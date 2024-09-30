Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E441CCF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E9C88ED0;
	Mon, 30 Sep 2024 03:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dS8BxjuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF3588DB9; Mon, 30 Sep 2024 03:50:37 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3160788E7E
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso12626445ab.3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661034; x=1728265834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXY1elNWWY4xpCmHbihcDmsO3yL/jsb2TutzUlPc4J8=;
 b=dS8BxjuP0FglHTwY5K2Z8P2NrhThFMNqzOpoZ5rahvsW06TUuu8foY01L/jLd9NFY+
 172vsWAkHQg4B+6SW/tdBMq5G2UauUUWaIP/bY5dT6WAJgBitjEtVVV0h92Ojjv8X5hD
 2JjEcpbzBFlBChLGVVqpFw+AXr9KVJHZULnGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661034; x=1728265834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DXY1elNWWY4xpCmHbihcDmsO3yL/jsb2TutzUlPc4J8=;
 b=gUZo87dFSSbygXdGfu/EmWQ13NdL/YSYeY/13b0B+Khj98/GXvCpOGWgFSPqlo2/Fu
 mSiCOC4Ce7m3WLSkWm0tNxP0a0rXCnEkwCrmiVpdVgW4K/sVyKPpLp9/jDdxaSj/GLvL
 zyWd3+6wPhDrzyj6tGKx81RQDqF9O26HP0vVW+zkfSXyLd8czbIi/+cWeor3yejKuxTh
 eKSO8Z0vk+IsXPAVq5ocFNsRD76qBVnZcQjnevv6KGSBzdS24+RkJJ9KDh2CDTWhtVS+
 Aj++C1bQerXO5zORpKG2+0hS5Y6M3NKOKaSxHYEuFHePdz3T0Skt0lOGVsMpzbSbb1Bt
 AEUQ==
X-Gm-Message-State: AOJu0Yyq+Dp9jvyZiDK2wyxLAEYPWXLEKyAu/q1esETEyTal7juzhV6R
 Uapqdo/m/PWv1UdTC8iIcJg1Mp7eOiaknDlBGN5P8V/Pf4CvXK5fEUUHrgSFg2K8+kDNKmm4KUI
 RLg==
X-Google-Smtp-Source: AGHT+IHrY35/xmuH1Y5Ktjp8pHEA5vvVpWKaq3A4W7IERy0/AsyE63fzIlH961uXhn68jeBHtQJUwA==
X-Received: by 2002:a05:6e02:1388:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-3a344fc8b3amr86825255ab.0.1727661033693; 
 Sun, 29 Sep 2024 18:50:33 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 22/33] doc: Update init docs for the xPL changes
Date: Sun, 29 Sep 2024 19:49:45 -0600
Message-Id: <20240930014956.1434060-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Update the documentation here to cover the meaning of xPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/develop/init.rst | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/doc/develop/init.rst b/doc/develop/init.rst
index 2955d9bdbc3..ce985781bb4 100644
--- a/doc/develop/init.rst
+++ b/doc/develop/init.rst
@@ -4,15 +4,16 @@ Board Initialisation Flow
 -------------------------
 
 This is the intended start-up flow for boards. This should apply for both
-SPL and U-Boot proper (i.e. they both follow the same rules).
+xPL and U-Boot proper (i.e. they both follow the same rules).
 
-Note: "SPL" stands for "Secondary Program Loader," which is explained in
-more detail later in this file.
+Note: "xPL" stands for "any Program Loader", including SPL (Secondary
+Program Loader), TPL (Tertiary Program Loader) and VPL (Verifying Program
+Loader). The boot sequence is TPL->VPL->SPL->U-Boot proper
 
-At present, SPL mostly uses a separate code path, but the function names
+At present, xPL mostly uses a separate code path, but the function names
 and roles of each function are the same. Some boards or architectures
 may not conform to this.  At least most ARM boards which use
-CONFIG_SPL_FRAMEWORK conform to this.
+CONFIG_xPL_FRAMEWORK conform to this.
 
 Execution typically starts with an architecture-specific (and possibly
 CPU-specific) start.S file, such as:
@@ -48,7 +49,7 @@ board_init_f()
 
 Non-xPL-specific notes:
 
-    - dram_init() is called to set up DRAM. If already done in SPL this
+    - dram_init() is called to set up DRAM. If already done in xPL this
       can do nothing
 
 xPL-specific notes:
@@ -68,9 +69,9 @@ xPL-specific notes:
     - must return normally from this function (don't call board_init_r()
       directly)
 
-Here the BSS is cleared. For SPL, if CONFIG_SPL_STACK_R is defined, then at
+Here the BSS is cleared. For xPL, if CONFIG_xPL_STACK_R is defined, then at
 this point the stack and global_data are relocated to below
-CONFIG_SPL_STACK_R_ADDR. For non-SPL, U-Boot is relocated to run at the top of
+CONFIG_xPL_STACK_R_ADDR. For non-xPL, U-Boot is relocated to run at the top of
 memory.
 
 board_init_r()
@@ -82,11 +83,11 @@ board_init_r()
     - BSS is available, all static/global variables can be used
     - execution eventually continues to main_loop()
 
-Non-SPL-specific notes:
+Non-xPL-specific notes:
 
     - U-Boot is relocated to the top of memory and is now running from
       there.
 
-SPL-specific notes:
+xPL-specific notes:
 
-    - stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined
+    - stack is optionally in SDRAM, if CONFIG_xPL_STACK_R is defined
-- 
2.34.1

