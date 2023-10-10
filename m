Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14B0CD68E8
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B793086C67;
	Tue, 10 Oct 2023 11:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IZFV2pAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A7F86DA2; Tue, 10 Oct 2023 11:03:15 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7E886459
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E204AE0003;
 Tue, 10 Oct 2023 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696928586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fa+yUscZqtUfCFllY1tDxmAc84T2WVJPl+sgrUhruoM=;
 b=IZFV2pACM4OLZsdpA7D8AOvrML5CNX6Nxnjtb1ROKfVvjC+ac2XqxNMLZZfukj01jxm2YO
 6P1ubuyaIgl/gw+CATeK7P19+QfPp0Wrbr95hMY6vBjK4v/6adMqmM1ojTQiTOKoMXJz/c
 DZEZd0N3myxhSlpVVMt1I1IEm7jBZdnVz5oeCZBYyp1wxvSyR4LTXVqAelOyHRs5gqVuao
 XkjA/JTTeFV/O5eykZ5vx4PCmTFTwx3FQ8lSsaz6A9hE7bAL8sOmobuIp37Hthpxwv50kD
 uv97jhXg2yjXOox7qyNM1BMXD/e2Il2sT0mZ71/rHH20wMrt7lqiT9zEfVoz1g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marek.vasut@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/3] Improve the experience with USB gadgets
Date: Tue, 10 Oct 2023 11:03:01 +0200
Message-Id: <20231010090304.49335-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

Try to ease the use of USB gadgets for people not fully aware of all the
terms and constraints. With more helpful error messages a little bit of
guidance anyone should be able to adapt to the bind/unbind game that is
now necessary with USB gadgets.

The idea is to eventually get proper USB composite gadget support, but
that is a longer term goal.

Changes in v3:
* First patch is new.
* Collected the tags received.
* Imply CMD_DM from CMD_BIND.

Miquel Raynal (3):
  cmd: Change the dependencies between CMD_BIND and USB_GADGET
  cmd: bind: Try to improve the (un)bind help
  usb: udc: Try to clarify an error message

 cmd/Kconfig                       |  2 +-
 cmd/bind.c                        |  4 ++++
 drivers/usb/gadget/Kconfig        |  1 +
 drivers/usb/gadget/udc/udc-core.c | 13 ++++++++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.34.1

