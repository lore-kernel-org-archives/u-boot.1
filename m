Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901DAF51416
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C32D83FDB;
	Fri,  6 Mar 2026 23:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oJ7/C5sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3CB783FC8; Fri,  6 Mar 2026 23:07:10 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B576883F98
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4c9537f90so6666228a34.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772834826; x=1773439626;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ucK9JPJzmVxnv515sigDMhOqgChzRNMdbcoDD/492OE=;
 b=oJ7/C5sxMcvfnv8WH5+UewnZywk7T+JFf/jppJ8kB2GCdPl2NQiLYTzpGiDJXTy0j/
 JLC3ZUGaYaLYrIdyteFrgMd8fmEVq3CYUWpRujYd8D0rFCB3JYk3IahLAAP/1R3gPYZN
 F8B4epvnuKMloyJjAyz+gU8cvGdnUfaME0Cm0K+5vTtFEva04jTtob33tyHGStOb9+xR
 Hk/w5niWK6rQFuKOMXMnifUgxOTy9kzzK9aRByYJN/VdxcaAl17dl/bi8qQMJXptMFB/
 2IKuwxK/p7V2EnAinQ0lMLikt0Nv/KLaw3rpEkYSdRjRvC7C9gktqojMr8JDP3YLViwu
 6rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772834826; x=1773439626;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ucK9JPJzmVxnv515sigDMhOqgChzRNMdbcoDD/492OE=;
 b=O5VP5xZUIvEgClTOSYb6kgbusT3mnhRu+0IUJMA2iCe96diAHbN8bvp6bOzagOFB3r
 PfOg7P5RvPu8flClO59W84CR/m3BibCAsO2lQEyr/TG+8b/ciN5cDH6OtIDiGK7FbuwI
 a+Z84gDjPQGc/sT7hING3jJoEMdwVR3phPCzeABi/8JSQMkReDqJB2mdzJq314iCusCW
 Xf3UMCghsJxdzZhTGMAOCKCn9RGrvL1VRzNIFp4ofBFGwWHgUgrJFUM/IOFjO4OGC7va
 UJ0tgknWVaH/tz3uSIY2dYAdBuBTeOX+1BIl45wbLEPYCYJMDroKSTS+aK8lTagcblEe
 NPGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUnZqWqj7Gaf8MymIYvJAQGmLkO76ypqBb0qD6ZjvLrGiYWIstKptoDjxJvkxxVs0RBlqi+Jo=@lists.denx.de
X-Gm-Message-State: AOJu0YzRM7pEWgi9438iiYUf6BujPbtV6B9U5WDKA5usQU1d4bB8H2EW
 miA3GLO7gvmfgOO+34YWKeXYzanctXSjT1YwAmO7DbNyZAJo+OCpQ8plzxxG5TMH0JY=
X-Gm-Gg: ATEYQzywi9/MoTrFBg+amAqx426YEnaxUbEfWqhTH2jvFbFqqSN2C4icrLmCy75pN1S
 gOA5u2Rxc3cvSFo8glcIVftGov2xn0GMAiOtbAs/etwK+PoRBVqICrpYcjEJnjSNbt6j9JKCHBb
 tC5xVxT2B3lPBjtJgvGXZGXZy4KgaeLyqY2xSPjmNwjO+V7flop5+XKBz5a0dKNv1FfQ5pMbAb7
 FyNQ7FwTX+Frol8b1uLxVJBTsDgfuEsO/lovIaoLInGfkTH5GzytNS0+3h4CP4wCZZX85pi8p8d
 08CIyDbb2z1M0kq36zCTYzWNG/IUH3yCw/qTRegOHJmVl10Q6rLlIGIYimHDPYun+BFUtNI05pH
 8QL6gnqFMJ7OvtQdcYGC5dNQP/ULcDTDn1+Lb19/Gt4XiudvQUuiIb6vjjjtvmrW5yGQsirVBP6
 bE4bjYEZtNRoB70OWktpz8X8CTHT17
X-Received: by 2002:a05:6830:44a4:b0:7cf:cebf:b41 with SMTP id
 46e09a7af769-7d7270607b5mr2821327a34.31.1772834826444; 
 Fri, 06 Mar 2026 14:07:06 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5b830sm1707548a34.1.2026.03.06.14.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:07:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Mar 2026 16:05:50 -0600
Subject: [PATCH v2 3/9] clk: mediatek: add MUX_GATE_MIXED macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-3-b253b49f17b2@baylibre.com>
References: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
In-Reply-To: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EG3jM+Q7kVoR5MPhkgU00sJDMugIDahVdBDIBUeLVcI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpq0/XLS34D058IpDqf/RWV5nEkA0bOJl+5oW43
 XutsLMISEKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaatP1xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZYwH/j5YDbvOcAA+LyBAeDXsvp47YB6S9rrI57i2dbJ
 B94ZU+/n3dIzkBGPz+N1lmgc2zIjBnD5XCAQQi4N4QIrdCR5XqgRHO9Axsfmz8ntTgO1y6nxGRM
 8JXmo//1q0qb+SqvJgfbZ8KdzmHVNfZcWh3D92gi64iItp6dBXKLDB2eu+Ee3t4FlISgGN1CO3C
 TOLEos/wnKYlbRQbNiAPHJQUu5mYzQEGjZdQ17l7MK3NHo32lbATdluGlotWzF0pft2qpjG5hmk
 cnAkaRWSp68J6R7ErobnoQHLLxfYQn6KvgecMebsceMqmbcCioeHSwIGLhwzfMb2JpIwY3UTWr2
 u/sA=
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

Add new MUX_GATE_MIXED and MUX_GATE_MIXED_FLAGS macros for mixed parent
muxes that have a gate. These will be used in a few drivers where we
already have this type of mux clocks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index d33e5cd2480..5a48f2e002d 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -178,6 +178,22 @@ struct mtk_composite {
 #define MUX_GATE(_id, _parents, _reg, _shift, _width, _gate)		\
 	MUX_GATE_FLAGS(_id, _parents, _reg, _shift, _width, _gate, 0)
 
+#define MUX_GATE_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _gate,\
+			     _flags) {					\
+		.id = _id,						\
+		.mux_reg = _reg,					\
+		.mux_shift = _shift,					\
+		.mux_mask = BIT(_width) - 1,				\
+		.gate_reg = _reg,					\
+		.gate_shift = _gate,					\
+		.parent_flags = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.flags = (_flags) | CLK_PARENT_MIXED,			\
+	}
+
+#define MUX_GATE_MIXED(_id, _parents, _reg, _shift, _width, _gate)	\
+	MUX_GATE_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _gate, 0)
+
 #define MUX_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _flags) {	\
 		.id = _id,						\
 		.mux_reg = _reg,					\

-- 
2.43.0

