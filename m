Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB45CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F23C8488B;
	Mon, 15 Jun 2026 23:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="haXeMmaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA16F848BA; Mon, 15 Jun 2026 23:07:48 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC598484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68c14ac8ebcso645932a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557666; x=1782162466; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rHmGiIDPPbFsV6tgWE3hLqdyrb3A36tjERrmauZUDL8=;
 b=haXeMmaWCWbR8uV5Qvl+2Ebl0mRxAaqY1g8zXitxJKwa8V7V1M5f/GUh74DM8GdsPg
 KthfI8iwWa/uU1KjBZ6mTFdR5WA1IzL77clRmjSspmNZowcEfhtlZlKXP3JcvhFgdr6v
 jT0eIfBaF8MXSf8gukf9SLIcVS6zZhPYRDwQgeGiDuu/6mxAjPm3vwxg1MuXtekKcnbj
 geRaXFHusdvMZXrl0DeaZwisJgl8kdpO12G/8ZeiF47q1MXrHg/HmWlvqRIJ4K1nTVwk
 9Fot0d/qclP134RjZVQKNafq92rHO0VDdQPIpuITxvVT7ehhY3/6EIiUN5/kcfMjF6aH
 8fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557666; x=1782162466;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rHmGiIDPPbFsV6tgWE3hLqdyrb3A36tjERrmauZUDL8=;
 b=mbfU7jAlNp43biSfBwtqi2YEXWRvbGkbKNIEuBkzN+xoIxtYqUhTGmE5tbKIo0CstV
 zKvC8rQk/f4UXgid2lxTpV61pgEDLE20VbvoNq5M5IozFMUQWDfcryBfpnxG34974ueQ
 PC6zVtJp5lOSmqhM4icItaJahdjL5A4b262XYPNEu1wNKWXQhVxSPftw54KrIrsMxpok
 QOX+qijN0tnKSYWXXu/lN1SDHwN7GIYpY52N2a6yzQq5Fl9xfv/BLPt8GiLcgDRWYi0O
 3TqywInhig2Od4Wa+0NPvZOdNxchXRKrwEV8nE1FBYQqTZJiYRTLLywyCH2s8DqUCKTw
 r1Sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ztoSWcJF6whyfaTRalWE+CxfNvmcqbIF8zqZP8+kiAaaxax0L6s9ybVVEH1Apa58ELUBmM2I=@lists.denx.de
X-Gm-Message-State: AOJu0YxC+AUKLQm9hiQluRp5T5YAxR80Jv4xD3RE01syY3v03pZbMbzZ
 Nyl+Ra1uEzv1IvsWEJbm55/WlDb7P8VZ5dRq6FDLXzJFDcZucB74H7+I
X-Gm-Gg: Acq92OF10pihxOcTPwVO7K0bnUWUfWB93hRjz/PYQ7itXbWreizS7YwVNKv7v05sfsC
 MrMmOV/IAuVgINnRbo3xSzlPgcBK6tOGiYbBpzuPJHibGjQBtKVTTp6A63XrSiL5LUW3uSCb5JG
 YzHzALlSoFhmEzbh2sdyKt69xbS6iSo0UyestEZDi0IdZ/FWO/zQ7KJ9Z+zvrN49xTxZJecXhP5
 M8qTNn77F6S9o0yXh+CcZPdSDvdHpQEOsYaZxgFSJIOFQ+Ls3PF/2v1IOeZIpkvyIZDYH3AqrJ3
 eGfl/TeYHuBieHlP8puJgRJouVbBTneiX70BZ6ljLpBplsaRm4OGmDpA6VLwoyTsyxETK8d5QeT
 DWthThvA6w8xrYrqxw2SMhzN5jPZtDBfU0USmebBlhNnGqy1kfxbMTcqI39Z7BsJEesN6Rdt9ct
 9MP8xu0Vjgau24rl96l/F9G0940oBI5XY5EeG8wPs2IRCxLvaaxQS+0OwPWzZjvQ==
X-Received: by 2002:a05:6402:e86:b0:688:1d5:44dc with SMTP id
 4fb4d7f45d1cf-69377b1aab0mr2518889a12.0.1781557666125; 
 Mon, 15 Jun 2026 14:07:46 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937948fc99sm4140073a12.23.2026.06.15.14.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:07:44 -0700 (PDT)
Message-ID: <d2f8a434-1790-47e4-9c57-d074a870b37e@gmail.com>
Date: Mon, 15 Jun 2026 23:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 04/10] rockchip: bind grf syscon usbphy subnode
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The RK3066/RK3188/RK3288 SoC's have a grf usbphy subnode that
doesn't show up in DM by it's self, so call dm_scan_fdt_dev to
bind grf child devices in the device tree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c | 3 +++
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c | 3 +++
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
index ff269b53b542..41655d433d26 100644
--- a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
@@ -20,6 +20,9 @@ U_BOOT_DRIVER(syscon_rk3066) = {
 	.name = "rk3066_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3066_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
index 6df054e5b27d..543f078bc659 100644
--- a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
@@ -20,6 +20,9 @@ U_BOOT_DRIVER(syscon_rk3188) = {
 	.name = "rk3188_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3188_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
diff --git a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
index 6413d0a88a16..fddb61f419b3 100644
--- a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
@@ -24,6 +24,9 @@ U_BOOT_DRIVER(syscon_rk3288) = {
 	.name = "rk3288_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = rk3288_syscon_ids,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 };

 #if CONFIG_IS_ENABLED(OF_PLATDATA)
--
2.39.5

