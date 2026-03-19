Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154F5109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5215284209;
	Fri, 20 Mar 2026 00:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="leTqU9c0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F8183FC0; Thu, 19 Mar 2026 21:58:09 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D67A83F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so8539065e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953886; x=1774558686; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I/f4S9l/E5i4btKb7Yb2qc06X9sdAkelp31qRHQyfBo=;
 b=leTqU9c0YZnW9lghe+ol4xCYFuRs7Avf4Fr15QicqCVh7H5fAUDd2lsd0PrjnfLA20
 orgjMEy8xW8SGo62AW2NG00FywCYMxERim4QfgMxEwew6ru4YGl7hyrw2pSLVBIJjVau
 Ay8CWblaZfDLtHfHU+kom2ryH8trrjgaXqXHmfBodpFjDTtkp53iIyvEOe1XLSXZJUtK
 OGDccjB4CWBQPry+FD7DPraGR26d3OK76s8fxc1IUZikw4CI81HgZerzRSo/8dWVqY/H
 lIax4foKExQfu5zD1HHsIwN33aQhAFjGEoxRbUUtm9JYMltItsAn94LM+Td+qf1NmHs0
 UoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953886; x=1774558686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I/f4S9l/E5i4btKb7Yb2qc06X9sdAkelp31qRHQyfBo=;
 b=k67XQeAuV8otMYjLIqyT9/vlkw4Ph0ftTyAz0TtcpneV52QKXRVFvppbq+orOtNA+V
 2+/tX9Aj8dyWhO2sEqeNpG6IOzTMTq4XqZu+DPA/Bf6HA04XIsbmo1m8pD16y7h3wzaw
 0VPf6lBUr4X4h5HDQwb/Y+NomPI52Lq+QV6BsaB1cE2kxIaAE74KQr+4lrYGW8mScaDi
 pufNEAbcUGtEG83rgXem0Zm9a/oyVR1Pgj2nMmqnximjFDTlmE2eBhdxy3nWAdteQgnu
 q31cPt/yWEtyPeTT9amV7jNHZXdor6HPStM8NprCH7T45eQybKUkAjYAJ3BMa8d/3fCu
 NlKA==
X-Gm-Message-State: AOJu0YwmpGFdgQIDJZULkb5T+ATNkVpdCgLi60apWUNc3xwbdUxp3Fnp
 SzZrceAIBnZD+gszhzxTsxz5WT3ACum99+dDkNcQSC92Ejdimev6ByaWdXqKdCWctHU=
X-Gm-Gg: ATEYQzzTaFqSswEXQW8kTNn9CDMBkZkjRiePN3v8Rn35aTWgHVcEBQZ5gFEAI1Cyfog
 ai8cD6d1futSr5FVp+OYdrVeTfu9Ef509QoCiDx3x6jDkaIDNYC7MfqK85e/6l7AXm5vdB5pRbl
 61M9/fik+3pgH47yCjl/n0BD1LOUfaeQV1M8IAVKOy1mrhn6Gi3iumHqg+U9s0gLsOFhHF5vPkf
 QNSwnMV7l6ARwgxjMxrGI6z6mrrfBX2YZHhyGlo2xNSZrICNwMG3oEEwHfULIyOf9NEWrAKEnzc
 YboFRJ8asmAlSx/CzlSeP5Fql2zF8CqDztDGG4VSx5Taz4ZiKtpMpe17y0hFL0N8SKE/aUwIv2f
 0Y0e6xKtC8FkjesoEJnLmU1t11ce365cYyAOXo/uCVxVyfM+xY+Ro7xQ1tuFl3RI/izww9tz7VU
 vcIEreRsUzEdnIRCgdxJmJdswCTXPpYXdvxu7q6NfZPnH7hWTKVeHyYglb0axYA0ikHkw=
X-Received: by 2002:a05:600c:56d5:b0:47e:e48f:43b5 with SMTP id
 5b1f17b1804b1-486f8b921f0mr66772275e9.18.1773953885922; 
 Thu, 19 Mar 2026 13:58:05 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:05 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:40 +0100
Subject: [PATCH RFC 18/40] clk: move fixed clocks to clk/basic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-18-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=715igzV4HS4mUxyYAOfpPGBwwmJ9nlDFxPe0UC3c4oY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yfxbI19eVM/kmzujILX13YeWAh2hX37bWyQWzKoSX
 M3JMVuoo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzk6QlGhpkKjm6571IXnBE3
 S58U/ojZ9nmm92n5QPcmM84tElHHZzH8ZPS9p7lpE1PBv98Nnw/2WWvfL/Fqd57q816Iu1FieWD
 8TAA=
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

Linux CCF has incompatible implementations of fixed-rate/fixed-factor
clocks, move the U-Boot versions of these drivers to clk/basic and only
build them if CCF_FULL is not enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile                       | 8 ++++++--
 drivers/clk/basic/Makefile                 | 7 +++++++
 drivers/clk/{ => basic}/clk_fixed_factor.c | 0
 drivers/clk/{ => basic}/clk_fixed_rate.c   | 0
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 30991e9f55d7..23f381eb0d9f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,16 +4,20 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 # U-Boot/IMX "micro" CCF port
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
 
+# U-Boot basic fixed clocks, full CCF has a
+# different and incompatible implementation
+ifndef CONFIG_CLK_CCF_FULL
+obj-y += basic/
+endif
+
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
 obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
diff --git a/drivers/clk/basic/Makefile b/drivers/clk/basic/Makefile
new file mode 100644
index 000000000000..4cf9469d2312
--- /dev/null
+++ b/drivers/clk/basic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026 Linaro Ltd.
+#
+
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
diff --git a/drivers/clk/clk_fixed_factor.c b/drivers/clk/basic/clk_fixed_factor.c
similarity index 100%
rename from drivers/clk/clk_fixed_factor.c
rename to drivers/clk/basic/clk_fixed_factor.c
diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/basic/clk_fixed_rate.c
similarity index 100%
rename from drivers/clk/clk_fixed_rate.c
rename to drivers/clk/basic/clk_fixed_rate.c

-- 
2.51.0

