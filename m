Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803F8CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08CA83881;
	Wed, 15 Oct 2025 17:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ukueOLgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E4EF834D4; Wed, 15 Oct 2025 16:32:54 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 236B58313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so5137555f8f.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538771; x=1761143571; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c2Ex94fmhlLv2i2Yx1QhQ917Ez/zRaZdOvJOV/zm02o=;
 b=ukueOLgIacMJcUUniqN3HdUPGX545SotpOKeB96aOqeFkXditxDjI5TgtSC5jkLJO1
 c9TJZjHQzkAWYskXT/+pScv98iD5vW/dE0S63iDVVCoCYllDn505e/76mxZTc45YnG8i
 3RW+tgU7wtVeATak4dRW1y1JlT7wWdCSnjk3AWy+b8BPxPEDBBVDD/OqkHlzQyhdy7Rj
 gr4GQrcxmfraiCvEzEKmIPxPseeJU4kQiEkUhmNCpCYV3+jQ2IQRlHZFrSucHCCF2bJM
 z7nYeWfbnS1GxkSSqaB435wp3LDxg1dFfQczfqe/Ly25St/87SFWAj33uM+mWRJsRNBk
 7q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538771; x=1761143571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2Ex94fmhlLv2i2Yx1QhQ917Ez/zRaZdOvJOV/zm02o=;
 b=grtfmFpTcjhnPytlGtOrqrb8wLUov0IS3MOoJ2XYwhbuUbjiTu/Ts8PUaroLuEAApp
 hrRhWpGFObWEX6flbFSjy5sYTu+55GbEv5S9U/IxSBbVFcz85/2WfqP+qc6c8/swgvI9
 r79arZfGnmfyTDtOwBg3lz+adOGlzKhLwSPxKJOAb8kjlgKR5sXHHuFID96qk/dRd8iq
 x/z8bFLWVwGzd6VKfjtDCG4wLgZyzAxUisvbgMkggZsx39HriXY1gLFPVdcTxYYVRCN3
 Ea92AHPeeLXHJrwC3hD2amC6uyxs29krBNSiLbovO3v8y/zvHkBmGsd1U1d076/STnZ0
 ZT7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyzaJfIjvnFmBtWsAtZB+286/coqpQelcZ1jTI+/vkh9wEg3K3AO5+adIf48KrjCwE+K4h9Y4=@lists.denx.de
X-Gm-Message-State: AOJu0YyM7qLmfa5eIXtScWcFOF1AlbjKLkx62RxL7AqyKxFyhVPlJ5nt
 uxlLtNRolVAYOly4Vl2Zu07DNG4ZtPLEsPWQv8Rw/FQsotiTvJ5bjHt6LzPs09dtWws=
X-Gm-Gg: ASbGncuSJVTmHyoWxDvTpAnd5qE9BX9KLe7Co1+gEv/QRCdaV9sQ9ShQXB7QngQCIM3
 Jh16c4iwboeTqzUncUd24ukrDVy5xBsCW7LFNbMgf4sn6ADlwGN1Q74X68V7o+fBB8PfOQjh6ik
 bCbrGKD5inM/b2Kkt23/Inqpdpvdl+St4h4Fr6eauF9EK7163pPYSr5no7TK6EMFUAfJzforume
 VVCTEQG+ij96bfHSDGdzp3K1u5Vs+DOcYT26ESwGFwZgUiMWhKognNIR0Wl2S9r6oD/vGuGhHjF
 /f1sijLRVg5NErJx9EaGD0+Ox4winPNyUACvdUmNKwhZ4aLsNOrpuVbhkdYPHEYC0hGrYwnPezG
 8yUErzXJnkJVSpmoeQDfdEcYMi/PKukAQjcpbuPs6v41PnWSx4dRHWEPxhDraGMh0+vRvrMXeOe
 Fsu70IeEsf
X-Google-Smtp-Source: AGHT+IFntIZgc8kpwywcm6Ac1YodmDRVT9uEaIFSPv2xMkytU2MPV98wALWC7FxueiIlE7bJN1OwyA==
X-Received: by 2002:a5d:5d88:0:b0:425:7e38:419f with SMTP id
 ffacd0b85a97d-42666ab867amr19302858f8f.16.1760538771388; 
 Wed, 15 Oct 2025 07:32:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:50 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:20 +0100
Subject: [PATCH 15/24] clk: exynos: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-15-5f80f827407e@linaro.org>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
 Dai Okamura <okamura.dai@socionext.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Heiko Schocher <hs@nabladev.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Wed, 15 Oct 2025 17:55:48 +0200
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

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/exynos/clk-exynos7420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/exynos/clk-exynos7420.c b/drivers/clk/exynos/clk-exynos7420.c
index 7de4e688f036d47adfa22c841400770b1b1ed3b3..494f5623259945376475c53dcd8d5b5fbf635b0f 100644
--- a/drivers/clk/exynos/clk-exynos7420.c
+++ b/drivers/clk/exynos/clk-exynos7420.c
@@ -199,7 +199,7 @@ static ulong exynos7420_peric1_get_rate(struct clk *clk)
 	case SCLK_UART2:
 		ret = clk_get_by_index(clk->dev, 3, &in_clk);
 		if (ret < 0)
-			return ret;
+			return 0;
 		freq = clk_get_rate(&in_clk);
 		break;
 	}

-- 
2.47.3

