Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94789CEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D2983FD3;
	Tue,  6 Jan 2026 23:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jJg94n7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25BE83935; Tue,  6 Jan 2026 23:05:57 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7340283942
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-457c1148a5bso566903b6e.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 14:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767737154; x=1768341954;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aKXG7lb6fq2pTRif+ai2uI0GCB0wfp1H6TiVf7a1Sa4=;
 b=jJg94n7wRCIwNn/vLO+jMuSq4Hyz3z6EPHypEzzcHOuwZ8+CTu6tuRnWBLYtgYVQDh
 +ZbnftaDp6eUElT24yeTuCQj3UKdbHEEn/hPosXS3zeDYx3ff2Y0iQ8PoMP7kbNrG/HV
 C/9zXFFOjmQH867cS8+sRa6gTPQ9EqhqXW8mL4s8ssU+SCseOvC1KS+mCIFT91dTixqm
 E3rmlKtkEDgHQoDjLhXp95riVqZ7PfUHSQ32SkxhMA23WpyTDlRd52iLy5+FpYx1zyRG
 TfjIi6CxW23BSiCVb9UBLefUPEAwp7OomZQR6dq0FArDptG1iSTFcQrJrXuY+uhdYuZx
 nbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767737154; x=1768341954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aKXG7lb6fq2pTRif+ai2uI0GCB0wfp1H6TiVf7a1Sa4=;
 b=RwbDSF9w0DWBW7IOfRV8t5RbP0IgJwsZqqrOZqZIT4IHkfkakB+kig8zbzmS8CM6Zn
 //KmDTv0ushha9wzrwgGx8iZ/H/U6pjNpGTKoR5CtRYACkdwnla4sZX8MPdQTId1RmYF
 eixquFDxghFnFKS8yQZX3JPHBK1wgBhZPnWIfu9wNufeT6AGpFB3wUYaHCC6qaI0DtMM
 SftvlfSJfZEZu82dwM+K6BceZG8aII2+2q+nixRQ1IhWrtvlMV7yfxWDE3tacILtzQ8l
 4QNCCPe69GXO+bfcuEcCF2wAnkE0ujOnypfgE6OoomwSLOnobYOQ/Wvcf3njgXaaRZfM
 Vi3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGVm7knZ0VfBIbTVQkztv7ppFiKA1fYtVsGGwBL2V8GgpFZdGxWWIcRxNwMiB636g5a+za0eo=@lists.denx.de
X-Gm-Message-State: AOJu0YyUs261OhMnn+3Hcx6H5WDLDYlh0JLZZH1tFEqNiE1b28aQzWwo
 kJ9/19D0R0YXBY5mWhR9xZA+OylL9cXFvjy22tPLV/LynYu9XeAJyzfBnS1LlpEXFMk=
X-Gm-Gg: AY/fxX4fRwyZSx+ebdGTyZRORQ3JTWAJRTwiQORF2AepWVR9Jcy1R2OO6JRSzl8ZiD8
 FmOPTXsdGAdTkzaSLkNehB+4wuzXBjn3Est9Dts5r83lT+ueENtLtQYekrq9z5lrhXH25oKVUp9
 bi3UIYs25EDXUt96lss/TT39cRvEd6qnfiluUliFZc97dVjXtwE25qfvEqqVgfRoSpphn3C7WWM
 Oa9RDlEKbhBsZWSPPyw+XnyxP9PpVGcQAglOemQcb2/tCnZDXnqK1++YXDc28HRCkoKZ6pJtDWN
 wOp2eGea56e8/s4svCETsKnsJtRGluMUCQ72bVwkzKYCE2+Du3hdP1IPC1G6OnyGQpPgh3Rb0b9
 wQmgkBmsrTGkqSgUeG2ZEqObae2ctu5NnDjj2ZmCGzbg0Fz8Alr4OsS+FmjfwFlO+QXqbr/PIcL
 Hdn9e/29GnCJg+4kM=
X-Google-Smtp-Source: AGHT+IEfkpfjBiTCUoaPAyRpln1c5c3wWYJ0b9l3qxEYmbbg+wJCTciHXWz4M9/3r/p2gVBZAceZxA==
X-Received: by 2002:a05:6808:150c:b0:450:8ab2:d86b with SMTP id
 5614622812f47-45a6be3f2c4mr267519b6e.35.1767737154150; 
 Tue, 06 Jan 2026 14:05:54 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f98:2205:4ba4:3e65])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e183916sm1575124b6e.5.2026.01.06.14.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 14:05:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Jan 2026 16:05:19 -0600
Subject: [PATCH 1/3] pinctrl: mediatek: support mediatek,pctl-regmap property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-pinctl-mtk-mt8365-v1-1-0ca3eb382468@baylibre.com>
References: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
In-Reply-To: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ruDZ0bi0W9+sY3YyZVI44XjpSOTrOJcBNm+wwqj79xY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXYctQgrCHvuc4bMy82gNuwt0V5ZRi+P/7VzeE
 g6Y2dOLft+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV2HLRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArcMH/Aq+4KZQslvfYrzwk+v2spH3MGOFP61KldwvoRP
 gYNSTOZZbeKdlwTRobX0Lzc3LY+nofIK3J9vIPWrjKU1OIoaKT9iQkTS55Bpo6q2TYWCgVv1l6N
 vDwyDrO7SfVPsYhRbc7To1zdyJf4Pcvl4CfeYwLgZbXshrFN/ONDAAp8U2PAVRbTOXWEiWOE0Bn
 E1JX0/TvLAWq7Y/PiR6XPGJYjjjLt0mpwn9VKPxXwmFSvmv4ooyQHXetfKjhpZLg7jyAxOpktuS
 wMNT6X9lcaDxhPYi2agEIdDtvXq7E8X36lc5mTLv3RynBWCZk/ho7OsWqHSPxG4ufOmjY0Z/gzk
 JaBk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 06 Jan 2026 23:57:11 +0100
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

Add support for the mediatek,pctl-regmap devicetree property to the
common MediaTek pinctrl driver.

In upstream devicetrees from Linux, the pinctrl nodes may be on the
interrupt controller register address space rather than the pinctrl
register address space. In this case, there is a syscon node linking to
the actual pinctrl registers. This uses a common property name of
mediatek,pctl-regmap for the phandle to the syscon node.

The logic here is that if this property is present, we look up the
syscon node and use it's address as the base address of the pinctrl
registers and ignore the pinctrl node's own reg property. (Support
for interrupts could be added later if needed.)

There is also at least one SoC in Linux that has two syscon phandles
in this property. This implementation support parsing this, but doesn't
do anything with the second syscon yet (the 2nd syscon is for interrupts
which we are saving for later).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 4aecb84504a..0483d532800 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -809,9 +809,47 @@ int mtk_pinctrl_common_probe(struct udevice *dev,
 	fdt_addr_t addr;
 	u32 base_calc = soc->base_calc;
 	u32 nbase_names = soc->nbase_names;
+	int num_regmaps;
 
 	priv->soc = soc;
 
+	/*
+	 * Some controllers have 1 or 2 syscon nodes where the actual pinctl
+	 * registers reside. In this case, dev is an interrupt controller which
+	 * isn't supported at this time. The optional 2nd syscon node is also
+	 * for the interrupt controller, so we only use the 1st one currently.
+	 */
+	num_regmaps = dev_count_phandle_with_args(dev, "mediatek,pctl-regmap", NULL, 0);
+	if (num_regmaps > ARRAY_SIZE(priv->base))
+		return -EINVAL;
+
+	if (num_regmaps > 0) {
+		for (i = 0; i < num_regmaps; i++) {
+			struct ofnode_phandle_args args;
+			struct udevice *syscon_dev;
+			int ret;
+
+			ret = dev_read_phandle_with_args(dev, "mediatek,pctl-regmap",
+							 NULL, 0, i, &args);
+			if (ret)
+				return ret;
+
+			ret = uclass_get_device_by_ofnode(UCLASS_SYSCON,
+							  args.node,
+							  &syscon_dev);
+			if (ret)
+				return ret;
+
+			addr = dev_read_addr_index(syscon_dev, 0);
+			if (addr == FDT_ADDR_T_NONE)
+				return -EINVAL;
+
+			priv->base[i] = (void __iomem *)addr;
+		}
+
+		return 0;
+	}
+
 	if (!base_calc)
 		nbase_names = 1;
 

-- 
2.43.0

