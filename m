Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CB5CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA5E3838D2;
	Wed, 15 Oct 2025 17:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yEIA1E0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A61835B0; Wed, 15 Oct 2025 16:33:03 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A78808357F
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso3018465e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538781; x=1761143581; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TTbXf2v+6DOITANdOMYtay+m9aD8F7IEVVIpnQ+2pPc=;
 b=yEIA1E0Wu5G58Pslk3QXJiwHSqnMl0wr9YyPuUT23eVOkUY6rVE/mt86Xn1qBc5XrL
 0Wo/Sj6Wgf6htYfFMRFuTpISrqdG3XRCgij1ycsvs1BD4MnudlZq/Z2UahKUvtJU2kMy
 n3IIqeDTZrtOcR0ExWP7vJSlmYoejJ0Eov3+NlCBuCXAfGjvmQTgnQhG3ROGAoE3/T0w
 6r3y7R59pfGgYN3NtlWB8uUMIy7BXaOzGiJoLz2Z+NvBnYQz54EZMIhc3GWEpjBlLeWC
 oTmBW5xDr9E4+EM/tLHhDe9KWBeXeHtjoarLcguoCnlrX7dsjou8LHJOOb2WuExqjrvp
 1q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538781; x=1761143581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTbXf2v+6DOITANdOMYtay+m9aD8F7IEVVIpnQ+2pPc=;
 b=lDbubA5FcanJYFdgjfGMMnUTTVFcaG9Nj+uowoRZ29i3AQ7ElyoHAf1F7RNG7A/MLZ
 FZotT5sj0oth8bCRAliaaJQa0Ek8j3QrqbVgrZlONalV/MfB09LtGjBnOmx05AQ0A8Ob
 t+6doRFgq/fnIcZvNhbJLamiqdqWyhwenIxn7r58yVUx+JsPxruJTSxGphyk4Omo0BNX
 qns7W7bg0lPI2PECoatzSU9qPHjQsctaKN4szJSnQITtHtd9LfZfBroD0tJM6ubxl560
 DIm4By5pa8B1hAaTe/fLbRfHGsz01maUOKrtJIOlINVx9h4UsLRMnJXCnPn+UPa5LHgL
 eYIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7agkZASYBMxvJDoYT5v/A/6e0BkZ4Zs7g339IMA6qV1JQD3uqFokZWSA+0+9hI+r1O0onNK8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywda8i+sK0eESJbRrQw/oO45/GpmYjD/GAggDgsMQWUG4t8zRRH
 hL3jBA5RoKvmbadaEsG4aNU9ZdHlzu7xcek1l40LwgzllqQiFNFE4AS2j0OUvqudiCU=
X-Gm-Gg: ASbGncuMCZJigWiz49A88rAzG+CzCY3BWcZ61oSKW/wCX0fbElTVizFH9cVbaaXW0NJ
 +JGJ/fjjtg8zkTlbQbYgmM+g+jQH6+Ya5Whmc3RUme5sg2ldmIExf92EJmJMv7NaqFfTfdmvrSq
 apICBBJMtPPgY8XP882uYuMtLkhJxV2q7cX6eYLm2db8OrAlUwDLoGKWygTv0YNxCqpGqHnlHh2
 PzBpF7uNp73YjvklbDtUxMU28ORgFw8TMivKmEhXsKcujlQako4Uo5PtWTJIczo9NcHaqK5Em/e
 SAq2IEM/Np+CK3VLL/Leyau1CYGD06FSvUjZmgeCIlbabYtXG3EQSR05hWaVd/r5S8ZOhGjYak4
 aVzC7L0Q6OIk50EzthbfkNKkwRvqSK53YQFVURr2uOYlbbkWMojtaPd7ve8Kim3kMNpwddi3EJC
 T9DKgLu2K7
X-Google-Smtp-Source: AGHT+IH+rwZaZc5p0en/wUvb43r51I+4D/Ojes6xOI2/lEb1mRkkPQW7ty8WKdlM7v8kZME/V1yKwg==
X-Received: by 2002:a05:600c:35cb:b0:471:9da:524c with SMTP id
 5b1f17b1804b1-47109da5403mr1337285e9.12.1760538780882; 
 Wed, 15 Oct 2025 07:33:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:33:00 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:25 +0100
Subject: [PATCH 20/24] clk: tegra: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-20-5f80f827407e@linaro.org>
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
 drivers/clk/tegra/tegra-car-clk.c | 2 +-
 drivers/clk/tegra/tegra186-clk.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index 880dd4f6ece9fde3ef3dd9d457e717ce4c237e29..19ca5583a53427d05936cf65b6a32237d91df4ae 100644
--- a/drivers/clk/tegra/tegra-car-clk.c
+++ b/drivers/clk/tegra/tegra-car-clk.c
@@ -57,7 +57,7 @@ static ulong tegra_car_clk_get_rate(struct clk *clk)
 		return clock_get_periph_rate(clk->id, parent);
 	}
 
-	return -1U;
+	return 0;
 }
 
 static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
diff --git a/drivers/clk/tegra/tegra186-clk.c b/drivers/clk/tegra/tegra186-clk.c
index ec52326c3b365eac9845e2fb98531ae0da2f486a..8c364e2dd3412d1298bd39178f19b3cb609aba5a 100644
--- a/drivers/clk/tegra/tegra186-clk.c
+++ b/drivers/clk/tegra/tegra186-clk.c
@@ -23,7 +23,7 @@ static ulong tegra186_clk_get_rate(struct clk *clk)
 	ret = misc_call(clk->dev->parent, MRQ_CLK, &req, sizeof(req), &resp,
 			sizeof(resp));
 	if (ret < 0)
-		return ret;
+		return 0;
 
 	return resp.clk_get_rate.rate;
 }

-- 
2.47.3

