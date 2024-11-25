Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C1ED3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED00899EE;
	Mon, 25 Nov 2024 01:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6DB4895FF; Mon, 25 Nov 2024 01:33:42 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B62589550
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB98yDcFBO/92+GHLSaRrGAE3NdkF9CxYBAKpjn7hqaZXcrgdkyFUen9L1PSqgUwvEQAPwnPEY8cXeCJmhjleRs9uM9xU1aL3LUuHNimFyC6s/brxgbW4x8Ilxrxvvr39A3nMVPgScp+8E5PP/Ja8sBGvaG3CbRCKyHFIXxWl+3vpbNxdr7xWApvNAKssmAIkHnDI9VNvtRimIqSDjHibtTqBdkrXCPmbTf9ktEBJNwOQGQSkttWoqp43MdINLidzoWBpYU56ovk+UgWVn0yPkai9W8Qurva0avMFDpFf7C1Vjj5FVQDeO4BicW6aeZ1uHCYBRP+LIr1ATpY5JxV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQzkB0W1eooohoeYqzFUqxT/Co8DWsRto4YRkaOGr+o=;
 b=SesmdSRkWsfupiHnvLg+R2XxUMLmoXRgBIil0TZkXWoeduWjucjXV6oxmE+aR4uCgoTmsvpFd6WPVQAMdPC5MVFFxkLBv3LsCDYwew5VLvRZNA4owce8MwqeORyexxvccYJKMk2NCANxZ0J4KtqoAJ9UcG4Cot6rjaez+qx1UX6JlkDUhfTKZKSiSuY925EK5fixMPFlrGWOoYMjEBCKGrpWAMylbwnpCUMKJ6f3JCsduWHLUJjhwEUdPRgEumXq5cMcW2tGZmeG/zrMqMYTMDqPpLQc0dGkDrrjm12MD5B0w2RrLtQNtZMwQKdkcLLCagVCNXlrooloGH6UR9fqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:33:59 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:33:59 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 08/11] riscv: dts: jh7110: Support multiple DTBs in a Fit
 image
Date: Mon, 25 Nov 2024 08:32:02 +0800
Message-ID: <20241125003205.75327-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6a4586-f3f9-45ee-e273-08dd0ce8daa0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: SEl0hX9wxJUZ8xMcu3743bLdyko+LgOeh2V+rIWjCla19Nsr0iktzU6uf4hw1tD21lOVtjpnWhdNpT23zYnVGduxF6sjmKNX+mLVIwtngYv7wmNAt0vsBHbg7L/Dmi0gS5V8++PW8mWfNBUufjFApl+LwwqsQwWHo02u70nuJTHjh5W5xFXOlBTJ5hPLmYPSoSGK/9k5MnC8yfWDrUolAzCKa5ridrvjXAhTFZRWfAKyJa5r8q+R/aHlcPYAme8I/9D6H4+GgAXtxzmcAaeouf3vCJ6KGE5f9PiGo0H2RGVDck1J2q5T20Etezzb6KmTneZ5sxlL/5P+oQI89dBqM0ypCziNVleS17cvw4LClFLIHblXBUJgSQ0wpvxQuelpnuCQ8nSuCElXqsshbJ2ooyaAtBigXcf5hLGAjLrCuaw85zuGCeL14YXYt2nQyu1aaw3kM1NnQ0gb7TKvsqucSR98j1MkPxXvBwnyTLUzJ65g/JNLqz5YrNie0h3AfoWj01EdN9iOVKXnrBCm6s2bYdIwN+Sn4y5Ka+Vwl2bvxkZeujyNCbWcFD7iNuYFP4Rd8rd/DPdET5G5Tdanw8jkuo43T5Obpcs0HnBbQTC4qTK62WeIeW+PPTTnF8tc2LQS5M4knzg/onzThWF0Gn+mTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HBRiQ4pZWRszmb2U3vWqd1t4lTFcVkSigS+zgJCct5siXgMnMg02xJR1Vvzk?=
 =?us-ascii?Q?Mw3SrnjEEwT24AZLU4zEFnyHBh+L7J0dXQwRaq2EjycjJ+LLdg5TNzbjnIlf?=
 =?us-ascii?Q?0LtQgFfw+CAhxR1v92Gixmmo0e8XnryLZd7IvghW6KFO3jD4BMowOT3Ua+16?=
 =?us-ascii?Q?ic54R9kWsGLXsQrGERBxwWN28E405KIrX/KfJWMNIWw8ec/0nt5LoInbzv5L?=
 =?us-ascii?Q?mj/KagaAdZnhYmhBItpcJDswLrxsG5aW12+4dJiHmWpFHzKjTC6VYMsI0BCo?=
 =?us-ascii?Q?cNQcq90gnP4mRzlilSq7suFgWmk+6DuC/su1pCqkfVcbHs50HfP1keXyKlWz?=
 =?us-ascii?Q?fUlhbXq7nNftvyFns7Dh0EMb5lU8G7k3mPQrtMWekT+gnNcjIAS9MFi0jdea?=
 =?us-ascii?Q?DUlRpihb4fkuSIyiFWzb/kJLoerqtdIgGFdgBeCAI4JZL63eL3P4dsvc+83c?=
 =?us-ascii?Q?lLh7VIIVesz7fEMdEkA4ktdqZmXhWVdkzudjxj8QDn1dywq+f9pDPHVwQQch?=
 =?us-ascii?Q?HxH6B+yGAfG9bJsLa5G4ABY8oFQS8+41j84vWVv/oKW4w5rSHHji0P/HflHH?=
 =?us-ascii?Q?sapqQ/Zl+0Tg/oyp3TUxgGLambMT6VITMguUM3grhRZaslyuTCcF2p7DThS6?=
 =?us-ascii?Q?o/6yazWY6PsK5GDS8sXKLZ6sNXrijVIeysetdjorRVEcUqJRfKgKxg+Gk+aN?=
 =?us-ascii?Q?V5EWr+xN1ft8Ebsn3+P2fh7WQIQ7ZzxrTDs1vEGPnJl+TEdRsccVTFDxLtYU?=
 =?us-ascii?Q?MuqL08YJOUvvWURrsTl/pHScommUNUbD3RCCL0WmdY2HViuIt8Bmj3aXh/sR?=
 =?us-ascii?Q?RAabpOv2EHGmuANGXrZOSWXKspnSYMLCM4fa+IigMrGjpQvEWSFanevTnjJK?=
 =?us-ascii?Q?MMgWD6QZMUKiHLEunPXTmiVSZBTyueewOqTwjB3exCKltyeLf9Vg9PG4oDj+?=
 =?us-ascii?Q?XhCv5Bd1weFPHL+fXzFi0UbsuGgXD6GorHeUPzZbXX7JmUMcX5PjHkuTehig?=
 =?us-ascii?Q?/z2yj5skBkCVuxvz6WlhcyFeFxXqHkQ5iS1f5bZEF/cOmnaWIrvjV3PsQpq0?=
 =?us-ascii?Q?SVHtIakElUL/NU/MVzjfqqndmSLRqetTwZSL3GvZd508rV7mwPv65opFkbd/?=
 =?us-ascii?Q?evPE1FTr5t6PmYmfKFS7epInouweWvk+liTsntaqPX3f4iUuSLNp89nemi+N?=
 =?us-ascii?Q?qjMpoWru2ckGiE288s7YhW7EVjaVNtP9E4+JwZ9MdF/LsysY9dhDNMnKHYbw?=
 =?us-ascii?Q?FlL6g/jxc0MIi1G4hrI3C45zUZWdTIwW/n8OZx6e/1J0hfPIpMiegNrjjoxj?=
 =?us-ascii?Q?NpU0J5lGVsSM4/WNXgGKazuMXTQMzsVII1JTsts/6lZECg84Uk7Fzj4idtVG?=
 =?us-ascii?Q?arNcrXFyAe69Szc+phR8HP3iSDCj2VhuYjQ7RtzaPHP+XSj8tPK1Secm3CH/?=
 =?us-ascii?Q?thjPRj+qMU6QZcM9nz/BP3Y0KH/JBYLegFyMVLnwPm6TpKGM2i1vxQb5rjWl?=
 =?us-ascii?Q?077YPot4kDs6VDLPCF/Jor9fiEak3RCbuDx575k3teQtItzSbFB1oecj32A+?=
 =?us-ascii?Q?3farQNgR/5B7hIm2iXXkY4/vXv2/Hx5defRUda61LT+XlQTchYpewDGo3PsE?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6a4586-f3f9-45ee-e273-08dd0ce8daa0
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:33:59.7559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugynRP16rnqzL610jKxLdjxt2d5pEUMunPTt6HDzHYnOvZM5cLlxGMPR9jn4neuXD+lV2eHFJj2zU663dfltG8K4ozxuPLTgL2NMYrY0vwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Support multiple DTBs for JH7110 based boards, so they can
select the correct DT at runtime.

Tested-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi | 66 +++++++++++++++++++++---
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
index c44553455e..64b4d04884 100644
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -112,20 +112,74 @@
 	itb {
 		fit {
 			images {
-				fdt-1 {
-					description = "NAME";
+				fdt-jh7110-starfive-visionfive-2-v1.3b {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
 					load = <0x40400000>;
 					compression = "none";
 
-					uboot_fdt_blob: blob-ext {
-						filename = "u-boot.dtb";
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
+					};
+				};
+
+				fdt-jh7110-starfive-visionfive-2-v1.2a {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+					};
+				};
+
+				fdt-jh7110-milkv-mars {
+					description = "jh7110-milkv-mars";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
+					};
+				};
+
+				fdt-jh7110-pine64-star64 {
+					description = "jh7110-pine64-star64";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
 					};
 				};
 			};
 
 			configurations {
-				conf-1 {
-					fdt = "fdt-1";
+				conf-jh7110-starfive-visionfive-2-v1.3b {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
+				};
+
+				conf-jh7110-starfive-visionfive-2-v1.2a {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
+				};
+
+				conf-jh7110-milkv-mars {
+					description = "jh7110-milkv-mars";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-milkv-mars";
+				};
+
+				conf-jh7110-pine64-star64 {
+					description = "jh7110-pine64-star64";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-pine64-star64";
 				};
 			};
 		};
-- 
2.43.2

