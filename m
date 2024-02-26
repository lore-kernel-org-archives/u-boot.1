Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34172C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 20:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D7E87F38;
	Mon, 26 Feb 2024 21:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="FHP+ndbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3549287DF9; Mon, 26 Feb 2024 21:42:40 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2875D87F42
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 21:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 7c14d29e-d4e7-11ee-9a83-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7c14d29e-d4e7-11ee-9a83-00505699b430;
 Mon, 26 Feb 2024 21:41:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=UneI8Xe4Ff1nOKUufyYIjo4bpF9uRfY3J/RorEogh2U=;
 b=FHP+ndbOTPdS5pTK98I56xxgHJ+WArqhCrsFlr18Sz2duPvVPitlcLg3dAFRq9fkvEz4GkLIKkyp1
 poLdilrxBPs/pgnH5iO3nPdn5CJTly1e5mmJu63ikZCX+JRIPyapE0kEelwr5LpvBY4O4y7uMetI9P
 z9obdDfcFXRD/khn9R8aiGKRzHRq9lcyMvcPKUpdBOSV3srU/vo0ULvSKamzdJ/5e66FvK3HvIAvI0
 FAuZswIF/8IMY0EGAe9wemAT7Lfy8ai+XzroiFvjyfAtpmwcanhSm9Po43fTAmMl3g8wqLEpWMNyOK
 p6XIKxf/LSIb9HBFlE/SEkz76ZGwb7w==
X-KPN-MID: 33|KXjChsCSqRVLL54dJelljGWqdFNBgNokVRQTWGuQ9XQTw5r2+bIxO0yHb4/RUEv
 /ogW28ztQj9JHvJLy+uJT9GJocLMnJTvfbvaEYbo8S1I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gaEP3jhajUk3iH4Rt08mAHoBfG4vaATU1U5jW1v+Lt1Qvva2BFF9UB6rYVqCylf
 +EsPxSMOYwL1tzCvzOkLMpw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 92f85e84-d4e7-11ee-9e84-00505699772e;
 Mon, 26 Feb 2024 21:42:37 +0100 (CET)
Date: Mon, 26 Feb 2024 21:42:36 +0100
Message-Id: <875xybj6tf.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marek Vasut <marex@denx.de>
Cc: j@jannau.net, bmeng.cn@gmail.com, trini@konsulko.com,
 u-boot@lists.denx.de, asahi@lists.linux.dev
In-Reply-To: <52b99ba9-3772-4074-8b64-e01dde80f6a4@denx.de> (message from
 Marek Vasut on Sun, 25 Feb 2024 22:47:41 +0100)
Subject: Re: [PATCH 2/6] usb: xhci: Set up endpoints for the first 2 interfaces
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-2-814b2e741790@jannau.net>
 <9cb3370e-770a-40e6-b890-ae9b5a15bd44@denx.de>
 <b0c41f38-abf0-4713-a80a-c78f074b7b4d@app.fastmail.com>
 <52b99ba9-3772-4074-8b64-e01dde80f6a4@denx.de>
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

> Date: Sun, 25 Feb 2024 22:47:41 +0100
> From: Marek Vasut <marex@denx.de>
> 
> On 2/25/24 4:28 PM, Janne Grunau wrote:
> > 
> > 
> > On Wed, Feb 21, 2024, at 13:39, Marek Vasut wrote:
> >> On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
> >>> From: Janne Grunau <j@jannau.net>
> >>>
> >>> Apple USB keyboards carry the HID keyboard boot protocol on the second
> >>> interface. Using the second interface in the USB keyboard driver does
> >>> not work since the xhci has not allocated a transfer ring.
> >>
> >> So, what does this patch do ? That is not clear from the commit message.
> > 
> > rewritten for v2:
> > | usb: xhci: Set up endpoints for the first 2 interfaces
> > |
> > | The xhci driver currently only does the necessary initialization for
> > | endpoints found in the first interface descriptor. Apple USB keyboards
> > | (released 2021) use the second interface descriptor for the HID keyboard
> > | boot protocol. To allow USB drivers to use endpoints from other
> > | interface descriptors the xhci driver needs to ensure these endpoints
> > | are initialized as well.
> > | Use USB_MAX_ACTIVE_INTERFACES to control how many interface descriptors
> > | are initialized and useable. Currently defined to 2 as that is enough to
> > | make the Apple keyboard usable.
> 
> Would it make sense to make this a tunable Kconfig option ?

Maybe, but it should probably be enabled everywhere where
CONFIG_USB_KEYBOARD as folks will connect their Apple keyboard to
non-Apple hardware as well.  And I think someone mentioned on the
#asahi irc channel that there are othe keyboards that have the boot
protocol on the second interface descriptor.

Cheers,

Mark
