Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0911091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512F384159;
	Fri, 20 Mar 2026 00:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JP+73iS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF6F83FDE; Thu, 19 Mar 2026 21:57:36 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB27B83FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486fd3a577eso6976615e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953854; x=1774558654; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ta7Tj8NqXyER4Q7mkz0A0OEdacbDVtJaec0R0jQ3J34=;
 b=JP+73iS1OfApXkGxdQfUgavurEKpsi1UiJwJXgyD9CuzKkOLv92UoskgrIysfmeue2
 Vbz9bA64e8JszRQKwzKgKy2Q3OF88f/tPrsXINv1ec3u7RMrP4ngmDFCORJPFrYvsorY
 Tw//ZKMhpkVvYeRDSvSprNuMzK/wv0vvVHK8FlAdsOiwoafFPf91Y5ammPgQjt8wkivL
 Zwc8129h+5mc8i23XmyPrtHaWNNk4WErnibNnn5MpJCVAvUos7FOSHxHAAdRp2gt9e+U
 ndVe2NH5dfjMv+FoDwh5yNlY3WZyKqg7PCrb+Uuz59CyGjEUksgRrr9cuLfptPyYfka4
 JGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953854; x=1774558654;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ta7Tj8NqXyER4Q7mkz0A0OEdacbDVtJaec0R0jQ3J34=;
 b=jcaCEjYzU49O5PKDDmTJUYbkZN7sJuJSRTd1JNbvRATNWJ/fITpucj4+uKTfeX23qn
 W6BJoi0VAGKieh8UAVW03mE8AYy+zLpOFA0l8sQ+UDdPAwT8IZUAPaisjjz0i1QQgWB5
 BhBlyhfVFcUHaGCaHRuWkM7w4G90dFvcZ+gAC00AL1+k2G1sYs+PlQtAvSMDAFvLMFT2
 ZlQfzGOnPsHYqF+J2Mb3iQb7uDuy1PV0eq1rMjxKkiwjYZiS8IJA767dEZ29iGiVOC1Z
 WzytzfWrNjiXY/2U6FXl/wNelfE/hyDKTkro/9DD+mrMF7FNxGa6NlyeLp5u6m6NMsGQ
 +reQ==
X-Gm-Message-State: AOJu0Yw6yankS6fUZhowjGatwQQwd7ENHt7+Piom6hMasldkWZP2fi9m
 NWrddSg5MALNhtm9gnz13bm5L6Vh+7rFIg/wnsNwCoAUKvsuHgPW8w/1NUDG27EL9VM=
X-Gm-Gg: ATEYQzylw7MwH5mUjhP+kAYejQP+bx2RNcG9YaG7Echf7J7GaYDmSclP/27I+ykTE/0
 MZ4I5CCk9iikVnNWphirlxHLeuC0gXgn3/YMm4sWaVXrYAQ+/Ef57J4ZzrjJrOe9bQMCSoAxO9M
 uv6ZkkULpiA25v/IcQKUXaX48x8TeL2MLqw63QROohEB0pMa5NEK9pEVkGDwlyplrjO56VQq1H1
 sxcZ6Fzi0t+pPZoaA7VHN+mu1nMBXmgZXoftXkWy3eTQn85EJGZlp4ZEtgP/OWP7ks5b+bQJf9Q
 xwRGenjfZ8HbLEOeneSreJGQk0tdfMLzPoa86YkkPMQ6eooQFPlELUknMkn7vrwBBB54Oc6hOF9
 ifF1/rrxXPQMkzz/gvsChe638OV5wJTdax2AMwSioOE0cqMTpVZW779XTY61VxjhjZWl0YyAcXJ
 qwKumxJTPYLSXVqXvjdyCmDRO9y6tRtYNaDvCRnBmznVFJvci7MO+VLroPBXeICs+wn6s=
X-Received: by 2002:a05:600c:1d15:b0:485:2ce2:4c75 with SMTP id
 5b1f17b1804b1-486febbc648mr7851015e9.1.1773953853998; 
 Thu, 19 Mar 2026 13:57:33 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:33 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:32 +0100
Subject: [PATCH RFC 10/40] compat: add linux/regmap.h symlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-10-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=517;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=NdKEp6PPPnqzQwS5HXhBfSnvR7crR5H9OW0VElgSIaM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXzROgpafHf79v4zv5Bw8Z/S98/5VzOC7rQUPXAvL
 tp+6te0jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR0w8YGToquDZ/PDqRe45c
 AKvO4XWncx7y55c7eKxw/XLu2TPus/wM/2M2SzBK1mvPUpByT2089qHwyc2WT2s05rTJMzNrF/+
 9FQ0A
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

Add a symlink to the Linux regmap.h path so that drivers ported from
Linux don't all need additional changes to include the U-Boot specific
path.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
new file mode 120000
index 000000000000..8a3780b5cebd
--- /dev/null
+++ b/include/linux/regmap.h
@@ -0,0 +1 @@
+../regmap.h
\ No newline at end of file

-- 
2.51.0

