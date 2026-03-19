Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE47109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B2D841A2;
	Fri, 20 Mar 2026 00:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oFDMUr+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6358283FDE; Thu, 19 Mar 2026 21:57:48 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D6B83F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-485445e80bdso11991515e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953866; x=1774558666; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dZJd8jcJ2QufDdsWwRqWjudJvGT1Zn2bs8g3ffveHCw=;
 b=oFDMUr+sBOYawpHv4f4ALn3jvg8r4nobBUbzP1DREbQwbZ/wbNsctoinJ7PB2LvMyd
 uBgDIlZoJ125YheR38IYI3ATyWUQwpWtTD7r2lRQ0nfq0Ubv/V+pEh28hX5Z02f1Nocg
 x5gSB07W9biifRUhjA9xfHG/rMQCU6dpaAc5kBAn4vMLg1fnMPUgDeWwUzxjLZMwW9aY
 Yz4jpi7aYJUneiHHbbcxCxJ4aUuO31QPoubczyzl53NqskGqkFzpZcGAqfQ55WW+/eOB
 83YcYem+fkJWzG/beviJCON3aVd1dOsijekeeCmhBYwCqEjkN4iQN5AC5hEJBUDhJBSy
 YoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953866; x=1774558666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dZJd8jcJ2QufDdsWwRqWjudJvGT1Zn2bs8g3ffveHCw=;
 b=n9tDye8u8DfjnOq2m0jbX+Pm0TW/+YpH6ashF6Q6A1XBp95GFAHUctzWR5a9aoQvPm
 6QVOLsQ7q7pQmhzx5T9XZc+J7y5j8ICEdIpTFrav1YRuceu26L0SfGnWhbe69WUyBtJA
 0WpenhE/LgFs7R6r7yfbvAAZ45SyIUx+l+xAEwjX5KJB6EGj1q78fl6341LZEJKk4aeD
 fxjGmfx/YhhnDFmaG5Hp4xKlC8Z06Dfe7TvuGgQT9SIwd/g7F/LyFbVNA0yscSn+89KZ
 R3V2nsm8IWsdiKEhRDSn7mGILC62byA4wcI0PI+wdcjl9fDmyqngDiVBAmA12fW+fKTx
 Ai3g==
X-Gm-Message-State: AOJu0Yy9V0l/dnR0DWGBm1VMX6sgRSY8KE5uzFfQoUg7FzMMqgwrm541
 bWZpiyi1I+YpJy3PY/eTT1f0wiquP5A2GggmprQe+LilBv3MhjSDp6F99R0rJF3gz7w=
X-Gm-Gg: ATEYQzyM6F6zSYrY0cOFkZGk3qI85QnRLmp83+deYPWLI+qoO3/Adk3Qh1Ul7UPcHL3
 MsFL4B0KsL0PLku4soUHqcj7sAODrRvCvphCShVsIi5LG4J4piAuFINkXyV9rami9PByl0eJh1y
 xReb7jKUP113SQgHZg/nsuDDsA7qY43nqcQrsp9uhJ3zP6FycqSx4xPMrhhYCDdz8whC9dL4qFr
 XFh7CtvDSSCWusxsy5SXKQcjiEQ+RbBynwv7jsPRWW+cX3z2nJUBOBVp4Dn5kT2jE4zC687FwVu
 79tlz+4JrIiZrr1s+6cj2tvGiskJdf2t7hwDdq8gKEB9hqYuryZ7LPtLz7jl3eNGCJioe08mEb/
 hA6+9c/6T9LmD/BK6iuYH/Evakiagte7xA3qQ/lrwusJVSlnk+pIbBuotzJZYd/oAPHdfREhtC7
 /Iwus190HzLMkHOYpfCP9LY+fitgS/Hue6blNXvVf76kSJ5++6lBdicGpYz7pk82TCQWo=
X-Received: by 2002:a05:600c:3b8c:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-486ff03f4d3mr9099525e9.32.1773953865712; 
 Thu, 19 Mar 2026 13:57:45 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:45 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:35 +0100
Subject: [PATCH RFC 13/40] compat: regulator: add enable/disable macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-13-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=850;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=w43IAJ/GgxcdhAfepdgBnfs8T9pBTj4C8IelGrdXjr4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXx3d9WLR28weh6QZiNrfLJjt13W2W77ozGr5ebou
 VQkvw/uKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABPxjWX4n1D6qHqu97OLAmw3
 hYs5j+tKWrozHuyWS3+v/OZC6xf+LQy/mH7bxl3I3+Mufnm/3a9OpbnObXM/sDzdHaQbeSN09ct
 OfwA=
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

These just wrap regulator_set_enable() and provide a closer analogue to
the Linux API.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/power/regulator.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/power/regulator.h b/include/power/regulator.h
index 8a914dfc74f4..4011fb1d254b 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -358,8 +358,11 @@ int regulator_get_enable(struct udevice *dev);
  * Return: - 0 on success or -errno val if fails
  */
 int regulator_set_enable(struct udevice *dev, bool enable);
 
+#define regulator_enable(dev) regulator_set_enable(dev, true)
+#define regulator_disable(dev) regulator_set_enable(dev, false)
+
 /**
  * regulator_set_enable_if_allowed: set regulator enable state if allowed by
  *					regulator
  *

-- 
2.51.0

