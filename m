Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3B9CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3F183829;
	Wed, 15 Oct 2025 17:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HVFx4mXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEB98323A; Wed, 15 Oct 2025 16:32:44 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C191B8313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so3542744f8f.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538762; x=1761143562; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rrFYn5HqWfkmgQZXH9W4GMctaMQzBSO78U9wF2VBV8A=;
 b=HVFx4mXk1lp3/o2Lpy0rA3WfLww2o+XtDI1ZLi9TWxHNqAcM9w26T3MF4YngIIP6EV
 hPA4yNykC797PvXKpnJILqocgFZr4Y5F11PGgqZcIDqTDA9HFc1/ykvNFE+y78A3Skeb
 p9toxBXgnO5I+0OXaFSexWkXwQgzJeF/xw0OyUE0siDXAriMHw+MotBqMNSO6H/nZw6p
 yA3YM/QCq80LEbOEaD9ZdrIgGZHMZs0LlihPfuW2HETiAgXVjd4Ouqt7KzbspZEbD5zo
 dz5Xkmc/I+tpr+xJa8tPJseZccz/rV1hZOiwu1mIHqOrefzw2CFp7z9aVMgBKb9BUzPX
 sdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538762; x=1761143562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrFYn5HqWfkmgQZXH9W4GMctaMQzBSO78U9wF2VBV8A=;
 b=mWkCZZmUlSQzdZqgwr/cqIqZAlkvOq3T87yYBvSQiTIuSsy3nqvDStwe3pTcaSYypd
 jYhJNPSklB0z5PYzzSXv8wvj1FUOzUQfvDM4qqfjJMozM0jHbVz1q8EaAW2rGNmraxts
 r0e5HsUDCnd1T4eT6Md8CfRF4xwgf1xq2Jd80Xkm4Ux7dbX1KzP321mDZ2A6HIJ472Mm
 ydtl4A3LO/edPtGR8gsGk937Vet1DInAc/HHabcKffEKRfQ0FOsNGvahgQOUVlIQBoz/
 mHBwLW8vDyniKstBV5EA+eIonBhl7KIbeSbos40JEoIxX3tj7KCdVNl3m3TTZmnG+FPJ
 wATA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtfQKZMlQcmPqwhooMjZ807a6ZusbkfSimXM6kq3OEsmohAorJpfOWSaURXS+9eAVrzg4ejnM=@lists.denx.de
X-Gm-Message-State: AOJu0YwtXuxUNk9MHteVAaz9m6n9pMZIJxQLjOI7U25ZsqnYKxBib3Mv
 QKul1SBjEBg3S9ZIomOZout7+BdWA2EJp8TqxDZEPNB5oPxJ6UtLhDSMZtf2x34t/+0=
X-Gm-Gg: ASbGncsaEIhDOvroQPWSEpSdpH4sU+l2GT1X7V2jkVG1F571GpQPOPzslCK9SVtyW+3
 MtMJIJdC1E1i151h0iRXb05mSkJNQQpFyaIYeP4E9hnNmy28SsUv8I1KFZ9W+eNYQf4Ar4bGe04
 Pj4PaTF7pvixbHFe1eV0aFcifIOc5EN86nVXsFqNiXtlNm3OxFoZe8nnKk0vHkSgJAJ3NnJmPdU
 W5mca2cH6S7rHgYIcJf/p2pt+jWQ9iTVSyDv55OlLLeaFZhu0jhD3mRCEa6Qt2moFo+25L1UfxA
 7R+pT7d9POHbOpdWx+g4TyHzReIfOMILue+4In9oQ0kXwmEg1YVjcsCDj+/kLIBdLz/QjJDjiwH
 SMHbct7TcVkmn0O0QGe48b9Q/ALjflIOxr7JoZCoCX+UI71jxKFwTZ7vbjNIEXx/zeD0RClPBWe
 mvlvOEQc/Q
X-Google-Smtp-Source: AGHT+IFlNowh+vGp70FH97qTtLRQH3h2fsYL1QnfN9LOkLczISksLceR9H/9QlvbKNOAnaY9OEN82w==
X-Received: by 2002:a05:6000:420d:b0:3f8:e016:41c0 with SMTP id
 ffacd0b85a97d-42666abb540mr18223531f8f.10.1760538761916; 
 Wed, 15 Oct 2025 07:32:41 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:41 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:15 +0100
Subject: [PATCH 10/24] clk: starfive: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-10-5f80f827407e@linaro.org>
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
 drivers/clk/starfive/clk-jh7110-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index f8af17227c502a39cc8f4b77f52a3d88fed210a9..12dd14c02c683bb860743bcb994b549e7a8f74bb 100644
--- a/drivers/clk/starfive/clk-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-jh7110-pll.c
@@ -292,7 +292,7 @@ static ulong jh7110_pllx_recalc_rate(struct clk *clk)
 	else if (dacpd == 0 && dsmpd == 0)
 		do_div(frac, 1 << 24);
 	else
-		return -EINVAL;
+		return 0;
 
 	refclk *= (fbdiv + frac);
 	do_div(refclk, prediv * postdiv1);

-- 
2.47.3

