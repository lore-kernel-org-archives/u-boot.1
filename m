Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2850109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C41D88419A;
	Fri, 20 Mar 2026 00:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EYaZapsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E63583FC5; Thu, 19 Mar 2026 21:57:45 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC4A183F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso1335864f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953862; x=1774558662; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D76RHHt3ck1rSasR55eeHf8+THJxMze9S85PZjvQ1eY=;
 b=EYaZapsvye4NU1sPMvQQO80ihu23SlW8CtZv+sOL1q4ULM0fEAC7eOgbaN/6BsUjOu
 vSix18oP24ctFmEYfAtzXqI03FnHTyrT2xADtNEN0XpUnKp+9F7E/LKFkN79MbCZo45O
 BduOeH4BAf2IlWK8nOz+YLNIGuCNX0Hf21yOmEN/S4zxboUwu/bstKcOflXOoc8HKFoU
 5mg6SD8g/yLRlAHltplRbSg4MbDJO7P0D9XeRm2tZo4zhzsUXThpts0yAdIL41wkcq/d
 NPg1fl7bL502xZ47SDtRJkjlbULeYOBuDkkl4o95CXz1Wkz6pGWhF5Jp4hKq4AdQtoha
 3dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953862; x=1774558662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D76RHHt3ck1rSasR55eeHf8+THJxMze9S85PZjvQ1eY=;
 b=NKAVxq/IAYLaHsxpTtkE/Z834CEnqnj1OzHpEPBXpWC2ebs0ZvbH39iXSWaQPPDHGo
 Wgrb+3kNaiS71KivF8MjEOLb4vc/DymbqtaUse31dNVyOiCk9s2I7rNI4qVjtqQrR8bX
 8UM0Orjv+BwTWCfvukIxTJ4gARo3ta1b5Th6MbrP3B7rOvBzF1HFOeANU9ggagZh2IiI
 Wc6IlVB5M8Mc4DXnGpiOV2hbhWARrHa9HMzYWZeV6ewh1rkYW2AiYrAR7fR6S0efCi9+
 2KYA63jZrQcCJPgq1QDzGfBk3f0IxjpBX4/LSMN94E+E2mysXi7qlul6jXNA5mEwPgDr
 n26g==
X-Gm-Message-State: AOJu0YyvWfo5l2KVmR1c3HPA833SCQDM/+g/3wpIfBniJv/85xx1m/lj
 Ve+GkPeDD2OAgaPjaWNJu4eezsgI5NEknY/83YbZOaQTWohsXPn6pJjxnyptnxTxoqs=
X-Gm-Gg: ATEYQzykdb6FTjqN+yzHlDpydemNs+YKTdWDRCJ/uqSNmKm6rbN8LB9VxRZOEhpjjAj
 8rQhL61Q3cjt08G7G3hRB9cF+X7LMsbNHf3XvMR4+up0qHELhv7ENM1OsaqbCpT00RJ5IF3K/pe
 dPEivF49vIthhsAlcbRF0oQ7VK6vm5kpa4vJGSrXfixI8Xw4ueWCuFxNULejO8Zr93InU7OuKgv
 RpXNkLp6wmq/UbbT2qqFvn0Zxz2A0BytLOBjHmCPl49xRCNtQKjI4iTpXOc/B/omAL2pJ+hJFE4
 7w0RrNM3H4kXdFspoknu2jNylzgyUKYsWZJd8cPeV2EgWP3B1eP00tftfPhVZD1R8uLS8bkN5ap
 fbOfHVgM0yuu/MFjJ6U4ODIb5fdPKLxi6ohTTXeJ1qmf4LIMB+sFWbWtMs68iPQTWctG4FVj9JB
 5xhDeGp9DdxOOImlbke22oWRqNVAR1KXNLJEWv3pHTd59ahcCFilwjoJUbV20wqGTye6Q=
X-Received: by 2002:a05:6000:26c3:b0:43b:3d44:662a with SMTP id
 ffacd0b85a97d-43b64233db1mr1315823f8f.3.1773953862112; 
 Thu, 19 Mar 2026 13:57:42 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:41 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:34 +0100
Subject: [PATCH RFC 12/40] regmap: add regmap_assign_bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-12-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=R70v3bfUMa8es6EMn7gwODOUxcvSL29PsRM99C/5PHE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXx3DRP5WHuv7Ftr6rGGb23/b8P1G5cJ5u5Tj0ktO
 77hp6FdRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZgI+11Ghq1tvl6x9z9qqTqs
 v31NV1oz7oVeVqW++Ssbu20K381sghn+h8wuKc33aBCb+179iHaPiYLOSxne+dc33DNpfaK0sD3
 zMgA=
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

This is a simple wrapper around set/clear bits used by drivers in Linux.
Add it here so it can be used by Qualcomm CCF clk drivers.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/regmap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/regmap.h b/include/regmap.h
index 8c6f7c1c9b1a..eeae843bfb74 100644
--- a/include/regmap.h
+++ b/include/regmap.h
@@ -388,8 +388,17 @@ static inline int regmap_clear_bits(struct regmap *map, uint offset, uint bits)
 {
 	return regmap_update_bits(map, offset, bits, 0);
 }
 
+static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
+				     unsigned int bits, bool value)
+{
+	if (value)
+		return regmap_set_bits(map, reg, bits);
+	else
+		return regmap_clear_bits(map, reg, bits);
+}
+
 /**
  * regmap_init_mem() - Set up a new register map that uses memory access
  *
  * @node:	Device node that uses this map

-- 
2.51.0

