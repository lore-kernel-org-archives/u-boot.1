Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A40CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7170C838EF;
	Fri, 17 Oct 2025 17:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="GigI6l0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4E783852; Fri, 17 Oct 2025 17:28:02 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F2EB83804
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id D56A725D5F;
 Fri, 17 Oct 2025 17:27:59 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sYU1enZJKeR6; Fri, 17 Oct 2025 17:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714879; bh=wr8PbUnr5NEkgpUU8FnAgmAtCGa+cxgR4vJSh6VIdzk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GigI6l0DPcRI5Iw3f+agkbsaV4cA7plpPPpPVYAZzLSzP9aKFXjLSN8WIlQ6erMN1
 1f8AY256B+I4QbcRReZuugBPEkBUowIx8Zd0uJeIsB2PjtMsl49Ev+X97wkcITwdFQ
 xtIIZUYZKv/jYf9qZ7NkZRZrbr/lxocZ9A6b/lM1KBN0d9zse3yi2aN+CeBsQaEwfK
 SU7Dnq0/qp6Jz0K82Roa7CacjpbZPHF1NaIzlZ9fgVOGOKy/nioguOcY+cmKUsw0EK
 1DFz53jMwdjxMKnpDeibURu8LfbvEqSgbobGLIefyG34xuLp90lOq1IJYxwQhnY/ca
 k07OOkkSgG4Xw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:57:40 +0530
Subject: [PATCH 1/2] pinctrl: exynos: bind GPIO driver along with pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-pinctrl-exynos7870-v1-1-beaa92f95a0c@disroot.org>
References: <20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org>
In-Reply-To: <20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714868; l=4206;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=wr8PbUnr5NEkgpUU8FnAgmAtCGa+cxgR4vJSh6VIdzk=;
 b=HwsJwNwkoV4m5vC4mjb78hrN3iK+OS211FIwcfK4PHE4RH3CpIoRiS8U9zfo1IJ1egt+rvGpx
 SZPvzlO1VlaBgabvA1deI6/NgjVKyteZ37m4G6x0A5z7PyFt2BfLCD6
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

The devicetree of Samsung devices typically have the pin controller and
GPIO bank descriptors under the same pinctrl node. In U-Boot, these are
handled by two separate drivers. It is not possible to invoke both
drivers from a single node compatible.

Bind the GPIO driver on pinctrl driver bind, with the same OF node as
the pinctrl driver. This solution is already being used in other pinctrl
drivers. The hierarchy, as represented in `dm tree`, is as follows:

  pinctrl@13750000
  |-- gpio-banks
  |   |-- gpr0-gpio-bank
  |   |-- gpr1-gpio-bank
  |   |-- gpr2-gpio-bank
  |   |-- gpr3-gpio-bank
  |   `-- gpr4-gpio-bank
  |-- sd0-bus-width1-pins
  |-- sd0-bus-width4-pins
  |-- sd0-bus-width8-pins
  `-- sd0-clk-pins

Since a bind function doesn't exist, create and add it to all pinctrl
drivers.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c     | 11 +++++++++++
 drivers/pinctrl/exynos/pinctrl-exynos.h     |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos7420.c |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos78x0.c |  1 +
 drivers/pinctrl/exynos/pinctrl-exynos850.c  |  1 +
 5 files changed, 15 insertions(+)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index b37282fa9d6734b7c5b547930d05b5b65d5aa4e3..4c06b41c7aa102775fa6043dac1182626291a7ee 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -7,6 +7,7 @@
 
 #include <log.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <errno.h>
 #include <asm/io.h>
 #include "pinctrl-exynos.h"
@@ -178,3 +179,13 @@ int exynos_pinctrl_probe(struct udevice *dev)
 
 	return 0;
 }
+
+int exynos_pinctrl_bind(struct udevice *dev)
+{
+	/*
+	 * Attempt to bind the Exynos GPIO driver. The GPIOs and
+	 * pin controller descriptors are found in the same OF node.
+	 */
+	return device_bind_driver_to_node(dev, "gpio_exynos", "gpio-banks",
+					  dev_ofnode(dev), NULL);
+}
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.h b/drivers/pinctrl/exynos/pinctrl-exynos.h
index da666777581e4de5adb6078d7acf5048bbff4041..73cc2ce4117b4254c376c8e1b56b3f310a4d9c72 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.h
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.h
@@ -97,5 +97,6 @@ void exynos_pinctrl_setup_peri(struct exynos_pinctrl_config_data *conf,
 int exynos_pinctrl_set_state(struct udevice *dev,
 		struct udevice *config);
 int exynos_pinctrl_probe(struct udevice *dev);
+int exynos_pinctrl_bind(struct udevice *dev);
 
 #endif /* __PINCTRL_EXYNOS_H_ */
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos7420.c b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
index 8fdf60715a53cd8fe18c65744af3a49023056aa1..b1d983fd383cbeb10295272b35b36c7d9971fcf7 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos7420.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
@@ -114,4 +114,5 @@ U_BOOT_DRIVER(pinctrl_exynos7420) = {
 	.priv_auto	= sizeof(struct exynos_pinctrl_priv),
 	.ops		= &exynos7420_pinctrl_ops,
 	.probe		= exynos_pinctrl_probe,
+	.bind		= exynos_pinctrl_bind,
 };
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos78x0.c b/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
index 61b98443daf3d5d13f1004bcb8ec41707ef94c91..cc01028add123765f9c652e4be46967a20800295 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
@@ -115,4 +115,5 @@ U_BOOT_DRIVER(pinctrl_exynos78x0) = {
 	.priv_auto = sizeof(struct exynos_pinctrl_priv),
 	.ops		= &exynos78x0_pinctrl_ops,
 	.probe		= exynos_pinctrl_probe,
+	.bind		= exynos_pinctrl_bind,
 };
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos850.c b/drivers/pinctrl/exynos/pinctrl-exynos850.c
index 3ec2636e0d878ced252c851ae622db046f246c9e..5bf09ae20ee526b7c221448d076697ca80195fcf 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos850.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos850.c
@@ -122,4 +122,5 @@ U_BOOT_DRIVER(pinctrl_exynos850) = {
 	.priv_auto	= sizeof(struct exynos_pinctrl_priv),
 	.ops		= &exynos850_pinctrl_ops,
 	.probe		= exynos_pinctrl_probe,
+	.bind		= exynos_pinctrl_bind,
 };

-- 
2.51.0

