Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC523F46C78
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A46184144;
	Mon,  6 Apr 2026 22:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ByXLDTfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E1E83FA3; Mon,  6 Apr 2026 22:14:45 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0AC483C2B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4645dde00a7so3759137b6e.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506477; x=1776111277;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ov1k7UleLYHPsqnarXmyon1CVt+YbMs1CUITccQjHM4=;
 b=ByXLDTfA9CNh2Fkz/guAjB60Y9p2xbVY3v1K5RoFvOD74bGIrbhDtrgQpxpQafIzfQ
 6Jn1zdkpa/r5WesiBqSH43NZkxmF5fBrhJHi0vOfYZQT8cNlE2hrW1BDaX7GGTiDRzbq
 V9oJJaBKs5VNmppYMvpljEURblmJiSjW+Jh3Amk8/jtP5oAqci+xt+mU8W8KgLzWiTe4
 S9bwTQQ8U5ANDzQaXg+ZTEy5ftC+Yqsb804DEAySfUKLmVVtoLF4YsTonJqTngCj6YdE
 Bv9/JgWCbblAcfNRDBI3aiYbzN4Yx14OlrUaCuYmLAZiCtESXpkj3foN1qQsR+ipqwSg
 LbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506477; x=1776111277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ov1k7UleLYHPsqnarXmyon1CVt+YbMs1CUITccQjHM4=;
 b=MeoC2T6AOSGJ98gPPrgj1WkiiGha0OmCSeaML7jT1GEozLOKzrJqDeFEUT27tALPTI
 NTz3FRhSbWLtpWql/8Xu/HUeWrD3s63kcymNND8l1VUUtpzRjCiBVsuYtni58OK32FgI
 cxaH3dJkwcdwX7aQePGFbwCivrfRspIVuh0ieKTbrwb2vQZEwEUEChqV9YyqHT+8+k+u
 RneU8iIzhT/W5wGzmIUl84zPVQvJchSF3GMGrdCfMbTaZrdF07mydyGVhagGtCym4rru
 XUOhfmuzbj8zNoPdp71Vd5bQiTDZP0kXPAQe/PcdGR6LXj/uA7mues150/ER2ECvuChQ
 QXcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj1gU0wSefqBy7DalxRbWLPLrxSZ8QDO4aJ24Q/Nj4+kyeZgTsAZZDXrvHGU5JLbF/C3yrbp8=@lists.denx.de
X-Gm-Message-State: AOJu0YxQ/7DXvctrBqJ/1wTZNRVZRMAZST3tNo4egn8L8Sw99i+tcu1q
 tTKcVRD1dpqOLvV9SWQ8jh259RWjzKIguy40yF6lFuvLMBCOLGFvfAabkNoDlAOJRw83+MBxgJp
 RO9Gx
X-Gm-Gg: AeBDietp/MMx+XXphlluCjLTn56nlFV0/depSPjzj/yp3lKwb8j1xZLtZyqSdCq7lOY
 jGnebhPwU2oiusJ/VGM2kQFw9sHzSI7kWWo4N6mxHNHbE0yE2VfeJ5fsCIAUAD26EENmNvooXOO
 3C4xyUxVO6UAjBlieNWbrSkcHJtyp9RsErBXHJJngwcbE6oePdQtL2bRZqikGZq+Vi4kLrp8BnX
 gEk5l0vaKnSdvSr8IWHcdYX4pPKOWFuM2vazDGvXrqO6eJGcIgeNS9swbFhbOjSZHQNNX4JAbFQ
 aNLgsPrGa1ojNCCAx92K6u/gKHLJd5duPL0CThc8h5ms2kpzL2J5DTz0ckVS7nqgiPX4iJqx1oM
 YZlcZpfB9IMDosB1S5pV5ppVMyZrS46ifZhUv8twqTGeLy7gHO8/CQD7JG23A81g9XuYsEdUCFc
 sroSKI1NrLqVOPRipIwW2RYLqFbPU=
X-Received: by 2002:a05:6820:1a07:b0:67c:28d6:430e with SMTP id
 006d021491bc7-68220c420bcmr6876492eaf.28.1775506477339; 
 Mon, 06 Apr 2026 13:14:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:13:32 -0500
Subject: [PATCH 6/8] spi: mtk_snor: support newer SOCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-spi-nor-improvements-v1-6-66f675cbbd3e@baylibre.com>
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, "Noah.Shen" <noah.shen@mediatek.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Uatn2Ihu8+Rogw43lASyi1h7dj4jj3pC7De8ieQvKF8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BQTNvbEc/5VGAqCclVMBjdaHJxZxzxWfBjOV
 xX+nbQr8UKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQUExYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABBsH/2a7qtUK35rLdFSu2g/hI/AXs+EC33xm5HzosyY
 cffP+Z3XEo4GL3hnDhuNY2wfMdtNWDFF7dhX/FUsvaJvm9eK5pQgEbJkMGt+xAaDMNMD/vgYhfM
 nPP+F/sR0QQl/kJ1Lrpe2rDbJba38zXOIGxxcCXpw4Hr6zExI5YXZdUF3wN1y3++sYiG4EJzZSB
 IoPVb4/kIdhswLMdWQfd5eEm3MoODCpT+flQsM+kmSvP+o0iaZFIti5u3ASJz4moY26uyBW3sz7
 a0XMMfaXYtghnTLhlDTdWXGS32Y+fz1nWriFZb6VgPtvac5hTaMyuPgVK4iB7f+ZJbgVP/UrwEz
 k+cE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: "Noah.Shen" <noah.shen@mediatek.com>

Add support for some newer SOCs. New compatible strings are added to the
lookup table. Some SOCs also need a extra bit clocked out as a hardware
quirk, so a new capability structure and code is added to support that.

Signed-off-by: Noah.Shen <noah.shen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 77f94827568..649bca5716c 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -104,9 +104,19 @@
 
 #define MTK_NOR_UNLOCK_ALL 0x0
 
+struct mtk_snor_caps {
+	/*
+	 * Some new SoCs modify the timing of fetching registers' values and IDs
+	 * of NOR flash, they need a extra_bit which can add more clock cycles
+	 * for fetching data.
+	 */
+	u8 extra_bit;
+};
+
 struct mtk_snor_priv {
 	struct device *dev;
 	void __iomem *base;
+	const struct mtk_snor_caps *caps;
 	u8 *buffer;
 	struct clk spi_clk;
 	struct clk ctlr_clk;
@@ -448,7 +458,11 @@ static int mtk_snor_cmd_program(struct mtk_snor_priv *priv,
 	}
 
 	/* trigger op */
-	writel(prg_len * BITS_PER_BYTE, priv->base + MTK_NOR_REG_PRG_CNT);
+	if (rx_len)
+		writel(prg_len * BITS_PER_BYTE + priv->caps->extra_bit,
+		       priv->base + MTK_NOR_REG_PRG_CNT);
+	else
+		writel(prg_len * BITS_PER_BYTE, priv->base + MTK_NOR_REG_PRG_CNT);
 
 	ret = mtk_snor_cmd_exec(priv, MTK_NOR_CMD_PROGRAM, prg_len * BITS_PER_BYTE);
 	if (ret)
@@ -508,6 +522,8 @@ static int mtk_snor_probe(struct udevice *bus)
 	if (!priv->base)
 		return -EINVAL;
 
+	priv->caps = (const void *)dev_get_driver_data(bus);
+
 	ret = clk_get_by_name(bus, "spi", &priv->spi_clk);
 	if (ret < 0)
 		return ret;
@@ -584,8 +600,19 @@ static const struct dm_spi_ops mtk_snor_ops = {
 	.set_mode = mtk_snor_set_mode,
 };
 
+static const struct mtk_snor_caps mtk_snor_caps_default = {
+	.extra_bit = 0,
+};
+
+static const struct mtk_snor_caps mtk_snor_caps_extra_bit = {
+	.extra_bit = 1,
+};
+
 static const struct udevice_id mtk_snor_ids[] = {
-	{ .compatible = "mediatek,mtk-snor" },
+	{ .compatible = "mediatek,mtk-snor", .data = (ulong)&mtk_snor_caps_default },
+	{ .compatible = "mediatek,mt8188-nor", .data = (ulong)&mtk_snor_caps_extra_bit },
+	{ .compatible = "mediatek,mt8189-nor", .data = (ulong)&mtk_snor_caps_extra_bit },
+	{ .compatible = "mediatek,mt8195-nor", .data = (ulong)&mtk_snor_caps_default },
 	{}
 };
 

-- 
2.43.0

