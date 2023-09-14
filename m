Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84088EEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC4A870B9;
	Thu, 14 Sep 2023 18:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yq45Me4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B852E870BF; Thu, 14 Sep 2023 18:56:49 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D398708F
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34df2a961a0so4064615ab.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710606; x=1695315406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyw6tdLPFHn1+iu1ZkmIqyxuRtULS4DQbyScss7bLI8=;
 b=Yq45Me4OrUPxN+pfTAzzGGRC7EnQ9RfcF6n4MuJTQ125mefkwEjAFIicwqLEwQQNzc
 wNd6CKx68ObS/ZlmTouiLnMTm8640eMelwWOAne1OF5niKHQPgpJnhKZR8yy3A2+E3M3
 QxJC6xNrP6HK2neSMQ63d92jxG1lYEKKrGKmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710606; x=1695315406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyw6tdLPFHn1+iu1ZkmIqyxuRtULS4DQbyScss7bLI8=;
 b=M62b7OUoSDFoXK2fWJB1VLofAxIEo+MsscfYdqkxAmaaRhLIQaLpgIRUfVKvMHYR80
 hvBtKJLsKERkH4K6W0IaF0gItBbPDLskGBUsfVSTQjXDi7mSjU5/UALCPCfYzm55sdBt
 iwnMxFjDEg7qG3XzUgSYMS3SJnaj1sbeHCO9cp7q9jqrVgq6wFKYiqhehgzGPgfCrIW0
 LfLLjDfSHoJ+X/rQhPz6DDtVEU5MODdZtUGXIN1c9r+FsvxMSThZ7nD/4g9sHH3l6RLY
 TWV54iwpd12eWuRL1+cEoJ3pyOgfhjFYpIt5hZkPubff5aRC1VnaSFj8iqPfgQ3/aCVD
 VPJA==
X-Gm-Message-State: AOJu0YwMRUnbkBVR0ZusX7FLyCpDjmhBluIBnR06g/ZlIu1PR6OyTyfd
 1eNxHWL+gemfWeCkpkgy0t9xJ2aYKvXcxfkPlKo=
X-Google-Smtp-Source: AGHT+IHclEzeHVqwde0L84IN8w9st39+I7/qLmylnp2ySepAvxBmMi8FJDNd7zTEgI8QWWtLXiuQfw==
X-Received: by 2002:a05:6e02:1a6b:b0:34f:7e36:5f8b with SMTP id
 w11-20020a056e021a6b00b0034f7e365f8bmr7544485ilv.25.1694710606299; 
 Thu, 14 Sep 2023 09:56:46 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 15/21] boot: Make standard boot a menu
Date: Thu, 14 Sep 2023 10:55:53 -0600
Message-ID: <20230914165615.1058529-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

Collect these options into a menu for easier viewing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9b09d636d05..a885fea692f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -372,8 +372,8 @@ config BOOT_DEFAULTS
 	  of U-Boot to boot various images. Currently much functionality is
 	  tied to enabling the command that exercises it.
 
-config BOOTSTD
-	bool "Standard boot support"
+menuconfig BOOTSTD
+	bool "Standard boot"
 	default y
 	depends on DM && OF_CONTROL && BLK
 	help
@@ -393,6 +393,8 @@ config BOOTSTD
 	        U-Boot)
 	    - bootflow - a description of how to boot (owned by the distro)
 
+if BOOTSTD
+
 config SPL_BOOTSTD
 	bool "Standard boot support in SPL"
 	depends on SPL && SPL_DM && SPL_OF_CONTROL && SPL_BLK
@@ -413,8 +415,6 @@ config VPL_BOOTSTD
 	  boot. It is enabled by default since the main purpose of VPL is to
 	  handle the firmware part of VBE.
 
-if BOOTSTD
-
 config BOOTSTD_FULL
 	bool "Enhanced features for standard boot"
 	default y if SANDBOX
@@ -673,7 +673,7 @@ config BOOTMETH_SCRIPT
 	  This provides a way to try out standard boot on an existing boot flow.
 	  It is not enabled by default to save space.
 
-endif
+endif # BOOTSTD
 
 config LEGACY_IMAGE_FORMAT
 	bool "Enable support for the legacy image format"
-- 
2.42.0.459.ge4e396fd5e-goog

