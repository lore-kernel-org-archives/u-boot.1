Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D014CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C6583890;
	Wed, 15 Oct 2025 17:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dHJBdf+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDE1835B0; Wed, 15 Oct 2025 16:32:56 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2286C8313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso596988f8f.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538773; x=1761143573; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mcQ8CXNf57aPhy6c7X3EkXw8uO2jY7I9YKfUXV5n+24=;
 b=dHJBdf+3MwlsWtK3RMKDRT335BC+OhWG84pg6kabrXjYQRKr41snOirTt8YPbDiMwi
 t3opH5x1Sxe9O4S4dnkZWk8aGe4OZZqbtIMvgCi/fixiIy7f9JE6K7noPi1I8z9gZJCw
 sB0NyWBfWfPbZVio0hh6z/z4FdIIV8aHvEybKoIKwLCpcpvp+LZKgVvV54wwvUY4Niwa
 PEKi6gfhFHnSTr5MqxaROrMLsDjfjo2dFuwtVw8nFuJUvcQvpgMful8SLKGmSe2yKwn7
 AAVDDFcw1M0opf7kFoDeoxyHPAvtKZ3RwwM/vD+B8FRa6LxlczuMWiBnK+Mz1qL+W3RS
 3o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538773; x=1761143573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcQ8CXNf57aPhy6c7X3EkXw8uO2jY7I9YKfUXV5n+24=;
 b=sLrkLlllCK9YzNdm7pi2zOrdH7tq2bvvc46WMLns507erdIHbn2ARwropLjL00YWzU
 GpKf59PCEmLagLOg5YsaCgU3gFv6FKizaJeJ4iHorJyCn2lUSAcXIalTwsGRdjBSXhyO
 kY0IjtsfXrcljrq7c3G9xfj/5yuEQVFvIOq8rGMgi4zsfbVzk1MXyi0rQ+lrlQ5vDx6B
 qBOnQyNnRqy4zkGO01ia+HjwaYNTGT5ybzV5Td/joqYopQqBUwwztNy4fekulOk4qzVf
 0yaa2l6P1hWJNrtTHHeNjs4IqoN2yQ6sa5bF2iQe8WkmQJ2CKnekQlIvgfggQU0+hZ7/
 IwIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXa69o9oVy+1fGvlBtkA8j6Sz4AFmvEQ/z7KJIWUkz1s6Ija01ohaK3/olUN0w4W3V2SlRnZA=@lists.denx.de
X-Gm-Message-State: AOJu0Yya/B+brf+8XruC1X0puCZSOiG8jasCnVLNe03qWWu9qq2lXCT5
 OMVxzH09CcADbsKZ/RkEv0RCNrB93w4AdJVzsH7jJ5Rb0sfUBcGmh6e1rChrr5fbiDk=
X-Gm-Gg: ASbGncvvBsNd8nQzqZp3QwY23z5NRwUJQbGFLyEPm+K2yNoqBzL2ceSbs23G3+Mg0PE
 xWde99KIua5FQHskeenOETcAJBaLTDI2l0v6RuH/y3qiISCbSE85clJeX8xXzPAAVNcmHGwrW0A
 YQv9rEy6OHEe4cagVDcxxq96xGpkl8hod6F4T4b4bfT4RZjQEBOdX4v8g8Y0tsYCVRkE8FFjipn
 IPK9+BwdskK55o1p0MSy4kWH70lOZY6aWQkpX9mddfbb7K6jYtgfjlID7aHF/sLAQLh/i/9VVMN
 /ToWDMNVpCUYypp79EmouNPz0BOmdpOR87YEwn/Z3Aox12irBDPi1YmVypBH+fIGXuv/Keo7WAG
 wSE+PzFp5dT66IP6kR8/d4BLsm3dvmUFcL3MEcoPp5+zfc1PzT0wlikzoRofwn/jEodyYQvnfFg
 ==
X-Google-Smtp-Source: AGHT+IEl7LqZhV2V+mRAvIp9HPyRtytEkYU4/Cq3hS3UEvinHw9MpC6lhYRaIylvccqIzXRaAszpmA==
X-Received: by 2002:a05:6000:1843:b0:3f5:3578:e538 with SMTP id
 ffacd0b85a97d-426fb8b7789mr229863f8f.21.1760538773280; 
 Wed, 15 Oct 2025 07:32:53 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:52 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:21 +0100
Subject: [PATCH 16/24] clk: imx: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-16-5f80f827407e@linaro.org>
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
 drivers/clk/imx/clk-imx8qm.c    | 6 +++---
 drivers/clk/imx/clk-imx8qxp.c   | 6 +++---
 drivers/clk/imx/clk-imxrt1170.c | 2 +-
 drivers/clk/imx/clk-pllv3.c     | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qm.c b/drivers/clk/imx/clk-imx8qm.c
index 466d71786cfb2b1ffe617bd5c7ea7304238683c0..56db4ba262654a1e0837f1340800b115e2d9321f 100644
--- a/drivers/clk/imx/clk-imx8qm.c
+++ b/drivers/clk/imx/clk-imx8qm.c
@@ -135,16 +135,16 @@ ulong imx8_clk_get_rate(struct clk *clk)
 		    clk->id >= IMX8QM_CLK_END) {
 			printf("%s(Invalid clk ID #%lu)\n",
 			       __func__, clk->id);
-			return -EINVAL;
+			return 0;
 		}
-		return -EINVAL;
+		return 0;
 	};
 
 	ret = sc_pm_get_clock_rate(-1, resource, pm_clk,
 				   (sc_pm_clock_rate_t *)&rate);
 	if (ret) {
 		printf("%s err %d\n", __func__, ret);
-		return ret;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 79098623bc8cc32d134b6cd8d21d990ae1bcd25a..cb7798ff0b963fb46573603873e99c993cc28ecc 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -128,16 +128,16 @@ ulong imx8_clk_get_rate(struct clk *clk)
 		    clk->id >= IMX8QXP_CLK_END) {
 			printf("%s(Invalid clk ID #%lu)\n",
 			       __func__, clk->id);
-			return -EINVAL;
+			return 0;
 		}
-		return -EINVAL;
+		return 0;
 	};
 
 	ret = sc_pm_get_clock_rate(-1, resource, pm_clk,
 				   (sc_pm_clock_rate_t *)&rate);
 	if (ret) {
 		printf("%s err %d\n", __func__, ret);
-		return ret;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index bfd5dd6c464457af1d9e19344e555a984a36ef2f..d2cec8f224c549996e0643617f774eced5bb9881 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -23,7 +23,7 @@ static ulong imxrt1170_clk_get_rate(struct clk *clk)
 
 	ret = clk_get_by_id(clk->id, &c);
 	if (ret)
-		return ret;
+		return 0;
 
 	return clk_get_rate(c);
 }
diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 85b6a9809e8dbcd1c73c0f914077b54fbae85f1f..bde95e950129ea54cb98e3ea37e49883b3911fd9 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -210,7 +210,7 @@ static ulong clk_pllv3_av_get_rate(struct clk *clk)
 	u64 temp64 = (u64)parent_rate;
 
 	if (mfd == 0)
-		return -EIO;
+		return 0;
 
 	temp64 *= mfn;
 	do_div(temp64, mfd);

-- 
2.47.3

