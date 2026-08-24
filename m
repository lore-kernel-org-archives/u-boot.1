Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57138C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19BCE80E26;
	Mon, 24 Aug 2026 16:47:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RSqteGYQkbMf; Mon, 24 Aug 2026 16:47:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589929;
	bh=yDeOTA01iUCFGnOI7//seYzp8jnxHepU9DaKX7kMtjU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FHAZRYB6uWUYipX9xJVOK9Q8X66D2zVi/gr2//XO1A4gJGUyTmc6pfqHsFdBLBfQY
	 o3T18ORaT1vdRkECxjq6GkDLW8699Iw2qjQyeeqnVOfjFV+rlfv3GiWOSaWce2Y9YU
	 /TSOJiyr7Bi/JtfARU+MoyK1fdsAgACZcvkDg7A+Uf7xI+wlDgZ79oAEZAc7h+4Mz2
	 Tc8kiSm/H+75npbhEoI+YTt80E99ZkYzLcOq6srCc1xZSK1DUJ7wToztDgpfGOou3d
	 xcaxh36rNfV0+WibSzuh6OAsIZwPZPj2t7oIs7ZhqM7VzskQnSJ9b7yLguMkiPHg1A
	 ZhvBCDVZYRl/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B93A80F1E;
	Mon, 24 Aug 2026 16:45:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C838279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E55660627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0lbRiesDKljM for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:42:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=c41FbcU0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4211605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:07 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1676648c1eso26052266b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586125; x=1788190925;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yDeOTA01iUCFGnOI7//seYzp8jnxHepU9DaKX7kMtjU=;
 b=c41FbcU0+2fZh5CPW0NpJUxzmqzhYALXq1RJlRprFczYysI1vdGLG86l8DW7YYHYgX
 oBdy+2BiTMWLHzELuArLIt3VW07Ichdb/wQkgs1eXUxgRAK3t5oUxJfP1/t40KSlYCun
 9e2zL/vma91KVwOuZYEvyJ6KBBGF3mroEk/4HU684DRe0Z2I2vYbjiBqxR7w7onfyv8Y
 7BjhioVx2uVMfvyuWRpYEJEmvXMEgWb33k+0Y0+8Y3FrwU8bYH8XxvQRGUt7S266r6e7
 aMx8kmpNT0iSyO7s6+WBQVs5vZHPbIuZKUv1yrFTdvW2CMLO7MWdktbQmxkF0sQYMZPE
 0KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586125; x=1788190925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yDeOTA01iUCFGnOI7//seYzp8jnxHepU9DaKX7kMtjU=;
 b=G7FTo4q2u3sPXI1xCOUajlA8ngEAtABuB91nZIdmSMwg4kC1wjJ4ER+M7KcgUAIKvX
 7iK+G1Pv3fyHqVurLwvEX44t6xaGFQGeOeWPEaQM13MoGC5EPrPvWnsiJjw6JwXoLmEs
 FxA5Gb5c2htP0lswWBvnxRyzd5E1L3pfAkkoKD+V4UdOky6p8gW6AWdAPfFPFstkzWXA
 BYkicuGFEf3a2LRuttzXEBU2ivOmgD9WxCpAlVFJalVFxBo/QJ33V3NGZJOTxmpr33Kl
 San85dfoJ2nNywx0XuwUJDvWC14oqo5KQA+9EIEN8csf/bcMYcrGDRUBkqIlJS79lDYC
 Cwkg==
X-Gm-Message-State: AFuF++lz1OEAtwwblC/HKwsJEnD3Saz7aTVHlZjuupHo5zOWbyvnSy9m
 nA8UJegDsKO6lcFetFcuhhlF0izsePxEe9xE0ksRyB5YKvRHBy+1WsobLFWLkURRnROkgO5jG/b
 IoDZp
X-Gm-Gg: AR+sD11g6ADfp573Cu4K8KFJfwhNI9bOnWCg4QoS9oiBy3Ho/SVqdkNaw0uYZ+rfZ7s
 yVdJIUBgldS5n6lPOb52wv7wbHy0EbEbpAec8jvU3JKtnHLEyYq1nlmywrx9Vx7LwTMDFKEH3ZY
 sOIlDcDRVgsgzOF9xxAJa8TBxdlP7q1okyjBZS0vkkamZ7FrrJ57fsHKQOMwgjBnZ6wXsOw1y9I
 87hidaVmJIHTx8rhYktlGMNJgoEc3Bua/4jrNYstQFFzjd6v0J+VZ00KPrHDSgR5U55LD3WCvvp
 Azuf6l66RDxJRpug4kQPZ1r6RpqdON8jzFqDJsaEPPlVOFcIpe8q9/xH1md9r/Ia/6uj+3BHazf
 Mu3qCmrcpkyWrhWwc+K9SReLM3Nreh7uA0sH+xYAAGgk5iAWpJH7ywdnbt3rpxRfuGu6B38DHhE
 s9B99w+yJ4OT7XYNmgRGjtxzJGJ/wp6Sb7RlWr+vSjBD1L3v+i1EGpnReRHAPFY7FcYgBxeuPaz
 TLwFZ1Git3hKYQ43/6W8w==
X-Received: by 2002:a17:907:d17:b0:c1c:4ae9:b935 with SMTP id
 a640c23a62f3a-c246a6902c5mr1460849166b.3.1787586125374; 
 Mon, 24 Aug 2026 08:42:05 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1278567866b.38.2026.08.24.08.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:42:04 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v7 00/24] usb: dwc3: part 2, make the resynced code work
Date: Mon, 24 Aug 2026 17:41:09 +0200
Message-ID: <20260824154133.217744-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi,

This is part two of two. It applies on top of part one [5], which resets
the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
the build for every board that enables DWC3. This part adds back the
U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
builds and the gadget works again. It builds on Jerome's work [2].

The two parts have to go in together.

The resynced epautoconf matches endpoints on their caps field instead of
on their name. Five UDC drivers never filled that in, so each one gets a
patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
and mtu3. With those and dwc2, every UDC driver in the tree sets caps.

Build tested one board per driver: every DWC3 glue layer in the tree,
dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
musb-new and mtu3. 17 boards in total.

DFU is tested on hardware on BeagleBoard-X15, and on BeaglePlay by
Anshul. ci_udc is tested on an i.MX93 board with ums. The rest is build
tested only.

The branch has both parts [4].

[1] v5: https://lore.kernel.org/u-boot/20260716134305.614278-1-anders.roxell@linaro.org/
[2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[3] dwc2 prep: https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org/
[4] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v7
[5] part one, subject: [PATCH v7 00/63] usb: dwc3: part 1, reset and
    import from Linux v6.16

v6 -> v7:
- Split the series in two. Tom asked for this, so review and iteration
  gets easier. Part one is the reset and the imports, part two makes it
  work.
- No code changes in these 24 patches.
- v6 never reached the list in full. My send died in the middle, so the
  cover letter and the last patches went missing.

v5 -> v6:
- Split the "add helpers" patch into a dm patch and a usb phy patch.
  Mattijs asked for this.
- Kept the U-Boot dwc3 Makefile instead of the kernel one. This is what
  Marek meant with glue drivers that are never compiled or used.
- Brought back samsung_usb_phy.c in an own commit. The restore commit
  deleted it and nothing added it back, so odroid-xu3 lost its USB 3.0
  phy setup.
- Stopped moving functions around in dwc3 gadget.c. Where a function
  still had to move, the commit message now says why. Mattijs said the
  last patches were hard to review because of this.
- Split "fix up musb-new and mtu3" and "fix up xhci and cdns3" into one
  patch per controller. David asked for this.
- Set endpoint capabilities in at91_udc, atmel_usba_udc, ci_udc, musb-new
  and mtu3. Mattijs asked for this on v4, after the VIM3 fastboot
  regression. Each patch sits next to the other fixup for that driver.
- at91_udc now calls usb_add_gadget_udc(). Without it udc-core never sees
  the controller.
- Enabled async callbacks on bind, and added a cache flush and invalidate
  around ep0 transfers. Without these no dwc3 gadget enumerates. Anshul
  found them on BeaglePlay, I hit them on BeagleBoard-X15. DFU works on
  both now.
- ci_udc got udc_start() and udc_stop(). udc-core calls udc_start() on
  bind, ci_udc did not have it, so the board crashed with a synchronous
  abort when ums started. Found on i.MX93, ums works there now.
- udc-core got two more fixes while I looked at that. It checks
  udc_start(), udc_stop() and get_frame() before calling them, they are
  mandatory in the kernel but not in u-boot. And it reports what
  usb_gadget_udc_bringup() returned, before it only said "No UDC
  available".
- Rebased on current mainline. The ci_udc patch shrank a lot: mainline
  gained three ci_udc fixes and the old patch deleted the functions they
  touch.
- Mattijs' dwc2 endpoint fixes [3] are in mainline now, so this series
  has no dependencies left.

Older changes are listed in v5 [1].

Cheers,
Anders
Anders Roxell (24):
  dm: add helpers needed by the resynced DWC3 code
  usb: phy: add the usb_phy helpers needed by the resynced DWC3 code
  usb: gadget: adapt the gadget API after the resync
  usb: gadget: udc: make udc-core build in u-boot
  usb: dwc3: make the core driver build in u-boot
  usb: dwc3: bring back the samsung usb phy driver
  usb: dwc3: make gadget and ep0 build in u-boot
  usb: gadget: udc: enable async callbacks on bind
  usb: dwc3: ep0: flush and invalidate cache around ep0 transfers
  usb: dwc3: make the am62 glue build in u-boot
  usb: gadget: ci_udc: move to the udc-core registration
  usb: gadget: ci_udc: set endpoint capabilities
  usb: gadget: dwc2_udc_otg: fix up after the resync
  usb: gadget: fix up the function drivers after the resync
  usb: gadget: fix up the last UDC drivers after the resync
  usb: gadget: atmel_usba_udc: set endpoint capabilities
  usb: gadget: at91_udc: register with udc-core
  usb: gadget: at91_udc: set endpoint capabilities
  usb: musb-new: fix up after the resync
  usb: musb-new: set endpoint capabilities
  usb: mtu3: fix up after the resync
  usb: mtu3: set endpoint capabilities
  usb: host: xhci: fix up after the resync
  usb: cdns3: fix up after the resync

 drivers/usb/cdns3/ep0.c                |    8 +-
 drivers/usb/dwc3/Makefile              |   16 +-
 drivers/usb/dwc3/core.c                | 1761 ++++++------------------
 drivers/usb/dwc3/core.h                |   39 +-
 drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  117 +-
 drivers/usb/dwc3/gadget.c              |  719 ++--------
 drivers/usb/dwc3/gadget.h              |    4 +-
 drivers/usb/dwc3/io.h                  |   36 +-
 drivers/usb/dwc3/samsung_usb_phy.c     |   77 ++
 drivers/usb/dwc3/ti_usb_phy.c          |    2 -
 drivers/usb/gadget/at91_udc.c          |   83 +-
 drivers/usb/gadget/atmel_usba_udc.c    |  114 +-
 drivers/usb/gadget/ci_udc.c            |   86 +-
 drivers/usb/gadget/composite.c         |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c      |   86 +-
 drivers/usb/gadget/epautoconf.c        |    2 -
 drivers/usb/gadget/ether.c             |   21 +-
 drivers/usb/gadget/f_acm.c             |   20 +-
 drivers/usb/gadget/f_fastboot.c        |   10 +-
 drivers/usb/gadget/f_mass_storage.c    |    5 +-
 drivers/usb/gadget/f_rockusb.c         |   11 +-
 drivers/usb/gadget/f_sdp.c             |   12 +-
 drivers/usb/gadget/f_thor.c            |   19 +-
 drivers/usb/gadget/udc/Makefile        |    1 +
 drivers/usb/gadget/udc/udc-core.c      |  933 ++-----------
 drivers/usb/host/xhci-dwc3.c           |    4 +-
 drivers/usb/mtu3/mtu3_gadget.c         |   10 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
 drivers/usb/musb-new/musb_gadget.c     |   21 +-
 drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
 drivers/usb/musb-new/musb_uboot.c      |   39 -
 include/dm/device_compat.h             |   13 +
 include/dm/read.h                      |   51 +
 include/linux/compat.h                 |   15 +
 include/linux/usb/ch9.h                |   25 +-
 include/linux/usb/gadget.h             |  529 ++-----
 include/linux/usb/phy.h                |   56 +
 39 files changed, 1406 insertions(+), 4007 deletions(-)
 create mode 100644 drivers/usb/dwc3/samsung_usb_phy.c

-- 
2.53.0

