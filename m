Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAB5C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DACC869E3;
	Mon,  4 Sep 2023 16:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ia/rg4QA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FB318693D; Mon,  4 Sep 2023 16:41:53 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C28F0846D2
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-792717ef3c9so46220839f.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838508; x=1694443308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0xcmwv6BzSPJwNDgfIuzrB9VyVCaYJP41wzNJUVwgg=;
 b=ia/rg4QAL5Af2xZdxBSpOQ2mkqgu2+mrG+8CyMkZzyB2S6kyPSLY4iWnWviBYr4KDQ
 x1ygdk0q0+MTYu/XyWTaUxrSA0MB5fzJ88sNyqNyIgXTs4lLofRjhPJMUfQsEkv52tSE
 cpgIx+SRNv4zzWQU20B1oUfgeNFhXpByub/TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838508; x=1694443308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0xcmwv6BzSPJwNDgfIuzrB9VyVCaYJP41wzNJUVwgg=;
 b=Pv1l+1bKp1dkGRlrPkX14vMzfVwQLEAedeolXg93jWFXimGBRVR1c8YwnGkGlHDvfJ
 UFyBf5s3WaIWpeEep3fsgc8mJPWpAFyy46K49BuKltDQPqSwMz0BbgBX03PjsSl/o9x6
 ZID7hJ/yl2o96c2NgZSEwvANx3RfYw8N7kS31gNBuuUea8CSauNEHM/G8if6lKbLzBV/
 mdjA2m2jB+zMF/Y8JdHoKOVCJTvDONvrkoYEkaCgPcnQiWR53Tn/xHr0Hq0rWqEMFBJS
 LQ9guIBYx4bbm/Jx/c4kf+rXJufb0z+tDAjSmKrMKj40uvsQq+VVv2wZNHjgXjecZXAI
 FSxg==
X-Gm-Message-State: AOJu0YzThU6+7DIeAnYCybK+7M9VegLqnp5D0u1lWUvUw2Umt5vVE7j8
 wqXm1Dhz5JCnjW3z7Th6bKfnFX04JnQH1xZrfoI=
X-Google-Smtp-Source: AGHT+IHmsFpLuxytSgW9E7DplLbvJBEq98PommtGNdblAM5tGr+pcS7oFYg/v3Gv+p4QttBj+s3lzQ==
X-Received: by 2002:a05:6e02:219c:b0:34e:1f27:2e5d with SMTP id
 j28-20020a056e02219c00b0034e1f272e5dmr7297628ila.14.1693838508399; 
 Mon, 04 Sep 2023 07:41:48 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 09/20] Move fdt_simplefb to boot/
Date: Mon,  4 Sep 2023 08:41:12 -0600
Message-ID: <20230904144131.2699824-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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
index d11292f52c2b..21eaa5e815f9 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1157,14 +1157,5 @@ config VPL_IMAGE_SIGN_INFO
 
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
2.42.0.283.g2d96d420d3-goog

