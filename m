Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAEECAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C56483526;
	Mon, 29 Sep 2025 22:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="CJWQrDIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2E38344E; Mon, 29 Sep 2025 22:40:01 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87FD82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 76fc83b4-9d74-11f0-809d-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 76fc83b4-9d74-11f0-809d-005056992ed3;
 Mon, 29 Sep 2025 22:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=SdFZwWNdMGpJH8L/hT1HscziPPCiP8oCzb5K6dPp/qE=;
 b=CJWQrDIvUSFg0L4/7gtsrutO9L9o22enamPathFWpRkGh/v6JNbRWtvEiRfLGMGBZcmcUcTFlDADZ
 rXB12EK2CjoIfCTXhpQYlr8M9BoEKFPw8bb/fbhEX+rcXBeDFVSpgA0KMr8OMFBdz33nD3mfsqVyYO
 zC7OwpsAF7qOYQka2IPKXmvzKCghgKmgYGFdkwJaUsg+dGIDDdbb26BmVjKuoW3mb/XHYXcS/wTTs/
 zu8JyKirQzn/Ljr6JOQbC3eaJmowdvoUfq78avMm7RvIiSATb6nVK1YLaH2WPz4MJR9BmgVZ6p+m9T
 QMylDBnYP3OXW1DEh/Lc/feZ450AByw==
X-KPN-MID: 33|4T4gtz3BMINKjKhI9Rx5ZcwdUewqiMIMj8iiO/blfd9LOrlGtfsxpkD+vOioVEV
 7HrZNUBJq2SATDdbGoLMfS4SLyVhx1KynKcqluQCtVCE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0azN+fAt56B3ynRFmUF9Vf35Tg1lFW1uYuB90MrXB8j3QhYz3o7VTNaYX9tNi7s
 x6Xvak3PEx6pN2tz6pjmQHA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 76cc0f27-9d74-11f0-bfed-00505699772e;
 Mon, 29 Sep 2025 22:39:59 +0200 (CEST)
Date: Mon, 29 Sep 2025 22:39:58 +0200
Message-Id: <87qzvpdmch.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, marex@denx.de
In-Reply-To: <20250929195957.GN6093@bill-the-cat> (message from Tom Rini on
 Mon, 29 Sep 2025 13:59:57 -0600)
Subject: Re: [PATCH v2 3/3] usb: xhci-pci: Load ASMedia XHCI controller
 firmware
References: <20250929195241.70351-1-kettenis@openbsd.org>
 <20250929195241.70351-4-kettenis@openbsd.org>
 <20250929195957.GN6093@bill-the-cat>
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

> Date: Mon, 29 Sep 2025 13:59:57 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Mon, Sep 29, 2025 at 09:52:41PM +0200, Mark Kettenis wrote:
> 
> > The ASMedia XHCI controller found on some of the Apple Silicon
> > machines needs firmware to operate.  Use the file system
> > firmware loader interface to read the firmware and load it
> > onto the controller.  This allows keyboards connected to the
> > type-A ports on these machines to function in U-Boot.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> [snip]
> > +config USB_XHCI_PCI_ASMEDIA
> > +	bool "Support for ASMedia xHCI USB controller"
> > +	depends on USB_XHCI_PCI
> > +	default y if ARCH_APPLE
> > +	imply FS_LOADER
> 
> The code reads like the loader is non-optional so this should be select
> not imply.

Thanks, the Kconfig stuff is still amystery to me sometimes.

Fixed for the next version.
