Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848D3C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD8F81429;
	Sun,  2 Mar 2025 17:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X1j77tIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4158881423; Sun,  2 Mar 2025 17:54:03 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DEF2811B2
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-852050432a8so111667539f.1
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934386; x=1741539186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8M3KzmOr8hBdeFhHWPuMoh9Hn43mMGgWioGbpeTp6s=;
 b=X1j77tIkd+uRK2/Ea+aUHpAGRY9mwS5Tdf2hSeeuk5TkjnR+/SRZgdd+ckn4Ftxkf/
 SLnI+TkcdRQHTBmkCfVxSw32Z8ip4H8XrgI1eHTjBQIDgsIojR4yLl5xWxsYtsbg3Eq5
 HKgQkSfJj9PChmWLbvuAILA3hXhCyW2ACZlP6uE85T/Y/XXombyTIwXjSHE/iXQYJ/5A
 sQBxMyJ8T+HWXdUa+Qji81JqydiLpM9TcJyypB/z0kaIGF/6ujTvr1YvnTRX/Y/SP0bL
 abBFKpVk/OuhU46CiVLzWBONWwYb0MtzphaJPmeKGjAi/1/NlFlcKGBOqDU3WJSSWosP
 laUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934386; x=1741539186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8M3KzmOr8hBdeFhHWPuMoh9Hn43mMGgWioGbpeTp6s=;
 b=dR9KGDQyXhjxD3z7JfIlBzVFB3ZaaLwbbmMsre5D/7lpuXfRziXX2f345YyB3F5A8M
 HiGDObLZx0WE+LyJlcPKD+nvHyIbyEIyErX605jdBt8wOFEMjyWPxA5nhcMwKiHCeRyU
 om5Fa5x8FFgfn4Ju6HDHoLQuDaHfimiUVn5tZBXlyBToesr+segg4aH7gt86/nhQFB77
 fCCZyWuezqv65S+4IWynPTuMR4oK7VQycu9OW74BovxrBSKIcbu5kGthB8Lw6sltsdr0
 Fz3GPPhyj0fEFQ8tWHSWzBMT2TtjZtDIyyGZCURI6DB4gT9F7oH7FCro3vYnmxo7K3nm
 26DQ==
X-Gm-Message-State: AOJu0YxW9OL/1rh7X0RXMQiQop25aW3XrhoyGBZzjdUmuUM6k8BNcZNU
 f+aeSIilxoWLiQIINsNN4J++tyXruWB3nKGLnljGF1cyAnc6q2NcXagiEQ==
X-Gm-Gg: ASbGncvBAIqD1oT6QB4bjViRH/vLRxBWP/KzYKKiHYr+lFgZ46wpUEYvRriCKPmd/bV
 iOTE5bZLvDTMnYJxIoF6XcMNu8f/hqn6YjPrzPtP26pY1RLb61M6Wj/5BgeyQMU3SjFOh/q+TUg
 kX62LvRss0AKN0qgNruQkelIUp+FlNQSEdeUIRp2fhV7AypkQ1uvx87bimDZj7xi49zgnOjf1pG
 oJm0UWzzx6WD3y4F8jiajYBWYYe5O/pqNLlo7KL/YywLwj17Lf5hqE206RAl30YqZBsL3hIaglK
 QdIV+bTVuucJJovvynE6p06kzZ08NUr46pYXuJbYSsIIjP9aLs1mjD6fn4A0vPC6LZ3F3YkNKrO
 lVMi2ieAjaHKghHA/nV8=
X-Google-Smtp-Source: AGHT+IEs0/HFN0rH8MUW9Whez4SeqbswACe5b0yII3foI9hJxBs3mLoSM77P6jyxyyyJlr328oRPKg==
X-Received: by 2002:a05:6602:5c6:b0:855:9621:d08c with SMTP id
 ca18e2360f4ac-85870ec3891mr1313846639f.4.1740934386550; 
 Sun, 02 Mar 2025 08:53:06 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:05 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 03/10] clk: imx8mm: register UART clocks
Date: Sun,  2 Mar 2025 10:52:30 -0600
Message-ID: <20250302165249.267992-4-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250302165249.267992-1-aford173@gmail.com>
References: <20250302165249.267992-1-aford173@gmail.com>
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

