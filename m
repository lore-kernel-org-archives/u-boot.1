Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E185FC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6458987EFF;
	Mon, 11 Mar 2024 18:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a49f2/u0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD3C87F9B; Mon, 11 Mar 2024 18:23:49 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D16D287FB5
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7pggQS0HlKOxLBXOCVVKru/5Dcc1Srp0DKt1mLzrArGNjTC43UE1Tghahcoew7J1a47Y8pi+xA6WvgMn6pjJxTYS7HjgIqAvy17isZE5FLY6n+H4UZfSvOY6R+nJZANixPs0VDGdaG5mWGZM93jMo1Q2oFDGDZ9ZqXXe8Nx/R3qCeIYsdN5cVFCKmpAf4eOhuUDR8u7TOvsSUql0vSDQdPc3I3WQYkp7SHH4xuxlaxkJq58OOWItcz9mVvMujdM0s6dYDQxNuHfOkWjEDjqn8ZG83CLFNAqk8pVYDUxm8fy4i/g+9f6ty+P1xqsWzG+x/YrhY1Fx0kCXwbXy5UIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=720pvoNVGLxQkjhYhEoVWB1AQYtyVt7M+ZznJPu1ToE=;
 b=K08qVP10/YXY7tw4/LPobBGuZ8qWmElvyvKontNSL4eGNWyB6AwJxh8nv+wnci84SGT5PZAY9Q565IdyiWHwpG2rEjdKVR1UjXnr/hUEZZHdgkiv5ffAfgbr8JpEtDNSa5pXCTLTcNZlubJnvcISqC6Y71mDuNzfEFo5N1s4mSC9hnNP2zNUGvKXGA80nXczP2aGSX+gW1zTCQ2C00Gkp2Ye+7rziKJTRNAWJm2IDhEqEc+pkKs1s5hTof6SwrEAM8Q+HjlhF/N4ZMEJFJvlQ5I94dnofEbVVc5PxpCESP5H0/8s8K7IrTLcRMqcEKP577SXmDFLzIg+PSdKYZG+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=720pvoNVGLxQkjhYhEoVWB1AQYtyVt7M+ZznJPu1ToE=;
 b=a49f2/u0oPyQtioCcl7Dc4wPagbewEQ6sTFveu+tMDMS78mtYKUOe7vAX3g1p084ADGE9IZcseUlYi9hCAG/cPwKm+n/uzms0TILMo6fJ/ch03TARlkQ/rfI9ZHWAKhCOQOzoEkBM2iRoangKv0uWXdSDtkTcwTCwmmIeek4Ns0=
Received: from CH2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:52::35)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:44 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::b1) by CH2PR04CA0025.outlook.office365.com
 (2603:10b6:610:52::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 10:23:42 -0700
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:41 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH 18/19] mtd: spi-nor: Enable DDR mode functionality with
 Gigadevice flash
Date: Mon, 11 Mar 2024 22:52:48 +0530
Message-ID: <9d170c76facf4278a3b0b0059455e4bf0735e497.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3dee7b-2f24-4a94-3bda-08dc41f000b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVHOibKPfrsQFWbDho22j5h6f1bsWz47JpaW+6hloJO41RJfm2M5oHu16flL6pJ5nTkXPOj+jzbcUc8m79047sucKWJBdMsiOed0H/OjHge8wg42FYLaGPx5qguLdYml4ItwuwUYeGcB1oC2gaPyI3mFMRf4wLthcoi2XssQN4KuB34IIXHBaJz1suk+qfosgbatQKIWYpAF4IljQe2Tq91ivmP3c0IZoe/CWnQV9U9D/4E9dn4peU8448Zcx2xIhjfzgZM+RuyELEjEe/G1+rWQ6WOCleJQ+e/qNmkqyyUZXSrWkLMqVKjlpimyNu6G/lz3ByQe6Akzu+pd0GAzjSCUO1AZjYAy6o9kEeCmGaFpeNkeZo70iodSFRqvVT6T4L0gYBEscnE1g27mwi+sFwXgo+wEEiuxquugdFVT7DVA5ROotrWa93U20VvROQ07Mn1vM6LdWSmORhgf4r1yITHx+UFJhXK3R0S+dWUXuudWaeYHbnykI0AMDqbIN4Zff0So39o6b+wlPe0lNg1cslZkzwqIIvoT7jQjF/ijlsd5Zxr7c3pKQUS+hg1HBnGPdO3CEpsWEVrLmJeKrYqoueDXFNsBxTI6OTaLwEt8SpfRF5qIBLjWX5909Z9bYJa+LJbHO4XLtJ6rLy6vgyk+950+RAIj4WKxD0IENBSV3E/5cMXuw+zNr8ePgDYTUSxsHc2MBH3BrAMfIsUWTiUuXEqCHgZwRSZ86fl6daIMk2twpALc/7R+23yl5T1k9jFL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:43.8780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3dee7b-2f24-4a94-3bda-08dc41f000b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
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

Enable the utilization of mt35xu512aba_fixups for GIGADEVICE
octal flash to operate in DDR mode.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 9 ++++++++-
 drivers/mtd/spi/spi-nor-ids.c  | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 27579cbf15..6b396ce681 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3977,7 +3977,7 @@ static struct spi_nor_fixups s28hx_t_fixups = {
 };
 #endif /* CONFIG_SPI_FLASH_S28HX_T */
 
-#if defined(CONFIG_SPI_FLASH_MT35XU) || defined(CONFIG_SPI_FLASH_ISSI)
+#if defined(CONFIG_SPI_FLASH_MT35XU) || defined(CONFIG_SPI_FLASH_ISSI) || defined(CONFIG_SPI_FLASH_GIGADEVICE)
 static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 {
 	struct spi_mem_op op;
@@ -4356,6 +4356,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 	}
 #endif
 
+#if defined(CONFIG_SPI_FLASH_GIGADEVICE)
+	if (!strcmp(nor->info->name, "gd25lx256e")) {
+		nor->fixups = &mt35xu512aba_fixups;
+		return;
+	}
+#endif
+
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
 	nor->fixups = &macronix_octal_fixups;
 #endif /* SPI_FLASH_MACRONIX */
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c5c46c1a0c..34fba49592 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -192,7 +192,7 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{
 		INFO("gd25lx256e", 0xc86819, 0, 64 * 1024, 512,
-		     SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)
+		     SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP)
 	},
 	/* adding these 1.8V OSPI flash parts */
 	{INFO("gd25lx512", 0xc8681A, 0, 64 * 1024, 1024,	SECT_4K |
-- 
2.27.0

