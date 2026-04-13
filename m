Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7DCF34C53
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E2884206;
	Mon, 13 Apr 2026 15:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KHmS4Vog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0285F83DC9; Mon, 13 Apr 2026 15:15:53 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B194484199
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d556c1a79eso6031451a34.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776086149; x=1776690949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcwwnZArgauI9dwWQVxkj0FmN4DOivtVsgVpTwkIsfQ=;
 b=KHmS4Vogrz9xKcMdr2C9z1nC4hFgK17YTlGSm7HFJ62ueXvL5YOqYkMzWEY8+oCoPd
 lM4gLKuFS8V24kySpc7w7AuaKN480Xcv8G/GQrSOjm8eXgNFVieyM75Tn+iGaEo+llvA
 oajDS8D89JAIyVfvH42mpJ9BW7Gztu3TSPMGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776086149; x=1776690949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pcwwnZArgauI9dwWQVxkj0FmN4DOivtVsgVpTwkIsfQ=;
 b=l67pD/NeNVoJYcMDlNQwbE/52X7SyOhxcMoHB9MulGp4NPKv9f4R0Y8LS+cyOJMP2D
 3Fqy36GOSjkQSzhmNYUPqFgEM00xhGLo+55m2FBIbl+ybpz0/mL/8vrOqXf0Gm64pSpw
 /dX0Wv73fiFxvHmvDrFV1oQaw0iSCyJEhQo4WxfZhobWyxPoENRnIPg0OnwRgMwvJCao
 4Fp9bN9ZvzPXIVKxsGzQRWtuROxCkmODlBEeqff9YIligf0dsFqsqO4gxXK/xiheccRt
 zf8A52t4iMJowTc5aZ985McLQL5arJlAsy9FJfo5nYZwVaOMQScvx5zzqcDfFSAPpMqg
 t70g==
X-Gm-Message-State: AOJu0YyCifANtQ5/HLhoHixgFGCDMLRcA+gxfd5WDjZke9+5GXBjEXQK
 y88Wp5YNKt6CCeC1m43+51vAdAAOqucaah5HjZRF8cLlYIl0AZPlv1CQwPhYrXqyHn6ugPvQdt6
 z4wmmqQ==
X-Gm-Gg: AeBDieupIbts5Fi3drn8mItx9ERkhHdClcNFTQKGM7emqEC1a+zFKvtk+4CTY6I8G2c
 MsLN18HO7D6/FVRVXt0P95zqLD2ARTO1ECquGIO3msP39+y+/jx+FSsO8a1fNcGDfjUxH080w2a
 tpX52t3SmSANrkpxEr9FiQ4yJ60mCwXPv+Xw7VK68M1GpiqqZDvjIapLjKwGsep/lLY/etoAbxr
 PAX1P8AMwCUvHNuQaXEwdEE06otIusnE09ey3ooAahnpqwtIDN9t7lpQwwHyHLEhkrS2tJad2kw
 1xZx6PKxzfN2fFVBhc7bifkwJ1lji5tLirUnMgZlmJhzS7sd6EA8hOxuZ3qq5P0eLlv1wiuLTO+
 k1nufbBqibuxVkVJyVwvgkGiMdG6CIjWDmDlGH5iQn0ajeeQhwxTlJu2az84ZYfITQUWJqd1XSV
 1Bq3Z7oRczTowKqFVFpQ==
X-Received: by 2002:a05:6820:1351:b0:686:c7a9:d64c with SMTP id
 006d021491bc7-68be84d179cmr6456648eaf.43.1776086148768; 
 Mon, 13 Apr 2026 06:15:48 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc7dfa196sm5958562eaf.2.2026.04.13.06.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:15:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/2] kbuild: Use if_changed for font and splash .incbin
 rules
Date: Mon, 13 Apr 2026 07:15:38 -0600
Message-ID: <20260413131541.2091541-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413131541.2091541-1-sjg@chromium.org>
References: <20260413131541.2091541-1-sjg@chromium.org>
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

The intermediate_targets entries stay in scripts/Makefile.build rather
than moving to scripts/Makefile.lib-u-boot, because that file is
included before intermediate_targets is defined and 'targets' is ':=',
so a '$(call intermediate_targets, ...)' inside it would expand to
empty and silently drop the entries. To keep the upstream block
untouched, the U-Boot additions go in a separate 'targets +=' block
immediately below.

Suggested-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add a separate 'targets +=' block for .ttf.o/.bmp.o per Rasmus

Changes in v3:
- Use if_changed with compound suffixes (.ttf.o, .bmp.o)

Changes in v2:
- Move U-Boot .incbin rules to Makefile.lib-u-boot first (previous patch)
- Drop the EFI .incbin change since .efi files are generated, not source
- Use per-file AFLAGS instead of modifying a_flags in Makefile.lib

 drivers/video/Makefile       |  2 +-
 drivers/video/fonts/Makefile | 10 +++++-----
 scripts/Makefile.build       |  4 ++++
 scripts/Makefile.lib-u-boot  |  8 ++++----
 4 files changed, 14 insertions(+), 10 deletions(-)

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
index e625f99986e..73b6769ab90 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -440,6 +440,10 @@ targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
 	   $(call intermediate_targets, .lex.o, .lex.c) \
 	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
 
+# Added for U-Boot
+targets += $(call intermediate_targets, .ttf.o, .ttf.S) \
+	   $(call intermediate_targets, .bmp.o, .bmp.S)
+
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
---
base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
branch: font-us4

-- 
2.43.0

