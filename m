Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCC4C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E5088CC0;
	Thu, 29 Aug 2024 16:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y43iISrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B20888C4F; Thu, 29 Aug 2024 16:58:30 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA8888C4C
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so33879839f.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943506; x=1725548306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruIV0gP0m5I6cDk2IbmBk1GQluxfzSR0nxQN7a6yGGM=;
 b=Y43iISrfu348xLhxQ/vT8oudvbHwyzybz3BslfJ6q825Xt8XsiAYVNPueQCqzHZroR
 GEvSCvXJKH3KvBYg62yBTCK5XDiRK2mHR/JL7D/colBGkQWl2OPbrLUJp5dv+9W7KVKb
 +9itWxgG1Uq3oB9N2abGORHw6rChrTL/HbGxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943506; x=1725548306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruIV0gP0m5I6cDk2IbmBk1GQluxfzSR0nxQN7a6yGGM=;
 b=i5P6U+LBjYb98+IantiUL5IQOL3wJXes2UlFugzPSd1FGsh5j0+7wCDnTR8Zkmctqx
 SgMz+FVoRbyvOB4FjlOzO6irhZMSihBI4uY0m8LKWTD+qjLDuAMYUIJ6ltBgHDZuYvhj
 UUwu/IvesllUBVTZOQ2Fi+yKfDj3bBNFuxGywZBkR8rgyybEHbuEnP7rX6AFhfw75FLh
 sWcg/rO/BHD/NTuo++4Ff68EXQXfWPeKQp2Rbe8EP8rkRtpeYPdbKuhoQrLkVODxt/aq
 5oADOO8Aj2psOMM5SxTNrOACsD2DkCIB0S9aUdY+SHcIShgZrkGC3pGXcJclpSrGlXyn
 tHrg==
X-Gm-Message-State: AOJu0YyTnG7IApYDAM6df/asJ7uXhEkFdl07KsETXW4SS1EXZi3+HT7a
 a0nWRlaVOuMpNeskFedE/tIB8B6xXS6w+wBkWE0fA7VFKBb9XiyNr58JbMuXjKfI/2rUplYegTM
 =
X-Google-Smtp-Source: AGHT+IGxdCULi38sZQ+H52zJyDa8CX0OmFGoxYWaZW23cdYCUNLaM3uLUkx7TR2nzauCI8sIQROBgw==
X-Received: by 2002:a05:6602:1485:b0:81f:880d:ec18 with SMTP id
 ca18e2360f4ac-82a10e140cemr317175339f.3.1724943506218; 
 Thu, 29 Aug 2024 07:58:26 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/19] spl: Drop use of uintptr_t
Date: Thu, 29 Aug 2024 08:57:55 -0600
Message-Id: <20240829145802.1827952-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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
2.34.1

