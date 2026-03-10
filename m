Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B2CEA8550
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 09:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6A683F6D;
	Tue, 10 Mar 2026 10:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mz34ulN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D3883F98; Tue, 10 Mar 2026 10:06:58 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1EFF83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYpTmEgWLyW5sF1FlqPYAx4VjuvWfUbkXy/FpKBc6XhQwEILXdIV1LLmYG6mKss9UVwXauiXl7CLtpAXG1pFRBz1vPLYtW40YjAHM/HJl8pIbyVw8xoqWUU7xfAWIz4/eE8koa6UTz8E7eNCicwnBMZtTG7Bs5Dxs8Z5wuQdFPnMHU9NIk61A176BLRIrstZu3R9nT/+X2NCyn39F316xW0sfkXo9aQZIuIuZ94+JMcLkJ0ZL8NlFvHwnnBbo/7admEU1GvjaatpB5m87BLqgeJAtZUC4Tf/fMAqvT5QxRXKqSOQFevB/ss3Lz1+daIt2UTYsooz4z2wQY/q6ZOnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKqP2u5mwLm9tMgxTv7qoNv6/hKD6u470YpKVchB6JU=;
 b=Te5p0UgUBDqOqNBLneakYL64oOFDG+8u6hRmdks49cN4384IxUI8/ZRcWh6hGY0rjeKlDAjrtoZDlHs1IUFvTd9zlb16OcgIBRygGX/wgGPDiIj9ykiuLS0GNb256ZsKiueZXKAw464n+pK9IDKybkJAh+qJvCXkgrwZL1hnfHKloPw0RDqHFRj84UJSlBsECOnWYg0F2e/8iEL908lVjP74ZE4WIXAAY2NEce5aCH7NGMJ3xAzhwPkfaqwHZgr0srrW0nxr9OUeWzfgL645AqJzugm19lYoedXjLGDt5Qos4XcfwwYglLnlF6Q1jojYEIi0wXOVG/Ey4A8eP0HpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKqP2u5mwLm9tMgxTv7qoNv6/hKD6u470YpKVchB6JU=;
 b=Mz34ulN3TqBWGKih9qLhlSuYti5tKYbe2uAhmPpxlCI5GVy2+E6IDswbUq0ehutjCyC9ZhMEp6by4U1II4haSGDGBVdBQS2SzgR3FGG8sqJdEWbROj2Ee4vzqCcJwqdkdEWmDBxiexdIlsc6Uey1mX8jzakAHUVApdxaYRssbc8=
Received: from CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::26)
 by DS0PR10MB8031.namprd10.prod.outlook.com (2603:10b6:8:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:06:51 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::23) by CH5P223CA0012.outlook.office365.com
 (2603:10b6:610:1f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 09:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 09:06:51 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:06:46 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:06:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 04:06:46 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62A96jvI2269898;
 Tue, 10 Mar 2026 04:06:45 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 10 Mar 2026 14:36:27 +0530
Subject: [PATCH next] arm: mach-k3: use Kconfig options for ATF/OPTEE size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
X-B4-Tracking: v=1; b=H4sIABLfr2kC/x3M0QqEIBBA0V+JeV7B3CjqV2IR05kaAo1RliD69
 6THw4V7QUZhzDA1Fwj+OXOKFe2nAb+5uKLiUA1Gm15/W60KOVsQrQtB7O5TJF6tIDlfkiiz0DC
 M3RhIE9THUQuf73+GiGeB330/UeXwKXUAAAA=
X-Change-ID: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Suhaas Joshi <s-joshi@ti.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773133604; l=3484;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=1xGEF5Ikg69wGQYgHzpW5GePz90FRuFe9UbFqFwPW6s=;
 b=qNkG2/yfVqV6MN0IJU3OaMAxC92CL1NReKo1NEwohxB+6zzkJKQORc1G3gnhFrws5MechlBRp
 5nHmRkHgwezALpGyoALDCBe0t8VR1Eed4KkLYSVakPjbDQalpV3yIBo
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DS0PR10MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fabd68-029b-49d7-a182-08de7e845e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: xTFW76cJKkDKPiw5chQ5xG++MfT9Rns1U3RbKpH9MHn7QxfCJ8z52c8MgrYMrO7478Pa47UvaBp1RlKiCVOKf8atq58shGIlVD4SlM0KGrJkvdH6MKv689MDGC/yU7YW7qVyEsGnVmXHlzDVZOxp3xCuVOZlktUYImUfzRUxV24Ob+blNW3oYBFiavy4yyHLIcrkaUr9Ep7cukB0JQnYnl+B4b9sYnIP37+WK9ggYW1jbNAxvXOvMPwyqaklbEs9Qs4GB4mQEe9WDZHaUdsjuuxbI0ZZc5GG6lMCIu0jdap6plUdj2pgr2KzsDFcIzoLnWOWtV4QPoERtdqhgw4lGV8pyJvEI60nRiPguEeCrwN+IgiN/j1b7gMe2gJnSIeHb6jLYYevdirzYoa9B1H3g2qWoM4GkhLnxFAI6SNTS5aSuu1uK79+3vdYnEsBFpKez2fwHSqDnxtd5x0hhMiWVitKLuGzP5X0gPZX6hQwE9y4tCS17NadRJ5UH4KfP0kyZHJsN5Gxo3NdY+Nq0oJ3LNzF45s8iI8nJYKf0TG683oeUpCIZwWMWtylNJ5qgZi4u9VOWJeECoYiuXCH61exwHG1OJHRJnlZBmMINWDtjN4Af/Z/24jkV7WoLxWH+szEA3CzNb63q1e6PKvJC2ijlMA6munUPBTFFAxreHCl7eKBSRogdO1zgu+IvPYq9ajOa3E1+dy6Gvpnv+WpeKh1Rqu55Dq9B5TFuMZCq1B2IVMXRFW2kBB/q4gW7Ld9PBN+0DjXD1bnaTmjrw+bRZLY+w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: leX4URTpZkZHdeFqz1XzoYFK0I20r7DTQe4LvW/MFqN1jzowuh9L6oK+puY6Kv8XmNH/x1tBpByIXIj6o57ceIyP4k50JZlAzVSgBnClPgqAi8/UZDIUh2PSHs2a3y2rdcvJXoiZEi5Bkd1oqtpEQnj2ktq1syEkSUUymvYlu5cLqV0zlZMzvcZkyPCGW424KoVBCx5qiqa6OnT2uIJgzBNKHAsNYJpmMqKWFSyOvoDd8AfoGnPaRC1CL9jm3zOpFuC1kiSMyRgXgNG9zM28kzdA783giZv0qqFn+WBcZyeHv3EgLUUZwUzTqrLV7WD3C8PwgfVlsKtDVR9X29b+iyIahz6P50d3ZQJmEZdk13Uqe8B8pPonRXW2LQlAvwXUpu2cJumibH5qUQJCaW1iYgMQD62lAWkTYHEr3+Ucjq7sRQz4Br5pSWX0jYaQJ31Z
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:06:51.0699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fabd68-029b-49d7-a182-08de7e845e0a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8031
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

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-binman.dtsi   |  4 ++--
 arch/arm/mach-k3/Kconfig      | 15 +++++++++++++++
 arch/arm/mach-k3/common_fdt.c |  5 +++--
 3 files changed, 20 insertions(+), 4 deletions(-)

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
index 1b8c0b1eb96..ba1130a7996 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -130,6 +130,14 @@ config K3_ATF_LOAD_ADDR
 	  The load address for the ATF image. This value is used to build the
 	  FIT image header that places ATF in memory where it will run.
 
+config K3_ATF_RESERVED_SIZE
+	hex "Reserved DDR size for ATF"
+	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
+	default 0x20000
+	help
+	  The runtime DDR size reserved for ATF. This value is used to fixup the
+	  kernel device-tree's reserved-memory node for ATF.
+
 config K3_OPTEE_LOAD_ADDR
 	hex "Load address of OPTEE image"
 	default 0x9e800000
@@ -137,6 +145,13 @@ config K3_OPTEE_LOAD_ADDR
 	  The load address for the OPTEE image. This value defaults to 0x9e800000
 	  if not provided in the board defconfig file.
 
+config K3_OPTEE_RESERVED_SIZE
+	hex "Reserved DDR size for OPTEE"
+	default 0x1800000
+	help
+	  The runtime DDR size reserved for OPTEE. This value is used to fixup the
+	  kernel device-tree's reserved-memory node for OPTEE.
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
base-commit: 1e240f7206fccde4ec73ea432ab8360d321c5fe5
change-id: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

