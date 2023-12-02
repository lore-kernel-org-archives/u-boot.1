Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3850FC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 06:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5932F87136;
	Sat,  2 Dec 2023 07:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701498372;
	bh=5RwFMfo/8+qkONiEKvb12gQP6S1VhsSdnWpPT5byk0E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hN0EkCJktgGsfqBupac8hpW0Gw69iHFUNu13Uk5Wv5lT2sLhMchzFIonEzddRM5cH
	 RNywIJzu6jF0JgYFjurHVodzi9yA8mcqHHJ2wRBOAR0MORvJfFORsE/H1rVXDMXiUo
	 s6WA3pV91Lm17yqJr1VfJT64XzxmxBIhoFTu4K4pdVWUCUYMv/Cwys/eWORyKUdaLa
	 fhIdSuoFR0DpxIhc4sPnroG2b3Fjz1cv074aMo9eiYx98g6Avr0exrh7+J/pc2IO9C
	 mURb4RBeJCZU1m5/kX8aeXK4HrMBRR+NzXmfjoXZ7DjBMjuaiD2AZSW4i9Gm/mg17W
	 zLydr9D/I7mFg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 91FC38642A;
 Sat,  2 Dec 2023 07:26:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701498367;
 bh=5RwFMfo/8+qkONiEKvb12gQP6S1VhsSdnWpPT5byk0E=;
 h=From:To:Cc:Subject:Date:From;
 b=tbVkVzP5gOkwLHssWPei16uOZszWIaN/N7JsMzSbM6zTHr6QJgc9PwCwbjPKfpqsa
 X82O2fiKybZhnBOiBMrcaMaWLfLQxKPi16RTovI1SOIOob+xWWyX+6TtKU3jQIXpW1
 BFAtw6gpV9WZK+RZb6Adw4Vwe0ZNGPQPwXDHgRTFSP17j48XLR0uNnLSrhvMkCPcz9
 wgXoUazmor56JV77dFSf5Fi2MLpM2x2wubrvmdDVLCFd6BItG99x+mOEMJf5Si5QXg
 nQAtdkX0Bu/cNDxGhVM2ASiu9yZhlbtqQf1b2DZJxzAPKS+6eZo6VDLmD8V3dP+cDu
 YU56dzfik01kQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Hector Martin <marcan@marcan.st>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PULL] u-boot-usb/master
Date: Sat,  2 Dec 2023 07:25:14 +0100
Message-ID: <20231202062552.415353-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

The following changes since commit 43f2873fa98b1da6eb56d756315c7bd7db63db27:

  MAINTAINERS: Step up as co-maintainer of Tegra SOC platform (2023-11-28 11:23:02 -0500)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 493e0e2577bfe11b3065a30a6f5c827f95c1df94:

  usb: USB_XHCI_PCI depends on PCI (2023-12-01 16:01:59 +0100)

----------------------------------------------------------------
Hector Martin (9):
      usb: xhci: Guard all calls to xhci_wait_for_event
      usb: xhci: Better error handling in abort_td()
      usb: xhci: Allow context state errors when halting an endpoint
      usb: xhci: Recover from halted bulk endpoints
      usb: xhci: Fail on attempt to queue TRBs to a halted endpoint
      usb: xhci: Do not panic on event timeouts
      usb: xhci: Fix DMA address calculation in queue_trb
      usb: hub: Add missing reset recovery delay
      usb: storage: Use the correct CBW lengths

Heinrich Schuchardt (1):
      usb: USB_XHCI_PCI depends on PCI

Jonas Karlman (1):
      usb: dwc3-generic: Use combined glue and ctrl node for RK3588

 common/usb_hub.c                |  7 ++++
 common/usb_storage.c            | 22 ++++++++-----
 drivers/usb/dwc3/dwc3-generic.c |  1 +
 drivers/usb/host/Kconfig        |  2 +-
 drivers/usb/host/xhci-ring.c    | 72 ++++++++++++++++++++++++++++++++---------
 drivers/usb/host/xhci.c         |  9 ++++++
 include/usb/xhci.h              |  2 ++
 7 files changed, 90 insertions(+), 25 deletions(-)
