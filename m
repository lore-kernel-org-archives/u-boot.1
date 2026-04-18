Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA9AF99C86
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 14:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C4383BC8;
	Sat, 18 Apr 2026 16:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="PKIzW4Dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBFD583FF5; Sat, 18 Apr 2026 16:40:10 +0200 (CEST)
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch
 [185.70.43.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C7F83B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 16:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1776523207; x=1776782407;
 bh=tA5DOVZ6V3iv6Y3pUqycYquw+oEgfNjOMFaLIdYjNI8=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=PKIzW4DcO6ZmZNYRUlaBvDjYUcbdTA1I8actxdD3EGKqVu9EEcNm9RJPpdHmXyEMA
 1II/WasAFMz1aL/m3l2eoPxgmYEFLMKfHW6S+klJF6ORhWPq5OkpMHOjqPjQZxuVmo
 2TqjyLF7FKmBPn0UoTzHPbnheX6f5+pILkKHcW5CHw/EQkltWA69lUbPP3MA8j9QXg
 rrpdQrXQXug3FJqmiiLcOaIYPkaK1sn0CXFEySYSGDCCYFXsdOr2SP5Sm/Y+cL0zuu
 VcWki5O0r43RX2nACPk8PQ2r7xxr+2lfeeQLYfkJTMOfBeKwEswc1Yu2wHdRR05b2E
 Mm0BNnMlt+pow==
Date: Sat, 18 Apr 2026 14:40:02 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
Subject: How to build U-Boot with a custom out-of-tree device tree
Message-ID: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: c51a3c5fa484284807495966838d67eb20680cd3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------f535e9f8430aeea7a9a5387c7eeaafd5b8f7ff6fb6ec23ac51f21e30c59e2e09";
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
--------f535e9f8430aeea7a9a5387c7eeaafd5b8f7ff6fb6ec23ac51f21e30c59e2e09
Content-Type: multipart/mixed;
 boundary=27e2447be0dfb9a5a89fac37b20818d68feeef8ebc06029376f62784f796
Message-ID: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
Date: Sat, 18 Apr 2026 16:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
Subject: How to build U-Boot with a custom out-of-tree device tree

--27e2447be0dfb9a5a89fac37b20818d68feeef8ebc06029376f62784f796
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This question is generic and also valid for none RISC-V boards.
I think it's maybe already asked, but didn't find any useful
information this time. My question is, is it possible to pass
a specific device tree blob to the build system from U-Boot?

Example: RISC-V board Starfive VisionFive 2 8GiB variant

The default in-source-tree device tree from the VisionFive 2 has
only 4GiB RAM. I own the 8GiB (RAM-IC BiWin BMWZCX32H2A-64G-X)
variant. So therefore can I pass the device tree blob directly
to U-Boot's build system without modifying CONFIG_DEFAULT_DEVICE_TREE
in the device configuration? Exists there an environment variable?

Want to use U-Boot's EFI subsystem as loader for bare-metal
environments. And I think when I want to get the memory map
via EFI there will with the default device tree only <4GiB free
usable memory shown, although there are 8GiB.

Thanks in advance!

Kind regards,

Johannes K.

--27e2447be0dfb9a5a89fac37b20818d68feeef8ebc06029376f62784f796
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
--27e2447be0dfb9a5a89fac37b20818d68feeef8ebc06029376f62784f796--

--------f535e9f8430aeea7a9a5387c7eeaafd5b8f7ff6fb6ec23ac51f21e30c59e2e09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmnjl8EJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdD6/HV27EuRCriXGETBJaJFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AAAfkAPsHJYn4zurqWPmYcitayQBkm5wPiv2rfkrVxKIQ
AeBykAD/ThAvZwW/p1dvD5ZGdt+OeR/P+of1yokCROUGBows4Qc=
=RJbE
-----END PGP SIGNATURE-----


--------f535e9f8430aeea7a9a5387c7eeaafd5b8f7ff6fb6ec23ac51f21e30c59e2e09--

