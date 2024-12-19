Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCEBE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2E680374;
	Thu, 19 Dec 2024 19:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CWzHtuQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE7A803DC; Thu, 19 Dec 2024 19:29:44 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E1E802B4
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a7dd54af4bso3856895ab.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632980; x=1735237780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9FKCNQpzeg7HyEi23UFW0yXEddaB5ql4vSbAJO2ltg=;
 b=CWzHtuQd4WtEKrPlYw8sYfIcnpWraRssAjtH4pIAPOw0ygshQkKyBsfvBWLzZLOTIF
 XVKO///DAA53c77CTixTwlAC4oAKIUGKp09AR1/5AzarJPZbxCVYHuc0kv9idHe/tnJq
 Xqbj59JjI2VD+0GNXVyVwmUQEnOK1LHxeUSqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632980; x=1735237780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9FKCNQpzeg7HyEi23UFW0yXEddaB5ql4vSbAJO2ltg=;
 b=K8zsYpO4KQYFuAnLJNVhMIcGCUjDMAH1ybbnDSl5y1A0Jr+0YxOApfQjcZEvYT9R7T
 s+0RnyjIA0jOFPE0Q8BiPUkOeqbKRUo6gAJRbxa+zecVatxnvAX6RWLPzYBpG/a0VCSz
 TtXF1U9wfNqrjKHCN79yipCDMcT8RtvWI9Lt/WiwHOcHhTNEP9uWfWLgdrmCnHxc8aY7
 JfnOLXEmMviVbTwZ7Qby6lMAU31MqifUFw9+8+TWcxqqjrko+0lZ+0IBq8JBVETJg9fp
 iABnkPm5CJMaXWB80gTAF72IbbThMGk9uKraJMo20gTqwSBWdtfp1WJmzINSSpkDdnJi
 stFA==
X-Gm-Message-State: AOJu0YxW9+Hn0mZmr8fKu8idfAb6ZVCp1zQyqxMWjiw9R8ANfxodCpSA
 2gKkEV7U1f4ACAo6b3PtFVa1vhodd8VIMQIzbZgpnsyQ9jOa4d7s4IW82f/r9MBzRNmHXguTt0Q
 =
X-Gm-Gg: ASbGncuyUvprw4M/P0+izmZwIsu7dPqtSFuFap89n08Fj7zCzyqNDYfJjWpJxhkBy6w
 mYVgZuQqsP9Omd8rheJeMDCZSrwdHKyaQE0OPae+MbwgPRKKpPAY+uHCkXVTF3YOwCzHzJFzttW
 mKvClK7BEXeRoQ/Qtf10/r5SDaiJnMxa/29Dv/2ZPUZJAQumsPW8HALxbWbBNVH3ba3cwQD4tA1
 MJ2dznNS/jWtC9/hPLrct1kBAlnqzh6pIm5vHHk5l3iJCKE2YUmHqeSPR/05VMeu4WeN7dYxmP6
 ZC42WvCAwB+UzcRb1g==
X-Google-Smtp-Source: AGHT+IHlQcHqqwyJ2Z8CsUiJwrxOEpHb5U1jUG5d0w6d3G0o5hJWKqHXGOHP0QhCobPa52Pu77PfgA==
X-Received: by 2002:a05:6e02:b2e:b0:3a7:91a4:c752 with SMTP id
 e9e14a558f8ab-3c2d5919b63mr722335ab.23.1734632979798; 
 Thu, 19 Dec 2024 10:29:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 12/19] spl: Drop use of uintptr_t
Date: Thu, 19 Dec 2024 11:29:00 -0700
Message-Id: <20241219182907.2609704-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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
index 3160f573bfb..ef40a50082c 100644
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
index 9252b3a3de0..b3efb3e630e 100644
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
index 269e36bb441..43b344dbc55 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -268,8 +268,8 @@ enum spl_sandbox_flags {
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
@@ -951,9 +951,9 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image);
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
@@ -972,9 +972,9 @@ struct bl31_params *bl2_plat_get_bl31_params(uintptr_t bl32_entry,
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
@@ -988,9 +988,9 @@ struct bl31_params *bl2_plat_get_bl31_params_default(uintptr_t bl32_entry,
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
@@ -1007,9 +1007,9 @@ struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
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

