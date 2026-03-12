Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99717FED2C6
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 03:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E20783FBC;
	Thu, 12 Mar 2026 04:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X+zcnjfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34ED183FEC; Thu, 12 Mar 2026 04:43:37 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9538583F75
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 04:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnhgTzDH9wP14jbaNTQuEzL7GmPgG3eBVfzghvhU0sziUzMbZh1bmw0bZE/5KNQMFui5sN5ceCFKquWwetwTB9gNbZ8hOBZpvhVmPMvjUJ1Uvdk/OVG47jWKuKVDn9fceCVa2bVCV3GFTONQmXnhzxN257HIB3UDDm0PSyinBtxxN6GKC9O8pVNfHji2QqweXIwfySVuH3ZibPAFGKtOMqu0zAngrjjONT3bJTCsEbuVwe3fA2KNOxVAMxlNJb5XIRLyzCeaAkv6BQHHdk6k0v7CASrrY6BKaA2VSyyDTOVdPKrh1ds1j7xdacFTS5JTFLYgKKCui+tiv1QIc+CoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwvfKQx6LWizuxwZYY4PpgMHSzc8NtGYxy7w7Ut3pzU=;
 b=bM+MqME8TNptn1z7h8kVTYDbGj4NFNL3apLdYhetCsz0nuT8D5toKxnguyAXuKplIdElsdmbodq6yvIU0xcwpe6doiDzG798Eayh7Cp6C3Ez7EyKdQPHeQ7mzj4bTa+wMQvq8KNKgqcdgVPP3hIDoh8uMAZE7JHNmMWXeExs5EJM4PFxOstThukF29ciSGEVBSOWdbWaGUvHTURaWFEuVT2Re09b0GeiMRCHcMUYk8o2MZMcgWgUC7F0yeJfIQikMh6df96YGl8GTMKY/u8Z+tzkNFZf6FFh7OSDSsaEkz53FBMI4xAByrrymLvO2AJIGe/dHaWyGnthRIL1S15N8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwvfKQx6LWizuxwZYY4PpgMHSzc8NtGYxy7w7Ut3pzU=;
 b=X+zcnjfdYl9HjNYj46nJCEAQyA2QwBS92ieMELIbVRffQ0oRgoZtzTFDADysRFDVqbK0cijoXOTFDI/wdYnHuRvvoaYPzP5oeYFG7k+M/AbC/avEz4qwpeveMWtAdkpWy0CwcF6Vc4/f5aR9ONNMcUjJrkI7G5HE4a18cUAok7A=
Received: from SJ0PR05CA0199.namprd05.prod.outlook.com (2603:10b6:a03:330::24)
 by CYXPR10MB7952.namprd10.prod.outlook.com (2603:10b6:930:d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 03:43:30 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::ac) by SJ0PR05CA0199.outlook.office365.com
 (2603:10b6:a03:330::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Thu,
 12 Mar 2026 03:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 03:43:28 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 22:43:28 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 22:43:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 22:43:27 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62C3hQw02081563;
 Wed, 11 Mar 2026 22:43:27 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 12 Mar 2026 09:13:24 +0530
Subject: [PATCH next v3] arm: mach-k3: use Kconfig options for ATF/OPTEE size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260312-tfa_tee_addr_kconfig_refactor-v3-1-86c92718e048@ti.com>
X-B4-Tracking: v=1; b=H4sIAFs2smkC/43Nyw7CIBAF0F8xrMXwaKh15X8YQ3gMLTEWA4TUN
 P13kY3udHnn3pxZUYLoIaHTbkURik8+zDXw/Q6ZSc0jYG9rRowwQTglODslM4BU1kZ5M2F2fpQ
 RnDI5RMy06/uhG6wjDlXjURu/NP+CZlgyutbr5FMdP9vTQlv3p18optiyTmlt1JEBnLM/mHBvb
 GHfFP1FsTclhNZWc6H4h9q27QUv4tL3GAEAAA==
X-Change-ID: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Suhaas Joshi <s-joshi@ti.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773287006; l=4121;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=/EetNntxK2KZABft39KUdtnjdR4Tz0RnJRq5eAN3jVo=;
 b=oYW/sRtMf24abiZ3mTREP3Zo/kPzaoJuPbCrGzD7MzPhhpPvhnVW31Bar0t0tGutsAX1ovCd9
 8YKUlCTDy61DsNBYXaNcxzOeWfxKHbL6XzTehz5+BecT9dSZ6vL+DDt
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CYXPR10MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 8217b213-63f7-44d7-fa3f-08de7fe98623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: OWkSW8C+uLMUg85V0JXOXPhsvAagDhwKU535VjnzbJPI6jdl9h7k8TJ3VaJoL8x5BzIdA0F139Sxj/G9MRSm472S8iPWgW2Sb5sUDj0/UjiH1P/3R/NSAWI91sjztT2h4OIA61m1S4NYxc9ewriyDCMzvvohN9GGvfhXXmtnpO8t/S0yXQlDhQmXhkZ+IdPHbq82JwGKBmZE0u6z24mwsqmjIEYESw8vLdszVw7aqVhcpz+m1Gybu6xyD7lApxVZBp+7qKUIaxQe+YobbY2Kg5bqLIB8e+rxfS7anwwhHERYZu6Tcjx6hwhaW5ohcH2PUa4ygxGJ8d7E/xLAc0ed7mnWRHekbW+zJE/d+XNSaxZKGuvE3j0Y6niGOGEyMLikrtM3nE2Q5g2ymKJM5L4x6wuL+QSbY7NS+M01NT/PVdbB87MaOArNqSUkC3Y3usJ3U3gUsL1duOIPU5hBfWEszyYFrKwJcnukZ4gZYElHDiR3epbhof/d7hZpP3bDYnnZArZ8qG0s96+h9iSkYERu0tXROP/F8Cm1b3sZiZovRMQnzzgh78MzcfErLRyAAxBu9NdoVBLF4AdqD2L5BBJlSKW1Kl77mRsKx4JFiN7rMhP+CipM10+DnD4hidlLndhiJEX/wI3c+BkaDbzYvGOcxAWMecnJoZEXMtgLy7YbsQMkpL+C+tvF6KrAeQS43cXw5y5ZVkfvrotBfgXjr0IEVMz69mz/JJSeGLoR0NeFiitciS3udTmu/d+7HyDwVq3zm2ib/xULkL4qOeRReB+18rd/54/oICL1fZhF9+QTV6c=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7QeheTU4EWf88803MsHwl+M6o95xI9cxw2uuY9j1iIPDL/zF2lePgYeOMLdE1YEyg+oJUMwDlr5oBYOvHDuujDm4KfDuduAiTevIe2BXmPvbae0xgo3wD+CufipcYAsqo2f/BpVUX9MuYgCFugvYhX7bnGVf2Aq9hqcYS57/NibbJNp7f7g49lKwhUMMR/B0ZNC2jLzr9paj2HfXs3FqVsBd91OpscMQZ8Eaw+grzE3ZpmnEBbvljBZpaTLqfOkXfZV23+3D8WlQxAbLes9bj0tyioarge9YhUzn85dwSIC4RUbArLwm9fPgluNrPugWH1N+DqscGI6O3KTf4bWGbzvJ6OQWdznfIScJqF2rX8Wpaw7eoN/s88+Sno3lT+atTcHcLqDnIyWgiJpm9MtkJT8iktaDprdbvXVZ07Fd8qW/W2MX1w28Msw17Gsfqd27
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:43:28.6512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8217b213-63f7-44d7-fa3f-08de7fe98623
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7952
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
Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v3:
- Pick R-by tag from Manorit
- Change help and prompt text to use the generic 'memory' instead of DDR
- Link to v2: https://lore.kernel.org/r/20260311-tfa_tee_addr_kconfig_refactor-v2-1-d66bbdb36a3e@ti.com

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
index 1b8c0b1eb96..a32ed3a9683 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -130,6 +130,15 @@ config K3_ATF_LOAD_ADDR
 	  The load address for the ATF image. This value is used to build the
 	  FIT image header that places ATF in memory where it will run.
 
+config K3_ATF_RESERVED_SIZE
+	hex "Reserved memory size for ATF"
+	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
+	default 0x20000
+	help
+	  The runtime memory size reserved for ATF. This value is used to fixup the
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
+	hex "Reserved memory size for OPTEE"
+	default 0x1800000
+	help
+	  The runtime memory size reserved for OPTEE. This value is used to fixup
+	  the kernel device-tree's reserved-memory node for OPTEE and configure the
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

