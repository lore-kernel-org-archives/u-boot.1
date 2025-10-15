Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1ABCCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3BAE83837;
	Wed, 15 Oct 2025 17:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vgs5SxV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 555878357F; Wed, 15 Oct 2025 16:32:46 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631D8835B0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso49016195e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538764; x=1761143564; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N3rljvq9KOA7AJzz2MxpZB3DqMsIJEB0N/Yw0c/kKeI=;
 b=vgs5SxV9dEPg0X0DGQ69ymQR1g2GPlY3fRpFSBDM/tWVqv7igaOpuFUJ38/snHT8ZS
 qQ975IsVUcS03qPWEikdrFs+VfvY4rRhpWXdeTts0YXFCIthZP5YYOnWoE+EoDPhsCRp
 +SuoSbsaMEG4zhMCt2WTbSKC0Odd/D2itTS3WD8Rs0Zx+MwmCjEVnrzIyl45fvt82kiu
 o1XIumTVtX0ZorPI+JHjrAoDn5p/9L8dc/NHBBzuexKVaXB+nG3qmTjcvv4qchIXgJoX
 iuyW7WlL+rCIMgSZehzuYIXWwW3nk+vTJEZ7kMkp0oNIL7iiyFV2UMQF4BF0XnlYyWuR
 IwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538764; x=1761143564;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3rljvq9KOA7AJzz2MxpZB3DqMsIJEB0N/Yw0c/kKeI=;
 b=KIzwJ+oAmW2oE0yfIMPunvaZNe4HPSKH3Io6eMfndyZxDZfBE/+6e4fNV//oBIBv1C
 TC5LUXl2mBnsT3LYHvw7KzZCaG1Uc2UrPCJSv5DncfYgLWlnWPiCYgyaAbd5aZ8G+x3z
 Y1Q9Cu1w8awxPBHsFuyZqarrsaJxV6AIF+QHT0WBvVNcfkDPpzkm4lMZtJdXAH9jA6ZW
 NkGHp0i6DRmtGVDWRYZ3Za90O3TM5zxFId35z6+gVANP4LH1lOFsnAqbO3ES6EWCtVmx
 7tBbkqHgo9II6FbiNG2qOcOwsWb1EUSm+DrKHJFEaZOJmywBpDohkj0D7v6r3i5qAWfd
 bEEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPWrx6KPYHTFnvu8HND5ZQAuJJwkgC7FXooJ+niHyTyXex+S2kfyRZL+nr447sfn7Phk3Qjhs=@lists.denx.de
X-Gm-Message-State: AOJu0YzrQy0iw7ozsLCn9JqdOEvpdsGhWXTEkZ7mVSz/9SlagXrefL5I
 YC4W4KhrAJPAg+NB2IguqRLeOVA1PKtFHYgnFkFeqeC0dSbgZlecrvr1pyGDoF+j2qM=
X-Gm-Gg: ASbGncslllBZ55Kyf0RyLEdkIhIaeMLniSdHE4+clLid5hXSK/XukymXCDI4dTSlOwe
 gzYvtJHkQ/8PjzbAoeJ37uLSUYooJs8Asv62vb/CyBaMZqHtm5On48QbS72H9apYEbKcsEtvbk2
 XJnZEUwOdllprFIDIsAnPJGhPQgb2yJ9iC2QnRwD70S5XLX7ytkX3unewgAQW3e+SWak6azAy1w
 3PlfLFudnF18GLoVBAm4tY7SgMz6cUpU49l2M+witxGbC5V1nSChDYzA3dCNzUNonZ4AZ733bqb
 hM6wSmeoj/Lml6ZJgBc3H002n+kCCdtmRFU/C7SUVhwmzPEm5mA6KyujnjlBZWPFrtvNFnGSXxs
 wBailxIy6GIjC4BKRb+2Y9Ps1qzF5uDwoP6CTpdHkWKHUzrhPogIbHKdGLmOyH5huas2NTWXzxQ
 ==
X-Google-Smtp-Source: AGHT+IGZBE/wvC/OR16B1nm/Lbel1Icf+lV5KoD+pC7Gi//18a7APy+0r1AOjyOP5ulUf0ZTDMkeQw==
X-Received: by 2002:a05:600c:a40c:b0:46f:b43a:aee1 with SMTP id
 5b1f17b1804b1-46fb43aaf16mr87846415e9.38.1760538763766; 
 Wed, 15 Oct 2025 07:32:43 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:43 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:16 +0100
Subject: [PATCH 11/24] clk: altera: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-11-5f80f827407e@linaro.org>
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
 drivers/clk/altera/clk-agilex.c  | 2 +-
 drivers/clk/altera/clk-agilex5.c | 2 +-
 drivers/clk/altera/clk-n5x.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index fdbf834bb2f6ae85025a2d11f25f8b1de025871d..7f57e2b1c5d722ba0c8f49eb0849e57ee0ed4d4e 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -639,7 +639,7 @@ static ulong socfpga_clk_get_rate(struct clk *clk)
 	case AGILEX_NAND_CLK:
 		return clk_get_l4_mp_clk_hz(plat) / 4;
 	default:
-		return -ENXIO;
+		return 0;
 	}
 }
 
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index fb1e72ffc5cdef4d641982daf2b57f185ec327c8..90495082203cee0791a26aec2ee38d3f3ac0aff0 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -705,7 +705,7 @@ static ulong socfpga_clk_get_rate(struct clk *clk)
 	case AGILEX5_NAND_X_CLK:
 		return clk_get_l4_mp_clk_hz(plat);
 	default:
-		return -ENXIO;
+		return 0;
 	}
 }
 
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 9e4e7a1d90879bf89cb07212b9d3c894bb203fc7..2340e9890f501b0760d159a66431c521df2bb2f1 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -436,7 +436,7 @@ static ulong socfpga_clk_get_rate(struct clk *clk)
 	case N5X_NAND_CLK:
 		return clk_get_l4_mp_clk_hz(plat) / 4;
 	default:
-		return -ENXIO;
+		return 0;
 	}
 }
 

-- 
2.47.3

