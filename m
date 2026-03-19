Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F0F1091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FBA984082;
	Fri, 20 Mar 2026 00:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mn6/f3o+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261D883FC0; Thu, 19 Mar 2026 21:57:09 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7429D83F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fb112c09so9109705e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953826; x=1774558626; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=28KGNakbB5RYH+xSVqNRph/AVitAGahkTrakR0qSqz4=;
 b=mn6/f3o+dDVLf6HxEkXr3jxqYg7Oosa4qLti9spQMlVa1f2ZiukPLN7cihRL0MxSir
 ZNxSd8hvsrWQH25HNdi5jL3o65rBePOhRS+3tCy1FGIsl8CxOudiAcLacOuiFJdoYp0I
 meLI4xWp2eU17V7K18p6qsOUQuwq23M6lOqz5tRIh/C3DZMK370rC9u/Z7NzCLgvQ3Gk
 OoPXb1qUJIcma5+6X5wO9vZ36XCumcn16M3h35IFNO80SRRV3bGcVVpS2gTl9esPCiU5
 Q9LPrxAIFtMlpR8kU6guVi14YF2HAbLr5E60OR4HjlJ4DeOlZajA61gRtFfm2VjkYxvC
 Cjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953826; x=1774558626;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=28KGNakbB5RYH+xSVqNRph/AVitAGahkTrakR0qSqz4=;
 b=Ho2g9DHwaPb5GSRiH4GPo9xRL7jygMoBGgXoF2xciwVKGcWYg8gvQ4bcfcGksAsYaR
 Q/bghJ2DS0HyQGSCgrkkZrcT+VzYNOh5WUt/GI3enUAni487doOVuiThXllvoW7dlcFK
 agg6RQ/8qKqNF7xabay+FeIMONkuuyraWNOYzbxIsKF6NGjFxH7dis5MSiBM1qK8dMWO
 ihLVeykw+46Eiule9dwVtvuaV6LcldyXPvuyKZmer0gygibgMrkkAHuWNApQbW9rz0Z6
 K1GhjlkMEfJK+Cik/iSZ9LIIetCEqfOryHsImo2Nij5vI2Xay/LMZSvmFIwPOadKM6AB
 jnpg==
X-Gm-Message-State: AOJu0YylYRR8PjJWeqKkqoverzPhYPkeaQJISzVo+aLhCMKzEPrLH01W
 BN7yf0mZSXuGXDAvxnxTtnyZ7FzcPWywAhWzXrhmgsWTP1If/Dzjxq6W0nYbwPARRes=
X-Gm-Gg: ATEYQzyzncAdWhTXeXaqJx5zoS1pkyVBOgPunw05zXGDkKVoPjo8YfHqXyxC+geURjv
 RdlkGk0LO5ER/xtzBLBNLuQwLwo2rRDuy/aeoNKZ3Y93OCbUVkEoHLjXWcZv08MLWyXKVlybP1v
 seKQWd5oHpgtpQwJhgOkcn7LnjjaXlR3n55VdFDne9c5e5RfG8k1GFAaYAmcoBygPfW9SVM442Q
 1VukPzMZcV7WsrCXkk4cNrQMjvPbQtS9RW888tmmhApQugA5XWF9ECWIq776nN9jKspOx0Jqboi
 A/+9r68kCwFAL2pkCGZbXv8KJkmxFJJcf9pabHOG0/Qyn8mrg5tyrJt1GQsObBAI6w3OxtD2owP
 ZOTCDLNjtCWF7DHgsGOuXWKB65+Jyzo7U0W/VbzhmAURIaX85dwUmqtDHUwFtr6kFlb/R8JELDv
 E8y/+OfEQqYFcsnVzwD4JZQ29GpCWAhiaO4w9qcJ7DAPm9N4TTfO6SMVf9aAuf/teeqyU=
X-Received: by 2002:a05:600c:c09c:b0:486:fcdf:c065 with SMTP id
 5b1f17b1804b1-486ff01caa3mr5557435e9.27.1773953825816; 
 Thu, 19 Mar 2026 13:57:05 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:05 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:25 +0100
Subject: [PATCH RFC 03/40] serial: msm-geni: allow invalid clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-3-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=7/r+622xulBFw7ksZmxxltq0sQqqtV5oui7FCVQq6rg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9ybxv7zToc8orPw09/KfrtaquUG7AhVcLrt7a8ivjw
 an0u8G1HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAid5cx/C+oaHlSZfj5S+HL
 d03ZMa6zO7/Z+s1r5o4W/1j+4K3dN0OG/4GGWoHPfmkdZ0jJzbY8fiWWNV/T//nVzA+WEWerYu9
 U6AMA
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

Pre-relocation we probably won't have a clock but it's usually
been enabled for us already, or worst case we will enable it after
relocation.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index bb5a2cb4d2cd..c37255f57d05 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -211,9 +211,9 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
 	}
 	ret = clk_set_rate(priv->se, clk_rate);
 	if (ret < 0) {
 		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
-		return ret;
+		return 0;
 	}
 	geni_serial_baud(priv->base, clk_div, baud);
 
 	return 0;
@@ -516,15 +516,14 @@ static int msm_serial_probe(struct udevice *dev)
 	int ret;
 	u32 proto;
 	struct clk *clk;
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-	priv->se = clk;
+	clk = devm_clk_get_optional(dev, NULL);
+	if (!IS_ERR(clk))
+		priv->se = clk;
 
 	/* Try enable clock */
-	ret = clk_enable(clk);
+	clk_enable(clk);
 
 	/* Check if firmware loading is needed (BT UART) */
 	proto = readl(priv->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
@@ -546,12 +545,8 @@ static int msm_serial_probe(struct udevice *dev)
 	/* Don't actually probe non-debug UARTs */
 	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,geni-uart"))
 		return -ENOENT;
 
-	/* Now handle clock enable return value */
-	if (ret)
-		return ret;
-
 	ret = geni_set_oversampling(dev);
 	if (ret < 0)
 		return ret;
 

-- 
2.51.0

