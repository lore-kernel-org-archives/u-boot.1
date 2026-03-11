Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60451062887
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 12:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC3D83FD3;
	Wed, 11 Mar 2026 13:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w3utUMGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC3883FEC; Wed, 11 Mar 2026 13:12:52 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E412883F2A
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 13:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPQo5Mq4Fui2fKZp0Z3fDk6oTUxVKfNd5/4vSNeyD/TT3SjS4QUqlUVvkqA4FgwkhV6J+A/6UbdNh5kjdouLmdr4qTnkB5wi+AysUz1FuP8lgUvkxROep0pqsMNnK6oMfkCFrgBFkpwRA1exzIwQUa9uFCr+/ZnVyBDSq7oHOepncHV/S2hDR2pxF5QIfq7jlbdr5KauqnY8dSNr+7mHkw3fzovgoJ6E0b4s2RSX/L7Csa8Fdkvioa19XNSGzAj9kzzw/M62CtheJRIJsxQoXTMt2soWFzPmrEGSTcXlyjabNjUTDZEuljr5o30ay6V38+pwJNyT9qUzfuwU40TOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk6ur6Z88kCh4GyNDNMl02gUWyz6Ndi93gSoA2xcI7A=;
 b=iHB17m+PgyMefAy9390R0D5UKps9T2xSwVayQzYFpKDqwb7cY7+E8UVY19wE2gKvdz4tct1f3HSBhaeKEnGwklOj2a0SHIM4LORb5tGt7DBEHYXapCNHXVEO/nVR0QRX9Xs5KKwVURQ34gBt2WTk+/DJlptCWs6Qu3DlSyuJCvAMWG6C4yWiryIYIebrFKngwQvJEiH6cXRoPGFpxeYgh/cC3z0N4F9qJzEcGajkegBsO7WK/E1l0aeC9W3VwLclHvN++fVAa14MvT9eeFM8ts1OI/XfXCRNVysTFyITSExftYFNAh91shyeV18JVBmUTJ4+ygAQPR4FoQeSP60tKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk6ur6Z88kCh4GyNDNMl02gUWyz6Ndi93gSoA2xcI7A=;
 b=w3utUMGRKd94sBs5hgbihSxwYxivhJ/CRyFaL73cBWS+9WDReQtzJvHajUitguN1ALR8vYl/xEaQ/pp1BdrvHDntN7hdvbNbQoJOj7j61bBsSzlvO2b6FuXYLUsxpv+Sa3rA+yq0f4ImBpSKXLlOsPjM+2rdn0PsTpuRno1trSs=
Received: from MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::9)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:12:46 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::ce) by MN0P220CA0029.outlook.office365.com
 (2603:10b6:208:52e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 12:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 12:12:43 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 07:12:42 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 07:12:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 07:12:42 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62BCCf0K298853;
 Wed, 11 Mar 2026 07:12:41 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 11 Mar 2026 17:42:40 +0530
Subject: [PATCH next v2] arm: mach-k3: use Kconfig options for ATF/OPTEE size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260311-tfa_tee_addr_kconfig_refactor-v2-1-d66bbdb36a3e@ti.com>
X-B4-Tracking: v=1; b=H4sIADdcsWkC/42NQQrDIBRErxL+uha1oWm66j1KEKPf5FOqRUVSQ
 u5e8QRdzrzhzQ4JI2GCe7dDxEKJgq9Bnjowq/YLMrI1g+Tyyi+Cs+y0yohKWxvVywTvaFERnTY
 5RCZnNwxjP1rHHVTHpxLamv8JHrcMU21XSnX8badFNPanvwgmmJW9nmejbxLxkelswhum4zh+2
 s4nyc0AAAA=
X-Change-ID: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Suhaas Joshi <s-joshi@ti.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773231160; l=3831;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=y30SsiBRsiL2O8mJ5BszYoKdi1QK0902G2Xmti5MPwo=;
 b=+0hz4Pbdd9oGHf2g19FePR8Ar0V2hSSBcfyO3VF8wYljU/5jvykB4lTa1tm44hrH5DKNp+T9e
 K7hBtRtLphwA9ra/GmQOoui4UsfUQzo9Wsvj49fq2VpHEoPDkCqwQAd
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SJ0PR10MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c7c354-ebf4-493b-6858-08de7f677f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: OxvXC66/X8e6lQqY4fXk2Cz7by7EFlqrBdS+22fnkp1VQOeA+foKaYZtWaHHdnuUsirYOYE3YgMRyfZWLABsc913KnQeeiuJrZRdHwdC1QccyaHai0M4FWUxu59+RueAXCrVBrDkLYsMOFfpPxtGkDXOGOV8Fco/NBjqjYBSAl9wWKVHaYJCDOZce276WeajMfDJTPytygzm0lhRpT/LkRj3juOFkesbTsCwYKcJ2JOIHg/B+jpPyXhqyF8OG6VBT23RaJGeneHCIqYbzpYTu+4LYh2H5T+rAM4rGVRDStHUD71WP893GS9Qw/LYUJpFuCs0UkmBU7PsAMNY96TyKnqUSh9+/sYQD0SYbJPd1GmQRZD7Qw8D8w7FRCFPOxg+D7OYuxrpUk1M1I56eznHguUZc8TSEBCMo/Ll2ERGYkewlFn5Zt6iYkVJKOOOZpdxTQcE+o3vZiewt1Aq/E81vK71uQzAme0YPVAfHhMSLKKDWvBgddGlsXpi03jdh4NMlsDqbsdxrqg4JVZaCnJHURQyymy/SzbtfoEXDLNPy0uMD3tvXkpHSTjTSrvEUtxansElxnJ4wykPcbHUWOVH6oQ3k/ywOssFjHiIXapezSZ14mf4pdE+dTSP9O2qeZkyXk6Fw3fu08RnsMymsq8rP3/Ogon1A3rrHFthIqaI9w3cQIO102d8OMGURAMhgtr+HFiVBBKPSH4LrZQhLd+ytyjnCmEVX1Nk8/OWPHMVV5HLOvVKHibu1bYTijZ0Et7sb06A78F+BEZgIK+Oszcgig==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TcMyILPcGgXlUtu8csLkTFKBqRWEA0PoF2Nq8+pbPxx9aF3ng1BjAwACUhHYyo7tIIWg3u/OWkg1ZFoPIMIjlQ3Ov7kvQunLAWzVvCVEzrHP+iv9wmt3O9n8SasCSmbsHQhmNkItKFllitbXHnm/G1ybFpXCUfPLpLf8sBnlIsIcbzWw5hgeBy2XTFPwgdFxBnML+mFq9SX7tBMZ4OEi7NGcwbjbmmA+6LAB7D31Xb+gcPsjhw0koUDXnOfSkxgRISKW7R3605Rvzi+25vVur1NXS7y1Or2VRU6VNTSXNd5ubleLOTvY7tKPIMiysvTOxlq0nvpKBLuR0idhiTtQ0sKdrEFjCr0g1ZDrGUX29ayTDkq9LXIugbkr/ZsS3x+WS659nv6RopEtuN544O8/fXqmnqFhh5/IpOQaRK4JeUPkBdHClUbLLsIczi7c2XlQ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:12:43.0382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c7c354-ebf4-493b-6858-08de7f677f8e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
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

The reserved memory sizes for ATF and OPTEE were hard-coded for K3
devices, this patch replaces them with a Kconfig option allowing for
easier modifications.

Acked-by: Andrew Davis <afd@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v2:
- Update help text to mention firewall configuration
- Pick R/Ack-by tags
- Link to v1: https://lore.kernel.org/r/20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com
---
 arch/arm/dts/k3-binman.dtsi   |  4 ++--
 arch/arm/mach-k3/Kconfig      | 17 +++++++++++++++++
 arch/arm/mach-k3/common_fdt.c |  5 +++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 0fd93f9536a..ad127663d03 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -477,7 +477,7 @@
 						FWPERM_SECURE_PRIV_RWCD |
 						FWPERM_SECURE_USER_RWCD)>;
 		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
-		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
+		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVED_SIZE - 1)>;
 	};
 	firewall_armv8_optee_fg: template-8 {
 		control = <(FWCTRL_EN | FWCTRL_LOCK |
@@ -486,7 +486,7 @@
 						FWPERM_SECURE_PRIV_RWCD |
 						FWPERM_SECURE_USER_RWCD)>;
 		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
-		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
+		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + CONFIG_K3_OPTEE_RESERVED_SIZE - 1)>;
 	};
 
 	ti_falcon_template: template-9 {
diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 1b8c0b1eb96..e7ef35ed2cd 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -130,6 +130,15 @@ config K3_ATF_LOAD_ADDR
 	  The load address for the ATF image. This value is used to build the
 	  FIT image header that places ATF in memory where it will run.
 
+config K3_ATF_RESERVED_SIZE
+	hex "Reserved DDR size for ATF"
+	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
+	default 0x20000
+	help
+	  The runtime DDR size reserved for ATF. This value is used to fixup the
+	  kernel device-tree's reserved-memory node for ATF and configure the
+	  firewall.
+
 config K3_OPTEE_LOAD_ADDR
 	hex "Load address of OPTEE image"
 	default 0x9e800000
@@ -137,6 +146,14 @@ config K3_OPTEE_LOAD_ADDR
 	  The load address for the OPTEE image. This value defaults to 0x9e800000
 	  if not provided in the board defconfig file.
 
+config K3_OPTEE_RESERVED_SIZE
+	hex "Reserved DDR size for OPTEE"
+	default 0x1800000
+	help
+	  The runtime DDR size reserved for OPTEE. This value is used to fixup the
+	  kernel device-tree's reserved-memory node for OPTEE and configure the
+	  firewall.
+
 config K3_DM_FW
 	bool "Separate DM firmware image"
 	depends on CPU_V7R && !SOC_K3_AM642 && !SOC_K3_AM654 && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index cb0fb8274a5..39cb00c3f43 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -173,12 +173,13 @@ int fdt_fixup_reserved(void *blob)
 	int ret;
 
 	ret = fdt_fixup_reserved_memory(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
-					0x80000);
+					CONFIG_K3_ATF_RESERVED_SIZE);
 	if (ret)
 		return ret;
 
 	return fdt_fixup_reserved_memory(blob, "optee",
-					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+					 CONFIG_K3_OPTEE_LOAD_ADDR,
+					 CONFIG_K3_OPTEE_RESERVED_SIZE);
 }
 
 static int fdt_fixup_critical_trips(void *blob, int zoneoffset, int maxc)

---
base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
change-id: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

