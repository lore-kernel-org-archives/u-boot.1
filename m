Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA5FE810D9
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 278D986DF4;
	Wed, 27 Sep 2023 14:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="dU95Xrx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC9086DCD; Wed, 27 Sep 2023 14:00:43 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2C286DDC
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 14:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so1545878f8f.3
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1695816041; x=1696420841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StN0QLjbzC039Byae+Sd5BXqK8IT11YW53KXy7cMB4c=;
 b=dU95Xrx2P8zzjjwUI2dODAqUWgcDONSp6QMRsWBFPJ2+dscmMQm33iHyxgvdeSuVxg
 tNoj/7EpYnu5ChXfNacWlByzQ1kpeff3gJ2uta1yQZaejNiWA1LJTQG5rd8oAarcGno0
 pQNEGe4xjqSsXGN/JpQf3xj6KAZ8JzMUl92S0WaxxN5O56/JsEaBWZcAQvBMhIcCVirI
 PPelhhRa27yRTFtaqJ5BgLixEA8Kpm3qD346t3o6RGDPPoa+hOt6486Qprsvo9+eYkch
 vDcmUAb9FijO5eD6zYY1W1xB4b3Ur3+algTWXDxj7cGlfSWfAZ3vwQyQ3Feh9NbC6BnG
 bs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695816041; x=1696420841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StN0QLjbzC039Byae+Sd5BXqK8IT11YW53KXy7cMB4c=;
 b=VxB2m1wDWEuvI3jI+R09AJ/0y+k1S4j/GhetgfQ/wifDHPGQHpsfXOKGYdGGtnHXPj
 Hg0AOt0N6lcE4fvuL4G5rFWHXIcLCEVr9oiUQ24pdcyPo6i5gYv+EXTp7/avv1wbwwOq
 Q82V6h2uAA7yfmKpCLefvt4Sd56zr6qK0xVDyUU3piwO0Exca2/f4RzFlkuBJPxZsxRK
 o37UfVerTgnD35gokWym2UjqRilOgbqmKgBYItTbX3hORTHksK0KKoPuhYsxA7il6/Nv
 4OEmtoMLlNywqrUPufqrKK3Cn3xDjmaD2a6zj3stuSGWOwmjf6+M2bImSOmIn/iW+lUt
 dMYQ==
X-Gm-Message-State: AOJu0Yy98V/ESSM5+R9YfSiEBdNlSZegwiPt8eaX5SF350KiJszUeezD
 zNqhLbhpamD5vzjn+Nd9Nk77zHsjY+FMi5eN0PA=
X-Google-Smtp-Source: AGHT+IFbP92rVEM/xp+TnTiJhndaJVjO70EjQ8I2gzb3xTQhw+VKBa2wbd6s+0av0xvoxKgD37r08w==
X-Received: by 2002:a5d:670c:0:b0:31f:f2dc:db7d with SMTP id
 o12-20020a5d670c000000b0031ff2dcdb7dmr1297214wru.65.1695816041150; 
 Wed, 27 Sep 2023 05:00:41 -0700 (PDT)
Received: from hugo-IdeaPad-3-15ALC6.home
 (ptr-4h549o68tsg3n9xv5up.18120a2.ip6.access.telenet.be.
 [2a02:1810:952e:3700:492a:f3bb:eb68:e461])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a5d4a8b000000b0031fc4c31d77sm17078557wrq.88.2023.09.27.05.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 05:00:40 -0700 (PDT)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: hugo.cornelis@essensium.com
Subject: [PATCH 2/2] image-host: increase path length when setting up the
 cipher.
Date: Wed, 27 Sep 2023 13:59:20 +0200
Message-Id: <20230927115920.2471498-3-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927115920.2471498-1-hugo.cornelis@essensium.com>
References: <20230927115920.2471498-1-hugo.cornelis@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Sep 2023 14:24:03 +0200
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

---
 tools/image-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 0c92a2ddeb..9afcc02192 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -361,7 +361,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 				  int noffset)
 {
 	char *algo_name;
-	char filename[128];
+	char filename[256];
 	int ret = -1;
 	int snprintf_return;
 
-- 
2.34.1

