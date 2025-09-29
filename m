Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EFDCAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 19:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2088319C;
	Mon, 29 Sep 2025 21:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ZR2YtIqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDCE08329F; Mon, 29 Sep 2025 21:52:54 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE5E82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 21:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: e8e14948-9d6d-11f0-ad1a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e8e14948-9d6d-11f0-ad1a-005056999439;
 Mon, 29 Sep 2025 21:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=DcBWAHumYwDmM4bqp+X0zmD9gMIs+FGA586MkGUhadA=;
 b=ZR2YtIqVSlaRoaw9LoiFK81RVpVHKulmFRNl6fOqyoC+yuQpROX02+mm6HHo9kyCrV6FteR7DFowR
 KC7YrEoGM9xwFZzAgUY5Ay53KOhLvjCcWz0qO0fFbPcOMNNiDk3EpTrCOPgApOqwmcIKUdWi18FJq2
 gzphXhMhTJRjKN6c=
X-KPN-MID: 33|Gt+RfhSlzezOjzztKbALvxxifeVLDrGrwQzZJBKQZtUUgNJVHgdATzpFBPttecx
 y0Pwx5uFO8hSKqZOiabMvMs5J9NeKyu1vb3yj7uLNGoI=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|5wB9srYLpjtdf4HcIxg/AXBouxUoAsOh1U4J3p16dHjGZTSL6Aq7antw2SccZOf
 N8Q1OTLaOcVp3HemAOFuoXw==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e1ce4240-9d6d-11f0-8d3e-00505699b758;
 Mon, 29 Sep 2025 21:52:51 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	trini@konsulko.com,
	Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2 0/3] Load ASMedia XHCI controller firmware
Date: Mon, 29 Sep 2025 21:52:38 +0200
Message-ID: <20250929195241.70351-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some of the Apple desktop machine have a PCI ASMedia XHCI controller
that needs firmware to be uploaded to function.  This firmware is
placed on the EFI system partition by the Asahi installer.  So this
series sets up a file system firmware loader that reads from that
partition and ports the Linux driver that uploads this firmware to
the controller.  With this series, users can use USB devices (such
as a keyboard) when they are connected to USB ports handled by the
ASMedia XHCI controller.  This includes the type-A ports on the
M2 Mac mini for example.

I submitted the first version of this series over a year ago.  Sorry
for letting this linger for so long.  Back then Marek Vasut provided
some good feedback that I incorporated in this v2.  Back then we
concluded that env_set() failures should print a warning instead of
doing a bitwise or of the return value.  But env_set() already prints
a warning, so it makes more sense to just ignore the return value.
This is common practice in the U-Boot tree.

---

Changes in v2:
- Ignore env_set() return value
- Sort readb_poll_sleep_timeout() before readl_poll_sleep_timeout()
- Use read_poll_timeout() instead of open-coded timeout loops
- Make asmedia_read_reg() return an error code


Mark Kettenis (3):
  apple: Set up file system firmware loader
  iopoll: Add readb_poll_sleep_timeout
  usb: xhci-pci: Load ASMedia XHCI controller firmware

 MAINTAINERS                         |   1 +
 arch/arm/mach-apple/board.c         |  59 ++++
 drivers/usb/host/Kconfig            |  11 +
 drivers/usb/host/Makefile           |   1 +
 drivers/usb/host/xhci-pci-asmedia.c | 410 ++++++++++++++++++++++++++++
 drivers/usb/host/xhci-pci.c         |   9 +
 include/linux/iopoll.h              |   3 +
 include/usb/xhci.h                  |   3 +
 8 files changed, 497 insertions(+)
 create mode 100644 drivers/usb/host/xhci-pci-asmedia.c

-- 
2.50.1

