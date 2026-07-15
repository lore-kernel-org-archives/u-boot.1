Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A3DC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 23:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CCD84CC0;
	Thu, 16 Jul 2026 01:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="aBm+rpJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6EFA84C42; Thu, 16 Jul 2026 01:18:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7CD84C42
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 01:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsxTt99pk4R+Obnuwu4R4a96UVJSCjpRAq8jRqfcjtsVj/nM113+ewrElrPOGDffVd9vHXZ8tlQdN1fDYAVt3TJPpn7koXK2CBpqgp2zKyi5dnXECgJLrXawe4SIhpyus5PUUEV+VeteZykD02NPc/u3poNRQ3s7DSaWoOH7P/VaQ/IJvEY41sGYlj8wwvDZNAEhtLiC3n1hgX+8RxrX6nDxcRHygKRWAH9qHKvfiue41tqkskrwzgNyv1igswvNCkgKmTwlvx0o07g9u28AgZDIuepjZFwy6GcS1XCKn/NCsTX2cKU2rGz3Uq4ZagL4vWgYFvW1cOnN0ta71XovRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWRmnPVS/+AIfPW5TpDuj4hLfIXTthdbwsW//btX27E=;
 b=GruQOMFVMyjhx+fcgixZn8c/iiwWArPClJS8PLxSJXjIE0WdMYBvDYNUsb7tHkOtYhS970UCSS4kG03YCSm6aNAw5sl7AB+oWQ82TGtgnxBlHIW5ptf/7+cJrGrDCsK3I84RUK4BF6XvX9t9yozNBSWf9vhMCLuTmG7eKIZk/KB2Iu0QOgJDqQYaHctS3hS7IxqyZelA8GxJr4wVGu50eyBovAtv4rKiTtLCP3bAaNA+/ICJdX1QjkV+FlBQxRMOjxADNPevsL449bHvVuI+STa0RCxBacqzkJjkaml6y0u+iiTgZA5cytXGxzyQLHugdnmqjKViGBw940XzmJlrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWRmnPVS/+AIfPW5TpDuj4hLfIXTthdbwsW//btX27E=;
 b=aBm+rpJMqlzFxqD11XcSlx7II2IfBK/5g6P9uBLpT2QZKmKo7MM/7ePvhItnGxrjvdngkAK/LEdYSBQW0oBBDnvoZoXvtOW6sS8IJLjDmTOl4lT6cH2R8yivuhDZz7oDinj66Q4EGHnrcxy+WYtBSp21zElP5IRTq99WDHZAPzd/mo05jOTKLbV8yuvX5Bfh4sgSFXhhfgYEaAldfa2mtRs2na0zDbhuHNYAG+37fZ/Q34pAG/ilvbnpDBDgfLhuFsI7iiF9rdKT2uP2tfoM8ZSHxWPZmUW1kx6l4QIKEL+QPmUreLVnGbzfgGU3zdG1/3F+gTNx8wrC26dB+RzQ0A==
Received: from AS4P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::9)
 by AM4P195MB3140.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 23:18:04 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::4d) by AS4P191CA0011.outlook.office365.com
 (2603:10a6:20b:5d5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 23:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 23:18:04 +0000
Received: from lws-haller-privat.phytec.de (172.25.39.212) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 16 Jul
 2026 01:18:02 +0200
From: Dominik Haller <d.haller@phytec.de>
To: Dominik Haller <d.haller@phytec.de>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>
Subject: [PATCH 2/2] board: phytec: phycore_am68x: Turn off pmic watchdog
Date: Wed, 15 Jul 2026 16:17:40 -0700
Message-ID: <20260715231742.56105-2-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715231742.56105-1-d.haller@phytec.de>
References: <20260715231742.56105-1-d.haller@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|AM4P195MB3140:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a250e3d-e218-4d40-610f-08dee2c75283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: csOM39IC9WWM0FMBgwYgYUv2If5pfH50rXM6ntlmoFjwB9XDqrNVlzqnwwHuvSzhJq7qTXVjI3lEqqCv3NfG6VWbPCnmFhNH9GoJ5hwDLTJ7USh1L1buO7LFPnE7xIJ87mxRhWmngpLVAPAdRn34ZNBjvqw0BLD9JJ3hd7waKAxrOMYE3d3E7E2AsTJZCM6x7vBfBafZFYwBgUkZrhXnT4tcqnDa0S0ro2skXt4+OFAz0df8kdEOSz3yD4EPzhr1e88EsOxdFAasgg917wSPA+yzTIU6P4HvtJJIol/zIVATxgxz1m+51f2IRwlBmukMd3TYXtKJ4IZnWmzedIaVj8NH7qv65DlazJ38MWDWBSxjvXoIpo5ZMjkBLHLgt2eDZXwtGEZCzhKq71NhpkUUTNWRnaNcjI/P4j4wiztVdy4bVKwpJUKPRauVWA+emwjmtZDlU8vfJ0nOMPanPhEHIfeW+s6aVDcBLZWXOiBhT1OPIWb5QaXu1MpzGp6dxLqJFj7ldN9e0fPNxw3aS1jFVMWjNKX0stodUPsvpKOu92G3cwN31olzsbBtHlgULenqKXpHVrc7pdx+fVAsGJeCuG/bla1tFUSmhhyMxEQNrFzpnakVKMOtUP+e5zGY662wALJwN3YsyRXoPxbeBgRm0nlzx22TrmC07udAwMpg3mRpN1xvA5WsJjdyJed9G7tMBxH3VF/aBuJr7GfQFTmVNQ==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /vSYXlIK9KhtS4X+8CKuQAQqgFts9HhN4vMcOlRjhbWOOczJ0Jsf9HaOo+Xns5FOncHHeN7c61qepg68emvV03e9ZoOCnKSIhrEEBoe/2bT2ziAlqNJM7apmEadnnSPk41SauKj3zYRk5abBgPTfI8e39Ouf6mGtdotPOMPVkiVjh+8tkRwTi6vdSkKmB06JUx41zBMWUh4V1frId/NB6DhP921orJLniwrAv3kI97uMJnGJm6uVqgCzd+1hlHGKoIAvu/ebKNwEMWyBjV+5VZ5rXDknNWFM36e9VtNQKlcV7tCrnqBzfzLIa51pLnRY81tD/QA5op6BnBzDz3QohWD/YV44my++USFFjyAbQAo+xaknDuXkrviLxxk7g1VYiqDt+A+Gbhsrox3Q1qyE0J8sxBo/TSOuDUtXUvnYAC70xKBP1ULZ00lM3Y94QqqS
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 23:18:04.3471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a250e3d-e218-4d40-610f-08dee2c75283
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P195MB3140
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

Starting with pmic firmware version 5 the watchdog is enabled with a
timeout window of 13 minutes by default.

The TI EVMs use a dip switch to control a gpio on the pmic which gets
configured as DISABLE_WDOG by the firmware.
On the phycore_am68x there is no such dip switch so pull resistors would be
necessary. Using mcu_i2c0 to turn off the pmic watchdog works with all
hardware and pmic firmware combinations.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 board/phytec/phycore_am68x/phycore-am68x.c | 41 ++++++++++++++++++++++
 configs/phycore_am68x_a72_defconfig        |  1 -
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am68x/phycore-am68x.c b/board/phytec/phycore_am68x/phycore-am68x.c
index 312d7ece23e2..9b71a4bdc680 100644
--- a/board/phytec/phycore_am68x/phycore-am68x.c
+++ b/board/phytec/phycore_am68x/phycore-am68x.c
@@ -21,6 +21,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/root.h>
 #include <asm/arch/k3-ddr.h>
+#include <i2c.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -69,6 +70,46 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
 }
 #endif
 
+#define TPS6594_I2C_WD_ADDR	0x12
+#define WD_THR_CFG_REG		0x09
+#define WD_EN			BIT(6)
+
+int tps6594_disable_watchdog(void)
+{
+	struct udevice *i2c_bus, *i2c_dev;
+	int ret;
+	u8 val;
+
+	ret = uclass_get_device_by_name(UCLASS_I2C, "i2c@40b00000", &i2c_bus);
+	if (ret)
+		return ret;
+
+	ret = dm_i2c_probe(i2c_bus, TPS6594_I2C_WD_ADDR, 0, &i2c_dev);
+	if (ret)
+		return ret;
+
+	ret = dm_i2c_reg_read(i2c_dev, WD_THR_CFG_REG);
+	if (ret < 0)
+		return ret;
+
+	val = (u8)ret;
+	val &= ~WD_EN;
+	ret = dm_i2c_reg_write(i2c_dev, WD_THR_CFG_REG, val);
+
+	return ret;
+}
+
+int board_init(void)
+{
+	int ret;
+
+	ret = tps6594_disable_watchdog();
+	if (ret)
+		printf("disabling TPS6594 watchdog failed: %d\n", ret);
+
+	return 0;
+}
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
diff --git a/configs/phycore_am68x_a72_defconfig b/configs/phycore_am68x_a72_defconfig
index 5ede3eb73e7f..e74e604e1bc7 100644
--- a/configs/phycore_am68x_a72_defconfig
+++ b/configs/phycore_am68x_a72_defconfig
@@ -38,7 +38,6 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_LOGLEVEL=7
-# CONFIG_BOARD_INIT is not set
 CONFIG_SPL_MAX_SIZE=0xc0000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-- 
2.43.0

