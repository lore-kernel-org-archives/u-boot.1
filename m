Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0B4D15DA5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12318885F4;
	Mon, 21 Oct 2024 17:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MNgm/+1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A7588E19; Mon, 21 Oct 2024 17:13:35 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7E1885D1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id CFDF9FF803;
 Mon, 21 Oct 2024 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1729523612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AhPpKtIEppJU7l/blodvXjFNazLsZDCe/iyuwsYm/E8=;
 b=MNgm/+1Jb45ufe+04T3d7NBtKPLj5pJFrhWbuZpupBl7dBC7l07uvPo6iUiOv4YQG8iHLC
 oZaJQ8PhW538HRbgk+BUEKV4ExaMahGiWv0RUvqQ2DbINMKe4anL3aIrOtFM6vdEftZseJ
 O5Idjr7T/lG9FXGn2t+w/ijcpWkOSJRdh/CWqtOrOPO6WzKxhEX22ArgYu1gna4ZI1p5HF
 eHu/JTQU3XgewYNWTP+q76muXRINosx+sVO4Lm8SsaB+kA11IAu1emTTML9Zo/3I5WR9Xc
 VSaMBtGpDT6cYydbpM3OYkK6ir5dilKpJGTtF+h9H6Eup54TIyprB0UcN1Yo8g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Tom Rini <trini@konsulko.com>,
	Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 0/6] memory: ti-aemif: Add DM support
Date: Mon, 21 Oct 2024 17:13:24 +0200
Message-ID: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
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

Hi all,

This patch series aims to add DM support for the AEMIF controller that
can be found in the DaVinci SoCs.

This controller has already a driver used by the Keystone SoCs so I
add my work to it.

As we can now easily import Linux device-trees, I try to stick the
most I can to the Linux bindings of the AEMIF controller. To do so I add
an 'intermediate' driver called 'ti-aemif-cs'. It's in charge of
configuring timings for a given chip select of the AEMIF controller.

Bastien Curutchet (6):
  memory: ti-aemif: Correct macro to ensure avoiding precedence issues
  memory: ti-aemif: Make AEMIF driver architecture agnostic
  memory: ti-aemif: Add ARCH_DAVINCI to architectures that uses TI_AEMIF
  memory: ti-aemif: Wrap the CS configuration into a function
  memory: ti-aemif: Add DM support
  memory: ti-aemif-cs: Compute timing configuration from DT parsing

 arch/arm/include/asm/ti-common/ti-aemif.h |   1 +
 board/ti/ks2_evm/board.c                  |   4 +-
 drivers/memory/Kconfig                    |   2 +-
 drivers/memory/Makefile                   |   2 +-
 drivers/memory/ti-aemif-cs.c              | 183 ++++++++++++++++++++++
 drivers/memory/ti-aemif-cs.h              |   4 +
 drivers/memory/ti-aemif.c                 |  63 +++-----
 7 files changed, 215 insertions(+), 44 deletions(-)
 create mode 100644 drivers/memory/ti-aemif-cs.c
 create mode 100644 drivers/memory/ti-aemif-cs.h

-- 
2.47.0

