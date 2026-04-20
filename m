Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E2AF588C3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F89C842E6;
	Mon, 20 Apr 2026 14:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="E7UFaE5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09DDF842F4; Mon, 20 Apr 2026 14:40:11 +0200 (CEST)
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6E783C51
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1776688807; x=1776948007;
 bh=gfTaVOIXQJZwk918+xkTAPgpEP+R6Q72hkA5HWsllyc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=E7UFaE5ErqyOfp7uGnTV6tXrQ9HaX2IkiI+aQTsh5fyGpOqCm1UdyFsCHSBR7SxOB
 tM7rzIk0J6lj+PXAc8EcbH/4QWopbau0QQz/76oktQn5MZh+AkNKZQqwS00MH8Izit
 SJnrt/1MFqtjkEBQ+UBD7277INxoqcmPcDfC4UJROEOZ4iZVsn1tZJAhgqTrwojVTE
 ZbU6JlOH0/wiiYDmtvYmihVFXZK7+et2DSsXwuwRbMBQWPw/L8wJyQEcCyAhsPR0yU
 60koIYCyC9DHcEllQ55mDdsFDee3F4pRy2b40AiZj9id3wW58h2xxSx05yMwmyKARY
 O/oelr/DEmwnQ==
Date: Mon, 20 Apr 2026 12:40:02 +0000
To: Simon Glass <sjg@chromium.org>
From: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: How to build U-Boot with a custom out-of-tree device tree
Message-ID: <48fd3747-7843-4d44-b31d-0ba6ed63c315@proton.me>
In-Reply-To: <CAFLszTgnGxLnEYdPyymLowq9jUTfRyneAPfBLu336MGQB__YDg@mail.gmail.com>
References: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
 <CAFLszTgnGxLnEYdPyymLowq9jUTfRyneAPfBLu336MGQB__YDg@mail.gmail.com>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 79de055250b6d3ca20187bf94242a113b5f2a842
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------645711da484574795c8aa78024486820936e860bc5dae68f042534025bf86fc0";
 charset=utf-8
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------645711da484574795c8aa78024486820936e860bc5dae68f042534025bf86fc0
Content-Type: multipart/mixed;
 boundary=e6425895406af92a1ec3cd531d32a226eadb5a39ca0b0500f26d7e28af25
Message-ID: <48fd3747-7843-4d44-b31d-0ba6ed63c315@proton.me>
Date: Mon, 20 Apr 2026 14:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to build U-Boot with a custom out-of-tree device tree
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
 <pEiyb1MJPzjpSpFTG0wv5BRnXMvGONVjw7bz8xiY45ZmgKsJJXhYRmT7wB7kpu98OE2Um8psmutKpqaGCeCMxg==@protonmail.internalid>
 <CAFLszTgnGxLnEYdPyymLowq9jUTfRyneAPfBLu336MGQB__YDg@mail.gmail.com>
From: Johannes Krottmayer <krotti83@proton.me>
Content-Language: en-US, de-AT
In-Reply-To: <CAFLszTgnGxLnEYdPyymLowq9jUTfRyneAPfBLu336MGQB__YDg@mail.gmail.com>

--e6425895406af92a1ec3cd531d32a226eadb5a39ca0b0500f26d7e28af25
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon!

Thanks for your answer.

On 4/20/26 2:51 AM, Simon Glass wrote:
> Hi Johannes,
> 
> On Sun, 19 Apr 2026 at 02:40, Johannes Krottmayer <krotti83@proton.me> wrote:
>>
>> Hello,
>>
>> This question is generic and also valid for none RISC-V boards.
>> I think it's maybe already asked, but didn't find any useful
>> information this time. My question is, is it possible to pass
>> a specific device tree blob to the build system from U-Boot?
>>
>> Example: RISC-V board Starfive VisionFive 2 8GiB variant
>>
>> The default in-source-tree device tree from the VisionFive 2 has
>> only 4GiB RAM. I own the 8GiB (RAM-IC BiWin BMWZCX32H2A-64G-X)
>> variant. So therefore can I pass the device tree blob directly
>> to U-Boot's build system without modifying CONFIG_DEFAULT_DEVICE_TREE
>> in the device configuration? Exists there an environment variable?
>>
>> Want to use U-Boot's EFI subsystem as loader for bare-metal
>> environments. And I think when I want to get the
 memory map
>> via EFI there will with the default device tree only <4GiB free
>> usable memory shown, although there are 8GiB.
> 
> You can build with: make DEVICE_TREE=...
> 
> See dts/Makefile for the logic.
> 

Didn't figured out how it works with the variable DEVICE_TREE
yet.

But I found the variable EXT_DTB in your described Makefile.
Have tried it now with a precompiled device tree and it works
fine.

make EXT_DTB=/path/to/custom_board.dtb

>>
>> Thanks in advance!
>>
>> Kind regards,
>>
>> Johannes K.
> 
> Regards,
> Simon

Kind regards,

Johannes K.

--e6425895406af92a1ec3cd531d32a226eadb5a39ca0b0500f26d7e28af25
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - krotti83@proton.me -
 0x1A5D6E0E.asc"; name="publickey - krotti83@proton.me - 0x1A5D6E0E.asc"
Content-Type: application/pgp-keys; filename="publickey - krotti83@proton.me
 - 0x1A5D6E0E.asc"; name="publickey - krotti83@proton.me - 0x1A5D6E0E.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4ak1FYUZyS2dSWUpLd1lCQkFIYVJ3
OEJBUWRBdm9MdzByd3hVZEZsMyszSytnTWhkTnlTK1p3WjU2Q0hlc2xBCndyKzhzalBOSjJ0eWIz
UjBhVGd6UUhCeWIzUnZiaTV0WlNBOGEzSnZkSFJwT0ROQWNISnZkRzl1TG0xbFBzTEEKRVFRVEZn
b0Fnd1dDYUZyS2dRTUxDUWNKa05aaG1aenF4TUNlUlJRQUFBQUFBQndBSUhOaGJIUkFibTkwWVhS
cApiMjV6TG05d1pXNXdaM0JxY3k1dmNtZnQwODBDTndEN0laNnB0eVgvVzhucHhhRFlwT0x6Zm05
Y21aK0hUUGJZCkN3TVZDZ2dFRmdBQ0FRSVpBUUtiQXdJZUFSWWhCQnBkYmc2UkVwSmNUMWFzaHRa
aG1aenF4TUNlQUFCdy9RRUEKOVVkYTBubVA4Q1g4UW1PciswNEY5U3g0c1NSUHhza0NsdE5rWlRW
RHROb0JBTjFlL3I5TnFZbUx1MjI4eHlVbQpmMHBkVXFlallJTytPT0lFZFFhMEZQd0V6amdFYUZy
S2dSSUtLd1lCQkFHWFZRRUZBUUVIUUJjYVpHMlZxK1MxCmV0Q2NSWDVJaGZnSHJCTFhIcGV1SzJC
VmZxZFNFVlltQXdFSUI4SytCQmdXQ2dCd0JZSm9Xc3FCQ1pEV1labWMKNnNUQW5rVVVBQUFBQUFB
Y0FDQnpZV3gwUUc1dmRHRjBhVzl1Y3k1dmNHVnVjR2R3YW5NdWIzSm44bk5IbWtwbApTakU0b1pU
WDVDZVlsamVGcmowd2pNWERNWENXZzdNNytnc0Ntd3dXSVFRYVhXNE9rUktTWEU5V3JJYldZWm1j
CjZzVEFuZ0FBZGdBQkFMc2p0elBMYjBnVytUQkFzVXNGNjNZUW1BRXBsUm55RWwxQ20rclJNZXJv
QVA5dVRkVFUKdThGL25ab0RUS3BxcGM4L1RqakhkU2JWMzMyUmhBdW1NSmQ4Q3c9PQo9TXJhaAot
LS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
--e6425895406af92a1ec3cd531d32a226eadb5a39ca0b0500f26d7e28af25--

--------645711da484574795c8aa78024486820936e860bc5dae68f042534025bf86fc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmnmHqEJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfEzRI5xAvFTdE0ICDNecANFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AAP4XAQDQLondFOgIBwF5foEKbUe9IzTtaGcJb09ajfoE
7wIFJwEA+9ykwmpFNd74by5m/rHcZZYZ8T4ZNOivQvLkvHsXvA8=
=Br0b
-----END PGP SIGNATURE-----


--------645711da484574795c8aa78024486820936e860bc5dae68f042534025bf86fc0--

