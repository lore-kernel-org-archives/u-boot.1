Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E17ECCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B8FB835D0;
	Wed, 15 Oct 2025 17:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PLOMpFnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59652834D4; Wed, 15 Oct 2025 16:32:26 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 335A48357F
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso5506216f8f.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538743; x=1761143543; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ma2chDb3vOw+DvVL+Elh8yWCMC9/MPlr8PtTT73X6dU=;
 b=PLOMpFnZWh/V2Wx3COVoiFL5ImdGTkbX6CzGDGQLzUFy+eVq3YvKpRQOeLmHt9vlHn
 F6vii8c85L5qdu8QNmwfDV33MVBZYuppA9S4jyGyPuZ6SQm2cve3WxqX3FGOK7wgf23F
 v/moWSNqihLCf5btGHo7g6OxOIiicC54lIHs+9rIl9M4Wn+2bR5bHMkENQjIhuCU0nY6
 v8IvdoL7wcWXQBd5q98amiRJZFKnPruDfIIwTh9zq22y9KZIRen2pwIEVhO/umpMVuDQ
 yszClXf+6xSCzWIMMhNvpt4ONIAFyp/NxjArRnWPBZAWmLrA2HQeI8px8KCaP9f7UEGo
 L+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538743; x=1761143543;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ma2chDb3vOw+DvVL+Elh8yWCMC9/MPlr8PtTT73X6dU=;
 b=elSGTPWNjlELyiWn33ksTMojERnT3nRXpkC4kmK/6jk4/TEbd4PLsGvZP/Afoi2POc
 oAQU/2I6s0+gVCIF68SYIHRfotWzDd5Vpo5mAwvU2OS4Gs5eSkxGuz0//k3FzBZTN64H
 BHiWyHeCRZVV2h9PnedkITIrcHy5QQw+9WPMi4i3NMGjPNQlStl/IWdtBRwjJAJNtmhg
 +c3fNUrBJ0Lq81MMrYxhOpNS7n50u4xhnQW4rc1vYssT5Q266UDyo72764jjGfBWPOam
 A4Ab7GXSsFLSFU8iB47TLbAS3k+0klpOJwOvuvID3i9aZRfMP14opzGPNb8aplZm+luB
 9FQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoUe8fmnP+dlNcbWxy/TMesSD8Ony3QxbwwryZJq6NT1OYOHZ3wBOIRBt6WDGIw/LgkmbkWZc=@lists.denx.de
X-Gm-Message-State: AOJu0YwiKLXNEG79WGOwY+AMV5b1jYZ1jjM9RxMTioAv0upWAUecJ05z
 MF6wkylIfX7H1YTAlmszl2V/9i3iQzDiC+KaCfPlDfY9abdU76MVsbGREpSPKlllJeg=
X-Gm-Gg: ASbGncse6hTUnPIP7WSMIti6FWJB2lMgHfsV1RfkwOqXwmEicoq/+7fPJ9ydVjOoizU
 o1HrGYcxxzDqYnLlTLtErUthvBNq8QeO/UTXKCEAVGIswVDV9PgFUhRjhSqOncTl2cCMwPgBdP4
 CUDSppOz8A2r4JPJQimCStzMMOHjmUYRy9uJN2AH0fMLl9S8W51/Jy6icaL9QCa5hrPsnhHBj7E
 L05a0rgYqO0V8lB8DuSJiJmcctCaEldNFy8zusdcSnv+g5USYUAj7nj4UEwRqCzJvbEk7TQv917
 ZXcTsOW+4Unesc0Ng0GdnNabaLfWjpoiAi3PmsPh5bKoAUdYd+Nh+jc1BUlTmL350uqAcCBf0hg
 bx6NXaT6lNGianVQ4Bh4ciyQxv1Iq4+CCmWUsK7KCG15O7NgIdAY0otvXe/DiL3zWCKXWncsg7a
 NvU9H9cUzj
X-Google-Smtp-Source: AGHT+IFxJ3tdTc9aXKyMZ7CBIzLF8xRR3KpTVUPPFRVIzybF4VytlYoKR7kxxnTeR6BEG36njzF8Fw==
X-Received: by 2002:a05:6000:601:b0:426:d80c:2759 with SMTP id
 ffacd0b85a97d-426d80c2f3amr10817335f8f.25.1760538743325; 
 Wed, 15 Oct 2025 07:32:23 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:22 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:06 +0100
Subject: [PATCH 01/24] clk: meson: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-1-5f80f827407e@linaro.org>
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
 drivers/clk/meson/a1.c   | 10 +++++-----
 drivers/clk/meson/axg.c  | 10 +++++-----
 drivers/clk/meson/g12a.c | 36 ++++++++++++++++++------------------
 drivers/clk/meson/gxbb.c | 20 ++++++++++----------
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index a1b8d79149102183402f470a60511d5300d0232c..78cad13239ca174a30f88cb2b18191cea74d6248 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -359,7 +359,7 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 
 	info = meson_clk_get_info(clk, id, MESON_CLK_DIV);
 	if (IS_ERR(info))
-		return PTR_ERR(info);
+		return 0;
 
 	/* Actual divider value is (field value + 1), hence the increment */
 	n = GET_PARM_VALUE(priv, info->parm) + 1;
@@ -402,7 +402,7 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 
 	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
 	if (IS_ERR(info))
-		return PTR_ERR(info);
+		return 0;
 
 	pm = &info->parm[0];
 	pn = &info->parm[1];
@@ -411,7 +411,7 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 	m = GET_PARM_VALUE(priv, pm);
 
 	if (n == 0)
-		return -EINVAL;
+		return 0;
 
 	parent = info->parents[0];
 	parent_rate_mhz = meson_clk_get_rate_by_id(clk, parent) / 1000000;
@@ -453,13 +453,13 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 
 		ret = clk_get_by_name(clk->dev, info->name, &external_clk);
 		if (ret)
-			return ret;
+			return 0;
 
 		rate = clk_get_rate(&external_clk);
 		break;
 	}
 	default:
-		rate = -EINVAL;
+		rate = 0;
 		break;
 	}
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index c421a622a587d2eddef70d28b65e560722cf7f62..e0b41811b0dfcc59f9a57366639ff2133209b697 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -104,7 +104,7 @@ static unsigned long meson_clk81_get_rate(struct clk *clk)
 		parent_rate = XTAL_RATE;
 		break;
 	case 1:
-		return -ENOENT;
+		return 0;
 	default:
 		parent_rate = meson_clk_get_rate_by_id(clk, parents[reg]);
 	}
@@ -123,7 +123,7 @@ static long mpll_rate_from_params(unsigned long parent_rate,
 	unsigned long divisor = (SDM_DEN * n2) + sdm;
 
 	if (n2 < N2_MIN)
-		return -EINVAL;
+		return 0;
 
 	return DIV_ROUND_UP_ULL((u64)parent_rate * SDM_DEN, divisor);
 }
@@ -171,7 +171,7 @@ static ulong meson_mpll_get_rate(struct clk *clk, unsigned long id)
 		pn2 = &meson_mpll2_parm[1];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	parent_rate = meson_clk_get_rate_by_id(clk, CLKID_FIXED_PLL);
@@ -219,7 +219,7 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 		pod = &meson_sys_pll_parm[2];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, pn->reg_off, &reg);
@@ -272,7 +272,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 			rate = meson_clk81_get_rate(clk);
 			break;
 		}
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("clock %lu has rate %lu\n", id, rate);
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index a7a42b2edb6a5b98612fb71fec6d17b1f3ab77c8..910b91e874bfdf6753ffc40bec7cd3a94e0b41ad 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -264,7 +264,7 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 		parent = meson_hdmi_div_parent;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, parm->reg_off, &reg);
@@ -273,8 +273,8 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 	debug("%s: div of %ld is %d\n", __func__, id, reg + 1);
 
 	parent_rate = meson_clk_get_rate_by_id(clk, parent);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	debug("%s: parent rate of %ld is %d\n", __func__, id, parent_rate);
 
@@ -323,12 +323,12 @@ static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 		parent = meson_hdmi_div_parent;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	parent_rate = meson_clk_get_rate_by_id(clk, parent);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	debug("%s: parent rate of %ld is %ld\n", __func__, id, parent_rate);
 
@@ -348,15 +348,15 @@ static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 			return ret;
 
 		parent_rate = meson_clk_get_rate_by_id(clk, parent);
-		if (IS_ERR_VALUE(parent_rate))
-			return parent_rate;
+		if (!parent_rate)
+			return 0;
 
 		new_div = DIV_ROUND_CLOSEST(parent_rate, rate);
 
 		debug("%s: new new div of %ld is %d\n", __func__, id, new_div);
 
 		if (!new_div || new_div > (1 << parm->width))
-			return -EINVAL;
+			return 0;
 	}
 
 	debug("%s: setting div of %ld to %d\n", __func__, id, new_div);
@@ -471,7 +471,7 @@ static ulong meson_mux_get_parent(struct clk *clk, unsigned long id)
 		parents = meson_hdmi_mux_parents;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, parm->reg_off, &reg);
@@ -560,8 +560,8 @@ static ulong meson_mux_get_rate(struct clk *clk, unsigned long id)
 {
 	int parent = meson_mux_get_parent(clk, id);
 
-	if (IS_ERR_VALUE(parent))
-		return parent;
+	if (!parent)
+		return 0;
 
 	return meson_clk_get_rate_by_id(clk, parent);
 }
@@ -588,7 +588,7 @@ static unsigned long meson_clk81_get_rate(struct clk *clk)
 
 	switch (reg) {
 	case 1:
-		return -ENOENT;
+		return 0;
 	default:
 		parent_rate = meson_clk_get_rate_by_id(clk, parents[reg]);
 	}
@@ -655,12 +655,12 @@ static ulong meson_mpll_get_rate(struct clk *clk, unsigned long id)
 		pn2 = &meson_mpll2_parm[1];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	parent_rate = meson_clk_get_rate_by_id(clk, CLKID_FIXED_PLL);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	regmap_read(priv->map, psdm->reg_off, &reg);
 	sdm = PARM_GET(psdm->width, psdm->shift, reg);
@@ -711,7 +711,7 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 		pod = &meson_sys_pll_parm[2];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, pn->reg_off, &reg);
@@ -851,7 +851,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 			rate = meson_clk81_get_rate(clk);
 			break;
 		}
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("clock %lu has rate %lu\n", id, rate);
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 51f124869c9c4043dfe047cf2f694bf59df7e87f..6dcfd084b8f93ade3fe1270db48f91f87cb61d26 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -306,7 +306,7 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 		parent = meson_hdmi_div_parent;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, parm->reg_off, &reg);
@@ -315,8 +315,8 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 	debug("%s: div of %ld is %d\n", __func__, id, reg + 1);
 
 	parent_rate = meson_clk_get_rate_by_id(clk, parent);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	debug("%s: parent rate of %ld is %d\n", __func__, id, parent_rate);
 
@@ -596,8 +596,8 @@ static ulong meson_mux_get_rate(struct clk *clk, unsigned long id)
 {
 	int parent = meson_mux_get_parent(clk, id);
 
-	if (IS_ERR_VALUE(parent))
-		return parent;
+	if (parent < 0)
+		return 0;
 
 	return meson_clk_get_rate_by_id(clk, parent);
 }
@@ -627,7 +627,7 @@ static unsigned long meson_clk81_get_rate(struct clk *clk)
 		parent_rate = XTAL_RATE;
 		break;
 	case 1:
-		return -ENOENT;
+		return 0;
 	default:
 		parent_rate = meson_clk_get_rate_by_id(clk, parents[reg]);
 	}
@@ -695,12 +695,12 @@ static ulong meson_mpll_get_rate(struct clk *clk, unsigned long id)
 		pn2 = &meson_mpll2_parm[1];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	parent_rate = meson_clk_get_rate_by_id(clk, CLKID_FIXED_PLL);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	regmap_read(priv->map, psdm->reg_off, &reg);
 	sdm = PARM_GET(psdm->width, psdm->shift, reg);
@@ -833,7 +833,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 			rate = meson_clk81_get_rate(clk);
 			break;
 		}
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("clock %lu has rate %lu\n", id, rate);

-- 
2.47.3

