Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873A510A1E83
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EFC183FD3;
	Thu, 26 Mar 2026 12:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f+b6rKLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6751783FD9; Thu, 26 Mar 2026 12:55:20 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31CC183FA3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-466ec4c6846so277646b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774526116; x=1775130916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQ9u+pAhrAF7QXuAgzwslLohwNno4IFo+TFQM6izD54=;
 b=f+b6rKLp3SJm9GYCy/SDYlFkjfXvG/5SQ2f971Om0K9FIiGJVbp3VjF4OIQZ3Hn27P
 9SamVoxMKrC3fXmRhVVS4bpCc8gsdjIcolzNy5kVRyTknXcu092TFqZ5S4MGtqONZl7N
 fMFPUig1uDd+KTb9EOVjtqHk7eb5bHrdkvtUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526116; x=1775130916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yQ9u+pAhrAF7QXuAgzwslLohwNno4IFo+TFQM6izD54=;
 b=Ehz/5DSdvKlUECrs2cniyZQK+HZhxH51FMdBC3MyLnv6FY8S4GGt7SFJ1r6TWUOj8+
 JSQT7Jc50tE+m3PGkQrQdYosDh7Z8l62TIBTzQhBurFu9AJGkhS00uYllw7oAqoKP44h
 WGu2Le+EC1v5L7DiSxYO25LB5Lk6xNjUrPkSwr4gLJqvSsCkOCpamKGWeEoguWz52ZME
 B3tNoSAz6rO5AI7UNCc37tbcGttEl4qNJVUKpTePb/cmyNQxUNp92gKrPUu+G+e6w5lB
 QFnBqUUEi8TQXwMLToKVzb2vVwx+7Ol33hzKJNNvemqYZN8Vpt6YxtmhQIsLkavbp0zN
 FMDg==
X-Gm-Message-State: AOJu0YxcdQSEo8Wdhd6K0Nw2fT8BJwY21kdNzw2ljiMDXY8U0w0LekOp
 Y/Xjl7ofHZiE3HSXTDRWPnjqXzsS7q/AjNt5h9Yf0I1gWubjf0xbxfF9gVmiF2PGOwg+WaqC7lE
 T5Ps=
X-Gm-Gg: ATEYQzzYt1/Wu8OO2W+0LF7+jUWzVF9kfxHDMBu+9F/UpY3jw4LUrQ6buC+KU8Yqm6f
 j1CCB0s+LkK+OyF/ARNVblvNKsqyKndOyX//iCBZl/hDYV2bxd5LrOrGnsfAHcDmvFdM2dkSmOi
 vkQOzNNWgzv1fOIFL/NhVmjQRPxz7VHuhPd6+0VWKeyvE5r366ioBKLHR8cOLl23wMi0LULAtPz
 hOGZnKBUq4ccAFSOf7QWOFoQKR2f8rTUk+0W5Gxqy66GedTT4x6a2D+tAjM93B5dLm9zs/a6BnR
 GRm7lv7W7xh8wCwuc+PIgkMMIjAXSFBNEtCQQMKEphXFgAyZHhTjXriTs8d2qlF9N+1vMj4tjXO
 6IDRFrrhKEBAWsuq0kuQS/vqWGTr75qRIPD0EqWfbzp9Rql1iqCbKTwpkYoJwLb+vJqMEMzItFF
 s4GT1weYMYDfjzVJNmjg==
X-Received: by 2002:a05:6870:1436:b0:41b:f7f5:e887 with SMTP id
 586e51a60fabf-41ca6fc02a7mr4232975fac.24.1774526116288; 
 Thu, 26 Mar 2026 04:55:16 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc7b6312csm2145860fac.15.2026.03.26.04.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:55:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] kbuild: Use relative paths in generated .incbin
 directives
Date: Thu, 26 Mar 2026 05:54:57 -0600
Message-ID: <20260326115500.955388-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326115500.955388-1-sjg@chromium.org>
References: <20260326115500.955388-1-sjg@chromium.org>
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

Use $(src)/$(notdir $<) instead of $< so the .incbin directive contains
a source-relative path like drivers/video/fonts/nimbus_sans_l_regular.ttf
rather than an absolute one. Add per-file AFLAGS with -Wa,-I$(srctree)
in the subdirectory Makefiles so the assembler can resolve these paths,
keeping scripts/Makefile.lib free of U-Boot-specific changes.

The EFI rule is left unchanged since its prerequisite is a generated
file in the build directory, like the DTB and DTBO rules.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Move U-Boot .incbin rules to Makefile.lib-u-boot first (previous patch)
- Drop the EFI .incbin change since .efi files are generated, not source
- Use per-file AFLAGS instead of modifying a_flags in Makefile.lib

 drivers/video/Makefile       | 1 +
 drivers/video/fonts/Makefile | 8 ++++++++
 scripts/Makefile.lib-u-boot  | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 984768ea156..020b6680345 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.o
+AFLAGS_u_boot_logo.o += -Wa,-I$(srctree)
 obj-$(CONFIG_$(PHASE_)BMP) += bmp.o
 
 endif
diff --git a/drivers/video/fonts/Makefile b/drivers/video/fonts/Makefile
index 1111f92a2c6..a2ac4bd40b3 100644
--- a/drivers/video/fonts/Makefile
+++ b/drivers/video/fonts/Makefile
@@ -8,3 +8,11 @@ obj-$(CONFIG_CONSOLE_TRUETYPE_ANKACODER) += ankacoder_c75_r.o
 obj-$(CONFIG_CONSOLE_TRUETYPE_RUFSCRIPT) += rufscript010.o
 obj-$(CONFIG_CONSOLE_TRUETYPE_CANTORAONE) += cantoraone_regular.o
 obj-$(CONFIG_CONSOLE_TRUETYPE_DEJAVU) += dejavu_mono.o
+
+# The .S files generated from .ttf fonts use .incbin with a source-relative
+# path, so tell the assembler where to find the source tree.
+AFLAGS_nimbus_sans_l_regular.o += -Wa,-I$(srctree)
+AFLAGS_ankacoder_c75_r.o += -Wa,-I$(srctree)
+AFLAGS_rufscript010.o += -Wa,-I$(srctree)
+AFLAGS_cantoraone_regular.o += -Wa,-I$(srctree)
+AFLAGS_dejavu_mono.o += -Wa,-I$(srctree)
diff --git a/scripts/Makefile.lib-u-boot b/scripts/Makefile.lib-u-boot
index c55f8d8e0c3..4c4de359fe5 100644
--- a/scripts/Makefile.lib-u-boot
+++ b/scripts/Makefile.lib-u-boot
@@ -14,7 +14,7 @@ cmd_S_ttf=						\
 	echo '.balign 16';				\
 	echo '.global __ttf_$(*F)_begin';		\
 	echo '__ttf_$(*F)_begin:';			\
-	echo '.incbin "$<" ';				\
+	echo '.incbin "$(src)/$(notdir $<)" ';				\
 	echo '__ttf_$(*F)_end:';			\
 	echo '.global __ttf_$(*F)_end';			\
 	echo '.balign 16';				\
@@ -34,7 +34,7 @@ cmd_S_splash=						\
 	echo '.balign 16';				\
 	echo '.global __splash_$(*F)_begin';		\
 	echo '__splash_$(*F)_begin:';			\
-	echo '.incbin "$<" ';				\
+	echo '.incbin "$(src)/$(notdir $<)" ';				\
 	echo '__splash_$(*F)_end:';			\
 	echo '.global __splash_$(*F)_end';		\
 	echo '.balign 16';				\
-- 
2.43.0

base-commit: 1ffc541eafc96d5eebcf837ab892dccec3b93568
branch: font-us2
