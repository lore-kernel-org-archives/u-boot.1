Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C501E9A03E
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 23:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D11283D0B;
	Wed, 18 Feb 2026 00:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iY8HqvPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524CD83D2E; Wed, 18 Feb 2026 00:31:19 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33AAA83CB9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 00:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d18d0e6d71so3172219a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771371076; x=1771975876;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sJeuMkg6/c0lnPQU1MBXhsOd9MnBt7w4eChECCeX1iw=;
 b=iY8HqvPPyHJSXn8o9hgESXNLtT6D/Y/bUKycYDSqBDW/sQjryGK+E0KTqrAJZNRsIA
 9O2tOGrTUjScYE5fLigwN/qoOzI9WyIzFHLwOSAzIkDuMSyJCH+7QsZsHIJLjmfllzNG
 xbDilwW/RDMiWUW9w2LRE/AMmKXSOu5EBbVGqEJlTKSmqoKIDNNccV2CLKH1zfslRB8l
 a7SstFaEGL3xY59kqnA3h0IpyYCBCDlCRfkXVy2yazQ4lOSwNBLmxogJXCDSS9aa8h2c
 NflFDxpgpgjpdom879b3IiSOJBN88Cm0TDlK5sSVY55c87m7ETSQLDdEejMpxOHXc4aQ
 wVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771371076; x=1771975876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sJeuMkg6/c0lnPQU1MBXhsOd9MnBt7w4eChECCeX1iw=;
 b=aL07nuVZkQKp1oOjqXpeArneWLncEPUq5r07E4BC+tuqC+Sx8YZTlrzqQIkxwJ8ARY
 a8797T0IjfEZmeVcYXOHuye9h4E5eho0BmNCZoYRelUOf3D6go/Pxt61dsJwYkVlPnne
 e7RePsEIU54YgpDSRgd3jJ9W3HwoHmtGtn7uBlLul4t/Q2RNF/Q1GnSkAHaqcgeC+/S1
 0QGUN47UTGS4dzl1G7utVtm6EhmiVMm9vve1hmSlTfw2+BDoM8aXq2/RR7k7osDWWbP0
 Ffm4J9KI/lSsp4bXuMwCaEMjVOdi8fOTpHxqEi1qL/cE6nFbymx1gHAcWKVwQGXQam+K
 0CyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcokVY3N8d+q9A5td5C2TFw5Dvh4DdwRNTNNdclrJ7X1597+lwWUwG8GxLHIDS5p4enWpvuds=@lists.denx.de
X-Gm-Message-State: AOJu0YxuC3SCvO/UzGxLe0IXg6WD923+3ghjOCEkcMzJtz7I+HKJwNbF
 e7FGYrNdMLMYX6pNbKZux6HA9sg6rqcSe49djHqnFJHFfr/miP+ClTzFSDlNgWJlvkShOBsZEww
 gKhyZ
X-Gm-Gg: AZuq6aISRabG3Ec4P8qa7BBKIoI3nFm0SDQL0fD2p9DTv0RAcF8KB7UldyqcyCVMasZ
 PKLoaol9wGrQW4ZInsmbud2UEnFjfblocwWZwwe6eemhHdCuZcA/x2yw9BvaRqVhiJNMvKuFdQM
 7CN8v21yQMw7EPlUwztBdIOaDY5/eNilkilhzPNpxvjt+675pXfoV5p+aWY9aTQmkaFOM7kWIzw
 T97+AmE++/8GIb4or8tW4T+A1t/zLHxAGUur+nansdl9MY+zvOP+jk2PDqMT2qo2D+WlK2rqMB/
 qVV1FxgE9uUydKA1z4kImUtK7jj9yUlPTErUTs8DqtF6BFImdtP7gcdRr84VHxEVdN7KNdxK6B9
 NczmtpxYNaJPcc46WTIf2j5PHDW2mO1tg8WKqpTzLuoo/8Pw2u5w3Phc6GiBLCVSOluj5UO3YcV
 pGLfax0ISex9SEtbA5Q+6JJtt/zuP0lLpBz9GN
X-Received: by 2002:a05:6830:442a:b0:7cf:dbb4:3210 with SMTP id
 46e09a7af769-7d4d0b0019dmr7190802a34.15.1771371075885; 
 Tue, 17 Feb 2026 15:31:15 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8c6:5b3:8109:1f08])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c7288d34sm11122198a34.18.2026.02.17.15.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 15:31:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Feb 2026 17:30:12 -0600
Subject: [PATCH v2 5/7] clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-mtk-mt8189-clocks-v2-5-cd381cd05251@baylibre.com>
References: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
In-Reply-To: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=+r3Mtaip08VF+oET76BCWEanas4FlGfdK9u8ImuiBEI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBplPoq5eTcyM/ctjX8Rj5VOz+n9/IT7fLo4Ac9X
 WvHododzieJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZT6KhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiskH/1hAe7hweMcJ1MzdO83aIM1JIbYTQAWPU44VVpj
 usQDFClmu++cKK1auRO7mKgxSJQY0oFrkj1CuR7BUbQUopfLFbkfiehaqrpYB7rj6CrvItj/KcL
 NQypIh3N3xJVgLIYDN33yrcg2C5mV+aEKddSN3Hd9GK7SRP/SIOkQLQe2caCSgvWceicrt+UsC7
 WZpd9rueFHkht8wlSagS+jElYvFT+nFyqSzFE9gYbed2DjWCWhqwzj2Rrr0ZBYnkJtzpyO8ikL+
 ViROjyaMNZr/SEORHF2JoEA4gpTR2t1iM1WP8pBIerOuP76pR4vJsQZRGco4Gq4BggnLKJ7jDgT
 oqIo=
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

Add a new MUX_MIXED_CLR_SET_UPD_FLAGS() macro. This is the same as
MUX_CLR_SET_UPD_FLAGS() except that it uses the parent_flags member
of the union instead of parent.

This will be needed by the incoming mt8189 clock driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index c6874445dbe..c4aeee49abd 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -221,6 +221,24 @@ struct mtk_composite {
 		.flags = _flags,					\
 	}
 
+#define MUX_MIXED_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,\
+				    _mux_clr_ofs, _shift, _width, _gate,\
+				    _upd_ofs, _upd, _flags) {		\
+		.id = _id,						\
+		.mux_reg = _mux_ofs,					\
+		.mux_set_reg = _mux_set_ofs,				\
+		.mux_clr_reg = _mux_clr_ofs,				\
+		.upd_reg = _upd_ofs,					\
+		.upd_shift = _upd,					\
+		.mux_shift = _shift,					\
+		.mux_mask = BIT(_width) - 1,				\
+		.gate_reg = _mux_ofs,					\
+		.gate_shift = _gate,					\
+		.parent_flags = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.flags = CLK_PARENT_MIXED | (_flags),			\
+	}
+
 struct mtk_gate_regs {
 	u32 sta_ofs;
 	u32 clr_ofs;

-- 
2.43.0

