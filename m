Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F3DC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1423865F4;
	Thu, 31 Aug 2023 05:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QD4EeeWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46198658D; Thu, 31 Aug 2023 05:53:41 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D861B8657F
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7950fac19f2so17717939f.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454017; x=1694058817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=943ed1pUiSP1Zkzvsm8A1bvAC4BW8aeHAipc3ycPfgk=;
 b=QD4EeeWowsKQLwCZbwr6VPRebz60im85yW1zGIhtb34o84fS9Gz9VU8dZ/tqLWMShf
 RVLI0XsH1PiX0mp4N4WRw/0KIjg+E+Z4fYbTxIm+gupznetJ4/UsjsB/0XJGupEBRJwt
 C9WKHGezvLS7mxERc7aJE9kJDwt+WYZH+yFjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454017; x=1694058817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=943ed1pUiSP1Zkzvsm8A1bvAC4BW8aeHAipc3ycPfgk=;
 b=jHmnkmpSs18+72ZE+BSSCGTdWjddaveBy0L0t+y6Vv78POf4jR4odiHGq3P7gnG4Ut
 KsCMH2nLZekqzBoAwrDLQzl1/pc1Bv2s1ESNNni1rT8nm/0gTKVLjetG0d1E9dAUSbDq
 6e7IZjUU1qoEyQ/SnmaPTsXvXBMtJsnw0rXExIddQ+N3tWg7HUzUSrdh6l+r34DcyF9a
 LBc2+aYoP17IzeUAnNWeU4TsOs3+z0+aqJIOaqf2w1DYudVKovdZ2jPXtDWR/KBx4Svk
 aThQ8PcRW9WxpIbEJZvWzfnkKnTQKL0mZvoXHUZcMm3ozw9lZlKINxNYW15bU20XdZ9c
 WXcw==
X-Gm-Message-State: AOJu0YwQrjipU4+qu50UT0ICCJ811jfJkN09xC4xa+rNyV1/UzAtplcz
 jV5wMaOM1SSlVOQulCQPQTQRSEg2AM96J2TJFZk=
X-Google-Smtp-Source: AGHT+IG75z3I2MK8/SuhpMFOhZnNuDnacGDi0ZtUAENd5/gxuY7ZiV7hrGYNfmNflQ2HW6GG81ewlQ==
X-Received: by 2002:a05:6e02:6c8:b0:34b:ba9b:c764 with SMTP id
 p8-20020a056e0206c800b0034bba9bc764mr4009243ils.18.1693454017473; 
 Wed, 30 Aug 2023 20:53:37 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/19] Move fdt_simplefb to boot/
Date: Wed, 30 Aug 2023 21:53:03 -0600
Message-ID: <20230831035319.2316665-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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

This relates to booting, so move it there. Create a new Kconfig menu for
things related to devicetree fixup.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig                    | 16 ++++++++++++++++
 boot/Makefile                   |  1 +
 {common => boot}/fdt_simplefb.c |  0
 common/Kconfig                  |  9 ---------
 common/Makefile                 |  1 -
 5 files changed, 17 insertions(+), 10 deletions(-)
 rename {common => boot}/fdt_simplefb.c (100%)

diff --git a/boot/Kconfig b/boot/Kconfig
index 86ccfd780312..025fa01d782c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1538,6 +1538,22 @@ config SPL_IMAGE_PRE_LOAD_SIG
 
 endmenu
 
+if OF_LIBFDT
+
+menu "Devicetree fixup"
+
+config FDT_SIMPLEFB
+	bool "FDT tools for simplefb support"
+	help
+	  Enable the fdt tools to manage the simple fb nodes in device tree.
+	  These functions can be used by board to indicate to the OS
+	  the presence of the simple frame buffer with associated reserved
+	  memory
+
+endmenu
+
+endif # OF_LIBFDT
+
 config USE_BOOTARGS
 	bool "Enable boot arguments"
 	help
diff --git a/boot/Makefile b/boot/Makefile
index f15a161614ff..6ce983b83fa4 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
+obj-$(CONFIG_$(SPL_TPL_)FDT_SIMPLEFB) += fdt_simplefb.o
 
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
diff --git a/common/fdt_simplefb.c b/boot/fdt_simplefb.c
similarity index 100%
rename from common/fdt_simplefb.c
rename to boot/fdt_simplefb.c
diff --git a/common/Kconfig b/common/Kconfig
index 2f46fdb3f62c..9693c0ac426f 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1156,14 +1156,5 @@ config VPL_IMAGE_SIGN_INFO
 
 endif
 
-config FDT_SIMPLEFB
-	bool "FDT tools for simplefb support"
-	depends on OF_LIBFDT
-	help
-	  Enable the fdt tools to manage the simple fb nodes in device tree.
-	  These functions can be used by board to indicate to the OS
-	  the presence of the simple frame buffer with associated reserved
-	  memory
-
 config IO_TRACE
 	bool
diff --git a/common/Makefile b/common/Makefile
index 0948721d0b47..5c1617206f07 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -17,7 +17,6 @@ obj-y += board_r.o
 obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
 
-obj-$(CONFIG_FDT_SIMPLEFB) += fdt_simplefb.o
 obj-$(CONFIG_MII) += miiphyutil.o
 obj-$(CONFIG_CMD_MII) += miiphyutil.o
 obj-$(CONFIG_PHYLIB) += miiphyutil.o
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

