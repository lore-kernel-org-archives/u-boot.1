Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F41F8D758
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 15:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120BF84105;
	Thu, 16 Apr 2026 17:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="PJ9Puuy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F5D841D5; Thu, 16 Apr 2026 17:11:51 +0200 (CEST)
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08551840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1776352308; x=1776611508;
 bh=S4KG8SrYY/EtYmmZQbKsM1ruz2fl/AS7/tnD+1JtYPQ=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=PJ9Puuy/mcforfDAjPnf3kGW5vkStlc7hg3irDS8cdofJxJDlMbULMvNz7Y8KMIe2
 sDBcDP82GBwNbS/G5OqhSVmuavVjKCaKM6VsIwc3zOWeXkXaVyFhuF+vpopKbwzI0Z
 3gD/JfpX5wLrqK7NqgntMBKP6GFvFe+pm+bvzkCWoactkrmCXej1O/ni40gz2s+5kI
 3VL+svKq6kPJUUjYKeRmkkcJKREqdCTGJAzPzgEDkmHEwpLiy/znp3YdtGsz831vmA
 drGyE5X2m262U9c6thHqBY10AkUXCacFyKiDNovWiiJHsSoEhcH42OaSCncH4AwNVA
 ip4xmOKMAbDQA==
Date: Thu, 16 Apr 2026 15:11:42 +0000
To: u-boot@lists.denx.de, minda.chen@starfivetech.com,
 hal.feng@starfivetech.com, Tom Rini <trini@konsulko.com>
From: Johannes Krottmayer <krotti83@proton.me>
Subject: doc/board/starfive/jh7110_common.rst: Documentation doesn't mention
 OpenSBI text start address
Message-ID: <a39c05f8-7cb4-4a27-bd73-dd6297c19a0a@proton.me>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 62506d614c1ef159104fac934da0443e9cbae6d7
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------716a275231344047903600dfef7471cd79ca373144c9127c4ee0e0012107ab69";
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
--------716a275231344047903600dfef7471cd79ca373144c9127c4ee0e0012107ab69
Content-Type: multipart/mixed;
 boundary=48c8da530961df3345929a436b82b9c4c4db27021be11a52c70425ff08f6
Message-ID: <a39c05f8-7cb4-4a27-bd73-dd6297c19a0a@proton.me>
Date: Thu, 16 Apr 2026 17:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de, minda.chen@starfivetech.com,
 hal.feng@starfivetech.com, Tom Rini <trini@konsulko.com>
From: Johannes Krottmayer <krotti83@proton.me>
Subject: doc/board/starfive/jh7110_common.rst: Documentation doesn't mention
 OpenSBI text start address

--48c8da530961df3345929a436b82b9c4c4db27021be11a52c70425ff08f6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,


I have used the U-Boot documentation for building OpenSBI and
U-Boot for the Starfive VisionFive 2 board.

Unfortunately there is a important definition missing (will be not
mentioned in the current documentation) in the build step for
OpenSBI.

FW_TEXT_START from OpenSBI defaults to address 0x0, this raises
an exception. FW_TEXT_START should be set to the correct address
0x40000000 and then it works.

So therefore the correct build step should be:
$ make PLATFORM=generic FW_TEXT_START=0x40000000

Should I create a patch for the documentation to add this?

-- 
Kind regards,

Johannes K.


--48c8da530961df3345929a436b82b9c4c4db27021be11a52c70425ff08f6
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
--48c8da530961df3345929a436b82b9c4c4db27021be11a52c70425ff08f6--

--------716a275231344047903600dfef7471cd79ca373144c9127c4ee0e0012107ab69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmng/C0JENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeIojaftb0CSLVgBgNBYsy6FiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AAEmfAQCVwNQ59UQ0yY3uI4OLRrEMDQFj4aa9uKXuBsea
eiqBtAEA4wEaepseO03xkFXts9F28TRuAEoHTCNEh0/uofx2uwI=
=Ae7i
-----END PGP SIGNATURE-----


--------716a275231344047903600dfef7471cd79ca373144c9127c4ee0e0012107ab69--

