Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37736CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858D38386D;
	Wed, 15 Oct 2025 17:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pm4PiguB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03AD2834D4; Wed, 15 Oct 2025 16:32:52 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110278323A
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso4553295e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538769; x=1761143569; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bV/e8/t/Q2+spodtqDGG7TeDuDfPmijfIksYHrPyn9U=;
 b=pm4PiguBTm5obWjeP3l6fyBcwUldXL8tuoK91+gwySHCWQcmVHACh97YX8V0t1pvq4
 sXBgeSEgBc/epNn5psEWMCBmJE9SWSqcR1VeiHzf7Q7+aZzETyTfYK1r5l1B9TuIQNfv
 N065muhLznE+6+5SGJCwI391vOPnx6jZO0V0lRZ3yGSUYAn+71KVJMr1hDUYqME3ZQHL
 yZwSbkGvq3stujoPliCfnSunKeQ4Jf/HH+bukbNjZjq+cQnzjRI6sK4eLQz1nRBhcgW0
 TxQuphvkJhsHHNsdSb+YO8PO0WQKZYoXUHvYo7Mpw4I3KMQy5jCeBv5bvkKEEzyuVwKP
 XVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538769; x=1761143569;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bV/e8/t/Q2+spodtqDGG7TeDuDfPmijfIksYHrPyn9U=;
 b=XvLktzmASA0P3bRpIW/YfswA5horCclkQNkns0+3X3QMMhW9IXJjSAGwznG2ngjeUP
 Z/PQ1JUCK4+sdtf9tWL5rDzUclRhtE14RiGkV1xN88GRbkCON8ukYxLTPXbJ5BPfc/rt
 27e4SStZoVcwRS7r+DZqOlLXpDx7kwqStTVMFDyiSh+EZ8COuLpomL2XY0QSS3vrfGGX
 f+RVx8ep3Lm4D4Jj+QvbmvAIQ1UtzPSFqnt91/LarT55DQFM3lRCNYD299hQsWpuqhqr
 2BHmH80sFtFlVuc3SYCYx45DcKNFmn8bg+b/qu2Kx1Armn7BpxzzqHcL2qXQGOs8GbR7
 Xe0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTW91d8lC7Mu2zHIi98nv6XkiAG9cP5p3KjZzhv8Fc1NFz8wejMGj4ep/AWWW9UGP1fy9W6RA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyct3X8qjTfc7zKKPk/bKboxu5qTLnAhh5qhy0gXpNiOK7twsFL
 jWgpQ+fHCAl7ZkmK5KdHG7ApU+JNn1srnEM2BD7y2WqW3a59lqWTzIslezo5tsmO2UI=
X-Gm-Gg: ASbGncso5jOs0FGujLKNjQ5VynqGecuEE6YF3yNpYCgpJdOaC6Ek2DoX9IYsUhcmmPW
 bg6bJoIaYX11vHItS7Ilv6C9azUNfyXi94mjOPUo6cS5U0yfIy00MFmgDDDQ4EiZfc0GbkBUGU7
 Golk/SW6VFRohcKides2UdwHhdm/XABJArgGUBfLA0CGIouqExUTvzHQPLdMquwtdpWlsN1zLz7
 EMdSY/3tEUmpyjIIr9nV2S+nYmIhzsyYv7ZXn1FNdmnLrif+7r3rHBtswEdRqE26eoMjF2ElHxz
 +fPkF0wDh2JfC5L7ibBQch5QWhybbCiTUA259SDIjFVJXl5HcsV0pw62FNS22Bt3C7AYjIf0Pq4
 sC96HeLDVVpO0cvkui1WKQ6AW2U2zA6RS1ToR/0/46UE8zTrryexaQS8zRgqQssr8ycbBXGD/eA
 ==
X-Google-Smtp-Source: AGHT+IEdXqJ0ecDo7rFbfmDvnja6s23sdrsv131WYpUK2dXyZgikEBrPhQmktvo9H2vA2YUew3DXSg==
X-Received: by 2002:a05:600c:c110:b0:46f:b42e:e3a0 with SMTP id
 5b1f17b1804b1-46fb42ee4d2mr116739385e9.41.1760538769348; 
 Wed, 15 Oct 2025 07:32:49 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:48 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:19 +0100
Subject: [PATCH 14/24] clk: nuvoton: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-14-5f80f827407e@linaro.org>
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
 drivers/clk/nuvoton/clk_npcm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/nuvoton/clk_npcm.c b/drivers/clk/nuvoton/clk_npcm.c
index 18cb9cddbf38f4f68f9d035079ff147a4409878e..304c5f2ca07ba3c3e285494ca07330e572b4cac7 100644
--- a/drivers/clk/nuvoton/clk_npcm.c
+++ b/drivers/clk/nuvoton/clk_npcm.c
@@ -177,11 +177,11 @@ static ulong npcm_clk_get_fout(struct clk *clk)
 
 	parent_rate = npcm_clk_get_fin(clk);
 	if (!parent_rate)
-		return -EINVAL;
+		return 0;
 
 	div = npcm_clk_get_div(clk);
 	if (!div)
-		return -EINVAL;
+		return 0;
 
 	debug("fout of clk%lu = (%lu / %u)\n", clk->id, parent_rate, div);
 	return (parent_rate / div);
@@ -199,12 +199,12 @@ static ulong npcm_clk_get_pll_fout(struct clk *clk)
 
 	pll = npcm_clk_pll_get(priv->clk_data, clk->id);
 	if (!pll)
-		return -ENODEV;
+		return 0;
 
 	parent.id = pll->parent_id;
 	ret = clk_request(clk->dev, &parent);
 	if (ret)
-		return ret;
+		return 0;
 
 	parent_rate = clk_get_rate(&parent);
 
@@ -236,7 +236,7 @@ static ulong npcm_clk_get_rate(struct clk *clk)
 		if (!ret)
 			return clk_get_rate(&refclk);
 		else
-			return ret;
+			return 0;
 	}
 
 	if (clk->id >= clk_data->pll0_id &&

-- 
2.47.3

