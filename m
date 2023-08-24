Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC824C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C01F86AA7;
	Thu, 24 Aug 2023 21:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eI/eb3IH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A967986A60; Thu, 24 Aug 2023 21:59:46 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E5B869D1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7927e66abc9so5073239f.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907182; x=1693511982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lguuD0EzHSPIWanJSgq6ODTtjdlOtrqnUSQ9Gb3Jt0Q=;
 b=eI/eb3IHXhG29k5yZY98ED5pHW92PJ2orD42/mZ3V6rmfw2l0iu5QbO7Gyd/MrD0m+
 dimZh4iAkyOW4YqJbke25VvU4k07fSP0TqPLyA+lsuPXtQNvnJEyXtQHxCl7ppoB3kyf
 iix84B0yWOVrelN2Mp9lFoHi3BmBwIc7ECfIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907182; x=1693511982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lguuD0EzHSPIWanJSgq6ODTtjdlOtrqnUSQ9Gb3Jt0Q=;
 b=jrC6j9n5N2EqLPRTognZZplZBJNwr4Yz7XabktGuHXQRJYqxpIOoDjbmDg0HKnOxPZ
 s2qA9FZCjNgWWUKDqsXaoxhyOnbqMBNZz3SAqOXD1hn8qweyDBtYBrgjxlfRajiU/msB
 MxSakOAdok1SXrWDvyFeARU/Q4jKBv4dV5yEZuO90oT2R2r1agDbjrR/0R+ZzAt6H4z6
 GrZTE0djzuXsZtvSp8Mor73g6VIqFrTlaUJROXQYCE+GFC0PUNS8mrJtcnS0f2k+Xc/3
 CdDQLcovftkuAVfWHk9MJbH5JlO5jEcjChdXejuyVVcBqHKxJ6j0SK6nv2VJEZvnnQuA
 7MqQ==
X-Gm-Message-State: AOJu0YyEEMczwWdkH4yA0hpG8WLVG51vtCY8lfr2J5cptOiarE53Wp8+
 9AdoFA3D28F1ZySPnPTViJUhxJ2r+chLuDsEAUE=
X-Google-Smtp-Source: AGHT+IG58vUM/GL7IH3PtDxtxCvMj+vlYSU0zd4HdWgVCuQnZa9DtXSkUya2VMHyxnoGRdQdULDv1Q==
X-Received: by 2002:a6b:720b:0:b0:787:8d2:e0c with SMTP id
 n11-20020a6b720b000000b0078708d20e0cmr7459965ioc.12.1692907181933; 
 Thu, 24 Aug 2023 12:59:41 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 15/19] boot: Make standard boot a menu
Date: Thu, 24 Aug 2023 13:59:06 -0600
Message-ID: <20230824195917.1687886-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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

 boot/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index af08703ea1e5..8343eba10531 100644
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
@@ -670,7 +670,7 @@ config BOOTMETH_SCRIPT
 	  This provides a way to try out standard boot on an existing boot flow.
 	  It is not enabled by default to save space.
 
-endif
+endif # BOOTSTD
 
 config LEGACY_IMAGE_FORMAT
 	bool "Enable support for the legacy image format"
-- 
2.42.0.rc1.204.g551eb34607-goog

