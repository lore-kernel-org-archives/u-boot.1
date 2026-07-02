Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1AFC43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65C684CB6;
	Thu,  2 Jul 2026 10:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aI/E61uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5992F84CB4; Thu,  2 Jul 2026 10:11:22 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED1584C85
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 78912C4FED4;
 Thu,  2 Jul 2026 08:11:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 26C565FF03;
 Thu,  2 Jul 2026 08:11:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08C55104C96DA; 
 Thu,  2 Jul 2026 10:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782979877; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=hAVotZ5ABhRKoVM59vHz60TmZdgANNR/kPIU4OnsLEs=;
 b=aI/E61uckd3ryCNCL81pGxzMKfUIic4KZxoYVHwXLLFnCswBusCquPKWbQfzBFRQ7CEXgv
 UT4wkE1rHyWpj82OwkW1tbC6segzHZuY5Qpt//bvCvSuRGwMcDo6VkM64rsZ93eRXoLWnc
 B3iQ8EhaSje81Wcta/4NZgdH0zVNmPtmihBa55ZKpXWehKQRLsbQbf56nHi9Uv0s9QpeVt
 BYfMbVxOMOjX1EFMTHnilamAerdEXgM5jC1Zo0lwIU0QUP8uwyyNGqaOfypeIQO3iXHBoI
 fLOQtXZJ2ax6HC8vqaqJDwJz1lNeg0hVXkdZ1ph+QM49jL6uB7VrCtRRljzyJQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v2 0/2] usb: gadget: Add Renesas RZ/N1 USBF driver
Date: Thu, 02 Jul 2026 10:11:07 +0200
Message-Id: <20260702-rzn1-usbf-v2-0-00ceecebaea6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NQQ6CMBAAv0L2bE1baiGe/Ifh0JZF1mhrWmhUw
 t8FjInHSSYzEySMhAmOxQQRMyUKfgG5K8D1xl+QUbswSC4111Ky+PaCjcl2TLWlVrquDCoFi/+
 I2NFza52bL6fRXtENa2A1ekpDiK9tlsXq/bqHv24WjDOOwpR1V9laupMNYbiR37twh2ae5w8tU
 +b8tgAAAA==
X-Change-ID: 20260622-rzn1-usbf-4d364687ae44
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

Hello everyone,

This is version two of my series which adds support for the Renesas USBF
controller, which is used in the RZ/N1 SoC. This will facilitate exposing
USB gadgets from RZ/N1 SoCs in U-Boot.

The driver was ported from the Linux kernel. The following features were
removed to reduce the memory footprint of the driver, and to avoid
including features not relevant to U-Boot:

 - Suspend/resume
 - Handling of endpoints > 2
 - Dynamic detection of endpoint DMA capability (DMA capability is
   predetermined for each endpoint anyway).

Best regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Provided the original Linux commit hash.
- Corrected a few spelling mistakes.
- Link to v1: https://patch.msgid.link/20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com

To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: George Chan <gchan9527@gmail.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Herve Codina (1):
      usb: gadget: Add Renesas RZ/N1 USBF controller support

Romain Gantois (1):
      linux/list.h: Add list_is_first()

 MAINTAINERS                       |    5 +
 drivers/usb/gadget/Kconfig        |    9 +
 drivers/usb/gadget/Makefile       |    1 +
 drivers/usb/gadget/renesas_usbf.c | 3036 +++++++++++++++++++++++++++++++++++++
 include/linux/list.h              |   10 +
 5 files changed, 3061 insertions(+)
---
base-commit: c03e40b49af8d9985a18f04c1218b8c50ce1dd74
change-id: 20260622-rzn1-usbf-4d364687ae44

Best regards,
--  
Romain Gantois <romain.gantois@bootlin.com>

