Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7704ECD3423
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 16:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5B5803C6;
	Fri,  1 May 2026 18:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="g3/0MlVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8DAD80F0E; Fri,  1 May 2026 18:27:10 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979CC80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 18:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202605011627084ee4ed698b000207c0 for <u-boot@lists.denx.de>;
 Fri, 01 May 2026 18:27:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ErLmqOVdfZEih4PmNHAab6evMJTfUfsU+J2b/qFzdOE=;
 b=g3/0MlVKU+AK5qK0I8uRRH5sipAKw1fR5yIpogwM5gEtHMoLdGgTNL8+pbVWJov/B+/Qgr
 SFsHtjdVgr1yBtvZA1wST5zYFveZCcblwrfNs6BpZdfM98VspjCQcAwaqh5jfWbRbA9ZPbFc
 r03O65rM5x+yUtDAg6lC1zinL1MLAUex4YENbtOIy87I8bJlefOhZEsYUpCLDjQ6twJE8XqO
 GdYw7s7HLeSb0qP3dwUeLDyxS/rLpaQ2fvkq05Mt9u9CrS646C4bMBgsSWmJfcpIqO6kzY0u
 NHKAzee9XQr9ktU/fabZ4mARmAQh06Fqg7pM4RYCGFRUfkT5xiWLJMDA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: don't build i.MX6/RTxxxx code for all users of CCF
Date: Fri,  1 May 2026 18:27:03 +0200
Message-ID: <20260501162706.543779-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

When commit 1d7993d1d0ef
("clk: Port Linux common clock framework [CCF] for imx6q to U-boot (tag: v5.1.12)")
introduced the parts of Linux Common Clock Framework, it was done for i.MX6
only and even had "depends on SPL_CLK_IMX6Q" conditions. Since commit
ccab06689aa2 ("clk: imx: expose CCF entry for all") the framework can be
re-used with SoCs of other vendors (say, TI), but NXP SoC-specific code is
still being build. Is is especially problematic for size-constrained SPL
images on TI AM62x.

Make the build of the i.MX6/RTxxxx code not only dependent on
CONFIG_$(PHASE_)CLK_CCF, but also on the corresponding CONFIG_ARCH_*
options taking into account that only two platforms seem to use the code in
question.

This saves 2264 bytes on ARM platforms [using CCF].

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/clk/imx/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index f2fd6ff8ca0..53f07bdf70d 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -2,7 +2,9 @@
 #
 # SPDX-License-Identifier: GPL-2.0
 
+ifeq ($(CONFIG_ARCH_MX6)$(CONFIG_ARCH_IMXRT),y)
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-gate2.o clk-pllv3.o clk-pfd.o
+endif
 obj-$(CONFIG_$(PHASE_)CLK_IMX6Q) += clk-imx6q.o
 obj-$(CONFIG_$(PHASE_)CLK_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_CLK_IMX8) += clk-imx8.o
-- 
2.52.0

