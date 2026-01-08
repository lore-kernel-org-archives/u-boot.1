Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF604D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6E884197;
	Thu,  8 Jan 2026 14:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ktI758xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE28784127; Thu,  8 Jan 2026 12:17:32 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04AEC84129
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so4367980a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767871050; x=1768475850;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NQdKySszMWxZzfLpdSZ/3XPypDh6AjD3noEf0JGmBtA=;
 b=ktI758xdGW6p2j7TLknmyf/CH7RkH6hNNXwUq9fZhek/QOr3y2oNrYn83OPg1CKJHM
 07W4DURFh2Lu7v0iCLXpUbftvbgYweirlDsHC/UuTjGJfuwT6T1qtxJlrkwHJyK9cIqZ
 R2POWou9HwGx+RE44+VYSzwnoFpgaAnII1mHLkGP1KEwn7eGq2Rm2g5DyFRGKrZYU5Ky
 FYBfiQXpYuzyB02aiMhy4aImuP1GB2HytureXoBCyj0xSacXONoh2HDHRpks8CLjZ/Zs
 ynqaxWOFUs0uJd7GA1zK5WiReoUHkoUyc8XRNdsrly+Xyk8XcMOR2LyzSRTqGQ7VuJks
 oCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871050; x=1768475850;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NQdKySszMWxZzfLpdSZ/3XPypDh6AjD3noEf0JGmBtA=;
 b=rT1n0/PFtO6pwZYuGTfF+AQawjN3nMfcskdsqN8b4Kl90SzrzKYMAulcOhAGb6arzU
 DjYP/31VD5rKDhd9q/xVU0wOy68AFb7p57d3q6qnoPIlmLV4N/TAQ0mJiXhT8/j+6/0P
 5F+hT/MUhPMlUrVtdbRJkj4axsGVGVFX1BlfMUYt+BM/FipCGOpV+a/VBu4yYOz0/W77
 cmPRZu07xMVRd8tS89tMEu2P9QqNMDBabUOTVaDtGLcfaDXu9qZH/lYT9rQ6Q6+VZLdz
 sM7LbsoJb953LRP0q7dVcL0ItN+lCLu95zwg/jv0k0DY7rkScPSHxBR7bxDOEpNsU5wQ
 WnVg==
X-Gm-Message-State: AOJu0YzFG+huXbetSLzqM7ur5gZbaXCV8ecEoBA+tmWX7pZ3cyUeCQdG
 9rzgfqu5h1mcZbDukAQZITdij18tb+vDzrKncG0MHjrXaFL2d6xf/jttcj3Ii6XgZL8=
X-Gm-Gg: AY/fxX6k4evAf6xOulWpr+oBC3oaLJKiBeI2Qd3ftGncJpNzrsbD3EEX7dDnPpSgMC8
 2EDJyYZysXhmRtzdJbFsrJD2y1Z6Qh9di3ZeDoJn0t7Nol3UVFfDzG+Sw2XQMi27dIz1xDFhV8f
 QASmMJiHAmyx3fT+n1QQq4q7rzP+3bWrtTXtnnpFk2gu3jG04JXq2hlmy5YlSRtKzlY68+zbBGr
 utCa7DlcLISsSVcjryRx75XmN17HzngHYpup/N0qx/pKj3mDtNgI3GHdoH1i3AMjj29wgTLslNe
 DQOTN7iQg59w1h1phqMzq4P/eLvFl4ABCIKwo+OYqHqG747QKpIM275sNXoT9wTgHmPPKI2j0Nz
 +3dG4Q3TlUyQFqud8Nmnc+9Zvw+k2Tr9EQ5REQOVP8rz+YV0AaJuYYOM3odSheZF/HrLnzpd2DF
 PfCK2sELragkeyn+w30pU=
X-Google-Smtp-Source: AGHT+IHbKJDoeXc1kOSTPmaahERhDUq7IZxevxETPdTQ/TyvjM2i348U5k+MuB15Htl+7n+ldK2w3A==
X-Received: by 2002:a05:6402:13cd:b0:64d:1ce9:54b7 with SMTP id
 4fb4d7f45d1cf-65097e4cf0amr4849268a12.18.1767871050139; 
 Thu, 08 Jan 2026 03:17:30 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c4484sm7403339a12.7.2026.01.08.03.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 03:17:29 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 08 Jan 2026 12:16:31 +0100
Subject: [PATCH v2 5/6] usb: musb-new: Relative ctrl_mod address parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-topic-musb-probing-v2026-01-v2-5-2a47c6e0e73a@baylibre.com>
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=msp@baylibre.com;
 h=from:subject:message-id; bh=dDvD/x/4LymVEL1XBsIubCAquDLmvaK7eVpCHnTgwZ8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz4SZbM16tv6joe61SblOufNf8795MTAUVr11uqX66RS
 pl/lqOgo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACay4jHDP73ED3Esnw435AXP
 2Hhl4lqnxwYFrdeWMG3y7On0OnRQ9hwjw/3Fs6wnJfS/X1H1K2j3tQMezWK39jlukjZaYF5/rff
 0BiYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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

