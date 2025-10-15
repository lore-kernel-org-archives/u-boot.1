Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585E8CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94724836C1;
	Wed, 15 Oct 2025 17:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LV5qvDZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F4B8357F; Wed, 15 Oct 2025 16:32:35 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217C4835B0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47109187c32so1141715e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538752; x=1761143552; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ERwowSjUiSfjiyeRoDtHaJmN8qD2SmfA6iuhiy4Rcrk=;
 b=LV5qvDZgfQtjx1WYWTyG1mMgHR+nA1a0Bd/PiJm3ozajutBbidvfOsHJgwEIivfvoB
 vGXK9v7kf2K6vts62iATJy9wXu3f1lAE+YKRYFmz575UFMMkUXiblNlZnI6U3d0mmfNa
 w1e1sadwdT0JdzohDrWd813Kb2k5CHpx4fiOORsnZdh/wAR2yDGUQRNEGgHOb1jx2Cd8
 M5JWGVK4U25vZMEZFgwVwL+I/xk3iU2D3AIECMiitJq4+36jHP6+xzgKkVjUQLNrQMM5
 W1DGiskwmQN9tysPxOL4jWxr0OnbvkIHieQ8+2N6SEaFFU86cPNt4pbBYDO5jakT3woU
 h1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538752; x=1761143552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERwowSjUiSfjiyeRoDtHaJmN8qD2SmfA6iuhiy4Rcrk=;
 b=FPAzFBsCx8eysFy4EMh+mXntTSmBe4TQvPWy/SD0UhPzZwii4+dphFIu9GRKv7Clwd
 b9s0fAEDf4+fbz8x03u1bbIy4MGCJjQQgjDBKXC0aH1HEmPaeA2ZAhGSU+HTdX+DDifb
 e+K4t9kMzRR/VuAhrIfWICnx3haVLpCxr47HoGIjvGJTyGBA37IQxjCS36zZ4krWek6s
 DHWdnVZUY60CAHKmLIuL0lvWMKB4PaLxcsjEWDfuhXUY0F4hWKkmSPClMCYJYdxyOTSm
 CG+mqynupFY/mWysAkW4D/ZZQOfy5j+OwpcNFTtO5kT7ja/+zaR4IzWCGTiD4ZPJhb5/
 7C0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Ej8aCZP0RK2D5TUAHRzYKdKxZxQC7GSze4tATzB4hAus89FkH97T9t0HOHHGg3Mmh7BWUJc=@lists.denx.de
X-Gm-Message-State: AOJu0YzBclJFVWQqpGCSTHq5FLa5dibsaz3NpZ3SjKfbQ3NhEvGv0474
 p3+cdp6zfvqXop/+9tA6ex4/v7hmwumsPsZhZspFyuX+g3D42LMTaVdfmOQIFlp/xys=
X-Gm-Gg: ASbGnct1a/IU82oknsJ/x/EktQ+v0wsMmeFQuosKl4VobxH+6NCHw/SDJTW+6c6toN4
 u8uQH7HyT5ZvzHnwTTExJ9lyncK0Ur7v803AGRtHmyhcvoWcydCQcsktSOoCkPXUS7GudvyM6yM
 ioJpCb5nnX33e4Ey26Tl3aFkoxcuRDeBLJWOos2D5WlxkyQjIV/uiavVReo9Nl56Ssp48rttup5
 nsfWN2J3l6QrMlqRlv7xOXdH5qpBFCNy5qYAAlSuYQup7t2nyzruvmfCyfy6qnxi76vu/DWwH94
 pWI32y6mu6HaGeKaWsrgqQWKpmfxxU52pcE+yRaXV+G5AH01MiYMbtYxIGjbXkWQ8E2HKibM6pU
 SxFIpA2RGV92ffNWT0ebrsb8DiwOklUvnl3auNip2xVCudex/hNIgn1aS4aTLT07s4Bs3dGUXzQ
 ==
X-Google-Smtp-Source: AGHT+IEYyrBIrogkMQ3xVs6oCJsz6+b5u5hitXq0HuUBGcvkXrEFn3Yf8t0jmhLEmQ4TxVA9MpI9eA==
X-Received: by 2002:a05:600c:c8d:b0:46e:3c29:ce9d with SMTP id
 5b1f17b1804b1-46fce362f77mr79718925e9.32.1760538752292; 
 Wed, 15 Oct 2025 07:32:32 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:31 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:10 +0100
Subject: [PATCH 05/24] clk: ccf: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-5-5f80f827407e@linaro.org>
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
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b8c2e8d531b91f986995d15669620feff936e617..eb3b58edd2669cdff0f72ee9daad083d063c4dd8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -84,7 +84,7 @@ ulong ccf_clk_get_rate(struct clk *clk)
 	int err = clk_get_by_id(clk->id, &c);
 
 	if (err)
-		return err;
+		return 0;
 	return clk_get_rate(c);
 }
 

-- 
2.47.3

