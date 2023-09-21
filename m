Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D702E7106D
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 13:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F250B86660;
	Thu, 21 Sep 2023 15:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YCEq2540";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33993865A6; Thu, 21 Sep 2023 15:37:58 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A13864EE
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso40077739f.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695303474; x=1695908274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1kaIWonyeR9fAL3AZZRK3McWjCWyTB8pLQNEecblbE=;
 b=YCEq2540Ano9K82jMRx2hAKqaUOSD1jo+T7j9a7bis55/sk4+U62msA78D9SZjZ/TR
 gcEXnjzu/Vm9jzWBGA8fLJi/bHDlbXKAlxnSr31HuHjQ1LvDr7UQ4Nfp4InoBx0j6Bb+
 9zXmkyjaoYZIC6BInyb2vjH9eZ/PsRg4YfcYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303474; x=1695908274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1kaIWonyeR9fAL3AZZRK3McWjCWyTB8pLQNEecblbE=;
 b=b4PaitKWjl8ExydUTIxAA+b1+PRiaJ62fK+gUKGhiQ2af58aVjV2s6R2xroBUuMK9B
 31eFjvANxvTZlTnbVoAsAL3ffcyZXOtwGZBom8CVliUABu1PIBdOLiC89ysELDaRHfmz
 I8CqqnQkMwsPzjIEkfCHJ0JlI2ZZigHdejO95CcI/MojEOfb8D8qmZ1PojC8aml3esKX
 tA3B/+ec8GktjsBu7M/Xu5EJNYwfLDkTFb96vLVkK1kxcsEKxX1kGtUyBUoy9hM0nh7N
 7syqLH2DtKWkWi89uxWa3xr8vv4A9T2VmFPp70r6m6tUXwT9/qRgT+L/tLBo2Tc41CFM
 Eu7w==
X-Gm-Message-State: AOJu0YwQfF+V7UhDxRMPJBFkqTaee2tPtVxYpFeVRwBocksYbssPRWx7
 EbdEq50OS5ssgwKUJ8JeivylednaDPdXTlWURwk=
X-Google-Smtp-Source: AGHT+IHQw70UNdudTgP6ZQNJB1ev9umqr7UBPrLHX9pjSI/eUiHPqEW72RFmQbevZnf1pffDzI7Qew==
X-Received: by 2002:a6b:7412:0:b0:790:fab3:2052 with SMTP id
 s18-20020a6b7412000000b00790fab32052mr5599555iog.5.1695303474713; 
 Thu, 21 Sep 2023 06:37:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 w17-20020a5ed611000000b007835686237asm389786iom.27.2023.09.21.06.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:37:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 1/3] fixup: Move python control earlier in Makefile
Date: Thu, 21 Sep 2023 07:37:43 -0600
Message-ID: <20230921133748.1543007-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921133748.1543007-1-sjg@chromium.org>
References: <20230921133748.1543007-1-sjg@chromium.org>
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

Move this control into the common area of the main Makefile, so it
applies to non-build rules as well. This allows 'make mrproper' to handle
python files as it should.

This should be squashed into:

   65a33eba10d Allow Python packages to be dropped

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Add new fixup patch to move python control earlier in Makefile

 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 264f31bfe473..efbaf434df48 100644
--- a/Makefile
+++ b/Makefile
@@ -485,6 +485,15 @@ export RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o    \
 export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn \
 			 --exclude CVS --exclude .pc --exclude .hg --exclude .git
 
+export PYTHON_ENABLE
+
+# This is y if U-Boot should not build any Python tools or libraries. Typically
+# you would need to set this if those tools/libraries (typically binman and
+# pylibfdt) cannot be built by your environment and are provided separately.
+ifeq ($(NO_PYTHON),)
+PYTHON_ENABLE=y
+endif
+
 # ===========================================================================
 # Rules shared between *config targets and build targets
 
@@ -646,20 +655,12 @@ export CFLAGS_NON_EFI	# Compiler flags to remove when building EFI app
 export EFI_TARGET	# binutils target if EFI is natively supported
 
 export LTO_ENABLE
-export PYTHON_ENABLE
 
 # This is y if LTO is enabled for this build. See NO_LTO=1 to disable LTO
 ifeq ($(NO_LTO),)
 LTO_ENABLE=$(if $(CONFIG_LTO),y)
 endif
 
-# This is y if U-Boot should not build any Python tools or libraries. Typically
-# you would need to set this if those tools/libraries (typically binman and
-# pylibfdt) cannot be built by your environment and are provided separately.
-ifeq ($(NO_PYTHON),)
-PYTHON_ENABLE=y
-endif
-
 # If board code explicitly specified LDSCRIPT or CONFIG_SYS_LDSCRIPT, use
 # that (or fail if absent).  Otherwise, search for a linker script in a
 # standard location.
-- 
2.42.0.515.g380fc7ccd1-goog

