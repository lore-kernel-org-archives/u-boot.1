Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C57BFCC07D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BAA83F98;
	Fri,  6 Mar 2026 23:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s/soJtEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B3483FC8; Fri,  6 Mar 2026 23:07:10 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17B5483F86
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c65d772cso8424039a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772834825; x=1773439625;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SZAFxvyK6NoGvxEZTHzXPEjy5ZQIuNgJ0z3XcCxV9bU=;
 b=s/soJtEupV4Q7fO+D8qpcct9GJ3cq3klJC/wJ9pXgdVZD7Ibl94RDLRNQPY+XpkEF5
 I6OJRlmVf9d4wGzUBQ65h3madOWNziijqGO71f89Kv0/+H+rc0mnP63sXYOR2zQlaZ2p
 e1xxj/0Xuwu6V9MHLGD8Nq1wIK8iyGJ9xCP9umNUVVdXHYoX64LmrU/Qqh8tGnhxJBMc
 fFqYeQ+9e16rJS0pPZfW0QWmgzgFRYrZMUUVAFHoqzYO+nArRs33jxGLUURyEAQkZRQt
 hahgj9yMtmRRP6kxflrAPVZIQVrizLKu0OsdqOgmv8/OjJm3rhfQiF8pXNYlv3+WBR9R
 +TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772834825; x=1773439625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SZAFxvyK6NoGvxEZTHzXPEjy5ZQIuNgJ0z3XcCxV9bU=;
 b=c0jHiczuckR/BQ6sKiguI4F27Avn5L2mWZfp0Fv8QGeL/KRZIIxlM+Sixd5PtdhN72
 vcqCDAu+xtx5hKzsDH93RK2uFYOYuOjn5+G6sUV2dRaJDn0hplQsLRhWf2i50zpYxbKW
 3ywZ51pQaGt1tFLdbb2M0qjnFFhRPOccHHEyVQ3jQxhUZfWHY142CP46q8N92ITzhCEo
 FWOb88i4nDbBJT7hUJbKo3d9eql43Snzo5Wo5z6OAv7hbo1qAqVxdZD37fednNI7W+Qc
 DX36FniyaNaGRHrdYsMDucYXmGIXwB6vAz4kjzU+hGzzH9CnAgSSph+ZQFcxrnR0xiYM
 r3vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrIMhyQ4tbtqSIS8EArEr2kjB+kDzoCzOW6e9tFTac6IsBStVV/AY0nmzg1z9b8QtKEZggWLk=@lists.denx.de
X-Gm-Message-State: AOJu0YwmmiZhttQ6LSi7/SbN5TRQt143r+p2TGUMjJNWDRjUZU+R5GoY
 drrlP+3OCFqN3ckxCuIf/5jew3bsTk/RqENZKh3ZRZ8IzKLgCLayeppXl1gEdDysQpY=
X-Gm-Gg: ATEYQzwO2K1P+zLOwTMvpbhXSVC8CS58jLQzJaMk594G/N9HJKomAe57ypvml1vyzIb
 jX0hwbpsZQIGXqwNzp1iIey6vo6RDQU56r+hjR+J2Sccj3GnvAnhSUNI0fgIZAA1sgqMWrauo8Z
 Fmg+B9i1IILsGgbEikAETMDjPNJxlPMpgwF7C6KfxlWDgU46BDO34TExgPyeE3vjHpKpgX5LHIJ
 A3m8BveayQU4l16wZ0zca6d6D5fo01Xvj8b1fedV12JZuDzKlKitlhYGPmS7/sYpdbIdAdQpUV9
 69+HfLwLT/SyB1UHPvxPz1BGiSVCcVDhRlvu9inPIKM6Jg0bdrUAAvcG5AhXLDNJWzU10NWigu7
 3lXnJiS0D13Uz9zDoSiNey730ja5yhj8bBzfsGTnM6HmXk+NR7T2QO+43TJ09lM8Pg2ranMMJl1
 oTmHgQzKu4OY9nz6PzEYTA1zuGMJqb
X-Received: by 2002:a05:6830:828b:b0:7c6:9d7b:b033 with SMTP id
 46e09a7af769-7d726f8cc9emr2576622a34.22.1772834825579; 
 Fri, 06 Mar 2026 14:07:05 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5b830sm1707548a34.1.2026.03.06.14.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:07:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Mar 2026 16:05:49 -0600
Subject: [PATCH v2 2/9] clk: mediatek: rename CLK_DOMAIN_SCPSYS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-2-b253b49f17b2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=++ZLUsHac1yOiuXK10XWUvL7Vv+/+NBVhmVheJ+v2zU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpq0/RCE/1HDE5aUPCdziDap0hb2mlBTyt/IhuC
 uiiiz2+iyOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaatP0RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjG8H/1AJKFO6YPqL4p8FThBPzFgGwKNYVNoqTRGUOAX
 i42ptY/6K3Df/gP3xtxRRnhDo0hp4Kgmge5P+OzlED/YSeYHijdNMO/M1KtIpKJ5tQUTp0ceLpZ
 Faz5aUY+dGal3yR19JcOtGyHxnsZHZJQG5bJf8zOOOnsQPh16YxtDi9DkEOQcSrJE5RhTByo8oU
 ylZkKINhKdlW3kClQGjUtsH3oPr2pPCg5Yh7bBj1W6VWTZzlJ9TAeWzGH6nGzrzKWm4O0rMKZpT
 UG5QC6hV7AWKihXHvinf76S0bpR2xOORj4BZ48L1ZQFrgvoCrpW1ULO/hrwTsRLJcIAXav4mip7
 kX+Y=
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

Rename CLK_DOMAIN_SCPSYS to CLK_MUX_DOMAIN_SCPSYS to make it more clear
that this flag only applies to MUX clocks and not other clock types.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 2 +-
 drivers/clk/mediatek/clk-mt7623.c | 6 +++---
 drivers/clk/mediatek/clk-mt7629.c | 2 +-
 drivers/clk/mediatek/clk-mtk.c    | 2 +-
 drivers/clk/mediatek/clk-mtk.h    | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index a26a32e0b44..a69136dbc94 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -362,7 +362,7 @@ static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_5 */
 	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
 	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
 	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 70570644ca4..d62b9651fa6 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -701,12 +701,12 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
 	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
 	MUX_GATE_FLAGS(CLK_TOP_MM_SEL, mm_parents, 0x40, 24, 3, 31,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 
 	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
 	MUX_GATE(CLK_TOP_VDEC_SEL, vdec_parents, 0x50, 8, 4, 15),
 	MUX_GATE_FLAGS(CLK_TOP_MFG_SEL, mfg_parents, 0x50, 16, 3, 23,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 	MUX_GATE(CLK_TOP_CAMTG_SEL, camtg_parents, 0x50, 24, 3, 31),
 
 	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
@@ -745,7 +745,7 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_parents, 0xD0, 0, 2, 7),
 	MUX_GATE(CLK_TOP_MS_CARD_SEL, ms_card_parents, 0xD0, 16, 2, 23),
 	MUX_GATE_FLAGS(CLK_TOP_ETHIF_SEL, ethif_parents, 0xD0, 24, 3, 31,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 
 	MUX_GATE(CLK_TOP_HDMIRX26_24_SEL, hdmirx_parents, 0xE0, 0, 1, 7),
 	MUX_GATE(CLK_TOP_MSDC30_3_SEL, msdc30_parents, 0xE0, 8, 3, 15),
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 7fe62bdcea5..85011f5327b 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -397,7 +397,7 @@ static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_5 */
 	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
 	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, hif_parents, 0x90, 8, 3, 15,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 	MUX_GATE(CLK_TOP_SATA_SEL, sata_parents, 0x90, 16, 1, 23),
 	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index cbe03f23388..e86e677d8ac 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -788,7 +788,7 @@ static int mtk_clk_mux_enable(struct clk *clk)
 		writel(val, priv->base + mux->gate_reg);
 	}
 
-	if (mux->flags & CLK_DOMAIN_SCPSYS) {
+	if (mux->flags & CLK_MUX_DOMAIN_SCPSYS) {
 		/* enable scpsys clock off control */
 		writel(SCP_ARMCK_OFF_EN, priv->base + CLK_SCP_CFG0);
 		writel(SCP_AXICK_DCM_DIS_EN | SCP_AXICK_26M_SEL_EN,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 806ec2ec20a..d33e5cd2480 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -22,7 +22,7 @@
 
 #define CLK_PLL_HAVE_RST_BAR		BIT(0)
 
-#define CLK_DOMAIN_SCPSYS		BIT(0)
+#define CLK_MUX_DOMAIN_SCPSYS		BIT(0)
 #define CLK_MUX_SETCLR_UPD		BIT(1)
 
 #define CLK_GATE_SETCLR			BIT(0)

-- 
2.43.0

