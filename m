Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5370ECCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92B7C8149E;
	Fri, 16 Oct 2026 09:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0JZeGIYNMMc; Fri, 16 Oct 2026 09:06:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 031B88149A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792141600;
	b=ICMb6CA7EyYez3JJkT9Zvsfq/+6WG+V6ZQBWmcB7xg8TwOGKVKrxrSu8QRrZrgYhiFSu
	 ko6LYZzvRpZB6frZQ9LTuMQOtgXBbjhW4PIjiA26uEFEvK2N58TfpxwF3yynviiwYUsC7
	 AxaSVfhh3UaQ0kTkh/gxmfNcb8UqIFwPlL4aqw+jA0G2tx4glTX7BjxhxX0mWnDcJFB+h
	 qArCzoxU8i9Me4R26ZgTtREbcYKMaa+6bNCJlomS6+CQR8iT5ywrlLj/hIwRMcxg0BnCI
	 /7q3V4kOSYjuDe3Ogz/BoQ49AMiVKQs8nt5Nr8mP1Gdgj3Ui9QR4h5oNzvf0cMQvTww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792141600;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nMh/H/BOMp/SLWmMi0SJVSE1sP4BQTVx/4BmJkHZQVA=;
	b=KSiaBkCp/F4AWbxvhhGSHbxOJkA0hF8t/klnLesZNwVzuxxXzQtoMTggvjoPwuXGISaY
	 yTsZsqLdq0RoZHWeB9N9jqiO6IIOtFno2cxO1/TXZ7PbzCmJm1mIJ1tEzq1Tztjbg7dI/
	 dTNJA4Y5Tqy+yZsWLe3phhgom0+aWZ2a+OU4+zv7h7UrMh64L8JLxLWQ2ph0DaqvFQyBh
	 L86kVeXIymst7Y1dB4Or6gH8lCrsPl3S4QSxS3Fv2EH7+QWjY3CzmytQ/58rq7dlwz3Bh
	 tE2GeDRX6wnea+bTvcgMH1dBztmhaI8EvXjb30BIP8C3xNcimUPnZgN4j45B9Gq2EVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792141600;
	bh=nMh/H/BOMp/SLWmMi0SJVSE1sP4BQTVx/4BmJkHZQVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sWP9opyykBu46vhumD90D8ijHEO5h/+gEE5yQjEsZVYhLZrwz1jZfTT0ms0boqHCC
	 I7xinsc2kcIFTQdfDyQT6wD/jGIaZQqw2mqlXdfWWCAjmR+2HvR84NJUy6MX9cDtCf
	 bIBs06bYiJIjKzM1Dw4dcYjleNOa75ql7pB6E1I3/3voC1RsDHiQ9SkL1BNwu3bY0k
	 RFVG7UFbHxC+N9h9oNVe2owRwyGDJbTvkB8E/BUGJKae2D4pHcC7xi4ugSycznt5pV
	 G6wlkRDvh/W+3UNH5Z9egOVvSmSNZtHbXWRl+4C9nFZHf7xUcrXQHeR5BVxMBM4K9J
	 VlU6O4EESV6Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 031B88149A;
	Fri, 16 Oct 2026 09:06:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AA252A8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 462F94022A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dAriI0IZz7hp for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:06:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A72D40100
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792141592;
 b=scZZkYIa51E0FHZkfQJDaoNnQvEdpTwXXgzXemvTF5kijPfS9EtCKd4eUt9ymYXTcDvu
 OGDyOCVfC7BAuUgYmvfqB6BQxVgOWxsKX2OmBzRvdm/ESINECO1d12LuFx/E/dCTDNpON
 flOwG5fFRXhYirmRg1jlXdzoLeON9LRALJsrIQYIEYFfdC01VHy7sxWVa03Np0mzp/xqq
 z0NU5LdlQWDh9gDEByL1Iv+IX/JO3Ob9PgdRA95P8SjkB7DW0UjiREZGl2ILADqqFgn6X
 KAlHsCcvBm7Fkew2Lxfc8ujoOmMnNMyZiiPwfp3kz2xdRx/zUASBPQ9EtYxd9Zjtr+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792141592;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=nMh/H/BOMp/SLWmMi0SJVSE1sP4BQTVx/4BmJkHZQVA=;
 b=EhS0nV37rK5PSrHHULJuXbQ6pzTqfxLa+SKJOhuuDuTT1jvOBpTbzLWw+0lh9caqz1J+
 Q9TufcwUlZqNg+LDYpTBdjtU7oi3AK8b1QKoxxqDM1hdUk7svDOUHpKKT5Y4z7yN+WCXf
 Imge7INJkkgHjKuAa+DTdvmM40hLIunjvHUK23wqODaA+KOJNfwQcH5phT9tYEVQ2aFJl
 J4NwSfMWdGYztXibdrb2h9piU8DA5Zhqg0JX1lLa+oB+i4GIM0KhmPoxGr/k6ERDymooJ
 sYON91AKj7u/xVDayinnF4VK5X3PKx9V9pGxO3BmMTc/FFiSYkrXRn8PGiyXkHnBebg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="RjoYQ54/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RjoYQ54/
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A72D40100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:31 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso44507025e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792141590; x=1792746390;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nMh/H/BOMp/SLWmMi0SJVSE1sP4BQTVx/4BmJkHZQVA=;
 b=RjoYQ54/xsCGAl8kklxjI4rtgyOB8WL7i2C68tIoeG8KlNbC1+Pag5/XlowOGCCGHi
 NgfaNkQRb/dJlQh60HkiFfIbn4vm08QIZdsf3imgZt6CxzMGdksFIFKzU7LSGxgZ9Mmj
 LvaSFTnnFJhKpO+Btal5bp6N8U2DtgTX3JePkwSkHrHk9Czof62GUNk5XrT7dIpPLBZN
 GCKVYPfxbq53FSiLOVbP4o/NRdBj1VlNjWvr34CgYbCBFW3xX4z1qwXufht+W6wvc8bp
 qkALm40JpowABTjYB0bT3/xraF0WB6EUhFZwgYnHAlh5BK4g8mIhRmC1vH/NGppWFidJ
 R2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141590; x=1792746390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nMh/H/BOMp/SLWmMi0SJVSE1sP4BQTVx/4BmJkHZQVA=;
 b=075kpIzPEXzjpMaFKWJMlinRMKNyQj4gvlV/bbSXU6HYPQT2aHT5Zf0Q1Dd5fAzNw3
 cjdmZt4Xr9PrVP9jPurguFyycyhSD8TVGBDswKUmITMZzdgmQCKZssCDyWNItPZ8p18z
 yTuNop0oTY1GdAyNKkQD9tWhOx0yQz4qKWeePZeTo9ueKmLg5WViwxcBI+hm1WvwZekW
 +CEwOxlQU/vbe85Fl3YtD6JlzixrJBYRfp4Cs0MT11agh1wKdAyRv6KPn3TDjbbr0+5f
 lUC9ZiZ/fVad2Ofyp/CtYRm+dk7d7wDUsfx1YWBjC7xfPYXTqfgLMPOJ5he0zZ/V4lrp
 dOBw==
X-Gm-Message-State: AFq9FYJRJSY3E8oemLqSgxQLD7gLwCvKjU4jOQz2VsVK+02AenaQPHx9
 kVIKbimaOKLtZ7v9wRRdslraKrej9P9VHffbp96kADSBHbldbIi1SC0dmpYI38XV5shAthcZ34g
 vt820
X-Gm-Gg: AYBFou3kCA3jvCJ+lN7mJxEOyj77T+cuQC1frB+wCsZga57hDetS6XSEKGmGiNEOK2n
 f8QfiZPNIaVkWCdmnleCihA386X36Rl24Saxc+hwJco825YmjL+tllfbJH30Ok6lq+K7UUc537F
 g63ZLCkUnCnNvYhzFojxzJDqHJTLreSR3UYoOQKOfrw+zoXuVX8uQ2mjzwZoKvM90aYPxeHMV6X
 QPxueIKaePGOFQyB0Gt8mHBTlgPobS3r1qLzzr+nbH5l59l11cx+3vkI1Z1lggFP1Cr7AtDcJyi
 zxYYt0p1weoL0cZVA3eQgB7hyMHjF9tmHS+aNtek/x7dGUzIP/CX7iCrh/3/oX5mpKRKqqRF5qL
 xluL9Mgod7RXJdkVzhMHJQE7fkjZgbQ9r/EETiD2QWSrasJobUXLF5/k2Sh5STvLYYatTQY/At2
 nbnUwrC8Hfxh8RYhuH58V+OtQcErISlikCaM3oG3VeOYor3v9aAVoQMx48SJb5vU45kU5gPOXr+
 TxsJ7MzgQYRvIk=
X-Received: by 2002:a05:600c:3e16:b0:4a1:992f:d0e7 with SMTP id
 5b1f17b1804b1-4a1992fd259mr366106635e9.16.1792141589237; 
 Fri, 16 Oct 2026 02:06:29 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm121287685e9.0.2026.10.16.02.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:06:28 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 16 Oct 2026 11:05:56 +0200
Subject: [PATCH v2 5/5] arm: mach-k3: j722s: Wait for TIFS initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-5-c7ab53f79b34@baylibre.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
In-Reply-To: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=msp@baylibre.com;
 h=from:subject:message-id; bh=f+ttXl3trp+FUWtDKXbyO8Po1BsG9fgDg4MmtUKL984=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLL7lc9Ge//jdd94O8Qt1DS5uXvtyPTeTnPhObmFFXs
 74ig/F+x0QWBjEuBksxRZbOxNC0//I7jyUvWrYZZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jBi4OAVgqvN6GP4n7jqSoZPNlnpkUvPzysRdzBuTy2vnGqW9/7oq78qKjXdOM/x3a1/l+L/
 B59PjRemrju3+p9vhOe24h6K/j3ZBZ3KU13VuAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). Note that spl_early_init() needs to be done first to
setup DM.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/j722s/j722s_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551d..c15b3b2682d9 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -84,13 +84,14 @@ static void k3_spl_init(void)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	ret = spl_early_init();
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
 	/*
 	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
 	 * regardless of the result of pinctrl. Do this without probing the

-- 
2.55.0

