Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86648C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B06ED88962;
	Mon,  5 Aug 2024 15:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mmarCtxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A422B888F0; Mon,  5 Aug 2024 14:43:38 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACE388901
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 14:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b79b93a4c9so47189046d6.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722861815; x=1723466615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXfB6CFpt0ycQtGpxZIBdTwqraGUoLqVZogC2j+r3zI=;
 b=mmarCtxO7YpOo9eXLnf2RT6YpijYAWS8Oo5GFTN239MaNWou7090bV3LtUOIwURQfS
 FBSCh/P2CgbZJC9GqxVG4HA0yPgncZJtrH+DhO7jiyHSSQ7aOX8IylufqIHSf9boo6XH
 hNYP9IPxpxZb6rqwr/ckea3rwOrlC5ztvwOBNg243sFexmORSxJ55/cJv4ArFLmqUy0a
 K4/OvrTfbRpfPanP/oBLH7AR+fb14RTjqI/GSjx3UbbcGdmtSFGmnYBg57LKJtqNXlp1
 zMVU7zsiNCbfNONq0OByu2PirBwbDpHW131MejYXGy533E0ZC9Vgq9YQU5U8A6tpiJq4
 A0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722861815; x=1723466615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXfB6CFpt0ycQtGpxZIBdTwqraGUoLqVZogC2j+r3zI=;
 b=qeyu+GZp5AfwMoATF8eaGCkr8L0vd66sYBUIHIYwZpHnFyHfSKf/RAPT1QrMVEdNuG
 b8pgO0xrHGg+CtUXfbzQomxZ8i7njX47kHtg+mv4qwFWVYzll7OOu50BGwTESL88CDqu
 8cfzKOGyOpdmcc8rCuoxCKrfKRblyOqp8DWYaW+I5/XnfwFZhKM1OjhrVITdxlcfIK86
 ImbnSVLfhxnKT0h885KU9i09ySowP5oUwTCQa5GO3dtfEtjUEPoQB4bG+me09rPilwfV
 iuKJugF9m/TbpJ9nPkKlgpu0VeNhA+Ml1HQJQreC8T3YzXH08OF/3HpIgMLbDid5keun
 EERA==
X-Gm-Message-State: AOJu0Yy/vkvpGtJ4o2cKxXciVJr+CRWpfezJw/fut5gbDR3p6V3ub6g/
 DaSotxuO7CF5Dt57E+pRe9rF5mcGzlxHarnGV0NtW0h6jymVPmfu8e6OUw==
X-Google-Smtp-Source: AGHT+IH4w24nVyrPq49qQCywwJIYgL42VCAqSSDugqyARNICFIlH3AnqCxiOyBU5zagogbaTduEpHA==
X-Received: by 2002:a05:6214:310f:b0:6b5:33c6:9caf with SMTP id
 6a1803df08f44-6bb986fb506mr174466486d6.16.1722861814793; 
 Mon, 05 Aug 2024 05:43:34 -0700 (PDT)
Received: from p1g2.lan (128-78-204-97.abo.bbox.fr. [128.78.204.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c87bb90sm34984796d6.130.2024.08.05.05.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:43:34 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH 3/5] spl: binman: Disable u_boot_any symbols for i.MX 8ULP
 boards
Date: Mon,  5 Aug 2024 14:43:24 +0200
Message-ID: <20240805124326.544310-4-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805124326.544310-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Aug 2024 15:54:59 +0200
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

This is extending commit da96f93cda9 ("spl: binman: Disable u_boot_any
symbols for i.MX93 boards") to i.MX 8ULP boards.

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
---
 common/spl/Kconfig     | 2 +-
 common/spl/Kconfig.tpl | 2 +-
 common/spl/Kconfig.vpl | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6f56ca911c1..c08ff064493 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -206,7 +206,7 @@ config SPL_BINMAN_SYMBOLS
 config SPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in SPL"
 	depends on SPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M || ARCH_IMX9
+	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in SPL which refer to U-Boot phases,
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index 4ee3b9b826d..92d4d43ec87 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -23,7 +23,7 @@ config TPL_BINMAN_SYMBOLS
 config TPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in TPL"
 	depends on TPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M || ARCH_IMX9
+	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in TPL which refer to U-Boot phases,
diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index f1993026bba..d06f36d4ee4 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -243,7 +243,7 @@ config VPL_BINMAN_SYMBOLS
 config VPL_BINMAN_UBOOT_SYMBOLS
 	bool "Declare binman symbols for U-Boot phases in VPL"
 	depends on VPL_BINMAN_SYMBOLS
-	default n if ARCH_IMX8M || ARCH_IMX9
+	default n if ARCH_IMX8M || ARCH_IMX8ULP || ARCH_IMX9
 	default y
 	help
 	  This enables use of symbols in VPL which refer to U-Boot phases,
-- 
2.43.0

