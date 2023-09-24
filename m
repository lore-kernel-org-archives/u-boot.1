Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170E6CE7A88
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDAE486B55;
	Sun, 24 Sep 2023 21:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fMmqwKeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4130E85423; Sun, 24 Sep 2023 21:26:01 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A8A86A28
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35133097583so5410475ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583552; x=1696188352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssy0jUFvmu5+yh6VvKGTwGLodOO/J3W1in21MxGDhzU=;
 b=fMmqwKeUmRgKcaB7v1S0Rdrro9fwzy+pdxSz3vuFBcgcw/qupZc9BmOAYk6VJVKahe
 Y4EbGc7SFU5kPty5dJExELdybzBe8OnqSo0m7MnD5TMYdVx83gDSQiLU53BWkT+rtBQi
 SgZeS2w84bCmaFPy0cR8jEWLNJG0ny5DNwMYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583552; x=1696188352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssy0jUFvmu5+yh6VvKGTwGLodOO/J3W1in21MxGDhzU=;
 b=vKqZXniz8ilZGWLFid8UmCN7+e/FcD8OVRu8WgPv2ORfqDhEQH0almh94aTvUwgg/D
 ic7ggjIfXkJZOOxrpgU3X9YFPcGX7VbIB2DJpZkj6ItdSc8WsU+ehdei1aiNZLr7SstN
 KSg6+Vd7zoPJh0oT7k0GUIC3OLTOseQg8yh4QTg2A0X7F7Y2vY4nbDh4JuKXuw6FXhVu
 /K3mTrcw5Amd8cKVT24jOsyT6SaR4D+JwUDkVY5Ne+CUz8AssgfOgLcQF2N3hlZndau5
 z6AdpQbdt0xmsxzGvcZ38ZDKlOKZMtGdBE704Vadj+0IKt1rT6dtrrxNAPhYkUZggBfI
 Q4Fg==
X-Gm-Message-State: AOJu0YwjPf8WulOZCv7ozQa8XfbiAVze66xahT2bk++hKKwcWOQKFC6W
 MyCPB/uIfhlJraxL+ZjgHtkZPda4xoW6YxlXFxI=
X-Google-Smtp-Source: AGHT+IFkRaSPHFdMfetDgxQztDOUdcP3MPN4b6C3Xg/UYFjaalT46qRT3jXTY9lxQrJTOq+HBxkmQw==
X-Received: by 2002:a05:6e02:1c2a:b0:34d:ee49:5114 with SMTP id
 m10-20020a056e021c2a00b0034dee495114mr7392871ilh.23.1695583551854; 
 Sun, 24 Sep 2023 12:25:51 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Nikhil M Jain <n-jain1@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 03/38] spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
Date: Sun, 24 Sep 2023 13:24:48 -0600
Message-ID: <20230924192536.1812799-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

Use IF_ENABLED_INT() to avoid needing to use the preprocessor.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Improve readability by moving the size part to the header file

 common/spl/spl.c           | 8 ++++----
 include/system-constants.h | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 657886dfe5b0..5cc86288145b 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -754,10 +754,10 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 
 	spl_set_bd();
 
-#if defined(CONFIG_SPL_SYS_MALLOC)
-	mem_malloc_init(SPL_SYS_MALLOC_START, CONFIG_SPL_SYS_MALLOC_SIZE);
-	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
-#endif
+	if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
+		mem_malloc_init(SPL_SYS_MALLOC_START, SPL_SYS_MALLOC_SIZE);
+		gd->flags |= GD_FLG_FULL_MALLOC_INIT;
+	}
 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
 		if (spl_init())
 			hang();
diff --git a/include/system-constants.h b/include/system-constants.h
index f0a191be590e..dca6a86b01f5 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -24,9 +24,14 @@
  */
 #ifdef CONFIG_SPL_HAS_CUSTOM_MALLOC_START
 #define SPL_SYS_MALLOC_START		CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR
-#else
+#elif defined(CONFIG_SPL_BSS_START_ADDR)
 #define SPL_SYS_MALLOC_START		(CONFIG_SPL_BSS_START_ADDR + \
 					 CONFIG_SPL_BSS_MAX_SIZE)
+#else
+/* feature not enabled: this value avoids compiler errors but is not used */
+#define SPL_SYS_MALLOC_START	0
 #endif
+#define SPL_SYS_MALLOC_SIZE	\
+	IF_ENABLED_INT(CONFIG_SPL_SYS_MALLOC, CONFIG_SPL_SYS_MALLOC_SIZE)
 
 #endif
-- 
2.42.0.515.g380fc7ccd1-goog

