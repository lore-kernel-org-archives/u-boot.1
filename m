Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2721FCCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8678838F8;
	Wed, 15 Oct 2025 17:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="texDoNAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6538323A; Wed, 15 Oct 2025 16:33:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010C98313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47109187c32so1147155e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538788; x=1761143588; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4DlBlKpxAI+PPChFoLT58sI+sD4cz43gntE98De/JHE=;
 b=texDoNAVusL7tmorZVqSL5vquRmEjO9k6ctOOltu1ac3Vl6qIR9AVWMCH1i02oP48s
 lrA9OEiCkU6gRyJYA3/dN/Uy+Ch4hUwRhIZywMUnwmlK8wKK4UidhIhjVlCdjn/f0HKN
 m1txSAVWTI3mfrT1+jx6GTs1phvdayq5J6Vi4E9hrN7FK7aKVxPvfLuKjPA1B3aG/h8k
 T/DAh6PHnTeQ/DZ3hQX4qxFlf47M7J/8XrSX9wboWAvL3/FS/7VSGxoBXxw7DW3qyzN9
 a0Tz86vec6h0LRYJo9+8kHJGhGsZuJD48j0i0xfLyHIJ2Y2Hgx1xGoA2kuAISs67vygQ
 B6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538788; x=1761143588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DlBlKpxAI+PPChFoLT58sI+sD4cz43gntE98De/JHE=;
 b=YRAttAzKKXJZa40cy7tefyKx7L+9DangNkI/FG3jNwi3fAq6Az8dLu8d2E415EMAn5
 y11AdIOWVRdWTKyz9oXscLVaj8vi0NdiPLbkAKhcsHIBwVlSTBWcJYAWHwU1aMz9OSrV
 ObkIeXrkNYBdJL4IHWtBQmXPN3aazgmMO+mtwOf+r45Bd9q8ub1EsjYW+2UZ6ObhOFWv
 b10UEe+pdDAojvofYUmAAYiCobKFFhoJo/DrW+zBRu2Hd6YyuuNn6skVXmLujVS8ZmTP
 avNLfucR+b2dOZrM6acrNqYwCS8cEppfCJ9lil3r/v3l2l+SUpDEOEb8msQzXXWySXvB
 T2Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUODkNLHUGwgWd2vFyxlXTaoOu1YznAQ+hJceCeskt7peFEvAiMaQ6fEOXisSZdSIjuLiyTQsI=@lists.denx.de
X-Gm-Message-State: AOJu0YwnLwQRfGmV8R2pBvXlIWQw6vkuBq8mj/VOi/kvO7rx9IO3F1aX
 RrlEquA7piYwF5PdMh0lIX5JEcZ1FblFlrUTMT0G08suJfRBZV3FIDXJDU5FglQfTrY=
X-Gm-Gg: ASbGncuSUDyT7A71WhG2/DVYJvApkgQ7SbhVuAx1rse67RwxGSRRdsq3mjCu6aw//5a
 tGsDlzHhxOwk8kT8YLytFrrmOmRSmgfYFWslMI6R5rzLWtliyynPHosHux2vSrC7Jojsu9DiPCE
 Du316MtFGO65k+JDBcOLpHvSmeWq9yFw2OneOz5CblK48uo9wWn7Z4qLo8YhGlvavrhCW7jvsv1
 3ZaiHoOopxw5/IrVHgjv3DAOt3glQbC5jx/3ztIoPWnIImd2Y/wA3Xsbq7rgjtbq1D1DJQiswyc
 d5WlzXpdC+l5acuw8GPKpukyVrQAfk5m8w8mBFrMry1YMdF0qVwx4S5E8X/rfKRVe+cbEA8Y5MK
 ByPsb2f9OMG5uNsWYzcpz4FlNK6mRfxou1kOBde5K50VzIClvd5dGVGaDbjt1jN3GOo6MhBVcTS
 riZ6VtJnDaHr6WZLcY/rA=
X-Google-Smtp-Source: AGHT+IGGoNhcuuBnqzdOS8d1serI7LBP8ZtrY43uHHsw2cJDzVWs6n2CpX0JLNFJQ7Pf6GLL4B2fyg==
X-Received: by 2002:a05:600d:42a4:b0:46f:b327:31ef with SMTP id
 5b1f17b1804b1-46fb327388emr111447735e9.12.1760538788353; 
 Wed, 15 Oct 2025 07:33:08 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:33:07 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:29 +0100
Subject: [PATCH 24/24] clk: x86: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-24-5f80f827407e@linaro.org>
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
 drivers/clk/intel/clk_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/intel/clk_intel.c b/drivers/clk/intel/clk_intel.c
index a677a7caac7c84e5576a8b228e8ce4493a2e92b3..b5f3e800431314f4c2617133c1afad99dac35787 100644
--- a/drivers/clk/intel/clk_intel.c
+++ b/drivers/clk/intel/clk_intel.c
@@ -15,7 +15,7 @@ static ulong intel_clk_get_rate(struct clk *clk)
 		/* Hard-coded to 133MHz on current platforms */
 		return 133333333;
 	default:
-		return -ENODEV;
+		return 0;
 	}
 }
 

-- 
2.47.3

