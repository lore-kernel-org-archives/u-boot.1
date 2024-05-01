Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9B6C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03DC88ABC;
	Wed,  1 May 2024 04:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mMIToLeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBA488AD2; Wed,  1 May 2024 04:43:45 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6464388AAD
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6a0badb6892so15244596d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531422; x=1715136222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aS6gw3NHEs2PGjYW/dNjeQ4UDt5avUPSk1+M47kx59U=;
 b=mMIToLeLi0pnsncXOHvHUXKDVuebNQVDDSThi8Grdu104sveWv6wxcQXvyAF0yaII8
 dcip/kyutzp/kkaR9yFbB+3/5Cgoooq0IBO/aQ7olgCVi75jmfX9x2toHErZy5PYTU15
 GEuT3TPMg6GGjEWV8r2pALfw4D4GErqGHC47U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531422; x=1715136222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aS6gw3NHEs2PGjYW/dNjeQ4UDt5avUPSk1+M47kx59U=;
 b=T4CedHgWKTYQxBYLkw9GDwPd06l9CLp96BghlNWyQoFLRi2lRmMyFR+2QWt6o7TkuQ
 H5AxSB6IGeQkQgskQV6ltHy3g07KHdJ0d3xnS9TgiYw5acAFjcR28WBYFuz34T8BROxw
 5Jq1lkfnXdjN6dheaPs4T1zAbiD8RpvbXAv5PpUcxKpdw/HtaO6mc8mABLZFKS/FH1x4
 dkl3iS0FW6ZSKSO3D4jJ320WlSzFwnt+me6bExrIsUQtESepOvA6QGJ9kIgSo/AfkouY
 pjQRb3Zu8rjFfz4AWtN1N6ekInoCSYl5jexDER5CWV6Ci5pRdxdUH7+IlV7IKOC5Xf7e
 JbAQ==
X-Gm-Message-State: AOJu0YzGPHMLEMIGzJxHUm+7tB0hXphcsG2vmrWcmVvXE/6LGcEHZNnj
 7X9tGXuBMkLHr754oLLLCtKkISDVwuyGz21nHMh8BKxufehGwx4OZ5O7e46aQaxeRiNClF+FPQD
 Vg0INqw==
X-Google-Smtp-Source: AGHT+IHEFEK4v/YiY+0GqthFqWkSsue+YLsZTGe8hGRAyxY7/yeI/GlzC+RkmM2imp1MUffVy7cuMw==
X-Received: by 2002:a05:6214:260b:b0:6a0:cef7:c54d with SMTP id
 gu11-20020a056214260b00b006a0cef7c54dmr1477008qvb.56.1714531422079; 
 Tue, 30 Apr 2024 19:43:42 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Wolfgang Wegner <w.wegner@astro-kom.de>
Subject: [PATCH 020/149] board: astro: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:07 -0600
Message-Id: <20240501024316.1767971-20-trini@konsulko.com>
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
Cc: Wolfgang Wegner <w.wegner@astro-kom.de>
---
 board/astro/mcf5373l/fpga.c     | 1 -
 board/astro/mcf5373l/mcf5373l.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/astro/mcf5373l/fpga.c b/board/astro/mcf5373l/fpga.c
index f85737432b31..6e505c630d12 100644
--- a/board/astro/mcf5373l/fpga.c
+++ b/board/astro/mcf5373l/fpga.c
@@ -13,7 +13,6 @@
 
 /* Altera/Xilinx FPGA configuration support for the ASTRO "URMEL" board */
 
-#include <common.h>
 #include <console.h>
 #include <watchdog.h>
 #include <altera.h>
diff --git a/board/astro/mcf5373l/mcf5373l.c b/board/astro/mcf5373l/mcf5373l.c
index 43563c412793..43fcbc65513d 100644
--- a/board/astro/mcf5373l/mcf5373l.c
+++ b/board/astro/mcf5373l/mcf5373l.c
@@ -5,9 +5,10 @@
  * modified by Wolfgang Wegner <w.wegner@astro-kom.de> for ASTRO 5373l
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <serial.h>
+#include <time.h>
 #include <watchdog.h>
 #include <command.h>
 #include <asm/global_data.h>
-- 
2.34.1

