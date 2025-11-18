Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFA8CEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F60983D7D;
	Tue, 18 Nov 2025 14:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RJDjqAuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28F383D07; Tue, 18 Nov 2025 11:42:19 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C360E83C98
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64074f01a6eso8985287a12.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462537; x=1764067337;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aB65zoW/lHUpl+TLaWPg+0mgfxmZbV9ki51ikNMrIKE=;
 b=RJDjqAuFhdkjnZ65/3Ro5iaGZOyamkNUv6rhQYD5LyQxXvSao4FwiweSAmk0CEnK8R
 O8qxAy8Av9L+C8vy9oHvh8I5cyCb5uYYxXNebStBqtpJE3wz2Ok+pyYvoW11vHMtx+mX
 H+pje2qtRf8pfn7GJqCVAycJa6JK0BqXDJToJyawzKNzFjsDJA/dVgY1Glh6jSmG0V8f
 E7T18HWiw1x5DqlKftd1/EJtpOYodR0WLlGgJj26LPB91or93KPoSWWsCXWxTK/mvbDp
 XACQCOeeYLqRQV1AFZbuKEZTCkL3kFok3pKeX5xAUc6gXq6R9pM37m5f6J/ckDycp43f
 Hnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462537; x=1764067337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aB65zoW/lHUpl+TLaWPg+0mgfxmZbV9ki51ikNMrIKE=;
 b=YiQf0454WM6mWSwCOSd/8Zv7wb1MyxKk9SDzXWAzNrXU8xuhTnfOqn4BaAJd+er+cA
 9IFaRfAIAtbpxMRqsYwKJE0+b+vwwxBthmtH+UOeiIpZ61ZwdNHzu0i8ZNjMjKGzHJfb
 Jqt8utZX0bHUDLC/pcKL1h+oBH++RoiEKJHYgD++ZflpyzHNit/1Q24+lyujD1EDXyfP
 lXMT7/Glkmddu7m+OBydHsIz1jkDa7AJ2eoy0rEv3crI3hZ4mQ+iFTSQ9ha1gnCv0M5Y
 vE4jUXM5M/ds13D2zkDQjarr4jfveS1SZorr6pDAd66mh8NJqetqP1mQUh953JKaeJsA
 FD3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKvKYhQQFkNYSYysPJaQmwUBU51nXWwnTR/VFvYzBHH6/XuulRis8hWox9HIrSDQwewu9fxfQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxSYtCiZsxsdRh8RjVbncqh23EG8kSXuhhX1La//FIq8vSZW8x4
 bq9vHacJ9IvR10WuARZ0el/hIBO+iN0vX0BWcm1vOmFz9G+8qWtlTUTBAjzoLnkBEX4=
X-Gm-Gg: ASbGncuA7MCEem3n84dkPgiakU1KBSIPi7XFR4aO2gm8fnAhbpgEtW81KVj2Ln4/FIi
 4XwW4BOlIUiT3bTF54wr5K6Qv0Z6+orQ09XKesSOQXyAdR5a6bv8lEFVzCZoKAu2AyWbofQkDkU
 OZ2MsSuwLZN7DAlIlGcWyOkB0F96sOZn5vxX15jtfRDR624zl1GNNj1SVFR5SxtsJMlL3DclMVk
 gi1WTmFlRC2m28pd7+hYTgwlG/TzhNyJ0Jvg300fTURxY+znUvQkeViZ902mCFhxavyiHDuwO4n
 MI5X7CqBPz2afMYiClrTcSlDWOv4TvQz8w5TBvZmyqhCVl12yMp3K81paurepuryBRVWxdkhvda
 7+R4nAbeJz+et+6pYCCFFBPydqT5VYiHd0fY54k0iZujkP4mCENHKPsJfLAmmQ0b4CDVxm1w1
X-Google-Smtp-Source: AGHT+IHGcgaciwefWi4pC619M4qt20Z1nU4d3JoS4NXy7T9P2nIawNontAEANY0j3RBzWOaNYAuLdw==
X-Received: by 2002:a05:6402:34d5:b0:643:18db:1d82 with SMTP id
 4fb4d7f45d1cf-64350e2159emr15037569a12.11.1763462537168; 
 Tue, 18 Nov 2025 02:42:17 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6433a3d7ddcsm12404555a12.1.2025.11.18.02.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:16 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:23 +0100
Subject: [PATCH 03/15] arm: omap2plus: Select REGMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-3-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=719; i=msp@baylibre.com;
 h=from:subject:message-id; bh=DDoSjHI09+zvmrwTB1lrFtgIYoH9ilF/67+7syrAkEE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZX/vmvM9sU5TdGRxivryev7/aV3TVo+nm5jwz6014p
 5yN+OPaUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABNxk2H47+kzb2oB8yHWD+pu
 IUKumfpLpIPefj8j80Jgep0kV/SqHwz/lCcdeLx27z33CqFd7tGBByVsz+WcF0xhnSt//+BlnWN
 yPAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

clk/ti/clk.c is compiled when ARCH_OMAP2PLUS is set and uses regmap
functions. Add REGMAP dependency to prevent linking errors when CLK_TI_*
options are enabled.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3db5474a05b8c08e111e8c8b98c3a6fe68de15f2..c72821ce2131e9d9deebef4fce3757fc68bd9f3f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -844,6 +844,7 @@ config ARCH_OMAP2PLUS
 	bool "TI OMAP2+"
 	select CPU_V7A
 	select GPIO_EXTRA_HEADER
+	select REGMAP
 	select SPL_SOC_INIT if SPL
 	select SPL_STACK_R if SPL
 	select SUPPORT_SPL

-- 
2.51.0

