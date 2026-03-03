Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D9EEDEBEB
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 19:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B86683FA4;
	Tue,  3 Mar 2026 20:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RbBZN/nU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11A883F9B; Tue,  3 Mar 2026 20:55:56 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA0683F93
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 20:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c7d04890so5541013a34.3
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 11:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772567753; x=1773172553;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sJeuMkg6/c0lnPQU1MBXhsOd9MnBt7w4eChECCeX1iw=;
 b=RbBZN/nUhePqyLmwbjKMGNFTpQcZbOmEoSy4m2pq/ofJ7L6tBk55TJz5kCPAO1EvBR
 pIKBSUGBJUyTWpsv9/3aNorcItVe5IMbhmGMu7EUdUcg9EhLL8EElCWlImbvoURrSPHL
 uFZq82iNN+36hwWq8ypOKgT31pzzYLnMKWjoFCmDJD8nnt8QdQl5cIqPyLfXe/ogccYs
 r4T39UYClqXkiVNFWMqyKnWjeNotIcgsseZM7Ykjnqk2lfPNxU1Rjxh8NMbFLMjZ48NF
 zWvO6pkqgSThNtDTR5o934TEy6QtYqmPZ6OQcKA7EjWiHmCb8qUwg+GQqjGSwO8MkuCk
 aE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567753; x=1773172553;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sJeuMkg6/c0lnPQU1MBXhsOd9MnBt7w4eChECCeX1iw=;
 b=e61C4A4YugGrgXZ0HsrhkEjbPvDShQFvyaBlfb+GUovugdunt1Eotv2jVJDQLNiZc9
 YkYhOag+i/hqjCufdpb5XWqjdk3pwHlRQ/NIyDP49C5LkeVxebvCw6JZOHMLe39hYcgb
 c2UrtDRmXibu/njTkHDx0FLR/4NUVVACCwwdRxuLaFkeTxj8T1pIAMRzgOBiR0E6hi0h
 T85brZjP22361D9xn4mKaGrFdKzehQLLnDizHbZiPjW1qLe72513dVmbZK8xQykvx0uC
 pmy1FXuEpuDIg2iMfRzj1ucbTC9vN+NmHF4Z3wqQi6/+72CdDShvniItiOFdkwUD7ll/
 FivQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfcBPxxwwDYUmw5TdpLWHwqFsDJ4r5wL9vhqoWBtuwvGNWaSoN57A5jStNXagJoKYnvyXwYaI=@lists.denx.de
X-Gm-Message-State: AOJu0YxhZxpWtbJmj2Gb7dLGDWtrWvl1C50CnXS3d+W1krqGWBJfM5ec
 sve8Da0TfITLY2doO0ysPL2cKy1iZDTyNzXIEGStB1Y3wjNh3DYanmMMk22BWEVeQII=
X-Gm-Gg: ATEYQzwAhE5gj846qqGMi/o3qQkuK1XQ0OqeRnCMhiztkxuw+tSB76gpiYajpFn3a3M
 nqTlY/SyUdUKJiRLm3cxt91L4uUWM4Nm8sFmvfur8C4NOf0Sc+zxAWybO1lOJXBFmPLxs8LYKbS
 pgewUEBg9Oa1LGZGNJlzVKknraw0XjOOITLMzu4Z7yj8eh8UcuelX7WZPw4/vCvtt9QpoNZ/tAQ
 erPK2Rai6JrG69NViNgLbdML5VpAgNmLG1agQV8qKuLVXlutWu8q+hAEUj4+3WqRMBs0YV/4WVF
 kVEt0+qgDU/kZ8q0rnCQb4+GXpaTtYMkhVzQpU/X3D5lifXRiskOrP8nFFivgFe31zgI4bVpHXv
 zCgFmPU9uZEF/UufNkXyBPPHxnBqCNXhqaVveKuB6WSLNPxDUs/7xwC7bdGWdLg0bB3EQctoow+
 cTaTmt9C8waCxuCxECsrRWkn3jz81g
X-Received: by 2002:a05:6808:c3ec:b0:45c:872a:57c with SMTP id
 5614622812f47-464bf0089c3mr10140595b6e.57.1772567752942; 
 Tue, 03 Mar 2026 11:55:52 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e10b:3ef0:5af1:d180])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb352592sm9995183b6e.1.2026.03.03.11.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:55:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Mar 2026 13:54:53 -0600
Subject: [PATCH v4 5/7] clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-mtk-mt8189-clocks-v4-5-ee85f8dd2f0d@baylibre.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppzywE349TYCbwV8mpY8HAbJcb86nbgW6OHjBN
 BJeiPVKz8KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaac8sBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuwcH/iwwI4Rl95iovWuX04i1mBcuTWFZS7PWZQVQ89g
 YlSg3MczNuIVQt0FMxmtFhJbTk7+GHysaJ1nsVZzkPQF/3qFrP3GCbS+4L53w7qNRT7Vz0+TGtl
 RH6UE7JKtV3RDZgR3HcLSgXxX2fLhwD24u18iAdv+ByAoVCKlyKpX+G5eUFkPp1BFtPRq2u9Pa/
 UV2//02ZveD8KHn+WQQxLSo/g+jjJzqc38vGOQ/0ixeK0lVKmedoUzb0eoh+1uDULmmgykdwr5j
 STW5VCWtFa0ymx3ksFiwOZ/v3qZX55H+HijpH1WHecqU2MpLi5LacrqIKuPY9oqhzqYQ2mW27Uy
 UqRA=
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

