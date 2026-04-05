Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA3FE64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 10:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 532EC8394E;
	Sun,  5 Apr 2026 12:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dnk4xL9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF8FF800AE; Sun,  5 Apr 2026 12:42:56 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838288394E
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 12:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-68397b9840cso250354eaf.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775385772; x=1775990572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7WdteUf94HS5J9ezBC8Kp/fNC9aTr4uqjNqF7FMx0Q=;
 b=Dnk4xL9/dJPIseMKWYiTfUV2SBn0wk9dGvFVuDhfKH+MaYrCfOo62wOMZdKHrOEZWt
 mxXSzGo05cpnA1XIEdSKvrz/8mk59VHfqbeD0ZJRqL7cUnby0FX+JOU0ywugXGYFqut9
 ncnv3jeBVvvq51dN+SHgXFlL5MqCEAZip8qEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775385772; x=1775990572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7WdteUf94HS5J9ezBC8Kp/fNC9aTr4uqjNqF7FMx0Q=;
 b=YVDy6OKhU3CexAiWbpbFWDTMQ6wE631dvdUSHKxUVpCUzOZ/7hz8hVb8+TQ+s7vAGD
 f5X53o0ONSUDTaU6zEJXe21XDKHU1r77CYtz+8sREgbbiOcUNwHCdh+dYmR/vrrNbCGr
 PNekgqeNX7PBbw7pxtFJCjy5sbzbCeV9qYPbNjxAnj3ngq/iqC9tcKkqE0cgZYqLah/+
 DbOsEiHRo0bAwNJLw/JJVOThDib+QoPfrtc8D5viC+GvxIuXg1R5oZ4l2IfMND8ff3JH
 cj6BXFt8NAXw/kwCoimlIRxiJeb6X6TprL7sZYaD3oBfPk0Nm/sgLsOAQxxwl7IUC5pJ
 rnFg==
X-Gm-Message-State: AOJu0YwlMu43rMsAp10sXfdkkvbZhsvR1u5rfqJdMgXwJh1OdSh9Zsle
 z8GgTkZdwSsjl+AO655XQpPExlCrlPhQpCQ2EITi1whVzfOHJDhz9dAD78JUuU1VExELyLLQSpp
 k0T/t1Q==
X-Gm-Gg: AeBDievTiAWFcgWZNhfjLRL6q+IQ53gcjts7eFY7gZhdecWVqikXGdddDyVVdLvUtWG
 K8V8UzWInEoYRx/BMjEAXNh9dAeEIvN/64R1XoLJ2AcKpnTBceAXZ5FBmHHUk5lIrkNQ94cWPpK
 dWUPqR1dp7Qmmesx9xYND8l4tnIVHQWzI55e2BiH+4eq5ILrpS8JPQkP3FTgRKPN/6tJuHIZWDW
 ZRPNUeEnJlBeBgJ5w0zkoau6CkcgFaxtV3eau9cgvJEg6CvF9nNzHnLkZ9FGqwUoDb0ZiQChDng
 YkZfiT6mmEWwDazSLkTIxmF4FwoxUFDapDk2Zec+HcG3n537AGTxPhpfoECMtf6X+ItkWupZoDn
 e13adpUuPFj6FdediEWo8jlJKCPpx/ysEYSiBYCwqfTr/6wY391BDVLV5XMZBa0MCyPsHr40Ni6
 umEBBE4qn9Fn6Kb5mX3g==
X-Received: by 2002:a05:6820:3095:b0:684:384b:80b4 with SMTP id
 006d021491bc7-684384b84ecmr1953782eaf.15.1775385772529; 
 Sun, 05 Apr 2026 03:42:52 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42330d4a3c1sm3914436fac.1.2026.04.05.03.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 03:42:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] kbuild: Use if_changed for font and splash .incbin
 rules
Date: Sun,  5 Apr 2026 04:42:21 -0600
Message-ID: <20260405104224.530051-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405104224.530051-1-sjg@chromium.org>
References: <20260405104224.530051-1-sjg@chromium.org>
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

The generated .S files for fonts and splash screens use .incbin with the
full prerequisite path. When building with O= this bakes an absolute
path into the .S file. If the build directory is later used on a
different machine (e.g. in a container), the assembler cannot find the
source file.

Follow the existing DTB convention: rename the object targets to use
compound suffixes (.ttf.o, .bmp.o), switch the pattern rules from
direct $(call cmd,...) to FORCE + $(call if_changed,...), and register
the new suffixes with intermediate_targets so that kbuild loads their
.cmd files. This lets if_changed detect when the recorded command
(including source paths) has changed and regenerate the .S file
automatically.

The EFI rule is left unchanged since its prerequisite is a generated
file in the build directory, like the DTB and DTBO rules.

Suggested-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use if_changed with compound suffixes (.ttf.o, .bmp.o)

Changes in v2:
- Move U-Boot .incbin rules to Makefile.lib-u-boot first (previous patch)
- Drop the EFI .incbin change since .efi files are generated, not source
- Use per-file AFLAGS instead of modifying a_flags in Makefile.lib

 drivers/video/Makefile       |  2 +-
 drivers/video/fonts/Makefile | 10 +++++-----
 scripts/Makefile.build       |  4 +++-
 scripts/Makefile.lib-u-boot  |  8 ++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 984768ea156..dbc3018d716 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
 obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 
-obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.o
+obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
 obj-$(CONFIG_$(PHASE_)BMP) += bmp.o
 
 endif
diff --git a/drivers/video/fonts/Makefile b/drivers/video/fonts/Makefile
index 1111f92a2c6..4d32fa43994 100644
--- a/drivers/video/fonts/Makefile
+++ b/drivers/video/fonts/Makefile
@@ -3,8 +3,8 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_CONSOLE_TRUETYPE_NIMBUS) += nimbus_sans_l_regular.o
-obj-$(CONFIG_CONSOLE_TRUETYPE_ANKACODER) += ankacoder_c75_r.o
-obj-$(CONFIG_CONSOLE_TRUETYPE_RUFSCRIPT) += rufscript010.o
-obj-$(CONFIG_CONSOLE_TRUETYPE_CANTORAONE) += cantoraone_regular.o
-obj-$(CONFIG_CONSOLE_TRUETYPE_DEJAVU) += dejavu_mono.o
+obj-$(CONFIG_CONSOLE_TRUETYPE_NIMBUS) += nimbus_sans_l_regular.ttf.o
+obj-$(CONFIG_CONSOLE_TRUETYPE_ANKACODER) += ankacoder_c75_r.ttf.o
+obj-$(CONFIG_CONSOLE_TRUETYPE_RUFSCRIPT) += rufscript010.ttf.o
+obj-$(CONFIG_CONSOLE_TRUETYPE_CANTORAONE) += cantoraone_regular.ttf.o
+obj-$(CONFIG_CONSOLE_TRUETYPE_DEJAVU) += dejavu_mono.ttf.o
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index e625f99986e..067c38c4cdd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -438,7 +438,9 @@ intermediate_targets = $(foreach sfx, $(2), \
 targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
 	   $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
 	   $(call intermediate_targets, .lex.o, .lex.c) \
-	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
+	   $(call intermediate_targets, .tab.o, .tab.c .tab.h) \
+	   $(call intermediate_targets, .ttf.o, .ttf.S) \
+	   $(call intermediate_targets, .bmp.o, .bmp.S)
 
 # Build
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.lib-u-boot b/scripts/Makefile.lib-u-boot
index c55f8d8e0c3..4d60a8eee49 100644
--- a/scripts/Makefile.lib-u-boot
+++ b/scripts/Makefile.lib-u-boot
@@ -20,8 +20,8 @@ cmd_S_ttf=						\
 	echo '.balign 16';				\
 ) > $@
 
-$(obj)/%.S: $(src)/%.ttf
-	$(call cmd,S_ttf)
+$(obj)/%.ttf.S: $(src)/%.ttf FORCE
+	$(call if_changed,S_ttf)
 
 # Splash logos
 # ---------------------------------------------------------------------------
@@ -40,8 +40,8 @@ cmd_S_splash=						\
 	echo '.balign 16';				\
 ) > $@
 
-$(obj)/%.S: $(src)/%.bmp
-	$(call cmd,S_splash)
+$(obj)/%.bmp.S: $(src)/%.bmp FORCE
+	$(call if_changed,S_splash)
 
 # EFI applications
 # A Makefile target *.efi is built as EFI application.
-- 
2.43.0

base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
branch: font-us3
