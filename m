Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373C7CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 08:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBAB140611;
	Tue, 29 Sep 2026 08:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vMo9PXhRrlf; Tue, 29 Sep 2026 08:50:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C28E0405A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790671840;
	b=Iw3J1kGvUufkq5IxCsaypqeZlulz+YNT5DQUvMONVPwk421YdML2GWGJTkwTQe6LGFbM
	 pazkUcNrY1SfnZcWiMOvwYG4IuHWve4ljKJtL+KhXJyNfwBkRmAEVjkgV+PkpSBwTbaSF
	 Jv4+xGR45LTOgPVqheRGHqfIYiULq7I1FbXtGzfM0+B9yAUa2PvpPIF4k8fVXn6dZW/Ce
	 bcj5aVmf/+HTe2G6ZdrSYtMRbP6xhlcpZ5OMhVz2KDzj5ksnEI98EInwuKf3GuLb8xgHM
	 QkIarWL5KD3MdsWyviUyBAaYjSyalTJsZStJ/gp8o/YiSaDd+2dvzMbc0gBSKWDlYbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790671840;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VL/rGMZsMH05NJ+yO6JrCaX2PaiWZAaJCM2K4dmdnlA=;
	b=Q0A7jLML3MkzqnVt5zK3K4lI9oBIFMOtBKzg8YD+VxnyfI7KELjVdFxDPztxPmkQSVUG
	 wpSRsixzGZdhmrz1HYZ4QaXBHIsrH4U5NOOitN3+TVCybIb3mkB+27LtdT3vDi8d+cu4j
	 jnVM3RihuGN1aUx8gLWoySte6Y7YX2Xj++JaukgXNa4Oo9DMvwsjT4eIAAxVM0dZOHjOl
	 zMCjZAe9pudVXrfh+s+KJeZQK/6oqkQKKVc7UOXeFOxkfiPBjsvoUAIWF4HO6IIEBT4Kr
	 zE4KvwqB0gv3rX3wuu1Z4+uNjNNy540oRc5wwY8Z3wYj7uvF4DpYwfQCuykZ4swyRJQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=I5IG9KXP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790671840;
	bh=VL/rGMZsMH05NJ+yO6JrCaX2PaiWZAaJCM2K4dmdnlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K78l5vC0J7zuK+UfJ8s1KMZrkbpeLfvIe5A579qp5cvpEKXmt8h5FRzz69l36+gX/
	 7USZC/sjTshJvU2vBNJr+jYD3RINJfWhqTsfvlnLDdkTcVj7ONCXBTCfHlE6aRIJGp
	 BfqhT37HAtH9FzFj+gzRZAxtjQncqTctGzfChvq7I0ft/E0LyMO4t2EY/Z3nbxXpIw
	 BqvkvupJQW+qUo4YacBrjH9pffRocuVV8Beapja7E8D4wnaPLxTn0HIGsB3sxB02ff
	 JzuT32m57gDwQtnPz9FCfJYkPuUym7747pS7rFVGg/eVBEhU06mZjdUDnBT3ju1Q05
	 v0hterg+KfUdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C28E0405A1;
	Tue, 29 Sep 2026 08:50:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6532F3D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62C9E40602
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ywdw-K5gpRxP for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 08:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0049E404E9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790671836;
 b=d0V5wYHOb7r/7MGD3qoO24k/axqdRDWCavXOEUKN5IUr85gubENWv+IACLMMwRG+BZ9u
 m/5Sfvh4/8VAWxtDAYGKwrrwvsgwHagdfMSZXpXTMzhhjyQz10U8XyMM8VvYg6MF7r1cJ
 8D41VOgYplwwRI6Wucaz9FE3PnHXGru1GOwWxxTKC57utQndUEpJ7c4M6+gPfQRTPTiZG
 PjCmuTPp2ZA+XJUQqDt+ZBYsfZv4gSB/g8rXrWbdd0hytjut6stFFVM3OTCAlduUSHToQ
 R97Eeqw+e5R4ItW8U4EWMCuenuuX21+JU8/UrZIZVznoKCLMcjgc5ii/lwI2faO+uXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790671836;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=VL/rGMZsMH05NJ+yO6JrCaX2PaiWZAaJCM2K4dmdnlA=;
 b=YAxmj8D2sgmAbrfshaZZV+9n44o9si95A/AF6hI2br6S98sIiKLmyKJtTaveXVr8I2gu
 mlbsdGqY6EbNExw0fZqN+WhYy3GZjp8rn2tUpCIteaVdgqNuQQgOLC5U/dNPqauBbelUc
 MkmIuyx0qQo9EM/6Eu/kuSYC+Tg0BK10CRGg6258970tKB+Rku19GFMYc59XJl9cQNvNv
 LQxzekJC8wH6vHYG3nNOC5xXjw9FbR/n6neKXHEmY3QhaHb4bbkPgSw+nNU0HIahPcGTB
 Ovyyd4gfXREKxLP1k9XXA85TVYm0dgrUIVCMV7Te2wdgX54KIJLbZMDwvXmksZw2yZw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=I5IG9KXP; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=I5IG9KXP
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0049E404E9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:50:35 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso28847965e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790671833; x=1791276633;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VL/rGMZsMH05NJ+yO6JrCaX2PaiWZAaJCM2K4dmdnlA=;
 b=I5IG9KXPUm1RjGQ0VrdItt7B0D+tRny3oDZQUg4OKNDrVYDgP1zDo1WI7xlhmGd9F0
 ThkDPUc8C7/ptopZUu+yp12yxuQPFLlIk5pd+NEDiRIhW6NV5cwxIgK85VAlY1UOa6Wf
 At54Xxl6F9JSnNYzUq/8Bol5wPwynk5+V5PXJvg82nyBjE2JTWeyqAchhw+ztgpSleAg
 BSWKLMhZ8gl9K24zvT2dB0D/BLaTLmtsP4IBdrC/vlRg4XCdIDbWnBh8jTzCXUo6gOy4
 IxI6FHzwh9yvBd7DJv2pCM9XvjTLidczA4ga8GTnu7KoibtcLVIl9mzPWpEV2RASd3Gd
 09lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671833; x=1791276633;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VL/rGMZsMH05NJ+yO6JrCaX2PaiWZAaJCM2K4dmdnlA=;
 b=c8xn01zVaKM/HrdBGQXvfVkpUetIGzLq1JV6Ibv+2chhuiXqHcu9UOiqrdeGx75tEI
 JptrIWennYy1xvbGoAGbz+jW8+ucscNwriJStNCg0hCTkgRgC8kPZ8T9baUue1UgJnmA
 DzmKnQ52igtlQLtvPTtfCt3Tyya3vm6p2UNDCMm7XNCT/emxIGPRUicUyDNdFZwBLDS/
 RzJoWIim4MMctHdJOPJMaxVxvqXVFSMrWw4OGQSl6M2ofQwRawIgWNeQU3e+SHJkYDAh
 BPbECIhemlD869Ly1SNn6zsHh+XN6W64p9Pep+pdOuz+ijnrKXBqTquyCFXTUxuXbtmA
 5vZA==
X-Gm-Message-State: AFuF++nFF8RJ/ySCfX2BEAoZd+85XepQvc7wJtaTlmr+Nkaw+g8BBWVD
 f5PXknJGgnW1AgLc+6dWcNQQlenAO7Bj06llinXGadULHLiiLWahO/+RirKLOJWH5kg=
X-Gm-Gg: AYBFou3xyfbB7hqvXnKof+Y6PTZzEmLZVNVjZoetIQzqd6Rq0zI0XuNuM/wIjYYd2uR
 iLYSljvXiJhNdPkNWY0XRWwrBIocIpmEUPsgdYJG+n9UQK2OfgRqYLdayBCXbLFesE3+PNxGzGS
 /v3jAbyxKrDtHkjrFzBbQOQCDR3mflRTo8l7J9e7YTN9OHHNVyMxaiAHb8suY+xVViKljMH1ecF
 iptnhv2tmF1nNX/FnM6sth52Uot07NQFZT+W82M7QW2DD16MGq69pls2JXqGW+T71x6/cKzOC3n
 t9NeNwRU4iDh2XhPvsZeS0KVclYdc1LNLNx83BoaPt1zhXfcBDzehsQh6KCTFSlO2ZxAJECvk4c
 fe1clAVP4aYVRccaE6avgjiyS9dnj2pKLiyU9s5WhlZ+06X04S+RVwKxGnmoeSk4dr19yBLDr1q
 RkQcB1Jl7I5cPHA6uVbSO3QaYQyjJn6bT+LZRTEmuyG0Ght3P+yWITQpgdyQUvYNRfVAlYg5C01
 /VY7qX5AHbtQlHYfceKqEf/jvrBK1CnjYyhjZclu4H+gL2XInAHoZllKPeX23Q6nVTq9dJEP89y
 O1D5ery6rLDt71nnTZerg0PfeNoplSrJA3K5lWosSjt7nFOqcT5+zds=
X-Received: by 2002:a05:600c:4504:b0:49f:ff09:3b57 with SMTP id
 5b1f17b1804b1-49fff251664mr123728755e9.10.1790671833329; 
 Tue, 29 Sep 2026 01:50:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe16a2sm60967475e9.4.2026.09.29.01.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:50:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 10:52:42 +0200
Subject: [PATCH v2 2/3] phy: mediatek: move MediaTek PHY drivers to their
 own subdirectory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-2-7a1bd29d0e6d@baylibre.com>
References: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
In-Reply-To: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Stephan <jstephan@baylibre.com>, Siu Ming Tong <smtong@axiado.com>
X-Mailer: b4 0.15.2
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

drivers/phy/ hosts a growing number of MediaTek PHY drivers (T-PHY,
XS-PHY, UFS, HDMI). Other vendors already keep their PHY drivers in a
per-vendor subdirectory, so follow the same layout and move the MediaTek
ARM SoC drivers to drivers/phy/mediatek/, together with their Kconfig
symbols and Makefile rules.

The MIPS SoC drivers, mt7620-usb-phy.c and mt76x8-usb-phy.c, are left
where they are: MIPS MediaTek support is kept separate from the ARM one
elsewhere in the tree (drivers/clk/mtmips/, drivers/pinctrl/mtmips/),
and Linux does the same, keeping its drivers/phy/mediatek/ for the ARM
SoCs only.

No functional change: the files are moved verbatim and the Kconfig
symbols keep their names (only a typo fix in config PHY_MTK_TPHY
s/veriosn/version/), so existing defconfigs are unaffected.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/Kconfig                              | 46 +-----------------------
 drivers/phy/Makefile                             |  5 +--
 drivers/phy/mediatek/Kconfig                     | 46 ++++++++++++++++++++++++
 drivers/phy/mediatek/Makefile                    |  6 ++++
 drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.c |  0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.h |  0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi.c        |  0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi.h        |  0
 drivers/phy/{ => mediatek}/phy-mtk-io.h          |  0
 drivers/phy/{ => mediatek}/phy-mtk-tphy.c        |  0
 drivers/phy/{ => mediatek}/phy-mtk-ufs.c         |  0
 drivers/phy/{ => mediatek}/phy-mtk-xsphy.c       |  0
 12 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 97133304cb6..112c5aee786 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -278,51 +278,6 @@ config PHY_EXYNOS_USBDRD
 	help
 	  Enable USB DRD PHY support for Exynos SoC series.
 
-config PHY_MTK_HDMI
-	bool "MediaTek HDMI-PHY Driver"
-	depends on PHY
-	depends on ARCH_MEDIATEK
-	depends on ARM64
-	depends on CLK
-	help
-	  Support for the HDMI TX PHY found on MediaTek SoCs such as the
-	  MT8188 and MT8195. The PHY provides the TMDS links and the pixel
-	  clock PLL to the HDMI TX controller.
-
-config PHY_MTK_TPHY
-	bool "MediaTek T-PHY Driver"
-	depends on PHY
-	depends on ARCH_MEDIATEK || SOC_MT7621
-	select REGMAP
-	select SYSCON
-	help
-	  MediaTek T-PHY driver supports usb2.0, usb3.0 ports, PCIe and
-	  SATA, and meanwhile supports two version T-PHY which have
-	  different banks layout, the T-PHY with shared banks between
-	  multi-ports is first version, otherwise is second veriosn,
-	  so you can easily distinguish them by banks layout.
-
-config PHY_MTK_UFS
-	bool "MediaTek UFS M-PHY driver"
-	depends on ARCH_MEDIATEK
-	depends on PHY
-	help
-	  Support for UFS M-PHY on MediaTek chipsets.
-	  Enable this to provide vendor-specific probing,
-	  initialization, power on and power off flow of
-	  specified M-PHYs.
-
-config PHY_MTK_XSPHY
-	bool "MediaTek XS-PHY Driver"
-	depends on PHY
-	depends on ARCH_MEDIATEK
-	select REGMAP
-	select SYSCON
-	help
-	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
-	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
-	  multiple USB2.0, USB3.1 GEN2 ports.
-
 config PHY_NPCM_USB
 	bool "Nuvoton NPCM USB PHY support"
 	depends on PHY
@@ -364,6 +319,7 @@ config PHY_XILINX_ZYNQMP
 	  that is part of ZynqMP SoC.
 
 source "drivers/phy/cadence/Kconfig"
+source "drivers/phy/mediatek/Kconfig"
 source "drivers/phy/qcom/Kconfig"
 source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 02f8b495ea0..ed0279e47f2 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -6,6 +6,7 @@
 obj-y += allwinner/
 obj-y += cadence/
 obj-y += marvell/
+obj-y += mediatek/
 obj-y += qcom/
 obj-y += renesas/
 obj-y += rockchip/
@@ -42,10 +43,6 @@ obj-$(CONFIG_MT76X8_USB_PHY) += mt76x8-usb-phy.o
 obj-$(CONFIG_PHY_AXIADO_EMMC) += phy-axiado-emmc.o
 obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
-obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi.o phy-mtk-hdmi-mt8195.o
-obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
-obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
-obj-$(CONFIG_PHY_MTK_XSPHY) += phy-mtk-xsphy.o
 obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
 obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
new file mode 100644
index 00000000000..ce7279daa75
--- /dev/null
+++ b/drivers/phy/mediatek/Kconfig
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config PHY_MTK_HDMI
+	bool "MediaTek HDMI-PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK
+	depends on ARM64
+	depends on CLK
+	help
+	  Support for the HDMI TX PHY found on MediaTek SoCs such as the
+	  MT8188 and MT8195. The PHY provides the TMDS links and the pixel
+	  clock PLL to the HDMI TX controller.
+
+config PHY_MTK_TPHY
+	bool "MediaTek T-PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK || SOC_MT7621
+	select REGMAP
+	select SYSCON
+	help
+	  MediaTek T-PHY driver supports usb2.0, usb3.0 ports, PCIe and
+	  SATA, and meanwhile supports two version T-PHY which have
+	  different banks layout, the T-PHY with shared banks between
+	  multi-ports is first version, otherwise is second version,
+	  so you can easily distinguish them by banks layout.
+
+config PHY_MTK_UFS
+	bool "MediaTek UFS M-PHY driver"
+	depends on ARCH_MEDIATEK
+	depends on PHY
+	help
+	  Support for UFS M-PHY on MediaTek chipsets.
+	  Enable this to provide vendor-specific probing,
+	  initialization, power on and power off flow of
+	  specified M-PHYs.
+
+config PHY_MTK_XSPHY
+	bool "MediaTek XS-PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK
+	select REGMAP
+	select SYSCON
+	help
+	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
+	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
+	  multiple USB2.0, USB3.1 GEN2 ports.
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
new file mode 100644
index 00000000000..00ab10a238e
--- /dev/null
+++ b/drivers/phy/mediatek/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi.o phy-mtk-hdmi-mt8195.o
+obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
+obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
+obj-$(CONFIG_PHY_MTK_XSPHY) += phy-mtk-xsphy.o
diff --git a/drivers/phy/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
similarity index 100%
rename from drivers/phy/phy-mtk-hdmi-mt8195.c
rename to drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
diff --git a/drivers/phy/phy-mtk-hdmi-mt8195.h b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
similarity index 100%
rename from drivers/phy/phy-mtk-hdmi-mt8195.h
rename to drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
diff --git a/drivers/phy/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
similarity index 100%
rename from drivers/phy/phy-mtk-hdmi.c
rename to drivers/phy/mediatek/phy-mtk-hdmi.c
diff --git a/drivers/phy/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
similarity index 100%
rename from drivers/phy/phy-mtk-hdmi.h
rename to drivers/phy/mediatek/phy-mtk-hdmi.h
diff --git a/drivers/phy/phy-mtk-io.h b/drivers/phy/mediatek/phy-mtk-io.h
similarity index 100%
rename from drivers/phy/phy-mtk-io.h
rename to drivers/phy/mediatek/phy-mtk-io.h
diff --git a/drivers/phy/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
similarity index 100%
rename from drivers/phy/phy-mtk-tphy.c
rename to drivers/phy/mediatek/phy-mtk-tphy.c
diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/mediatek/phy-mtk-ufs.c
similarity index 100%
rename from drivers/phy/phy-mtk-ufs.c
rename to drivers/phy/mediatek/phy-mtk-ufs.c
diff --git a/drivers/phy/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
similarity index 100%
rename from drivers/phy/phy-mtk-xsphy.c
rename to drivers/phy/mediatek/phy-mtk-xsphy.c

-- 
2.55.0

