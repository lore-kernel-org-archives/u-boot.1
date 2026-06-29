Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E8BC43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 11:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F133D849E5;
	Mon, 29 Jun 2026 13:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f0WYVYz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A111849EF; Mon, 29 Jun 2026 13:11:21 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0000E849A3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 13:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65DEB416F7;
 Mon, 29 Jun 2026 11:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998EF1F000E9;
 Mon, 29 Jun 2026 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782731477;
 bh=LZPkfY1llJR1yqis7u2A6CN0E04s2nzZ6MXtuGbzgPg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=f0WYVYz6u2It3Nfw3cLulJ24MlmOUaaRNb2/WuMZ5kkDawhafyKUIsOXzhO3pVfZQ
 aFpcke106n9blnYCcwgUdvJcwgE8X45RUAKDVegCNz6zmOrvhbE4cMHoqhh9MomnuU
 AdXmyB7dQ7OwVujd03oViwC1uyzFoKxGUwIgVM+YOZPNS9PjA3Au7ydDCjTPMAJxSw
 gnyEDfGCqG/2p4aMEs1rzvTJEqjWWYojeyjgUp14UmwG/K5LcDN/3D0/SXzUfNHKBU
 bcQUqdMXLHqi+o6Lf2HKWK4rjZOsoDmIYcSwsaGDev7BPKEJzq0IMlAs+t9zC5jC+z
 2BxXX7e5zCu4A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] cmd: ums: Set Device Descriptor iSerial based on
 serial# env variable
In-Reply-To: <20260626142840.305478-1-marex@nabladev.com>
References: <20260626142840.305478-1-marex@nabladev.com>
Date: Mon, 29 Jun 2026 13:11:14 +0200
Message-ID: <87h5mld2jx.fsf@kernel.org>
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

Thank you for the patch.

On Fri, Jun 26, 2026 at 16:28, Marek Vasut <marex@nabladev.com> wrote:

> The DFU code currently sets the content of "serial#" environment
> variable into Device Descriptor iSerial field. This is useful when
> there are multiple devices connected to the same host PC and they
> have to be told apart. Replicate the same behavior in the UMS code.
>
> Example without serial# set, which is the original behavior:
> "
> u-boot=> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000
>
> $ dmesg -w
> ...
> usb 5-2.3.7: New USB device found, idVendor=0525, idProduct=a4a5, bcdDevice=7e.a7
> usb 5-2.3.7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 5-2.3.7: Product: USB download gadget
> usb 5-2.3.7: Manufacturer: Vendor
>                             <------------------------------- NOT HERE
> usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
> ...
>
> $ lsusb -vd 0525:a4a5
>
> Bus 005 Device 051: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB File-backed Storage Gadget
> Negotiated speed: High Speed (480Mbps)
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 [unknown]
>   bDeviceSubClass         0 [unknown]
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0525 Netchip Technology, Inc.
>   idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
>   bcdDevice           7e.a7
>   iManufacturer           1 Vendor
>   iProduct                2 USB download gadget
>   iSerial                 0 <------------------------------- NOT HERE
> ...
> "
>
> Example with serial# set to 1234abcd, which is the optional new behavior:
> "
> u-boot=> setenv serial# 1234abcd <------------------------------ HERE
> u-boot=> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000
>
> $ dmesg -w
> ...
> usb 5-2.3.7: New USB device found, idVendor=0525, idProduct=a4a5, bcdDevice=7e.a7
> usb 5-2.3.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 5-2.3.7: Product: USB download gadget
> usb 5-2.3.7: Manufacturer: Vendor
> usb 5-2.3.7: SerialNumber: 1234abcd <--------------------------- HERE
> usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
> ...
>
> $ lsusb -vd 0525:a4a5
>
> Bus 005 Device 052: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB File-backed Storage Gadget
> Negotiated speed: High Speed (480Mbps)
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 [unknown]
>   bDeviceSubClass         0 [unknown]
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0525 Netchip Technology, Inc.
>   idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
>   bcdDevice           7e.a7
>   iManufacturer           1 Vendor
>   iProduct                2 USB download gadget
>   iSerial                 3 1234abcd <-------------------------- HERE
> ...
> "
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

I looked at the linux implementation and I could not find anything
related to the serial number in
drivers/usb/gadget/function/f_mass_storage.c.
I think in linux it's handled by drivers/usb/gadget/configfs.c,
therefore we can't just do a straight port from linux.

This looks good to me.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

