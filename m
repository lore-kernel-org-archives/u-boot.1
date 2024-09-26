Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC65CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D903488F12;
	Fri, 27 Sep 2024 00:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LnIeGEGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D88188F12; Fri, 27 Sep 2024 00:41:48 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B2488EA3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-4581d2b0fbaso9663921cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390505; x=1727995305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX0MJyqF9F9Kid8py+zUqWPWLfVJEWYGa5UwpFhDgZk=;
 b=LnIeGEGOgCsvnn1wU63RidM8ySl9AonuuLdfWfs683jlm19+gm5Q/F3qW50bVkxSYh
 /AoQ2R9+IE3xgTD3NFiGuGI8XkV6zt3uu27omp2lYfWcjg3MvfDuf+PH0JBx2sqnb9ZB
 qvI2E7Y+UmqmuzPzEdlPjAn5G0xJU8l5nw+as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390505; x=1727995305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oX0MJyqF9F9Kid8py+zUqWPWLfVJEWYGa5UwpFhDgZk=;
 b=hxU6FKiLYHqd6GJGudQWhmu+8j1JH/yj+NYl7mnvSKq8iQwDGaldA4Lf+7M1Qxi7hJ
 fqS+dxhvkIIbOLIm3X67zA/0aQTCQkaIywm020mSF+zGD6MDJ/dRsWN7bzxh1s89cCbY
 7ebesD8QIBA+NDsIMu/apF2qiWhnH4/0rcv3n7IokS5/VvKEapHnoTG/lWKKNZdQp9ju
 rHtxHK6CtJUy0+v1CuObLarfMbLRp6nJAhOq2Qilh0pB6AcVw+ObOYH5nIPRkNphM4P4
 aH8jwrGUfLptDE/tb5c7KdE6yhJ0IM6Z2ctkHLnFK08sjhMIGrAXUBuwpvYk2e4BVw1P
 SL/A==
X-Gm-Message-State: AOJu0Yx1jUWrQUAFt3LfM/eEhTB2rl8ig78imbMJdNp7WMQEoQcGwuNk
 E0X0zSRKh/splFixNIkoxP+AfynJvu6jzuiUkIJGAT3cwe2FpXv2GR5tUOYN6au1utEbKtJME80
 ABmZB3F9irQ==
X-Google-Smtp-Source: AGHT+IHxLbQQ38RGKIcYNoXMjhsz5+hHwB4xcg1YvOVniMwL5MuaOfASDhQziNUyxGmvU/0wG+auDw==
X-Received: by 2002:ac8:5856:0:b0:458:3e19:8271 with SMTP id
 d75a77b69052e-45c9f20f575mr15389881cf.34.1727390505292; 
 Thu, 26 Sep 2024 15:41:45 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:41:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 13/42] xpl: Define CONFIG_SPL_BUILD only for the SPL build
Date: Fri, 27 Sep 2024 00:35:38 +0200
Message-ID: <20240926223814.1276764-14-sjg@chromium.org>
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

Make this define mean SPL only, not TPL, VPL, etc.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
2.43.0

