Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927B1E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31BE89650;
	Sun,  8 Dec 2024 14:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D2A89515; Sun,  8 Dec 2024 10:21:23 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D6689541
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlVZ0P6xC7+uci6QEiZ4PoPxuUKyZdAl66Xm2rjYkrmX5A03krVbRl61BGDkyxUwxlQ4NC+QRstJ7Fv9xRHBEwojwonPISEDoRVtcHegwazi9LTAcGSAcO3BiarI+PHM4RzzQcRzgW1qH68nwDCfslnpL50L0tyAFwcbBT4mVuZbi8jJGezSbdfvLrq46kj15pie3tVGQTwyLhrnHjcMVxEOUiohIuCXo7YVMD+zw8FDik7NeLod33eZi7exwpr3C3dImMPUHk8CPSWsbB0kr7ZA0XlO0BBteHIfIKHNzH7TaPNHYxkDQ6rxDEk8HoQS9texJOu/AOWUzFp2A4QuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiZRv1ymOMJxuLr+Y0O4LaQi8IZNMWMDSlgcUSXg9Xk=;
 b=ipOfrtrBe0mxcxHsMSt1AhCAVJpe/TzTvyjE4FRe3prcjeUGlRvjHU8XITxK8+4ZsD1db4yAhRARmzjlzKlNuqd9L1H+3Jc9/Iu6/howqLyr/+py8biXJfbsL2dPszxROmvTuZ3XQRCq8jNYIb8VBc6LSLEk1b7vIQfhQh1FZBZvMisvfhlaMM6YhXZVG7gmkwU0jFykatk8FtzEwwIJFq1WWUOLfEF4KfcR7iU3IeMC9+OxAIl+EYi7BDSPDlCt8p3kazphv1JU0onz8w86B6t7inVwmITO+41Edw3TBPaLQladwhofOXb47G0kt5S93ZCWU4k6t2n1CnWxIvVQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:44 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:44 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 09/12] riscv: dts: jh7110: Support multiple DTBs in a Fit
 image
Date: Sun,  8 Dec 2024 17:19:39 +0800
Message-ID: <20241208091942.47298-10-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd8e9b1-db3e-48d2-376c-08dd1769bb59
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: HmVbVfnSGu7HqmQ3egNGxFi+nyKaf3lOKl+1T++mBppTqcS/55s/RpCPrsj8YNZ+flHXaV0wIRAY4RVQ2NbiuugEoRb+FcLJuq1LgkIu6pgIDn3r9mlATSX3mgVspiwT+E/KUXfHmZ0i0aVD6hTM5IzQZiDqnKxeLwjdjFhA4d+BOtZSnH06+lfODYMX0NttN5LYK+5S61P6Q8ZO0rfS9binQUkcJmkteyx5B6xMGWdsjDeX7R0blXh761zwzCLHK44bCZwcLT0YySdLCoWotwkCBlawyInGTTSihLukuZf5KfpB5u7/dAs226UwNf4HMMcLEeIZ0ZVCuMKxlo0lJJ/M30iVrnFDCc6Gj5DGrqIv9qbyILZv1ZLqAjO80f3rtkOgQ5ZBnYXHhPiLSIcVUHDWt8G2MBLChEseqh8GW3MVAr4DhBCxvCiDRVfkY9djb/EAWvaSaCZUk8Psg+DsN069Ff/u/EvJjfz3eRVy4qDgJdoLvXVSzV+QAaCbWdCZbRNSERMnbVZM2M8TNlNjduIO3xOoMWG2KAhQIEIN8SKfp8ECo3+CN+2+lXTOY9PDf2MHTE2pmaw94tz/TjM4WOG2GwEk9/Y/zBKr8fhi5a2gB31SzJnJ3gs2wzLVPmxXbMsmjb+un1167TkbFu9EoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RD+jL14q0dZjQpAjccpwctW/x2c2GTDC0KTQD9Q2u/nyCl0ovEe5WSdeF5t5?=
 =?us-ascii?Q?y9n50/PZkI81n5vKnYu2t+ztIPe5rz8WHdYCABFkPQwoFqTSwIsMw3AlS8L9?=
 =?us-ascii?Q?CH140qRTPpcUA5T4tyG3GWysjV1ptPdDEoIi6CL05mzYftjileR/HxaJ/bTI?=
 =?us-ascii?Q?FmVho9mWb+0S6ffiDDbSzNZXopmTT9Vp6Be3Xmzhb3FWDsZUaK//L6HokV/N?=
 =?us-ascii?Q?w/VcF8R9t7L6YD413iLXrrUBXax9tFLi4S1Drn71tEwU1fb6ypZbmrvNx4yK?=
 =?us-ascii?Q?6dPXaN67JxFQNjMZi+jhfhBEQEpjavDkMa2jUZs2wwHW0hwI5YS3uzxANcvB?=
 =?us-ascii?Q?d0WPPEC4P3iSofrl0CfyMpZTsBeXqMYlAn4fnatmmW8FI8190sB9h0SdQKZn?=
 =?us-ascii?Q?eRNxsqy3we9TM/17wDAoT35ofb0EH4oBgeWGvoMzbeHP6LEIv65uTifPa9SW?=
 =?us-ascii?Q?AdiUXX8GuQh0QjPsgXfZ8pP0RnwFMNPaKLnQk0H1ninJeTCd8IIDsFY2rKDr?=
 =?us-ascii?Q?Oshc33TeqaBoKdkwRGVpVKNm/5KIvr8UnN3yqcRUDSgpfl4SU2OjPSkjs6tQ?=
 =?us-ascii?Q?74mHboJB5QHS8c0lAAjOwoVIddSlW13tQ1/UpwQ4lvJr9wIDe6i0ZDVXohdH?=
 =?us-ascii?Q?AyjzE+0g4NWhS8KG9hxb8aerONFDp5EJ4NeNJZq8FjhMIUQJl8I2RQKazktg?=
 =?us-ascii?Q?KeE0TdL3X2XsyX55NutkC1qbsAIuXxwJfYmZGu/gsLIszSA2lMtw0lSpGRZQ?=
 =?us-ascii?Q?tz82S3nTL8zYl9VoS1pkgdYHnIO3+2pmMbdvIfQ1EN13m0h0j1IkBkvi9IqY?=
 =?us-ascii?Q?twzyfGmdfndpjObkPt46yaVMmXPc5CiREHFXcSMgiL5lSmpt/OB98uWMop9F?=
 =?us-ascii?Q?yoHAJ3/SFvglLxrVjHltw4G6Wy6pXPqSgLTTPCDG+1m5hKn1UQNABcT5rqPL?=
 =?us-ascii?Q?93oFe2SSqTonoG7zVQQmby9UrFSrd9y4xtHNI8qKQz1kbVF1PC0zli//0V5j?=
 =?us-ascii?Q?Qj+8Q7o2zNXuPwm7AfCfJyV4cPOZ6O7mxV/TV1omn6UT8A3laXRlORhNH2Q/?=
 =?us-ascii?Q?Q686rbUepFkWCWMGDn2wZLjmGuGFr+jeoRfxcBpGTKrEBNLvSpHrk0LCZcgG?=
 =?us-ascii?Q?ZjfdnDb4TuVnrgyuBwKYhueYegtFJZZDz5kgoTv5pgB/PWH3rcXgnpLoqxh3?=
 =?us-ascii?Q?bg+lB+yS122t9ymzB9a7zUExXDP6gSapoFUMLjspLrHyqwQa266Ybn+2WzDk?=
 =?us-ascii?Q?xLe0jsfF2hRbm0pAbHgRPi2SWOHaVuaQuNkTA/Bgp2ynPpXj0ftFdn7K0UuA?=
 =?us-ascii?Q?07uE8M8WAOzj+eB3z/ZvCLxNZX684dsTjAbedYKlvts7Wx8TsEErw/GmQEZU?=
 =?us-ascii?Q?POHua/3oUnLENhnqsImu1KCpAruHmZ7l9J0rhlbGk7hncY2jwweik4HGI8P7?=
 =?us-ascii?Q?jVPLpkk3nV+eKvGhZ6IboeIGZB/SX5xnT8A9UyvcXHS0OR5BjUOUEt6J2qhz?=
 =?us-ascii?Q?o4uc+tl/BtIat+sreezX1/kNT6OHDTZL+EgqtysKhlWRnIoYKdMMgFukNted?=
 =?us-ascii?Q?LgpnlphmU29yc9drCIMsybwSYAGgw+3EHr1/5icHiwij0jIWF5ronVPlNNhM?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd8e9b1-db3e-48d2-376c-08dd1769bb59
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:44.0031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwHp4QYY4Ql9g2cQOtKYLlChKrAWX5xpdeb+zZKCv0oH0FHt1ghzxE5h9Jr6qQ6QstRFkvOoGIbDJjz6YFiWkJBhbiCwQV8ft6yj6Iq5Gbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi | 66 +++++++++++++++++++++---
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
index 45fada34d2..7871294e90 100644
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -109,20 +109,74 @@
 	itb {
 		fit {
 			images {
-				fdt-1 {
-					description = "NAME";
+				fdt-jh7110-milkv-mars {
+					description = "jh7110-milkv-mars";
 					load = <0x40400000>;
 					compression = "none";
 
-					uboot_fdt_blob: blob-ext {
-						filename = "u-boot.dtb";
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
+				fdt-jh7110-starfive-visionfive-2-v1.3b {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
 					};
 				};
 			};
 
 			configurations {
-				conf-1 {
-					fdt = "fdt-1";
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
+				};
+
+				conf-jh7110-starfive-visionfive-2-v1.2a {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
+				};
+
+				conf-jh7110-starfive-visionfive-2-v1.3b {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
 				};
 			};
 		};
-- 
2.43.2

