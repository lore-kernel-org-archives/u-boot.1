Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4D4CF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2DE89456;
	Fri, 20 Sep 2024 10:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="axxfsIuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A24893FE; Fri, 20 Sep 2024 10:13:41 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7DB89449
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c46680a71bso396525a12.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820016; x=1727424816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diXCyDopFFvUJSN0rD4GC7RAOWgVv7+UdyCXvWL7ZcA=;
 b=axxfsIuLsDXJ5Riqcw1YtEjnjxza3RdBz1YM1iN4iQY5NaQshv0rv1h+J+LYbB07IN
 dZaTy6v28oHqCI7G0Pd///qlSLWfMCfecbVAoXpzaGsf/vTPGZIY2KXrpIClH155O3z3
 NmgeTywg4e9/lsgqd8M0r5VsI9PyGFbCbJ/8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820016; x=1727424816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diXCyDopFFvUJSN0rD4GC7RAOWgVv7+UdyCXvWL7ZcA=;
 b=r6K1Cg+5k4PvINrO67TP46UaAj2mGYyAQx6ufgcnQiD7xK1dXFd5s5FU7fvhJpbYIN
 rOtMKHfehu7pHWiX4Q58yEryKsU4i+SOO0jzUdNhTwR8c6+BRsZrFKsi1RGvKuA3r2A+
 LwymcCwxwb38JTMtOWtI+Iwb7f3kOBydF9pTJrUlpekv6+jGQLEIFZZ3x+AW/4DRevWl
 VHw6RcZBcbmqTBht4uumd4lmAMNLZkwlWVdNCp6Mgl7Vz62TlUoW+hdAInBGYP4u3wHt
 a1dlfNSXyzEvxyIOPk3w02vTyUJ1NGspZdMyLsE6SwhDVFKtL2679RUTUON6KU1v1AIh
 DcAw==
X-Gm-Message-State: AOJu0YxxyLo8bfBJshNuO/TNDfMVFXlVePFkZ0Da1Bepf+9Qr3glWg8p
 9aYM68K2L4Th7xBmfxpNziaM50hIaToZQeQxF9TFyPv5VM3Kf25SD6IpVfu9t4EO0mqDHnGSKGe
 moXA5
X-Google-Smtp-Source: AGHT+IHOG89FiJvCNwHucVFCaPil2QXCrwva2/G14c9hFAor9yLKfi+kvA40WXzKqassbC7bfw1JHg==
X-Received: by 2002:a05:6402:5113:b0:5c4:51b3:d75f with SMTP id
 4fb4d7f45d1cf-5c464a56a48mr1163644a12.24.1726820016561; 
 Fri, 20 Sep 2024 01:13:36 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/18] spl: Drop use of uintptr_t
Date: Fri, 20 Sep 2024 10:12:50 +0200
Message-ID: <20240920081309.140426-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

U-Boot uses ulong for addresses. It is confusing to use uintptr_t in a
few places, since it makes people wonder if the types are compatible.
Change the few occurences in SPL to use ulong

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl_atf.c    | 36 ++++++++++++++++++------------------
 common/spl/spl_fit.c    |  2 +-
 common/spl/spl_legacy.c |  8 ++++----
 include/spl.h           | 28 ++++++++++++++--------------
 4 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 0397b86a33b..8bc5db77395 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -41,9 +41,9 @@ struct bl2_to_bl31_params_mem_v2 {
 	struct entry_point_info bl31_ep_info;
 };
 
-struct bl31_params *bl2_plat_get_bl31_params_default(uintptr_t bl32_entry,
-						     uintptr_t bl33_entry,
-						     uintptr_t fdt_addr)
+struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
+						     ulong bl33_entry,
+						     ulong fdt_addr)
 {
 	static struct bl2_to_bl31_params_mem bl31_params_mem;
 	struct bl31_params *bl2_to_bl31_params;
@@ -100,17 +100,17 @@ struct bl31_params *bl2_plat_get_bl31_params_default(uintptr_t bl32_entry,
 	return bl2_to_bl31_params;
 }
 
-__weak struct bl31_params *bl2_plat_get_bl31_params(uintptr_t bl32_entry,
-						    uintptr_t bl33_entry,
-						    uintptr_t fdt_addr)
+__weak struct bl31_params *bl2_plat_get_bl31_params(ulong bl32_entry,
+						    ulong bl33_entry,
+						    ulong fdt_addr)
 {
 	return bl2_plat_get_bl31_params_default(bl32_entry, bl33_entry,
 						fdt_addr);
 }
 
-struct bl_params *bl2_plat_get_bl31_params_v2_default(uintptr_t bl32_entry,
-						      uintptr_t bl33_entry,
-						      uintptr_t fdt_addr)
+struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
+						      ulong bl33_entry,
+						      ulong fdt_addr)
 {
 	static struct bl2_to_bl31_params_mem_v2 bl31_params_mem;
 	struct bl_params *bl_params;
@@ -173,9 +173,9 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(uintptr_t bl32_entry,
 	return bl_params;
 }
 
-__weak struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
-						     uintptr_t bl33_entry,
-						     uintptr_t fdt_addr)
+__weak struct bl_params *bl2_plat_get_bl31_params_v2(ulong bl32_entry,
+						     ulong bl33_entry,
+						     ulong fdt_addr)
 {
 	return bl2_plat_get_bl31_params_v2_default(bl32_entry, bl33_entry,
 						   fdt_addr);
@@ -188,8 +188,8 @@ static inline void raw_write_daif(unsigned int daif)
 
 typedef void __noreturn (*atf_entry_t)(struct bl31_params *params, void *plat_params);
 
-static void __noreturn bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
-				  uintptr_t bl33_entry, uintptr_t fdt_addr)
+static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
+				  ulong bl33_entry, ulong fdt_addr)
 {
 	atf_entry_t  atf_entry = (atf_entry_t)bl31_entry;
 	void *bl31_params;
@@ -238,7 +238,7 @@ static int spl_fit_images_find(void *blob, int os)
 	return -FDT_ERR_NOTFOUND;
 }
 
-uintptr_t spl_fit_images_get_entry(void *blob, int node)
+ulong spl_fit_images_get_entry(void *blob, int node)
 {
 	ulong  val;
 	int ret;
@@ -253,10 +253,10 @@ uintptr_t spl_fit_images_get_entry(void *blob, int node)
 
 void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 {
-	uintptr_t  bl32_entry = 0;
-	uintptr_t  bl33_entry = CONFIG_TEXT_BASE;
+	ulong  bl32_entry = 0;
+	ulong  bl33_entry = CONFIG_TEXT_BASE;
 	void *blob = spl_image->fdt_addr;
-	uintptr_t platform_param = (uintptr_t)blob;
+	ulong platform_param = (ulong)blob;
 	int node;
 
 	/*
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1ad5a69d807..614dea9ae18 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -862,7 +862,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 {
 	struct bootm_headers images;
 	const char *fit_uname_config = NULL;
-	uintptr_t fdt_hack;
+	ulong fdt_hack;
 	const char *uname;
 	ulong fw_data = 0, dt_data = 0, img_data = 0;
 	ulong fw_len = 0, dt_len = 0, img_len = 0;
diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index a77893455f2..3af7ea33ae9 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -16,11 +16,11 @@
 
 #define LZMA_LEN	(1 << 20)
 
-static void spl_parse_legacy_validate(uintptr_t start, uintptr_t size)
+static void spl_parse_legacy_validate(ulong start, ulong size)
 {
-	uintptr_t spl_start = (uintptr_t)_start;
-	uintptr_t spl_end = (uintptr_t)&_image_binary_end;
-	uintptr_t end = start + size;
+	ulong spl_start = (ulong)_start;
+	ulong spl_end = (ulong)&_image_binary_end;
+	ulong end = start + size;
 
 	if ((start >= spl_start && start < spl_end) ||
 	    (end > spl_start && end <= spl_end) ||
diff --git a/include/spl.h b/include/spl.h
index de808ccd413..d90eed956af 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -256,8 +256,8 @@ enum spl_sandbox_flags {
 struct spl_image_info {
 	const char *name;
 	u8 os;
-	uintptr_t load_addr;
-	uintptr_t entry_point;
+	ulong load_addr;
+	ulong entry_point;
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
 	void *fdt_addr;
 #endif
@@ -939,9 +939,9 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image);
  *
  * Return: bl31 params structure pointer
  */
-struct bl31_params *bl2_plat_get_bl31_params(uintptr_t bl32_entry,
-					     uintptr_t bl33_entry,
-					     uintptr_t fdt_addr);
+struct bl31_params *bl2_plat_get_bl31_params(ulong bl32_entry,
+					     ulong bl33_entry,
+					     ulong fdt_addr);
 
 /**
  * bl2_plat_get_bl31_params_default() - prepare params for bl31.
@@ -960,9 +960,9 @@ struct bl31_params *bl2_plat_get_bl31_params(uintptr_t bl32_entry,
  *
  * Return: bl31 params structure pointer
  */
-struct bl31_params *bl2_plat_get_bl31_params_default(uintptr_t bl32_entry,
-						     uintptr_t bl33_entry,
-						     uintptr_t fdt_addr);
+struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
+						     ulong bl33_entry,
+						     ulong fdt_addr);
 
 /**
  * bl2_plat_get_bl31_params_v2() - return params for bl31
@@ -976,9 +976,9 @@ struct bl31_params *bl2_plat_get_bl31_params_default(uintptr_t bl32_entry,
  *
  * Return: bl31 params structure pointer
  */
-struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
-					      uintptr_t bl33_entry,
-					      uintptr_t fdt_addr);
+struct bl_params *bl2_plat_get_bl31_params_v2(ulong bl32_entry,
+					      ulong bl33_entry,
+					      ulong fdt_addr);
 
 /**
  * bl2_plat_get_bl31_params_v2_default() - prepare params for bl31.
@@ -995,9 +995,9 @@ struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
  *
  * Return: bl31 params structure pointer
  */
-struct bl_params *bl2_plat_get_bl31_params_v2_default(uintptr_t bl32_entry,
-						      uintptr_t bl33_entry,
-						      uintptr_t fdt_addr);
+struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
+						      ulong bl33_entry,
+						      ulong fdt_addr);
 /**
  * spl_optee_entry - entry function for optee
  *
-- 
2.43.0

