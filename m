Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAD1CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49302838C7;
	Wed, 15 Oct 2025 17:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YvBLRG8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1CD834D4; Wed, 15 Oct 2025 16:33:01 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25F78313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so40099175e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538779; x=1761143579; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kwWQND9CMT+Bz5FgcZ94jD7k5YY1jW0BivJ6A4aGPZk=;
 b=YvBLRG8k2y8qa6scQZkr95Csj/5V7p9vyyqZw1un3+I+AicTVXv7+3exvObg57CSOV
 X61pbxMCJMXMIyQdUguq3I3Kulnh77LdnNcv//iuZagzRV+9dzoX16+rq2i4OeKs/CeP
 T6hbZFPUMgM76rwpNe9YqFMCEJik7z7zY/CDFzYE+sHCQ5tMHDuFjAySZE+oyFXEq7pB
 jnlxPoqD5nxLuCxdZ34ujRJ7pt3U7tH9TpeHkRDhxdLCyAD2/dYT6ISLNOM7S/ykAxF4
 LOU2S4mZvHJ60/gF6Gm1CEr+N8b8+YHgJu1RS4iMw8RQRG6ZyIvQLqrFdjI/eRE0LMIt
 dQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538779; x=1761143579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwWQND9CMT+Bz5FgcZ94jD7k5YY1jW0BivJ6A4aGPZk=;
 b=vSaAPL1k0+irWljvhZ5P8lt3LsiptFxFLxqim+4+/fqoF7JxvHoOkBWBXruHxIFIon
 Qerdji092CXgkKyPlh8JMlKBrVcky5BmX3GEM/mNKyKK5oO1pAEXm/Ni2F4sMVuObmuq
 hHOaP8T7wTPtAE0vaW31IR0JPfs1TRc72BeN3jMfte9oF9MshHgEKRXs5KuGRrWjUaJZ
 aWcL+lmdoYfIQE4AKgxTPDDjeTeGNhfGga6AxEBLwpyqkR/tuw43yvv17rMsAG3bm/Uw
 z370bhcszG50miSZScVOo9Ue7GO1dkfuFud7uRbvc6llQjZvl272+PcdAUhucQF1Qo+q
 yHHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/QrA80JJh3oVXYpLnr5uzI6DEdIB47JU0xNdrG6nACFeGxgRG/8QalV2E9nZy0i+O7j348wc=@lists.denx.de
X-Gm-Message-State: AOJu0YzdV39ZlDoWmZvO5HND09mmEauSsZCVV5s+v/gCxIHwyn8uj5Ql
 Uyx5/0tPQ1xtJSQdh7y90AqUXnZaZSAlBnJeRqpzzV2B1SkPYXFhrk61C723bQ+/uPA=
X-Gm-Gg: ASbGncu/1Y3XjO514GHS47gXel0MAu9asDtQMHdj2/2z5woipPTy0bKEyYrE4YUVvmg
 DEVNxFxb8yKbDlG0vL9KJUzhQMXLYZ0GkFEq08S3+1EqKl88oxH1scbN2rUIZCTuYlWRwDeud+W
 mup+7VINCH/xIYk0rxJ2BI3dvNgqZW6buEM+tUS7CNspS7IPtgTnRY0KKNQbe0yV5YFof202Z1G
 P9WjvetbZqMv2qn5/dfp0wa+j3dPV58q8oMVVELbFjRzNxsLqRT6Kp5uzLQWF8XViy+9u/F+ena
 5PA/Oqv4x5x7bU9LX6SBZF4pFqAkJLfaqp732o2upthhlf4yWft/2WHQWZ+M38gf/fd61n7etSx
 yCplxrtTkC36KSCfWNai7OmfgAERKkNneuxj+U/sWbrAfIbEx5irDwgM7iPthpSXvDZdNjhjavM
 4jJEtE4iDh
X-Google-Smtp-Source: AGHT+IExvdrrtACv1v1bCnHO/vLEuSJs6IgHVSJLmyd8qAi7z8oH1x726lDJpOK5Wk/7aL8ono5B/Q==
X-Received: by 2002:a05:600c:1e86:b0:471:9fb:e386 with SMTP id
 5b1f17b1804b1-47109fbe4bbmr303835e9.35.1760538779015; 
 Wed, 15 Oct 2025 07:32:59 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:58 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:24 +0100
Subject: [PATCH 19/24] clk: owl: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-19-5f80f827407e@linaro.org>
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
 drivers/clk/owl/clk_owl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/owl/clk_owl.c b/drivers/clk/owl/clk_owl.c
index 513112c1146ca055d99c85eddd7de527b674c60f..11e71f54617a63d565bf61f3f70dff3f94845d00 100644
--- a/drivers/clk/owl/clk_owl.c
+++ b/drivers/clk/owl/clk_owl.c
@@ -202,7 +202,7 @@ static ulong owl_clk_get_rate(struct clk *clk)
 		rate = owl_get_sd_clk_rate(priv, 0);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;

-- 
2.47.3

