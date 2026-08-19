Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7244C5DF88
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 14:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15A496071F;
	Wed, 19 Aug 2026 14:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t9UazdEPz3zq; Wed, 19 Aug 2026 14:35:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787150153;
	bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dw1Qc9C0oJUXtQloggesUaZWYtvDQNEyubN0lL2EfmzLF7BxTwuVpY0tS5pmPN+94
	 J3bylyeIU92DETUpVYHt6zBBobRWGLqQY4sDnsFhxqHISW8bKgihtaTYB8TkgmPUiC
	 X/KUBr+sm5RPilj1bu88k2tvrP7om4qR1tnnBRvzXhfyFv8KT3+iwD+93oSuYLKcRm
	 V66Vfy4trOrN+TTUytjJLcuUEMH/wRjm+4bPmWTqB1nLFJtINpibTv++sp2siu3+xD
	 68GSgQlTqihOTSTCi6TNnh66Mk4UgOioVY5C7VBld4YST9/TT2NaFEfurUEjKIuGoH
	 y6R4RfdoliouA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6409B60743;
	Wed, 19 Aug 2026 14:35:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AACF32FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9194D400E3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oz-I_08A-5Fg for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 14:35:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kP5kndvC
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 519E440093
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:48 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso7543895e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787150146; x=1787754946;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
 b=kP5kndvCZJAXX2ypP5N0X+A/HqFZAutQXU/xO1aLzW95xAiQS3Kt6Pe6nj8rAtMIF8
 yK1eymvUI41GT98ZVMKosiwt6NdMFdPRtLs+3upsPBozW6VCHaMq4tgS2c4LduqRj/Hr
 tQ1ExK/60FAjAhiRvO/0FOeErenUx+fwlbW1fvk1I1cNq7pAnxnjPB/WXWjAwBfc17fR
 9L8Ccz1WSi3NQEc9XZy/EuXxYngJEIgpbLP0f80Esi4Zi/FaQuUJSzYLDXqnpJ57H209
 W2Rao9Fn5kd4KHxQkz65cojbNuODVta6JUb3Ix+wxPqnVOIIZzSpojvzMgYWNa2GSJ7Q
 60uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150146; x=1787754946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
 b=RAq9nOhPxYIoApuuerp0/rhugaMvJCIHuqLRd+0mFv3gaICoH55V5+OBKI8S1SMW5D
 A+esc9tlgeoGV7jXniXmzNQVv0vOYN13zINGatHwTTjmZ8X/x+Oa3qcccsqOJD2E2QHg
 61CrX+C87XIHq+uQYrH6HKozpKNPJvzZVozl78fWpwKVUBOHwd5vlw7Z9eIQVz1zVjLd
 cq4LbC4ZnHTObkIbXnpwO4q3BLz8Xgk97vC6LEmxtKN1cazjeNIdcruyU+UvOTqgIkrK
 UzuSQvhF8ivXtIxEoVVXcGuZaybJNyPJ00J2kK1/wMRCxJ73neGQgF2v4m8zk+hfV6MN
 iBfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RppQCuXkRnk+tR9qD67QQVt+W9bhtqrm4zsgS/1Memi5vomLP+C4DTiSRK5bxoeIfX33wKHgJw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YygJbq5ggxhPJ98opL0HM7UUtL1Yd/2KpasLlaUPQ6XD/9NhWXu
 hPc5L/lstLO/dzjwN9djBnuUrWisWd/TuiYdivsI/YtN+p6rJ9YMJu6TQK3IAw==
X-Gm-Gg: AR+sD11imyoNjF/TruffzmmTzBoBmuhV36NdC/TxJJVU14I9wTpjwSed+opKvU9GdpR
 6WXSlDvFKvrSJNDZU9CNBeOw8BYAvURPJi1HcXMAzaGGdpfcDBCssuAT/mYMaMx+ynb0CzO9m1t
 6feU7cmjg7mP0WfRouPi0y3ASWpmiXxA7NS8uuYfIlQLKfAT9QkHS0zbL4iK+ItUdw5tsHeXEki
 n9z4EuZsyTRIcB75kP8R90ZadebdrhOgd1yKIl1QQlCKQGRd41Q46AkzNB2ZnrU4dsNFT4idFRK
 tjfIEH4CBd2S0WG3PRKeXFsPucjVa2/JY0XL0w7nrFuth5xiNzZY1NayLiHeBZ+VjYe1aIVCX88
 zetgMpL2qH3fmasFQ1rYbm6Lmug+5Q4Czl8/TfAnrbOXaNUbPianBgn/s93/ROaRjXdPkfQa/p1
 t9eJ1vj+UPwONKtqvTHj4V+hERxIoHaNUQurdPCjleo0YXOYAzHCj517JMMNElzcZ3OQ==
X-Received: by 2002:a05:600c:3490:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-499aa1d05eamr118546595e9.10.1787150146269; 
 Wed, 19 Aug 2026 07:35:46 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm3811405e9.4.2026.08.19.07.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:35:45 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 1/2] dm: core: read the device tree into plat data after
 pinctrl
Date: Wed, 19 Aug 2026 16:35:42 +0200
Message-ID: <20260819143543.427396-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819143543.427396-1-mehmet.fide@gmail.com>
References: <20260819143543.427396-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

device_probe() calls device_of_to_plat() before it applies the "default"
pinctrl state of the device, so a driver that acquires resources there
sees them undone by the pinctrl state that follows.

It has not always been that way. When the pinctrl uclass arrived in
commit d90a5a30dec1 ("pinctrl: add pin control uclass support") the
state was selected before ->ofdata_to_platdata() was called, and it
stayed that way for four years. Commit 29f7d05a347a ("dm: core: Move
ofdata_to_platdata() call earlier") then moved the call up so that the
platform data would be read before the device is probed, which is
reasonable in itself, but it also moved it above the pinctrl state,
which nothing asked for.

GPIOs are where this hurts. On most SoCs the direction of a pin lives in
the GPIO block, so a pinctrl state cannot disturb it, but on Vybrid the
output buffer enable is a bit of the pad register that pinctrl writes as
well. A fixed regulator asks for its enable GPIO in of_to_plat(), so the
pin is configured as an output and the pinctrl state of the same device
then turns it back into an input. The USB host VBUS regulator of a
Colibri VF50 is one of those: its pad reads 0x22ed once the regulator
has been probed, the value from the device tree, output buffer disabled,
and no USB device is ever powered.

Move the call back below the pinctrl step. That is also the order Linux
uses, and the order the board code of these boards used before the
driver model: set the pin muxing up first, then take the pin. The
pinctrl step itself cannot move up instead, because it relies on
DM_FLAG_ACTIVATED having been set to break the recursion described above
it.

Nothing between the two positions needs plat data: the parent probe, the
power domain and the pinctrl call all work off the device tree.

Tested with test/py on sandbox, before and after: 11 failed, 414 passed,
210 skipped, 1 xfailed, 20 errors, the same failures both times, all of
them from tools and images missing in my environment.

Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
NAND: the pad of the VBUS pin reads 0x22ef after "usb start" instead of
0x22ed, a USB stick in the host port enumerates, and Linux still boots
with Ethernet, SD card and USB working.

Fixes: 29f7d05a347a ("dm: core: Move ofdata_to_platdata() call earlier")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/core/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 6024534ff93..ccdf0ab9220 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -500,10 +500,6 @@ int device_probe(struct udevice *dev)
 	drv = dev->driver;
 	assert(drv);
 
-	ret = device_of_to_plat(dev);
-	if (ret)
-		goto fail;
-
 	/* Ensure all parents are probed */
 	if (dev->parent) {
 		ret = device_probe(dev->parent);
@@ -552,6 +548,10 @@ int device_probe(struct udevice *dev)
 				  dev->name, ret, errno_str(ret));
 	}
 
+	ret = device_of_to_plat(dev);
+	if (ret)
+		goto fail;
+
 	if (CONFIG_IS_ENABLED(IOMMU) && dev->parent &&
 	    (device_get_uclass_id(dev) != UCLASS_IOMMU)) {
 		ret = dev_iommu_enable(dev);
-- 
2.54.0

