Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCECC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC3A88BC2;
	Fri, 19 Jul 2024 12:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BzQCyK3r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ltc5NaYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB3688B90; Fri, 19 Jul 2024 12:50:26 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCD487E96
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRKD00m8z9skR;
 Fri, 19 Jul 2024 12:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlMWaxvb+kO2x0aRuu7nrmTHw8gWfha3ZvhfvPdcm4E=;
 b=BzQCyK3rtd9jpSWWWot2sB3308TwwGDideAfV0bmJ0FFdL9e0RfsAL1wEPpg8+8tSmO/mC
 JPNBWM6hgGD0dQ2IBQ/CLXMGlcgyjKowYyZUY0QWf6+jIQMuY/iIRiSjkN0TAcS7BQZT3U
 bQwMTI3xsXLWKd8BCYFsFoZDINbnHzV8tt503fIO9b5iZvE3U9PIO+OGy6AgMFCGpsHAPr
 l4IAYpvBUZ2kXbKcd/9OT1zxhC4A/kxCroaXY7uZ4M5MT7JMD02uPs22JtYdEQmBIrU/jG
 7ihBP/u4dAjlE6SQ5g+di5QjX7hV6tI9+MKPV0DACulkEuR8cvkTzAqgqGISHA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlMWaxvb+kO2x0aRuu7nrmTHw8gWfha3ZvhfvPdcm4E=;
 b=Ltc5NaYR5KwhuY860IVfK8rdRqMIGzNPjLhvFwYg2w5bP8oZDipSkLfAQEfwHO7Ki7VdME
 rcHSvDYIRTEu0ymIrHONn0B9j34PeAZo1SPJyJSXC5udjCZiLZ7F1MUt0mxOPN1o6RoOTw
 /NPwDfnM1nOjfkoEY+lJrLv+xhSA82ewISjzVMa/mhpEy8/Jzn6wGMsFEYdv0/7UXKb+vV
 cDhk+A1zgzu0QEUF5vlc3K7AODuqU8T9aq1gzZL2O3YKY7yCW6jmrhIV5S1Vcf9vZ6OTwi
 Nf1QCcLkLLdu/lrTXydrT27mtwDkRLXXLJa3l2vWWU2k4xnZubjnK9cytILbcQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/37] board: compulab: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:45 +0200
Message-ID: <20240719104948.323791-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d05114db8d28104abb7
X-MBO-RS-META: wmh1hpffhnj6zbygkjowrukxa9158p9h
X-Rspamd-Queue-Id: 4WQRKD00m8z9skR
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
 board/compulab/cm_fx6/cm_fx6.c | 1 -
 board/compulab/cm_fx6/common.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/compulab/cm_fx6/cm_fx6.c b/board/compulab/cm_fx6/cm_fx6.c
index 4a6cc3e5630..c6d33c32ccd 100644
--- a/board/compulab/cm_fx6/cm_fx6.c
+++ b/board/compulab/cm_fx6/cm_fx6.c
@@ -252,7 +252,6 @@ I2C_PADS(i2c2_pads,
 	 PAD_GPIO_6__GPIO1_IO06 | MUX_PAD_CTRL(I2C_PAD_CTRL),
 	 IMX_GPIO_NR(1, 6));
 
-
 static int cm_fx6_setup_one_i2c(int busnum, struct i2c_pads_info *pads)
 {
 	int ret;
diff --git a/board/compulab/cm_fx6/common.h b/board/compulab/cm_fx6/common.h
index debef15880f..17b56ddc283 100644
--- a/board/compulab/cm_fx6/common.h
+++ b/board/compulab/cm_fx6/common.h
@@ -31,6 +31,5 @@
 #define CM_FX6_SATA_NRSTDLY	IMX_GPIO_NR(6, 6)
 #define CM_FX6_SATA_PWLOSS_INT	IMX_GPIO_NR(6, 31)
 
-
 void cm_fx6_set_usdhc_iomux(void);
 void cm_fx6_set_ecspi_iomux(void);
-- 
2.43.0

