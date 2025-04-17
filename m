Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D799C369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9CCF830A0;
	Thu, 17 Apr 2025 20:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YMi9elxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D555830A0; Thu, 17 Apr 2025 20:16:55 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC79083086
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d439f01698so7163995ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913810; x=1745518610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhcyjgaoncYfQKTSySxPxwzlrW2sHvOl5djwzPZsB8k=;
 b=YMi9elxbuRwa3Tty2edo4BBGeVP653LN9OKsP1hExrMkePBpIOYnCgf+kUmpXMRlLk
 DJmfhTNPL7dXgt9hoAifXVYzUKSYDzcYy+uC+G0K7GDPl0fvbZHJFdht4A26Rew5sE8Z
 K+FIleESMRBKtdAN7j1Fg2EzsbIa6eaxRXCfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913810; x=1745518610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhcyjgaoncYfQKTSySxPxwzlrW2sHvOl5djwzPZsB8k=;
 b=GC+BwdN15/fCXx7vI1vtaMyrGtQypPHyRXCz0YlO3wHi+POfQTPBjTzYJaEPMdr2Al
 hkgn2ztpUEtNNfG2IZYyDM+6F4ZzbUB1KAIkVkRr72/cAguTRhXsMd+qrjnJUu2bgMH+
 UubiFx4QA1gPEku0IZoZEOXf5wnuU94XBOuxmralnueQtGLZnvzudAip4AsJbM0/mUII
 rLks+5D9lqRE8PUk69zdVzW9+/cK1RY2C2nPtb9sFKFwgvRYcNOe+kKrPD5+rW9fpgk4
 Wi80pStzNQDGOhl9PIGR3/ww2oewT5lIpr4NWXcGS4W1Om1LAQOwD5/k3W+a5HyOdpG3
 GRWg==
X-Gm-Message-State: AOJu0YxRkFUZxmc4KWgRIJyPns4eeUEGV1Ckv3WLFF1WuyP6AsVza8Pt
 pyaAztSa3/g4WMnRLHNrEQGfGPZf0PT8WDSEabTMd0E/AjnLTvg0UjETlOLL5Hh1Jt6UEklysFE
 =
X-Gm-Gg: ASbGncsx22eVVgvANZW1I4JX6NQTnVPnpkHctE7Dr1b/fSLPZ9ENV+0c+OtWh8bTm0M
 TFBBpPSpmu+mmepfLMNqO6Mb5o9mw1aMDAnmE72S6WpttvXa4TYlt4g5CCVVzx700TiCHN4661x
 GqxdgYLZf2uZPAPS7wKalPlk/fWd6ZAw2OCh69Ob08rqfitYtTfmkUD4uXxHBOxuQlfQIaxFS6H
 Zk7J1sctTenqgytuufKyxidNi2aryLRA2bALRzfh/eC/hojBiHGV91wATYGczEZeMUMv4sPCB/p
 zDLND6P/lZazOlLgK97eUEXzdcKEBkgua8rwYtA3DND+SpzT9phHzMZE9OszZAoUX7KCqnX5yOU
 9UZnjCgsqHq6j
X-Google-Smtp-Source: AGHT+IFwc0K0jDxSSii7duS1ER8eVsq2pQeeANtKnLh86Zzb6jXyuJH/BiZjoNuxivkfVm81QfF1lg==
X-Received: by 2002:a05:6e02:4a8:b0:3d5:e428:7091 with SMTP id
 e9e14a558f8ab-3d821cf8efdmr11052745ab.1.1744913810406; 
 Thu, 17 Apr 2025 11:16:50 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH v3 06/22] passage: Support an incoming passage
Date: Thu, 17 Apr 2025 12:15:48 -0600
Message-ID: <20250417181613.1355024-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

Plumb in the ability for U-Boot proper to accept an incoming standard
passage from a previous phase, such as SPL or TF-A. This allows data to
be passed from binary to binary when firmware is booting.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add passage_valid() to decide if stdpass was provided
- Make the global_data fields present only when needed
- Move arch_passage_entry() into this patch
- Move passage.h into this patch

Changes in v2:
- Rebase to master
- Rework global_data for new stdpass convention

 Makefile                          |  2 +-
 common/Kconfig                    | 31 ++++++++++++++++++
 common/board_f.c                  | 13 +++++---
 include/asm-generic/global_data.h | 37 +++++++++++++++++++++
 include/passage.h                 | 53 +++++++++++++++++++++++++++++++
 lib/asm-offsets.c                 |  8 +++++
 scripts/Makefile.xpl              |  2 +-
 7 files changed, 139 insertions(+), 7 deletions(-)
 create mode 100644 include/passage.h

diff --git a/Makefile b/Makefile
index 73939748e54..3577c2c9a22 100644
--- a/Makefile
+++ b/Makefile
@@ -1396,7 +1396,7 @@ endif
 
 binman_dtb := $(shell echo $(CONFIG_BINMAN_DTB))
 ifeq ($(strip $(binman_dtb)),)
-ifeq ($(CONFIG_OF_EMBED),y)
+ifneq ($(CONFIG_OF_EMBED)$(CONFIG_OF_PASSAGE),)
 binman_dtb = ./dts/dt.dtb
 else
 binman_dtb = ./u-boot.dtb
diff --git a/common/Kconfig b/common/Kconfig
index be517b80eb5..c6a8fa54363 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1089,6 +1089,14 @@ config BLOBLIST_PASSAGE_MANDATORY
 	  U-Boot will report an error when a valid incoming bloblist does not
 	  exist.
 
+config BLOBLIST_PASSAGE
+	bool "Obtain bloblist from standard passage information"
+	help
+	  Rather than allocating the bloblist, get it from the standard
+	  passage provided by an earlier phase, e.g. SPL. The bloblist address
+	  and size are used as is, except that the bloblist is of course
+	  relocated when U-Boot relocates.
+
 endchoice
 
 config BLOBLIST_ADDR
@@ -1148,6 +1156,13 @@ config SPL_BLOBLIST_ALLOC
 	  specify a fixed address on systems where this is unknown or can
 	  change at runtime.
 
+config SPL_BLOBLIST_PASSAGE
+	bool "Obtain bloblist from standard passage information"
+	help
+	  Rather than allocating the bloblist, get it from the standard
+	  passage provided by an earlier phase, e.g. TPL. The bloblist address
+	  and size are used as is within SPL, then passed on to U-Boot.
+
 endchoice
 
 endif # SPL_BLOBLIST
@@ -1212,6 +1227,22 @@ endif # VPL_BLOBLIST
 
 endmenu
 
+config PASSAGE_IN
+	bool "Support the standard-passage protocol (in)"
+	help
+	  This enables a standard protocol for entering U-Boot, providing
+	  parameters in a bloblist with a devicetree. It allows the various
+	  firmware phases to communicate state and settings to following
+	  phases.
+
+config SPL_PASSAGE_IN
+	bool "Support the standard-passage protocol in SPL (in)"
+	help
+	  This enables a standard protocol for entering SPL, providing
+	  parameters in a bloblist and a devicetree. It allows the various
+	  firmware phases to communicate state and settings to following
+	  phases.
+
 source "common/spl/Kconfig"
 
 config IMAGE_SIGN_INFO
diff --git a/common/board_f.c b/common/board_f.c
index bff465d9cb2..e9ffa2d7fed 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -700,11 +700,14 @@ static int reloc_bootstage(void)
 static int reloc_bloblist(void)
 {
 #ifdef CONFIG_BLOBLIST
-	/*
-	 * Relocate only if we are supposed to send it
-	 */
-	if ((gd->flags & GD_FLG_SKIP_RELOC) &&
-	    CONFIG_BLOBLIST_SIZE == CONFIG_BLOBLIST_SIZE_RELOC) {
+	int size = bloblist_get_size();
+	int new_size = CONFIG_BLOBLIST_SIZE_RELOC;
+
+	if (!new_size)
+		new_size = size;
+
+	/* Relocate only if we are supposed to send it */
+	if ((gd->flags & GD_FLG_SKIP_RELOC) && size == new_size) {
 		debug("Not relocating bloblist\n");
 		return 0;
 	}
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 506ee51cdb0..464b9c3eee1 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -219,6 +219,35 @@ struct global_data {
 	 */
 	long precon_buf_idx;
 #endif
+#if CONFIG_IS_ENABLED(PASSAGE_IN)
+	/**
+	 * @passage_mach: Incoming machine information from standard passage
+	 *
+	 * Provides a value which indicates whether passage is used, e.g.
+	 * PASSAGE_ABI_MACH
+	 */
+	ulong passage_mach;
+	/**
+	 * @passage_bloblist: Incoming bloblist from standard passage
+	 *
+	 * Provides the address of the bloblist passed in by the previous stage
+	 * or phase. If this is zero, there is none.
+	 */
+	ulong passage_bloblist;
+
+	/**
+	 * @passage_dtb: Incoming control devicetree within standard passage
+	 *
+	 * Provides the address (typically within the bloblist) where the
+	 * control DTB is stored. If this is zero, there is none.
+	 *
+	 * Note: This must be set to the correct value if the control DTB exists
+	 * since SPL may use this and ignore the bloblist, e.g. if bloblist
+	 * support is not enabled for code-size reasons. If this value is not
+	 * valid, any devicetree passed in the passage_bloblist is ignored.
+	 */
+	ulong passage_dtb;
+#endif
 #ifdef CONFIG_DM
 	/**
 	 * @dm_root: root instance for Driver Model
@@ -581,6 +610,14 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_video_size()		0
 #endif
 
+#if CONFIG_IS_ENABLED(PASSAGE_IN)
+#define gd_passage_bloblist()	gd->passage_bloblist
+#define gd_passage_dtb()	gd->passage_dtb
+#else
+#define gd_passage_bloblist()	0
+#define gd_passage_dtb()	0
+#endif
+
 /**
  * enum gd_flags - global data flags
  *
diff --git a/include/passage.h b/include/passage.h
new file mode 100644
index 00000000000..b71796f5eaf
--- /dev/null
+++ b/include/passage.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Standard passage implementation
+ *
+ * Copyright 2022 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __PASSAGE_H
+#define __PASSAGE_H
+
+#include <stdbool.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+enum {
+	PASSAGE_ABI_MACH	= 0x4a0fb10bul,
+	PASSAGE_ABI_VERSION	= 1ul,
+};
+
+static inline ulong passage_mach_version(void)
+{
+#if BITS_PER_LONG == 64
+	return PASSAGE_ABI_MACH | (ulong)PASSAGE_ABI_VERSION << 32;
+#else
+	return (PASSAGE_ABI_MACH & 0xffffff) | (PASSAGE_ABI_VERSION << 24);
+#endif
+}
+
+/**
+ * passage_valid() - See if standard passage was provided by the previous phase
+ *
+ * Return: true if standard passage was provided, else false
+ */
+static inline bool passage_valid(void)
+{
+#if CONFIG_IS_ENABLED(BLOBLIST_PASSAGE)
+	return gd->passage_mach == passage_mach_version();
+#else
+	return false;
+#endif
+}
+
+/* arch_passage_entry() - Jump to the next phase, using standard passage
+ *
+ * @entry_addr: Address to jump to
+ * @bloblist: Bloblist address to pass
+ * @fdt: FDT to pass
+ */
+void __noreturn arch_passage_entry(ulong entry_addr, ulong bloblist, ulong fdt);
+
+#endif
diff --git a/lib/asm-offsets.c b/lib/asm-offsets.c
index b6bbcbf76ca..23ee9aab47e 100644
--- a/lib/asm-offsets.c
+++ b/lib/asm-offsets.c
@@ -48,5 +48,13 @@ int main(void)
 	DEFINE(GD_ENV_ADDR, offsetof(struct global_data, env_addr));
 #endif
 
+#if CONFIG_IS_ENABLED(PASSAGE_IN)
+	DEFINE(GD_PASSAGE_MACH, offsetof(struct global_data, passage_mach));
+	DEFINE(GD_PASSAGE_BLOBLIST,
+	       offsetof(struct global_data, passage_bloblist));
+	DEFINE(GD_PASSAGE_DTB,
+	       offsetof(struct global_data, passage_dtb));
+#endif
+
 	return 0;
 }
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 43f27874f9f..b25866e9676 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -322,7 +322,7 @@ endif
 #   - we have either OF_SEPARATE or OF_HOSTFILE
 build_dtb :=
 ifneq ($(CONFIG_$(PHASE_)OF_REAL),)
-ifneq ($(CONFIG_OF_SEPARATE)$(CONFIG_SANDBOX),)
+ifneq ($(CONFIG_OF_SEPARATE)$(CONFIG_OF_PASSAGE),$(CONFIG_SANDBOX),)
 build_dtb := y
 endif
 endif
-- 
2.43.0

