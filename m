Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BADE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 12:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C817A806B7;
	Fri, 10 Jan 2025 13:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JqwiL7xV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A97A80608; Fri, 10 Jan 2025 13:35:59 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A34805F0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5GJSVPppK4gyUPBTSE6mksobN3oYD2PuHp77IlbIU7Tm3/UKeYK5e17kKIVL3YDLfUjsF198G1WovWlo0YYsClWw0KUGe1jr0gT6BHGcG1//GGfBwpHQlWONkYcECGdf39MZsZefm4jINVSOoklZO3OKZG1lS4A2wb1ITRke3NfCJ7ddP2Kvx3BEWl5ijQYZJTbWQMyj4e+1I3UQa+sCuaPDHUzQf0s+s9uQ349ytU8aNNlfEI4ENAZDn1OTbGPYqEf+lwihHut9ZznQ9/aAoHjoDHflaKlQc5dT7N0pkCBROFfz1rNNEMNLHf+4SUd/PfDNqFTIWRnyUdDLdZNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RL3hroVGLc47ZaHok6xTok0k71smyCa1+Z12wm8wFk=;
 b=vavblRbhrAwQrTapYfp4Yot6qPXg6pBlg4rbFeEkEKBid/lt9BcpUIQzCW2tdv51rm4IqMc6vktslQ7hOkGbPpms5kZmD/R7OYTBYI6arN52jLom9nCOZ2CJA6OjxeIkecvHhUJFR8JjcHZ6EwApKyuFB4mcITr35iaH/wRUlZfBt193iVJ9HARwmY4GDvD72CyFuwc/F0xduIfamkkD/yM5APM9EJYd1hW6gbIltsCpcU52KlU6epPtrGQDSESQ9lZn2CpZYJrtbU8G+polX/qPFebAsCrAm4Pz2n06RHDMTqCtEzqJ5rI6Fo22lvsQcyO16pYwjwwPgOuSCya+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gateworks.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RL3hroVGLc47ZaHok6xTok0k71smyCa1+Z12wm8wFk=;
 b=JqwiL7xVPvCAwr7pfskDtiGVzg95KJrrqCwBZ1Qv0QES3HoI6uvhIwfx+liNjtizSs21AI+m8He4qKnZNFW4GqV9voLY6xyC09Z/otFSaFYD6iA+mmDchb5gcuxEd5YyFAlvSy99AijE9KnKpo0cfSq+RnYzCCvIyx1V8l86VhFECDwuAymwKaZM+9eo2/OjBmPAmf/s2ZxIfyqAUvoPGXrAipbv4HWGcEt2BaUKjXUOuO4GopXyMhPzxOS2Ct0LgzN9FMI5QD64hGoiHbAIDdgTMyl1y607ETeNjAmMYKuq8Kah/S9c61v/N3M7Wd9qnQ7vAq4fjHfXZjqFpkmFrQ==
Received: from PA7P264CA0141.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::19)
 by PA2P195MB2522.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 12:35:52 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:102:377:cafe::41) by PA7P264CA0141.outlook.office365.com
 (2603:10a6:102:377::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 12:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 12:35:52 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
Received: from lws-moog.phytec.de (172.25.32.31) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 10 Jan 2025 13:35:33 +0100
Subject: [PATCH v3 1/6] arm: imx8m: add OP-TEE node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250110-phytec_imx8m_optee-v3-1-6c39dab15592@phytec.de>
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
In-Reply-To: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.31]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|PA2P195MB2522:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5ea000-e8dd-4ea9-c718-08dd317351db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzNkSkI2aERzRVU4TTh4RVlnSWR6TUhIQ3RYUFFaalgwajBIUVVaQUxZNkxT?=
 =?utf-8?B?WDRKWVkwWWFmRnYvS0JXT0Z1UUVnU2lhZkI5R1ZiUnZ5OEIyWmlMRWVUaXll?=
 =?utf-8?B?THdjbGh1OUlGb2RiZHhsVStmTUZoaGRsTitMWDRScjg4QXVlcy9nMzdLZlZU?=
 =?utf-8?B?MzVnU3ZzN3dFQ1ZmOE9iZ2ZXNnd0blpPVUlFVmFZZHdpR3NoNkFqVG9hMlRi?=
 =?utf-8?B?bnN3dDdoZXExbFE1VmdwS3pkbGRrZmx2UkdCT09oZUVmLzVFaWRmUUtHdXRv?=
 =?utf-8?B?anhhbFMzOS9TdWxkUWtXdlZJV25pNDVRT3ZtbEl0MmJPcW9pdXFMUGNnOW01?=
 =?utf-8?B?U1BNWnhUaS9RVWZ5NEozNnJ3dXl5TFdTcWN1cnlOWGRmWnlPNzIzRVNyZHVL?=
 =?utf-8?B?ZlIvLzB4bWduYmlCL1NEa3BwaVNxTWdSVUYyM0JhdEhMZGxqckZmZS9vdXlY?=
 =?utf-8?B?S3dyVGxNTU8wWUlaZmhGM2dwcDQ2VGVKdjFqRkVBQ3hZRklzRFhRSnVzSVVP?=
 =?utf-8?B?a1E0Rk5aalhxSDZ2Tk5KVk12Q0ZkbTNUVFB2dG05N0RQU3oyWXVNUElhVmpv?=
 =?utf-8?B?bzMzL3hnME9ITFZNRzU5QWUzQkNPekp3WXM3OW0wVEdiUmFXaUNBQnZjUDdB?=
 =?utf-8?B?TlowSFN2aXlnb0Q2anYxTW03VUo3ajRQam9DUi9VWEFuWFY3ZnRIUElGdGJP?=
 =?utf-8?B?NXlqakFhdURtR3FEdzFsaWhKcXUxRDJpME43bm54MTF4Y0QxbFl4MEVpSUVo?=
 =?utf-8?B?TmFlS0ZveFlTdDFQd1NneUxNVlUwbDhOU2FBaWRyaTJZK3pSWFdUM2pMUHlh?=
 =?utf-8?B?a2FCVWllMWwyNTVSYnA4Qk5HS3Q2alE3aGlHZXRUSFNtaXNVY0YzcVdxRElk?=
 =?utf-8?B?SHlKM1Z6bndIeXNzbUJFVkpCVVlWQUx4RUhQOVc2czlLMzJuTXlOMExsTHlu?=
 =?utf-8?B?dklpQ2hwSUJTd0dIY3c1ZXN4dXMzcXo3b2NFQnA4RWF6UHUyekhaTGg4S0xV?=
 =?utf-8?B?dStoSklweWFUS09GbnZwRnMzeHNoek1WenhkODZlVHVUOG9kZDh6MlRqdm5x?=
 =?utf-8?B?MHc4Rm95STBCbU96WmNHQmI0ekJoWDZmYWd1YnpWSWRvWk1BWDg2dEkvdVJk?=
 =?utf-8?B?blNWWUlGTlFrR3lrNURUaWttYk1Va3QxOXY2L0dRcHV6STFKOHRtZ1FNSktG?=
 =?utf-8?B?WWVaK0ZjRGxBUDZ5bG1iTGphc2gycTZsMUZXL2txT080NDNPUHduelp1a3p5?=
 =?utf-8?B?SzM4bFVrSGZKSlZnYnFDK1VmcVFhSGJaY0VONG5xM0Q4cTVDcm1paFhjcEl0?=
 =?utf-8?B?ZEtJT2xmV3pyaUV0UjRQcy9kVXdVTUE1NTZWZ0VxZEc5cjNVK3BsTUR1eXo3?=
 =?utf-8?B?NE5zalJqRWpEcks1SDRuM3gybGJTODRaWkpmNG43ZW1tNFI2d2diSmp4T3N0?=
 =?utf-8?B?bHBJQStleGF6NSswY3NocHBEVDhBV0FoTU1nS2lhcnhwQnczKzRmWVFIdlMw?=
 =?utf-8?B?NHc4MXpYNHdXN0tsRWlVOTRUdzY5c2hYandTbnNjMFNCajVUOVJDaDhiczh4?=
 =?utf-8?B?Z0ErejdxZmRuaTdGQncwMWhNZ3BSNWRRcXZZUVJVdUR2ODc3MTFxQlZMZ0li?=
 =?utf-8?B?WnNsNzFsYU1nQnNyWUZwNUVUSnk3RDNSRmtlc3BVdEJGVjVCVXlzRkQrcEZa?=
 =?utf-8?B?eGVUeGRnVW5EN29QZGhZVENsVnhMYkV1L0g0TGJwd0hZaGdTNW5FZUNWSUF4?=
 =?utf-8?B?K2JHTFBlaTZLTkthc2tvYUNRWlBVWGFiL2g3NlFwMndiMzJRUnVIeFo2Vit0?=
 =?utf-8?B?RTdGcVEvWlpRUzB2ZGFRT1NrQ0dZZ0xzeE1ZZ05Nc2ZYNjRDSFdZdDg2VFFw?=
 =?utf-8?B?WTVhc2YxUzVYMzZjSkxNcHhuWlFyM3pqeitlaDVFazJNOG5KTDBOOFJBeDYx?=
 =?utf-8?Q?A4ndgssH9Eo=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 12:35:52.0523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5ea000-e8dd-4ea9-c718-08dd317351db
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P195MB2522
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

Add tee node in SoC u-boot device trees. Use a kconfig entry to specify
load and entry addresses for the op-tee image in the respective
defconfig.
Default IMX8M_OPTEE_LOAD_ADDR is supplied. To keep it simple, the same
addresses are used for each SoC as are defined in upstream tf-a
(BL32_BASE) [1].

[1] https://github.com/ARM-software/arm-trusted-firmware/tree/master/plat/imx/imx8m

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 17 ++++++++++++++++-
 arch/arm/dts/imx8mn-u-boot.dtsi | 17 ++++++++++++++++-
 arch/arm/dts/imx8mp-u-boot.dtsi | 17 ++++++++++++++++-
 arch/arm/dts/imx8mq-u-boot.dtsi | 17 ++++++++++++++++-
 arch/arm/mach-imx/imx8m/Kconfig | 11 +++++++++++
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index d31bc822532..ecc2319279e 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -164,6 +164,21 @@
 					};
 #endif
 
+					tee: tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+						load = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+						entry = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+
+						tee-os {
+							filename = "tee.bin";
+							optional;
+						};
+					};
+
 					binman_fip: fip {
 						arch = "arm64";
 						compression = "none";
@@ -192,7 +207,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf";
+						loadables = "atf", "tee";
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 6d80d856365..4a4498b36b0 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -240,6 +240,21 @@
 					};
 #endif
 
+					tee: tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+						load = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+						entry = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+
+						tee-os {
+							filename = "tee.bin";
+							optional;
+						};
+					};
+
 					binman_fip: fip {
 						arch = "arm64";
 						compression = "none";
@@ -268,7 +283,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf";
+						loadables = "atf", "tee";
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 56749ccacd2..9ede98a11e4 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -185,6 +185,21 @@
 					};
 #endif
 
+					tee: tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+						load = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+						entry = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+
+						tee-os {
+							filename = "tee.bin";
+							optional;
+						};
+					};
+
 					@fdt-SEQ {
 						description = "NAME";
 						type = "flat_dt";
@@ -204,7 +219,7 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf";
+						loadables = "atf", "tee";
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index d7a83a78f4d..93e2ef27f7c 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -144,6 +144,21 @@
 					};
 #endif
 
+					tee: tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+						load = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+						entry = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+
+						tee-os {
+							filename = "tee.bin";
+							optional;
+						};
+					};
+
 					fdt {
 						compression = "none";
 						description = "NAME";
@@ -164,7 +179,7 @@
 						fdt = "fdt";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf";
+						loadables = "atf", "tee";
 #endif
 					};
 				};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index b254a50b091..8aeb1ea75f7 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -37,6 +37,17 @@ config SYS_HAS_ARMV8_SECURE_BASE
 	  If enabled, please also define the value for ARMV8_SECURE_BASE,
 	  for i.MX8M, it could be some address in OCRAM.
 
+config IMX8M_OPTEE_LOAD_ADDR
+	hex "Load address of OPTEE image"
+	default 0xbe000000 if IMX8MM
+	default 0xbe000000 if IMX8MN
+	default 0x56000000 if IMX8MP
+	default 0xfe000000 if IMX8MQ
+	help
+	  The load and entry address for the OPTEE image. This value defaults to
+	  the one defined in tf-a if not provided in the board defconfig file.
+
+
 choice
 	prompt "NXP i.MX8M board select"
 	optional

-- 
2.43.0

