Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5064EC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2776E88A34;
	Wed, 24 Jul 2024 17:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JuVrawlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07EFC8896B; Wed, 24 Jul 2024 17:10:11 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E796788A25
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3737dc4a669so25738285ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833806; x=1722438606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jd0l4zwxrWARTFEkbuyz4ngT8mytSOpGKQmzVJEO9x8=;
 b=JuVrawlKYoaO+olz4TDh7PqHyx0IXeynkxwdfGRR4Ah1JxwO5JhCdusqeg9BLi3V3D
 4n1T96LGJKr25Dq7qrIQznUQEl4/3VOEiS/nLUNqykgOkavXNHxWXdob/OBmijnTJ7+C
 iU6qMVY3dBJ1HB2bWQv8GgLiKU6m/WzKKfWwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833806; x=1722438606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jd0l4zwxrWARTFEkbuyz4ngT8mytSOpGKQmzVJEO9x8=;
 b=mwtKy2YCIIX4dO/ncCPj/sVgPQEp3s1rxJHlnF6+BMt0HVjC7Li5+zDnX+ooWho32Y
 iL6r8Z/J6qtB2IUW6WHGc0ty4dpHHE+A5xH5vYLEGTwqVRc0ZSQM64Fvdy9lLX7q7kl4
 WW/M7pMdoqXE7XrIEad/pOPpvPbva9ePWzDX4M74siTDJCi7wb2ccqv+vVLvhx2lL0LV
 fOED89PlAcZsKob1toVOGwAWDZ3IeXhlI32MbLRCaQzzD8HTqOck4o+mL/HwhvCAWCsW
 wtYPFw+JnqOVKhn+YQ6kodOG0ZCFqGAYj5Wsofsy2cFkChLfis82U5AUY4mKinNr5WV1
 4tZA==
X-Gm-Message-State: AOJu0YxQKaw+23IkE48T9SVhIfd2OlHR8yknJ0uq+wngX9mdjvAqsMbq
 Fd0FVL4bwPeLh7vmV/Coc+Me3HACs5zSxrcQr/oJmzeJF6OhdVKauayTMxvR6AU5pBGGD6RGvws
 =
X-Google-Smtp-Source: AGHT+IFN+CcD1gfx55iRkHacHfJ4+m/z+l7wL1m4koqJbnkVIxgI3U1xHqo51+6Ipi2Zsq26iyg+iA==
X-Received: by 2002:a05:6e02:1a6a:b0:376:410b:ae67 with SMTP id
 e9e14a558f8ab-3993ffa3d27mr148678115ab.16.1721833806484; 
 Wed, 24 Jul 2024 08:10:06 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 33/35] global_data: Remove environment members if not used
Date: Wed, 24 Jul 2024 09:09:20 -0600
Message-Id: <20240724150922.2343249-34-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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
index 18d21de6237..1d58ada4094 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -85,6 +85,7 @@ struct global_data {
 	 * @cpu_clk: CPU clock rate in Hz
 	 */
 	unsigned long cpu_clk;
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
 	/**
 	 * @env_addr: address of environment structure
 	 *
@@ -92,6 +93,7 @@ struct global_data {
 	 * environment variables.
 	 */
 	unsigned long env_addr;
+#endif /* ENV_SUPPORT */
 	/**
 	 * @ram_base: base address of RAM used by U-Boot
 	 */
@@ -133,6 +135,7 @@ struct global_data {
 	 * @baudrate: baud rate of the serial interface
 	 */
 	unsigned int baudrate;
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
 	/**
 	 * @env_has_init: bit mask indicating environment locations
 	 *
@@ -149,14 +152,15 @@ struct global_data {
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

