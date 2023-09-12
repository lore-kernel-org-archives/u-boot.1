Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78530CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 11:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE08986E75;
	Tue, 12 Sep 2023 13:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VzyRt5Jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D3086CDA; Tue, 12 Sep 2023 06:02:27 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A632386D76
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 06:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxjJt0T2Ey8a322GE5qg9jEGmmW0iIDHTcWDiAUb46J9JLH9ZK5RvgaKq9byDIK0lIilD8J9rzIVrVTdQhLAvx1PSGgbTpqpuiVvZzahg8mj65yw/ATt93DH/SLak/iNosWX2kVffLyJ5Yh77i3wLe1hbNj5zkN6I4jyPW3Sd6R7vFYXZ/cvnUiSXM+cabY6nHQgOQPJnS59by/h4sU+PCL9FLB0p66KqWf6MVM2qXDk9Utmz9x7ZftyKxu1yU0rDiAIDL9m0UkAAcz6KUs/Dyg8iqjqNlK6ZhS9BjY9tI81YZYNMK0DHucuAdJq9g6UGpgPVxMp3Uti9/gdyzTYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+KQcmLDXM+g8597QD1GAwp3p/1N5Q921itAF9nPy24=;
 b=kS27wPCaIV9KCVmBMmd/MzzQzIbhRwSW/VsD8XMPQmOtnT9Xk3Nqj6mgivqhqGfWhuzdunBIxCjJyuPup3tw2cgsaZulHVG/8rk/anteFkRLtm7j23qmk7pwEDh2HLed8YxeRvThL3LUnJ8Jqp9i600dD8ArOYVrSk31W3P4ewCtG1o6OJBrn0SRpwu3Z3UJ5iTIuP94bWkIjJQdEjt9hhHcJG5oFnsHLJK1EkLXk2W+tRpr74+asGSJeUhe7EtlPmU1ZrAiopr9F13FgCtQ+RGZbGXwE0Rld+LYVLjVvozZ0zIfYzeTOJ6y9//j2TM/jopPzTYixBdl/RB+AlPD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+KQcmLDXM+g8597QD1GAwp3p/1N5Q921itAF9nPy24=;
 b=VzyRt5JvxyNj1NGHWHj8EI5o4rGnpc022QysLOxWKQUrYiboAU0jg6TaVJmjEuEuk/65ssAKPUzYiyuxfQ827xHunPeXcY7Of7O7eS6EseR9iKdB2mvI5YaYBTKbWQ9jtvMl9sjw6qaoB1olB4rCg6SwY8h71Q0HxYcE0XYX1lQ=
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 12 Sep
 2023 04:02:19 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::83) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Tue, 12 Sep 2023 04:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 04:02:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 23:02:17 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 11 Sep 2023 23:02:15 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <git@xilinx.com>
Subject: [PATCH] usb: dwc3: core: add external vBus supply support for ulpi phy
Date: Tue, 12 Sep 2023 09:31:47 +0530
Message-ID: <20230912040147.30734-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fb0a76-f004-4f2c-b1d5-08dbb3450e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03xRrceNnVPEwr1YiMNUMM9AIwfodiognH5EYnd039xsk+qCqD1ajKXf/LyQ0DUy/thYgpkK8SXh9c0fvt0eGMexK0swQXQggTaGDcggZqzYoXRpW3mha+E9ivxRy4iYQKsoubwkgPbP5yCJqglfsZCZ5t7iQFO+uBGRK2+ZAmnhq1cI0ULEWarHwBFfJPY+1kzRtH9aZ/q10fz6ou+UdBBEyHzk6Yir9l+KDSY3gfN5V3KfJ2EOiRcZUINSaxz4J3rEWAITTZ0fLBsVolfa/ntBbToXu0Ip5uUBMGPbv12LJNrViy1BCA74Oo0hxlQB5/yPpcPJVFe3xxP986Q7n/k2ICuJGX9Bu42J6vE9RLx5aUhYwWjcWDaa6pMcKgp4H+FacpBAfpoF3nm77d1jxT9Tf3lKnsHj7/vXNYa4tzRBxRzE6LT8ycjOHylgGWwYm8OQFbk5wcVABZxNcu0MdwECvYOv4FtJRgsKK4TTeFckj59A3qOzstWnoRCwKzNUhEFLc43avjHIFbSLBKdKaqLAClr52kOvwSkA6nImmM8oUNRKxHLLiiERSN/8QyqS/hhuwEcmi9C+52oCEM2pr6k6rMxBEr7N/iIAlyTH6XMqsWA71aqYybdq078rIQOXHoMkzH4cotcxzpdHWvpa9A9ljI/DQdHDAEpAkffmUmpaW7Z83d9wMTEiufrbcWX7LEUGtYLTX7HAnf3G9lFBXoxDcHCoEBbfJOOK6Ywcee935pXyGsgh1dRV72Zj2qYECAaU6e4ZCMWqcS3/s73o1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(426003)(336012)(36756003)(2906002)(81166007)(356005)(82740400003)(47076005)(40480700001)(54906003)(70206006)(70586007)(41300700001)(6916009)(86362001)(316002)(5660300002)(8936002)(36860700001)(6666004)(4326008)(478600001)(8676002)(107886003)(2616005)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 04:02:18.1788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fb0a76-f004-4f2c-b1d5-08dbb3450e9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
X-Mailman-Approved-At: Tue, 12 Sep 2023 13:24:28 +0200
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

[ Piyush: Ported from Linux kernel commit
	  b84ba26c922a ("usb: dwc3: core: add external vBus
				supply support for ulpi phy") ]

Some ULPI USB PHY does not support internal VBUS supply, to drive the CPEN
pin, which requires the configuration of the ULPI DRVVBUSEXTERNAL bit of
OTG_CTRL register.

Added 'snps,ulpi-ext-vbus-drv' a DT property to configure the USB2 PHY to
drive VBUS with an external supply, by setting the USB2 PHY ULPIEXTVBUSDRV
bit[:17] of the GUSB2PHYCFG register to drive VBUS with an external supply.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/usb/dwc3/core.c | 13 +++++++++++++
 drivers/usb/dwc3/core.h |  4 ++++
 include/dwc3-uboot.h    |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 49f6a1900b..d59bbefec4 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -529,6 +529,16 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u2_freeclk_exists_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
+	/*
+	 * Some ULPI USB PHY does not support internal VBUS supply, to drive
+	 * the CPEN pin requires the configuration of the ULPI DRVVBUSEXTERNAL
+	 * bit of OTG_CTRL register. Controller configures the USB2 PHY
+	 * ULPIEXTVBUSDRV bit[17] of the GUSB2PHYCFG register to drive vBus
+	 * with an external supply.
+	 */
+	if (dwc->ulpi_ext_vbus_drv)
+		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
 	mdelay(100);
@@ -888,6 +898,7 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 	dwc->dis_tx_ipgap_linecheck_quirk = dwc3_dev->dis_tx_ipgap_linecheck_quirk;
 	dwc->dis_enblslpm_quirk = dwc3_dev->dis_enblslpm_quirk;
 	dwc->dis_u2_freeclk_exists_quirk = dwc3_dev->dis_u2_freeclk_exists_quirk;
+	dwc->ulpi_ext_vbus_drv = dwc3_dev->ulpi_ext_vbus_drv;
 
 	dwc->tx_de_emphasis_quirk = dwc3_dev->tx_de_emphasis_quirk;
 	if (dwc3_dev->tx_de_emphasis)
@@ -1107,6 +1118,8 @@ void dwc3_of_parse(struct dwc3 *dwc)
 				"snps,dis-u2-freeclk-exists-quirk");
 	dwc->tx_de_emphasis_quirk = dev_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
+	dwc->ulpi_ext_vbus_drv = dev_read_bool(dev,
+				"snps,ulpi-ext-vbus-drv");
 	tmp = dev_read_u8_array_ptr(dev, "snps,tx_de_emphasis", 1);
 	if (tmp)
 		tx_de_emphasis = *tmp;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 532746dd88..54450842e0 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -184,6 +184,7 @@
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
+#define DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV		BIT(17)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
 #define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
 #define DWC3_GUSB2PHYCFG_PHYIF(n)	((n) << 3)
@@ -742,6 +743,8 @@ struct dwc3_scratchpad_array {
  *	1	- -3.5dB de-emphasis
  *	2	- No de-emphasis
  *	3	- Reserved
+ * @ulpi_ext_vbus_drv: Set to confiure the upli chip to drives CPEN pin
+ *			VBUS with an external supply.
  * @index: index of _this_ controller
  * @list: to maintain the list of dwc3 controllers
  */
@@ -876,6 +879,7 @@ struct dwc3 {
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
+	unsigned                ulpi_ext_vbus_drv:1;
 	int			index;
 	struct list_head        list;
 };
diff --git a/include/dwc3-uboot.h b/include/dwc3-uboot.h
index e08530ec4e..722a9352ce 100644
--- a/include/dwc3-uboot.h
+++ b/include/dwc3-uboot.h
@@ -39,6 +39,7 @@ struct dwc3_device {
 	unsigned dis_u2_freeclk_exists_quirk;
 	unsigned tx_de_emphasis_quirk;
 	unsigned tx_de_emphasis;
+	unsigned ulpi_ext_vbus_drv;
 	int index;
 };
 
-- 
2.17.1

