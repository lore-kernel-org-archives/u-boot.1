Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D4CE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563F480200;
	Thu, 12 Dec 2024 11:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2/Hqr0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3856C80209; Thu, 12 Dec 2024 11:13:43 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37098801DB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so579650a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998421; x=1734603221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzVzfd3GPpiqfCYvFbZQh1ICTCfb7tuLubuMWuz3TVw=;
 b=C2/Hqr0hGmYVdsIL566Thq94HcjmJN+L+mNRMNyxo76iJEJQ9kwvmugWhWQgNFMkhV
 /r5C3S+kaX3TQEIEqF9KXTAtS13Enpb4cm9toWo3NAzvd2ZJXkyrQ72pGlKK/yMXDYNg
 1K6UmXnSF/FXd4NO61n2JqyISPig63eHbP1/qzwIm6LNzxxAdfPGzZrqUawhXbEI7HZ9
 wa5TmQE2vs+JlXwj9spApmdyx3FalrBF8H0mE3AFPENnR8rfW35zOmqSkcN7a0JIwPj/
 tqWN0vVyqW/rF7dUWbpHhL/R5STLK+9TRgyf7UGlks5ZSvk4CX0TQq4RJq6hUSKgd4Pj
 TuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998421; x=1734603221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzVzfd3GPpiqfCYvFbZQh1ICTCfb7tuLubuMWuz3TVw=;
 b=kdf1sc47Oer3XhwWclcKEKj+4BTKlDuoEZZf1Tp815gYSyHVxflIQly7azTvNu4KMm
 UyFiIrX0mUAcSBRd0IJHtiTUnkIuuQNVHfIMWSS4QI74NnQwxwTo+WhQHFaXqfqnLpEC
 iXhgpISWzCvzJo28tex2qX5D0mlxKZrVjfUBWOqrKjnKXJ9FuRBLaMz7Vw7dIsI+Vqlu
 beYnxyF7jEBMmugnB36T2XwsWqKLA8wIxXwJTx+0vx5EQQcU86q+TScAV+4Uk7Acddil
 ThGWQ1vLEsuuJ4bCKcOfP9oF1pn7SXu/0djUO0cVgvb4C5+Fn3fi70OvoLsG8KBg8eK5
 IObA==
X-Gm-Message-State: AOJu0YyExGE6PfJNGEz1bsZQiGO4D/LJgLE0bPtDI38CqVXcScuDDoyE
 Y/uEYAOQdjnhg5Ir58Lxluf8uYD5iDgWh8+ivGtNzoFeW5/UVrXP
X-Gm-Gg: ASbGncs6ciJKErc37L8aKfTXYg+tjqLc7WTaAFIknEKdOnh6HMhN2l9TSbPxVsi3SrI
 kvByDEsBN5dQhf3FYpMPCpya76Wc5+E6Xfdu2q9j+I/pTDi7dP2l7RahAPwGPMM8GSo16c/hTCA
 dQhFygqW79noapsttRsJvt7etiIYqt10eN33facGQp+OeJfISG4OJfxG9iHsGUAgzmwD+xcIyCD
 9ZmDqSkFAN4BoMFCbXQytLdvBPJ5xZQu595NBzRizRWjxQv
X-Google-Smtp-Source: AGHT+IGmbvpmOFeCxWvsPU6UjtIYIjuGcxBxi7lFoy9rUX8tj98SaqzmVBVhVJw5++YbHIrXI+6kpw==
X-Received: by 2002:a05:6402:278f:b0:5cf:e9d6:cc8a with SMTP id
 4fb4d7f45d1cf-5d4edcdeb93mr504523a12.20.1733998420374; 
 Thu, 12 Dec 2024 02:13:40 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149a25cdcsm10192647a12.9.2024.12.12.02.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:13:40 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/5] ARM: tegra124: clock: implement PLLD2 support
Date: Thu, 12 Dec 2024 12:13:27 +0200
Message-ID: <20241212101331.6135-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212101331.6135-1-clamor95@gmail.com>
References: <20241212101331.6135-1-clamor95@gmail.com>
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

PLLD2 is a simple clock (controlled by 2 registers) and appears starting
from T30. Primary use of PLLD2 is as main HDMI clock parent.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra124/clock-tables.h | 2 +-
 arch/arm/mach-tegra/tegra124/clock.c              | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-tegra124/clock-tables.h b/arch/arm/include/asm/arch-tegra124/clock-tables.h
index 9f531253153..055948ec07a 100644
--- a/arch/arm/include/asm/arch-tegra124/clock-tables.h
+++ b/arch/arm/include/asm/arch-tegra124/clock-tables.h
@@ -24,6 +24,7 @@ enum clock_id {
 	CLOCK_ID_XCPU = CLOCK_ID_FIRST_SIMPLE,
 	CLOCK_ID_EPCI,
 	CLOCK_ID_SFROM32KHZ,
+	CLOCK_ID_DISPLAY2,
 	CLOCK_ID_DP,	/* Special for Tegra124 */
 
 	/* These are the base clocks (inputs to the Tegra SoC) */
@@ -37,7 +38,6 @@ enum clock_id {
 	 * These are clock IDs that are used in table clock_source[][]
 	 * but will not be assigned as a clock source for any peripheral.
 	 */
-	CLOCK_ID_DISPLAY2,
 	CLOCK_ID_CGENERAL2,
 	CLOCK_ID_CGENERAL3,
 	CLOCK_ID_MEMORY2,
diff --git a/arch/arm/mach-tegra/tegra124/clock.c b/arch/arm/mach-tegra/tegra124/clock.c
index 4ac0c10c597..0ea212f80e2 100644
--- a/arch/arm/mach-tegra/tegra124/clock.c
+++ b/arch/arm/mach-tegra/tegra124/clock.c
@@ -598,6 +598,8 @@ struct clk_pll_info tegra_pll_info_table[CLOCK_ID_PLL_COUNT] = {
 	  .lock_ena = 9,  .lock_det = 11, .kcp_shift = 6, .kcp_mask = 3, .kvco_shift = 0, .kvco_mask = 1 },	/* PLLE */
 	{ .m_shift = 0, .m_mask = 0x0F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
 	  .lock_ena = 18, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLS (RESERVED) */
+	{ .m_shift = 0, .m_mask = 0x1F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
+	  .lock_ena = 22, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLD2 */
 	{ .m_shift = 0, .m_mask = 0xFF, .n_shift = 8, .n_mask = 0xFF,  .p_shift = 20,  .p_mask = 0xF,
 	  .lock_ena = 30, .lock_det = 27, .kcp_shift = 25, .kcp_mask = 3, .kvco_shift = 24, .kvco_mask = 1 },	/* PLLDP */
 };
@@ -852,6 +854,9 @@ enum clock_id clk_id_to_pll_id(int clk_id)
 	case TEGRA124_CLK_PLL_D:
 	case TEGRA124_CLK_PLL_D_OUT0:
 		return CLOCK_ID_DISPLAY;
+	case TEGRA124_CLK_PLL_D2:
+	case TEGRA124_CLK_PLL_D2_OUT0:
+		return CLOCK_ID_DISPLAY2;
 	case TEGRA124_CLK_PLL_X:
 		return CLOCK_ID_XCPU;
 	case TEGRA124_CLK_PLL_E:
@@ -1194,6 +1199,8 @@ struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
 	case CLOCK_ID_EPCI:
 	case CLOCK_ID_SFROM32KHZ:
 		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	case CLOCK_ID_DISPLAY2:
+		return &clkrst->plld2;
 	case CLOCK_ID_DP:
 		return &clkrst->plldp;
 	default:
-- 
2.43.0

