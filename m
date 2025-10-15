Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFD1CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EE283857;
	Wed, 15 Oct 2025 17:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fQUaKVXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EDA98361E; Wed, 15 Oct 2025 16:32:50 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA388313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso38312095e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538768; x=1761143568; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X3kPH94duDXi2y0uFSPhGXlr4nkQRpFgaC0tEk4x3qc=;
 b=fQUaKVXUU+isI+lCD/xzMCh3K2MuTBE/rnoMI1ygVJG7tJ2hkhE0qVM1QgK5j06DgU
 rA5cbrJDKDJ6pWlVODmS2v7pBSPNsXJ6rdAtCSviLhX73pCgem+4Rp27+WlrZUXvNawJ
 lNQ8FZOoCEm+/RuPX6L+pDqOFaKs1G3ZsdDIyisYF/mjkA4B+uBljkWWgVgUpa4Or7E8
 NwYVdezEjbQ/wxR7ref2/i6CWuRPHrmp3Z7QkxcXtUen8wRblCDX28BynzHNukhosd6T
 xlcxPt4XhS7I8NobjEVI6k9untUwWa07K65WGJXNeE5bD+HX+us6ItXEnDffRlbJL+1x
 NjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538768; x=1761143568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3kPH94duDXi2y0uFSPhGXlr4nkQRpFgaC0tEk4x3qc=;
 b=rp5zYcsvHYR9jV1LCSowsKaBZg+VFoIk+wrp1jvF/WNx+3lOnRn44N7+FVOCliNIsy
 N1mKkKgEkFYqd4Iy6Glu+oQU+eVUki/uTYfvmvCaSK62oA3sSDXbf6QHecBqsJtHYVBi
 WX4V6v7Ls6Yd8dGsQid08mEWKN2QOXC1TrrQrAccBerm6rsXTeV/PHLDnsCVLtwjxKF1
 ssWUFSp7HhH30PaEk2339If0kwLzxy/KiIgxUlxN2cfkiJg0uS25lpmAhM3HZt3Lbh10
 f9MMGD5B2FO5HX/gxBic+36xV0JPjNirMmhnbKPaFQ8gK9ttvmgV7yynhPZXGgOFuN4Y
 BULQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMmyCFCYvxHwHOoSMBa8mXuG4RoQNktg7FGGUkZtdm8+Pmq8xXjV3SzMPo/GAW5uIUzPkvYAc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj5Ihh+xnB4m25aOQcpC8uH//kViWL+xLLCSRrwNUA1O2YIzJ3
 ojncdmdjOK3xPwgh9YSlaHQ0kkZ+OjIksnt6EpRMWtj4ibQI99gwDVsq1weS+FthO4g=
X-Gm-Gg: ASbGncsGyHWut140hn31NEH1vJ2aGNolmBROXkTatQD1mFMLVf1NheQWfgeNnxVFz91
 MUVNzk0Cg/UhWZCADPZEQOBP5aogHk9K+Cwiov3Q/tN/v3JgWcHq6rnaooC6+5+Dq1IlJlX3U2g
 WkHsF57/P0zLGPod+sU2YFw8gYW35Sc4CrkELkWITpkRisxfT3Gu1Q/TFmhM2RxXTg7a7OvQB09
 J2X801QzyJgxqpDAyg0Pc+HtbQ8NHtl2RzfjQaofCT3XHV2fRPhr18st12iWqYjjfckkXuqORnY
 OFLXyHwzXKBPLa5MSYIA/sMIVuiimf5YuzzZ8apVYJzgUdGtd8ID5xKQ8p+loVnn/mLWPh6cBxz
 Jvm/u+BwOAQqEdpz7SjsAjvf1QFxNQu1FzxMssr2FYiegPGA4WINZx8wNFgrbTFHZlLElLLu+Oq
 5Sp2Wrh4M8
X-Google-Smtp-Source: AGHT+IGjcPz60CY/ty2SwUER5zMHoK+uFYCxXPg7myYGlDxDfj3NBnrrq8j+DbTUrNlg3QcTBQ5jwA==
X-Received: by 2002:a05:600c:3e1a:b0:46e:1d8d:cfa2 with SMTP id
 5b1f17b1804b1-46fa9af9842mr182565155e9.20.1760538767482; 
 Wed, 15 Oct 2025 07:32:47 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:47 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:18 +0100
Subject: [PATCH 13/24] clk: aspeed: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-13-5f80f827407e@linaro.org>
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
 drivers/clk/aspeed/clk_ast2500.c | 2 +-
 drivers/clk/aspeed/clk_ast2600.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/aspeed/clk_ast2500.c b/drivers/clk/aspeed/clk_ast2500.c
index a330dcda4dcbeeb602f7210e262f88e64ab99623..3ad47b9e19117eb888666087f5f3fa32b0f588d7 100644
--- a/drivers/clk/aspeed/clk_ast2500.c
+++ b/drivers/clk/aspeed/clk_ast2500.c
@@ -197,7 +197,7 @@ static ulong ast2500_clk_get_rate(struct clk *clk)
 		break;
 	default:
 		debug("%s: unknown clk %ld\n", __func__, clk->id);
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/aspeed/clk_ast2600.c b/drivers/clk/aspeed/clk_ast2600.c
index 535010b7941484804573279f90226c2641dba034..8a36356c40f75abc799f71eb66c554a7caa1eab2 100644
--- a/drivers/clk/aspeed/clk_ast2600.c
+++ b/drivers/clk/aspeed/clk_ast2600.c
@@ -471,7 +471,7 @@ static ulong ast2600_clk_get_rate(struct clk *clk)
 		break;
 	default:
 		debug("%s: unknown clk %ld\n", __func__, clk->id);
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;

-- 
2.47.3

