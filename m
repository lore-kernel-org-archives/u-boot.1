Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C39BC35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE57881877;
	Sat, 15 Mar 2025 23:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NzFPFZYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E9CF8168B; Sat, 15 Mar 2025 23:18:32 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE22A811B2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223594b3c6dso63410195ad.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077108; x=1742681908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfT1TwykQwss8rAEvr/XAZkQ5jIFGWRWfZ+tj88wuXI=;
 b=NzFPFZYPz9BnRFFeSC/UH6gqJlZ5UtAVZPVDL6Zh5SSpmYRvbhsc23wxTGsBJO5Hdu
 NqsnQJLM2+WrcbL3jI9jiTWj3LPb/MMnOHu9b4Sg5/30C8UxUe5hm0np1N1hdkbR9ptz
 iNMCZP2WqNqI5PJLNnlT0v7QxyWAn/iCkDU+mo41bke5f9I12dvANL6HifTjGeU/NHLB
 9sK6A7S6YhYXMaMVrk0U5hVqHzNaae2+oIHL3r4IyqTGCE7aUOlLeXSx9c+6z+64jDvE
 5Ph/Wh6RRtGf3B7dGkrdSp/sMS0h0pWFvaF4065jCRuYfJvNqnH2VOtgm1jmJE6W3Y0x
 fqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077108; x=1742681908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfT1TwykQwss8rAEvr/XAZkQ5jIFGWRWfZ+tj88wuXI=;
 b=QJeeLN3Y9LSebbrwwaiJFHI9GQsWDFInTjHStsZkAwripgLhvR7CeqfTKdV6BsEGA9
 HYfh53gKECnEkyDiOCruCaD9pGPOA7qS5nzFWwkNOEq3F/e0sLcRYlJfCjvCkpB6T48C
 qYLWb51cY/CBurkjiSp7ecMzsL6l+YTYF1KE6UjNWa1nX2VWkGdE8RPgngXHtadd49aJ
 XjpTJ//HFrm0SYWudpspWR4zVqcgrIHExUbM+lXP+ZTIaB5pmkKwAESTdJlAsMkDlgD4
 wmqtm8URDg1eX42E8hv2D9iCNcTTNjY5SDGhgyWS+RuCzHGyrmPX5d+jIXieRowOk0me
 1RdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbeEpxq47YSZjzeFckukO3bly+xyK1jlTIgrkyNzXznW40hvL5KFtIT5VL5MXKca/lUQ4SKvk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzqiql2OvXUcm+8JQLMAElyoffKDs1egqXDvWgY5sDEAEPIsXwg
 qZtT7RIGredpxLu4C5jAbYf0AkuxRCG6jdr2Nkjvl9NH9IwRsdLiPiCrSTdB4vA=
X-Gm-Gg: ASbGnctA422xnVHMbIY/8pjbFA/bnbI0N+8inSQUbrqFpaXYNKJZloMbWTwWpHTcxpr
 3m9EeoRYRDNAri5X063H4iMFZ7NkRR6QUur9bpIQJcRWfrxJ6f8iy5xrUzzNYsJIUyoLOCOYXhK
 BvxP2qok5H45/Cu6g3aGyVstQXzKpmKpKIGULAg7VWyF5n6i9NHpfSUltaontgMSahZifNz4ZxF
 lqZ0ia5p465YAANGz1furilKgR0gVtCYbK5gWY9SSQoakAQSCoQQPJ3Dx/8zYLlAmqAyHjfRwSL
 ywnkzyI8TjcMx/iyxH19N8vJseUxo4BQ1t4GlKzkSKhCHCiYxcMIuCQnTo5XMxUT4A==
X-Google-Smtp-Source: AGHT+IEJVYqReHuwnoVC+uxpVUQxs/mhBY1rQJv5iE+ki9kkIGI5EaGQdFH0Fke2WdDfwyR4wrpNJA==
X-Received: by 2002:a05:6a00:22c8:b0:736:476b:fccf with SMTP id
 d2e1a72fcca58-737223ed458mr8284936b3a.18.1742077108289; 
 Sat, 15 Mar 2025 15:18:28 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:27 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 08/15] makefile: Avoid objcopy --gap-fill for .hex/.srec
Date: Sat, 15 Mar 2025 15:18:06 -0700
Message-ID: <20250315221813.1265193-9-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

This flag only makes sense for `binary` output, because .hex/.srec are
sparse formats and represent gaps without filler. While the GNU binutils
version of objcopy does not seem to mind the extra flag being passed,
llvm-objcopy considers this a fatal error.

There is already a version of the objcopy command template in the
Makefile that doesn't use --gap-fill, which is provided for EFI. So use
this other version for all .hex/.srec outputs as well.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 0694c425438..9c353af17cd 100644
--- a/Makefile
+++ b/Makefile
@@ -1067,7 +1067,7 @@ quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) --gap-fill=0xff $(OBJCOPYFLAGS) \
 	$(OBJCOPYFLAGS_$(@F)) $< $@
 
-# Provide a version which does not do this, for use by EFI
+# Provide a version which does not do this, for use by EFI and hex/srec
 quiet_cmd_zobjcopy = OBJCOPY $@
 cmd_zobjcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 
@@ -1282,7 +1282,7 @@ OBJCOPYFLAGS_u-boot.hex := -O ihex
 OBJCOPYFLAGS_u-boot.srec := -O srec
 
 u-boot.hex u-boot.srec: u-boot FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,zobjcopy)
 
 OBJCOPYFLAGS_u-boot-elf.srec := $(OBJCOPYFLAGS_u-boot.srec)
 
@@ -1296,12 +1296,12 @@ OBJCOPYFLAGS_u-boot-elf.srec += --change-addresses=0x50000000
 endif
 
 u-boot-elf.srec: u-boot.elf FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,zobjcopy)
 
 OBJCOPYFLAGS_u-boot-spl.srec = $(OBJCOPYFLAGS_u-boot.srec)
 
 spl/u-boot-spl.srec: spl/u-boot-spl FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,zobjcopy)
 
 %.scif: %.srec
 	$(Q)$(MAKE) $(build)=arch/arm/mach-renesas $@
@@ -1436,7 +1436,7 @@ OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
 OBJCOPYFLAGS_u-boot.ldr.srec := -I binary -O srec
 
 u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
-	$(call if_changed,objcopy)
+	$(call if_changed,zobjcopy)
 
 ifdef CONFIG_SPL_LOAD_FIT
 MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
-- 
2.48.1

