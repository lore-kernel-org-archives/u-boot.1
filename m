Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241B1C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D703760640;
	Thu, 23 Jul 2026 09:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvIdT7qiN4k7; Thu, 23 Jul 2026 09:09:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E104960704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784797785;
	bh=oY/s7tRfXgJwsta8l9Cc7R9gyqg7J8iUXh5Bc64fwGA=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HEs6Uy7JaEy299NNTMPiOPY6wZpSSFNNTfpQX2oY0V0ZHQw7ZAurjQP5zv58MKylf
	 IYLZY6TlOvGZk/sSKiBBP9Ad+lb1evHSUSuqMICJAW4/QWkzBOnccQGiqkS3F0d98t
	 Ahed3HSsSOwFl3jOdGfubHfIu5gXC78ogZYQ9oGsXH3hYgLR7gisEiXJpkftgZK0G5
	 iBZW5j6BnhNv0TXwaUW7QSIF1pD6/0Tsab5DhQhQJfSuHI186JVKwAcT9lFulVtZ6i
	 6++X+QLYTOM5IpUWCEOF0WPEQgfp9wgjm7NdMoDzKmxBC7mQAEJh3AcSOe8qLZagem
	 Le/cY8+XckWFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E104960704;
	Thu, 23 Jul 2026 09:09:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 221072E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0832580C23
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrZemhnrUNKX for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:09:43 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=romain.gantois@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DBD61809BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBD61809BF
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBD61809BF
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:09:42 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550478404D; Thu, 23 Jul 2026 11:09:40 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9CE8803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 11:09:37 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 71E3E1A11A0;
 Thu, 23 Jul 2026 09:09:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3A68F602B8;
 Thu, 23 Jul 2026 09:09:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CAC8D11C1029D; 
 Thu, 23 Jul 2026 11:09:25 +0200 (CEST)
Subject: [PATCH v3 0/2] usb: gadget: Add Renesas RZ/N1 USBF driver
Date: Thu, 23 Jul 2026 11:09:21 +0200
Message-Id: <20260723-rzn1-usbf-v3-0-34dd7c4ddd99@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOQQ7CIBBFr9LMWgxQpI0r72FcAJ1ajIKBlqhN7
 26pMdblS/57MyNEDBYj7IsRAiYbrXczlJsCTKfcGYltZgZOuaSScxJejpEh6paIppRC1pVCIWD
 e3wO29rG0jqcPx0Ff0PQ5kBedjb0Pz+VYYnn37e5W3cQIJRSZKuu20jU3B+19f7Vua/wNcjnxn
 1vR9U+JZ5caRINaoZL/7jRNb+ns6wryAAAA
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
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1784797775; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=oY/s7tRfXgJwsta8l9Cc7R9gyqg7J8iUXh5Bc64fwGA=;
 b=njSD33q15RNHElzeWlcBWI9RItgcvw1az6lo9jck2M2W5ow3Mnb8rAkdfCKefw60Wegfvq
 wgdtyBpFz7GAkbeMOJ/S/VPrasX7pu5G6llS6XjWJ93PHbF5iGfutopMelgu4rOvErHDak
 cpqz3SersOuMolCISuKF4poRnBQp44HwzNi9fKU4t4Q63COhGyTxkBOgSgIb4otoCXn7yF
 Z+u3RoA2cG8gjgSgr5mo3Mm2GEfBUYzjSZFY1jrDRLU1ZRkYve6TvTLUaEqTj2xY/qjXHJ
 Oc6fJrzkgxx6G03eeRwgsHuMG3ZbRjhNYgTYQgUR1FbXtVRw9+AC52Wscql2ZA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=njSD33q1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=romain.gantois@bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="njSD33q1"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Romain Gantois via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Romain Gantois <romain.gantois@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello everyone,

This is version three of my series which adds support for the Renesas USBF
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
Changes in v3:
- Mentionned all removed features in commit log.
- Style corrections in Kconfig.
- Added a call to usbf_detach() in remove().
- Matched indents with Linux driver and stubbed spinlock handling.
- Link to v2: https://patch.msgid.link/20260702-rzn1-usbf-v2-0-00ceecebaea6@bootlin.com

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
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>

---
Herve Codina (1):
      usb: gadget: Add Renesas RZ/N1 USBF controller support

Romain Gantois (1):
      linux/list.h: Add list_is_first()

 MAINTAINERS                       |    5 +
 drivers/usb/gadget/Kconfig        |    9 +
 drivers/usb/gadget/Makefile       |    1 +
 drivers/usb/gadget/renesas_usbf.c | 3118 +++++++++++++++++++++++++++++++++++++
 include/linux/list.h              |   10 +
 5 files changed, 3143 insertions(+)
---
base-commit: 643502070009f20447e196efe2822f5213076bca
change-id: 20260622-rzn1-usbf-4d364687ae44

Best regards,
--  
Romain Gantois <romain.gantois@bootlin.com>

