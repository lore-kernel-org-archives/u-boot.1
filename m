Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF946E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC2E86E7D;
	Tue, 26 Sep 2023 16:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jzKa1Q2M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A2B86E5A; Tue, 26 Sep 2023 16:16:09 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A3AC86E14
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fe99a5f29so22839f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737759; x=1696342559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhP20/J+z0W4sFtNvAkzJCRhwJFMRa2Cj+VUkoRHIEk=;
 b=jzKa1Q2MlHgQ/UIKNqTp8BnTcsYzERxEaJCa2W4Zfr7HeoywaC2VrGWd/tGsR3ZpZG
 NrUsskUUrTZD+BvasQtgsMbFA0mN6IJ0GNIIj+NKBHvDWgAzr9xBlSjolSh1E7ZvkEik
 7HT/w5NfJEmSIdTCClxRL2twdwvknVVA/r5co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737759; x=1696342559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhP20/J+z0W4sFtNvAkzJCRhwJFMRa2Cj+VUkoRHIEk=;
 b=vKENfzOztJGI5Ho5R4PpyYX81mG7+/x8BxP9hZcKQzbsWHH4QLgtatm0P27HCC2F0D
 FB18O+wzJL996CwaMWp+0oI++hXbVVgztrzpmM1GMgYJ4q2QxQlAwJuVLg8jy0HMskMF
 ymkCPFIlEeZfNPZnJCXk4m7yEqIHa1jhINGwGWmKBuAI/MRDjSDnSVbbDxId/rMBhAZh
 fMILEBPrXVjcBTZh5WI3r5ECaP5JLenrSJIbTWX6X1+A5t4uVlmijQUbxglVoqaC9JKL
 ZIRdZSuiKKsZjzO7Tir9cS5WKQglAILQXN91QRvPrUjq0VQ/f78WNJ2NmcXie0WO24+F
 viCQ==
X-Gm-Message-State: AOJu0YwB0Jeb/UW/XidV2FL0AmjgIEoLBfgfINMiX4/y45tb1U225yAD
 ZCU8EQZd5xjPMydC2Z9EyYddtHEuhQty05SmYbA=
X-Google-Smtp-Source: AGHT+IFQGGHHyQtkMDKorOKzlj1F+DReJhazUhTOU5nogf5YYwfoftC2o2Z+hJYhrfTrHMyk1DCHSg==
X-Received: by 2002:a6b:fc14:0:b0:785:d4f5:2225 with SMTP id
 r20-20020a6bfc14000000b00785d4f52225mr9904476ioh.19.1695737759637; 
 Tue, 26 Sep 2023 07:15:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 36/44] sandbox: Move the bloblist down a little in memory
Date: Tue, 26 Sep 2023 08:14:50 -0600
Message-ID: <20230926141514.2101787-37-sjg@chromium.org>
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

Move this down by 4KB so that it is large enough to hold the devicetree.

Also fix up the devicetree address in the documetation while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig               | 2 +-
 doc/arch/sandbox/sandbox.rst | 4 ++--
 test/lib/kconfig.c           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 21eaa5e815f9..5e79b5422178 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1012,7 +1012,7 @@ endchoice
 
 config BLOBLIST_ADDR
 	hex "Address of bloblist"
-	default 0xc000 if SANDBOX
+	default 0xb000 if SANDBOX
 	depends on BLOBLIST_FIXED
 	help
 	  Sets the address of the bloblist, set up by the first part of U-Boot
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index a3631de74932..23902dee89e7 100644
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
index 76225ba8ffa9..3914f699659f 100644
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
2.42.0.515.g380fc7ccd1-goog

