Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDC5CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75CCA83775;
	Wed, 15 Oct 2025 17:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fwYZeick";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AA1835B3; Wed, 15 Oct 2025 16:32:38 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57B4835B0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4710683a644so5726005e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538756; x=1761143556; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3tWf4K5nfITc9L+EnRjgeRkZmPVpS7I4ycWja9HuwN4=;
 b=fwYZeickgXVaHJ8jRPd/tLA8jISH8ZpvHgGAoyyIC2j/NZbWPNyyDKYzFX/tcv7wDO
 GJCO/oKxOlti4vxaukpvk4GCzBJtknYQw5OO44ncLnVKjjmc/JKCux+nIoSbSQkdqgeI
 aWd6Rea9OXEiL0JRvp6/cWlwS+AlPW9w8yW+nYCMsp3CejeiGX/XTSkTcchOo395Y2tk
 xvyxK0e6XtY6/mKT75MyMvX7VafinwXn7wj+YDsYdaYlv+ESAue/8uenV6SGL7rvb1zi
 UoSm8YwomIw1lZ/ZAhyRiQUkidJ269AXZEQJSTs5mJXVOaIFuexvA/B5YcefgzRYmkEC
 XEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538756; x=1761143556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tWf4K5nfITc9L+EnRjgeRkZmPVpS7I4ycWja9HuwN4=;
 b=P5Vo8JgmGMy/KGpFEQk/UZWWxQKasU7SXJSMj1bixWhlG72QR5Kfd1jdfHGLY9UJoQ
 5zzBCBi4Tv76LYWCgywmtyl3+GWbuU30sk4glxXJy/I24H8eS9Tv2wX2apoOtkWDHrza
 skHCU10BNMsPJRSGa6gq7rPQO0hfRkakP2bT35IhTmkPWo1LJ9z9hte9r+Nh04BZnhzL
 ZP1v7IHKOD3BfXaGPSwb1WMGwWA8V1Js3V5AIdCd1TqCJpxYD2YpJhvrWEK8IvGDvrrn
 hLx9bpKzHySgjd2Qvg6ZHCm2G0Bohs2NBysIHlYBnUtCcgv0cQoFG5K5cbJP+t+FdzZL
 SNcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyrdI1PvWxLhWdVSchy/ogXrsQJlSbRp4jcgPG6j1kDDQECf3z5UOciTu2jhZwiky+LFFMGOY=@lists.denx.de
X-Gm-Message-State: AOJu0YytABPkAPa7+av4n5LA82KKInFOzfuMpUiqfwlGl37ffxh02H7Q
 +hWgIMlr0+rY+VUJe6nvbBeuJ/ndu9hFbHiDjNElF8kFpiwCVB11UA9ueXpuqsSGrpg=
X-Gm-Gg: ASbGnctmzhlM5+wBgA7ospPkwcMIjDP5rkRVhyXGVdb+CXKCTxHZtzSSfx/jDarIhbi
 CuLb0MNxvhRAuQdoI72MjQpC5mSvV6+msggKAhotC1p4ondHELqtx6Yy0nREf4yLqOwwbeCII4E
 Qq8/B+1OI3joi7Bcit8x7sBDaC2UbyEqBxnWNlgxSI38sJJiziPF2zmnEizq3uAb/5PJjGq0w59
 jv3XjMdrQX1fPpSMIYp03F/PP4eZGUYPRWcIBAa/uRdPTSjWSxHZhWlSAnr3eXbgpXi0nPBzcrH
 HDiQDnyMJIAV+W3aUprzUB3MrmJ/i1Z8j8iGPMPjYuDxXXW9pLVXzFSCawyAos2R5O4AQDoFcuC
 0U7UTfxQpVpzUQ9plonYMD4hdGu5kRRBWuT61Y0nzp/Z3imwDLtltfj3/69j3FPSh+py2qGo58d
 JF3Q7bI+et
X-Google-Smtp-Source: AGHT+IHBJVSDbhob8EQTtHJBQyTHlnrM8iU3P6RVY/IQeZmYdOCBqElQiuRq2B0zOuFibLaJVHxdQQ==
X-Received: by 2002:a05:600c:4e89:b0:46f:a8fd:c0dc with SMTP id
 5b1f17b1804b1-471099212bbmr3743235e9.3.1760538756090; 
 Wed, 15 Oct 2025 07:32:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:35 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:12 +0100
Subject: [PATCH 07/24] clk: renesas: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-7-5f80f827407e@linaro.org>
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
 drivers/clk/renesas/clk-rcar-gen2.c | 8 ++++----
 drivers/clk/renesas/rzg2l-cpg.c     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index 9b6fce4675c018ad72eeefe3939bacbf65ffc428..4cdcc0fe71946d3055caae3ac7eb8e36c0b9b507 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -82,7 +82,7 @@ static ulong gen2_clk_get_rate(struct clk *clk)
 	ret = renesas_clk_get_parent(clk, info, &parent);
 	if (ret) {
 		printf("%s[%i] parent fail, ret=%i\n", __func__, __LINE__, ret);
-		return ret;
+		return 0;
 	}
 
 	if (renesas_clk_is_mod(clk)) {
@@ -94,7 +94,7 @@ static ulong gen2_clk_get_rate(struct clk *clk)
 
 	ret = renesas_clk_get_core(clk, info, &core);
 	if (ret)
-		return ret;
+		return 0;
 
 	switch (core->type) {
 	case CLK_TYPE_IN:
@@ -112,7 +112,7 @@ static ulong gen2_clk_get_rate(struct clk *clk)
 			return rate;
 		}
 
-		return -EINVAL;
+		return 0;
 
 	case CLK_TYPE_FF:
 		rate = (gen2_clk_get_rate(&parent) * core->mult) / core->div;
@@ -198,7 +198,7 @@ static ulong gen2_clk_get_rate(struct clk *clk)
 
 	printf("%s[%i] unknown fail\n", __func__, __LINE__);
 
-	return -ENOENT;
+	return 0;
 }
 
 static int gen2_clk_setup_mmcif_div(struct clk *clk, ulong rate)
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 7fce1f70d13805fff452b60ce6ec16e4439e28d0..ecdd6c6e52695658d032b805425480cf60a1be59 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -225,7 +225,7 @@ static ulong rzg2l_core_clk_get_rate(struct udevice *dev, const struct cpg_core_
 		return rzg2l_div_clk_get_rate(dev, cc);
 	default:
 		dev_err(dev, "get_rate needed for clock %u, type %d\n", cc->id, cc->type);
-		return -ENOSYS;
+		return 0;
 	}
 }
 
@@ -244,7 +244,7 @@ static ulong rzg2l_cpg_clk_get_rate_by_id(struct udevice *dev, unsigned int id)
 		}
 
 		dev_err(dev, "Module clock ID %u not found\n", cpg_clk_id);
-		return -ENODEV;
+		return 0;
 	}
 
 	for (i = 0; i < data->info->num_core_clks; i++) {
@@ -253,7 +253,7 @@ static ulong rzg2l_cpg_clk_get_rate_by_id(struct udevice *dev, unsigned int id)
 	}
 
 	dev_err(dev, "Core clock ID %u not found\n", cpg_clk_id);
-	return -ENODEV;
+	return 0;
 }
 
 static ulong rzg2l_cpg_clk_get_rate_by_name(struct udevice *dev, const char *name)
@@ -272,7 +272,7 @@ static ulong rzg2l_cpg_clk_get_rate_by_name(struct udevice *dev, const char *nam
 	}
 
 	dev_err(dev, "Clock name %s not found\n", name);
-	return -EINVAL;
+	return 0;
 }
 
 static ulong rzg2l_cpg_clk_get_rate(struct clk *clk)

-- 
2.47.3

