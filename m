Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCA0C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC7E88A15;
	Wed, 24 Jul 2024 17:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DOTHJQ5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D6B388998; Wed, 24 Jul 2024 17:10:10 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC31E889F6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3970f9331deso28078075ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833805; x=1722438605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak6hg46T3kWmRyjqQXB4c5T9u+Frmz5W1bwnKW+EREI=;
 b=DOTHJQ5Pgi2UWf4OghMLfmqWWZBvl7nCS1IeESz5fioHrWGOBYp3ZJO3BBiAPzUHuv
 QrYXv3YSps141zOYgBiaKmMr1OEeOTBjx/p5dlSou44yH4HjVmvDif/BNJJSN8jjQGQ2
 +EFx+S2CHJmCbcsXP5f8tUcuLZxghVpac3XP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833805; x=1722438605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ak6hg46T3kWmRyjqQXB4c5T9u+Frmz5W1bwnKW+EREI=;
 b=DrVZku1jGlPksa97PbDeJhqoVUluIrg1JSJDW3Jh4k3QfrX6KoijdIk9o87yNEULXf
 fDHft/NVlEJqEtY/xZWw/lrGEcZIsRtZTXkoM+gY5um/O/fJjiQ+yT75OfL4/+hEtRC6
 3f86evrkH8+vQz3QNVLaEg9NU+FJZZE3tLkLLroqrRmUYIu75VqIRoFCQvmL0qvKKEHX
 Vy/39e/xzojQJVsbQySvj3X0vbLhCNFvg6VED+IiVOXONxOV97mgGSOe0VtrFs6oYjlx
 oMnVWkdX2s5uet/5U1/pLJfSCJMX4vVFxPWg6M9xUBICeQNHDSUJUOWaz+y70NB0boV3
 nVuA==
X-Gm-Message-State: AOJu0YxtrjvtQoTc7DEKHBLbzRUhXtC/USwhY0wD2BtE9Tb70HtpoPLf
 I45NPIarCGma7H3RvkIhoJdlQcBKZ5fugD0K/UdjEwJtIukoshRPb1nLEpo6b3Yf6dtGOSqeb2E
 =
X-Google-Smtp-Source: AGHT+IG0raz0chjAlzy4puRPDygI19J8Gjtxt7VkPQ9oiXgbaA4WFhyPW2PYdP/pZFCwD/MILtXgXQ==
X-Received: by 2002:a92:c24d:0:b0:39a:16f7:f9d3 with SMTP id
 e9e14a558f8ab-39a16f7fbd1mr37331475ab.9.1721833805557; 
 Wed, 24 Jul 2024 08:10:05 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 32/35] global_data: Remove jump table in SPL
Date: Wed, 24 Jul 2024 09:09:19 -0600
Message-Id: <20240724150922.2343249-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

SPL builds don't use the jump table since they cannot run apps. Drop
it, moving it together with boardf.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/freescale/ls2080ardb/eth_ls2080rdb.c |  2 +-
 common/console.c                           |  3 ++-
 include/asm-generic/global_data.h          | 10 +++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/board/freescale/ls2080ardb/eth_ls2080rdb.c b/board/freescale/ls2080ardb/eth_ls2080rdb.c
index 44d9782d729..7fc4fecf774 100644
--- a/board/freescale/ls2080ardb/eth_ls2080rdb.c
+++ b/board/freescale/ls2080ardb/eth_ls2080rdb.c
@@ -12,7 +12,7 @@ DECLARE_GLOBAL_DATA_PTR;
 int board_eth_init(struct bd_info *bis)
 {
 
-#ifdef CONFIG_PHY_AQUANTIA
+#if defined(CONFIG_PHY_AQUANTIA) && !defined(CONFIG_SPL_BUILD)
 	/*
 	 * Export functions to be used by AQ firmware
 	 * upload application
diff --git a/common/console.c b/common/console.c
index 30ddefef6b1..f39821385bb 100644
--- a/common/console.c
+++ b/common/console.c
@@ -189,6 +189,7 @@ static int console_setfile(int file, struct stdio_dev * dev)
 		/* Assign the new device (leaving the existing one started) */
 		stdio_devices[file] = dev;
 
+#ifndef CONFIG_SPL_BUILD
 		/*
 		 * Update monitor functions
 		 * (to use the console stuff by other applications)
@@ -206,7 +207,7 @@ static int console_setfile(int file, struct stdio_dev * dev)
 			break;
 		}
 		break;
-
+#endif
 	default:		/* Invalid file ID */
 		error = -1;
 	}
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index f6d1ee1d57a..18d21de6237 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -50,6 +50,11 @@ struct global_data {
 	 * @fdt_blob: U-Boot's own device tree, NULL if none
 	 */
 	const void *fdt_blob;
+	/**
+	 * @cur_serial_dev: current serial device
+	 */
+	struct udevice *cur_serial_dev;
+#ifndef CONFIG_SPL_BUILD
 	/**
 	 * @jt: jump table
 	 *
@@ -57,11 +62,6 @@ struct global_data {
 	 * the jump table is passed to standalone applications.
 	 */
 	struct jt_funcs *jt;
-	/**
-	 * @cur_serial_dev: current serial device
-	 */
-	struct udevice *cur_serial_dev;
-#ifndef CONFIG_SPL_BUILD
 	/**
 	 * @boardf: information only used before relocation
 	 */
-- 
2.34.1

