Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F4ECCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059FA838DD;
	Wed, 15 Oct 2025 17:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hc2Sow/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E1A8357F; Wed, 15 Oct 2025 16:33:05 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 568E48313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so5563955e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538783; x=1761143583; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2q4Wj/H3DTzfFF6xEUa+h8ifX/P9rsxbK5daN1/KAnk=;
 b=Hc2Sow/I3rwASQxpkROdYpc6C1mn8mz7VxIcPYdr/XLq1BCfEqdmItAtjwUIPIiVQD
 V6MXA/SjssQRMU6416luWnMLqR3QKWjvuliRDAyMJsD7cgy/BmuR8jH15Lgr44AkDLtH
 +4PbGCNW6Jyj1okK3lZUi451x99nWW3ciZHMb0HUWz2rdoX/ZuSHDA1ZFrsA13ZwCtUA
 1qyNwBQP3XBgcKuo9Y0TlRghNGkez5L2DDtfAnFbzuuwbIYQusc901d6BZDqlwcfQ3Gr
 UAebYveH0a8GBgZKPnJ9J9AZlvTs+Q79YTCNvfuvoqAdN4d+Tw4Q+B9KcOKnEIeDLjos
 pWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538783; x=1761143583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2q4Wj/H3DTzfFF6xEUa+h8ifX/P9rsxbK5daN1/KAnk=;
 b=IQuJ7r5k9ga6BvqSF8w7O0N8ewoPn8WTVl0ZFH1XpcTwR5IztORj5U20NUJIDoCVQC
 GUzZKUmHt8UDSk9StVqsabvlOsVfGnBzmttlnAVcGiBrSLaz00Pc4pjuWRBZLLHVLzJd
 3pUmKrvy2gTZ4g4dcaFUG3TbbAOyEzDv+881XLESk5xtFLhUUImYlCxMzoLBgmGGuEUc
 xZiXQMWc0MB6O9ugR18bdM77zI8FbMujrWPJVt53WvBjlx4I1t9XFgDO4nJNDPFc2rt1
 uScUuqj60Rhar61fKI6/zbz6705/G4U2J7RHGADjj7Yq3cnUlGNUYxCCELJZGyVG/RG/
 z5MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Km6iXZxoVgiimtHss9llLpfny7LvV8mAp1Sn+L/BZhopE1UWDkEu3GdwgiATtE/oLjsAGqw=@lists.denx.de
X-Gm-Message-State: AOJu0YyjacTkHypC0sq/USUFz3MgauK6lJZSBKr5GI9QeSBxsWKmU+ZR
 xDpHZLtYKYSvtOG8JDd/4YcbbU+o9YoV1WBhUu4UnM0qokY7YXHU99KSEweMc5MGldY=
X-Gm-Gg: ASbGncvGXGTfIb5TgaWN02AcsG9WNrYose6M2zQ9qCTxLImKQ1hRzn6FlaSIF7uyFXf
 tQ24DUgjEZ5q3onCeh+U9i1L84uFB9uAt4mKX1V/IdgqpwEfMJwHQ/rddnrdIaYKSsqREkNypYE
 yTMtKjTO0hdeX/n1D47HfGGVQIQdaEpr2FS3DyJyl7LVqWCU4ybJx5meE60PEXESOyKSkvIeUZg
 lR1ifDK8O7GJYlDHrZYa5jxru5zMKqRLHEbOVjoUTR//d7ya0CZyTCpL6nqlXyGKWDpdMxhVDpV
 RjnmJXihC4BiMshCzc8cPpY5wwZ0p2uEc25u4roAEFLGCnRFG+GBFWbJl601B0J8MLlNzShvWxm
 pmwKPmIFQFY1Rxm6uvjJsjl1QFOSPLYtKX3Gqqm+D24BHYjUr+dJQAVaZ3nC4oW1CKbngfZyNhy
 ywWc513z8F
X-Google-Smtp-Source: AGHT+IEiPj63alC/F+qsPYPzODZQfGumCQVRmx0HRJuTg0Jc2ejaDI+cXXR57MHzjLzAoVQsLyWfnA==
X-Received: by 2002:a05:600c:a69d:b0:46e:1b9d:ac6c with SMTP id
 5b1f17b1804b1-47109b58b51mr1738285e9.17.1760538782734; 
 Wed, 15 Oct 2025 07:33:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:33:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:26 +0100
Subject: [PATCH 21/24] clk: adi: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-21-5f80f827407e@linaro.org>
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
 drivers/clk/adi/clk-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/adi/clk-shared.c b/drivers/clk/adi/clk-shared.c
index dcadcafa9d236882af8c7b397eeeeb44461a23cb..600e22940e8cb60b1e510a74ee8068ccf0c7848a 100644
--- a/drivers/clk/adi/clk-shared.c
+++ b/drivers/clk/adi/clk-shared.c
@@ -16,7 +16,7 @@ static ulong adi_get_rate(struct clk *clk)
 
 	ret = clk_get_by_id(clk->id, &c);
 	if (ret)
-		return ret;
+		return 0;
 
 	return clk_get_rate(c);
 }

-- 
2.47.3

