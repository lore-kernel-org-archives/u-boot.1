Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2928DCCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5E8838E7;
	Wed, 15 Oct 2025 17:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ReucQ6fB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D2B835B0; Wed, 15 Oct 2025 16:33:07 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49AD48313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso41589775e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538785; x=1761143585; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9oGBD9zwxOILT7ohOlit8rFNmou7uiQ/OKULCO/97Qk=;
 b=ReucQ6fBrSxL70tmjRqdQgo7YZOJRaA1v3EkwWBITjKDwx2Yd/gNdP50W0hLHIVKam
 pvaN13uPFp8c4AH4KBxnL9zgnUSzkHqy8Sy4FNs0QYT1AVPWH3ONeb+XRctfJpokpUTt
 8IrnInM+Jmym+JzknwLu9mYCNfBs252n/Qfo4a1tnQH52xuWkCr1HO21JIw0vtCY55vU
 Hg3Dy9g3Q38uEgw03nbNbpeoQqcnMoeBxE/WYFT/aCI1TRQUogp0FxJZC5uExXZGQrjX
 OuDSMyLlSQ4g7HyRo7njRbXPO5Qoq6lrW2wkRvfyK968trZg0/kYoSuGg7oawfHdqvGs
 tryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538785; x=1761143585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oGBD9zwxOILT7ohOlit8rFNmou7uiQ/OKULCO/97Qk=;
 b=e/zKctF0+Ch5uxNUlH+z8x6UgGMs6bk6oYnZoB0Y7/Um1gkHcjnDZnBHau7FWwXGOi
 umygzElC8+DfwLVU9HJRkB1trh6zt/bpDcNcxTiDcbsGtgUhP7WSYwAxr536mcrAWn9f
 erV4TnCZzJvrjZv7/Oz4j6hItqS4+sX/mNx2xNbx78MhxhrbZk7qTH8Ri+XrELxYhtGd
 hGTUMe8P7uZqrL2eBhf5W1evPzmBuM7YhBe+/vZnmHj7LTSBnhqgFY35ek1CYZjp4UfW
 UQLGQE84HkAwZhH6WMYe+1Dc/F/QkYmJ4HhC4tLRBTb9NwkCgH4o4aNiFz+tV69hyHl9
 dlIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvoNT32TMIjNUDFJ3Ke75W5Aw8JOCH0U//pvewSDtoWkMOG0Hr4laZdJbpY7hlMRHaunnuvpE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy8uqt4ppC7lVCF8iRBYP7v8uUrCpNSdlXsha82YHUpbzpXwgT
 jJxYqwMv0NlU9SrygaNMj6zNgulO3WeLKnu+d4mUDrxOLXxKN3fGmM7Na1PvgPH0rGs=
X-Gm-Gg: ASbGnctwyCv3XPca0dTY5hxmnA+/vZN6BBEUqLkfMq1FMRtuDi0YezMnKPHg9oxwHuV
 LFHlB0IXHM8PvXEwzCxLwViN7CrYbVmdqntSGsWYEc6X2hafB/U6N7lNftvUr5tJddFyNMgq9vu
 vr0F4Hni6RYBYEOluyj6XMSxYcMdv+VgzfI8+IiiTcKvHhSBrWcwvvhxiDFcrwfq9eYfXoB87Vc
 RybLBUY0UApTSU1F3xlHw8hYfKJo1RkH4jA/esHBTtG2zg/u8tITKAabCCuT/+MmnzQg5rku4RG
 HQdFt2FsY4ikDZK2UG/PpRoIwPGo1TS3lIC8cHCFuJ/D/zMdCkhURRTYT9nQtxt8k/MxhY7oSbW
 j4yyDEwSev7j8rs/xcVs2fy8IAWW+WlmP472byNSioGa7oiwt80hKGfAFLLhmnoWtV53b1n991f
 2VOTG1plTb
X-Google-Smtp-Source: AGHT+IE+IxqzwB48mSjhb1Y0a03IfJLfxUFd+QgEaBnvgBt5TnjYffDJ96Xtz+ZB/k7CHTuEUm6mfQ==
X-Received: by 2002:a05:600c:37cc:b0:46f:b42e:edcf with SMTP id
 5b1f17b1804b1-46fb42eee39mr141973725e9.40.1760538784542; 
 Wed, 15 Oct 2025 07:33:04 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:33:04 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:27 +0100
Subject: [PATCH 22/24] clk: sophgo: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-22-5f80f827407e@linaro.org>
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
 drivers/clk/sophgo/clk-cv1800b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index d946ea57a460ab223f89a79504f6c1d01f7c39f9..44f1cb36ba76294586d0075d575ccdddefd59cbd 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -704,7 +704,7 @@ static ulong cv1800b_clk_get_rate(struct clk *clk)
 	int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);
 
 	if (err)
-		return err;
+		return 0;
 	return clk_get_rate(c);
 }
 

-- 
2.47.3

