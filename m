Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4A9C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10FE88189;
	Sun, 21 Jul 2024 17:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gg9/WPN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95F7880D8; Sun, 21 Jul 2024 17:26:49 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139EB87F51
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so28770895e9.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575606; x=1722180406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/2IzB95kuKYUiAZPjcAEAOS0mmi8EMf8y6z/GHEaik=;
 b=Gg9/WPN76hkqHKcyQGgqSx+3LI0TjU9BR1S6sWEi3sdSO5l8sKqtXmku70WuOOdOWK
 k7z4aANBONbs8nSKtbRaISB2oKFdjBNfh7aW100z3eXir8FJi8LHRuWavmZC8FM/mglI
 QPSjgyRE8yEcxYP1qMScVrqyN2ADU7l17+dMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575606; x=1722180406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/2IzB95kuKYUiAZPjcAEAOS0mmi8EMf8y6z/GHEaik=;
 b=k26glDVebIQLeZaSNf38rkU4MENmU40MuMRzUJtO1wIilNrJ4tMmOR4iuXo66sk9fD
 UHtFNb2dQ1sWU94FxkbaLwG86Pkbvh/4MKh6/O4n1uTGFH02g52PseZExlRNw8clUYSW
 T2IDk9HAGnVTL58bFMtdu/t1HOfQTSbxA1ATVzfxabEJs0MQ6Fm+n9D0e47QU8Cf1nSX
 gPbRafIWSXq5M8NZsnyf6NQRinwelnCCAm/iPavSdl/3P+HO7xmOaxp260qBHN1kHmOF
 syAqTg6r19Zh6UuKUHWuHMaWfpWMu1th73tXCU0ltuyejvdNl33rhAIUA6GJgLF3mpgl
 luWQ==
X-Gm-Message-State: AOJu0YwVF6ge3U03LAu6iaEKRatLngH8KcN8zlpPTirqONzvFYvCsZQx
 ADydv8OfWBgRcg4rfYDqD1LKAJGKCewexfsL7wfWaVqHD3y+cZrMU1qHT74dpljJu2NQCbZnNTc
 =
X-Google-Smtp-Source: AGHT+IHbgq8aW4TERmR6jRn9ViA51dlHhr3SS+ds+m53hrhabpOsYz9b6PCkSALiqw+QqBmOh6XYIA==
X-Received: by 2002:a05:600c:46d0:b0:426:593c:9359 with SMTP id
 5b1f17b1804b1-427dc56b60bmr41785735e9.32.1721575606403; 
 Sun, 21 Jul 2024 08:26:46 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 12/14] spl: Use unified inline functions for spl_load_info
Date: Sun, 21 Jul 2024 16:25:57 +0100
Message-Id: <20240721152600.3212917-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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

Rather than declaring completely separate functions, put the code for
each case into the same function. This makes it easier to read.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 include/spl.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/spl.h b/include/spl.h
index 5dfdf778d2d..2f6a3e64c10 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -306,31 +306,27 @@ struct spl_load_info {
 		      void *buf);
 #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
 	int bl_len;
+#endif
 };
 
 static inline int spl_get_bl_len(struct spl_load_info *info)
 {
+#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
 	return info->bl_len;
-}
-
-static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
-{
-	info->bl_len = bl_len;
-}
 #else
-};
-
-static inline int spl_get_bl_len(struct spl_load_info *info)
-{
 	return 1;
+#endif
 }
 
 static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
 {
+#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
+	info->bl_len = bl_len;
+#else
 	if (bl_len != 1)
 		panic("CONFIG_SPL_LOAD_BLOCK not enabled");
-}
 #endif
+}
 
 /*
  * We need to know the position of U-Boot in memory so we can jump to it. We
-- 
2.34.1

