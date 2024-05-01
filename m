Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48666C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4134F88B86;
	Wed,  1 May 2024 04:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SPyXcFQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6F388B88; Wed,  1 May 2024 04:44:36 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E180588B43
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-69b47833dc5so23588976d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531472; x=1715136272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAB1E5rsWA6auZvkrDtuqFkPuVRYoxYzydnGjPC2lwk=;
 b=SPyXcFQnxhkLYmi85LNnW8ILm5lDaTC43hQu0L8SPNW34hNxG+fxHfnCTrn2r95VgN
 ym52UmvKCy3ovIO5meQgLSnhD+R7PEECv1L76EZpPkc8y8M78Pz0SJWg/9RehWStZ5g0
 3p7FZHXmanrNGUjDpnFkGAFtrOpgpFo78W+dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531472; x=1715136272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAB1E5rsWA6auZvkrDtuqFkPuVRYoxYzydnGjPC2lwk=;
 b=BSuT61B9tcgbmIcovjmRRpz5hhJSahijqk5WHUd/riFxG5p40J4RF+hEOdK7ucrswU
 cirqsqOgSt50b+9EIWAZwHcy9SCD62jqKYR9scfct3XZ2Kv7m7DCiASLbOTwMKq4+j1D
 H9xDghQNfu/EMNMt2XxtZycq9n6AfGWrPIsVed2BICqMoee2u8n9U/mvgD3QiEyBRFKq
 lGHHVjTVIXNscgf7JFU/qnL1/bn8ghNaTp4TnsFeOg3O+kv9C/yQ5umusu9206sO10Ff
 NOqoFK92BG9xedXIkDGoYnMMyAYaLiPy9ucclIEe7NAv/QTPL6UiIEWUIWcx8kmpigE7
 dZKA==
X-Gm-Message-State: AOJu0YycJ8keMmW/hA4IoE/yFaCuB2vMBb1OXDpGf/UjDPrtbpSm4/mP
 h6qUah2XsuBgSP0YH9g2wGI18iWAmXL5FQIYcFwgWF8kn7nYgAsjb7St6QIaVy8puF90Yh9EyGT
 J2pU1iA==
X-Google-Smtp-Source: AGHT+IGAHmJeGVQdBy0EqRXb6/0JiDgTBtpNarso2Isz+BgP4fZFRIewpyxgGgbKGwkyiYVtvU93AQ==
X-Received: by 2002:ad4:5ae7:0:b0:6a0:c914:2a07 with SMTP id
 c7-20020ad45ae7000000b006a0c9142a07mr1210323qvh.4.1714531472576; 
 Tue, 30 Apr 2024 19:44:32 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Bosch <stefan_b@posteo.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 062/149] board: friendlyarm: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:49 -0600
Message-Id: <20240501024316.1767971-62-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Bosch <stefan_b@posteo.net>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Igor Prusov <ivprusov@salutedevices.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 board/friendlyarm/nanopi2/board.c   | 1 -
 board/friendlyarm/nanopi2/hwrev.c   | 1 -
 board/friendlyarm/nanopi2/lcds.c    | 1 -
 board/friendlyarm/nanopi2/onewire.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index 393c5a447d6f..c8cbc5a15fa8 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <command.h>
 #include <fdt_support.h>
 #include <log.h>
diff --git a/board/friendlyarm/nanopi2/hwrev.c b/board/friendlyarm/nanopi2/hwrev.c
index 585e08c944f9..cd9c2414a320 100644
--- a/board/friendlyarm/nanopi2/hwrev.c
+++ b/board/friendlyarm/nanopi2/hwrev.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <i2c.h>
 #include <asm/io.h>
 
diff --git a/board/friendlyarm/nanopi2/lcds.c b/board/friendlyarm/nanopi2/lcds.c
index 7303e53af925..b37367300cf0 100644
--- a/board/friendlyarm/nanopi2/lcds.c
+++ b/board/friendlyarm/nanopi2/lcds.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <fdt_support.h>
diff --git a/board/friendlyarm/nanopi2/onewire.c b/board/friendlyarm/nanopi2/onewire.c
index 4f0b1e33c2df..31cc871330ca 100644
--- a/board/friendlyarm/nanopi2/onewire.c
+++ b/board/friendlyarm/nanopi2/onewire.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <asm/arch/clk.h>
-- 
2.34.1

