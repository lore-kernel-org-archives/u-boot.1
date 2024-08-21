Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7734C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D2288E43;
	Wed, 21 Aug 2024 18:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qa/C1xlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B83188E40; Wed, 21 Aug 2024 18:20:10 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22E688E43
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70944d76a04so586680a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257205; x=1724862005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G01vxVo6fNrjWbbnkQ5N8c2f0N5CsTr2Bb3TXI1JLtU=;
 b=Qa/C1xlLkJ/EHXPPS9PrhbLLI4nrFyBnMWDWyxGNuzRE6YutAxv8iUHId+gFOS3TCK
 QCZJa2AzIG4dZ7dpblmkD2lzc9Xjzzy8UmGu0vYlrxFEKq0dki/kw2mvHYN9Wl/GP0I/
 1IDzavCaD5g0AeXrpz6Uhd1bCiYVMK6E4Qs6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257205; x=1724862005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G01vxVo6fNrjWbbnkQ5N8c2f0N5CsTr2Bb3TXI1JLtU=;
 b=swdtvZtXkhXGjCahW2VsYva+t29smzv0spp8qg0caP64LzYbb0prnyNeNGE2V4erjn
 bQHgpjuPULGGtuSMgSPm+itjOz+rsqERFT9tGMHo5vcLKKhMsuEzqQMicjxOIf/TFygQ
 AMLN/NNWnJAc3hXtfeBmaKQiAY8mwpAphzGIqiDQ0TJ09n3vWNqnHv2lHCP32DITdBOM
 eUPTJNrJPQRSCwCiz8oolQ+z7f6PiVSv4lKNQa3yZ2WmL6uTsxRyBXBxCAMiMKbQe53s
 Df9m0cJwDzsMMcVLzIu3XZJ3eOY+4AzpUVrwSzgOHM8wSEoXW0iTOvT7mfF3wF6hb2gL
 Kb0A==
X-Gm-Message-State: AOJu0YxuK3jSri+MoE9YlfeekpC06QRmaaQu69w/BZ+AGVJi94GzUUP8
 yTxokBbNmCgt81qBHqpxkuh567wsw7mfELpoLcmindmnghvD0BU72DlXbF3i0wlOJQQIAKfrbNY
 =
X-Google-Smtp-Source: AGHT+IEnm8Fmws6y9Jd0s3BNBeAo/QO2xNKt2Yw9pVMLWcOJNIGQL5SNf3MeuT7SeddCq2OrNSHxiA==
X-Received: by 2002:a05:6830:3108:b0:703:6cde:1cb9 with SMTP id
 46e09a7af769-70e01ba8949mr68501a34.13.1724257205399; 
 Wed, 21 Aug 2024 09:20:05 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 33/35] global_data: Remove environment members if not used
Date: Wed, 21 Aug 2024 10:19:25 -0600
Message-Id: <20240821161927.695717-34-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

If the environment is not enabled we don't need these fields in
global_data. Make them conditional.

Make these fields conditional. Move env_buf up one so it can share
an #ifdef.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/hwconfig.c                 |  8 +++++++-
 include/asm-generic/global_data.h | 12 ++++++++----
 lib/asm-offsets.c                 |  2 ++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/common/hwconfig.c b/common/hwconfig.c
index afaa6cb37ab..25a8cd5bf5d 100644
--- a/common/hwconfig.c
+++ b/common/hwconfig.c
@@ -77,7 +77,13 @@ static const char *__hwconfig(const char *opt, size_t *arglen,
 
 	/* if we are passed a buffer use it, otherwise try the environment */
 	if (!env_hwconfig) {
-		if (!(gd->flags & GD_FLG_ENV_READY) && gd->env_valid != ENV_VALID) {
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
+		if (!(gd->flags & GD_FLG_ENV_READY) &&
+		    gd->env_valid != ENV_VALID)
+#else
+		if (true)
+#endif
+		{
 			printf("WARNING: Calling __hwconfig without a buffer "
 					"and before environment is ready\n");
 			return NULL;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index bd1069f572c..a05b939c007 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -86,6 +86,7 @@ struct global_data {
 	 * @cpu_clk: CPU clock rate in Hz
 	 */
 	unsigned long cpu_clk;
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
 	/**
 	 * @env_addr: address of environment structure
 	 *
@@ -93,6 +94,7 @@ struct global_data {
 	 * environment variables.
 	 */
 	unsigned long env_addr;
+#endif /* ENV_SUPPORT */
 	/**
 	 * @ram_base: base address of RAM used by U-Boot
 	 */
@@ -134,6 +136,7 @@ struct global_data {
 	 * @baudrate: baud rate of the serial interface
 	 */
 	unsigned int baudrate;
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
 	/**
 	 * @env_has_init: bit mask indicating environment locations
 	 *
@@ -150,14 +153,15 @@ struct global_data {
 	 * @env_load_prio: priority of the loaded environment
 	 */
 	char env_load_prio;
-	/**
-	 * @fdt_src: Source of FDT
-	 */
-	enum fdt_source_t fdt_src;
 	/**
 	 * @env_buf: buffer for env_get() before reloc
 	 */
 	char env_buf[32];
+#endif /* ENV_SUPPORT */
+	/**
+	 * @fdt_src: Source of FDT
+	 */
+	enum fdt_source_t fdt_src;
 	/**
 	 * @arch: architecture-specific data
 	 */
diff --git a/lib/asm-offsets.c b/lib/asm-offsets.c
index 4e2dbda9a71..b6bbcbf76ca 100644
--- a/lib/asm-offsets.c
+++ b/lib/asm-offsets.c
@@ -44,7 +44,9 @@ int main(void)
 
 	DEFINE(GD_NEW_GD, offsetof(struct global_data, new_gd));
 
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
 	DEFINE(GD_ENV_ADDR, offsetof(struct global_data, env_addr));
+#endif
 
 	return 0;
 }
-- 
2.34.1

