Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E403D5E141
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 06:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B886F88C86;
	Fri,  8 Nov 2024 07:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PLqRMDGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2681888DD0; Fri,  8 Nov 2024 07:36:02 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9780988B4B
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 07:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSrBsCoT7w+dVxi2PMeJpZD1WAoF62mMxqFqonWGpgLTnOssxhhnQk0cDyuVIIlSULGOVEkydYqsBgqEGIVEZuiLvp4+SbKq6MfLlWPiXnVEM1/CpXOI4AOTcPJ6XpzabrvvacMCKCEZagMDFVda/vaebUYAw2ecIcBBR8ASIaHkoQ7A+ONGpBDCekIf1bOjVABEabTYigr6c2tnFCuRNX5sGxVtRtc1XwE4VADn7vUnaYRpNss4jqojWvsg65Oea1vcpX8SCXLejf6qH4ZkIGvI2NInVJePFpp9lbwu4AxcVuRXBozkce9088VWNX6F+e7Oqdxn1KPN9JiGgx875Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP1NtV+WJ0qe44jk8MTNEUO0gh4lKNquGPbGQQ7W5wg=;
 b=vV7w59fJPG3W9UNOil23mNjFp/ivFtUcPD9rYjF3yvwG3QWoKuvPW38eZcPY6kxZXwRV+won9B1TSTn4EwwDyE9gSAHdaHqsO6IFg8WY8AbufTvR/aZMGZHXOn4HmHjwoyk8S9LI/Fk0DLb8mVXh1oCGhwlyOYr6IuE4FOQc/l7FZ8wq+tJMEnSCGvmS2ETJYgGKP+UBdCbpG0vzfHchqLmOXyy26X/QqsC6mqIrN0hag/zeLJDk4Pv6N4dnKJKNIvFphYlOU5w1mf3ib1+i85Tsp8NHIiuq0i4uOBgUR7Q9Tgyfhh/kg2rPbY7saTS0L7LLe+IwOSk7gmFk3xqt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP1NtV+WJ0qe44jk8MTNEUO0gh4lKNquGPbGQQ7W5wg=;
 b=PLqRMDGvrUmzgQmeK044FRVXY3/99UbesA0O+OquB3G1yXQkSm8T2Lnms/asc9ynL/oJH/HkbliIhB5/V099Fh88WU2ptl3+FAeUPuktOH9kuYZCIdTeX8A3sYJxjsWQsgrf5RtcnVK5lJ9Fy//qoL/dVKqSQM8jfqxbF5H4/Fo=
Received: from DM6PR07CA0110.namprd07.prod.outlook.com (2603:10b6:5:330::26)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 06:35:55 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::a4) by DM6PR07CA0110.outlook.office365.com
 (2603:10b6:5:330::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 06:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 06:35:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 00:35:52 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Nov 2024 00:35:49 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>, <git@amd.com>
Subject: [PATCH v2] cadence_qspi: Refactor the flash reset functionality
Date: Fri, 8 Nov 2024 12:05:37 +0530
Message-ID: <20241108063537.13180-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 42721522-44a9-4b06-bdc4-08dcffbf98eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UwXaduOgAaAgBW4OTtGENuKYaaQSfsEWRuZ/vQ2LdcpBVYIl739JrcDD8xk/?=
 =?us-ascii?Q?hCWq3Lb1Uzx8vSXYhWTHr9+4zWIV/8MqdvdyhQZCMl+NDY+LdCTTGaxo3fEN?=
 =?us-ascii?Q?+dApsr2fVCHi0bFFIHGmLrMuTQ/fjvC8F+7xpx8c6uVL6FkaEiyq2maU98Tt?=
 =?us-ascii?Q?IjQtSIa+XFc0vTjpqfWAsXvVKdpUkJD0MHrac1YcxaxJZw6e2AKQFlvzX3Xb?=
 =?us-ascii?Q?YJwHmxM7+7ezw9uWNQJwXgBNzFS0WXlBJQbojfEm2tH6XeZF1aaGOyeTrUsZ?=
 =?us-ascii?Q?8jFSWdcA826IsIJn6gmxIpA30pM34Yp1iwxv8GK4pJflF07kw/NSHPvOlzUg?=
 =?us-ascii?Q?VYvNyuY/GK8ri8wmqpgq7JIizgj9DBmhxdtxrnYH+X91nsPaD3GN+iSVBr9m?=
 =?us-ascii?Q?T20Yb9VWKBtL3adj+cQ8sFHkbkW3jngxJvgQ5Y9BSSqD3o8sN5LEYhdpJC4I?=
 =?us-ascii?Q?pFKgr/fTisPXGhpm3ohdMv4TYXTGCGPBAm3mrAQZu2b3gYLKXld0nChotH+a?=
 =?us-ascii?Q?wi9YJY5PCygnhojlC8FL01zrxXeRhR54YWZEft3MbGfbSW97MjD9gy0X7v5g?=
 =?us-ascii?Q?aH3EjH1AXxB7zaJsBba8I4money6dl//1POaC/MnkwcpaF/QX1v7Qvqc3VR0?=
 =?us-ascii?Q?Yfqf8A4HzJGWOQd2M1AeDmt232m4Rh/v/GaDNMkLZUtelFmuTexdqTS4EX1e?=
 =?us-ascii?Q?ppDs500YyFS2w+6Y5eeu3pHW8hy/4Ke/LkMZmCDyTo3ijBUChkWWnAZeY5jp?=
 =?us-ascii?Q?hjNR2eLAk0+nuzM1ZkTrIdDRnv7D56oDXxXAqxiPgwhMc8Ux7rIRywM8fxqc?=
 =?us-ascii?Q?OD+XApc76Hzm11L+VSIL3jwoSjBt61KFo1WKsjGGPs1fUfeFSDCyl+mDYMmR?=
 =?us-ascii?Q?r1yPVynNfBtT2jspNXiVlMLNolcWVjZscRXjqgqWV+pdGbzQD0G6P46hwWaJ?=
 =?us-ascii?Q?7/kbOiyRu9YWZtybGR/xbIkbgCAyKNB38haRChzuN6BIRd/FgXdtHS+PfaHX?=
 =?us-ascii?Q?OzZ8blARx1LAuuzSH2UfwBzkNyo5PUqaxnuG9b9evaRCdzxIgKiu2g+mtzxk?=
 =?us-ascii?Q?D2ZIxKIw7PLzeH4kxsdcDOL3Ot+LpjCfET/ypkeJa9q3xrJus6CnloLaEPeH?=
 =?us-ascii?Q?5BFmofG+VYA7dsWMCASy5EX8vT31ZYNePIrRP8865hkO9IKsyYVZTwMYwWrh?=
 =?us-ascii?Q?bibkIWaATm2HfoUCCm+Z6Y8qQKAELrNenFjDUGNOoHafYO1sU1PzdAKPEcZt?=
 =?us-ascii?Q?95K0xM0ONQaAp6URQ+xVPGCRvFc4ElYjpeRrECNikdtXSmyyioj2dBhKUQiE?=
 =?us-ascii?Q?G08N49OIexdLr1ERg82P6eM110yiW/sg5DabHwdRZVyNy3A9Ader7BnVwlOd?=
 =?us-ascii?Q?JJHHkAjYCrjjD3TBJXCb8to/i3CRrme+cb2rsa/nu8Qts2WIeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 06:35:54.8096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42721522-44a9-4b06-bdc4-08dcffbf98eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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

As the flash reset is handled in spi nor core, removing the
flash reset functionality. As the configuration like tristate
and hysterisis need to be enabled by the cdo. Handle the flash
reset only for mini u-boot case.

Rename the "cadence_qspi_versal_flash_reset" to generic name
"cadence_qspi_flash_reset" as this can be used by other platforms
as well.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Rename the cadence_qspi_versal_flash_reset to cadence_qspi_flash_reset.
- Add the DM_GPIO flag in the paltform specific file.
---
 drivers/spi/cadence_ospi_versal.c | 45 ++-----------------------------
 drivers/spi/cadence_qspi.c        |  6 +++--
 2 files changed, 6 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 222f828f54..dcf28c7559 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -125,49 +125,8 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv)
 	return 0;
 }
 
-#if defined(CONFIG_DM_GPIO)
-int cadence_qspi_versal_flash_reset(struct udevice *dev)
-{
-	struct gpio_desc gpio;
-	u32 reset_gpio;
-	int ret;
-
-	/* request gpio and set direction as output set to 1 */
-	ret = gpio_request_by_name(dev, "reset-gpios", 0, &gpio,
-				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-	if (ret) {
-		printf("%s: unable to reset ospi flash device", __func__);
-		return ret;
-	}
-
-	reset_gpio = PMIO_NODE_ID_BASE + gpio.offset;
-
-	/* Request for pin */
-	xilinx_pm_request(PM_PINCTRL_REQUEST, reset_gpio, 0, 0, 0, NULL);
-
-	/* Enable hysteresis in cmos receiver */
-	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
-			  PM_PINCTRL_CONFIG_SCHMITT_CMOS,
-			  PM_PINCTRL_INPUT_TYPE_SCHMITT, 0, NULL);
-
-	/* Disable Tri-state */
-	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
-			  PM_PINCTRL_CONFIG_TRI_STATE,
-			  PM_PINCTRL_TRI_STATE_DISABLE, 0, NULL);
-	udelay(1);
-
-	/* Set value 0 to pin */
-	dm_gpio_set_value(&gpio, 0);
-	udelay(1);
-
-	/* Set value 1 to pin */
-	dm_gpio_set_value(&gpio, 1);
-	udelay(1);
-
-	return 0;
-}
-#else
-int cadence_qspi_versal_flash_reset(struct udevice *dev)
+#if !CONFIG_IS_ENABLED(DM_GPIO)
+int cadence_qspi_flash_reset(struct udevice *dev)
 {
 	/* CRP WPROT */
 	writel(0, WPROT_CRP);
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 9c466f8695..c8d640f068 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -33,7 +33,7 @@ __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 	return 0;
 }
 
-__weak int cadence_qspi_versal_flash_reset(struct udevice *dev)
+__weak int cadence_qspi_flash_reset(struct udevice *dev)
 {
 	return 0;
 }
@@ -259,7 +259,9 @@ static int cadence_spi_probe(struct udevice *bus)
 			priv->read_delay = -1;
 
 	/* Reset ospi flash device */
-	return cadence_qspi_versal_flash_reset(bus);
+	return cadence_qspi_flash_reset(bus);
+
+	return 0;
 }
 
 static int cadence_spi_remove(struct udevice *dev)
-- 
2.17.1

