Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E971CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D872B83710;
	Wed, 15 Oct 2025 17:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E6/ab4ch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E217F8362A; Wed, 15 Oct 2025 16:32:36 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16988313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e504975dbso40833045e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538754; x=1761143554; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ft6YpEUUyQpMIMjtQb4mzXXMGUrMiVllGY4iEuw5Oyk=;
 b=E6/ab4chyOAX9Qfnk/bA+S2uyyvxOtmv/GQJwcZ28AY7vq6rV/2BSXUo1nPQA1Vgcv
 3A2SOZ7q/3lL/RACs3YHgxRPZJ4ZTdavVYVTTpJK4RmzEsTkAlpZcHJDJn6h8w+OfFaa
 Dufc/7DxbxHUTAlug4opRQ86pAgbgItfEApVryHqLE3Po9fNGFrcgVvo5SiBh3kaDN1S
 PP7hO27LtMThDR8DWMxxVim2kmNN7CzfPZkO3f0wgIeB3c42Lm5B5oArDuJ/hZ84Tc3q
 Npd0bzqwmjenkRzf4oJMBEV46nIIjRmzHiP1T0aTjVSGGIkpmGAbjOQ5ep4wQfWys1g0
 /wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538754; x=1761143554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ft6YpEUUyQpMIMjtQb4mzXXMGUrMiVllGY4iEuw5Oyk=;
 b=vWacxJu9ydiX4rqXn+63+jSPNE8dUwWAyAuvb5fbRo+afOstXzKdMGzI61FcMXowDq
 O6Ktx9n/GvPimL9Z0W5P2DJmIqnV2+dOlslo+BNrmBUN/7rxIRW+Qgso03Nt6y4MEuyN
 VlEvxCrbtHDnx42FrZH+YTiCAwpP2NxaatpF+8z5QC/8j4F7RrFp0eZ2PGF7+rDEQF9/
 /uJ2VxLxRmta1tc0ag6kUVpcomM+hAqxCvFHnRd9m0YIftThcw9a5WMS2LllcCM/qBLi
 TS7N8P+1UPrgeLbTfssOvaEMs0FcwtfFFkyOkpApJGwiE8W93nwiruA4sfKBF+yRNDM/
 nAdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuGcKJdkm64VQWcGnnYy9/veJYcEhC8O4U0DhLpdQ3VKdHi9DsVPG5NzIXIkApFAeedwpShrI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3bO0rL1OG2CYDSt76jYhUpn2SlEBDy1l5AEcvq8i0R9nG5H5n
 rCPc7jUTFt1WhVnerYtLuWvMqz5W33CyfeN2V33dKdDJN8AdsPTRuFgUXLEYsD7rT2Q=
X-Gm-Gg: ASbGncvMScEVM9R0cjImbUbH6/Ypi+ukzl6kB4GkNbrn0kU+k8D67iqRxG53/N97dIe
 AkkHemtl+z2fvqasPFdqo+piWVWJfI473M14WtjOmq0GGId2foR9yzjRbAb+eWMF8HZTLet2xzL
 tKWXFqVUt/8yNu7soPes8fAPhXtK5lfSE8SWpwD8S528xI0RYYEMXx977DTrhdUrQtXqE8Ao9rr
 lQLq9vBdrLILoIaj03cTJx+NnBOU+43adThyYyK9IM+4Ywba9U4HH15cqbAayXlc1mZtDTkmO9i
 +ocGGoC+FPpEmhRoBLhE/bsXU5SOIw1DDT+uXefiycCSM2tCqLj0TH6UiTtO6aI00GNRaR7IBMU
 ZKbRyjVJwHOd8swV1c4G109NtePlsIAv/gVwUT6e+Sde/BSOSiVnFbP45mcsL7eQ4ACxP9KBgEA
 HbB0OxCgmF
X-Google-Smtp-Source: AGHT+IGhjWYd2CQ0DhgHukvBFVnRXpKUvzKiYOh/QAsK00PN3zJO6feyK57Jo0s8/4iLtrm/BWvvOw==
X-Received: by 2002:a05:600c:358a:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-47109da54admr1640155e9.26.1760538754211; 
 Wed, 15 Oct 2025 07:32:34 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:33 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:11 +0100
Subject: [PATCH 06/24] clk: at91: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-6-5f80f827407e@linaro.org>
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
 drivers/clk/at91/compat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/compat.c b/drivers/clk/at91/compat.c
index 1d738f160b6e0881ac6ca6730e54f016e9899b27..ffc3168400b276a57f7dbe6f80f813571118cead 100644
--- a/drivers/clk/at91/compat.c
+++ b/drivers/clk/at91/compat.c
@@ -291,7 +291,7 @@ static ulong at91_plladiv_clk_get_rate(struct clk *clk)
 
 	ret = clk_get_by_index(clk->dev, 0, &source);
 	if (ret)
-		return -EINVAL;
+		return 0;
 
 	clk_rate = clk_get_rate(&source);
 	if (readl(&pmc->mckr) & AT91_PMC_MCKR_PLLADIV_2)
@@ -387,7 +387,7 @@ static ulong system_clk_get_rate(struct clk *clk)
 
 	ret = clk_get_by_index(clk->dev, 0, &clk_dev);
 	if (ret)
-		return -EINVAL;
+		return 0;
 
 	return clk_get_rate(&clk_dev);
 }
@@ -522,7 +522,7 @@ static ulong periph_get_rate(struct clk *clk)
 
 	ret = clk_get_by_index(dev, 0, &clk_dev);
 	if (ret)
-		return ret;
+		return 0;
 
 	return clk_get_rate(&clk_dev);
 }

-- 
2.47.3

