Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94832C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 13:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C5288126;
	Thu, 11 Jul 2024 15:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fa2PF41F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F1F87F5C; Thu, 11 Jul 2024 15:10:06 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1796888126
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 15:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so5419855e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720703402; x=1721308202;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u5UtoFtvrs9/JRzXP4i4P8EchTbr9C0vnQRZrrW0YyM=;
 b=Fa2PF41FSg4Z9MBeI7ZAg5HYVVEhFVA1gib7snM6ywYKAojgy65StK1kdFv5RnXBFk
 Pqw1VTiRtk9UgKUXEtKtkcC4AGSAW9ucX7SF6mq4YwVwB5GysAkau1vuxjA0+kBulEfi
 bZsUTjyUHmo1kyaPU2Si3iGejLrtJFlKV93MEFbJMnysD9lgmuyVYkYfcfbA/j5WVBNt
 fOqHzLRQSJuGAe0IHwAJoclZN3EmqVJPtxL5pjT/wqSpLvVPZ2Yhxl2It1t3IseWY4tn
 fJV5iROKxq0Z84cMgG58BVDXLgcYLjvVSGwNunRVqp43YX9vXCLRAMIRpoLxWOut3IDj
 LrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703402; x=1721308202;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u5UtoFtvrs9/JRzXP4i4P8EchTbr9C0vnQRZrrW0YyM=;
 b=Y6f0vmIjb3c3jClVMAXZbVALr7lg14MLlY5AtYffmGLabTNh1Jb20xkprBrQ9l0svm
 a+S6phmN/L8psP33M5Ye/YRXhyg81qrjhy6VoTzttCEnI7uDDh7QyNA8Z/q/VsE1WZ91
 b9MvJFf/w3eIMjksQRhb7ww0dxIsjER8881yvIeGUZE4aCrx4fX2oc+9uLAqAjfDw904
 +RE4gxfFvCtIJHuEUW/8iANG5dsxo4VzsRzLPGl7t/SYIGHLkrsatjg2tnPekpQbMTMJ
 3ElWWQj0hn319dpZO1JoC+1rmaHVzTjRhNCl+ek4wz2rHg3UrnGdjzYaBsCd5psDM43A
 EcpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIdA6Ji+9p4zDmmrddKz1U0zKkvNrnGtbGu/gBrlPDWOGExav3v/o2V/05a4XlrFBLwoTupyqBunRh7G4G2wIUK2cqoQ==
X-Gm-Message-State: AOJu0Yy77u39cm3kqQmZ7j97G5HvU6bJXDcmaw8TPLIYEW5bQ1wHDbdr
 J3KylRKY9AUtR7VfluHfI4aoGtaTV/XCCy4X2QJv9TmLihmjsJalecm7trwl7OQ=
X-Google-Smtp-Source: AGHT+IHAoyPBqP7wLysVK2qqq94eNcOo1Vd5Q5GBFgqixKL8JWZTD4rSjgIMicNwLj4LqEBLtQ8zEg==
X-Received: by 2002:a05:600c:181c:b0:424:a7f1:ba2 with SMTP id
 5b1f17b1804b1-427981f2dd6mr22719025e9.17.1720703402207; 
 Thu, 11 Jul 2024 06:10:02 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279669d882sm53605115e9.4.2024.07.11.06.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:10:01 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Caleb Connolly
 <caleb.connolly@linaro.org>
Subject: [GIT PULL] Please pull u-boot-dfu-20240711
Date: Thu, 11 Jul 2024 15:09:58 +0200
Message-ID: <87bk34m5w9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Please find some new developments for master:

Usb gadget:
- A welcome cleanup: epautoconf workaround is dropped to use
  .match_ep() instead
- Introduce handle_interrupts() op for USB_GADGET_GENERIC, which
  allows a per-driver interrupt handling

Fastboot:
- Fix mssing include when building with TCP only

Thi CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/21552

Thanks,
Mattijs

The following changes since commit 7c9c5c0562347dccb8ac89148784a34de402ea9e:

  Merge patch series "xtensa: Enable qemu-xtensa board" (2024-07-04 16:11:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240711

for you to fetch changes up to b091d3872833a4b8d088ee41348a2d4ff48067cc:

  include/fastboot.h: add missing types.h include (2024-07-09 09:15:37 +0200)

----------------------------------------------------------------
u-boot-dfu-20240711

Usb gadget:
- A welcome cleanup: epautoconf workaround is dropped to use
  .match_ep() instead
- Introduce handle_interrupts() op for USB_GADGET_GENERIC, which
  allows a per-driver interrupt handling

Fastboot:
- Fix mssing include when building with TCP only

----------------------------------------------------------------
Caleb Connolly (1):
      include/fastboot.h: add missing types.h include

Marek Vasut (17):
      usb: gadget: g_dnl: Drop usb_gadget_controller_number()
      usb: gadget: ether: Drop usb_gadget_controller_number()
      usb: gadget: Drop usb_gadget_controller_number()
      usb: gadget: Drop all gadget_is_*() functions
      usb: gadget: Add full ep_matches() check past .match_ep() callback
      usb: dwc3: gadget: Convert epautoconf workaround to match_ep callback
      usb: gadget: Introduce handle_interrupts ops to USB_GADGET_GENERIC uclass
      usb: gadget: cdns3: Convert interrupt handling to usb_gadget_generic_ops
      usb: gadget: dwc2: Convert interrupt handling to usb_gadget_generic_ops
      usb: gadget: dwc3: Convert interrupt handling to usb_gadget_generic_ops
      usb: gadget: max3420: Convert interrupt handling to usb_gadget_generic_ops
      usb: gadget: mtu3: Convert interrupt handling to usb_gadget_generic_ops
      usb: gadget: omap2430: Convert interrupt handling to usb_gadget_generic_ops
      usb: gadget: musb: Convert interrupt handling to usb_gadget_generic_ops
      usb: gadget: ux500: Convert interrupt handling to usb_gadget_generic_ops
      usb: gadget: sandbox: Drop dm_usb_gadget_handle_interrupts()
      usb: gadget: Mark dm_usb_gadget_handle_interrupts as non-weak for DM_USB_GADGET

 drivers/usb/cdns3/core.c            |  24 +++++
 drivers/usb/cdns3/gadget-export.h   |   2 +
 drivers/usb/cdns3/gadget.c          |  11 +-
 drivers/usb/dwc3/dwc3-generic.c     |  23 ++--
 drivers/usb/dwc3/dwc3-layerscape.c  |  21 ++--
 drivers/usb/dwc3/gadget.c           |  33 ++++++
 drivers/usb/gadget/dwc2_udc_otg.c   |  20 +++-
 drivers/usb/gadget/epautoconf.c     |  81 +-------------
 drivers/usb/gadget/ether.c          |  25 ++---
 drivers/usb/gadget/g_dnl.c          |  17 +--
 drivers/usb/gadget/gadget_chips.h   | 210 ------------------------------------
 drivers/usb/gadget/max3420_udc.c    |  19 ++--
 drivers/usb/gadget/udc/udc-uclass.c |  24 +++++
 drivers/usb/host/usb-sandbox.c      |   7 +-
 drivers/usb/mtu3/mtu3_plat.c        |  23 ++--
 drivers/usb/musb-new/omap2430.c     |  26 +++--
 drivers/usb/musb-new/ti-musb.c      |  23 ++--
 drivers/usb/musb-new/ux500.c        |  22 ++--
 include/fastboot.h                  |   2 +
 include/linux/usb/gadget.h          |   8 ++
 20 files changed, 219 insertions(+), 402 deletions(-)
 delete mode 100644 drivers/usb/gadget/gadget_chips.h

