Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B554FECD9AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC6F83BC8;
	Thu,  5 Feb 2026 23:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V/2xkFoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657D58341A; Thu,  5 Feb 2026 22:13:43 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C88383AA4
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 22:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45c838069e5so1030634b6e.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 13:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770326020; x=1770930820;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sJeuMkg6/c0lnPQU1MBXhsOd9MnBt7w4eChECCeX1iw=;
 b=V/2xkFoZNtES3J4HYK2PquOHDcU/tuAqSB7uam0hN28rTYpPk8uSNRm15Ar5lL0y5M
 BoHA11E3j1dryDKnByS8jHzMng1xTWf1mNIKrzC/bUaAgIq9ZR1aP3KeEBKw6Q978iWm
 wp8TP5vCCniDX6OYCLOsK96HnFn8dnQ6xQYjwDZnwBcYOZWaz/LJeFbotYJXIKKi42WF
 E/O9juk8Nm25wuPgSHUBlsPDbuoZmh1f5AX+ovnXU4NcIB60BszEmdG8lyiJZvRuWiF3
 2D58J9HH/KyPTSHzKh0HUoDT5VhRblZPwDQSzZEw/ngpR+KQZl8xsmv21I5FaV9hG6Mh
 Y2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326020; x=1770930820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sJeuMkg6/c0lnPQU1MBXhsOd9MnBt7w4eChECCeX1iw=;
 b=ckZF/+eIyu7/F1g3h3+Hu/zwW0pNZTDVMUStnN7c8Nycvh2lp2RaPCyVu1LipQinxR
 ow/DYtTVy5wJbnkm1HR3MPMmZGBFZGtEyBO5rTcqvLHZw2dRDNpt3c2PeaF4k864JJ6i
 fBn+a5WAyjDOsl6DwkLp5WJZbQC8iS8TuFFs+vcImFsw54ATXKfSwIUScBUG7TXgEV4X
 Y6BrK8gBLVF7YVljLEc5iiM3DqwpjKHAbs7MXu7NG50cl5WQZSSMYHyq2hq7JnEm+TQI
 rl4dCvFv+IjkvSfMY869jtpIDXuqhhvDTkYnhJj6jIxNCRckHlUxpItWOZUalyYvy8K/
 p0Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5fZEw7y/sylTylSxbJ1AtmZcVK2UFw2JmROXaBc1vynLjxTQFn0oyTmqswvQJuB18uWTSrN8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6r5LMhGKCuaiO2ozNCIGPUmzWH0BQoVTmSdTkUnkWC4CvhnQ6
 OnzLG9ySRxbk9iH4y4pRMpTNR8lkUbAL50k/ewyZqvX6et3AxEIjR0+d+OzmYbpeCoo=
X-Gm-Gg: AZuq6aLbdejmRsyTVjwVOvPjHrRT4Mr64WC8JfuZlblsL17dSoOyU0T4UAIPn7wrb02
 dI3i2ag8WAvZ5Yo23pQPv7jHfw9m1J+vZu07nJmcmB4ehq36zPqmQFRMhjSkJLVz3S8D0XYsZ1+
 h+bZFBh+1ODOCEhhLyTcRLSnNG1YEzrbB81awpIE+84+NJkNEmB8tRmKH8TqWOEQJ1vtV+Qza/t
 jgLqRwa3Kj2+x7ap/2S/NoGL90gv3/kx/rmdWZIbtZ6z3tVC4a5MsXCUm6nzL3bndkRZSuK5MF0
 8/YSl2yXR4j2JbNH+pICO46ztWLg8aI+OGxSWwukasx8GgqaJ7gowNydmlJ9iwvmogCMrNlcXYa
 SA85nsNEVIHbFQTMLfa6rasJ6Qp8TAtk0AZGLe4ulg3gBmRiPlY/sJddvZgt4K4mtsL2sqOxwTR
 kFXTgLF7XzqTyNX+M=
X-Received: by 2002:a05:6808:2223:b0:459:a26c:2c3c with SMTP id
 5614622812f47-462fcf551damr396199b6e.26.1770326020116; 
 Thu, 05 Feb 2026 13:13:40 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4647ab1cesm164313a34.31.2026.02.05.13.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:13:39 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 15:12:40 -0600
Subject: [PATCH 5/7] clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mt8189-clocks-v1-5-bbac40932c2a@baylibre.com>
References: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
In-Reply-To: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphQfrN4qOEAkIxboztFD4diLlLHvGygMYRKMEa
 pgTGaDRMtuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUH6xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AT+4H/3FjpUX5GGf8+KYXA3g19r7Qp+soJMIpFFQC5PU
 2Z/3ByQ0L9i9uL/151mSIFR70MhtH386/VTa8tdxX42P86G+r5DIYP4nftctxOHJL8VRJ1OvQ73
 ftAick/oGJrbgLRlELdQrgAiQeguf7Ix1rKrWmLNVCPKBUbcYYyg5nQn5kNpLWQnctvRq9EScTM
 P7aAuu0aVVzRG3u4DspwvwFvcKhacQjn1vndIPoMWQJrWlvrVBO66iHyDH1hsKoUdY5dtJBfv+2
 9GD8u5CsYDKHA97lk4b7S5tqSx8vHxNtNOJ0McbYA2BP59MAWT2bqIdkQiJWy/ml68ZYk3CwtT2
 6dMQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 05 Feb 2026 23:06:53 +0100
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

