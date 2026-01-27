Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C48D2D8FA
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8B68405E;
	Tue, 27 Jan 2026 12:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GZkv+Lkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB448405C; Tue, 27 Jan 2026 12:04:28 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC4C184035
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so17868435e9.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769511866; x=1770116666;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nhGIJ/5RfCFKusCEOoHuo1hVLZGB4eKdu+BxgEDrPmk=;
 b=GZkv+Lkr/Tqmgb1lBu/kIJEq9PB9J0Pbsz5iFW7NVjWvRwRX0UvXJ/PYdbUAZydQfR
 KQI851jjNHaAyN71m3B8gk2+DXzeS+TS9C/E/LmjnfBNavd6BN+RsRPV9U5E9nywuq2Z
 7V1kqah5a1qmaR8YiMqmKoDAz+x5gwywIF2J7BYp1vLzakBqppilXgEVWL3/Mqzws+dq
 VbhIxPrnvrm26rBIScycgVjQYLocFpz7/zUx5PjXG3+EH20AIiiyQK5+UzK271USwhmE
 ZjaGBre2McLEtaeVfiKPaWh/a0RBPnQGSY+3KXLazxnCiStJhxWCT0J8/0/2gj7jidEG
 P0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511866; x=1770116666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nhGIJ/5RfCFKusCEOoHuo1hVLZGB4eKdu+BxgEDrPmk=;
 b=fIvRzYX40CPo0T4gkxlUQl08WlLGuhIFWJq/ayyPURjYFQPMW5h92xndgMxnwn4qu4
 J77OmKWGozhPaCHrp0v+ugc7ZNUAM28GRTYFZby/OYRV14dXhIeNmbuskIDSnsY024lx
 RzQCKZOuGHaeFF+SXzxX82BoxxBY710BxpquJdVHIDqcvBmpqY7iUluscf8TJqxYcwL8
 HIehfYrDAOnEZDvGf5ZhN2foFEYjFd/i3Q4tRLUXbL1fcik82WBKJwel0JUfcnuuXd7q
 3svDMfxmCnSxHexo6EtnvtQ/xgZTFXGWFMrSlXhs/tkCmAahLtMd3bneVUQCHYTpVqkh
 1d+A==
X-Gm-Message-State: AOJu0Yzlv1PVgA7HBbhau0m9xSECMESOl9gfZWqMKVuxBtjnfD+3Lx41
 HseBUoNZSwMQLiOQAjOiRfToDgywTc1495T+EpmcgRMKkWfw+lWI2dDX0nW4KkZuYmw=
X-Gm-Gg: AZuq6aJqI0PaVBKotaunHV+0jGxyzZscQQvB4ylp29TDx5g/DnGAhN2Ol9x1sqX3Ngc
 tA+8gum27oPoCV/+FHlnc01HXu/XuINnKf20YLLKTFahJL8PfIv8vru/IXWsLub93fDqsBsEsou
 27BEzCeB5kYLIhr0/bT9kR42XUvlJvnamHcpWPdg3FZb6gFehN13hIKJF90KQGDVMmYqgXXTasF
 /ZzlBqF5bI/nwu0S0xSzXaLyTBY/4JBAYOzcYgoI5+8ecHPZUCqKfHnQsR4dyPmM3jwVRJT0YFt
 jfKMcxDTdPnL/ktvGPM8upv386DcQTzl/IQV+P2ltJIx3grHkolGwsNjsrFkqblf1sFwtdYz5bf
 qjzYtYWU8y5l0wgixdNiZ3HHwM+YH4AJvQmfgsa7+u02uE53kT/okJwM2F+5s2QW/PaIB3KF+RK
 YQqd5WkAwh
X-Received: by 2002:a05:600c:4e94:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-48069c0e6acmr15977115e9.14.1769511866057; 
 Tue, 27 Jan 2026 03:04:26 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c428basm56326315e9.12.2026.01.27.03.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:04:25 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 12:03:40 +0100
Subject: [PATCH v4 6/7] usb: musb-new: Relative ctrl_mod address parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-musb-probing-v2026-01-v4-6-ea3201e0f809@baylibre.com>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=msp@baylibre.com;
 h=from:subject:message-id; bh=jG0F3gZWL8eyGO0RH+Md8R7HuqC6a2b7jBVpGRQzP34=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyK2cudDWfKfJx4ds5jmZ8Hv1YGGkrPynl/69lHsw8/Z
 wS8ZM6c3lHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATSa9kZFgt/XPTDckYo9+l
 PV6fl1q9Stl7m1Vo4ve1u9dZ+2zfzuTPyHCsxzTI7fnCDYuWn1OJ/ydslKiwK3fVGZ5TralvmLx
 MS5gB
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

For the upstream DT the ctrl_mod node is using a relative register
address which is not translated by the current code.

Make address parsing understand relative addresses.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/usb/musb-new/ti-musb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index bcd31adba522fc55190fc43fd2dbd2dec93a2731..d3c3d3057c1df2a5cc62df3c57d8b071bb0f12b8 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -93,7 +93,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 
 	phys = fdtdec_lookup_phandle(fdt, node, "phys");
 	ctrl_mod = fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
-	plat->ctrl_mod_base = (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
+	plat->ctrl_mod_base = (void *)ofnode_get_addr(offset_to_ofnode(ctrl_mod));
 	usb_index = ti_musb_get_usb_index(node);
 	switch (usb_index) {
 	case 1:

-- 
2.51.0

