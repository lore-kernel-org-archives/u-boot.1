Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4B6CD4F2F
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 13:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BB683C62;
	Thu, 13 Nov 2025 14:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WokVu0vD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YzJubzNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F7583D4A; Thu, 13 Nov 2025 06:44:50 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F4C83C54
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 06:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d6Tk657TYz9tlB;
 Thu, 13 Nov 2025 06:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763012686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sec5ecNDZO6BMd87C9IE5sb5mXz2qVb4CABG0gTiquA=;
 b=WokVu0vDZZ2y9+MHKIToYJ9GXb3D63NrNentF42RWGVBrlIOR31aJGXYHFR87/pHpF6ZIz
 iPt/6LWogKsSZQAmPxpf90n0w0/qwuIhYJ68dtsDCadh5CNhE//clPV9sWzmbIIYTr0ThK
 0PxbnYOYksarptacYBe520dtOvmgdMspaeUfrZ7DuxA3fqLHRMdnUjAgByeNzRSILJ2BXF
 wDh8S5f489we6Pww/J/CdVTw/y1JTpCdDCct4xl4XuqZuD1SbS019CzlqIWwl4Y3f7T1tY
 rJjotd6NXrL6/embVPNuPmqNPjwopbmilgxeqUk+5xgIRgmMFHKjAxu0KW6k4A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=YzJubzNS;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763012684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sec5ecNDZO6BMd87C9IE5sb5mXz2qVb4CABG0gTiquA=;
 b=YzJubzNSCbhpcImyrRHtwV8RZrGRfUQQ3inJB8acc3VWYgBsxNt3GjVIqnHP1Y1mibjDHX
 OkXrFFkhsg88//jqo9eQ72vQIv/t0mZqsusbF8vuVeoU7VcUeUkspNv3UnqCjHAWL6qHQd
 hlPoAylQkd50jmJIdN8eJs4UryzIV7dmRFFipe8nfayucHv7zkUVOI+Cp9sa+t2y7sKWvE
 rzknG6hljrTehjy1sF+r/pQq10HK6K0i67sZA0h9lWSyGcPE5bgM1rttV7oZB9cdodHnky
 eiR6b7hBIXMDqSLOeWfEtsUbTx8Q1LSUcp4VT6MCzketszd5YH3nQiPx7j/2wQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PULL] u-boot-usb/master
Date: Thu, 13 Nov 2025 06:44:23 +0100
Message-ID: <20251113054431.5981-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1rdqp5i7ohwdy51dznkj5xfqnzhngn78
X-MBO-RS-ID: efd3ba92a0e21f33499
X-Rspamd-Queue-Id: 4d6Tk657TYz9tlB
X-Mailman-Approved-At: Thu, 13 Nov 2025 14:16:58 +0100
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

The following changes since commit caa740df9cae5ddc74b18b88a4fea43e27b2fdf6:

  Gitlab: Optimize the job dependency list more (2025-11-11 11:55:16 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 70c3b4c3185c224211dda7273c5ce5f97ffffc5e:

  usb: gadget: Tighten CI_UDC dependencies (2025-11-12 22:13:03 +0100)

----------------------------------------------------------------
Peter Robinson (2):
      omap3: evm: Drop old musb omap3 driver
      usb: musb: drop musb legacy drivers

Tom Rini (4):
      usb: gadget: spl: Add missing dependency for SPL_USB_GADGET
      usb: gadget: Tighten the dependency for DWC2 OTG support
      usb: host: xhci: Make U_BOOT_DRIVER entries unique
      usb: gadget: Tighten CI_UDC dependencies

 Makefile                        |    1 -
 configs/omap3_evm_defconfig     |    1 -
 drivers/usb/Kconfig             |    2 -
 drivers/usb/gadget/Kconfig      |    3 +
 drivers/usb/host/xhci-brcm.c    |    2 +-
 drivers/usb/host/xhci-exynos5.c |    2 +-
 drivers/usb/host/xhci-generic.c |    2 +-
 drivers/usb/host/xhci-mtk.c     |    2 +-
 drivers/usb/host/xhci-mvebu.c   |    2 +-
 drivers/usb/host/xhci-rcar.c    |    2 +-
 drivers/usb/musb/Kconfig        |   20 -
 drivers/usb/musb/Makefile       |    9 -
 drivers/usb/musb/am35x.c        |  138 -----
 drivers/usb/musb/am35x.h        |   81 ---
 drivers/usb/musb/musb_core.c    |  150 -----
 drivers/usb/musb/musb_core.h    |  343 ------------
 drivers/usb/musb/musb_debug.h   |  191 -------
 drivers/usb/musb/musb_hcd.c     | 1161 ---------------------------------------
 drivers/usb/musb/musb_hcd.h     |   93 ----
 drivers/usb/musb/musb_udc.c     |  953 --------------------------------
 drivers/usb/musb/omap3.c        |  129 -----
 drivers/usb/musb/omap3.h        |   38 --
 22 files changed, 9 insertions(+), 3316 deletions(-)
 delete mode 100644 drivers/usb/musb/Kconfig
 delete mode 100644 drivers/usb/musb/Makefile
 delete mode 100644 drivers/usb/musb/am35x.c
 delete mode 100644 drivers/usb/musb/am35x.h
 delete mode 100644 drivers/usb/musb/musb_core.c
 delete mode 100644 drivers/usb/musb/musb_core.h
 delete mode 100644 drivers/usb/musb/musb_debug.h
 delete mode 100644 drivers/usb/musb/musb_hcd.c
 delete mode 100644 drivers/usb/musb/musb_hcd.h
 delete mode 100644 drivers/usb/musb/musb_udc.c
 delete mode 100644 drivers/usb/musb/omap3.c
 delete mode 100644 drivers/usb/musb/omap3.h
