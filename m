Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A84C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 17:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A02871BB;
	Tue, 24 Oct 2023 19:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mZKR6S/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1468E8720A; Tue, 24 Oct 2023 19:38:56 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82548718F
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 19:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso89845e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698169133; x=1698773933; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cO1xrWKHLd+fTeoHZH4XnL+kbXs8gnkvJfxOjDrkjnQ=;
 b=mZKR6S/zD6/TUQDju23egVNGoa8Duw5ioqN/Tg863xBTU23KugBthI3sEIo91ULpjg
 XEuYrJPDfp4xCWY8N3cNpDdXA9KzSFj3DOycyiM4Yz23zgAvxFF6mm08hZuE/oZlQKBa
 3RDtiNX3JLrGUkkE5Dq7dEc5oca+TRdC2XkUrdK0dY50WVoyan9ZiudUK+5YpZp3gcu2
 DuGXb2jeDv1p6K9GlE/pZR5bfJ6NlTNQhzm+b7IdsfxovBDBZsm9vSI8oe3GeSe+hAcY
 oPKF4RaMa0ezgPncaLSya4EZ/V5nr0eE7IJ3MFBuEhaRnVted3MrXAICi5AU4R9+ZEb1
 O7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698169133; x=1698773933;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cO1xrWKHLd+fTeoHZH4XnL+kbXs8gnkvJfxOjDrkjnQ=;
 b=tmggVCasMd1o9dq+1GM8DwW7irvsTmyz3uWKpdRll3506mKPT/E+tgzZ5y+ijFdsRz
 Yom09+ZBqi8ZuKF0+XmeODtClNy/l0qtD1rNgPyy/L08ecoqRKg61uU+hEi2iGBdknHM
 vtUjA1fkGeT88TA2mH9jYR5fk1L+6lpr7xONszyTiQH0YL0hOcoqG2dBb8jUx1ggIumW
 MMYpmsH0J8PgbuaRcsqwXhK6Fp4XhTlcVAHQdTT3TOozZNJNkPRvN1xUFpFt6+34II+v
 RYzAzREIW/96iW/rxLkfPJWKO9pTX064du4JNCKvASnr227vhzRKuVg5gApPcv6xOD10
 K8iw==
X-Gm-Message-State: AOJu0YwCAy3qLNCL4HvYMAHioAzJDXmClhnmbnUImjmfqkXYrybrW/ka
 Dfd8/9fBaVx2Af2M6M1qJ4hb8A==
X-Google-Smtp-Source: AGHT+IE29WY1wbaKBBx9QwBrb4woEwE+X/rDA2L2p4ehLhJLrvMabLrWZHbm+qYssnXLUreNyGxR6w==
X-Received: by 2002:a5d:4fca:0:b0:32d:dcee:a909 with SMTP id
 h10-20020a5d4fca000000b0032ddceea909mr15515743wrw.1.1698169133021; 
 Tue, 24 Oct 2023 10:38:53 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a05600c210100b004068de50c64sm12336892wml.46.2023.10.24.10.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 10:38:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 24 Oct 2023 18:38:43 +0100
Subject: [PATCH v2] arm: init: add an option to use FDT from previous
 bootloader
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-prevbl-fdt-v2-1-7822ec6b0b20@linaro.org>
X-B4-Tracking: v=1; b=H4sIACIBOGUC/3WNQQ7CIBBFr9KwdhQQ08aV9zBdQBnaSSqYoWk0D
 XeXdu/yzfyXt4mMTJjFvdkE40qZUqygT40YJhtHBPKVhZb6qqQ24Ay869DNEPwCSprQou88Gi+
 q42xGcGzjMO1WYhopXl42L8j7v6qBPkfv2VeeKC+Jv0d+Vfv1X2lVoOBmVGiVd7aT+jFTtJzOi
 UfRl1J+AHHz/8sAAAA=
To: Simon Glass <sjg@chromium.org>, Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3840;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=fa2gCYoEhpYMqHHrYUtjTXc4/vWFNqsxGZPw9ollp5U=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQLRh2DOUEcAmuMlM6mWJ38FrTGZm9PiP3Ls9anf0x8K
 rYsVuVMRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhI/i6G/xnJC0xOP/Uu+7c7
 bvrjntTdNzaWJ7Qa5Bfcds07Gr/ZUoCRYcWS+GMu/zqVn2tclQrYWX2qPu/XthN7/rT+2+X9dJV
 59wUA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a new config option to allow u-boot to reuse the FDT provided by the
previous stage bootloader when available.

On some boards the previous stage bootloader can populate
platform-specific parts of the devicetree such as the memory node, this
allows us to avoid hardcoding it in u-boot and instead determine it
dynamically at runtime.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch will improve generic support for Qualcomm boards by enabling
us to configure the memory map at runtime rather than having hardcoded
maps on a per-device basis. I've gone for this approach initially to try
and avoid introducing board specific code where possible, but I'm happy
to rework this into mach-snapdragon if that's preferred.
---
Changes in v2:
- Replace pre-processor conditional with runtime IS_ENABLED()
- Link to v1: https://lore.kernel.org/r/20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org
---
base-commit: e65b5d35c9116485366bb08138043d51220551da

// Caleb (they/them)
---
 arch/arm/lib/save_prev_bl_data.c |  7 +++++++
 boot/Kconfig                     | 10 ++++++++++
 include/init.h                   | 11 +++++++++++
 lib/fdtdec.c                     |  8 +++++++-
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
index f7b23faf0d66..b0608502535e 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -45,6 +45,13 @@ bool is_addr_accessible(phys_addr_t addr)
 	return false;
 }
 
+phys_addr_t get_prev_bl_fdt_addr(void)
+{
+	if (!is_addr_accessible((phys_addr_t)reg0))
+		return 0;
+	return reg0;
+}
+
 int save_prev_bl_data(void)
 {
 	struct fdt_header *fdt_blob;
diff --git a/boot/Kconfig b/boot/Kconfig
index a01e6cb8aafe..c127ba254589 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1599,6 +1599,16 @@ config SAVE_PREV_BL_INITRAMFS_START_ADDR
 	  If no initramfs was provided by previous bootloader, no env variables
 	  will be created.
 
+config USE_PREV_BL_FDT
+	depends on SAVE_PREV_BL_FDT_ADDR && !OF_BOARD
+	bool "Use the FDT provided by the previous stage bootloader"
+	help
+	  When u-boot is chain-loaded from a previous bootloader, enable this option
+	  to use the FDT provided by the previous bootloader instead of any built-in
+	  to u-boot.
+
+	  If no FDT was available, u-boot will fall back to its internal FDT.
+
 menu "Configuration editor"
 
 config CEDIT
diff --git a/include/init.h b/include/init.h
index 4e7fe26c2004..ca78ff9f08c4 100644
--- a/include/init.h
+++ b/include/init.h
@@ -168,6 +168,17 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
  * Return: 0 if ok; -ENODATA on error
  */
 int save_prev_bl_data(void);
+
+/**
+ * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
+ * of the FDT passed by the previous bootloader.
+ *
+ * Return: the address of the FDT passed by the previous bootloader
+ * or 0 if not found.
+ */
+phys_addr_t get_prev_bl_fdt_addr(void);
+#else
+#define get_prev_bl_fdt_addr() 0LLU
 #endif
 
 /**
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 7a6916764835..b82baf08fc2f 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1222,7 +1222,7 @@ static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
  */
 static void *fdt_find_separate(void)
 {
-	void *fdt_blob = NULL;
+	void *fdt_blob = NULL, *prevbl_fdt_blob;
 
 	if (IS_ENABLED(CONFIG_SANDBOX))
 		return NULL;
@@ -1234,6 +1234,12 @@ static void *fdt_find_separate(void)
 	else
 		fdt_blob = (ulong *)__bss_end;
 #else
+	if (IS_ENABLED(CONFIG_USE_PREV_BL_FDT)) {
+		prevbl_fdt_blob = (void *)get_prev_bl_fdt_addr();
+		if (prevbl_fdt_blob)
+			return prevbl_fdt_blob;
+	}
+
 	/* FDT is at end of image */
 	fdt_blob = (ulong *)_end;
 

