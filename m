Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E8CD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23ADA84879;
	Sun,  7 Jun 2026 21:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ky87O5tY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757C6838BB; Sun,  7 Jun 2026 17:36:37 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54226801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-842338c18e0so2471442b3a.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780846594; x=1781451394; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3vLYNgfhlTTwKidRQwZW0H1/9Fj55ueKfVDys5k7JwE=;
 b=ky87O5tYoM2d7idt6VSUU7QEnUEqFr3rsfcdRTAop+IkwAtASQshbMQsyGOxzfGFjX
 VuXdtqOqdpjfvqBoO/M2DKNk6Aj2R+HyzXRPG/k3CPIVX7HZkSDBtZKC4GZAyh4bmv/m
 ymlRGPOvz+xb+KWY1Q1H+GNc947QYVcpawVstPlowyYoYpInl1VSj4SAbWVkELqYKq+s
 eWnXd8PnDrCfpCNjouGhxR44DaOYEubazFGd06D0fn5uV9YeVyegXziDRaiL2RUWQqZh
 FoBTWEJDr1M9mkwOuNLM35c6o97U0EYFVX/saejBMB2CLeJ0E4aco2nX/WlR4NV6DE57
 B6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780846594; x=1781451394;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3vLYNgfhlTTwKidRQwZW0H1/9Fj55ueKfVDys5k7JwE=;
 b=f0hpsIrbRpB/KgtO+nz2KoMoz9McweDjihEpz6RvBkufU6K/FVOfPTLJLeYKhKahz5
 wQPIwm6jbzFaJoZDRc5C3mENcA/jTaPM+h6pNdUUYkw7nyYU3ku0nwxUUqLVG/XBqRar
 wC8Q7wGyIzCVTcpz+0JE7FLqalvtc1AHFP3dYAu3zvOqeFx4y9Af43nCcZyw7vT7/qbG
 7XEsWxuEedFF0EclkoVbRkpg7nuQPd6aMiNxuHCIvHgxit8QVl09PshfQ9UW4esIl7Yv
 9ZQ315MYoGaX6tYppScXoCcEJ86O5PabCKu3qRGfLhsEai8W0k4VIvjmtK0fRCP+7rI3
 eRJg==
X-Gm-Message-State: AOJu0YzMiUGx4XdnIcE13H/VSUOMid74QHGg+VvXdvOe8lGFc/i/DDB1
 gjx2EBkJuSlTGCme16tpj5zMg/BcQt/iipOfm7YAHFhFSogcqg8rPAlYitMDig==
X-Gm-Gg: Acq92OEqQlyC3a1AY8PPUprpcRxDwMORUCTfj9oKc6FNCboXH0Y2MHV5/ik/FtiQGkx
 BeElCMRhy3Y2GRw2Zn/CMCMu1+mHuyXmWbo3YmJhO6Oi5jtT5Z3uhA0EUtCGaCWo/1GnukDxgs/
 5YA/qyWNno3uJcUK7uK7W4aN9m9fgfQt2HlTygauFVkYqq81wmPS0A0z5/TtJXtP5EmK9XsMJ+l
 0nRm30a9pXOPPtncy3Yv+a8hqwokRDBIJISzEWLB63PWRVmXUxf43b1+WMnN17sM9kht9aVENpN
 GBOwUzRvG0RcglT9UTSPWknBkPaIWlb4d/5FQ/QROQAyj7GpMVOj2BUSIW0J4V4Ls3UbG/sPrBT
 yKK3queVrKnBy7gGFWaa67c64tEnt1UOFdZ0J7B0QwMMOyM0NZlOIKUzRU6n/CmS/Ut0z/cqXrW
 1X0nylRJCqXGY6C1KsOopAh6URl46OAOqv/KU=
X-Received: by 2002:a05:6a00:a21e:b0:842:6004:3fbe with SMTP id
 d2e1a72fcca58-842b0f56e14mr12654710b3a.25.1780846593648; 
 Sun, 07 Jun 2026 08:36:33 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282880050sm14935858b3a.29.2026.06.07.08.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 08:36:33 -0700 (PDT)
Date: Sun, 7 Jun 2026 21:06:31 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] serial: sifive: remove busy-loops from getc and putc ops
Message-ID: <uqth4koabpkytf4u2nbq54cszi5bsaov35x2vlc6mfzigwhv4e@ejbsksdz42cf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:32 +0200
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

The DM serial framework in __serial_getc() and __serial_putc() already
retries when driver ops return -EAGAIN, calling schedule() between
attempts to service the watchdog.

sifive_serial_getc() and sifive_serial_putc() spin internally on
-EAGAIN, which prevents the framework from calling schedule(). This can
lead to watchdog timeouts when waiting for RX data or TX FIFO space.

Remove the busy-loops and return -EAGAIN directly from the underlying
helpers, letting the framework handle retries with proper watchdog
servicing. This is consistent with how other DM serial drivers (pl01x,
meson, cortina, etc.) implement their ops.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 drivers/serial/serial_sifive.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/serial/serial_sifive.c b/drivers/serial/serial_sifive.c
index e47828e4d6a..0203e2fc37c 100644
--- a/drivers/serial/serial_sifive.c
+++ b/drivers/serial/serial_sifive.c
@@ -144,23 +144,16 @@ static int sifive_serial_probe(struct udevice *dev)
 
 static int sifive_serial_getc(struct udevice *dev)
 {
-	int c;
 	struct sifive_uart_plat *plat = dev_get_plat(dev);
-	struct uart_sifive *regs = plat->regs;
-
-	while ((c = _sifive_serial_getc(regs)) == -EAGAIN) ;
 
-	return c;
+	return _sifive_serial_getc(plat->regs);
 }
 
 static int sifive_serial_putc(struct udevice *dev, const char ch)
 {
-	int rc;
 	struct sifive_uart_plat *plat = dev_get_plat(dev);
 
-	while ((rc = _sifive_serial_putc(plat->regs, ch)) == -EAGAIN) ;
-
-	return rc;
+	return _sifive_serial_putc(plat->regs, ch);
 }
 
 static int sifive_serial_pending(struct udevice *dev, bool input)
-- 
2.43.0

