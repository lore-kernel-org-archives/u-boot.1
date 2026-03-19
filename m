Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB821091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF321842EF;
	Fri, 20 Mar 2026 00:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ws5tPLLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A349F83FC5; Thu, 19 Mar 2026 21:59:00 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937A983FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso1032563f8f.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953938; x=1774558738; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pNVimY15oqCrAYHxDzYtB5OTchEi1mxLeVPqbmrztJA=;
 b=Ws5tPLLYZnzALy0UqML+vmSXS3EihyMJQpX71WfZ/mo0J/qrddp/2lIRf6r9cKyo+A
 BJUO7uvBKQ9V+/U5ED7XBGVOmblcUGMGOKURtjsZv5TRptXH518wl/rf+E4nUdBdDjyZ
 atNm9gcoG1A+lEBIzzzprD317/oEZTzJaMyL83dWOyjkJuBudVtr5BtcpC0krE4MrBWu
 DE31WU4ZVHCfCfmgpmNBrOpywWXVosTN8O22G86XuAkbD/dhRZkFP9oeKxRTizyHIbLW
 eUUUgsZiE2EyWsFpKlzchliGT+4FTp5QbnqKc90rDmWYQ0Cqfq/8mmzcywCWW2vfHdsq
 SWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953938; x=1774558738;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pNVimY15oqCrAYHxDzYtB5OTchEi1mxLeVPqbmrztJA=;
 b=OWW6WHBwwQsnDY/UKV/KIdpzGtke1W13CtgeOVcLIh29FTQRi9KU7TNeOZwSw9vZGQ
 /tWPRldIiUagfqMr/NLthBO8yOqJ35hLnXh13/24lxv8nMl7J/irnpYPN5uxz+3i2Kuh
 1l+H5ikHlVYAZFozGOAcyRYt65+bED8yjyl4zLVRw4nOxiEkwXqQiIWKdB23kRuxp9jb
 HVmZgg8FrFYmudktywX1Q1L0VM3pDm8Bi/sBZAEEe065kkLwJk6am2+JrQCEqQU9otTH
 b3wPK0xGIfLqSo9v9NY433wuZhMc+LPIQY3E73+s8o2V3S/dwQeFLmtdnzKFsO9jpxvr
 2WmQ==
X-Gm-Message-State: AOJu0Yz4Bf7h0jroSHk/8EzEj76SPokyiS5zMzEr8VUCWilguxLlFy2e
 cTmvCcl1AdWMk6KzJqixNGSsluQImYCOApWEYPXL3Xs73eRudWdGfXEIs+ZQGliTcqw=
X-Gm-Gg: ATEYQzxEHuD0l4J9nSqhRR8ciSd5Lfj1Aokkpg3bLYROka22S83lo0sPjXcEepSmCF4
 q1UP1M/Dif0MZIj79+5NeOx3McrY6z4HinpYdwSrPxp8YMs/zLKkH3dAvkObulEN7dr9NE2Ok7Q
 mM+7AojUNGaSY3bH/2oHOcifAK1vApi8bSU7OYETx1f5DyqWozqYMLUcpvUH3GYtvbJTULxApGl
 uzE0IeoU31UW8lFIv9lxTWkllYN12HFwBbhf9oTwEFOoa27QNyqLSWAfnMZVTcgaoIGHOaJ0Owo
 KWTRCPJPRmXtyMwuQwq5lCHf7WBrpkxz8r51wgDJoX004Ng9w4GWSdPzTHNdfzHLOtBKApi0hRl
 PO5KjDW8C1Z/2z134ebSfijAwHF0tT4Of5ZUw86q8mmeu3XNCwpz9OtrPPM7WFSxwaCE+XzfOxy
 dmsc3JWw8OiMPaEFvfq6a1x0HH7tykOWe6CgKhOcAWi6fNqsXWosTv/tnwGvIWh+Ejn/Y=
X-Received: by 2002:a05:6000:2f84:b0:43b:4469:d31b with SMTP id
 ffacd0b85a97d-43b6424e354mr1215926f8f.15.1773953937711; 
 Thu, 19 Mar 2026 13:58:57 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:53 +0100
Subject: [PATCH RFC 31/40] cmd/clk: add CCF_FULL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-31-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=wSWRPGBCtLo+xli0XQv87b9CkhsJCfTj3P+Ywiou4TY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yQJ//4v/L9Cs6X99tvWc/vyw1UJ60+QPOB5RW7R2h
 7DfJhHLjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjAR3gUM//0jpJw8Y4pmnJtd
 pmR88OtPr/07V881THkZpJr0rGHzvGOMDDP6wksmXWT4ecF41ZkNPu/vfEqVtk6/srp2QanTz9d
 mh3cBAA==
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

This functionality can be expanded later, for now just support calling
clk_summary_show() to dump CCF state.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 cmd/clk.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/clk.c b/cmd/clk.c
index 1210a84ca2aa..1f1888b8fd94 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -9,8 +9,9 @@
 #include <dm/root.h>
 #include <dm/device-internal.h>
 #include <linux/clk-provider.h>
 
+#if !CONFIG_IS_ENABLED(CLK_CCF_FULL)
 static void show_clks(struct udevice *dev, int depth, int last_flag)
 {
 	int i, is_last;
 	struct udevice *child;
@@ -119,8 +120,26 @@ static int do_clk_setfreq(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	printf("set_rate returns %u\n", freq);
 	return 0;
 }
+#else
+
+void clk_summary_show(void);
+
+static int do_clk_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	clk_summary_show();
+	return 0;
+}
+
+static int do_clk_setfreq(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return 0;
+}
+
+#endif
 
 static struct cmd_tbl cmd_clk_sub[] = {
 	U_BOOT_CMD_MKENT(dump, 1, 1, do_clk_dump, "", ""),
 	U_BOOT_CMD_MKENT(setfreq, 3, 1, do_clk_setfreq, "", ""),

-- 
2.51.0

