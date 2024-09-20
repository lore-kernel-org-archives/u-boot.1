Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF6FCF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81DFF8945C;
	Fri, 20 Sep 2024 10:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X545beM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F72889449; Fri, 20 Sep 2024 10:13:42 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632D28943C
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8a789c4fc5so485593166b.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820013; x=1727424813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=it/pukHPW881bhR7MBvKN39WW2isL3vaWa/swL+ElqI=;
 b=X545beM4WiCHiw6OZ27S/Mg7KcRUtAlE+74OepqkVFTVaK8R31WttgZFBF1pT+4AGJ
 VV/7WCErBwlcv9BTKJJrWuEb1jBDtK+ZOHCyVoRcTyI1Ieb/7uiTJgNWHJAfaRRhqXbs
 cQno+pzktiJXjwpGtGJrJXI2gWem07SKv5cmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820013; x=1727424813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=it/pukHPW881bhR7MBvKN39WW2isL3vaWa/swL+ElqI=;
 b=FP/7mp4M2AdsjiYux/pvLHqZHIpadLIWApSFmP7dfcyhf9/mQ269n9nLCUOWYa4OR1
 hxfrZZZ/Y34s4GScuKYqe4u9Tuj/+pczTypxs/p3muhLBO8TbJSRbZIsFHGbf2fF9FKQ
 Roq2CH8B6SaITY8OKSJXyU75kpdEbc4Pk3C0Qy62y2JCS4OwInLmQsP3V4JMAkAilalV
 cXguFbKpL2HetWX6hvbbDcQUVvdVIS2AZXm5qnXHplkYl/lAR609lUmSTRPCQwJO+KoA
 06cY6eO08UhitdQbjpO1XKoG7nPVM8XdxcW4xH0tdQpLOW+2E0bVwXm9JYTu3TNqzVN7
 hVVw==
X-Gm-Message-State: AOJu0YxY/73Xp1P4bQTzvPOLh1zvfAmCuCCtuqMsFmgT5wwR5J3S1WtO
 ykZ++oOZ1McKoTGPuO9krpzA4ytjEsrCgEFPApX2lsbNJ4BS5SWdmYqh71Y4KJNlXYk+kw+PuZi
 xHmua
X-Google-Smtp-Source: AGHT+IEBDsOLcVlKjRw2IxLXpnebXgewXAomw8p71OPUW4FQSm4+SZZ5cXQ0gvCmXEmGfqmycSc7sA==
X-Received: by 2002:a17:907:268e:b0:a8a:754a:e1c1 with SMTP id
 a640c23a62f3a-a90c1c73fabmr586179866b.8.1726820013592; 
 Fri, 20 Sep 2024 01:13:33 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/18] spl: Allow serial to be disabled in any XPL phase
Date: Fri, 20 Sep 2024 10:12:48 +0200
Message-ID: <20240920081309.140426-10-sjg@chromium.org>
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

The current check looks only at SPL, but TPL or VPL might have a
different setting. Update the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index ecd90169f65..89a972dfc84 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -840,7 +840,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
  */
 void preloader_console_init(void)
 {
-#ifdef CONFIG_SPL_SERIAL
+#if CONFIG_IS_ENABLED(SERIAL)
 	gd->baudrate = CONFIG_BAUDRATE;
 
 	serial_init();		/* serial communications setup */
-- 
2.43.0

