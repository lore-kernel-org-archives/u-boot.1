Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DEBC55174
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 18:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B936380EC4;
	Fri, 31 Jul 2026 18:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4G_ZnNYElzo; Fri, 31 Jul 2026 18:13:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F17680F18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785521634;
	bh=2jEp21XzvUuYo/PetHHg6TpBhqPNeV5cISPmqS51Pe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c7Tw7laE/Payin8A6Cyja4vhsjoYgi6SwYMzbQm+bxl5zxkeX7TZdmP5tWrk5+ft9
	 xxAJxhvB3pxMaHseT+z7fjgFQlB7taKe4I4Hh9MA6LpzGozOqKaR3jIS43uDE/fOeC
	 4/PDmTYQWtiEOfEtSRkjsrdEyU4keCeMOoXDnDCqe5aLW5DYbBjxXVxEi9qmtUUSqK
	 0C7tt6m/M41rxduFGHSrJwkUYhPHIBi5M36Ze0vP2WzgkYfACn/B+yypn/rF4iXTO8
	 hLpY8QIMbeHgrdGn9Ep5aPi+jV+i1aOXFiti39B9u3rUF3yJSoIfdH9Tp+uKEKUTNK
	 THvl4ptOc8ewg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F17680F18;
	Fri, 31 Jul 2026 18:13:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AE0F37F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CE9840FD4
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JGQx8OS8ILNN for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 18:11:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=smtong@axiado.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DC8A040F89
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC8A040F89
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC8A040F89
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E4FD805D7; Fri, 31 Jul 2026 20:11:10 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C5B84A1A
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 20:11:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyLsblEoXgbDsG6CaQU+2qZXCYcvrvSDPQEDoc9uiIdT0cpzQudjpeRmPaNNdZoDIapd31mSPVi5/LurUVzA5GcmdxOtcRjDC2wkrn6Ru1pszjoK+Pi6pSCSbpqzMal8onG6s5nrC1d8VFQ0AEDhP/pPGVETnKWo08dS5Lha1hsi/mCOIYpSq6regHbjixNUL+bjULQEHzvlTqcUSG8q7Q/XiaqDJ2qCe3WIT3rY4LCTQak9Ke1oJ2JdllwCZ1o1AIx5LDT9gdyhuJLR2YDEc+P/m89JFv251AwuzDd9tc0nE2Ch2s3BNvxrlbyuZ05W+5TrNxKhlW3Zodw/kEdHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jEp21XzvUuYo/PetHHg6TpBhqPNeV5cISPmqS51Pe8=;
 b=p3fQQl8UdlxERfagM9t+BlpzU1BlixqPixuiyLg8KZ7Ton8KFIUld67UrVkwhdjskQdKLBCM/9sXlasWkA/ER2VdL5OSgvi/nG359D8DNCl4MsX+l82o1rLeysITcT25nkB/bI6XzEsOkLhnzHj5RvhcY0UmYS8g2yohhpDi4fI1z/sa2zZVc8iU8jOwqSu0hCdqsDkUh6gRMy1buBYPB12IwgTFAy4I8YYAzhpriNNIh62VbDa7yx1vpzn1HK0XrrflNajJzXq6QulzvO4OyNZKXMGXGj4grLUkG48coRA5GgHbUkSV0Cg+Wl1fhqCDNvgHcqdArVwyiKiJxAf/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 BY1PR18MB5875.namprd18.prod.outlook.com (2603:10b6:a03:4ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:10:57 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::88) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 18:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Fri, 31 Jul 2026 18:10:56 +0000
Received: from [127.0.1.1] (unknown [10.4.1.117])
 by smtp.corp.axiado.com (Postfix) with ESMTP id D1CD04186B58;
 Fri, 31 Jul 2026 11:10:55 -0700 (PDT)
From: Siu Ming Tong <smtong@axiado.com>
Date: Fri, 31 Jul 2026 11:10:49 -0700
Subject: [PATCH 1/4] phy: Add Axiado eMMC PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dev-scm3005-v1-1-30bea90ac5f7@axiado.com>
References: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
In-Reply-To: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Siu Ming Tong <smtong@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8015; i=smtong@axiado.com;
 h=from:subject:message-id; bh=vdF0ibUhQY7lL6RszlQQxB2EKjyoPakz6gFK/ULRpuU=;
 b=owEB7QES/pANAwAKAXwcqHIUQvOOAcsmYgBqbOUu+N/6P5jNLBmgXcyjNNPPImrXy8yszpMYj
 wH3D/Tq9Q6JAbMEAAEKAB0WIQR3Lze7GwS3XzAkT0h8HKhyFELzjgUCamzlLgAKCRB8HKhyFELz
 jjiZDACbqaxAsaDQiE3BXGgLCftHad5kLhzs2PZ4vT+BD7HgreXH+Kb+6axG7STYrmwQBYykkX8
 6zgPMx0/EacRRateUfCAxcfafaDGPzWK9EkDjF+H6EhBETCqGkwwrhYBC66HBndouTYBWwliqxM
 W2zOpRYOVX/fztVRR/9cKbbk3k0wGDxJ3Ef4gJUrSswZI0w9+Nm8xBmXver5YKeKgDS0szg6F4V
 2p+9IvN/TlLRiORQ2ENeoBMLOA9KW8xOsHnJLe8ZmqJm0sAqdSjOk00TvoAoUhILfZLd9Q/q6FT
 Qzr8nueD8A5dd0qEwjuA4rKjCGJ33AJrQ7uTAiNNXBXlfeCnHkO/kz+goNUo57csBYEwf/MSLIY
 yAF3tcFXE11H+2K+A1HmqLMHrVKiOPPllq6RFsyayccQBGEOCHSa3dfTANqypbynC20g5fVB4/E
 yYYjspOMXZFISStIO+hNiZR9H7q1bhfaL43zv6ihyR7GpZXn0IDxRTcrmp+85blk9lQ8s=
X-Developer-Key: i=smtong@axiado.com; a=openpgp;
 fpr=772F37BB1B04B75F30244F487C1CA8721442F38E
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|BY1PR18MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8c8a60-20ed-4314-64d7-08deef2f1161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gVHwSSxYHMFNvvBTLst46T1n+C+qnB6O++iUcG7/rNWQEoC/UUc8Ow9WLZJMV/fDrOSItarIxsfA2izufTHaOkxntiOSa+p/jtWcx1ZjOz2qga1sF36Hvrs4R/rN5za6vNOrz83WHIwrDVN8McDbX+RaoIjwgF1JUwAxf2Lrki7qVkV1h9mUve0eRskF39KKy1yNfgC7W8gFCkU/c2o2vrb5GOaI3pt/BoynpSw/7nNFXZdOBgk/ieXNuCI4zpKp05FHoesK5UY0yL551sdVpZVSaZDNyOqy6J98qJJuVtcObUWF063Cysl/63jfr14ODR9WLvk05SZoKAaDDg8DpCAf7/JEQjyb2f0UPtHS6aQoCGxVNBuWufnJ3SqjbOCnDhiCIjmHlm23doFU7YmL+WMfSj6HGgMsqyLRPZnsLh/Cq2Dmgr3T9x90d6aErjkc+U2e3Ow5zs4UewCy8ESqH8/QxhfXmqilBsyEMv90CMXmnfRb3zZnJ/STmC1U+ZEHt1mdf78UcHWUMGxvcQ4Y8/RBMlQW7v3NiNZP0MD6v+7Uopdi7KKFShmMyiI0xLzVS9y5f62iIKaJaHgs2kWYyyBiLVVn1GOUdy6b9+/efSo9p2gtyRyGIqy4btf5PDruAk9JjKQCbtzOuBS7IJYczTw3nmVeneNNcKgtsZH/8CfVdN4RaVbXBbabv+HlLfMjfH1G6c6rPc7f302M2j3mOw==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S4Bi8U9zDTlujhHlpalnzEhmr8YQkK79MqRF3ciZz3JtdYjtvtnaHJEs3Y8PkE+SghZpVdx+pBnLjQvcIi7QtWVAHW6KeVI/q7zHzumUOOAKQzE3P7ef7aqX7Nlk3JS5KNQvq9i4S+IXx9QBJA6J4c1hFJRYYQ5pU6RnyUj4/0b5UwRmsL5LtrshK/mp9bJfyU5yO61F6UpgoOQjlu/2fbN3rKEBrTf3tMrzrlevtKpQRgFfCSZVHkHOKop0QwFNU7KUT9vp1ZVyjlqwTp1cOtB6na3dofdYWzjl3qCSpKJ+F9RgsfuyCwRGbEIdn+KACfejXih1kp1Ax9hHByJAfKpgAejv3UWmjYy074lEkjsEoXzednm2cy6yNtwBzq4vUsAsD16MtyqND04VVixnQjykF/2+X6g8/4ztQ1hNau9H8Sad2Tn7bXEi8x8n6jnV
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:10:56.4559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8c8a60-20ed-4314-64d7-08deef2f1161
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5875
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 18:13:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axiado.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jEp21XzvUuYo/PetHHg6TpBhqPNeV5cISPmqS51Pe8=;
 b=mkL9fFkeTnxi0tyEpF50W1k1YnNUyszZV8CrGAgjk7MqjfQlmAyd87HwVoQ0MaUiZJk1X+3vp+VHi1UMu9zJVNRirgfLyP/UBL/Fj1so/3KI/lFo38k2a/n3FO3FyC4qEeir307av1wz1Rhqr5XT8AykIb41yFDpFFHAcG4DnghuJ55lVlKog3nfqU6HTOjwSwUSndrikC89AFjdqJPSKLdy6pm81oGBkU+CqD8pda2QYs1pV/uxEIxsL93usc6ipajdNAlsktlPz6OcWraTjjIOXKSGWwQXEGmQqyb4UXrkRfTq9I9HVQIHzmL/UFb9QfL9lIT0AwHyZa29Pee6gg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256
 header.s=selector1 header.b=mkL9fFke
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=smtong@axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=axiado.com header.i=@axiado.com header.b="mkL9fFke"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a PHY driver (PHY_AXIADO_EMMC) for the eMMC PHY found on the Axiado
AX3005 SoC. The PHY provides signal conditioning and DLL functionality
required for high-speed eMMC operation with data rates beyond 52MHz.

The driver is based on the Arasan PHY (sdhci-pci-arasan.c) and programs
the calibration, DLL and clock-buffer settings through a memory-mapped
regmap.

Signed-off-by: Siu Ming Tong <smtong@axiado.com>
---
 MAINTAINERS                   |   1 +
 drivers/phy/Kconfig           |   9 ++
 drivers/phy/Makefile          |   1 +
 drivers/phy/phy-axiado-emmc.c | 208 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e53cb0a485c..eece4e5ebd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -232,6 +232,7 @@ F:	arch/arm/dts/ax3005*
 F:	arch/arm/mach-axiado/
 F:	board/axiado/scm3005/
 F:	configs/ax3005_scm3005_defconfig
+F:	drivers/phy/phy-axiado-emmc.c
 F:	include/configs/ax3005-scm3005.h
 
 ARM BROADCOM BCM283X / BCM27XX
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 89d84df96ae..16eaa67fd02 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -81,6 +81,15 @@ config APPLE_ATCPHY
 	  This is a dummy driver since the PHY is initialized
 	  sufficiently by previous stage firmware.
 
+config PHY_AXIADO_EMMC
+	bool "Axiado eMMC PHY driver support"
+	depends on PHY
+	imply REGMAP
+	help
+	  Enable this to support the Axiado eMMC PHY found in the Ax3005 SoC.
+	  This PHY provides signal conditioning and DLL functionality for
+	  high-speed eMMC operations with data rates beyond 52MHz.
+
 config BCM6318_USBH_PHY
 	bool "BCM6318 USBH PHY support"
 	depends on PHY && ARCH_BMIPS
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index e46c362878d..7ad0bd59407 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_OMAP_USB2_PHY) += omap-usb2-phy.o
 obj-$(CONFIG_KEYSTONE_USB_PHY) += keystone-usb-phy.o
 obj-$(CONFIG_MT7620_USB_PHY) += mt7620-usb-phy.o
 obj-$(CONFIG_MT76X8_USB_PHY) += mt76x8-usb-phy.o
+obj-$(CONFIG_PHY_AXIADO_EMMC) += phy-axiado-emmc.o
 obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
diff --git a/drivers/phy/phy-axiado-emmc.c b/drivers/phy/phy-axiado-emmc.c
new file mode 100644
index 00000000000..a151557a0ec
--- /dev/null
+++ b/drivers/phy/phy-axiado-emmc.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Axiado eMMC PHY driver
+ *
+ * Copyright (C) 2017 Arasan Chip Systems Inc.
+ * Copyright (C) 2022-2026 Axiado Corporation (or its affiliates).
+ *
+ * Based on Arasan Driver (sdhci-pci-arasan.c)
+ * sdhci-pci-arasan.c - Driver for Arasan PCI Controller with integrated phy.
+ */
+
+#include <dm.h>
+#include <generic-phy.h>
+#include <regmap.h>
+#include <time.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+
+/* Axiado eMMC PHY configuration registers */
+#define CAP_REG_IN_S1_LSB 0x00
+#define CAP_REG_IN_S1_MSB 0x04
+#define PHY_CTRL_1 0x38
+#define PHY_CTRL_2 0x3C
+#define PHY_CTRL_3 0x40
+#define STATUS 0x50
+
+/* PHY Control 1 Register bits */
+#define DLL_ENBL BIT(26)
+#define RTRIM_EN BIT(21)
+#define PDB_ENBL BIT(23)
+#define RETB_ENBL BIT(1)
+
+#define REN_STRB BIT(27)
+#define REN_CMD_EN GENMASK(20, 12)
+
+/* Pull-UP Enable on CMD Line */
+#define PU_CMD_EN GENMASK(11, 3)
+
+/* PHY Control 2 Register bits */
+#define OTAPDLY_EN BIT(11)
+
+/* PHY Control 3 Register bits */
+#define SEL_DLY_RXCLK BIT(18)
+#define SEL_DLY_TXCLK BIT(19)
+
+/* Status Register bits */
+#define CALDONE_MASK 0x40
+#define DLL_RDY_MASK 0x1
+
+/* Clock buffer bits */
+#define MAX_CLK_BUF0 BIT(20)
+#define MAX_CLK_BUF1 BIT(21)
+#define MAX_CLK_BUF2 BIT(22)
+
+/* Other constants */
+#define CLK_MULTIPLIER 0xC008E
+#define LOOP_TIMEOUT 3000
+#define TIMEOUT_DELAY 100
+
+struct axiado_emmc_phy {
+	struct regmap *regmap;
+};
+
+static int axiado_emmc_phy_init(struct phy *phy)
+{
+	u32 val;
+	unsigned long timeout;
+	struct axiado_emmc_phy *ax_phy = dev_get_priv(phy->dev);
+
+	regmap_read(ax_phy->regmap, PHY_CTRL_1, &val);
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_1, RETB_ENBL | RTRIM_EN,
+			   RETB_ENBL | RTRIM_EN);
+
+	regmap_read(ax_phy->regmap, PHY_CTRL_3, &val);
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_3, PDB_ENBL, PDB_ENBL);
+
+	/* Wait max 3000 ms */
+	timeout = get_timer(0);
+
+	while (1) {
+		regmap_read(ax_phy->regmap, STATUS, &val);
+		if (val & CALDONE_MASK)
+			break;
+
+		if (get_timer(timeout) > LOOP_TIMEOUT) {
+			dev_err(phy->dev,
+				"eMMC-PHY: CALDONE_MASK bit not cleared.\n");
+			return -ETIMEDOUT;
+		}
+		udelay(TIMEOUT_DELAY);
+	}
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_1, REN_CMD_EN | PU_CMD_EN,
+			   REN_CMD_EN | PU_CMD_EN);
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_2, REN_STRB, REN_STRB);
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_3,
+			   MAX_CLK_BUF0 | MAX_CLK_BUF1 | MAX_CLK_BUF2,
+			   MAX_CLK_BUF0 | MAX_CLK_BUF1 | MAX_CLK_BUF2);
+
+	regmap_write(ax_phy->regmap, CAP_REG_IN_S1_MSB, CLK_MULTIPLIER);
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_3,
+			   SEL_DLY_RXCLK | SEL_DLY_TXCLK,
+			   SEL_DLY_RXCLK | SEL_DLY_TXCLK);
+
+	return 0;
+}
+
+static int axiado_emmc_phy_power_on(struct phy *phy)
+{
+	struct axiado_emmc_phy *ax_phy = dev_get_priv(phy->dev);
+	u32 val;
+	unsigned long timeout;
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_1, RETB_ENBL, RETB_ENBL);
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_3, PDB_ENBL, PDB_ENBL);
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_2, OTAPDLY_EN | (0xF << 7),
+			   OTAPDLY_EN | ((0x2) << 7));
+
+	/* Read back to ensure write is completed */
+	regmap_read(ax_phy->regmap, PHY_CTRL_2, &val);
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_1, DLL_ENBL | (0xF << 22),
+			   DLL_ENBL | ((0x8) << 22));
+
+	regmap_write(ax_phy->regmap, STATUS, 0x00);
+
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_3, (0x1 << 25),
+			   (0x1 << 25));
+
+	/* Wait max 3000 ms */
+	timeout = get_timer(0);
+
+	while (1) {
+		regmap_read(ax_phy->regmap, STATUS, &val);
+		if (val & DLL_RDY_MASK)
+			break;
+
+		if (get_timer(timeout) > LOOP_TIMEOUT) {
+			dev_err(phy->dev,
+				"eMMC-PHY: DLL_RDY_MASK bit not cleared.\n");
+			return -ETIMEDOUT;
+		}
+		udelay(TIMEOUT_DELAY);
+	}
+	return 0;
+}
+
+static int axiado_emmc_phy_power_off(struct phy *phy)
+{
+	struct axiado_emmc_phy *ax_phy = dev_get_priv(phy->dev);
+
+	/* Disable DLL */
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_1, DLL_ENBL, 0);
+
+	return 0;
+}
+
+static int axiado_emmc_phy_exit(struct phy *phy)
+{
+	struct axiado_emmc_phy *ax_phy = dev_get_priv(phy->dev);
+
+	/* Disable all PHY features */
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_1,
+			   DLL_ENBL | RETB_ENBL | RTRIM_EN, 0);
+	regmap_update_bits(ax_phy->regmap, PHY_CTRL_3, PDB_ENBL, 0);
+
+	return 0;
+}
+
+static const struct phy_ops axiado_emmc_phy_ops = {
+	.init = axiado_emmc_phy_init,
+	.power_on = axiado_emmc_phy_power_on,
+	.power_off = axiado_emmc_phy_power_off,
+	.exit = axiado_emmc_phy_exit,
+};
+
+static int axiado_emmc_phy_probe(struct udevice *dev)
+{
+	struct axiado_emmc_phy *ax_phy = dev_get_priv(dev);
+	int ret;
+
+	ret = regmap_init_mem(dev_ofnode(dev), &ax_phy->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id axiado_emmc_phy_ids[] = {
+	{ .compatible = "axiado,ax3005-emmc-phy" },
+	{}
+};
+
+U_BOOT_DRIVER(axiado_emmc_phy) = {
+	.name = "axiado_emmc_phy",
+	.id = UCLASS_PHY,
+	.of_match = axiado_emmc_phy_ids,
+	.ops = &axiado_emmc_phy_ops,
+	.probe = axiado_emmc_phy_probe,
+	.priv_auto = sizeof(struct axiado_emmc_phy),
+};

-- 
2.34.1

