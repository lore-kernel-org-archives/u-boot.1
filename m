Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090ADD1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3D889152;
	Tue,  5 Nov 2024 04:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D52288FA5; Tue,  5 Nov 2024 04:45:07 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4E888FDE
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxdfwG2ufjbhjgxRjs5ZcKY2XaRhyHIkJzcnVPyxehwnb7UUEanHsmlY/p+RNxPwgRC+2N1rZh+DVPYkOoLkjDBfRaXjVSWmx97hbacaBmxEppQ4j69hhS+xSoHa3/uVrppwEVeCc67dIU6X0ycxcgITpvdm1CaikP5LzmWx+OYa+9G2LBpRGNXcmQEOEk1MumbppDfafzOccNF3OxDp9qeePyRlI2hq0Dvp9gG00dpf703KLLnka0KkfiytYQQFRE4pKPfgDAoHC2krckNuSPw+Hb62Wk0jeZ+PgOkBb8yAv+J2g2bXzG1s0jlU7CMcdgHvPHKcOgiFZ6W/BKOlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwyfpC8mTdXKuZQPMIHmFlqu0h07/IaaLTmLu/2Yms4=;
 b=anWn8IjIt/NcE0ghUMYgrRqX8RgH7lwTy4K+x32GKP012X4V9g1CHkzxPGcS0Wlqm8ia1aMYrvjMA386kIK1OX8yCTDHpg/mbz206iYg/0vm1VCf+j7eaO2rEJ9/UuoW9ZC7L/lRHO8m7619d+dEBOV42rnv50QUKO1+XlkNyc1WQaa4jkHTJoKoisxqolV5OqSmwocmeaTI2dGPS0SHMNrHnxZT0x7IUDkquxPw71ISgt8oPJAIAXuP4k/dHawjMkMthzO5uvNIf5XEsbIUSDBVCtizWlMcD/i8GcLL4lPk16eWMgwtASKkFnZkK7/ykZvRI6/GEDsw7m2U8XEetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:14 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:14 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 11/13] riscv: dts: jh7110: Support multiple DTBs in a Fit
 image
Date: Tue,  5 Nov 2024 11:43:26 +0800
Message-ID: <20241105034328.56439-12-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b088ca-d497-4917-3d5a-08dcfd4c4218
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 8Q80+KQV/NidFAxo3g0Qr9GMW6+ntC2224hfFkEGqm4VIpuVKE9iqPIKQeRhD5uMq39+VHT1ia+eSPdv+e9WfFpdRZC3RJpFx0XLp+SQa5mcHzaYoM3D6D6jtxkbnfLh6AT4i0LgkYA3z9StF5W3BqPTEB0qf6tlx6nPy57z8mwfbkiXDbf198//+shG6YD99TNIdFlrw7sA8DmyG14lbqJ/8ak9kUB8D84ru9xxV+QIPrAGb0yAARtkEhkkv0+rqwhGJe6C2pg1nphEafclb1zwp+W4b2iHwDA5QMiencOJTyUOFSHLy+cvwX0RSDRtAlyn1x1NeVuRmh2F2NkDjesSfF0C7Jv/rVF3iQJuKgVt6nTkfhVPJbT9NG0OoTH1QKhYSU+vMIwsO87E9A+ftfij2FmytePTN81yibGl395tExPAeOJnwOZKOUxZwCCr2PxA3ceOArbdeyhrQ0xpixyMFrWTXWy5Q8OFYI9i2+zimcZ/DHcvSuTZyIl1clOaJKCTxQu/Y2nGpN8w8n6O5W6TbhSdzjm3QEPDMmlFz795rh5UYiP6tEU73/x8Uj2fFpNiYhGYdePluf9Tx+H47jg14iRQeeklT5hTQfjyqA8ZRwKqLbCAxejIo2zLuYmKsNmFfiXOlBDD8V+s0qXKLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N9OJAf9xAvWRb0S7vhteRBIWgKzszkdOMjnLIgh2Tb0QqiSzfzsanixAmf9G?=
 =?us-ascii?Q?iYq0hV0A8PQB8KkMdyY7LzvMwx2TDeA4SSOiSkDiLvSvglt2erPcuElcQqVL?=
 =?us-ascii?Q?eVeFwLbedVY3FPsBnVaSjlYInyjot4xDz79f5Tx+YqM3bha3EKuaomdt33UP?=
 =?us-ascii?Q?VXKHMAZsk0ko0VeOGzeOE/qzjQePuZzUgFWa4m2n6+KeRke31tn8N3gUiGmI?=
 =?us-ascii?Q?esvMH2PHR2p6+Fh6ZBjILe+8wkOGsHW9lu0vPhEZG+4BoS/9/ckdVB31djzr?=
 =?us-ascii?Q?Fb7i2IFkZEZ2TU0agOVQTKt/MiwUIGCHQElETmkBhaHEX/jPGxkQVyNReMyG?=
 =?us-ascii?Q?N0JSBCgG3k8AirsyX8ptWylHBKaIV5Miv0yDr9fNwoH75fD5hDCjuWiW/5FK?=
 =?us-ascii?Q?6CKpuio1ItpAdIzWqQ/tbmy3eJI7v3O8q44Cn2UUmPswLNyiwDqJuST68kAS?=
 =?us-ascii?Q?TZM1Ngc5E0wVoO6fV2sXGtOQwzs6waCRzddwFDHaXMPAOtnIyRdooym5c+RE?=
 =?us-ascii?Q?NJYTLDb3u0PHgGwTz+rtdWKl3ycc1t/L8UgpcRI/8TQrRNsTnK5l4Q7mqN5x?=
 =?us-ascii?Q?nPR8Jg8mZMAab/nOSQfPBXMbDVnJu/lFLjSoY2cVGx2GO+R4gbOqRGRKiS4V?=
 =?us-ascii?Q?aRwbubzj90lomb1gqr100kLxzqptggcO3LADsTasR6sn2D73gecZ/SZh1VuO?=
 =?us-ascii?Q?wIp3pdw8+sjUS0KdUj+oen0yDtnpya4JjaVctZHhjNstrJ25BnyvdqckEW09?=
 =?us-ascii?Q?dixA9AHIJ/2eaTfrpTJsp6sZh3Z9Y6u3ZiMfpHAalob7wJ92yHrPju/Nmand?=
 =?us-ascii?Q?eAD2vP0ySl+8nCRsF2L0df8v1wSGi7iQZpGWjgoMdTc3qYynm9lQGTc7M25g?=
 =?us-ascii?Q?dk1FTeUn7DW6LJlqsnEy2o+ulQbfIaldhHyCCc4w8r57NyXODDlOLKwKgCQ/?=
 =?us-ascii?Q?JMaBZZ2CBmX5BNeiulhdD6HkwyojZp61Vx75RIfLdP20N6YGQkQmyS9EwXOk?=
 =?us-ascii?Q?QvY9DLaKVOYdbWV8jmjZpnMB40BhqO3xl7xuJd702xrwe0e3cW3xnaeF8poY?=
 =?us-ascii?Q?H6B1+VHUjAaS1Pwm66GALSjXkcUoorMfSEhcQxdW650S7hFGg1YzxtzROT22?=
 =?us-ascii?Q?IMJDtegmfL8fJIYpC81ORaj+JGHtBH8bNDdadED8u6uWb+f2Z8cFXXRhcThf?=
 =?us-ascii?Q?JPMUI4jvNAp1BbH4T9OZRtRFVhKFyhnjfzxvFXChwfqxRYyprMeUfyDUrz2M?=
 =?us-ascii?Q?DGpM5kpiGEF1wXysuUuNwgUsTJ51nTbeWDasetj0Qqd3PSZJY7G6o8KBQVlc?=
 =?us-ascii?Q?jUhfJde/cGAWlPxeXmZ5Fc/z8W9vlJ10YW9c/XbRr6Rh4994x19ifYxIjOYh?=
 =?us-ascii?Q?LJhx8UZpJjOTWCsbtVcsNACoJ8wWtHrN9JKpiwU1G/WCziRyXlNFjblZIoS7?=
 =?us-ascii?Q?QKdgpgk8+e0sYBmFHkR7o9d7G2jeIsK407oORp5tk7zyXurtzlPjVy0PEIM1?=
 =?us-ascii?Q?YmjZZfWIjmm5ciuYDWxh1ZbFU2COURdQ+VU/mkWj8CYTYJugyAh61PezGSK6?=
 =?us-ascii?Q?Pj00kEd6kjEJzAIQQiuO6dJx5YOLbA9bAWC9byu/cGRn83ndfXl7H4TWJiWI?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b088ca-d497-4917-3d5a-08dcfd4c4218
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:14.8770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SRkRVyvvcNp2V3MMpbx8Vo46LNmWI4zk6UpdoFsU24PiVJbPssif8L2pYhK834F4SME2SyECpxD/THzYmK+JHilHkLStMBanZABkoSKXxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

