Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BEFC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 890FC8497A;
	Thu,  2 Jul 2026 12:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F52849A3; Thu,  2 Jul 2026 12:08:56 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E64684409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=billy_tsai@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 2 Jul
 2026 18:08:37 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Jul 2026 18:08:37 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH 0/4] pinctrl: aspeed: Add AST2700 pinctrl drivers
Date: Thu, 2 Jul 2026 18:08:33 +0800
Message-ID: <20260702-pinctrl-v1-0-4d2bd89fc213@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKE4RmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMj3YLMvOSSohxdA+PEtDQjw6SUNBNjJaDqgqLUtMwKsEnRsbW1ABA
 +Tm5ZAAAA
X-Change-ID: 20260702-pinctrl-03aff21bdf43
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Peng Fan <peng.fan@nxp.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>, Sean Anderson
 <sean.anderson@linux.dev>, Michal Simek <michal.simek@amd.com>, "Leo Yu-Chi
 Liang" <ycliang@andestech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782986917; l=2630;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=fLu2vOu0mOXJqZHhjGoSRKmYTF8sTBvVAzTQ2FplZ5c=;
 b=fFXIYN4wx2HElDtSi8fw53CTzfvANXRKmuyXGqcICLXxPpOmmueSZsr37FbfrE/WKHqsVstRM
 AnoV8Zmu8j3COAedqWXQA9ndsFVPMLs8NlKlnK693CkqkX3y6AIqWmq
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
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

The AST2700 is Aspeed's 7th-generation BMC SoC with a dual-die
architecture: SoC0 (CPU die) and SoC1 (I/O die) each have their own SCU
with independent multi-function pin controls. Initial AST2700 platform
support is already merged in next, including the ast2700.dtsi pinctrl0
and pinctrl1 nodes, but no pinctrl driver backs them yet.

This series adds one pinctrl driver per die, each followed by a patch
adding its pin configuration support. Both drivers use the generic
pinctrl framework and are compatible with the Linux kernel device tree
bindings, using the same group and function names as the Linux
aspeed,ast2700-soc0/soc1-pinctrl drivers so pin states can be shared
between the kernel and U-Boot device trees.

Patch 1 adds the SoC0 driver, which models each (function, group) pair
as a flat register mask/value table covering eMMC, VB, VGA DDC, JTAG
master port select, PCIe RC PERST and USB2/USB3 port routing. Patch 2
adds SoC0 pin configuration support: every GPIO18A/GPIO18B ball has
its own IO control register providing a 3 mA to 41 mA drive strength
selector and bias control.

Patch 3 adds the SoC1 driver, porting the per-pin 4-bit multi-function
selector scheme (220 pins, 238 groups, 217 functions) together with
the virtual pins for PCIe RC2 PERST, the USB2 port C/D mode and SGMII
controls. Patch 4 adds SoC1 pin configuration support: a per-pin bias
enable bit and sparse 2-bit drive strength fields (4 mA to 16 mA in
4 mA steps) mirroring the Linux driver layout.

The bias-disable, bias-pull-down, bias-pull-up and drive-strength
properties can be applied per pin or per group. Both drivers implement
gpio_request_enable so the GPIO driver can reclaim pins through the
gpio-ranges already present in ast2700.dtsi, and provide
get_pin_muxing so "pinmux status" reports the active signal of every
pin.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Billy Tsai (4):
      pinctrl: aspeed: Add AST2700 SoC0 pinctrl driver
      pinctrl: aspeed: Add AST2700 SoC0 pinconf support
      pinctrl: aspeed: Add AST2700 SoC1 pinctrl driver
      pinctrl: aspeed: Add AST2700 SoC1 pinconf support

 drivers/pinctrl/Kconfig                       |   20 +
 drivers/pinctrl/aspeed/Makefile               |    2 +
 drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c |  623 ++++++++++
 drivers/pinctrl/aspeed/pinctrl_ast2700_soc1.c | 1642 +++++++++++++++++++++++++
 4 files changed, 2287 insertions(+)
---
base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
change-id: 20260702-pinctrl-03aff21bdf43

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

