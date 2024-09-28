Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EE9CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B732A88D36;
	Sat, 28 Sep 2024 22:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f/znSD6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C17B88D36; Sat, 28 Sep 2024 22:01:00 +0200 (CEST)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF4C88CB8
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-3a27668e995so10565205ab.3
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553656; x=1728158456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhjGQCF6hpgReyfb+S9TnD3lbi5K+gFtmrf3eQB15TY=;
 b=f/znSD6s7ONKIIbWweHM/PuFnKMqBaPQ+NHiT3hq8gYjT65lgecrx2QcBN+1ri4Xm7
 NwyKvXVcPj2QrvcbiIUic9FGO8qjUhrO7oaifmxnEUulpzlJHlHbSx+MEhAacymf09u4
 ziuqiBcBSUuKdmi8pc82f3+0jBMu5JpwX/Xiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553656; x=1728158456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhjGQCF6hpgReyfb+S9TnD3lbi5K+gFtmrf3eQB15TY=;
 b=WNTOsmRbVcyFbL8DXU9Mvnvqv2PLR97Wsxm3ANmYMr9B/iXoGyyU1bgtzeGY7+BEaI
 IAKReMmENpcWfQprU2WU9CShcShJ+h0DtcnLhqoJ6IqTspIEBOJKt/MMsAjbYu9FWjfY
 SbmNq6U5nkhLPGKv0eRBi10dnabH7WuWz5igJixBXX4iM1M4H07iky9K3MF24kgmGAFl
 7nzt5pCnBUPQ0eHJWmrLry+5jV6iwNFysX8vnxAlkxQ/d+kpxY1p0Jk4okLLnIqfVdiK
 mxxUSeUT50LzIl2INaX7/LkG4Pqjki6ZZpk0ytsQHQtQmu2ahepXITZpz2YBm6LwTtQ/
 RfDw==
X-Gm-Message-State: AOJu0YzGgis5CPPwCOHLGql+sVDN1LlHpii+I9XbC/YBl6VzkqmlNsom
 yJwnXIaoOYOa7cgd+2+zZYZvk/Cee16Shk/3bX+nZqu321GbLb7ccqFctUagq5wziTwTno0cPtL
 ZC74n
X-Google-Smtp-Source: AGHT+IEF+1iPDqVVTw7xu7hk+/sNYpmTudBD4WmnE5XuKYFY29dayNfkoLdu3l4FCsouanVbCJALaA==
X-Received: by 2002:a05:6e02:216b:b0:3a0:a26f:7669 with SMTP id
 e9e14a558f8ab-3a345169020mr56906795ab.7.1727553656318; 
 Sat, 28 Sep 2024 13:00:56 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Nishanth Menon <nm@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 13/30] xpl: Define CONFIG_SPL_BUILD only for the SPL build
Date: Sat, 28 Sep 2024 14:00:13 -0600
Message-Id: <20240928200030.194546-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Make this define mean SPL only, not TPL, VPL, etc.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/Makefile.autoconf | 4 ++--
 scripts/Makefile.xpl      | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index d7544022a31..c1eab2f3a1d 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -87,11 +87,11 @@ spl/u-boot.cfg: include/config.h FORCE
 
 tpl/u-boot.cfg: include/config.h FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_TPL_BUILD)
+	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_TPL_BUILD)
 
 vpl/u-boot.cfg: include/config.h FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_VPL_BUILD)
+	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_VPL_BUILD)
 
 include/autoconf.mk: u-boot.cfg
 	$(call cmd,autoconf)
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 63d4ec334bc..b43ff998679 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -21,9 +21,10 @@ include $(srctree)/scripts/Kbuild.include
 
 -include include/config/auto.conf
 
-# This file contains 0, 2 or 3 lines
+# This file contains 0, or 2 lines
 # It is empty for U-Boot proper (where $(obj) is empty)
-# For any xPL build it contains CONFIG_SPL_BUILD=y and CONFIG_XPL_BUILD=y
+# For any xPL build it contains CONFIG_XPL_BUILD=y
+#    - for SPL builds it also contains CONFIG_SPL_BUILD=y
 #    - for TPL builds it also contains CONFIG_TPL_BUILD=y
 #    - for VPL builds it also contains CONFIG_VPL_BUILD=y
 -include $(obj)/include/autoconf.mk
@@ -31,7 +32,9 @@ include $(srctree)/scripts/Kbuild.include
 UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
 
 KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
-KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
+ifeq ($(CONFIG_SPL_BUILD),y)
+KBUILD_CPPFLAGS += -DCONFIG_SPL_BUILD
+endif
 ifeq ($(CONFIG_TPL_BUILD),y)
 KBUILD_CPPFLAGS += -DCONFIG_TPL_BUILD
 else
-- 
2.34.1

