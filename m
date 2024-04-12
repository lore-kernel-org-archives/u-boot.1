Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878CDC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B842588020;
	Fri, 12 Apr 2024 22:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Q8u76rqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5124881F8; Fri, 12 Apr 2024 22:26:23 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CCF87E4D
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202404122026205380a31e15cb814457 for <u-boot@lists.denx.de>;
 Fri, 12 Apr 2024 22:26:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ExaRqNnoCUqk4zsDiRtsvxMAbtPhKkNUF3cYcPMdizw=;
 b=Q8u76rqoB3GhU/vlnAEa25yte5BOpmGR17FeZe2mUyTBF237/RpF7pZ1acgGyO9tieAyqU
 zagmWIokQuWVgtq8xLtlIuhSSfXoMofjWldcmQKZEpcd+XmT9Bt625m/2q0OZSFYopWU+kC7
 /7sg3VOIfU992f6goHxauqYMW3Aj8=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marex@denx.de>, Felipe Balbi <felipe.balbi@linux.intel.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon <nm@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 0/6] usb: dwc3: gadget: avoid EP command timeout
Date: Fri, 12 Apr 2024 22:26:00 +0200
Message-ID: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
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

While there are happy users who successfully have been using DFU on TI
AM62x [1][2], there are also others who were not so lucky up to now [3].

I felt into latter category and was wondering why I observe this:

--
U-Boot SPL 2024.04-61876f393762 (Apr 11 2024 - 09:27:15 +0000)
...
Trying to boot from DFU
dwc3-generic-peripheral usb@31000000: found 16 IN and 16 OUT endpoints
dwc3-generic-peripheral usb@31000000: Event buf 81e0a200 dma 00000000x length -2115984896
...
dwc3-generic-peripheral usb@31000000: initializing ep0out
...
dwc3-generic-peripheral usb@31000000: initializing ep15in
registering UDC driver []
dwc3-generic-peripheral usb@31000000: gadget no-function data soft-connect
dwc3-generic-peripheral usb@31000000: Enabling ep0out
dwc3-generic-peripheral usb@31000000: Command Complete --> 0
dwc3-generic-peripheral usb@31000000: failed to enable ep0out
failed to start : -110
g_dnl_register: failed!, error: -110
g_dnl_register failedSPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###
--

It turned out the timeout happened in dwc3_send_gadget_ep_cmd() on
DWC3_DEPCMD_SETEPCONFIG command and while the "timeout" has been increased
in Linux from 500 to 1000 and later 5000, in my case it took more than
77000 1us cycles to successfully complete.

It turns out that Linux DWC3 gadget code has been improved in the meanwhile
to follow DWC3 programming guide more precisely. Porting the following
Linux patches solved the timeout issue in U-Boot SPL on TI AM6232.

Strictly speaking
"usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer" and
"usb: dwc3: gadget: properly check ep cmd" are not required to tackle
the observed timeout, but it keeps the whole code block in sync with
Linux v6.8.

Felipe Balbi (4):
  usb: dwc3: gadget: combine return points into a single one
  usb: dwc3: gadget: clear SUSPHY bit before ep cmds
  usb: dwc3: gadget: only resume USB2 PHY in <=HIGHSPEED
  usb: dwc3: gadget: properly check ep cmd

Thinh Nguyen (2):
  usb: dwc3: gadget: Check ENBLSLPM before sending ep command
  usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer

 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 47 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

1: https://git.ti.com/cgit/ti-u-boot/ti-u-boot/tree/configs/am62x_evm_r5_usbdfu_defconfig?h=09.02.00.009
2: https://lore.kernel.org/all/20240112085317.1866449-1-sjoerd@collabora.com/T/
3: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1162644/sk-am62-am62-android-fastboot-0-issue?tisearch=e2e-sitesearch&keymatch=SK-AM62

-- 
2.44.0

