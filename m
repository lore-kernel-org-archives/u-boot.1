Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6027D1091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD6EB841F2;
	Fri, 20 Mar 2026 00:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fw2YILTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1312983FC5; Thu, 19 Mar 2026 21:58:01 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8D383F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so991841f8f.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953878; x=1774558678; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OCnS3ZlhvvW3XbeEgO9yZIoCnqN7iRGngRVh2eKOPzw=;
 b=fw2YILTx8WrZdsFNOh7uMFTSxKsMJDxW6R2ZvVwJTiyzwp6TDmHnxUcgA+DCAryMG1
 56oTXdPkj2T16cexcVl9XzHch+Yq3ZkDAAJvCuvOOhhQ0mtUJZy8Gm5PLw4Wb+DkihD/
 /muGYBRDOODmiuKqaNHxswTnZ1I74Is7YxoPqtt0r8NwNQ0nDdaehWneDAhBXBF0te6N
 lb/ungXiBTP4aFLF7fZKPEb7OWrh7RZ67OyazWVpNLN4LOfgeub8IQBNHTqHdsIzfaug
 vkTwQA6VpMwki5/K1jqMeBv7xlTXGAfn1YB7T1nuYNBITeDmN2NOzdbbSme5IlA9NHU1
 C0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953878; x=1774558678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OCnS3ZlhvvW3XbeEgO9yZIoCnqN7iRGngRVh2eKOPzw=;
 b=m0Yogc2pd/ftKRDGsTpgeMl9ZHgrdn0yRNiprE4V63T+Yt+svtve3L8lTFTlOPm5be
 xKpMtEoBQzUcUjvbz3yz4EBK/btZ+ug8Q4RkuLKDnOqWwjG56geMaWwbnn0KuFnhVkju
 9sqVpg9D2WU10tGHD49f1PzGj2HeQV7AG+IClJtSWgXHI0F6Ms0HA//FNm2TAekXBz4v
 U5fbRjyyWHxOXAqJFkFW2QqOSSO/7dOEbP2kGP1rRpd2/3TLuXj1VIONwDZFKxCHBtqx
 PKC+uNhlBbOCphesXhFK4PfZsEqzoQVbe9rHC7qrDE76pxqhPfEmrrONZmfwvyxKh/T/
 xqoA==
X-Gm-Message-State: AOJu0YxKFsLQ8VJE3wR1gw4FOBDlNDMEPp6vhGcNW6fs+JPiYrKsgJ6W
 rxAu0nRquovZnCwRNA3uI+JKhtTO2TTs6ypeQYXAjm8ZXavrzfSd4PN6HqIq+oWy/vQ=
X-Gm-Gg: ATEYQzzrHYDMezG1rjbAYOntRmbUNrUwCXC6xXJ8N0AmyljJgCa4/mb/iFbNWVo20XR
 ZeluS6lLIeYIA0DeXYKiW5/Q2gHVwZLmRwjzLUzCnyt+Rxzf08JDVwhrjOzNMIKW3CJGFkXmvGO
 xHe0R7uRyw+PiTMn6lNkcrG2L6XZZqAYdY7sInBW4yV2lxekjRGd1hohp+M5J3ya5//6btwE0hT
 2pj9AKot3CyI4RRZf9yFSDn4BNw0FzwMij0LHq3nghVKfcwGJr0V6uSuWfrc9BOxqCcy0cql0O5
 EFnHIMFO7fTvXbenLUTnUwS6kM+OLPdcBzaVbGwYEMOet1jWpFIgOCHG8aHmZh7wD0se9AweEtC
 rGrQG4Atw74O9ceBdiTrPYAF7Wvg9elTAc3YAOz0epulGnANCapyZz3pKNYxVAwxk+qiwywZMJx
 NvcFylceLt8qIzRnqlC7E2HhceTR9iIub81Ge0sAQ9L/jKdwmPPegyANHsJewo9rgM/B0=
X-Received: by 2002:a5d:5d13:0:b0:43b:3bed:f3b with SMTP id
 ffacd0b85a97d-43b64277fafmr1203947f8f.34.1773953877871; 
 Thu, 19 Mar 2026 13:57:57 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:56 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:38 +0100
Subject: [PATCH RFC 16/40] clk: move U-Boot CCF to clk/uccf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-16-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9240;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=/RAbNGoLPbHbhn8quS6iAUljDwLpWmzJA+HtFCQI1Qk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yfyZVdPqjzFeKtZ8mTDnwHx7Z6XTvTMnHtj3IueMe
 +we5ckHOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBETrEz/HdbJnz0g/15OyUN
 od6cNzMZXlwrM7SV3vos7GfQr97sCzKMDJNcO6I3lwU9tX/o22d0c8WeuDOuvH4/oys1fVls6hz
 4JgIA
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

Prepare for the introduction of full CCF support by moving the existing
U-Boot CCF support to a uccf subdirectory.

Due to a number of incompatibilities it won't be possible to support
existing U-Boot CCF clocks with the full CCF, this allows us to support
both. While it may make sense to remove U-Boot CCF in the future, it may
be necessary to continue supporting it to meet space/memory requirements
in SPL for some platforms.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Kconfig                                | 51 +++++++---------------
 drivers/clk/Makefile                               |  7 ++-
 drivers/clk/uccf/Kconfig                           | 22 ++++++++++
 drivers/clk/uccf/Makefile                          | 11 +++++
 drivers/clk/{ => uccf}/clk-composite.c             |  0
 drivers/clk/{ => uccf}/clk-divider.c               |  0
 drivers/clk/{ => uccf}/clk-fixed-factor.c          |  0
 drivers/clk/{ => uccf}/clk-gate.c                  |  0
 drivers/clk/{ => uccf}/clk-mux.c                   |  0
 drivers/clk/{ => uccf}/clk.c                       |  0
 .../{clk_sandbox_ccf.c => uccf/clk_sandbox_uccf.c} |  2 +-
 include/sandbox-clk.h                              |  2 +-
 12 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c88931c8ec4d..5cc76cd55cc8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -10,8 +10,24 @@ config CLK
 	  a particular clock rate and check on available clocks. Clocks can
 	  feed into other clocks in a tree structure, with multiplexers to
 	  choose the source for each clock.
 
+source "drivers/clk/uccf/Kconfig"
+
+config SANDBOX_CLK_CCF
+	bool "Sandbox U-Boot Common Clock Framework [uCCF] support"
+	depends on SANDBOX && (CLK_CCF || CLK_CCF_FULL)
+	help
+	  Enable this option if you want to test the Linux kernel's Common
+	  Clock Framework [CCF] code in U-Boot's Sandbox clock driver.
+
+config CLK_COMPOSITE_CCF
+	bool "Common Clock Framework [CCF] composite clk support"
+	depends on CLK_CCF || CLK_CCF_FULL
+	help
+	  Enable this option if you want to (re-)use the Linux kernel's Common
+	  Clock Framework [CCF] composite code in U-Boot's clock driver.
+
 config CLK_AUTO_ID
 	bool "Enable support of an unique clock id with several provider"
 	depends on CLK
 	help
@@ -66,35 +82,8 @@ config CLK_BOSTON
 	select SYSCON
 	help
 	  Enable this to support the clocks
 
-config SPL_CLK_CCF
-	bool "SPL Common Clock Framework [CCF] support"
-	depends on SPL
-	help
-	  Enable this option if you want to (re-)use the Linux kernel's Common
-	  Clock Framework [CCF] code in U-Boot's SPL.
-
-config SPL_CLK_COMPOSITE_CCF
-	bool "SPL Common Clock Framework [CCF] composite clk support"
-	depends on SPL_CLK_CCF
-	help
-	  Enable this option if you want to (re-)use the Linux kernel's Common
-	  Clock Framework [CCF] composite code in U-Boot's SPL.
-
-config CLK_CCF
-	bool "Common Clock Framework [CCF] support"
-	help
-	  Enable this option if you want to (re-)use the Linux kernel's Common
-	  Clock Framework [CCF] code in U-Boot's clock driver.
-
-config CLK_COMPOSITE_CCF
-	bool "Common Clock Framework [CCF] composite clk support"
-	depends on CLK_CCF
-	help
-	  Enable this option if you want to (re-)use the Linux kernel's Common
-	  Clock Framework [CCF] composite code in U-Boot's clock driver.
-
 config CLK_GPIO
 	bool "GPIO-controlled clock gate driver"
 	depends on CLK
 	help
@@ -180,16 +169,8 @@ config CLK_OCTEON
 	default y
 	help
 	  Enable this to support the clocks on Octeon MIPS platforms.
 
-config SANDBOX_CLK_CCF
-	bool "Sandbox Common Clock Framework [CCF] support"
-	depends on SANDBOX
-	select CLK_CCF
-	help
-	  Enable this option if you want to test the Linux kernel's Common
-	  Clock Framework [CCF] code in U-Boot's Sandbox clock driver.
-
 config CLK_SCMI
 	bool "Enable SCMI clock driver"
 	depends on CLK
 	depends on SCMI_FIRMWARE
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f96d57a3223a..30991e9f55d7 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -6,14 +6,14 @@
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
 obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
 obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
-obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
-obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-fixed-factor.o
-obj-$(CONFIG_$(PHASE_)CLK_COMPOSITE_CCF) += clk-composite.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
+# U-Boot/IMX "micro" CCF port
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
+
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
 obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
@@ -57,7 +57,6 @@ obj-$(CONFIG_CLK_XLNX_CLKWZRD) += clk-xlnx-clock-wizard.o
 obj-$(CONFIG_CLK_ZYNQ) += clk_zynq.o
 obj-$(CONFIG_CLK_ZYNQMP) += clk_zynqmp.o
 obj-$(CONFIG_CLK_ICS8N3QV01) += ics8n3qv01.o
 obj-$(CONFIG_MACH_PIC32) += clk_pic32.o
-obj-$(CONFIG_SANDBOX_CLK_CCF) += clk_sandbox_ccf.o
 obj-$(CONFIG_SANDBOX) += clk_sandbox.o
 obj-$(CONFIG_SANDBOX) += clk_sandbox_test.o
diff --git a/drivers/clk/uccf/Kconfig b/drivers/clk/uccf/Kconfig
new file mode 100644
index 000000000000..bf4a634a403f
--- /dev/null
+++ b/drivers/clk/uccf/Kconfig
@@ -0,0 +1,22 @@
+
+
+config SPL_CLK_CCF
+	bool "SPL U-Boot Common Clock Framework [uCCF] support"
+	depends on SPL
+	help
+	  Enable this option if you want to (re-)use the Linux kernel's Common
+	  Clock Framework [CCF] code in U-Boot's SPL.
+
+config SPL_CLK_COMPOSITE_CCF
+	bool "SPL U-Boot Common Clock Framework [uCCF] composite clk support"
+	depends on SPL_CLK_CCF
+	help
+	  Enable this option if you want to (re-)use the Linux kernel's Common
+	  Clock Framework [CCF] composite code in U-Boot's SPL.
+
+config CLK_CCF
+	bool "U-Boot Common Clock Framework [uCCF] support"
+	help
+	  Enable this option if you want to (re-)use the Linux kernel's Common
+	  Clock Framework [CCF] code in U-Boot's clock driver.
+
diff --git a/drivers/clk/uccf/Makefile b/drivers/clk/uccf/Makefile
new file mode 100644
index 000000000000..02440b5e322c
--- /dev/null
+++ b/drivers/clk/uccf/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2015 Google, Inc
+# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+#
+
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
+obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-fixed-factor.o
+obj-$(CONFIG_$(PHASE_)CLK_COMPOSITE_CCF) += clk-composite.o
+
+obj-$(CONFIG_SANDBOX_CLK_CCF) += clk_sandbox_uccf.o
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/uccf/clk-composite.c
similarity index 100%
rename from drivers/clk/clk-composite.c
rename to drivers/clk/uccf/clk-composite.c
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/uccf/clk-divider.c
similarity index 100%
rename from drivers/clk/clk-divider.c
rename to drivers/clk/uccf/clk-divider.c
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/uccf/clk-fixed-factor.c
similarity index 100%
rename from drivers/clk/clk-fixed-factor.c
rename to drivers/clk/uccf/clk-fixed-factor.c
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/uccf/clk-gate.c
similarity index 100%
rename from drivers/clk/clk-gate.c
rename to drivers/clk/uccf/clk-gate.c
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/uccf/clk-mux.c
similarity index 100%
rename from drivers/clk/clk-mux.c
rename to drivers/clk/uccf/clk-mux.c
diff --git a/drivers/clk/clk.c b/drivers/clk/uccf/clk.c
similarity index 100%
rename from drivers/clk/clk.c
rename to drivers/clk/uccf/clk.c
diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/uccf/clk_sandbox_uccf.c
similarity index 98%
rename from drivers/clk/clk_sandbox_ccf.c
rename to drivers/clk/uccf/clk_sandbox_uccf.c
index 9b8036d41aac..9c74ed940acd 100644
--- a/drivers/clk/clk_sandbox_ccf.c
+++ b/drivers/clk/uccf/clk_sandbox_uccf.c
@@ -112,9 +112,9 @@ static const struct clk_ops clk_gate2_ops = {
 	.disable = clk_gate2_disable,
 	.get_rate = clk_generic_get_rate,
 };
 
-struct clk *sandbox_clk_register_gate2(struct device *dev, const char *name,
+struct clk *sandbox_clk_register_gate2(struct udevice *dev, const char *name,
 				       const char *parent_name,
 				       unsigned long flags, void __iomem *reg,
 				       u8 bit_idx, u8 cgr_val,
 				       u8 clk_gate2_flags)
diff --git a/include/sandbox-clk.h b/include/sandbox-clk.h
index c2616c27a44a..eb02a474c741 100644
--- a/include/sandbox-clk.h
+++ b/include/sandbox-clk.h
@@ -57,9 +57,9 @@ static inline struct clk *sandbox_clk_gate(const char *name, const char *parent,
 	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT,
 				 reg, bit_idx, clk_gate_flags, NULL);
 }
 
-struct clk *sandbox_clk_register_gate2(struct device *dev, const char *name,
+struct clk *sandbox_clk_register_gate2(struct udevice *dev, const char *name,
 				       const char *parent_name,
 				       unsigned long flags,
 				       void __iomem *reg, u8 bit_idx,
 				       u8 cgr_val, u8 clk_gate_flags);

-- 
2.51.0

