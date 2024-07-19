Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8FCC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DCB88C35;
	Fri, 19 Jul 2024 12:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PvO/XFwa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bXUO7pxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A7F88C42; Fri, 19 Jul 2024 12:50:54 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB4688C13
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKm3TK1z9spG;
 Fri, 19 Jul 2024 12:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHXO6O+dfxXDmID4l20mwJBLVT+o8JyCHwGtjIkjRfI=;
 b=PvO/XFwaA7o8Ac/pHPv8RgHBLN4qF6xmNwUZTx4GnaX/pjrQoOrEG45OUQE5ncFPnkCX2R
 AB7d0lIEnOLfsNA16QC2ps9p5U+4GAONaqqaXXc0CS6hzfuYDLgPrimh/rAq4VwO+Cl1+0
 7E0wu+6BHOGySXEzym6QSEilO7alb1bFvSJErQNBZJzAqFc2EDm0hoh4QxZD6vyfU5Y7hI
 BtCXv/Yerip1YrOG/Y7p8zd9J7LjqAU6+Z9lqRyuSmv/5TFxaPBPCtXh933KYNUS9rvBNm
 1nkC6huFchnQCpOMmbi5Idxya0JZzn++/XXQJqdJPk+xX+KP5XeIXIWR6J1iJw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHXO6O+dfxXDmID4l20mwJBLVT+o8JyCHwGtjIkjRfI=;
 b=bXUO7pxm/bY29F4fXKeutbJjDUehL6UscmGT/kaGMXqyggn8Et0dBzt0sdiX7inS5OGYdp
 DarkaMiP2eJBveKHkJqfvya1woTHBs+OzWFc4lAeEhOmPO//Q4Qmn/BCNddBqNh0szboIo
 D+bdL4L8O8DWAjXOWPrXPWUMcqBJflHPvJ47HoyvC9pA+fh4q1EgVAPXcoepNcRB9zZVfJ
 TQJWfsiVTyBpBm0FE5jW6kJKuDMRAxRAs82WDSXHiuTLeWGmfvO0ZHsX/KYF5+b6mmQBwa
 oWlP6hoAXHjEZv3SgyoDIV7vQSw5hE0sDPNxYMphx58mG//7HbC2QQ/iuni62Q==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 35/37] board: toradex: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:12 +0200
Message-ID: <20240719104948.323791-35-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b8i7xnzi53pt4yxkjbj671bxbt48yz4g
X-MBO-RS-ID: 82df640548378f553b2
X-Rspamd-Queue-Id: 4WQRKm3TK1z9spG
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/toradex/apalis_imx6/apalis_imx6.c   | 2 --
 board/toradex/colibri_imx6/colibri_imx6.c | 2 --
 board/toradex/colibri_imx7/colibri_imx7.c | 1 -
 3 files changed, 5 deletions(-)

diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index 2dcc042ab26..4a1cfb89345 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -783,7 +783,6 @@ static void ccgr_init(void)
 	writel(0x010E0101, &ccm->ccosr);
 }
 
-
 #define PAD_CTL_INPUT_DDR BIT(17)
 
 struct mx6dq_iomux_ddr_regs mx6_ddr_ioregs = {
@@ -951,7 +950,6 @@ static const struct mx6_ddr3_cfg ddr3_cfg_it = {
 	.SRT = 1,
 };
 
-
 /* Perform DDR DRAM calibration */
 static void spl_dram_perform_cal(const struct mx6_ddr_sysinfo *ddr_sysinfo)
 {
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index 34e82c2b078..251970b99cc 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -759,7 +759,6 @@ MX6_MMDC_P0_MDMISC, 0x000b17c0,
  */
 MX6_MMDC_P0_MDSCR, 0x00008000,
 
-
 /* 800mhz_2x64mx16.cfg */
 
 MX6_MMDC_P0_MDPDC, 0x0002002D,
@@ -891,7 +890,6 @@ MX6_MMDC_P0_MDMISC, 0x000b17c0,
  */
 MX6_MMDC_P0_MDSCR, 0x00008000,
 
-
 /* 800mhz_2x64mx16.cfg */
 
 MX6_MMDC_P0_MDPDC, 0x0002002D,
diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index e966ffbf781..7de29e3abfb 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -223,7 +223,6 @@ int power_init_board(void)
 	int reg, ver;
 	int ret;
 
-
 	ret = pmic_get("pmic@33", &dev);
 	if (ret)
 		return ret;
-- 
2.43.0

