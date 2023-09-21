Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03677CD493C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A0886D71;
	Thu, 21 Sep 2023 03:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S2Ef8gGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2094C86CFC; Thu, 21 Sep 2023 03:57:55 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 585BB86CF6
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-350f43b9c3dso1475875ab.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261465; x=1695866265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yL7DbPJpY7Q+Rq2y9C3cKsu/PAaXkey7IEbolGler60=;
 b=S2Ef8gGoyJcmkiZWHuixwtVvPqyaN3F3/nkPW8HAUtE+lE08EvfOE8jFhcADw2umhn
 /RAHiEExLzFz1zTiLtVEsEIym9sx8X5QhGcCSRYSdigHuf3CwF4dquFC33l8j7WewGso
 eCcH7h5b3AaCKVcPiHn6XkiZnpyd1qCo+RAoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261465; x=1695866265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yL7DbPJpY7Q+Rq2y9C3cKsu/PAaXkey7IEbolGler60=;
 b=BimSWR4r9vYUdqoONAfbM0ZEZXE6P091yZWhKbRxIuOeG0QUYeaoachoWT+YtxAaHq
 JLUPSlimn3yLrJqnbKiAsRXiZ7JFksDDvBvjNnuwGc7k8dz+wOQGI7pCpy4wy1XuaCwX
 rIm6FyLOmoJlXIEyDtEWFMJqLo4hDNe72B25O00naSU/ZkwOtQv9KOWbOhmZ4D16lAPI
 wC+iEGz8sTDopv2ipcr8cLS4i0NvuSjQA59QmPNmFeBrQlumt2iSqp2v+oTczCCzDkEn
 qC+i9+5F8mhNEf2o6DDYNPmXHyxx2U0CFqRj3ihz4IGjwuBJy2WPu7K9ZT/oZXSdPAel
 uzDQ==
X-Gm-Message-State: AOJu0YwxiSRxjPzh7sJlp/7NCYBIkKrhYJru5/9uDQa83ffntjE5Rc/E
 ClVESsycbLczBOR+TDmjz+WoM2N48gzcpWsTDsY=
X-Google-Smtp-Source: AGHT+IFvl3xFV5C5BRGZBPdbhGCSJQpu4w2oNY/LsZ4xlkR/kyj3Wru7zcxfmDVP/1XNLxoeLzUZnA==
X-Received: by 2002:a05:6e02:2193:b0:34c:f665:861e with SMTP id
 j19-20020a056e02219300b0034cf665861emr5796707ila.21.1695261464984; 
 Wed, 20 Sep 2023 18:57:44 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Nikhil M Jain <n-jain1@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 04/32] spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
Date: Wed, 20 Sep 2023 19:56:53 -0600
Message-ID: <20230921015730.1511373-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

Changes in v2:
- Improve readability by moving the size part to the header file

 common/spl/spl.c           | 8 ++++----
 include/system-constants.h | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index acd154986e15..90e6dc2b5c9b 100644
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

