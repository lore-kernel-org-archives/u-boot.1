Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E41C49EA1
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 00:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8791288B28;
	Wed,  7 Aug 2024 02:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="q0uw8ilJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3650688A92; Wed,  7 Aug 2024 02:14:07 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBBB88A92
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 02:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 24A0A3F17F
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 00:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722989636;
 bh=RpEr08lkEBNOM5w/vUWJ6LV8EGyBWpXs4+Ov9Vbc0PA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=q0uw8ilJ0dHvXcojZLA/FfgYoz+miR9QpBl8l45gNZM+HBex9I5+PwwwGuUXflo92
 22geWXy3ByxwTvFXwBDeDRRlKCqDmSSzpQRo6XBUhcsSfnZP5ZG9nF2bRRvOBn0yKq
 xPQ1P0mf+Nh2FRJG9InGUyQn8Q7Akg0tIxRa6jZaQ7H6JW58WPkF6T1+GC9M/xU9qb
 U7nSHLSgNZftAzuxogGhISdmJ0g3uMwU5EG++rgiSKP/Wo2DpnaI5mHmRw5nSYvT5q
 Lfb1/PeItA8y7V/nfghN6PEvKg1hGIbk/myd+C3wFi1qn3o/LgYHnz8DXGfN4y7Ts/
 jUNfk5r4gz+Mw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-368374dc565so548478f8f.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 17:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989636; x=1723594436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RpEr08lkEBNOM5w/vUWJ6LV8EGyBWpXs4+Ov9Vbc0PA=;
 b=dkHRyeNbE2W9ASfaCyRQZPMFnmbDXPsOuiTqRWHKB8lZZk6f8jOrqql7D/Epm0cLN3
 OgqYS5f3hrmv4bqv0tbFDPLgVCdVEJotIWCcJwBpPmPksiDHtVWjlvXqyu1hZh35IL1h
 NYKKTOx5joyycQCpE/NUkohZ0/0MNeQLnU2BlGM9ZdosihTSpX6WHGTb3hE+fDmZ5aFo
 G1y4G5ol6UM7tGe6vjV68kKyknsMxhDd5KaSXZV7CXTOu5upvKX/iCFeIHU0RCkG4nRJ
 6gbJgIXW9U86P1JGe76Bw6I8tRZRzjOsYgawHGL5eaPx6W3xnnt9C5Gy5hXj8zqFDdX/
 7ezQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0/D9XZhMSwRjDFzXAfaTpDM9oQvx306ZslEToPGA43jxnkF5RU4bIrAS+AqT7bmfEW9k/JxUpS17hmJGXdxIukKBohQ==
X-Gm-Message-State: AOJu0Yw8Cw8B9lxMCONejsAKYYgfzKf7OdAENuYrC24oV55RKy4yWl+s
 Elm5r4TSLIbsTn+fZzfOqr7zHePJ2jxkcO9IqZtty2CJZwel651MU4kAzG0urNhcL/oGR79lEJw
 I1xD+m1HP7EPY6ZZT5ThKOjbDZruYLPnUP3/WHsyzKkTWT9gCcjFGwsI5ZoJphQV5hcQ=
X-Received: by 2002:a5d:5274:0:b0:367:8ff5:5858 with SMTP id
 ffacd0b85a97d-36bbc1d346dmr10773258f8f.56.1722989635707; 
 Tue, 06 Aug 2024 17:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHivoHsKA6EHpYI7Zmv38JyIaCVsNcFGx2lBq7HpOgohKjkufqDWbN952vXpgwfPph5eFPs0Q==
X-Received: by 2002:a5d:5274:0:b0:367:8ff5:5858 with SMTP id
 ffacd0b85a97d-36bbc1d346dmr10773242f8f.56.1722989635075; 
 Tue, 06 Aug 2024 17:13:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3031:2e0:52b3:22a6:b8b1:7d3b:dbe7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01945fsm14207572f8f.41.2024.08.06.17.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:13:54 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: set correct block device name in set_efi_bootdev()
Date: Wed,  7 Aug 2024 02:13:45 +0200
Message-ID: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

For SATA devices the class name is 'ahci' but the block device name is
'sata'.

Use function blk_get_uclass_name() to retrieve the correct string.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootmeth_efi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 39232eb2e25..6b41c0999f1 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -100,11 +100,10 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
 	if (last_slash)
 		*last_slash = '\0';
 
-	log_debug("setting bootdev %s, %s, %s, %p, %x\n",
-		  dev_get_uclass_name(media_dev), devnum_str, bflow->fname,
-		  bflow->buf, size);
 	dev_name = device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE ?
-		 "usb" : dev_get_uclass_name(media_dev);
+		 "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
+	log_debug("setting bootdev %s, %s, %s, %p, %x\n",
+		  dev_name, devnum_str, bflow->fname, bflow->buf, size);
 	efi_set_bootdev(dev_name, devnum_str, bflow->fname, bflow->buf, size);
 }
 
-- 
2.45.2

