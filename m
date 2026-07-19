Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979FDC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2876784AC2;
	Sun, 19 Jul 2026 20:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="PPO6dPQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE72F84A60; Sun, 19 Jul 2026 20:04:14 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A372284A4B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6675db463b9so4855504d50.3
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484251; x=1785089051; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xhxw8QWgTYAbmJzwrvYD7eUf/+87Wm+ysZHK04wr8wY=;
 b=PPO6dPQdvim/I4Md8n5rlfyIz6t2P5QDn+LXVZjSXNLAoOyczHnFOAFlosDrtGRo2c
 xx1YCGymfVdk3pqFdbqs8Fle+KsuvpGZRYNfxeP00HpQ6PF+jBXSatVh2gX9rjNDKNFi
 MV1KIppoO+5JqOVe39dFcetUu06oRAW+iu0+qDbP5JiaaiwljV0idlhjCHtrLX3gAwsn
 Za6ddnk3NO+YCtGkPA+j/DiF555DVvHhUTfxnqIsDgHZYLktOWG5vjUxNr6MIuv/qCj4
 ve+bhRWRyA8rjtQ6JKIt5Hx6VphBOaKP0g0oeF3+vApjoJGogd+XbCSLEgMIfLjIHvW0
 f3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484251; x=1785089051;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xhxw8QWgTYAbmJzwrvYD7eUf/+87Wm+ysZHK04wr8wY=;
 b=OtU7TwVFeHksBMjXMba6ON2HvnhrDt0Syjxi6R6GR6X8X6FYatJPTvqIXWyN7f9ToQ
 RYqGSiJ7MUGfedXBFt/AaLiZfl+ZArc96lzJfgfjaMZXHAZq8qSiaMHtSVrkeZ16u/C4
 nHvmLO6UbYPpvrZAGj1EhQu6KmNlmAxsCknYVl2r9WDH31m8fWDdbC7o3smhjz1lM3sY
 DiBjaC+0IGOoewm3aN+K34oi+y9M8bsdTwXtaMdZ4KtXZ9YiWm9xIm0ZeH8kVTu0dSLm
 BO25rA75sdVHnT8o9xP7rN3km6A67VwCzq4yQ6lo8xyUgtk7aFfCssDUooFsaM7t4Ja6
 5BVQ==
X-Gm-Message-State: AOJu0Yx4+84MOM9UVy2VUkdoOEWYZi+Em4FKBZagsyqRGvg8UkkOheyW
 o39XRqdxhvzLH9chr0Iw512UyJTe+ErRdY1g3gsPM1cFH7VHpDzbfY4rQx0PqKu6GJA=
X-Gm-Gg: AfdE7cm1b72B9QQ41bm8hAPWVOL4DilHdnAisEbB0wbxQuhT1lPKBVgjd95XUwgK5A3
 kC7CkKTk2fQJnf2l6k6X4nTnqsh9GLiQeh82zc4YVBWt1v0ac7r9vqQGo2gTROdgTFO0m0QcRk6
 n4XSP9mIfIWMijXkuMfhSBGwU0Rth0iRn5OH4GiMA4/nbgUAjIosrBAzrvfByPzrQJ/M7x/aV0l
 Nik3/w8fmv7zDTLQlenyhQwgNrCIQxB1rCbrybJdspDPWcI4FqraMrKGP7euJeQLa9aNZorObA6
 DgHtJBMee96ImZb7UIZ2rKgVs+JbDol39OuHsaIvtYtYVTlAdKA7rOreJtizY1ys2Wpdm2Y2Uzn
 XtCeO/rkgf9AQi+0hSHHTp+u9pwYClTVRcvZ9AZXRkxErLjjsrvSf1J4q0aXFEpT0WEuQRPP2tf
 44ipTTv4bu34Ea1TD8LWlKwGyw2VFU7IsoRBETI7LqDZM72QVL672EQw==
X-Received: by 2002:a05:690e:1c1c:b0:667:b57b:868a with SMTP id
 956f58d0204a3-6683bbcc46dmr3272395d50.6.1784484251394; 
 Sun, 19 Jul 2026 11:04:11 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:11 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:03:35 -0500
Subject: [PATCH 4/8] bios_emulator: support 16-bit reads on VGA port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-aspeed_vbios_fixes-v1-4-c94026f28250@oss.tenstorrent.com>
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

BE_inw currently doesn't handle 16 bit reads on VGA ports and falls back
to LOG_inpw, which doesn't do anything on non x86 architectures that
don't support I/O ports. Implement this 16 bit read as 2 8 bit reads
(similar to how BE_outw implements 16 bit writes).

The Aspeed AST2600's VBIOS has these 16 bit read instructions in it, so
this is needed to emulate that.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index e02c9fc636c..1b0c29794e6 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -612,7 +612,9 @@ u16 X86API BE_inw(X86EMU_pioAddr port)
 	u16 val = 0;
 
 #if !defined(CONFIG_X86EMU_RAW_IO)
-	if (IS_PCI_PORT(port))
+	if (IS_VGA_PORT(port))
+		val = VGA_inpb(port) | ((u16)VGA_inpb(port + 1) << 8);
+	else if (IS_PCI_PORT(port))
 		val = PCI_inp(port, REG_READ_WORD);
 	else if (port < 0x100) {
 		DB(printf("WARN: Maybe INVALID inw.%04X -> %04X\n", (u16) port, val);)

-- 
2.43.0

