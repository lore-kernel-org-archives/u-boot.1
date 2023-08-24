Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36984C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9939386A84;
	Thu, 24 Aug 2023 21:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AjeYnDe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9DA986A6C; Thu, 24 Aug 2023 21:59:41 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3E486970
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7927182dfe3so8032739f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907176; x=1693511976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unrAzs+YoCgcDwcgfx0x5WAMXAhPV7QR7bkNZW7e8GE=;
 b=AjeYnDe+2W0z5H9e4Wey/RpI5Du1lt4NBhVWOU3tEl9KsuAHTUKxtMVojCiVwb3bvc
 AAQFnASQSJco+RLfNIf4bod03RZO3vo9An9GZdYxQutroGfyesRtiMjQYWBrtMLxGBwM
 MxC0XsE1R7jUw++TeYx/0PkTpeFRR4NFMa3UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907176; x=1693511976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=unrAzs+YoCgcDwcgfx0x5WAMXAhPV7QR7bkNZW7e8GE=;
 b=SiuB/xpe699nBMgCLJ7xVcRyQULwJJjZtRy+vYVr5D7DF7ypxDrHrkgDbi/LSbKWG7
 Z+kr1A5SiOWD3Kjv52UrHemy7PRq9fFqEjwX0wNdXacimbHWyLDXhBnop6bsqT5a6QSg
 wb8mcYN/7m6w1o8dJh1vi9wyDPBlXnC7BEZiCe7LwYKYQ4YKeGoVDzLyzxyyH5tP1DwF
 LTuFNwDR0s4zyFkx3pTatx4BRbCP61HuyqICNoB76Fhq/FleirtkNBbOJIhBvPuC8G1B
 mJZeFIVbCsGH3gbYrpbvUxqZLSCTfRHQ6yccOxvbxy6+uBFjleeGkTcnUA6jPiDWKDRR
 bCIA==
X-Gm-Message-State: AOJu0YyMQDM4Ov3DlH3bSSpPVi2H8uvgnY+9vgRgrTqY1qrJiym77Tjh
 p+i2Oc/45XQCdFr1c0TjLBhLWRRxWP5050zZRWo=
X-Google-Smtp-Source: AGHT+IENLavPKLDh8MDtLcRE1eBA8bEDW3mlphdlfor1BLsBvw8b1EDexBXf/ldpNMJEPY1HJ4scjQ==
X-Received: by 2002:a6b:e30b:0:b0:792:7f26:dc95 with SMTP id
 u11-20020a6be30b000000b007927f26dc95mr163388ioc.14.1692907176427; 
 Thu, 24 Aug 2023 12:59:36 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH 09/19] Move fdt_simplefb to boot/
Date: Thu, 24 Aug 2023 13:59:00 -0600
Message-ID: <20230824195917.1687886-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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

 boot/Kconfig                    | 16 ++++++++++++++++
 boot/Makefile                   |  1 +
 {common => boot}/fdt_simplefb.c |  0
 common/Kconfig                  |  9 ---------
 common/Makefile                 |  1 -
 5 files changed, 17 insertions(+), 10 deletions(-)
 rename {common => boot}/fdt_simplefb.c (100%)

diff --git a/boot/Kconfig b/boot/Kconfig
index 5e2d4286aeaa..1b2ac7451a61 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1535,6 +1535,22 @@ config SPL_IMAGE_PRE_LOAD_SIG
 
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
2.42.0.rc1.204.g551eb34607-goog

