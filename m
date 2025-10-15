Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4AACCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9AEF83847;
	Wed, 15 Oct 2025 17:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s/lyvFgS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D029835B0; Wed, 15 Oct 2025 16:32:48 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7BD835C6
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so38958865e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538766; x=1761143566; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=49jSWRHsss//EBfN7zOwUemnNlZQX5Z/2fmZ0qpW5eQ=;
 b=s/lyvFgS3ZVTyzyYCmP/5XC0/R48HEjJL3AyCZZfFv7+hz8xCOQjGOXK926+SQGY0q
 P9BsX+rJLeNTeKUpRE50e/0LGDDgITJEbYHbO4J/8PdQDarnOEEKrWIXr89LjOzmuILK
 bubrurSJGa59lHlrP214S3qVic12re3eMyh8HxDWzzpEeY9wpybPEMnJaStoGcnzE4Xi
 qBzh7nriNTzNZW8tk5bxAsT6AOuyQuc+LqIzDZLXTE2yIczyQ/yVrmwrulviZk+5fbsW
 rB8Vmy7sOS1k1q7lpdI8AFKp4YY6JHAtlcifs+sySF4qxP3TBzLilcTlDZXDJZZPp4oN
 DQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538766; x=1761143566;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49jSWRHsss//EBfN7zOwUemnNlZQX5Z/2fmZ0qpW5eQ=;
 b=uD+0BqidMZTEd2iWcA5Zq8OPzwYVqTxlBkU4Y1u2s6nzw1eFPhMa84v4wCzKPCSS+0
 KufX60gBkQcHA5xQOP1l1KADhqQmEl8W3G5fuB/5TWNBFQRDR5y5VbWVPMpD3Yncak1L
 unBIYQvCUoq4LyN0SqBiR23jM5CY3fYvGhVRE+M3WJCL08m8tbLI4qVrXtoGGLK6uCVD
 KCVCh//upZTb1zShZyPCtfXaxx7/MCOa+8n5i8pR2gugVJitucO4oyc7eSp4nZma15U2
 nFKI/WExqziB3FBvqb5zjoVQy1CZ2cQqi2qVPS9WXGz1oBh588W8P/kscHLwuANt4vLT
 tJyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX7RcQsTyvAwlK1o3J7aj/ykzXh1IvafyD7f07WWxYLhCh1w0niBtq2fjAXxAeI6SNDoNfsNU=@lists.denx.de
X-Gm-Message-State: AOJu0YwOcODmP1w7LQp3K3UVWSJJ2H9n9aotgUiroksYHzoYcHujkWhV
 N9o9OplqZGWq0Rki8ywYvuLmJRNddJYZARIPHVbAMfc1J/TWS5iMYSevenR3KX1xgDw=
X-Gm-Gg: ASbGncsG5EN8UZiT25YrHGl1lMGLrXBjo3RqcVQDqTEWf9tbn9dgw0/LnE6E+Xq3dI1
 qlGLli0GmJvvJ22CvYz6W4qXOzNfMCzz6nirjHLuUmZWI5WzhbDW3o7rcnktW+9KlhTbpZ8bpIZ
 xZsdRbIfLSLww7TIYY4QN7slWk4fQNQYhnE+evA+KMPucRs4WhNG4RcZRlEGnXkVxxEFSUPlfIg
 +uBlLOD+JJZSvgCGsSCZ/JcAxs3d2XnN35IJQRiO/CaD9kib/9PbS37+OCY76GBbT9xvuJdDySD
 nbsM1DG9i24Y2LI0Q/K9PahJfVYzPK+/62yKSRlZQ1fe1mH3kgh/iszk1omIFvKAQfa8+JxCxmd
 Ukb9qmezfzjQ58L7QZ909rqzstj6nGtXR7OOKAWnyugJwhF0gCo7fqUfS44wPfaO/28hwAHXo/w
 ==
X-Google-Smtp-Source: AGHT+IE61xZ44uz8zMhdoQ8tBs0hpzL01dSTtaZwdHp/BnAZL3FSDzrFGhj1LePLNzK4t2rGWJb6kg==
X-Received: by 2002:a05:600c:530e:b0:46e:4c90:81d0 with SMTP id
 5b1f17b1804b1-46fa9a8f1c5mr206392935e9.2.1760538765676; 
 Wed, 15 Oct 2025 07:32:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:45 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:17 +0100
Subject: [PATCH 12/24] clk: uniphier: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-12-5f80f827407e@linaro.org>
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
 drivers/clk/uniphier/clk-uniphier-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index 33369c93916b06a68f81db056988bd4954adae4c..32e1d7efb86e835a47e0c51bf913fbca4dcb6071 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -168,7 +168,7 @@ static unsigned long uniphier_clk_get_rate(struct clk *clk)
 
 	data = uniphier_clk_get_data(priv, clk->id);
 	if (!data)
-		return -ENODEV;
+		return 0;
 
 	return __uniphier_clk_get_rate(priv, data);
 }

-- 
2.47.3

