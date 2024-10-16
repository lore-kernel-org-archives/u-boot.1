Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BA6D1AD2E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B57388E5F;
	Wed, 16 Oct 2024 11:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B59E888E9D; Wed, 16 Oct 2024 11:00:00 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BFC88D15
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 10:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=billy_tsai@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 16 Oct
 2024 16:59:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 16 Oct 2024 16:59:55 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <trini@konsulko.com>, <ryan_chen@aspeedtech.com>,
 <chiawei_wang@aspeedtech.com>, <BMC-SW@aspeedtech.com>, <joel@jms.id.au>,
 <billy_tsai@aspeedtech.com>, <fr0st61te@gmail.com>, <clamor95@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <michal.simek@amd.com>,
 <paul.barker.ct@bp.renesas.com>, <piotr.wojtaszczyk@timesys.com>,
 <andre.przywara@arm.com>, <jim.t90615@gmail.com>, <kabel@kernel.org>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>, <ye.li@nxp.com>,
 <pbrobinson@gmail.com>, <u-boot@lists.denx.de>
Subject: [PATCH v1 0/3] Support Aspeed SGPIO controller
Date: Wed, 16 Oct 2024 16:59:52 +0800
Message-ID: <20241016085955.314236-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
with 80 pins, AST2500/AST2400 SoC has 1 SGPIO master interface that
supports up to 80 pins.

Billy Tsai (3):
  gpio: Add Aspeed SGPIO driver
  ARM: dts: ast2500: Add SGPIO to device tree
  ARM: dts: ast2600: Add SGPIO to device tree

 arch/arm/dts/ast2500-evb.dts             |   5 +
 arch/arm/dts/ast2500.dtsi                |  20 ++
 arch/arm/dts/ast2600-evb.dts             |  10 +
 arch/arm/dts/ast2600.dtsi                |  40 +++
 drivers/gpio/Kconfig                     |   7 +
 drivers/gpio/Makefile                    |   1 +
 drivers/gpio/gpio-aspeed-sgpio.c         | 310 +++++++++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl_ast2500.c |   1 +
 drivers/pinctrl/aspeed/pinctrl_ast2600.c |  10 +
 9 files changed, 404 insertions(+)
 create mode 100644 drivers/gpio/gpio-aspeed-sgpio.c

-- 
2.25.1

