Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834611091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8DD842A4;
	Fri, 20 Mar 2026 00:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fqcQ5Dnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747A783FC5; Thu, 19 Mar 2026 21:58:45 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089AC83F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b3f91a7abso774452f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953922; x=1774558722; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SQ5hNGwzZKOOoHPheDCQ+BMmkBCQHsp6Shs7hnz6gBo=;
 b=fqcQ5Dnn2ZGzLsvZeve4u3IeQy7sz6NXixXFxi/CXMZKZYR+fCuJ+aFA55pDgFdyIG
 U+TJBtcnpsADE1loQAHlo4c+2XyINip+dAQYBQQbG7D0BB7Fb91wcPEelukx/e5wIvkC
 4qI4YxfA2xVhHwP5lG3FYnaDotkpT2pZ+p4UD3/szziq2WUzYvg9oggzCizvQQzhuktd
 SpQq/Mdn126sUQ6VLCTdNxHIrL36fwtwrp/10eUwZYJ1YbSGS0rlSZTD7/ZP9Zwit1NS
 mq1ipsph2A5/lquaUJf6XTfsrFlrNnYRWYKTpxGaPeTlZQB0BpUwCFN90huFMWCswLa6
 dJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953922; x=1774558722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SQ5hNGwzZKOOoHPheDCQ+BMmkBCQHsp6Shs7hnz6gBo=;
 b=gc0MBrw36Ne+ZgMN3mQI8dEaWH4pDxjFAqUV2o+BiSJmMjX6GmGAgGyr/5lqCJFPnG
 TtTbl0gOVApO1PDLsL+e81sTN26Fhq8UHOxoNj1vLzt0vE77o7zGPw7ruEzCSPBSFCcO
 rgDWoHkqmnRxtcrTTf7Mr2QYwKGDSYU0wfSDS8tt2Wsct1ZnED6gpfKOx08r/Fl7Ondi
 aTbgXjMO4rOKoWjCbrMyBacDfGGyH9OT1v0JTsZxE9ZQCz3PrdsftRZYkmISxUj6qVZq
 yGiT0vJctr+ubItGOsOksgXA/Vm04eG7Djl+boQ7j6kVJm8SWD8qbQk6ZwQeyzHvk/5I
 2zEA==
X-Gm-Message-State: AOJu0YwqOj1ODOjkbmBuP80pSo4H4BG6wSc73WvZkGW/aB3p7F3jKj+S
 l/e2siaHilhjA+SGl2g/ALnspKqXCEapyXbC7SA5rgitsWQpragTdwwZ0QS8YYAr6+M=
X-Gm-Gg: ATEYQzzpBazTavcOc+kGKDu2EZFBcr8+Nwixjvv0UVTfbyU4dKJdM1SMBoKJZeZsj1V
 Ter9FAtQJ/u3uu7K8X97+8Z/rQ9F148/eZXDM/keRAPvekoifa0OLp53RdRGthzDgX+ss9vjkYt
 jK63dygzXA3CeOVzx22/40MwwmjIPwbdcyfCTSXoKKFZzrDodyrjyFA1DanVZ72dJ6vkwmXHLqF
 TrAjug3WnZbUkkv++ioIx8ON7QcQW9kLLoyprJ97SBS980bumgy0euiNIlhGhM6yY3KRdglAPzW
 56uyCeOy/v87MYW9U2xBOg2JmbURkCyGyR/VFhNenUyidn40/OfdoFVI0Ezet1y+ZJ4SrTIWynr
 xt/0x46lii0aGhN7GYxCE1VVwXJWEgiZ3OwDZ7l1fb4zLKYV403Pa7yL27KnrmWgmUlGQAZt5eY
 v236DbTmPp/e/onu/STX7s0Dra+0fmlkGXssGW6iu4O6XyidJALAGmUUFImCVKLdJC6Zo=
X-Received: by 2002:a05:6000:2086:b0:43b:48e3:fbee with SMTP id
 ffacd0b85a97d-43b64286faemr1463540f8f.37.1773953922222; 
 Thu, 19 Mar 2026 13:58:42 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:41 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:49 +0100
Subject: [PATCH RFC 27/40] RFC: clk/ccf: add UCLASS_CLK compat shim
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-27-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9183;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=6OFVGLUuDBpI47iCgfFJPpTCiQFHLj/akAdomSUFFRk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yQKKN2+zTsjmTdzru/1c3Zf9BXlXeZv5NzEzrFJla
 /kecOF8RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIKhlGhj7hd8GzLdRVz27u
 unH9SQR3qXf/qoV66wq5F5isil/hp8Hw32m1pvqd0Gncn/fExs1Yr760c2bFRYEbSty7ppw/sOR
 G9E0A
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

When CCF_FULL is enabled, UCLASS_CLK drivers no longer work normally
since they're entirely invisible to CCF.

This compat shim attempts to bridge the gap by registering a clock
provider with CCF and register clk_hw's on-demand, mapping them
to individual clk IDs of the underlying UCLASS_CLK device. It then
translates between clk_ops and clk_ops_uboot so that clk functions work
as expected.

It's not clear if there is a need for this shim, or if platforms would
instead adjust all of their clock drivers at once. It hasn't been
extensively tested but is provided as-is in case it's useful.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/ccf/Kconfig  |   7 ++
 drivers/clk/ccf/Makefile |   1 +
 drivers/clk/ccf/clk.h    |   6 ++
 drivers/clk/ccf/compat.c | 227 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-uclass.c |   3 +
 5 files changed, 244 insertions(+)

diff --git a/drivers/clk/ccf/Kconfig b/drivers/clk/ccf/Kconfig
index ec5d2d91b870..4ae131c843a9 100644
--- a/drivers/clk/ccf/Kconfig
+++ b/drivers/clk/ccf/Kconfig
@@ -5,4 +5,11 @@ config CLK_CCF_FULL
 	  Enable this option if you want to use the full Linux kernel's Common
 	  Clock Framework [CCF] code in U-Boot. This is a full API compatible
 	  port as opposed to U-Boot "uCCF", drivers must register clocks at
 	  runtime and should not use UCLASS_CLK.
+
+config CLK_CCF_FULL_COMPAT
+	bool "U-Boot clk compat shim for Common Clock Framework [CCF] clocks"
+	depends on CLK_CCF_FULL
+	help
+	  Enable this option if you want to use U-Boot UCLASS_CLK clocks together
+	  with Linux CCF clocks
diff --git a/drivers/clk/ccf/Makefile b/drivers/clk/ccf/Makefile
index a337b9f29d7a..39879b34e645 100644
--- a/drivers/clk/ccf/Makefile
+++ b/drivers/clk/ccf/Makefile
@@ -14,4 +14,5 @@ obj-y += clk.o \
 	clk-fixed-rate.o
 
 obj-$(CONFIG_CLK_COMPOSITE_CCF) += clk-composite.o
 
+obj-$(CONFIG_CLK_CCF_FULL_COMPAT) += compat.o
diff --git a/drivers/clk/ccf/clk.h b/drivers/clk/ccf/clk.h
index 72607020ed8e..f4cdc51459b5 100644
--- a/drivers/clk/ccf/clk.h
+++ b/drivers/clk/ccf/clk.h
@@ -38,8 +38,14 @@ int clk_hw_create_clk_uboot(struct clk *clk, struct clk_hw *hw)
 }
 void __clk_put(struct clk *clk) { }
 #endif
 
+#if CONFIG_IS_ENABLED(CLK_CCF_FULL_COMPAT)
+void clk_ccf_full_setup_compat(struct udevice *dev);
+#else
+static inline void clk_ccf_full_setup_compat(struct udevice *dev) { }
+#endif
+
 // Linux compat
 
 #define clk_prepare_lock()
 #define clk_prepare_unlock()
diff --git a/drivers/clk/ccf/compat.c b/drivers/clk/ccf/compat.c
new file mode 100644
index 000000000000..3059de04f6ef
--- /dev/null
+++ b/drivers/clk/ccf/compat.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Linaro Ltd.
+ *
+ * CCF compat for U-Boot UCLASS_CLK type clocks
+ */
+
+#define pr_fmt(fmt) "[CCF Compat] "fmt
+
+#include <dm/devres.h>
+#include <dm/ofnode.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/clk-conf.h>
+#include <linux/compat.h>
+#include <linux/device.h>
+#include <linux/printk.h>
+
+#include "clk.h"
+
+struct ccf_compat_hw {
+	struct clk_hw hw;
+	ulong id;
+	ulong data;
+};
+
+struct ccf_compat_data {
+	struct udevice *dev;
+	int num_clks;
+	struct ccf_compat_hw hws[];
+};
+
+static inline struct clk hw_to_clk(struct clk_hw *hw)
+{
+	struct clk clk;
+	struct ccf_compat_hw *ccf_hw = container_of(hw, struct ccf_compat_hw, hw);
+
+	clk.dev = hw->clk->dev;
+	clk.id = ccf_hw->id;
+	clk.data = ccf_hw->data;
+
+	return clk;
+}
+
+static inline const struct clk_ops_uboot *clk_dev_ops(struct udevice *dev)
+{
+	return (const struct clk_ops_uboot *)dev->driver->ops;
+}
+
+
+static int ccf_compat_clk_enable(struct clk_hw *hw)
+{
+	struct clk clk = hw_to_clk(hw);
+	const struct clk_ops_uboot *ops = clk_dev_ops(clk.dev);
+
+	return ops->enable(&clk);
+}
+
+static void ccf_compat_clk_disable(struct clk_hw *hw)
+{
+	struct clk clk = hw_to_clk(hw);
+	const struct clk_ops_uboot *ops = clk_dev_ops(clk.dev);
+	int ret;
+
+	ret = ops->disable(&clk);
+	if (ret < 0)
+		pr_err("Couldn't disable clk %s: %d\n", clk_hw_get_name(hw), ret);
+}
+
+static long ccf_compat_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	struct clk clk = hw_to_clk(hw);
+	const struct clk_ops_uboot *ops = clk_dev_ops(clk.dev);
+	long _rate;
+
+	if (!rate && *parent_rate)
+		rate = *parent_rate;
+
+	_rate = ops->round_rate(&clk, rate);
+	if (rate > 0)
+		*parent_rate = _rate;
+
+	return _rate;
+}
+
+static int ccf_compat_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct clk clk = hw_to_clk(hw);
+	const struct clk_ops_uboot *ops = clk_dev_ops(clk.dev);
+
+	req->rate = ops->get_rate(&clk);
+
+	return 0;
+}
+
+static int ccf_compat_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	struct clk clk = hw_to_clk(hw);
+	const struct clk_ops_uboot *ops = clk_dev_ops(clk.dev);
+	long _rate;
+
+	_rate = ops->set_rate(&clk, rate);
+
+	return _rate < 0 ? _rate : 0;
+}
+
+static int ccf_compat_clk_init(struct clk_hw *hw)
+{
+	struct clk clk = hw_to_clk(hw);
+	const struct clk_ops_uboot *ops = clk_dev_ops(clk.dev);
+
+	return ops->request(&clk);
+}
+
+static struct clk_ops ccf_compat_ops = {
+	.enable = ccf_compat_clk_enable,
+	.disable = ccf_compat_clk_disable,
+	.round_rate = ccf_compat_clk_round_rate,
+	.determine_rate = ccf_compat_clk_determine_rate,
+	.set_rate = ccf_compat_clk_set_rate,
+	.init = ccf_compat_clk_init,
+};
+
+/* Find or allocate a new ccf_compat_hw */
+static struct ccf_compat_hw *ccf_compat_find_hw(struct ccf_compat_data *compat, ulong id,
+						ulong data)
+{
+	struct ccf_compat_hw *ccf_hw;
+	struct clk_init_data *init;
+	int ret;
+
+	for (int i = 0; i < compat->num_clks; i++) {
+		ccf_hw = &compat->hws[i];
+		if (ccf_hw->id == id && ccf_hw->data == data)
+			return ccf_hw;
+	}
+
+	/* We haven't been requested this clock before so we need to allocate it */
+
+	compat->num_clks += 1;
+	compat = devm_krealloc(compat->dev, compat->hws,
+			       sizeof(struct ccf_compat_data) +
+			       sizeof(struct ccf_compat_hw) * compat->num_clks, GFP_KERNEL);
+
+	ccf_hw = &compat->hws[compat->num_clks - 1];
+	ccf_hw->id = id;
+	ccf_hw->data = data;
+
+	/* Allocate init data for this clock */
+	init = devm_kzalloc(compat->dev, sizeof(struct clk_init_data) + 64, GFP_KERNEL);
+	init->ops = &ccf_compat_ops;
+	init->name = (char *)init + sizeof(struct clk_init_data);
+	snprintf((char *)init->name, 64, "compat-%s.%lu.%lu", compat->dev->name, id, data);
+
+	ccf_hw->hw.init = init;
+
+	/*
+	 * Register the new clock we just created so CCF will be able to find the clk_core for the
+	 * clk_hw we just created.
+	 */
+	ret = devm_clk_hw_register(compat->dev, &ccf_hw->hw);
+	if (ret) {
+		printf("Failed to register hw clock %s, err=%d\n", init->name, ret);
+		ccf_hw = NULL;
+	}
+
+	devm_kfree(compat->dev, init);
+	return ccf_hw;
+}
+
+static struct clk_hw *ccf_compat_get_hw(struct ofnode_phandle_args *clkspec, void *_data)
+{
+	struct ccf_compat_data *compat = _data;
+	struct ccf_compat_hw *ccf_hw;
+	struct udevice *dev = compat->dev, *consumer;
+	const struct clk_ops_uboot *uboot_ops = dev->driver->ops;
+	struct clk clk = { 0 };
+	ulong id, data = 0;
+	int ret;
+
+	/* Determine the clk ID and extra data */
+	if (uboot_ops->of_xlate) {
+		ret = device_get_global_by_ofnode(clkspec->node, &consumer);
+		if (ret) {
+			pr_err("%s: couldn't find consumer device, err %d\n",
+			       dev->name, ret);
+			return ERR_PTR(ret);
+		}
+		clk.dev = consumer;
+
+		ret = uboot_ops->of_xlate(&clk, clkspec);
+		if (ret) {
+			pr_err("%s: of_xlate() failed err %d\n", dev->name, ret);
+			return ERR_PTR(ret);
+		}
+
+		id = clk.id;
+		data = clk.data;
+	} else {
+		id = clkspec->args[0];
+	}
+
+	/* Find or create a new ccf_compat_hw for this specific clk */
+	ccf_hw = ccf_compat_find_hw(compat, id, data);
+	if (!ccf_hw)
+		return ERR_PTR(-ENOENT);
+
+	return &ccf_hw->hw;
+}
+
+/**
+ * Shim UCLASS_CLK providers into CCF_FULL so that CCF clocks
+ * can work alongside non-CCF clocks.
+ *
+ * This is ONLY compatible with CONFIG_CLK_CCF_FULL!
+ */
+void clk_ccf_full_setup_compat(struct udevice *dev)
+{
+	struct ccf_compat_data *compat;
+
+	compat = devm_kzalloc(dev, sizeof(*compat), GFP_KERNEL);
+	compat->dev = dev;
+
+	/* Register a clock provider with CCF */
+	devm_of_clk_add_hw_provider(dev, ccf_compat_get_hw, compat);
+}
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index d54d76745560..065c80e8c2b4 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -894,8 +894,11 @@ int clk_uclass_post_probe(struct udevice *dev)
 	 * using assigned-clocks
 	 */
 	clk_set_defaults(dev, CLK_DEFAULTS_POST);
 
+	if (CONFIG_IS_ENABLED(CLK_CCF_FULL))
+		clk_ccf_full_setup_compat(dev);
+
 	return 0;
 }
 
 UCLASS_DRIVER(clk) = {

-- 
2.51.0

