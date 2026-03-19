Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73379109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F73841DA;
	Fri, 20 Mar 2026 00:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ICLNcyRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76C083FDE; Thu, 19 Mar 2026 21:58:56 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C8683F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43b3f91a7abso774538f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953934; x=1774558734; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wMQa1ttISfPeBgePfdbUE+BNee4MFSE9e0gD8HsJuBk=;
 b=ICLNcyRDSIvK8ZXUe+vSHKj+tEFV2hZPSqeSn3nT/Jbm8coEOmOpkTx7fTaJfsBt/0
 9AE9LdMki+O6fAeDQ+RprYmqxQb4ZAQIzp6EAUbJvEUuCdSTeHqqztlgdqXo8GLQm2h6
 9sWwKeVKFpS3BA4CgDWNZZLT+4BWF008MjjArFDVldD/TYuSpk/ulVjKMlgkGYAnNU0F
 KGqG7a5x9MDFVH1sizV9J7JlfNq+BkEDcSh8PkXuzmB/LVCNVcQdDNEnj/ZMOy5r8ViB
 YivTZgF6USlsqOC5URnINWHGWxKM3wuKY0uVaiQKC5oC5e1+S4rcOCX+YhrAjqMRcD26
 VD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953934; x=1774558734;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wMQa1ttISfPeBgePfdbUE+BNee4MFSE9e0gD8HsJuBk=;
 b=f6I8DhhshldWufvClnoOacAinL6NPpgamH3S1tjfVxZsl2Nr+V7qNk5kWZggxshfZ+
 wVXZT1xGGA+8zPXGIILBmugaJAa9NANr8JbjXXzsDD2rvIeQqhbtG8JABtwgp00Wx9fz
 tBB59mfFCCqAEVN7jEOgum3pe4ut53tSY5W4ABLRkUr/W/YEGoO60WykvnqncOxx/cSV
 H7/oS14Y7yzKNLrI8eqxout7INDy29JWI5do7yZ5U9wDcmRt/LHn4aPsN0tqzfV5sIf4
 18GEfxbIRialNcOfdW2FZUZeVPGie+BeA1AOQOdTdEy1JWNsPLHMQRjiztTU8RIC4ZyO
 aPbA==
X-Gm-Message-State: AOJu0YxJ4KXbOnYlWZ9akSWKDrmTqc0T8BQ//iRgPZn5SWgWX/tr2Zui
 gfqpt1kec+SE3jklBy+a4xGC/3XoQHbNLlnJrerj3kwh/y4Xy1g2YYP26o+wSbeKreY=
X-Gm-Gg: ATEYQzxjngNFWP9+qHjI0Aqm4IgF+Juw3tS/8Jq8PRQKSh7WpQjBHLMsCux73xp5G6S
 zSrqQR+qam2ccWMp5yk26MUW8Ywpf7nxj+i5d7npI48lUDloSnXeU42OR5y+KvKp+8xqF7ClHVg
 g1hZde3ufxvFxPdekhAYBZbbiOKcpbmYfwxEvIfMID+Wwu2fvr5VomjfTgur355+vHMwYded5k8
 gmIbfqRyZEW7owWxIn306MEFv1yOk8KJLBHNhfgYKB15cRc9Lr7B94Gc93fJe2XYQyHl1TZd4Aw
 qn4SsOcGithoXrb9Ww1RXcxBIWM4XMS+4RnbRZhlz5ggIajal++4D2re77l1QG3UenKFodfXBv+
 BMMzGMW21dZz53ZsqBMVAhHLVuZlGt24uG2m7WXMnBiJrjSf0KNyKCOo2KrMyOsILpZrC0o7dL+
 8aG3NBidIAg17oNU1EWnQ/jDsMvnBgDw8r7YiHcIpT9etzt3LJ03BOLhn5YlOE4PMIkcQ=
X-Received: by 2002:a05:6000:1845:b0:439:c799:dbe3 with SMTP id
 ffacd0b85a97d-43b6427d9cdmr1299608f8f.25.1773953933829; 
 Thu, 19 Mar 2026 13:58:53 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:53 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:52 +0100
Subject: [PATCH RFC 30/40] configs: add sandbox CCF_FULL defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-30-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=593;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=sZ1m8A6gA/0GkrIXmr2c1FMysUneDUMTheSJV+osWuk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yQKqKr7np1hFasy78+pq04t164NDHT+Wt8rL1dXPf
 vU3Oqy7o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEyE6QLDfwdzrY9FgUtdtzxa
 8m+VSVnihMmZ26ML7l/R818jrLB75kFGhmmbbC2i+A5H1W23ez1F2z9qX5hsldHEx6U/uqrXdBr
 /7gIA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

This extends test coverage to include CCF_FULL which is supported by the
clk_ccf tests.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/sandbox64_ccf_full_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/sandbox64_ccf_full_defconfig b/configs/sandbox64_ccf_full_defconfig
new file mode 100644
index 000000000000..0cec3257a30f
--- /dev/null
+++ b/configs/sandbox64_ccf_full_defconfig
@@ -0,0 +1,5 @@
+#include "sandbox64_defconfig"
+
+CONFIG_ARCH_SANDBOX=y
+CONFIG_CLK_CCF_FULL=y
+CONFIG_CLK_CCF_FULL_COMPAT=y

-- 
2.51.0

