Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE60C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B724C818C7;
	Wed, 12 Mar 2025 01:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oxz5pOhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB1A681877; Wed, 12 Mar 2025 01:31:53 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8FD807D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6e8f06e13a4so3458096d6.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739510; x=1742344310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8M3KzmOr8hBdeFhHWPuMoh9Hn43mMGgWioGbpeTp6s=;
 b=Oxz5pOhqTDbIrDcaWOpsq97Qc34oBsPzKo+g41rWoiGJeP5Fdp/9ymHwmjpjS+Djqq
 6B6RRNOMJMWo+OH0rNJLh9SR/UUEgYPwa3Y7Nc4MJJxHKURjY85UmYs4OAARlrSiXKNu
 cHhD5RgsmZ9RrhuKhj0ImISKTI9k/UKlTkl+aeZ892iSb2b85jvRt56Z/xYOlSaYI6Ex
 Ac3THuQHBnpoauw3s2K3pSqq6gdJQkiWHtePnX3jFjag+oUVTLajVk9yQlNjiZGXpWgP
 VsiprvsR0FziXhhnPl/0J6A7LdMq6bT9+B0KX52kChOY2UyOGPZRH8egv6o/KmgmvXmu
 XlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739510; x=1742344310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8M3KzmOr8hBdeFhHWPuMoh9Hn43mMGgWioGbpeTp6s=;
 b=oYwqYqYSO5Hs7ChKVb0qrfH11ajAef4yIUOFRPBaUepUXitv3m7O19JPDyxoAkM5MJ
 AyHE4o/qmY5jX7+GMNtgl96vBhkLsLr85I7misuIAfi7YGteclvAeZG7TVfVDM2cBeZe
 Xt2koMKyd/YMUUTssPpPViZ4J1ECL+5RL4AdLA5xOjmLQR/FZutHuxsFuxI8NoGBessy
 tWnz5SxdkEPfo2l+3cNiXdNbDXVUUXmaOO2Ew4I1Zr1Oz/bqckqaQmnOPoaIkQLN4yjD
 SUQCACW/+/WAL+yz9HrWMuv+f7NnRRU6zWCeesiIv3k9WejXTB5WXz2XvR/5isoHyreC
 xpog==
X-Gm-Message-State: AOJu0Yx7Hk1cU5DBwi5iFNVeRZYaC5tVgDwrkrGqSOSoDH6pQY4D1wul
 pWVxjB89L49v7Dctw40bhdBDWaIX1ytlQDN2y43EtPq0F+TM78Cb5f/Kyg==
X-Gm-Gg: ASbGncuowSjLBXPe65nB/f//FLvDQyKX2XJNhKX/4xLOQ4OSHU0fDlO17vbs++inSM4
 7niRuJa8g15t8Fnt6nvIw2dR6A8Sbz0eRcsfLnEFGubDI8rXditmk5ErT/QReMCD2A1gxjMpTjX
 tRyycVdLUDZ9KysXxSo2dkCXYzr+gaLHaD6Z50xv45m7qWnyJvDmABppOC7P4szZi9FgAU+/pWG
 yzCzoW2ElNP8Z8BOYlyJ8dV6vGTHLg+JQjIf7ueiyM4N90L3mQ2b00Mmj8xoNTqDxSsAlXxf/3A
 KD6nuSRNnllOm9zLUZ8EfzZ6n9FbJXSlmCXLcoVok4HGjuGToDO9mlcpf36m9Mjpcm5B1z7W12u
 5HKSLdwEcTXDbLDhco1o=
X-Google-Smtp-Source: AGHT+IEmS2WS3TlII8lUzORVc/wgjQQ90N6+bFko82AqFzbT+V1p+uxMNAHKZZderb49KQd2mnSgDQ==
X-Received: by 2002:a05:6214:2269:b0:6e2:383f:4acd with SMTP id
 6a1803df08f44-6ea51ede8bamr81822136d6.7.1741739510049; 
 Tue, 11 Mar 2025 17:31:50 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:31:49 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V2 03/10] clk: imx8mm: register UART clocks
Date: Tue, 11 Mar 2025 19:30:23 -0500
Message-ID: <20250312003041.110023-4-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
References: <20250312003041.110023-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In order to let the serial driver enable the clocks, the UART clocks
must be registered first.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/imx/clk-imx8mm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index bb6958f0ec2..378c07caba3 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -81,6 +81,22 @@ static const char * const imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m"
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
+static const char * const imx8mm_uart1_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext4",
+					  "audio_pll2_out", };
+
+static const char * const imx8mm_uart2_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext3",
+					  "audio_pll2_out", };
+
+static const char * const imx8mm_uart3_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext4",
+					  "audio_pll2_out", };
+
+static const char * const imx8mm_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext3",
+					  "audio_pll2_out", };
+
 #if CONFIG_IS_ENABLED(PCIE_DW_IMX)
 static const char * const imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m",
 						      "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_500m",
@@ -322,6 +338,24 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite("i2c3", imx8mm_i2c3_sels, base + 0xae00));
 	clk_dm(IMX8MM_CLK_I2C4,
 	       imx8m_clk_composite("i2c4", imx8mm_i2c4_sels, base + 0xae80));
+
+	clk_dm(IMX8MM_CLK_UART1,
+	       imx8m_clk_composite("uart1", imx8mm_uart1_sels, base + 0xaf00));
+	clk_dm(IMX8MM_CLK_UART2,
+	       imx8m_clk_composite("uart2", imx8mm_uart2_sels, base + 0xaf80));
+	clk_dm(IMX8MM_CLK_UART3,
+	       imx8m_clk_composite("uart3", imx8mm_uart3_sels, base + 0xb000));
+	clk_dm(IMX8MM_CLK_UART4,
+	       imx8m_clk_composite("uart4", imx8mm_uart4_sels, base + 0xb080));
+	clk_dm(IMX8MM_CLK_UART1_ROOT,
+	       imx_clk_gate4("uart1_root_clk", "uart1", base + 0x4490, 0));
+	clk_dm(IMX8MM_CLK_UART2_ROOT,
+	       imx_clk_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0));
+	clk_dm(IMX8MM_CLK_UART3_ROOT,
+	       imx_clk_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0));
+	clk_dm(IMX8MM_CLK_UART4_ROOT,
+	       imx_clk_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0));
+
 	clk_dm(IMX8MM_CLK_WDOG,
 	       imx8m_clk_composite("wdog", imx8mm_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MM_CLK_USDHC3,
-- 
2.45.2

