Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76E6C2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B18E86A4B;
	Thu, 17 Aug 2023 03:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Br+tR4LZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA4A886A76; Thu, 17 Aug 2023 03:52:08 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36A6F86A52
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1c5046642b4so2558652fac.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237124; x=1692841924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8AAbQQ2y7GdS3KxqSyOTtK7yJJV7+vKcb0r2rMaWGM=;
 b=Br+tR4LZZ4602ganCQGCqsChs32wftXW7syEklzLyroCAMJOC6XpvluV4mXmOkcvwe
 wFT79lv3cJf6UXApmENFrKnxtvqG/6pwIQRvNTesKCl113OfJj0O9d4iRF2PZUiSHtEJ
 n0gzF3Loqc9A3yBP8F5olAJkoMxylL67EteTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237124; x=1692841924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8AAbQQ2y7GdS3KxqSyOTtK7yJJV7+vKcb0r2rMaWGM=;
 b=SXGCDObruxSDuU8rzeY26ey6/AFsUhf9B0pPIypH9BBMAYBD34C/ZPNobaqyPmwA3i
 p2jsGelLHD5YvunxiBEKYAaWsdhWKC5ZP+UDywTpFQZiYnqUaWCoAMbkW+xJAD3/ah8j
 5EAjjp6pl/TT5j/AGh+cTY320ULmPZZ059RjlOlIxrjoKKJLtEbcdto70NeqpPsZtQV0
 s+hGU55jaFPJWIkL/c8E7/QUegAdb513uhQ4ODuEo+xK0mppSjitiOCDk0CJ81qiUeDT
 TS8tO6VwCylUkHxfWpiW3PmMw5RNNAkKcKUR+V/uKiH+r/IknQdAsq3tZqB6PcT1dgpu
 T/Gw==
X-Gm-Message-State: AOJu0Yzt5EFSkAFEwyu52b3VRxlAhqsSLXbjJU7lSIR0+nIJFmcRVaOM
 mvIU5JJCIcTDQJydnWm9efI5z1RgqYcZBUemups=
X-Google-Smtp-Source: AGHT+IGp7cDbewGdvpiH/ao635LF/0HdSGIZ2lW1C6+Ligq6WPlgYBSGqmiUFdEWFpPeZadDWCSd9g==
X-Received: by 2002:a05:6870:3109:b0:1b0:408a:1d14 with SMTP id
 v9-20020a056870310900b001b0408a1d14mr4140802oaa.44.1692237124628; 
 Wed, 16 Aug 2023 18:52:04 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:52:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 6/9] x86: coreboot: Drop USB init on startup
Date: Wed, 16 Aug 2023 19:51:41 -0600
Message-ID: <20230817015149.774847-7-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
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

This is very annoying as it is quite slow on many machines. Also, U-Boot
has an existing 'preboot' mechanism to enable this feature if desired.

Drop this code so that it is possible to choose whether to init USB or
not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/coreboot/coreboot.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index 6a551e4c6713..5e3af5e561bc 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -82,10 +82,6 @@ static void board_final_init(void)
 
 int last_stage_init(void)
 {
-	/* start usb so that usb keyboard can be used as input device */
-	if (IS_ENABLED(CONFIG_USB_KEYBOARD))
-		usb_init();
-
 	board_final_init();
 
 	return 0;
-- 
2.41.0.694.ge786442a9b-goog

