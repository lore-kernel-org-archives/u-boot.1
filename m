Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7CCDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27E8188EAF;
	Fri, 27 Sep 2024 00:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZDp7PTxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D407D88966; Fri, 27 Sep 2024 00:40:01 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCD788966
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-6cb3ba0a9a2so2406736d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390398; x=1727995198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cCHZrCtAKc87OtQknk6c9sa3qAJ+gy/4gHlWpsgUvE=;
 b=ZDp7PTxXd5U4gd8oiwBCKfWNHfobIYMTZEKKpwUFI/n8/UtdI9dzd+414f2wPYxn+S
 FusApX1GKxPBPwsI1BPxAvwBmTAl1IKHuxyJvE3Z/dyCdFlg5FOV1n2JnULSh9r7cN8h
 QYLovotkkJ1RAqYahjpJ4GeO2xFkYlzzpPrmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390398; x=1727995198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cCHZrCtAKc87OtQknk6c9sa3qAJ+gy/4gHlWpsgUvE=;
 b=nsieKOMyAxSZIwUrYl1l8k54Lr3cHxA307Ip2f2NhuxUguhMnp9uDhXG9fp/xL4kTi
 K5f8nQ2qtHE6Ctd7RsoNDv65Gj57rLsKazGLY+W7epzYT0BoAx15wfpcbi0rzx9pbcSa
 D071ib9PNsanvqDPhXF91EHqxp45HWJNgsRJGkz7WJHSGc7Ra/uGS3eb2FL2D5olo+1/
 YUBGOirEU1+zelqTRg2O0uwSOOgahoLQwTdsJ1tTH2APsV08yy3Nmkt+KzrttxWOuAHj
 KaBeEZRXIC8ZO7EKsDQ6c7J/oQHu5H2DToMLJiGXdA4AEVwf+z+Qy5DmdZeKU8E3ZYKP
 uQCA==
X-Gm-Message-State: AOJu0YwSYtgtn+JkXlBbL4ksRNimO7+07KRykg9gecNUpER/QBrBopvR
 y0noLV+SCBdhyT1zNEO86OGiOvktYhxH8sc3jxWXzs9XkH8rt8Z8Mu922lTKIAK2ddJHid/KhRT
 jdy0sH08RGw==
X-Google-Smtp-Source: AGHT+IELXqK3AtYGHF3N90F9TDZWQA/m+sKEP/s0h2nVfHhtopLrDYeNpafJhY9DjTsj8WMrn+QIog==
X-Received: by 2002:a05:622a:47:b0:458:17d1:cc57 with SMTP id
 d75a77b69052e-45c9f1e20bcmr13652451cf.4.1727390398428; 
 Thu, 26 Sep 2024 15:39:58 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:39:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH 04/42] scripts: Define CONFIG_XPL_BUILD for all xPL builds
Date: Fri, 27 Sep 2024 00:35:29 +0200
Message-ID: <20240926223814.1276764-5-sjg@chromium.org>
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

The new name 'xPL' is intended to indicate a build of any phase which is
not U-Boot proper. Define it for all such phases.

Note that we also define CONFIG_SPL_BUILD for all xPL builds. This
preserves existing behaviour, but future patches will adjust that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
2.43.0

