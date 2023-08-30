Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140BCC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81FE866D0;
	Wed, 30 Aug 2023 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AG/blsYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55AAA864AA; Wed, 30 Aug 2023 20:06:22 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A845386680
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7927f24140eso2093739f.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418762; x=1694023562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0+2U8N385YHBANeZ1pdr5nooinRgU9Vy12OuBcNWQU=;
 b=AG/blsYShxXBNl4t3iTVgtLw2e8b6ciC9tM4FmDwQzsbtA64DYigfBNcrjdyrp+IcB
 BxI4a9Tg+/YGafnuYgtWX1MltyHppjUei1eAD0E4o8NhaXYXU9SlwCjeUPNLCQStRINu
 RopCd8lpem5SrpM85ei4TzZI2aDZ/ptZwyMjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418762; x=1694023562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0+2U8N385YHBANeZ1pdr5nooinRgU9Vy12OuBcNWQU=;
 b=XSSCnOVio8zLb8oCsHpYHFN2x7a/AU6bMSraPG0cuhZbFsh/xPWsNeCE2vnWylEhzR
 A57GIXqbsS84E+x57ztU6SSnouAF7tPYcCj9ygkPx9Q4esxikY8CVfZH6AVMzT7nXIM8
 SPSCf7s90EOSWRxjG4EQ0bU5D1Pb+SSL8wQvqaoxAaRaepVw6GY5Fy9O5eXKUgRqeVrn
 geBvCMYXuC/wuApl/3y5i0rVGTirwSh6PeuM+Y3UgO3CBG4zNfxCWecB9I+n3yYW7RNL
 skVOpdyiYuJJ6PmURyEVpgG/481UfyARpqQPbMswvG72BUKYCErbL7pxzfYrz/DuRcn4
 eHFg==
X-Gm-Message-State: AOJu0YyBIm1UASgpthR+xJcmlgMiqGtNPrLYkg2kc3ZVspyVwvVdV3FU
 x4weDVTZlvdsXkH/4gRouzyV8K1PqgYBTG5qgtA=
X-Google-Smtp-Source: AGHT+IHr+GdwvI6O+x+Updy+NsLDS1UB7GiDZAOmec5/5vZoTLJFk0uGtAzBKc4NsZS3ELqN0kvI0Q==
X-Received: by 2002:a6b:fe15:0:b0:787:8cf:fe8a with SMTP id
 x21-20020a6bfe15000000b0078708cffe8amr3707996ioh.2.1693418762339; 
 Wed, 30 Aug 2023 11:06:02 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:06:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Corentin Guillevic <corentin.guillevic@smile.fr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH 28/32] sandbox: Move the bloblist down a little in memory
Date: Wed, 30 Aug 2023 12:04:59 -0600
Message-ID: <20230830180524.315916-29-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

Move this down by 4KB so that it is large enough to hold the devicetree.

Also fix up the devicetree address in the documetation while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Kconfig               | 2 +-
 doc/arch/sandbox/sandbox.rst | 4 ++--
 test/lib/kconfig.c           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 0b09bd68bd1..7f8ccc2ed85 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1011,7 +1011,7 @@ endchoice
 
 config BLOBLIST_ADDR
 	hex "Address of bloblist"
-	default 0xc000 if SANDBOX
+	default 0xb000 if SANDBOX
 	depends on BLOBLIST_FIXED
 	help
 	  Sets the address of the bloblist, set up by the first part of U-Boot
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index a3631de7493..23902dee89e 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -614,8 +614,8 @@ that are mapped into that memory:
 =======   ========================   ===============================
 Addr      Config                     Usage
 =======   ========================   ===============================
-      0   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
-   c000   CONFIG_BLOBLIST_ADDR       Blob list
+    100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
+   b000   CONFIG_BLOBLIST_ADDR       Blob list
   10000   CFG_MALLOC_F_ADDR          Early memory allocation
   f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
  100000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
diff --git a/test/lib/kconfig.c b/test/lib/kconfig.c
index 76225ba8ffa..3914f699659 100644
--- a/test/lib/kconfig.c
+++ b/test/lib/kconfig.c
@@ -22,9 +22,9 @@ static int lib_test_is_enabled(struct unit_test_state *uts)
 	ut_asserteq(0, CONFIG_IS_ENABLED(OF_PLATDATA));
 	ut_asserteq(0, CONFIG_IS_ENABLED(_UNDEFINED));
 
-	ut_asserteq(0xc000,
+	ut_asserteq(0xb000,
 		    IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED, CONFIG_BLOBLIST_ADDR));
-	ut_asserteq(0xc000,
+	ut_asserteq(0xb000,
 		    CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED, BLOBLIST_ADDR));
 
 	/*
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

