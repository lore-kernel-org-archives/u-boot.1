Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FF6CF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B3AD88DFE;
	Mon, 30 Sep 2024 03:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SpJlVMDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE4688E49; Mon, 30 Sep 2024 03:50:23 +0200 (CEST)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADF488DB3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso12625555ab.3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661016; x=1728265816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98uPw419gdwMRv5Go30+/ApFfdscCs3u/29kR2So/SM=;
 b=SpJlVMDA6piVinblQ8ReNSWJVseXiGGEHxm8jiem6JvCgFfxrPwRPWi+wSvOMu9A9h
 MDY+Jua2UGEsdYrIOJrkkXu56pf5Ij4WykXBLyQmZh5+a2RUs2MSY+XUTXOSpm+qm3HD
 uZmLQynQ7fdWOMTqBvE5mR20fXNtMZxaUfGp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661016; x=1728265816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98uPw419gdwMRv5Go30+/ApFfdscCs3u/29kR2So/SM=;
 b=LHVKw+ugT4+H6w29Q4+ygFM/sHK92IE9m7RdIPyu0EoLFX3G2mcUttkLN3XFM3PIvM
 JoKBVZUjI+FeWCedkvgn7ISmq87hAivcDRaMn+uJV1fMUAl0gBA5soOoJjO3Rwkur47P
 zueyIb0aXUgVe73Vd0g2rmnNdicbHCQBAe69QxF97z7cbZMkLUzG9mBZbxiVydWHsfM9
 hita4y6cjqTYZSERvH6fBFMhVmjBg3Nc1QiYtIu41PrY+27OKeFXdaHGtB8KavjRREEx
 gL/KRwwWfUr5ZjsLa5+dLxjzQWkFSEjybF511Ao/fp6xfuZmsQG3lD60uYMGcQ4xNJEc
 ec5g==
X-Gm-Message-State: AOJu0YyWyMkcsr5qBoO3Di6HqAUR/tWFQycujy/TyT+LQ8bmanYSsoUs
 s+EmzRFVOa16YN+27LYjMVzZ5jMRT/VADZ4JfHd9pqNFQHwxZxHLXMwIzNj0x35oF/MKUkmARiQ
 w/lD9
X-Google-Smtp-Source: AGHT+IEkH89/RQARGXBmggp7pTlGFJ3AhK1aUJH/wt7O+0YWBOjSkVzd3V4w85NJ7eAVGAY1po5I7Q==
X-Received: by 2002:a05:6e02:1aaa:b0:3a0:8f99:5e00 with SMTP id
 e9e14a558f8ab-3a345145870mr82156235ab.4.1727661016087; 
 Sun, 29 Sep 2024 18:50:16 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 09/33] scripts: Define CONFIG_XPL_BUILD for all xPL builds
Date: Sun, 29 Sep 2024 19:49:32 -0600
Message-Id: <20240930014956.1434060-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

The new name 'xPL' is intended to indicate a build of any phase which is
not U-Boot proper. Define it for all such phases.

Note that we also define CONFIG_SPL_BUILD for all xPL builds. This
preserves existing behaviour, but future patches will adjust that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/Makefile.autoconf | 6 +++---
 scripts/Makefile.xpl      | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index b42f9b525fe..d7544022a31 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -83,15 +83,15 @@ u-boot.cfg: include/config.h FORCE
 
 spl/u-boot.cfg: include/config.h FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD)
+	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD)
 
 tpl/u-boot.cfg: include/config.h FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD -DCONFIG_TPL_BUILD)
+	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_TPL_BUILD)
 
 vpl/u-boot.cfg: include/config.h FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD -DCONFIG_VPL_BUILD)
+	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_VPL_BUILD)
 
 include/autoconf.mk: u-boot.cfg
 	$(call cmd,autoconf)
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 3091311a3d2..ad21d451a30 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -21,15 +21,16 @@ include $(srctree)/scripts/Kbuild.include
 
 -include include/config/auto.conf
 
-# This file contains 0, 1 or 2 lines
+# This file contains 0, 2 or 3 lines
 # It is empty for U-Boot proper (where $(obj) is empty)
-# For any xPL build it contains CONFIG_SPL_BUILD=y
-# For TPL builds it has CONFIG_SPL_BUILD=y and CONFIG_TPL_BUILD=y
-# For VPL builds it has CONFIG_SPL_BUILD=y and CONFIG_VPL_BUILD=y
+# For any xPL build it contains CONFIG_SPL_BUILD=y and CONFIG_XPL_BUILD=y
+#    - for TPL builds it also contains CONFIG_TPL_BUILD=y
+#    - for VPL builds it also contains CONFIG_VPL_BUILD=y
 -include $(obj)/include/autoconf.mk
 
 UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
 
+KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
 KBUILD_CPPFLAGS += -DCONFIG_SPL_BUILD
 ifeq ($(CONFIG_TPL_BUILD),y)
 KBUILD_CPPFLAGS += -DCONFIG_TPL_BUILD
-- 
2.34.1

