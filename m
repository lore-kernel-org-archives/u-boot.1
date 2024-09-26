Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA247CCFA07
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 418328900A;
	Fri, 27 Sep 2024 00:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CDKtZg/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C3789028; Fri, 27 Sep 2024 00:47:45 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E78588F41
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-457e153cbdcso11522511cf.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390862; x=1727995662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRoLMw9UnZvc8+hPOLjktqugtrUn2FH/RDEkT7LuZmU=;
 b=CDKtZg/xVRSql8Oj6zgbMI3j02gqBJLol7AWF9QmFdgfeXRBqoEFBSuqv+kH+DSEhk
 zLw0BGtDLEf64T70FF+XCZ9L7DqDcrtB9snrKllXpM1QTM/vqFzxsk+Nk6w3BDOKnpko
 fKUAug3baH+zxbkuAWlxgUTGzNIliGGAKkuTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390862; x=1727995662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRoLMw9UnZvc8+hPOLjktqugtrUn2FH/RDEkT7LuZmU=;
 b=IBR2c/DVrkPuI8UBKYiOJ/elvYN9H8vyrWEK0pKD8fmcXHSMYpKJTUB4wwo/YazL7F
 aq1ELEjSGr7FinO1TzCsnr/YowYfhrO1r/UlAsIbV4b8MU3Ls8A1nDozGS5i6tu5Xkov
 cvq6gApD22Hb+2Bl8j0BgXTa+/9YbjsKgl2fOl5FgBMpqbbi1xC6wC0SE8AqoV1ztDVc
 VvH1Vm0UU69UGL7U8C9DW2AmefeFf8cmXLC1cbUU9+rRtSd+jkZUEnxh9x8/ILciSHCb
 086cyV779NgyT8Yb3EK0AfS5rX9xmTPEeYROgzPaJ5bxsHR7EiUsd49kY61tjL8KF47p
 WR2Q==
X-Gm-Message-State: AOJu0YxB6CbaePRU+EoJVLC7PHfK1XQu5KAgkMw+EpNqaRbk7v/7xf1A
 E2cWBUdofC+rjXWEeTypEhmjUI+dqgW/kcef5N30ZIRr0r8/yubOPHvU9Tj9Vc4nl0e+AFCj/W8
 2PAZDY3c=
X-Google-Smtp-Source: AGHT+IHlakjB81rZXOBzNg6lgLdG1+1CY5frJ+hkm60aNibylgsImadLDWjkYstlSzifG6a9CqHJbw==
X-Received: by 2002:a05:622a:1214:b0:458:611b:ac38 with SMTP id
 d75a77b69052e-45c9f2877dbmr13341921cf.42.1727390861865; 
 Thu, 26 Sep 2024 15:47:41 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:47:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 42/42] doc: Update init docs for the xPL changes
Date: Fri, 27 Sep 2024 00:36:07 +0200
Message-ID: <20240926223814.1276764-43-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Update the documentation here to cover the meaning of xPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/init.rst | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/doc/develop/init.rst b/doc/develop/init.rst
index 2955d9bdbc3..ce985781bb4 100644
--- a/doc/develop/init.rst
+++ b/doc/develop/init.rst
@@ -4,15 +4,16 @@ Board Initialisation Flow
 -------------------------
 
 This is the intended start-up flow for boards. This should apply for both
-SPL and U-Boot proper (i.e. they both follow the same rules).
+xPL and U-Boot proper (i.e. they both follow the same rules).
 
-Note: "SPL" stands for "Secondary Program Loader," which is explained in
-more detail later in this file.
+Note: "xPL" stands for "any Program Loader", including SPL (Secondary
+Program Loader), TPL (Tertiary Program Loader) and VPL (Verifying Program
+Loader). The boot sequence is TPL->VPL->SPL->U-Boot proper
 
-At present, SPL mostly uses a separate code path, but the function names
+At present, xPL mostly uses a separate code path, but the function names
 and roles of each function are the same. Some boards or architectures
 may not conform to this.  At least most ARM boards which use
-CONFIG_SPL_FRAMEWORK conform to this.
+CONFIG_xPL_FRAMEWORK conform to this.
 
 Execution typically starts with an architecture-specific (and possibly
 CPU-specific) start.S file, such as:
@@ -48,7 +49,7 @@ board_init_f()
 
 Non-xPL-specific notes:
 
-    - dram_init() is called to set up DRAM. If already done in SPL this
+    - dram_init() is called to set up DRAM. If already done in xPL this
       can do nothing
 
 xPL-specific notes:
@@ -68,9 +69,9 @@ xPL-specific notes:
     - must return normally from this function (don't call board_init_r()
       directly)
 
-Here the BSS is cleared. For SPL, if CONFIG_SPL_STACK_R is defined, then at
+Here the BSS is cleared. For xPL, if CONFIG_xPL_STACK_R is defined, then at
 this point the stack and global_data are relocated to below
-CONFIG_SPL_STACK_R_ADDR. For non-SPL, U-Boot is relocated to run at the top of
+CONFIG_xPL_STACK_R_ADDR. For non-xPL, U-Boot is relocated to run at the top of
 memory.
 
 board_init_r()
@@ -82,11 +83,11 @@ board_init_r()
     - BSS is available, all static/global variables can be used
     - execution eventually continues to main_loop()
 
-Non-SPL-specific notes:
+Non-xPL-specific notes:
 
     - U-Boot is relocated to the top of memory and is now running from
       there.
 
-SPL-specific notes:
+xPL-specific notes:
 
-    - stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined
+    - stack is optionally in SDRAM, if CONFIG_xPL_STACK_R is defined
-- 
2.43.0

