Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE48C27C77
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 09:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C6487E52;
	Mon, 17 Jun 2024 11:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KGQ+6D3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C72F788167; Mon, 17 Jun 2024 11:22:55 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5529787CDA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 11:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so3095273a12.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718616172; x=1719220972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l+t+t/eis+36dXNVwjPaVSNBDWiq78aL3rjIjC1tfpU=;
 b=KGQ+6D3RHWCer/rzg2OxB+csU9MDi82ySdCO7Rjp0t49iN8Gnx7bRVGObyp6LYclGc
 1GpQsU1a+r47moi88epxaCSueMb0a0hfNDY4dX5/2mEPn/iaoP+ua9Pp9UtQFH1Iblwf
 DnaBomrocJ3uC534Z0bzdXE8sGKhwYzzsWa6yWK5gzdSqQbXL5HsLi4aQfzMO6QNQjRM
 56bRHuxICTiMSb4l6CJZ2+/6Ev4YvYfxEYbiWHsb5cI2WrWqdQxhRh4DiUfWQJXm0qxA
 zmhhZiwqWCzQoLBepD87xNSXEZka9K2J++wEqOMbvAvvgDcJ9VKKHnYEh5WbX/QUfSnA
 tmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718616172; x=1719220972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+t+t/eis+36dXNVwjPaVSNBDWiq78aL3rjIjC1tfpU=;
 b=NxO5VtsAx9N7N3pysAdzcYXYBE3B25XjnPR5L0sApn9y482O11h32kokV7cDADV1Bu
 jjp1n6QUDsuyRTEN9k99DoDB9q99dMliahsdTZGKcvRadopoMswm4TyT6Gt38cKJ6/5f
 mVlHnUg4QdaTXgS2Et2EpnxGF7pdUI/f32VAyvaRRK3w2OvguZTjUWlYrt19ehQr0ecM
 +76k350ehiV0ljI3Bj3Ty+y66Lfd2zq2gGQfHQytBUjhfDd0Tgnzn/8qSErpIw4aMr1r
 /EtHI4lkgiKwFyrhBrNkEn2jIgruVc5DVP1yZGUtk1KIH8rAJgui5sqTwf9AtRd2aqzA
 EFxg==
X-Gm-Message-State: AOJu0Yz+Nfvl7s1tzqt3a0hWyrYY6FujLm5sOX5FdD6rqVe/xwR054Mb
 h+J6RPG6nwxq27qXvH49BozvZr1y5ZH9HMCWc2U1uILzL3baha4NP5P9YraigDQ=
X-Google-Smtp-Source: AGHT+IE44SiUf2EayXMLSNp9IlMoNPkvYpIht7i0bJ8o9Ppk7do+9TtLMW8sZSnHjXgEotRCQI2MCg==
X-Received: by 2002:a50:c308:0:b0:57a:4c22:c0 with SMTP id
 4fb4d7f45d1cf-57cbd6825a4mr6788652a12.10.1718616171776; 
 Mon, 17 Jun 2024 02:22:51 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da790sm6116966a12.35.2024.06.17.02.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 02:22:51 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Bryan Brattlof" <bb@ti.com>,
 "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
 Hari Nagalla <hnagalla@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Nishanth Menon <nm@ti.com>,
 Roger Quadros <rogerq@kernel.org>, "Tom Rini" <trini@konsulko.com>
Subject: [PATCH v1] arm: mach-k3: j784s4: Fix MCU_CLKOUT0 parent clock mux
Date: Mon, 17 Jun 2024 11:22:01 +0200
Message-Id: <20240617092201.30245-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

MCU_CLKOUT0 output can be driven by two different clock inputs:
one at 25 MHz and another at 50 MHz. Currently, the 25 MHz input
clock is not selectable due to a duplication of the 50 MHz clock input
in the mux configuration. This commit corrects the parent clock mux
configuration, making the 25 MHz input clock selectable.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm/mach-k3/r5/j784s4/clk-data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
index feaa13ee266b..793bcac93245 100644
--- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -134,7 +134,7 @@ static const char * const emmcsd1_lb_clksel_out0_parents[] = {
 
 static const char * const mcu_clkout_mux_out0_parents[] = {
 	"hsdiv4_16fft_mcu_2_hsdivout0_clk",
-	"hsdiv4_16fft_mcu_2_hsdivout0_clk",
+	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
 };
 
 static const char * const k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
@@ -338,7 +338,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(149, 5, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 174, "mcu_clkout_mux_out0"),
 	DEV_CLK(157, 175, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
-	DEV_CLK(157, 176, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(157, 176, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
 	DEV_CLK(157, 179, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p"),
 	DEV_CLK(157, 180, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n"),
 	DEV_CLK(157, 224, "fss_mcu_0_ospi_0_ospi_oclk_clk"),
-- 
2.34.1

