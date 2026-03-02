Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A330EB3622
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E783E83F61;
	Mon,  2 Mar 2026 19:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z1qgYTsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9154283F64; Mon,  2 Mar 2026 19:04:47 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A4E883F30
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-46392972257so3884208b6e.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772474684; x=1773079484;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sJeuMkg6/c0lnPQU1MBXhsOd9MnBt7w4eChECCeX1iw=;
 b=Z1qgYTsOfYGHH9Jn8KAs715vZnrH7t3lQvcOgwrSQVr/IL75t95/7zM2Xjs6VRv+UB
 GSsAVjAjw+fapdG74EFCWoE9BAprqYYIkRzYPa18XtkNtePr25kKIaZBLIXowCkXulIR
 sY7xIYMHIk7GCamrb9D2q07SH36Q+1xLrNoNz5gSlwR6ro9mIb0kUjUrHisjZHv3G0vd
 b+99plD7nOYhq+NYG4TtE+3Y/7Hy/lqok1NeguB1INwOSVWeC8Z1kBedsfCcHsl4ap8I
 Iza8nPYS/KLKGtpRk59F3zS3iv4XBYIZgULvKuD4McEKQv7d99EW3xwcOu7fm0dEkVQ8
 vhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474684; x=1773079484;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sJeuMkg6/c0lnPQU1MBXhsOd9MnBt7w4eChECCeX1iw=;
 b=vidmX0xNmQEjCFC1se+Oa9SEg2cy6oTZD6xEuNKEyWc0r/LoGKe9EnY7SC47I/A670
 vf0eN1xyhVt10+eJYBrHnOnHLcEYGbQVHQ5lVwHAKTAWwvVIrz2whgCRShDfcHguFbL9
 tgT5STB8scVt7JgqRLTaqKPdH95j717Y3sPVK3lulumUhsAsxjJKZDdqaBh4dAe45N8b
 ygvKT8YjI7QGyNLNtArpfO9qm3pqdg5D3Y39L5fIWxKjijEQ51+iXhSXYgWTm4CyHiv0
 9gWQutgCEwUYbDwJN9PU9ChOk0bAOpwXqMOMDaGzvRf8GfzyNhG5tqp5gAlH/wfvV+PB
 NeSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4VbzGARblTCHaryVUAZOGHm5HuF2RFHEgn+K25yRPGzxrTMz5GhS+kg2rPBUTUNHQdisaoIQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzBHNMZaQAw3n+u5f/AqXrZc1ckIHOEClClKz8aSoQ/2bZBS8g9
 i6lAvwpoAdW3xDIlBP9ExhO7vt03cSFpYLcUqtJA4jh4FMWw2UcpLiI3UxMw68Y3SsE=
X-Gm-Gg: ATEYQzzsqUwU3Wj9zugzmXB2mikmbkOkVFA98P6U82XhaqvKWpBqEVnvob+F4xPddtm
 C/oIR4gJ8iJmm2WZzSpJDb1QoN7YoeF6hnis34a06B8WukzDFKraoIAifQjatOlVWKB69h1thtj
 p8wy7svdDi4ejk83uM4V5k9MvVFOmrl8HW6pcNCkeZq81ypblyH+NXx6LcbRsmBr12mhC4R1A0+
 redx5cCgStrljnqdDZcZbPcINPBlCTjsosqoIKYT1T5REwHFRwdxqEms7UbvvxAPMj/uTo7qsx6
 EZfVfIKHmNdyhfiy6gtmCT9jM3MThgAaJnO8iuR3jLBZKZ4XriuW3/6mz89nnFQdWLZkjuFQaJI
 fiAg+C2acgT7h77YkOVcPKiTJHKGjDTamevkd1hiDF7ZNbaN23osd3Bd4iHNxwEiWNsPJKbbcvt
 nlBw3HofPsWoWdm0ERZr1k3ZAy4QYl
X-Received: by 2002:a05:6808:171c:b0:45e:b623:f9b3 with SMTP id
 5614622812f47-464beb9171bmr6696003b6e.42.1772474683723; 
 Mon, 02 Mar 2026 10:04:43 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab302sm7986125b6e.7.2026.03.02.10.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:04:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 12:02:12 -0600
Subject: [PATCH v3 5/7] clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-mtk-mt8189-clocks-v3-5-c48ec60344fd@baylibre.com>
References: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
In-Reply-To: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppdEgqVcei6oJsCrfsyM/BXrwsFGU3tssULzok
 VHyYDy/Ab6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaXRIBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AOpwH/0T2yuW4THv7OAQIo1ftuG0w5DbpNIBQRnK6OKM
 YmWS6IWD8pE2aB7q4hr31UKMUUx8KOXQwfYNojkIkRn2DUijJ3csrZ2OvZhylaqV2ibg9DqGjpE
 qxXp+EQtaSzenhpF3FjzMX2jwJ8/MibMhHKUGeXzdmy9SHcTshvEAcLGD2P45Cou4g/Tuu1m3Rm
 6+7ZdiqiPrmPXjc85/vFMQXWxXzmYGSbF1QT5IhXVGEF4FsKD68osMyIlkLhdcQzdbue2S78yAo
 krGnByYJkrqczw45GIfdJGE/2vXuvViT50+KKOtdZPMgjNjPQL/QU+3w2QrqPnHvX1NfS0emcLt
 41YQ=
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

