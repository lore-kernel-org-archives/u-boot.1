Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29DBC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AADEB84AA8;
	Sun, 19 Jul 2026 20:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="eaBdQHLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3317A84A4B; Sun, 19 Jul 2026 20:04:12 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90E384A52
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-81ec29f1d07so72566977b3.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484248; x=1785089048; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZXCBhGmZQB/xG5ArdQb8B7Qye6+garILwSkLoSV430k=;
 b=eaBdQHLhmEz3Jog1q/UV9DIEnuG98DKLVcxJ6/Xs2bzunIsbVwwr7qamX+JBMWPdG3
 zw7V+HXprXl3zNttOee2p1mCwCYcDabsK3cQ3/GyshFAh/cYD3QfSW1f07LIPXIsVWdz
 Qsp9CDRRLHO3PO5Bz+KybnR09UOlt7RxzM2f11lUcbX/wfmf+ZfTms7NHdaJI7N8Gxdg
 fipm1B90fwMrUotnu8S19pFi8s0osJLbdXjnDOArbAFh3EHNfzEQZxfZH6pCkE934sUL
 40fetI1hjXzmu3MqEC4t2G9jeahXBF9YbBuiB7123k5UFqORh1kiFgA5gf3iUzviusNB
 uV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484248; x=1785089048;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZXCBhGmZQB/xG5ArdQb8B7Qye6+garILwSkLoSV430k=;
 b=PePvYs1z84w2EvHjB+R4JRaUoe6fK0mLEfJvgmp1qktfDMnqoxKN0PERCUDzVroeAy
 cV2gbd7eGQdn9TxK7HgXEtdXy4gf9KoodyvkJGmNS4prJFOG/3rAhWiRsVJTwzy6OG8V
 W13YV41vGnWXbxe+Qzs4EbmRe/ZdcSiJda82XQlzKs/0osxMDcdDAPHBuO+OC6HuaAq2
 H5PvpanCI4EnvvaCUndVp/S+5hbxqaVUz23LaMHF3dYnerydRehKxVWvcJiNyj5IzdZV
 BBUvTlQ9TvKZzfFOemf1bfen/bGJ3MDnp14kwPoYcbV5WH5651pJLDDjr7+/S7f6IEHH
 aVkA==
X-Gm-Message-State: AOJu0YwZLt2SSy8TKF4fmTA11pYwnjAmW0HeCoHLOkjVvaVGMp3pGVX9
 aOZ2R37OkZgoDP2xFwJXpamnMlRfVFokWd+AMyK93JRsII/4OeheKaIwalm7vBCt0hM=
X-Gm-Gg: AfdE7clJFHMUgx0tS4G0vvP1XPVUuPZ/5m2Fl17HH7QNXgbNtw4KdqzSQGLGZ089gYB
 SiBLbB3i28DJy+lc/bbvUAj6EjoA5hn+xFexvcnMEY7NRcz9EQtCP0a/F+ZnLBwy8jYnnmMZ9Vo
 2ZWUthZ76hn/QvIGDRvcOjJuyMXWbxPIInXec4jD5IriUFRSGCMynD9dBJNYxwkBPIl1gNT7PMQ
 Tr33GP+zgP1lCbqqaNQzIaJe+TIyKlR1P3jZC4eoNpsB5XyVRWlwoRpJMmv4p7/vSPe0aAgTwME
 uYZNNcNF1kHZPeD4PxOf4pU9ygnn0X5c10+AfK0kS8D7Pbfb+CbLl65XYRmn1wHxsKc116i1sVa
 BwhJOlzkwvcf9j+FXk3Wr4sGbTSIg2HDroTG2gdvqTdRaxhR2AHz9q/ev3FXRjR1UV1RoI2H8xA
 kLpNJ7nMLu9yJmb1z8J7fkZyFw1S1X4pLYfECtyloO6aYuNMQcc16VVGpY5y9l/U6KRnOL8uKum
 +w=
X-Received: by 2002:a53:b84e:0:b0:667:8b95:31b3 with SMTP id
 956f58d0204a3-6683bdfff02mr2224028d50.106.1784484248563; 
 Sun, 19 Jul 2026 11:04:08 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:08 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:03:33 -0500
Subject: [PATCH 2/8] bios_emulator: don't free a caller-supplied BIOS image
 in biosemu_run
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-aspeed_vbios_fixes-v1-2-c94026f28250@oss.tenstorrent.com>
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 19 Jul 2026 20:36:10 +0200
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

biosemu_run can be called with a BIOS image supplied by the caller
(argument bios_rom is not NULL), or with no image so that it makes its
own copy from the card's ROM (argument bios_rom is NULL).

It subsequently calls PCI_postController, where the BIOS image it runs
is stored in vga_info->BIOSImage. In the first case that pointer is the
caller's buffer; in the second it is a buffer biosemu_run itself
allocated.

The clean_up path in biosemu_run always frees vga_info->BIOSImage. That
is right for the second case, but in the first case it frees memory the
caller still owns. This can cause a double free when the caller tries
freeing this memory again.

Only free vga_info->BIOSImage when biosemu_run made the copy itself (i.e
bios_rom is not NULL)

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/atibios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
index e992a1aa822..ebeeb178b7f 100644
--- a/drivers/bios_emulator/atibios.c
+++ b/drivers/bios_emulator/atibios.c
@@ -509,7 +509,7 @@ int biosemu_run(struct udevice *pcidev, uchar *bios_rom, int bios_len,
 	*/
 	if (clean_up) {
 		BE_exit();
-		if (vga_info->BIOSImage &&
+		if (!bios_rom && vga_info->BIOSImage &&
 		    (ulong)(vga_info->BIOSImage) != 0xc0000)
 			free(vga_info->BIOSImage);
 		free(vga_info);

-- 
2.43.0

