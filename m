Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F0FC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E179486575;
	Wed, 30 Aug 2023 20:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jRSFMLai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6798656A; Wed, 30 Aug 2023 20:05:50 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E5986542
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79536bc6697so2252639f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418740; x=1694023540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0m6/mnCAFbXBEtj6RlZFzD9Jx3Wq11DDMdku69J2wy8=;
 b=jRSFMLaihplOvQehLZwvTGiLJHa4uwXwMVIWk2YowzIbXK/O0Gr1iyViIuQHDzChMg
 I2JoSu+DfaMZmgn8tdbQiroUhmTkMMn21Dq1kEjK5JvpI0BdHmGhdXqS0dBOmdHLOEH/
 Cr7NnnOFPzO5IEaCp6Ip2tg23cZtZ0dcMjv64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418740; x=1694023540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0m6/mnCAFbXBEtj6RlZFzD9Jx3Wq11DDMdku69J2wy8=;
 b=Za1klyntcgrHCXwgBE+bAEFep5UMNdNgRtWbqERPIHpDqouGwSL7hCPpPnA2qzPGIb
 zQ2fWKX+vFcemGANe78Pqy0HGlkvwcI1WzAx41UukSTgb/Q64BIBMx3CgTz4h98inb4d
 MUjvxzSrxl5Znph0RclclU0AgacwYq4e6cmJFb6f92GzIVJsrM5DaUo3d+kpTwjvpnFH
 eYL0KAgox5N7r1bRsflTO4g8E+PegKdlOEi2FALUubh3qRE03w59co5YRM12tj+TsvUW
 D+e7A2e3marfDx6SaGpQZzMAbSAoYUyJ03YWo0K9UccB0MmIIP35YI4RYIzNbi7PESBu
 wUvA==
X-Gm-Message-State: AOJu0YxJ4KCJ4BkhfaVej7z+MUiVAtRxVffjp7qYAvyxtUokrmcZ2Yzv
 9zFJW9+rJKyKPSGofN0x0UI5G50O/7Lvgw9qCrQ=
X-Google-Smtp-Source: AGHT+IH1yIjY5jsj5j5LqQFlLNiSDrRY3ZV6mL/qS/i2ixcWOGcAvx9Y02kpl17SA/7eOfJ8FBB2Cw==
X-Received: by 2002:a05:6602:370a:b0:792:4d29:ecc7 with SMTP id
 bh10-20020a056602370a00b007924d29ecc7mr3542365iob.15.1693418740133; 
 Wed, 30 Aug 2023 11:05:40 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH 04/32] spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
Date: Wed, 30 Aug 2023 12:04:35 -0600
Message-ID: <20230830180524.315916-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

 common/spl/spl.c           | 12 ++++++++----
 include/system-constants.h |  5 ++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 27266b393ea..78db9ef5318 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -754,10 +754,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 
 	spl_set_bd();
 
-#if defined(CONFIG_SPL_SYS_MALLOC)
-	mem_malloc_init(SPL_SYS_MALLOC_START, CONFIG_SPL_SYS_MALLOC_SIZE);
-	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
-#endif
+	if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
+		ulong size;
+
+		size = IF_ENABLED_INT(CONFIG_SPL_SYS_MALLOC,
+				      CONFIG_SPL_SYS_MALLOC_SIZE);
+		mem_malloc_init(SPL_SYS_MALLOC_START, size);
+		gd->flags |= GD_FLG_FULL_MALLOC_INIT;
+	}
 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
 		if (spl_init())
 			hang();
diff --git a/include/system-constants.h b/include/system-constants.h
index f0a191be590..aa02c48f49d 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -24,9 +24,12 @@
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
 
 #endif
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

