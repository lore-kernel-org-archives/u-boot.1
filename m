Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA2C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98269882BE;
	Tue, 18 Jun 2024 09:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n5PBTp8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDC18786C; Tue, 18 Jun 2024 09:10:15 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F62883B1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3620ee2cdf7so218831f8f.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718694611; x=1719299411;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xzjvRDWdI2YfQ8TvpFR9mBK8Tgvr4WeOrtUAxePfqwI=;
 b=n5PBTp8DYrDmQzvdkr6f7j3l0I7eHFWwNbZN37j+EjzY/N7jegFB0gvbPcajf/r3ee
 EDqQ+ng0vTRO4NtUwbvUKXv1pOWza2cJOfoaCYG3x/Z6KbT0Mkc4k+Rb+aN3OT0dHMyK
 uQhKFW9Vhbw0b0nL2V+JcmU08K0eB15bh7L9ybX6gM+L/uKllsZU9+kcbUX0AiLcVHyH
 4Ee4v//sshnB160ZDm+dMWpjANrChJvkP2x+WVr58zq2RnQxT7Vprr1BAYurHnMsBFrN
 5COVuJS6QfRZj4WL9o7R14dzJwKLlnzjCz9a5NKOA3TQLWTHTCwMKhFajQWyC15+4Eiw
 Diww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718694611; x=1719299411;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzjvRDWdI2YfQ8TvpFR9mBK8Tgvr4WeOrtUAxePfqwI=;
 b=eVqRiMdb9iRoL88g5ZwJ77CPV+KSaxmzuOFqKPLSZsj6XpZKDhzK4L3ERaMWhJE+Y8
 u+mDUTyfY/n1SViSJebxXTx1EqJQwcWIZs0UMDwJcJV9nUPolmuStVWegLuBtKWRaMhY
 t34ku7DPTo+uxFlH8sd4oevw5jptW6MKZyPfZcYKx4Sie84H/JCbfRvLN2/uFPTkLCLa
 1htZq+78nw0TSxWUo6/w8aRBwDeiR9imB7SrV/eN7w2+BFX809PaJ3Q/ZtBAhtdWLLKa
 O3IONRE5rBeWdcX+Va3Qxcyvs24AWQgGJTBiwn1sUhMVFLPRynz8aaf5KgkM7i558qb5
 KFhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB/D6IGyeTKC2UtEPeQ2CVR/B65jfSrD3de/09WETsa82y7+tziznQcXUjy9uSR4IlFNpfohZZoiH4X4eO29SElKSELg==
X-Gm-Message-State: AOJu0YxycGaMMQs8WVT4BD1jkwWw7UceuvZjCC3YjRURPl5IPYBw/ttW
 PRBRq+dxNAFjUrpBD5f54dQvlTB91KiFdEoBC7lRpvjdL6tmgKOze/Y7KknbP+4=
X-Google-Smtp-Source: AGHT+IHKn9zlTyoOa88ayt57899jmrPbrHfPEenqDT57Ba6D8P0RcmIz5bBmhul8nDkpJQwzvDEtJw==
X-Received: by 2002:adf:efc9:0:b0:35f:2e9f:bcfa with SMTP id
 ffacd0b85a97d-3607a77aba8mr8137432f8f.43.1718694610904; 
 Tue, 18 Jun 2024 00:10:10 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075093a13sm13638205f8f.9.2024.06.18.00.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:10:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 00/11] usb: gadget: Introduce handle_interrupts ops to
 USB_GADGET_GENERIC uclass
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
Date: Tue, 18 Jun 2024 09:10:08 +0200
Message-ID: <87frtak9pr.fsf@baylibre.com>
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

Hi Marek,

Thank you for the series.

On ven., juin 14, 2024 at 02:51, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Introduce .ops for USB_GADGET_GENERIC uclass. The first new ops is
> .handle_interrupts which must be implemented by DM capable USB gadget
> controller drivers and must implement interrupt handling similar to
> dm_usb_gadget_handle_interrupts(). For DM USB gadget drivers this is
> a replacement for dm_usb_gadget_handle_interrupts(). Convert the DM
> USB gadget drivers to this new ops instead.
>
> DEPENDS: https://patchwork.ozlabs.org/project/uboot/list/?series=410150
>
> Marek Vasut (11):
>   usb: gadget: Introduce handle_interrupts ops to USB_GADGET_GENERIC
>     uclass
>   usb: gadget: cdns3: Convert interrupt handling to
>     usb_gadget_generic_ops
>   usb: gadget: dwc2: Convert interrupt handling to
>     usb_gadget_generic_ops
>   usb: gadget: dwc3: Convert interrupt handling to
>     usb_gadget_generic_ops
>   usb: gadget: max3420: Convert interrupt handling to
>     usb_gadget_generic_ops
>   usb: gadget: mtu3: Convert interrupt handling to
>     usb_gadget_generic_ops
>   usb: gadget: omap2430: Convert interrupt handling to
>     usb_gadget_generic_ops
>   usb: gadget: musb: Convert interrupt handling to
>     usb_gadget_generic_ops
>   usb: gadget: ux500: Convert interrupt handling to
>     usb_gadget_generic_ops
>   usb: gadget: sandbox: Drop dm_usb_gadget_handle_interrupts()
>   usb: gadget: Mark dm_usb_gadget_handle_interrupts as non-weak for
>     DM_USB_GADGET
>
>  drivers/usb/cdns3/core.c            | 24 ++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget-export.h   |  2 ++
>  drivers/usb/cdns3/gadget.c          | 11 +----------
>  drivers/usb/dwc3/dwc3-generic.c     | 23 ++++++++++++++---------
>  drivers/usb/dwc3/dwc3-layerscape.c  | 21 +++++++++++++--------
>  drivers/usb/gadget/dwc2_udc_otg.c   | 20 +++++++++++++++-----
>  drivers/usb/gadget/max3420_udc.c    | 19 ++++++++++++-------
>  drivers/usb/gadget/udc/udc-uclass.c | 24 ++++++++++++++++++++++++
>  drivers/usb/host/usb-sandbox.c      |  7 +------
>  drivers/usb/mtu3/mtu3_plat.c        | 23 ++++++++++++++---------
>  drivers/usb/musb-new/omap2430.c     | 26 ++++++++++++++++----------
>  drivers/usb/musb-new/ti-musb.c      | 23 ++++++++++++++---------
>  drivers/usb/musb-new/ux500.c        | 22 ++++++++++++++--------
>  include/linux/usb/gadget.h          |  8 ++++++++
>  14 files changed, 172 insertions(+), 81 deletions(-)

Tested on Khadas vim3 using fastboot, ums and usb storage scanning.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3

>
> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
>
> -- 
> 2.43.0
