Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103BAE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75AB086DE0;
	Tue, 26 Sep 2023 16:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="falLf+qP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA2786DC6; Tue, 26 Sep 2023 16:15:45 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6D286DE9
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79f96f83270so275250839f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737733; x=1696342533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRAmP/E+hKf5xxsvOI2GMfxuXGKMDIgXU0DCLIX28k4=;
 b=falLf+qPnjy5Y9X23LRQZGPH2ZXrHYq8fhY+40c8c3yukwQHV9KFd22ash9e1TrQ4E
 wmFdkIikh8OauK0JBSm6RqcdOn/7LL7qnMyXcFTrKysysUMqwAkqfRu47gTDF2bTzcb+
 biizGa3qk/7VrecdLY/JHbLk23PYhLy1c/0OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737733; x=1696342533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRAmP/E+hKf5xxsvOI2GMfxuXGKMDIgXU0DCLIX28k4=;
 b=AQk0yjOCH3Qnkx2Af/gy13pFU30nhGPyhDrUxowSSRO98cj9f4oC4+fICBByAP9wVQ
 qz33uFxA2VaSx2Z+q/E8IPRtczetG3znlPulgpjUWKxjSjRU4n0ogg1iHNq2jprZF7wX
 6disAHdk6oAjyLicI0VEgstjGaCngZcUu73Bhs21rpoQf9o5i51p98OYEDBjwI8ncA28
 XAbjobYX0zboCmvSuU5wp5627LgTCRgjZ3rmGkatPqrbNDhkgu/5Ru0v/eMh3sN+pM3Y
 Vnh5tDtvmG6wm3x8niVz52/DkT0Ef59fkk+6/qgJpK91RM+BCz2Kn8Bua4i0xKpTCKus
 4Nxg==
X-Gm-Message-State: AOJu0YyGgu7u0xCwTbqWZCYLu88KBc3zx3ht7YkOZc0P9X/6aqIFXVmQ
 U37UDWw2OOfMiekinQ+hkMNiTfLmWIowVeQDq1Y=
X-Google-Smtp-Source: AGHT+IHc103Hk3FbS59qp9PjUNruEHnb6U+R5ikeig9ae9U2FRmLfVWO4GMOkkCk5lxRDAuAF6PZAw==
X-Received: by 2002:a5d:930b:0:b0:786:cc36:360c with SMTP id
 l11-20020a5d930b000000b00786cc36360cmr10956894ion.8.1695737733349; 
 Tue, 26 Sep 2023 07:15:33 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 10/44] spl: Create proper symbols for enabling the malloc()
 pool
Date: Tue, 26 Sep 2023 08:14:24 -0600
Message-ID: <20230926141514.2101787-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

(no changes since v3)

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

