Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56E9E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14C7801EB;
	Thu, 12 Dec 2024 11:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fB6QRdlc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4485B8021C; Thu, 12 Dec 2024 11:13:44 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E46D801FE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f367f97so663529a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998421; x=1734603221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xF3oIZ1wF4BlR1VBW/qGZezsXzyulrucvgoiMOLezs=;
 b=fB6QRdlcX4g/I71F24SwqsUkdRMqol8Niz0J95x0Q92EC46ccDxhPmTSEBfGo8u0iW
 erVOByCIXtCqwNM9Fcwx7IZSUNfu5tMH8aOzTPdWo9UAmiXqav7eXce2+Hlt7ABG3xUn
 dCAkE9zSMmdI/kmLoRbGBj1lBP3AjCmeIBb9H0JqzDpD2I+hC9hTldxQPJ7OOJlKzQm/
 KTgkD64SFOIpN1fK6P+XTiWjhWaae7nWJLzkuulJue553iMr1JsXklrKxmIxLqwA2gk/
 xsDdJCRy0Uw8zMlEansIkvlSlD/BRA5VQH9XJfQUqCu1l9lEPqA5w2rHR1CwWAvSzYNY
 TmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998421; x=1734603221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xF3oIZ1wF4BlR1VBW/qGZezsXzyulrucvgoiMOLezs=;
 b=DIWKVHLf8BaWyskNBGvQ5C1eQROjWTZ7y/nj61vgDSrc/TrYPnJ6MNf6bidj5pCqli
 hi2vZdxfUp6KRedk4IQGDyibeKQ6FKSJ8ioJjAaWXbVxJ9ve8pKy2Byze3c9W1BE/RdH
 d+at3CjaeQeGVxCuq0CvBiY0QOSu6Uqsh057cDBhNz2mH5/vfou1j04cTXlMgZvaU+rm
 3t1of4A1D3otaW748cmXZTz604GhCLwLn3HT98w2V/xjz583IpDomR8akhi6WFN/Fbgd
 RJe1E4RGVEZ5Qwb9thN+GFo91en/iZT2XwfLTY2Ld7XcTCSke4vYKvU1+C/E64qjJ5DW
 RiIw==
X-Gm-Message-State: AOJu0Yyn5zGjekUiZVPlNGs0oh37i7GHWmMsrj6aYybNfWHsakxXq4NG
 UpRVxhtAqxplcXnNUXL4t2lqhlGpxGGwbNCMa7eFUBbM0Q8Q3tPX
X-Gm-Gg: ASbGnctEWG1Kxp9PFyr3JmoEqsz7TMbDrugPbQ2Ek4uVzr2kAhBOwt8ztTHTA0jUZON
 XaM6NEzupaMkBNjo+vzXjmVDvkUymuaiQqEa9ZugU4gXQrBGYkLypHf2mQyMoqfpwMezEcQZ6hK
 dfehCZ+FJY8fxGAjbyKGI3Yjw28jJm5G7ex12/E6Q6hFkCw0UMr2lSvvMcGnEqUkTh0b5hzFPAg
 Ncpax58xhy/eGgUr3V4CnShFkKvHrXKeBaN4jXNlcC9Cbg+
X-Google-Smtp-Source: AGHT+IEbj8poS2vmO/wsvzJe4gJUD/SbV20PhyyRYFhRc7IUMeaxMl9sPgXSAMuQfp2bbQdBRC5ybg==
X-Received: by 2002:a05:6402:1ecb:b0:5d0:cfad:f6c with SMTP id
 4fb4d7f45d1cf-5d4fa2b2a0fmr390052a12.21.1733998421119; 
 Thu, 12 Dec 2024 02:13:41 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149a25cdcsm10192647a12.9.2024.12.12.02.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:13:40 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/5] ARM: tegra210: clock: implement PLLD2 support
Date: Thu, 12 Dec 2024 12:13:28 +0200
Message-ID: <20241212101331.6135-3-clamor95@gmail.com>
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
 arch/arm/include/asm/arch-tegra210/clock-tables.h | 2 +-
 arch/arm/mach-tegra/tegra210/clock.c              | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-tegra210/clock-tables.h b/arch/arm/include/asm/arch-tegra210/clock-tables.h
index c6d7487e629..5c4d7fc84c4 100644
--- a/arch/arm/include/asm/arch-tegra210/clock-tables.h
+++ b/arch/arm/include/asm/arch-tegra210/clock-tables.h
@@ -24,6 +24,7 @@ enum clock_id {
 	CLOCK_ID_XCPU = CLOCK_ID_FIRST_SIMPLE,
 	CLOCK_ID_EPCI,
 	CLOCK_ID_SFROM32KHZ,
+	CLOCK_ID_DISPLAY2,
 	CLOCK_ID_DP,
 
 	/* These are the base clocks (inputs to the Tegra SoC) */
@@ -37,7 +38,6 @@ enum clock_id {
 	 * These are clock IDs that are used in table clock_source[][]
 	 * but will not be assigned as a clock source for any peripheral.
 	 */
-	CLOCK_ID_DISPLAY2,
 	CLOCK_ID_CGENERAL_0,
 	CLOCK_ID_CGENERAL_1,
 	CLOCK_ID_CGENERAL2,
diff --git a/arch/arm/mach-tegra/tegra210/clock.c b/arch/arm/mach-tegra/tegra210/clock.c
index 57ff0b2a19a..04708f97144 100644
--- a/arch/arm/mach-tegra/tegra210/clock.c
+++ b/arch/arm/mach-tegra/tegra210/clock.c
@@ -668,6 +668,8 @@ struct clk_pll_info tegra_pll_info_table[CLOCK_ID_PLL_COUNT] = {
 	  .lock_ena = 9,  .lock_det = 11, .kcp_shift = 6, .kcp_mask = 3, .kvco_shift = 0, .kvco_mask = 1 },	/* PLLE */
 	{ .m_shift = 0, .m_mask = 0, .n_shift = 0, .n_mask = 0, .p_shift = 0, .p_mask = 0,
 	  .lock_ena = 0, .lock_det = 0, .kcp_shift = 0, .kcp_mask = 0, .kvco_shift = 0, .kvco_mask = 0 },	/* PLLS (gone)*/
+	{ .m_shift = 0, .m_mask = 0x1F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
+	  .lock_ena = 22, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLD2 */
 	{ .m_shift = 0, .m_mask = 0xFF, .n_shift = 8, .n_mask = 0xFF,  .p_shift = 19,  .p_mask = 0x1F,
 	  .lock_ena = 30, .lock_det = 27, .kcp_shift = 25, .kcp_mask = 3, .kvco_shift = 24, .kvco_mask = 1 },	/* PLLDP */
 };
@@ -939,6 +941,9 @@ enum clock_id clk_id_to_pll_id(int clk_id)
 	case TEGRA210_CLK_PLL_D:
 	case TEGRA210_CLK_PLL_D_OUT0:
 		return CLOCK_ID_DISPLAY;
+	case TEGRA210_CLK_PLL_D2:
+	case TEGRA210_CLK_PLL_D2_OUT0:
+		return CLOCK_ID_DISPLAY2;
 	case TEGRA210_CLK_PLL_X:
 		return CLOCK_ID_XCPU;
 	case TEGRA210_CLK_PLL_E:
@@ -1276,6 +1281,8 @@ struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
 	case CLOCK_ID_EPCI:
 	case CLOCK_ID_SFROM32KHZ:
 		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	case CLOCK_ID_DISPLAY2:
+		return &clkrst->plld2;
 	default:
 		return NULL;
 	}
-- 
2.43.0

