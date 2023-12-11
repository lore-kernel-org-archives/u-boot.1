Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F601C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 13:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2015987766;
	Mon, 11 Dec 2023 14:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devialet.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=devialet.com header.i=@devialet.com header.b="X41cmE9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC9D8761C; Mon, 11 Dec 2023 11:06:40 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28732876BA
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 11:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devialet.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nicolas.heemeryck@devialet.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-334ae2b2337so735903f8f.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=devialet.com; s=google; t=1702289194; x=1702893994; darn=lists.denx.de;
 h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pUYFH2gDDc66Md+SkvSPyz/mTFR7C4LNXn1fZwpOdZE=;
 b=X41cmE9eOXN7tgBh3qZeYt6x5DE37o7+3OvHkhIrZ8q26/fMG7F+2BoQrvMlWU2ukG
 Uw2MmzP4YaVNxqstphTbPCCUv+/i7xQGolk887IjTVZW/AsR5kiUA7yzo2BmIE88uvl2
 M1VfLIkwnReL1drS5BIO64aEuI1QAD/pe7RiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702289194; x=1702893994;
 h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pUYFH2gDDc66Md+SkvSPyz/mTFR7C4LNXn1fZwpOdZE=;
 b=mPw5JwjGweNtZa2uxtYMdI1hNj5OkM/G00osGT/LbJzKYrt92Py1/agb6y+n90MbSl
 MfacMFscHNqgYHnyxLl3GmVa2J047W2zTS09W8iBPW3eAc11hBUvTYhLtJsbZN3ELxuo
 0sK0oQMarY8StlC4ag0H6QLqnww4X+1o1ufHUciwZmthWJ5jae4Qaw5LGF9CdmcTH6bR
 w21fyH1qspvhAmpVYdhv0IhZPEWVSHEJoPA+c1hwjOGcVLLOBHJIiqLrNlhW2nECY2Bd
 i/WGViVEwJtn/NGkVYH5ExILb1k5FNNUCSwKlJG1c95URajAJWFDJBC5CuZ2CEq0pQYE
 i/Mg==
X-Gm-Message-State: AOJu0Yw9iDM1GaLmsANN931y6cErw+pm1YR7JO8+7Hy0LVNpxE/TTZxf
 VHagvI1cItIhMxRtMDpOzmW0iKzyu5Gb2gfNXKKN1kynuOj9VX8IIvP+5akQEL3CJPxAxRffxwr
 wEQJHi7LQaaB7+DUfw6mlZXhwipsRzGz8wPPQrBWDk+pPreWHsKb6vOPE4acQNZSOZJSeyRADvQ
 bfjQjdl6j5TtE=
X-Google-Smtp-Source: AGHT+IENDYBzjb3lhE0A4rnWWR295E51SRW9Eeeuz4nOwmLRP8ZNhZ+0qEJ6naRhFMBi9lwFg2W6CQ==
X-Received: by 2002:a05:600c:1c0d:b0:40a:771f:6a56 with SMTP id
 j13-20020a05600c1c0d00b0040a771f6a56mr5200823wms.4.1702289194338; 
 Mon, 11 Dec 2023 02:06:34 -0800 (PST)
Received: from nicolas-laptop.. ([2a01:e0a:297:6e80:8c1:cec5:e3b7:94b1])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b0040c31bb66dcsm12173591wmq.20.2023.12.11.02.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 02:06:34 -0800 (PST)
From: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
Subject: [PATCH 1/1] clk: imx8mn: add pwm clocks
Date: Mon, 11 Dec 2023 11:06:13 +0100
Message-Id: <20231211100613.46650-2-nicolas.heemeryck@devialet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211100613.46650-1-nicolas.heemeryck@devialet.com>
References: <20231211100613.46650-1-nicolas.heemeryck@devialet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 11 Dec 2023 14:47:26 +0100
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

Based on Linux kernel 6.7-rc4, add necessary clocks for the PWM
controllers.

Signed-off-by: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>

---

 drivers/clk/imx/clk-imx8mn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 692823e74b88..457acb8a401e 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -83,6 +83,20 @@ static const char *imx8mn_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_
 static const char *imx8mn_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
 					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
 
+#ifndef CONFIG_SPL_BUILD
+static const char *imx8mn_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
+					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll_out", };
+
+static const char *imx8mn_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
+					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll_out", };
+
+static const char *imx8mn_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
+					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll_out", };
+
+static const char *imx8mn_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
+					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll_out", };
+#endif
+
 static const char *imx8mn_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m", "m7_alt_pll",
 					 "sys_pll2_125m", "sys_pll3_out", "sys_pll1_80m", "sys_pll2_166m", };
 
@@ -330,6 +344,22 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_ENET1_ROOT,
 	       imx_clk_gate4("enet1_root_clk", "enet_axi",
 	       base + 0x40a0, 0));
+	clk_dm(IMX8MN_CLK_PWM1,
+	       imx8m_clk_composite("pwm1", imx8mn_pwm1_sels, base + 0xb380));
+	clk_dm(IMX8MN_CLK_PWM2,
+	       imx8m_clk_composite("pwm2", imx8mn_pwm2_sels, base + 0xb400));
+	clk_dm(IMX8MN_CLK_PWM3,
+	       imx8m_clk_composite("pwm3", imx8mn_pwm3_sels, base + 0xb480));
+	clk_dm(IMX8MN_CLK_PWM4,
+	       imx8m_clk_composite("pwm4", imx8mn_pwm4_sels, base + 0xb500));
+	clk_dm(IMX8MN_CLK_PWM1_ROOT,
+	       imx_clk_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0));
+	clk_dm(IMX8MN_CLK_PWM2_ROOT,
+	       imx_clk_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0));
+	clk_dm(IMX8MN_CLK_PWM3_ROOT,
+	       imx_clk_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0));
+	clk_dm(IMX8MN_CLK_PWM4_ROOT,
+	       imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0));
 #endif
 
 #if CONFIG_IS_ENABLED(DM_SPI)
-- 
2.34.1


-- 
- Confidential -
