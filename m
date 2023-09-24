Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9454CE7A8E
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13FDE86B87;
	Sun, 24 Sep 2023 21:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h9mFyeRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC80986B38; Sun, 24 Sep 2023 21:26:08 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F3286B33
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35140cc9187so677955ab.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583556; x=1696188356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qf++VFWYd9WdJZbtgQsrUaL0wv9WI2aQ8x7potv/hh0=;
 b=h9mFyeROyZZBxU577kxYoYzVa8QlPGBFon1dBKSgKC6Cz73p+C34fQoBNrgo8hMH/i
 fNHuTjTl1oeKLlKKHiybzo8u86VdzsFFu19Rc84p9iqOEx36MvBAEn3dC2ksnttEhL7g
 TKcsfIHngPJOHVAm0VZ1O1YIChDMzUJiOhpSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583556; x=1696188356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qf++VFWYd9WdJZbtgQsrUaL0wv9WI2aQ8x7potv/hh0=;
 b=oQuSryz8cwgPb+0B2I055JpEKOzSuJoPBqRxBE8j68njuDk4wxXOX9I/6cHpuC42Zo
 t70o6iALk6Rok2NMBJmiBx505FCFD31j5rqW1vkBxu6ZoAwVNcFaOsvJHa+5aMC4wdhe
 o4UI565wvvWOgK7zY4yHtbuvo6hvfJDgd9V+OSIby1pfF/PP0yhxvvwAfKDclbW3wTGn
 FuVQJWZ+d64wLt+vIeGI920PN9oWe5CwMftT+iU02wnkK95CtFznroQ+Sm9FZgDvFAxY
 eW70xcd/JTLIZrAXm8jfHqCXoiq25ZZoIhrdobqgC0TaehM+bg5U+6nbcUhxCmPR2Wn1
 IgEQ==
X-Gm-Message-State: AOJu0YwQ4IQYNxihsQt4U147CYTEwTGyQ/LYgcihWyuibtqvh3D3gPU6
 cmeNUEvTwVnuCyrx+d4wJOEqaSDDA1+Eov1aVaA=
X-Google-Smtp-Source: AGHT+IFP+fmOQa4RKeulGJdLJuCymZKjSjomyTrjK5PR17fA1MWyGCEzVVNpq80av2UxnKtAmiJydw==
X-Received: by 2002:a05:6e02:b42:b0:34c:f2cb:b2c with SMTP id
 f2-20020a056e020b4200b0034cf2cb0b2cmr7544256ilu.19.1695583556365; 
 Sun, 24 Sep 2023 12:25:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 08/38] spl: Create proper symbols for enabling the malloc()
 pool
Date: Sun, 24 Sep 2023 13:24:53 -0600
Message-ID: <20230924192536.1812799-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

For U-Boot proper we have CONFIG_SYS_MALLOC_F which indicates that a
malloc() pool is available before relocation.

For SPL we only have CONFIG_SPL_SYS_MALLOC_F_LEN which indicates the
size of the pool.

In various places we use CONFIG_SPL_SYS_MALLOC_F_LEN == 0 to indicate
that there is no pool.

This differing approach is confusing. Add a new CONFIG_SPL_SYS_MALLOC_F
symbol for SPL (and similarly for TPL and VPL). Tidy up the Kconfig
help for clarity.

For now these symbols are not used. That is cleaned up in the following
patches.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to create a proper symbol for enabling the malloc() pool

 Kconfig | 49 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/Kconfig b/Kconfig
index aadb9d145b17..690ccdb93c4e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -295,6 +295,16 @@ config SYS_MALLOC_LEN
 	  This defines memory to be allocated for Dynamic allocation
 	  TODO: Use for other architectures
 
+config SPL_SYS_MALLOC_F
+	bool "Enable malloc() pool in SPL"
+	depends on SPL_FRAMEWORK && SYS_MALLOC_F && SPL
+	default y
+	help
+	  In SPL memory is very limited on many platforms. Still,
+	  we can provide a small malloc() pool if needed. Driver model in
+	  particular needs this to operate, so that it can allocate the
+	  initial serial device and any others that are needed.
+
 config SPL_SYS_MALLOC_F_LEN
 	hex "Size of malloc() pool in SPL"
 	depends on SYS_MALLOC_F && SPL
@@ -303,24 +313,32 @@ config SPL_SYS_MALLOC_F_LEN
 	default 0x2000 if IMX8MQ
 	default SYS_MALLOC_F_LEN
 	help
-	  In SPL memory is very limited on many platforms. Still,
-	  we can provide a small malloc() pool if needed. Driver model in
-	  particular needs this to operate, so that it can allocate the
-	  initial serial device and any others that are needed.
+	  Sets the size of the malloc() pool in SPL. This is used for
+	  driver model and other features, which must allocate memory for
+	  data structures.
 
 	  It is possible to enable CFG_SPL_SYS_MALLOC_START to start a new
 	  malloc() region in SDRAM once it is inited.
 
-config TPL_SYS_MALLOC_F_LEN
-	hex "Size of malloc() pool in TPL"
+config TPL_SYS_MALLOC_F
+	bool "Enable malloc() pool in SPL"
 	depends on SYS_MALLOC_F && TPL
-	default SPL_SYS_MALLOC_F_LEN
+	default y if SPL_SYS_MALLOC_F
 	help
 	  In TPL memory is very limited on many platforms. Still,
 	  we can provide a small malloc() pool if needed. Driver model in
 	  particular needs this to operate, so that it can allocate the
 	  initial serial device and any others that are needed.
 
+config TPL_SYS_MALLOC_F_LEN
+	hex "Size of malloc() pool in TPL"
+	depends on SYS_MALLOC_F && TPL
+	default SPL_SYS_MALLOC_F_LEN
+	help
+	  Sets the size of the malloc() pool in TPL. This is used for
+	  driver model and other features, which must allocate memory for
+	  data structures.
+
 config VALGRIND
 	bool "Inform valgrind about memory allocations"
 	depends on !RISCV
@@ -336,16 +354,25 @@ config VALGRIND
 	  it can be handled accurately by Valgrind. If you aren't planning on
 	  using valgrind to debug U-Boot, say 'n'.
 
-config VPL_SYS_MALLOC_F_LEN
-	hex "Size of malloc() pool in VPL before relocation"
+config VPL_SYS_MALLOC_F
+	bool "Enable malloc() pool in VPL"
 	depends on SYS_MALLOC_F && VPL
-	default SYS_MALLOC_F_LEN
+	default y if SPL_SYS_MALLOC_F
 	help
-	  Before relocation, memory is very limited on many platforms. Still,
+	  In VPL memory is very limited on many platforms. Still,
 	  we can provide a small malloc() pool if needed. Driver model in
 	  particular needs this to operate, so that it can allocate the
 	  initial serial device and any others that are needed.
 
+config VPL_SYS_MALLOC_F_LEN
+	hex "Size of malloc() pool in VPL before relocation"
+	depends on SYS_MALLOC_F && VPL
+	default SYS_MALLOC_F_LEN
+	help
+	  Sets the size of the malloc() pool in VPL. This is used for
+	  driver model and other features, which must allocate memory for
+	  data structures.
+
 menuconfig EXPERT
 	bool "Configure standard U-Boot features (expert users)"
 	default y
-- 
2.42.0.515.g380fc7ccd1-goog

