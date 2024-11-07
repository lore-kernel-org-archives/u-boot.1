Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF146D5AE72
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 08:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ACD3891F5;
	Thu,  7 Nov 2024 09:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="SWFRJwd9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BDE89220; Thu,  7 Nov 2024 09:24:08 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49874891B0
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 09:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d734PQBP/b3xkWk6eMY+P6ir9OrwgPPzE8ZHq0emhAsjkdc9XVvLHuktOQFYYJDcqhE8WmPTymVMoZOb+xNmSbLi2zIjqc/vqO90O1ToKxuj7jua96Ra27Aguz3J6CD48pA21qb1kMd79LAgc+brooZFwgBOPLRbWYyBySvJSx0E/Ru9VIsUZTHghMWgBS2zOYTg83hg7Fspf+fzaBDYF3svBOzH3zonNLp6mj+9AuQRJZTWVxtAxoMczXw6lvXeOYdPZDUTW3NHkMU1ZD8VPgb/3GLmrwTtC5zSVC91YKiKEpwa/Aw+gEyRaGv97ehBjLXeVhugAAO6MIlEs7DzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6qzfmfXHu3t9tPAA81VW2ft3Xia6aQ15vjecL5c510=;
 b=nxV7ADa11KOrtUnole8/KCIMyJxkuaLJcOPfB+P79Xq5ypljRg1f0tBpIaBL1ECLexrLJcfDVT4WU3io20OUGrFPd+ro2c53rgSPCmtHv47QDoYr0Jwou8okMrPkiQTRaJnxTnP52Gi40q3+GE2RWJmr2R4XU0r9gcFUD15O3ov5p6TMwFSQ9NXpDK1adRMYeTBopg33xnYOLdmxeCLmp3ZO7QvV/iTrWXOp0RdrtrmD+uIPvJsV3qA8RZhW6WUDv3CAysxwQd3+wBjioaXkGTcWw2gsTCBON2E+mRViELeTfxg7uxCU87zAWDiUwkc+I+LFC54DSGyi0jZEDtC7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6qzfmfXHu3t9tPAA81VW2ft3Xia6aQ15vjecL5c510=;
 b=SWFRJwd93z+LTu4VlGhkALn4aym0iw0L8jEZyFxoAZ/UTRteDG+pbWYnxhDnuxtzrbvfiQBlb7tzdlMF3rdDZ2uzWcbl6q26XRv8aFkFv02scny0nHKEvm6aj26oEPjSCeZGt0bTcUnAm2LiTrxc/ecBYH5CMmOeZvdjOUo0Wa8=
Received: from DU7P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::34)
 by PAXP195MB1248.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 08:24:04 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::ea) by DU7P250CA0030.outlook.office365.com
 (2603:10a6:10:54f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 08:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:24:04 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:01 +0100
Received: from lws-moog.phytec.de (172.25.32.77) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:00 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 7 Nov 2024 09:23:28 +0100
Subject: [PATCH v2 1/6] arm: imx8m: add OP-TEE node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-phytec_imx8m_optee-v2-1-bbc3747a60e8@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.77]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|PAXP195MB1248:EE_
X-MS-Office365-Filtering-Correlation-Id: fa384ca3-e719-4ef2-26c8-08dcff058a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2s5VU1aRDRoTFlWcEZzS3J4ZjNaOXh0cUNmMW1WZFZZWEJQcU1HdkFtamR0?=
 =?utf-8?B?UTlKcnNzbnluWG84eDVQTjl6QmRlQ2UzekMyMDc0dlEvMGRpWS9HU2gxZm4v?=
 =?utf-8?B?aWU3NFZlTHV2TDBiNUFHZ3p6WVhmWEJ6YVRjeWsyWGxiVkRBeEY3SUd1T2F5?=
 =?utf-8?B?OE5Pb1B4Z0RiaHlveGVNT05mRGRsYnhQeVR2RVBYS2REaERLS3E4eXp0Q3Va?=
 =?utf-8?B?NGxSajhTcmp2MVZXUFl2MDJTakxxRUZ6ZnlQeDh2aVVGN1pva1oxL1VaWDAv?=
 =?utf-8?B?TktYVko4TDVDNTQ3TkVtUFFEUUFPang3SU1QVWlPVWwxT0ZFWHZ6VzVZNXhT?=
 =?utf-8?B?eWZUMXBCZzhjaDhXWG5EVkthZ3JhUGZQTVhWR3dzNFIyc3BzaHNnVEl0L0xR?=
 =?utf-8?B?b2hCc1JMcEVlVWx5azU3VnNYMmNKdDU2VllScmMramV0YXhxRXRzQUZNOEF3?=
 =?utf-8?B?VEV1MUdRa1dPZDltYXM5UlUxRG5mdCs5dXNCVGo0U1BNanRnZnpQam1PSWQ1?=
 =?utf-8?B?NkhZQXpvMDZubXpTWEtnaTVkcEx5cHRGdmNkZnZ1ZjVjVjQxcFV3L21zQ0Nj?=
 =?utf-8?B?UGVUZnpMSm5yNlphYVRITmt4L1NxbnA2ZzkvQ2lxL1AwcnM2YUljdGdTT2pW?=
 =?utf-8?B?WWVNL09iME15Y3NDZWlLSkx1aThLR3BSS1ZVOXZGb1JmVFh1NFlnTlBJMEhl?=
 =?utf-8?B?VVdlT1Ard0dYbUgyeXpIR2krYmFwNWpoQjI0UnhjQ3NGM0dxYmd6V0J3R3Jn?=
 =?utf-8?B?WDRBQldacG1TOWhzS1QxUTZNaktDMmVBZ3REcHVZbEJjTHRSN1ZWR0NiTnBj?=
 =?utf-8?B?NmEyZmgwK3dTQzZpdW4rZCtXNFYxVDBwWStmQWh4eVhudUc5c0ltbmpKWGZP?=
 =?utf-8?B?dGMvelpDL2Fza2hKdXhsRFpGSWkxUjk0OFBXUXIydnFHeTJYMDhrVVR6YUZi?=
 =?utf-8?B?NHpQTlJ6OXozU0U1T3QwRzB3YjFFbDZ4NTNRU1J5cWoyYW9WQWhtd2k1M2dm?=
 =?utf-8?B?aHB3dmgwTFA2SkcxWGY2ZUVOY25sSk9mRXp0TlNKd1VZTGp4N1k3c1YvM1VS?=
 =?utf-8?B?dlUzNURJSmVZT3dyYldiNWgxaC9QOHFORG5lYk9xcWV6WHlSN0x1S2NqMlY4?=
 =?utf-8?B?WWh0QyttUStVajRNVTVuQ2ZwRUR0L0lyRkIvcEJSdmFKbXJaTHhvM21zWm9Y?=
 =?utf-8?B?b2xGd2VLdlE0dXRMbVJHektmZC9iRkp4QVVtQ2Vjd0RiajJnT0I0M2J6RmFk?=
 =?utf-8?B?N2F0Z2N3VC9mSW5XajdHekFKanp3Szg1NVgxdktwQnUwYzdLaTJ3Wm9WTGRK?=
 =?utf-8?B?SkxTMTFlc1lrS29lZ3lxUjBUa3FDWTNnRUV0Ylo1VFMrQWlhZnVkenhWaURW?=
 =?utf-8?B?a3ZxNXNZdUhXRU4zVnhvVHBqMUM0QWpTVzNmcDl4NFcwM3UyUGZaY0ZuYjBz?=
 =?utf-8?B?eVFycVJVRDdoT3VDdkpNME5NTWdhbjNUZFVDTnkxTHhOczdySkJ3a0dIUkFX?=
 =?utf-8?B?MUoxdTNPTmJWRm1QbVEwd25RWU9kL0t3UmFFQ0xyQW9nckswdkZSU3dpeVVt?=
 =?utf-8?B?SWpjZFBLS29oWFM0bHgrY2tXcnJLUzRTOFJ3TlhjbWNpWXlVZ2Z2Z3pvUUt0?=
 =?utf-8?B?YnI4SVlOaC9QV0ZxSkxSc0piaDZQNlZ6cCtwd2MzMUxPZmxzMnVwSkRLZ24r?=
 =?utf-8?B?Rlhxdk52aEh1cTZWaEJJdnp5eWllcklCOFZzL2laNENBRjU5UVl6bXNzelJY?=
 =?utf-8?B?MVFwN3BnZWNnM0R0K0orQjlXZW5HbFRnbW1CUVQ1SlZKTmorUy9rRk9GUGkw?=
 =?utf-8?B?T3FuMDN0anJ2aWQ0V2xzMnpBZVFOWlBqa3RqSml2OHRXdVA5REhkeU43NjBQ?=
 =?utf-8?B?QlZVb2NCMWc5VE9GYVVUMjBKdXcySU1VeU5vbHNxQXBVc3c9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:24:04.0422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa384ca3-e719-4ef2-26c8-08dcff058a5d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1248
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

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 17 ++++++++++++++++-
 arch/arm/dts/imx8mn-u-boot.dtsi | 17 ++++++++++++++++-
 arch/arm/dts/imx8mp-u-boot.dtsi | 17 ++++++++++++++++-
 arch/arm/mach-imx/imx8m/Kconfig |  8 ++++++++
 4 files changed, 56 insertions(+), 3 deletions(-)

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
index 6875c6d44ff..f9108cb75c7 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -235,6 +235,21 @@
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
@@ -263,7 +278,7 @@
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
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index b254a50b091..14f14db6a35 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -37,6 +37,14 @@ config SYS_HAS_ARMV8_SECURE_BASE
 	  If enabled, please also define the value for ARMV8_SECURE_BASE,
 	  for i.MX8M, it could be some address in OCRAM.
 
+config IMX8M_OPTEE_LOAD_ADDR
+	hex "Load address of OPTEE image"
+	default 0x56000000
+	help
+	  The load and entry address for the OPTEE image. This value defaults to
+	  0x56000000 if not provided in the board defconfig file.
+
+
 choice
 	prompt "NXP i.MX8M board select"
 	optional

-- 
2.43.0

