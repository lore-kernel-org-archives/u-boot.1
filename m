Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F36EF587B
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 15:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5574F80B98;
	Sun, 15 Feb 2026 16:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AjUk5Cu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A12D80FA1; Sun, 15 Feb 2026 16:17:06 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082DB8063E
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 16:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UE9NEPYCK/2uEzWNLZiaXr0CxG0HpUu86I8yjVU41z7SXwvt+FxzKVp9hdW0PtMfQClUU0+OxFvsymjDyHhOwrsmpsnt1YTXgaNjUlH/1VjCR6RCJ3eP+Od7S+D3bQR2z7KvtLmcC88rmtZ5nBCf/YlFP3PFkdcWOsC4p/9fptXhCVVx0alo8YvV6camiJuoECfvYUMIxHzD/MHD87zOOXs9wVi2f9VQbDigOkpzvJcmkUr7AQT244S6laz0ontNO+ODyXB1CV/ny4XlgrW5sBXFFwAKz+9yMyJklj/22dfA2SCl2VwMypwm2kFYi5/lO8KsCPMJOBeDFetIRaXUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTxsywl1KpAMYBB1Oh2+tqtMhHEnlwpbHxrGrD6ThN8=;
 b=WKTH8VwslWuA99irdkjq19jgG4xIuQWDpf/01w5EqBGBN4F8ttU7CgjF0DLSYzceMFfnpGdlizdpbyhW5HrdlA/X+d63nzvRe+lg77CnBx5cO6/9gbd05XJtrawRHFwiBtsXpdwZ4gAEzxTn44LgQc/qN0qZsmxys0/WyeWeBQ+MsYTIcpWe+HbeA4Bd5Ee2Bm18mOLqWb6GOqbir0U2Cm0lcfHezoqmIHH0OCLx/7JLf3P3AlNCmTgcCfX92C6xWd6GkXsvGzDEjbpXlWc4dkCy7rwu86YuWYdP4uyttEYupEYWfFBvUe1pXijhGKQbvRWBJgUrtYMPxU8MwFqW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTxsywl1KpAMYBB1Oh2+tqtMhHEnlwpbHxrGrD6ThN8=;
 b=AjUk5Cu5n3bbY8zR1CYy4JKwJhOycX82TReqd/joKjLIc09SW3mh0dlDMunnWnEcjCAgkYQEMuHcGHr/9dWawSzumfzwhPXQ1xL3yNqxs8Za7NGWX97LCUPAknBJeJh5i9o33z9mSRa/Hdo7puwg2Z1dFzzy0vBcOvtVVKpbQnw=
Received: from SA1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:806:2ce::8)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:16:53 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::45) by SA1PR04CA0001.outlook.office365.com
 (2603:10b6:806:2ce::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Sun,
 15 Feb 2026 15:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 15:16:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 15 Feb
 2026 09:16:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Feb
 2026 09:16:49 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 15 Feb 2026 09:16:48 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] spi: cadence_qspi: pulse controller reset at probe
Date: Sun, 15 Feb 2026 20:46:26 +0530
Message-ID: <20260215151639.3472200-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c889ed-277f-4133-0030-08de6ca54046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WldTNmV5QXdhWWg3cXJ0S25qS000M3E1UmxHOHk3OVVIbmZTWXg2ZTNNYTlq?=
 =?utf-8?B?VCtMem9DTExWc2IweFBNenNNOUVXMFQyYzhMNFlVR0pYYUxYdEd4V2xRWXFo?=
 =?utf-8?B?dWxkZTk2U0JBbkMwQlptWUpXbzlwVzBWN3B4STl4bDRvWE44V3Jvc2h6N1VZ?=
 =?utf-8?B?VVdFYi9vaWdUNlVLRXQ5YnVxWWxTWGxsRHpzVnlRQy9TYVFkVHQ2aVlHNWNw?=
 =?utf-8?B?YUxMQmJkbVhkTDBtUWV2bU00UERpVEhTSTBEbmVuNVA2VFNqUExuNFM0MDlX?=
 =?utf-8?B?eldWaGtlVmhYbDRqVS91K0d0aEZ1TERKdnBMZmMxdnd2MXlmMzI4QmFOMnE0?=
 =?utf-8?B?Nnc1QmhpUGVsN0w2L081MCt3ZTVjKy9TUE0yMGlGdzFSME9BQ0k3ZXhOUWZa?=
 =?utf-8?B?N1dPbmJOMUMvcDhsSDJRdkViWU5PTGxoVXVDald2YzFjVGlnVk5CRU5LVktR?=
 =?utf-8?B?KzQ3TDVOOFQ2d0lOUkVNZU5vSmdrR3I4WlVCamFhVytZS1BTMkRscU5XZ1Yr?=
 =?utf-8?B?ZGU2TzdqWmdBaDBYRnUraDR3c0FoWGVMdXlSbE9xUDhwWmZIZUJXUmFTOG1P?=
 =?utf-8?B?aU9Ld3Z5anVRRWxkZk05V2NIQjA4QVZlVXJFRThiczhEQ0puQldOMDh5WUM1?=
 =?utf-8?B?NGtuWXpZbGxmTDM1bnhNWmU1bkw4Z1FxU3V2bVNWaHdqTS9FNDVRbWJOOWMy?=
 =?utf-8?B?OFFkLzdKa0hPZmxTZEVwOGFlenFIMTVUeXBEaUJyWHIvUElJT3h1N09wYm9v?=
 =?utf-8?B?aFdNbDZUenlrTzFMbmtaaENhMW4zU0NYbFM2amRXYzZKT0gvcG90bExRa3lP?=
 =?utf-8?B?N3U3N3Nndng2ZHNOWGh0OTJPUWlJZkJQYjVuTWVQU0w1ZFl6ZU14QjZtazA1?=
 =?utf-8?B?dnVzRWpRSjJsRCtUK2pTUWFvM2YyUkFERDI1MXl6Z2Y0RlBpTWU5NVhHMnJB?=
 =?utf-8?B?QWVPb0JpQ01yb1VWV1BpckZlMFdVT0p6RWVrRFNKcVJOM2ZlODljUWJ5bkVR?=
 =?utf-8?B?eUlpTUZEZGp6S0pWZmhKbjdYa2JFVFJaRTRsTXlKLzZoaUZQSmJjdjVLNWxh?=
 =?utf-8?B?ZS9sa0FxaE1xR2hlWnhBR00yb2F1bHNGb1k4WjRtN2dMUy9rakMrMzFZOEpr?=
 =?utf-8?B?S1d3TmhFQ1pWUVJndkRNUDIyVWhnKytGWGlKdHBGWWkxWkR6bVo5SFpSdjgv?=
 =?utf-8?B?RUZ4akU5WktkSEpOdVZNSWpnT1FpUXRNZk9OcU5wMkxDM0Y1UDFybUpodDhM?=
 =?utf-8?B?ZUNVYzFhSWhTdXlvajdDdzZ5Uk9ZVHh1NmRmZ3kzYk1GSWt0WlBFeTRqcnFL?=
 =?utf-8?B?NlRVTXY3NHZheW5xc1d4c20wTlYwR09ZQy9lVm10dExkc0tlUXVHNEtJTDMz?=
 =?utf-8?B?a0Z5T0ZlMzdnNlFZT3IrNVVRVGdHSDRpUHhxZTFuQSt3R3poV0Z5SnI3VGFT?=
 =?utf-8?B?Nmc1U082YVlueDFUSmdtaENUdGFKaWJzS1BxRjg5MjdxMlN4Mmh1OUYyM2lO?=
 =?utf-8?B?bVIxU3crWjRObmZKVHZ5L3BsNFk2NDNkS281ZGNYNXRYNTI3U1g5YWN6M0oz?=
 =?utf-8?B?WE91ZEp1U1lHMlZ1WllvT1hIQ25JbVhKWFZKZUhmU1VrUEhOSHM2VXZMYXRD?=
 =?utf-8?B?ZGxJMGQ2d3dIL1dmVzRIVmh2UFhoN2hDQkJqWXRvMm1TSGRGQ1ZTQ2NMZnlW?=
 =?utf-8?B?TkFRY3k5UXJ3S2MzSC9RczRBRWMrKzYvaEZ2bm8zdUNiWEhUU1puc0theTFC?=
 =?utf-8?B?WnRzNkRkL01jZWN5RllLUVFmdkp4NnFhZGUwMTUxYW9zdTFxRlZKN2NyR05F?=
 =?utf-8?B?QnpFOU1aTk9MRE1SWFR1VEZMMXpxVVlQV25VajRPVk4xdUM1SE1weGJMcTV3?=
 =?utf-8?B?eWNDMnpESG9jSHhQQS90bVkwbjhrcW40c3M2SHFBR3M3NXhySklFazZjY2Rz?=
 =?utf-8?B?QkpvSjk5elc2eWxkcW9vQ0ZvUElqVjJKSE5iL1p4TlUrdzdXRHl0RndBcU1P?=
 =?utf-8?B?K2JMRml0MmdIT1ZCV0hvTnRvcWdaSlI0MUluVHd4aExQendiZHBGWTdlZEpq?=
 =?utf-8?B?UU1aUHE3NTRiaHpLOU1qdkwzZlU1ZEdGS0VBZmxNeXFQL1owRFlsOFlmbGtB?=
 =?utf-8?B?M2pya3cvMHhMaGtuR3JVb0NjUlpFdkZ4UjJyUFd2UFh0eTl6U0NDeDZWcDla?=
 =?utf-8?B?UHU1WWRDSVpvQUNzMWdMQTQ1alVnR2d2U2VoZEVYU3o2RGQxamVFa2IraHlU?=
 =?utf-8?B?NDRQRitHdWdsSE5xaWFuY3MzbjdRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: muOuWa6Xr1bwvhKbuyHhAjsTU14LnsvAtRH1VbgiizzAtcJ//KLHCAWtH7sj9YRCB7RP/6oOi6owQl8VntvSQL2T3C9INcUvf953JkxHFpA2qCCbNL5fWn31WWJUjcEImpTVhbfmX0JcUST2E57kg6egMzjahjzUH8Xwks4ZZDrk5x0V3OieE0NoB+HYgtpkz1Bsg0DWQxfkoz0ibRwjXfbiVqKwLFzRDRZ295NOu26lQyYr8KIPeCU1TDhFggy6q0DNFsjtqbjyLa3tTl/jPsIIJsOO5Kb2COaVXPa7cgYPLIf8LCW1BFgTTMkbfeMO1BisF9nbvCSSk7NsvtjJy8ZgsLNjhDcdTLlSpKBV1+ys7xVf4N4nMgH8RHVgDku8+Df6dnXIhaU3EOTF8QgmI80Io1XUiCisVjy/6yhHGQU9X90H/MiOi10HdD+5Czq+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:16:53.6267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c889ed-277f-4133-0030-08de6ca54046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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

The driver previously only deasserted the optional bulk reset,
leaving the controller in whatever state earlier stages left it and
risking failed probes or bad transfers. Assert the reset first, wait
10 µs, and then deassert so the OSPI block starts from a known state.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
-Remove the reset condition based on CONFIG_ZYNQMP_FIRMWARE
-Use reset bulk option
-Add assert and delay for reset
-Update commit message and subject
---
 drivers/spi/cadence_qspi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index d1404e13810..2a4a49c5f1c 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -13,6 +13,7 @@
 #include <spi.h>
 #include <spi-mem.h>
 #include <dm/device_compat.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -254,8 +255,23 @@ static int cadence_spi_probe(struct udevice *bus)
 	}
 
 	priv->resets = devm_reset_bulk_get_optional(bus);
-	if (priv->resets)
-		reset_deassert_bulk(priv->resets);
+	if (priv->resets) {
+		/* Assert all OSPI reset lines */
+		ret = reset_assert_bulk(priv->resets);
+		if (ret) {
+			dev_err(bus, "Failed to assert OSPI reset: %d\n", ret);
+			return ret;
+		}
+
+		udelay(10);
+
+		/* Deassert all OSPI reset lines */
+		ret = reset_deassert_bulk(priv->resets);
+		if (ret) {
+			dev_err(bus, "Failed to deassert OSPI reset: %d\n", ret);
+			return ret;
+		}
+	}
 
 	if (!priv->qspi_is_init) {
 		cadence_qspi_apb_controller_init(priv);
-- 
2.34.1

