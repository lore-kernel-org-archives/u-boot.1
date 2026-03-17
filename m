Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98059FD8763
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00EC5842FD;
	Tue, 17 Mar 2026 14:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nsk/avnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F0D84301; Tue, 17 Mar 2026 14:31:57 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3368842FC
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43b40003d13so1985815f8f.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773754314; x=1774359114;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G+kia9eu/hhfKhlDdqjFr1Kk5HzLM/u7sBf/Qy0VYm0=;
 b=nsk/avnVRI7QkHr15i+J8cPUWQcpzd6GIGxatNuzf3pFiyHYp67uOgOEXrxrmiwqWV
 C5p+b5elaS/iGp1CX+j1KJTM3C1ejFl/HOpRtGSc9h/Lsa1ZVsRBpbaQ0iiLS6mxgIgY
 GCzVMEiRZ7nBSnILeb+HCtRMlRj2yegvldkdxfN24yrP9OkvAirR6OntrQn7pXU/X/NL
 MrQYet39eIr7srX+v4+Sl1tpcD6UEnr0rRJMLiUsX82VZraAMinltti3TBSVlOsk58/R
 N1qOmeQBZG+w7o2FEADPpkpkJM5XNb4ynkGMoMWrsdkRpB+FbxvwFADWrPgZhh5kBIjk
 F5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773754314; x=1774359114;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+kia9eu/hhfKhlDdqjFr1Kk5HzLM/u7sBf/Qy0VYm0=;
 b=CGiwxj/fAvgL031J6Fnts2+7V5c+W9riHftTfCUCC7Yggnajo+zC5fQJQq8poVb5pd
 3WNbPGr8u/9gq63EpPvlKnWODfi8w2BkDiNV7XjKm+8AcgYTSlrXofaZ0W53JiTkQ9JE
 9ToXh5QUX1/JnOSWLVvALj6OJpT0jvCwFbuETLYV+Gq1JPbe/8gAzn9GHMXLa0Kpr9Vq
 ZL/crnFh6uCEVGfLh5uuFHox48wr6bR7Joz1JovTubjeY6m68/r4E1uwti90ATURfJ1M
 kwmSvgMNhm52dxIiZS9g25Qd27e/uFcrpZsNE6Rgn37syqPLVMhXzyYAuUvDOFVdKvg9
 XuIg==
X-Gm-Message-State: AOJu0Yy9NgcQ0fNXR5tXFTYpk30dlMdVTA96fKseUZw6JzkcOQrMQPpy
 JIccIxeRqRuZzWalJuIfNW+JwchDpR1wzP2zfn/jr9Y5PGzt212lXuHBmrB6rxlCoSqvWL01HHP
 zccFq4vU=
X-Gm-Gg: ATEYQzyt6zDE7I9UlBwMnwUe8rzL5OJt+v+lIKLQNBf20loOG7ueo3urNuwA4r3dqNr
 WbiHwC2nCQI+cCUm63bxcF5oPPFoeJ8pjZdedhCPOJl0EVbKQGvIlI+4sZutekMtpITGy5jCrjE
 +7PgDvpmjGFHY1hH81AfzraIu61Zg82lGdm0cj9Ve83BT1ElsuNKJ4wJk/JHP1dPIi70lk+NmHz
 lSaegvDT1+IrfI+23ZNsWdZVMSrFGyGr4X/xwVElHEDZT93tsPYW02eGfNdB9dIMjayUVDxdhHK
 gd2IKXJLB6hHKOnERuGQuy2hDu/4hXSuK5kKFPdrt0iYH8KPWyLxRgcC8CiUBTEOEca7p3yBfpE
 Rz6V12A0cT2PQpNaHTdNxzxJfPgIzIALm1vWREhYhpWzGuvfByjGWaIE9y6PQXb1A4Ka0hXk3EA
 Z4GodBh4HLWXiee/nTZ1ed6qKw48XQkJJWX1RF93iUl91UZ/yme1I8SQWV6bBmu1LPR9cGIFt0o
 hVw2BdW1WhV+p3gM1dhckkD82sENwhl4bEYv7musPKTu2WmkSYMzxAKlwI4acxv1rK6cX7H4wy4
 p/KGpyQ=
X-Received: by 2002:a05:600c:1d0f:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-485566ca95cmr276963505e9.5.1773754313959; 
 Tue, 17 Mar 2026 06:31:53 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f3b04165sm4608895e9.7.2026.03.17.06.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:31:53 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 14:31:58 +0100
Subject: [PATCH] drivers: mmc: mtk-sd: disable dma for MT8188 and MT8195
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8188-mt8195-disable-mmc-disable-dma-v1-1-220da4144920@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nz3dwSC0MLCzBlaaqbklmcmJSTqpubmwxnp+Qm6iaZmZhYWiaaJZq
 YJyoBzSooSk3LrADbEx1bWwsAJ13ctXcAAAA=
X-Change-ID: 20260317-mt8188-mt8195-disable-mmc-disable-dma-b64499a6a47a
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, "ht.lin" <ht.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

MT8188 and MT8195 SoC should be fully compatible with MT8183, but
currently dma is not working on these SoC. For now, disable dma.
Investigation needed.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/mmc/mtk-sd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 7a4bdee7496..8f93e51599f 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -1989,6 +1989,30 @@ static const struct msdc_compatible mt8189_compat = {
 	.enhance_rx = true,
 };
 
+/* MT8188 and MT8195 should be fully compatible with MT8183
+ * but currently dma is not working on these SoC.
+ * For now, disable dma. Investigation needed.
+ */
+static const struct msdc_compatible mt8188_compat = {
+	.clk_div_bits = 12,
+	.pad_tune0 = true,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.enhance_rx = true,
+};
+
+static const struct msdc_compatible mt8195_compat = {
+	.clk_div_bits = 12,
+	.pad_tune0 = true,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.enhance_rx = true,
+};
+
 static const struct udevice_id msdc_ids[] = {
 	{ .compatible = "mediatek,mt7620-mmc", .data = (ulong)&mt7620_compat },
 	{ .compatible = "mediatek,mt7621-mmc", .data = (ulong)&mt7621_compat },
@@ -2001,6 +2025,8 @@ static const struct udevice_id msdc_ids[] = {
 	{ .compatible = "mediatek,mt8516-mmc", .data = (ulong)&mt8516_compat },
 	{ .compatible = "mediatek,mt8183-mmc", .data = (ulong)&mt8183_compat },
 	{ .compatible = "mediatek,mt8189-mmc", .data = (ulong)&mt8189_compat },
+	{ .compatible = "mediatek,mt8188-mmc", .data = (ulong)&mt8188_compat },
+	{ .compatible = "mediatek,mt8195-mmc", .data = (ulong)&mt8195_compat },
 	{}
 };
 

---
base-commit: d31f96cac1e25153779c44f1fe014978f9b06032
change-id: 20260317-mt8188-mt8195-disable-mmc-disable-dma-b64499a6a47a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

