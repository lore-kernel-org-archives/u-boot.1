Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09190C369C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 21:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B3582DE7;
	Wed, 16 Apr 2025 23:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EaX1XFoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C5482E38; Wed, 16 Apr 2025 23:55:38 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA08282DB4
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 23:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c5e2fe5f17so6753285a.3
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744840534; x=1745445334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sukhggooi7ba8x0ymKoXy4GKxqwpohvtz72u1VRpvbk=;
 b=EaX1XFoS+P3kgSGWDXDOjRwOBJ+Yh80AZaf68m2jJSQMSCDkD058D341eW4I7pzCqi
 NFtdvQ2GayfSVCR6NvbPLmjNvmcdD+zq0Dora/D1co09h8/GUp8NSbJTWjdqTaXtsxQH
 xVvck6ScI9DEaZRMx9MTc/oJWrJZNCJrxI79OTzvqyUoXrJahd4G+A1iO5cnyU2KPT2Z
 MeSOizJHp1uL1PFOcpBFB+8eZa3LtzX73xIAjvP1LHTukuLSe1kPbkDJ6ji4L8K6Oe9/
 hiUBM2xPgcWhm6Q3wqnCFTUmssvB75iBeU+MZN3Yn89yzjqAoslHA5MJHyGT2pAVnE2a
 EaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744840534; x=1745445334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sukhggooi7ba8x0ymKoXy4GKxqwpohvtz72u1VRpvbk=;
 b=jkNalE39k/eZmgHquVRmgyIrWT1VGVMfuIN4voe6zf6rC9iAbspuW1AvI9oQg/PeRu
 54Oeuo61gnboAeeqLsVC0RDqYBhjmz2dTXsmiI6y1ej4rH/CycZkJuCNMRv3sBne7sFf
 2OUQDa296G7V+Y6hrNGm0TUzlsSwlznsHOraYS1yfq30AuqjnHGGyoIgv8mpAjfH8G9p
 QKe22wos6xtGdbfyjrphe3dH2BnyNmnq1nXJNWLIfj5gLEEcR6DvNIuDtkLLiUxeVgnj
 yPVTH8CeBOdjTOwRPZ4VZ6HzrJuP2SY9mf4eDiqWv22tjrWp+TCyRoROieoWWL+4VDl5
 MNBg==
X-Gm-Message-State: AOJu0YzdTuc/vgJpGIdnSPlCYpzq1CVm4uazeD5u3TBfZQhoaON/nYLO
 IqEPFczOeE2JLUkNvyI82JFy9aakyqh11rPPyLUN08mjqwKnZsYeTtBEEA==
X-Gm-Gg: ASbGnctcLPh5JmH5o12NbaI3uaGBmSTYi5pKNpuYBdXvVBdCDGqeQWv6AkUlOg02T7w
 34qFc4neg+SJ1fykdNR9HYnrCnBf9Lz47rUH9tu+MsEM5i48OpygpI283wFSEb/rE3rTTPzsdPF
 a75PIDGUkDHexPr/W/7PtHVT08QCcoB6VIHyoLW1BhzvRceISE3Gr5Wac6+Ex8TrsPMW0US//03
 zXPjGTrmXnLbRPXKalu3hRVyEa46OOELwR5qOoVX6w8qZnYIG8wfVm70QKfgV00f2cFrByCE5QH
 YWsaGHWd2fcjT/EkH3559y/jb6botduLUkTpLx2R5PE9CqNVqT3rgBrx4RDM8JL7PsjePZa/MLl
 2L7jXnpQ2n2lAGBU=
X-Google-Smtp-Source: AGHT+IEToQEL5QiIQMd3CGGlEA/2gBtpXJ6vVfi7t1wa5ipP07THMTPIcjcQNBdy4UCqIXfP5vyV6A==
X-Received: by 2002:a05:620a:29c8:b0:7c5:6cf5:9439 with SMTP id
 af79cd13be357-7c919064075mr541310585a.37.1744840533782; 
 Wed, 16 Apr 2025 14:55:33 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c7a896b01fsm1102784585a.65.2025.04.16.14.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 14:55:33 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, cniedermaier@dh-electronics.com,
 Adam Ford <aford173@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] clk: imx: Finish converting clock-osc-24 back to osc_24
Date: Wed, 16 Apr 2025 16:55:24 -0500
Message-ID: <20250416215524.3963310-1-aford173@gmail.com>
X-Mailer: git-send-email 2.48.1
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

The UART clocks were added around the same time some other clock
updates were happening, so converting clock-osc-24 back to osc_24
was missed on the UART clocks for imx8mm and imx8mn, so update
them here.

Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b81db516a69..7eb05180e15 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -81,19 +81,19 @@ static const char * const imx8mm_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mm_uart1_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mm_uart1_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext4",
 					  "audio_pll2_out", };
 
-static const char * const imx8mm_uart2_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mm_uart2_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext3",
 					  "audio_pll2_out", };
 
-static const char * const imx8mm_uart3_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mm_uart3_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext4",
 					  "audio_pll2_out", };
 
-static const char * const imx8mm_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mm_uart4_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext3",
 					  "audio_pll2_out", };
 
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index be5b7933a8d..2dfa860bf37 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -97,19 +97,19 @@ static const char * const imx8mn_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys
 						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mn_uart1_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mn_uart1_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext4", "audio_pll2_out", };
 
-static const char * const imx8mn_uart2_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mn_uart2_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext3", "audio_pll2_out", };
 
-static const char * const imx8mn_uart3_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mn_uart3_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext4", "audio_pll2_out", };
 
-static const char * const imx8mn_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mn_uart4_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext3", "audio_pll2_out", };
 
-- 
2.48.1

