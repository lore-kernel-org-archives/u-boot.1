Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3DE109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1FC8414B;
	Fri, 20 Mar 2026 00:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ceATfIck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2631A83FC5; Thu, 19 Mar 2026 21:57:33 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A4D83FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43b45bb7548so913719f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953850; x=1774558650; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JxcERJ3UaiRl1vXO0KA5cEnHfc4xtMelhah9KPin2lI=;
 b=ceATfIck787KPK7J3uSYhSz66pzYFIhlyQTFYH033OLzp4dlZSiM49Vh/k+Wa4W9iG
 nypaw+r+2xnqFbn5zJXFenhmsnzC/kvgsjXi8uI8RrInj5Q1zxDFa/SKNlPLMTNCEBJg
 HkYjYjULSDwns6HG6E1XaeLko6tt+TaqWlnpnK9xHB+b+UpAQ0mieiFdWvf5BH9wrYth
 MAEH3zwm8dbkPYcIFXFVfTHOxZZ5QA8ftVEgEmGwNVI+y0axWNiWR8IgnnCD2+b8QhFh
 4KQatNDz4xWmVf2VH3Mi7uarkEF7ke+lfERYf00pAFhv2WhOWqDArN5eEpaKhmRJiDuE
 0Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953850; x=1774558650;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JxcERJ3UaiRl1vXO0KA5cEnHfc4xtMelhah9KPin2lI=;
 b=AZG46L0L9l+zEeSGnry1zbVSu09J1u4qJLpaVMIxBwrVpAr8X1KQP/I9teSVTcrS+X
 fwqdBxXB/ecikfcZxCNhF0PvAuys3FPD1ZDy838i2Iv4P6AcvzqLjjyeoh2mzfrwlyty
 Z7FoXsZ0dqH21rGaUcXXVOokXlQ28Vf7YxzmwUURDAnnKFK2b/mX+OG1HFwU33ZpMUll
 6Dl4IQzGIT7Gg2NvCBqWVlDgu+TyYzElNL5sEK62gaY9p6jma7FPh/fCMYy3HJZSHHr7
 XterOYlBaWmjnIlZWbLXlvP0Iks+NbXdm76Yyl7LA01MsBoBVt/ZXu1CLnchkkdFuDGZ
 Bwiw==
X-Gm-Message-State: AOJu0YxJEr9GRwWtF/q+PA0nxL7XkVGOCp2I40LzOlPXZ6TSymHg2i/w
 cqqohjbbNbGUBp/u6xUCNb66Hjbii2JvHN59tZDueJ8aB96spFB6XD8E1uUEj1Fl6hk=
X-Gm-Gg: ATEYQzx0yxQjmXO9p//ZEipUNjCp1MIOONDyBjlmjRYDlQHN56YUE5GosnWravpmDlX
 KiC0uW5eFs3oviM8vzq67bsWubzPCSuqY0XNqiktRPfzi1JucZz+XpfB6dBorpL0DuAwvYeYFUK
 bFaqUBJEnSuFR3ejCQhpDriT2O/P1cBAC4owjKxM7+2ekkDgKH7FECvrTWjrUDBuyRSZ06RaR2t
 ZiHjh8+IBTlncYuF/rg4BtSyvFc99WHhCW246QitOCK6PE0gTm/sXl9QHgsdvE9ds/CL7AOBIWa
 ccBcJ8KT1Yovzw6dxu3kIPrWpgbwyPKcGlT3qIxJhcXMl6EhF7LhkCy7z7kjaTOcSWXC12JvE+H
 7+V4EtzVwJfllUABPltHRkOf7svmXYOfynETNbJRc+nZngob+0+q7y3zsbPIP8ACbbj1RtmIiYj
 ppCnqzBYXyIoiF8hZHQCI5jY7iBsCPnWQ59JWp2YRHRGrFJQYJo0P/QWcfKz6I2CD0V+4=
X-Received: by 2002:a05:6000:2203:b0:43b:45a0:9df8 with SMTP id
 ffacd0b85a97d-43b642781a8mr1365023f8f.35.1773953850186; 
 Thu, 19 Mar 2026 13:57:30 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:29 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:31 +0100
Subject: [PATCH RFC 09/40] compat: add dev_name()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-9-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=1W3i+V3HK8nbQuiQS6Y9/UsTMCP1WFM11jOshCSCYko=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXx++tcuZc354bJZ5Pj/dr+zG5dt4w62dlwpuo5rl
 3bR1RVVHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiu64x/BUvODnfNVK99+/t
 ZkVrppuKq1bcOvvY4k3fqZB59avVZ8Yz/LPNfb2uYPmCtYmlHa5W+y+J/K9Yd2TeicBrX2MXPrx
 SmnMDAA==
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

This function just wraps udevice->name.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/device.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
new file mode 100644
index 000000000000..e76635cfde9e
--- /dev/null
+++ b/include/linux/device.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * device.h - generic, centralized driver model
+ *
+ * U-Boot: compat header derived from Linux
+ *
+ * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (c) 2004-2009 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (c) 2008-2009 Novell Inc.
+ *
+ * See Documentation/driver-api/driver-model/ for more information.
+ */
+
+#ifndef _DEVICE_H_
+#define _DEVICE_H_
+
+#include <dm/device.h>
+
+/**
+ * dev_name - Return a device's name.
+ * @dev: Device with name to get.
+ * Return: The kobject name of the device, or its initial name if unavailable.
+ */
+static inline const char *dev_name(const struct udevice *dev)
+{
+	return dev->name;
+}
+
+#endif /* _DEVICE_H_ */

-- 
2.51.0

