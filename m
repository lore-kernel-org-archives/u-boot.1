Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5671BCE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FBD886BB9;
	Sun, 24 Sep 2023 21:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HD2XqcRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F95086B03; Sun, 24 Sep 2023 21:26:11 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6717886AE6
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34961362f67so17452045ab.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583561; x=1696188361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEUcbFO0gEs/R8FSkOv/egTTUhgj7/NUGWAgX9VrMfE=;
 b=HD2XqcRkEARJlMBj935aHycez2XSl4X/U0JHW4YIw990TCMX04+N1g4FZFTfDi6UpB
 f5WZmXaM8Id1929CR+vcmiGZiyV28EQCsfwIGW0xXQfKgwX7AbASrFkb5SoNYQXnQsCJ
 eHx45zF4e00u1KwjFKWf+2Np+wOj68k6YWMIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583561; x=1696188361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEUcbFO0gEs/R8FSkOv/egTTUhgj7/NUGWAgX9VrMfE=;
 b=NHgLlZZUcxgmM24oqxQXzgYCKr6fhcCoaOzFLQIexuYa6dsqsyHWMUHH19+zc2XsNc
 ajVr9zFZLv95DiLivRe8JPIEyTMeM2oIqsOLfdNE3EGjLNY7dAErgpgr+rP19ozjM6y5
 wXgYiFPBBjK2vE4ixCzKTR9IVBvHFhuoz92HiLk5gw8Zx9HDoSCAnk1RUIetoTzTyVEm
 ZsMqqFyVkCBegCF6ISSGEdtIXssjV9MTykLL+HDLnv9QSKjREHDIY8YPlkddPwbvXoUR
 Boy4BY2XpU6aFDjbjvDpGMvDmE2K6c7TkGNd17+Tov+0SFcAtysjptbS4430Fvcx0lw5
 h5zw==
X-Gm-Message-State: AOJu0YyYkb1wctAF4QYLVhgNZRtRtu3yCJWBVUXfmRBI6tlNYPi2nOwf
 nekZ+pUKvPEV1Y6FMwM+WY7ydh0t1uVcB4KplbM=
X-Google-Smtp-Source: AGHT+IF3eauOszQOk/vCBuKGifg87YkqlHZszasJnJw6DLRrfGP0KdnH6tFvryNgf3rFERTVmI0vig==
X-Received: by 2002:a05:6e02:1b0a:b0:34f:dfb5:8e8 with SMTP id
 i10-20020a056e021b0a00b0034fdfb508e8mr7406821ilv.14.1695583561041; 
 Sun, 24 Sep 2023 12:26:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 13/38] doc: Clean up SYS_MALLOC_SIMPLE
Date: Sun, 24 Sep 2023 13:24:58 -0600
Message-ID: <20230924192536.1812799-14-sjg@chromium.org>
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

Move the useful help to Kconfig.

Drop mention of CONFIG_SYS_MALLOC_SIMPLE since it doesn't exist.

Correct a 'CONFIGSYS_MALLOC_F_LEN' typo

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to clean up SYS_MALLOC_SIMPLE documentation

 Kconfig                  | 15 +++++++++++----
 README                   | 18 ------------------
 doc/usage/cmd/bdinfo.rst |  2 +-
 3 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/Kconfig b/Kconfig
index 57afe597b0c8..a3061c86124e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -277,10 +277,17 @@ config SYS_MALLOC_F_LEN
 	default 0x10000 if ARCH_IMX8 || ARCH_IMX8M
 	default 0x2000
 	help
-	  Before relocation, memory is very limited on many platforms. Still,
-	  we can provide a small malloc() pool if needed. Driver model in
-	  particular needs this to operate, so that it can allocate the
-	  initial serial device and any others that are needed.
+		Size of the malloc() pool for use before relocation. If
+		this is defined, then a very simple malloc() implementation
+		will become available before relocation. The address is just
+		below the global data, and the stack is moved down to make
+		space.
+
+		This feature allocates regions with increasing addresses
+		within the region. calloc() is supported, but realloc()
+		is not available. free() is supported but does nothing.
+		The memory will be freed (or in fact just forgotten) when
+		U-Boot relocates itself.
 
 config SYS_MALLOC_LEN
 	hex "Define memory for Dynamic allocation"
diff --git a/README b/README
index a1f90642274d..60c6b8a19db1 100644
--- a/README
+++ b/README
@@ -1281,24 +1281,6 @@ Configuration Settings:
 - CONFIG_SYS_MALLOC_LEN:
 		Size of DRAM reserved for malloc() use.
 
-- CONFIG_SYS_MALLOC_F_LEN
-		Size of the malloc() pool for use before relocation. If
-		this is defined, then a very simple malloc() implementation
-		will become available before relocation. The address is just
-		below the global data, and the stack is moved down to make
-		space.
-
-		This feature allocates regions with increasing addresses
-		within the region. calloc() is supported, but realloc()
-		is not available. free() is supported but does nothing.
-		The memory will be freed (or in fact just forgotten) when
-		U-Boot relocates itself.
-
-- CONFIG_SYS_MALLOC_SIMPLE
-		Provides a simple and small malloc() and calloc() for those
-		boards which do not use the full malloc in SPL (which is
-		enabled with CONFIG_SPL_SYS_MALLOC).
-
 - CFG_SYS_BOOTMAPSZ:
 		Maximum size of memory mapped by the startup code of
 		the Linux kernel; all data that must be processed by
diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
index b287d0ff7369..5261085a068d 100644
--- a/doc/usage/cmd/bdinfo.rst
+++ b/doc/usage/cmd/bdinfo.rst
@@ -106,7 +106,7 @@ sp start
 
 Early malloc usage
     amount of memory used in the early malloc memory and its maximum size
-    as defined by CONFIGSYS_MALLOC_F_LEN
+    as defined by CONFIG_SYS_MALLOC_F_LEN
 
 Configuration
 -------------
-- 
2.42.0.515.g380fc7ccd1-goog

