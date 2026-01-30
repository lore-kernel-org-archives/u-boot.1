Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E592E6BF2B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 16:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A493844C7;
	Fri, 30 Jan 2026 17:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MIQ/87Mb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5742E844FF; Fri, 30 Jan 2026 17:28:50 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647A0844DE
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 17:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4359a302794so1617588f8f.1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769790528; x=1770395328;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UmmbsoJdCWTwPU9XlUl3kTqhR1/w7PXjQxQWy3bgNg0=;
 b=MIQ/87MbOrSeN8HtCNbTLbfd344nalGWnBworZnu5Z2zAbx7uGQVCMzIqawQx1xXf9
 OtoSmgshQF0ea1ILlGBct/k1i83WXaeBlCYfGCxsNfwecElk01POuVeIKpb8VBSIjRwn
 /BbL5BDeTSIBMfGOa8OqLuOLVCiAspS6WMn4CEyUko8b+Z9CCNoVZajDiK6jvu0t0Bo4
 Ngld+yjswGR0kCqkAXVq07ajNoT9xeGr3rX/QR0VNxUauAKS9wZ9LGySY6B9FqiViV8R
 vgVoKBZcV++yHjHMTDlA7T5SbQAHDetRZvPnQF4Zb85TXpFPMwhxzxtbsvzrUIArQEFi
 B/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769790528; x=1770395328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UmmbsoJdCWTwPU9XlUl3kTqhR1/w7PXjQxQWy3bgNg0=;
 b=pOnN6qyi+QMOgT8Nr/9CXwi453GEa56kyFwit4S6yL+pJoIv9VVYtDGj0xumUUNMOK
 qZDJxQTX96Au0nQca6SL3fzfHqep3fK+UzcOuoPWCT2k9lyKokfYoAVmpr5XQqBnZgE6
 nrGNrok02SUS6ftTTeu8mz49NjbZ7QhfvS2e+8imJljDPRjFVQyNghQuwM8TC1ONPER8
 HndWtRWSok4WXWncaSRoHS7dXHFrSn4QlqMm3oCzLNLH/rVJ3JkPVXDSeRQ61PmcuLbl
 vogJihMw6TZNmVceWoMUI8quUDjyqBpBL3DgvL1p2oFtAXTiRA1N5wPgv5iClaoDjCNX
 SDBA==
X-Gm-Message-State: AOJu0YxeraGneHd+bi8Ac2paEAZf0QEWUT2391uaQSnGBwc8/cNwzPH+
 F6KZBS1m4ZP6prMQBANrfcGZRDRM/UkjXR0xW4WeEWq9TLgQ62aA6H458XtCXBgaufI=
X-Gm-Gg: AZuq6aLZV0qz4REsfUD5hOS2KBz9ggzyIw32owEkB/gSZD4HBvaKdGxQ1nMcjySa+Tk
 SOACUWOFzIXGOqIUC2xIU07Jn89JI4avf4pD4Qe6R2fk7iC+8qiIl27UbTMjYVvxmp3Op29jLpc
 lIzgG5k00Q/c4HVefblqcbwDsI6oqQ/BIehgk9KFK2X5Lmjt1AAb6C6A8x4uQ2IG/ZMdFI8xx2o
 MX32/dfOIpYeWE6CkIjV3lVddDl5OC7vKI0nrQ2EpcM5DYTrcHaSiYMoVWguKP7+qX36j6LdffD
 EXjdCkM0lxtjkjYA8fCq2jHUPpETbYrZg10WhupIV1pOorT0bR8Jc4UuD4o28CCFYFgA88lJMNB
 bhj+D0gEdSDn0+1WUloSucPgKE+AwxVK+9tkPcA31k3lCbL/F506lxrzgJ+GkO9rW4rdAnX1r4v
 Wzmd/fE9uG
X-Received: by 2002:a05:6000:2507:b0:431:a50:6ead with SMTP id
 ffacd0b85a97d-435f3a8654dmr5550779f8f.20.1769790527730; 
 Fri, 30 Jan 2026 08:28:47 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm23552136f8f.35.2026.01.30.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 08:28:47 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 30 Jan 2026 17:28:26 +0100
Subject: [PATCH v5 1/2] usb: musb-new: Relative ctrl_mod address parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-topic-musb-probing-v2026-01-v5-1-195b23c7948f@baylibre.com>
References: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
In-Reply-To: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=msp@baylibre.com;
 h=from:subject:message-id; bh=LGIqZg8UyaBQhQgrMzroA7ESb3WTXpJDvmyy2TxYZnE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyaO0b5dskLBbJb+c+0WZVs+1Wk2nHuatbh/0xaLwxfe
 W2YuWRGRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkxCuG/xW27ndWN0w5/yOx
 aKLBwYOHX1TLB+yPfWgot+hE6d/4rV2MDN15GR9c9mnPaDeXq7l54AWzCatLp+w5lljuu0Fse2z
 WsgIA
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
 drivers/usb/musb-new/ti-musb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index bcd31adba522fc55190fc43fd2dbd2dec93a2731..75dc2dc18748e33785c7312a24145544b659579d 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -83,17 +83,17 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 	struct ti_musb_plat *plat = dev_get_plat(dev);
 	const void *fdt = gd->fdt_blob;
 	int node = dev_of_offset(dev);
-	int phys;
-	int ctrl_mod;
+	ofnode phys_node;
+	ofnode ctrl_mod_node;
 	int usb_index;
 	int ret;
 	struct musb_hdrc_config *musb_config;
 
 	plat->base = devfdt_get_addr_index_ptr(dev, 1);
 
-	phys = fdtdec_lookup_phandle(fdt, node, "phys");
-	ctrl_mod = fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
-	plat->ctrl_mod_base = (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
+	phys_node = ofnode_get_by_phandle(dev_read_u32_default(dev, "phys", 0));
+	ctrl_mod_node = ofnode_get_by_phandle(ofnode_read_u32_default(phys_node, "ti,ctrl_mod", 0));
+	plat->ctrl_mod_base = (void *)ofnode_get_addr(ctrl_mod_node);
 	usb_index = ti_musb_get_usb_index(node);
 	switch (usb_index) {
 	case 1:

-- 
2.51.0

