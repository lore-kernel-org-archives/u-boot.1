Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F3CCCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE6483695;
	Wed, 15 Oct 2025 17:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="arQ1KFpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A648313B; Wed, 15 Oct 2025 16:32:33 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FEAB834D4
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46fc5e54cceso22355515e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538750; x=1761143550; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XIQysIx4KJugzMwhq25Do8V3rR1hN0bWenENxg6QWqg=;
 b=arQ1KFpvLWm7P0JrXO9SB0fdVfpM9pC6LG32fwR79o2iTNZ80nDFOdBXTy/l5XHIt7
 V4zDnzHWjACxeRulV5kmqo2KQGWfI33tmqyNeh1aEq1WKkaf20fbWfZ5pcnOODjjiesr
 aVeN0HiQdajUmvXPbt+ruE+i7OxtTUk/8S1B/rrec1jBiaPnDi+4Vci0Tjh6ISg3DKTK
 JndYWMsOG/uv9TSDV4zLaA7PoB74jWD1faItUnN0SHsZ0BO8/A/mF44KLXMxYf2+n2pg
 HFF2YWOADvLetmLjTDREHSoyasod06FS75Nzq6eLTU2LvWkKJttkupv5zLPcJIrQI1uH
 Nk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538750; x=1761143550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIQysIx4KJugzMwhq25Do8V3rR1hN0bWenENxg6QWqg=;
 b=eRf93WH8f121JuJu9xMPCfTDp+d/to4gh+p4W+clmblzimLeh+k7BkDjzBxEoF8aNg
 3Yb3Er1Vo9m9HXLTjmYS5GqmB5Jps1DjtqCS0yzTTV+nbo+17Jb5U/nHwjmb6VU9NUuS
 /16GqQ6sIZmQZ41S/b9KFsFVME/kn1PvNnLGiSqk/q4gzSAyKogDBuTKlxuXX2cOGcyc
 Y7TXoEUgo+ZBkhvkNCIpxDi7ufBYdk5j1ZslNR4AXx9K0oUv/yW+ifTtLrvuivLpGMze
 r5740AcV2Cy4JpV8v97hoa/XgjMdT6kaK4FbPExROoBeO6Ond9KE/fA/9txIU7PpkC4x
 NFhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIQyGty++m7CXvqNsiCZctJHcjItwhm2b5zYFk/Rh6zB3syOAh51vOi8PCzAXEnYzynlv9fao=@lists.denx.de
X-Gm-Message-State: AOJu0Ywgxo/EGhcaF94KjRtt3dZS2xNikEblm2LWfg2SV7yqnVScH4hB
 A7A67Hk3Sg7wYL4JkGPUhbG/DXWNcPEk6lsHj79L2+qUmfVrQCOftnlenb7gxQotf/Q=
X-Gm-Gg: ASbGnctF7eYT9GVKkImT0LjBvC6hI2b1BmVe6eIpxYwsSH/VjWuJsr8WtYcVbpJOUpD
 88zBebCCi2tcp75ixVhtNw7p/R15LPytOSgp7ilABw5jDlO6gEJeLF0tXuEwF5uzGoe1B/qTV2M
 go02DUJfrXLPdsFwfAg6yd4CemJKkNVUifxBmkWHOz2IVpBF7ap74GoE5K530Muin3jIIh6Ctsg
 2vD+UGBi3SC0cLJwBjcro74d67zvt8LfGGtnumKJKEHlkYJgX1ak5PLigU4+byNgdfHkMUjIniV
 nbCLEXuaPQu+9qkL2LxlxfnqiX/i9qJd+gddj9sxfUtK0kDiXVLK9Wq6sIDNuwGFLiwbZVqIcWH
 sBRd1gPTckw1UVpeANESFY/1IBQ+mk/QytrB3BRwgzaWL0ZiRgeFO6JCxYR4FeGeRhxBVNmOwVJ
 rmUyiWHJ/WHFseLqLpCBk=
X-Google-Smtp-Source: AGHT+IGf5GpcS+S5beWQTbh6N/+mYXSMKn3Cif7lbjfUlCZ5iEsIZ3P/e9T/0Yu9aiD1g4OPovrjJA==
X-Received: by 2002:a05:600d:8110:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-46fa9b09233mr207794075e9.28.1760538750432; 
 Wed, 15 Oct 2025 07:32:30 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:29 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:09 +0100
Subject: [PATCH 04/24] clk: thead: th1520-ap: Remove negative error returns
 from clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-4-5f80f827407e@linaro.org>
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
 drivers/clk/thead/clk-th1520-ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 6899e1b595a7148a118d3a615d5dfea4b4fb5b96..e913621967eb131b534e8f5b928687967a02a30e 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -985,7 +985,7 @@ static ulong th1520_clk_get_rate(struct clk *clk)
 
 	ret = clk_get_by_id(clk->id, &c);
 	if (ret)
-		return ret;
+		return 0;
 
 	return clk_get_rate(c);
 }

-- 
2.47.3

