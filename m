Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFCCD13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCFF88FEA;
	Mon, 28 Oct 2024 03:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6658904E; Mon, 28 Oct 2024 02:59:26 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03D8588FC7
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dneSqu4kjDYTQJrPNhVDJa5aTo3ZKmwd/6MLZWsw62L5cCWX+3K+YuLsy1tZ9yaT+/X0pe2W/z2fVi5tbyzeaoll5ceRoOEW4uLod/4H8MshayPkGU79Mwj0FaSsxGZ7JdlYDfiLxIdV0FBIap9hZn6V/7C5kJ5nMNwPSZjCPdM8VnalHaeL4AJxwpDkIo5rFFvt11n2uQw7ldVxpIkJjCfzVr2jLYr2d5y0yNcw0HQFBARDWETlQUI+n+xfdK/l4tDOhsPW9n1wELAc3i+m9sIatKBGFd7+6WqSYk6SJGH6ra9Oh03+5fc6OZjKcDmBtsysH07ots4f7/bxuHRwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwyfpC8mTdXKuZQPMIHmFlqu0h07/IaaLTmLu/2Yms4=;
 b=TjFXrd+w1YJKM6PBmkUrUkE28ceINMv35RXJJVHv/kWkiI/jIa1n8ziyyCM2N+IUDtzkEKHusL4UXUBqn85fDYNu+GwXSPfXGZOxFHCFU1ezhIHOoR2iIfn1fue3rZ/swWUp9ZthgHdMoyg3A0w0ElX+yej9QjlCQA9knSVS2+BfrITRwEebHJPg7bWEz0CpH5NQAgkG8iceifjj+n7N4eFKMDi7FdgGoEvO0N0Vhx4w4PQrCXsTA5iTUbaQGGxl/P2R+ZYpE3r8PH6vcWvuvKH2To3q8i09SMGdkcTbGtpRwVgWKmqJaeFMm1M+a+SeYdqVjBpEwosm1TqyLJAacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:17 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:17 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 12/14] riscv: dts: jh7110: Support multiple DTBs in a Fit
 image
Date: Mon, 28 Oct 2024 09:58:45 +0800
Message-ID: <20241028015847.42344-13-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
X-MS-Office365-Filtering-Correlation-Id: 447cc8eb-938e-4b65-8f8b-08dcf6f42188
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|41320700013|38350700014; 
X-Microsoft-Antispam-Message-Info: 8CD4PBHvOr4fP/8LtJvsm/+UVTp+e5aOci3pf65V9zKyA2H1A2Njil2I7Ue/hhlWn0oI9wGnI5zF41efm13vKabPDTierYAyDmWZMDaNkJIWsSo12ng6GoetcvDhxJiRMTGASuqXWKvMEaigX77+HakY/3dpsIDn1KFwucOmI1MedM/BfGthwACBZNXDxqUmESrrgdBmkVWfDQjzGtX/veiMOh3DAYwVDDW4vLszKiMtRIu2tmsWb9aPx6DMmQvQ6m8IRa7rqgUC7xmzZhsG3sjeOz4vRKz8a7SP64KhqWD74xQ3Da0oOVsZwGCXokpBknoQkr/dra80tzyGLaEoQjlfG01JuhoBjPrmiA8BtfY0fEhlqJJjvd0hXhKNwe8NeH3N4BX4knTr8586MPMAZVz/4oEGbrmUUSJ1+uKjeVuBS+cpND9iv4qsJLfNCg0EApRezxTLO6JX2JTcCK3Rp56fr1dMvRV+GHMzkIDTy3h92fZRQNqjUFh/gSWTrS7i+jv1PzRjgw3sRNrv1CC4CMvehY5gAoOmLSK5cHpBdhzAU9YPNc7jqAk6d0b1kkV1vZxXjBWU9eYjr5WfEGGJY3x4tmuWhGj6Fjyilg3BbF6zlj7OV3KqTWhspPzH/nn1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(41320700013)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XHkKkD/qNry42dhhVwMutb0VIaiu4a0i5rb6cljGmQhS6L8nHHWJXoHBrwRi?=
 =?us-ascii?Q?5wG//2m9tteZjC+Zu2rdlVnu8f7BSkuupsJGlT6sDnIdDbfoX2ttPev4ZleJ?=
 =?us-ascii?Q?85oe8tnXxbKO6EZlyZpSP0uFrcttlYDvZSX2cR5t1nA2kux7ORLH9Jm5gbGX?=
 =?us-ascii?Q?l+IY7Ad+R5q4cvbvg/i5AGlFx8aksIQs0Zr/asnp8U9vGOjovn8bWvpm4Obg?=
 =?us-ascii?Q?yrB0iG2t+8DBmk3uaUMzRWzoQv6x0lUZwI3x/JtegVY/LtfF3vJfidCHf/CF?=
 =?us-ascii?Q?ZfobjiXdTeYgQf4wZAyEIgcNta7T/lIW531qkc5D8s0zIKtEGBPj7kpSfXS0?=
 =?us-ascii?Q?4ke1QFkuqcDkY7BRB9IplKb8l0XDNb+Yrsphf7iHciTHlxPnczSEGXDpLOEE?=
 =?us-ascii?Q?+byKJ6vSa1jhlh5gHycVEr5uhbHn3p7ialpOlNs2GcNmypmPLPrb2EaQUSwW?=
 =?us-ascii?Q?svNrgiviWnyADe+Ljrmuh6+houPtvDTYlkK1iLiyV5bKcuI9/+Yy1YERsA+h?=
 =?us-ascii?Q?52+676UUAystLAuAYkDF2PDN+8+loMAzWlA+8/C8hXKWNPZdG5SXhYGhwA50?=
 =?us-ascii?Q?n1or5DcUnzcP4P9NHsNk6OX+RGy7X+ivKuxzgTqaAOZsnEhSktThyRqhaCV3?=
 =?us-ascii?Q?Hu+wANa3jjrQ0eIORNsTW0QJcGzp60gRzZ8tIYJPjX4PIbsQ4V5+n5gbW3DX?=
 =?us-ascii?Q?xmh4ccnhp4c2Xukm4bCKkP+J/VLWLAor7MvWl/l9ZCj09ciCLBizfBokY7TX?=
 =?us-ascii?Q?Zy5c4HGijbeVpQlyjWzAQ3vVClc8HiDG1GXDegJbGo/yo++oZz2I68RN7+0+?=
 =?us-ascii?Q?HpuvG0wn4g6kWHiKAZcKs40d7TPm6u0WYBNRZ2jw7ioSx+M9wPFbWbFpZ9YE?=
 =?us-ascii?Q?oxwHYajkKLu7SH7s3AzLtxs5Tlfpmzh+b0YFOU1ueMtBiZk50sgBC+hQoEDd?=
 =?us-ascii?Q?foe95tklliy86x/8sB/VmcBbahaTF5DMYMxIclUg3jeOZNes4Ng5cyTMfbfc?=
 =?us-ascii?Q?URzG665l7NaqzWSBb3K56rLbC53/oU4mkTt8CVipS8y9Co3z/RIgi2igE65/?=
 =?us-ascii?Q?m1u9M+1qF26rH0xCp68ufpeyUOKhft1qAfZTfP4aMgUUjR8M/2Py4J2rmkmp?=
 =?us-ascii?Q?RkwY6Z3PzK8sIkbcPzgflZMAznaQdF/wtE97d0so3wPOUkgGMJsUAkUoqyL8?=
 =?us-ascii?Q?OlIk2GYNdBScsOumNVamzYGDKhZMEgjpNDTWfbN438iMIiiRnhknUpSZFxUo?=
 =?us-ascii?Q?Cjeoa3M60PCo7WTSLhHqrj7hL/VIvwS0qiR2XAkT2HMN9d228x/MC8ch4Rob?=
 =?us-ascii?Q?j+cOWkP6GiLy7HM1mKm93a0cYRq2YSuCkTK16ezmCEgzvdz3MEBRAslmq600?=
 =?us-ascii?Q?Hk1tZkUHwe9E296jFHRYIBz/mBOhPDl+uAyBayidI8C4H9cXOrSSGdfyYJec?=
 =?us-ascii?Q?G5oFY9U7c3onXeW1nRARMblqbMPsws9k2aYDQjgWHKW4n1P65vuhvOUdzG6P?=
 =?us-ascii?Q?aEJe5QLCrDAYi2QFwodIwWT0osYX4YqWgJaquxvpGUCHQDIdskAVzhcKeoxN?=
 =?us-ascii?Q?3VLABAsMc/2Uyd7GvmMIvoyxB9+wbJFfJO53YiL+gUPdm2GgMmKwNNcvEB+s?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447cc8eb-938e-4b65-8f8b-08dcf6f42188
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:17.6178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWQvaZ/MBN2+yBp8z8hLQ6phQRNACGnMC6UIgHgtXBqBd7idws2VT/3yFdOjEyTGraviWxYR2tUEOQVVfkZRfzsmO9W/61Lr+U80xCtAw70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi | 60 ++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
index cfd3c04aec..995a4f667b 100644
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -119,20 +119,74 @@
 		fit {
 			images {
 				fdt-1 {
-					description = "NAME";
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
+				fdt-2 {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+					};
+				};
+
+				fdt-3 {
+					description = "jh7110-milkv-mars";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
+					};
+				};
+
+				fdt-4 {
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
 				conf-1 {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					firmware = "opensbi";
+					loadables = "uboot";
 					fdt = "fdt-1";
 				};
+
+				conf-2 {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-2";
+				};
+
+				conf-3 {
+					description = "jh7110-milkv-mars";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-3";
+				};
+
+				conf-4 {
+					description = "jh7110-pine64-star64";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-4";
+				};
 			};
 		};
 	};
-- 
2.43.2

