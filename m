Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D869CDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 09:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD66F8491C;
	Thu, 25 Jun 2026 11:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VYI+OEkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 765E98494B; Thu, 25 Jun 2026 11:05:44 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6173784894
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 11:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5FC394E408C8;
 Thu, 25 Jun 2026 09:05:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 20D7E5FF03;
 Thu, 25 Jun 2026 09:05:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0EE4C106C841A; 
 Thu, 25 Jun 2026 11:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782378339; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=944wr+SRMQzeQDLnKtnIFgAE/ZJnI4/QuoXuVE/p1KU=;
 b=VYI+OEkqry0cOTs0RY69teQ1OAc78YRFPhLK1VMhP/hzINi7TGaVLWMc7QOIBthrO0/Bm2
 eAmjyravCMLbLtWUCjJ46IlRzck/TDlRwMjw8PS1LeSGZVhGK+docav+VgS4fvgVkyakiT
 ICTJxs1Jb+eFvik5UJtpqrDRX4WTCIDynlMUUTGCylZ2FTjeWtoJGQSSFGVBWrm4kVFaCC
 8iAFLJqx44OcbalNI5DS0rG5//C4uufRA9695/C/Xa8T5Kg8vWXrR2fJ9DLFegNpRW95YV
 ok5KRPpg/uka1822NfVYqXN9dDRX1qjpH0iWKYe6VLLwPHR6yXFKB+52fWhXZg==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH 0/2] usb: gadget: Add Renesas RZ/N1 USBF driver
Date: Thu, 25 Jun 2026 11:05:24 +0200
Message-Id: <20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDWhmhJXEYvSwViUdBAhvbti+
 ZKffwOjJ2Sokxs8HsS0uIg8TaCfjBtRkI0GmUmdaSmFv1wudu4GoWyhla5Kg0pB7FePA53fq2l
 /897N2G/vAEJ4ACRIXqxtAAAA
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
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
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

This series adds support for the Renesas USBF controller, which is used in
the RZ/N1 SoC. This will facilitate exposing USB gadgets from RZ/N1 SoCs in
U-Boot.

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
base-commit: aa64585125f68908f675693ccb40c6f726e2251e
change-id: 20260622-rzn1-usbf-4d364687ae44

Best regards,
--  
Romain Gantois <romain.gantois@bootlin.com>

