Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2BFCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 07:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43794846A4;
	Mon, 15 Jun 2026 09:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KPc58qX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C188484C; Mon, 15 Jun 2026 09:18:26 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6BF83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEC70600AB;
 Mon, 15 Jun 2026 07:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A901F000E9;
 Mon, 15 Jun 2026 07:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781507902;
 bh=T/McH63Y/Mm5tQ+yPmkjwtplnLLOAiK/CZRP64kpI5M=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=KPc58qX/u0FCaC0G3NnadtMXB0q2KbA8nmbWWTFv8o66rFz5tSYSbZPv7DB8at9jo
 wd2OnzoR1MzJXBCF4glAt70s5QzEn+/XQRbIF21a00cptW+Uyb6suDixgrCZ6n1cl9
 b0zL58XIG2RcvFknkh7yJYtDGQLfiwnswI/4uvHIjMWXtwiUKmMoCiaNWRElVs6W2H
 qTpTFp5AhS6bjC3OOujmSDb5UcpuzD/SAHb2LegxoMGW3BSNwh8huenCfi9AiersTp
 rmg/GIsfLMcs9us8/HUGNekv7AsPYJmYdOn6gpJ4TL8tntgYJ6YRrRkg4fLkDLkRbw
 uNbrOhNMzjvZQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] cmd: ums: Set Device Descriptor iSerial based on
 serial# env variable
In-Reply-To: <20260613025510.134239-1-marex@nabladev.com>
References: <20260613025510.134239-1-marex@nabladev.com>
Date: Mon, 15 Jun 2026 09:18:20 +0200
Message-ID: <875x3ki85f.fsf@kernel.org>
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

On Sat, Jun 13, 2026 at 04:54, Marek Vasut <marex@nabladev.com> wrote:

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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
