Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B43DF588C3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 13:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D544184372;
	Mon, 20 Apr 2026 15:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Lcwxz8Ox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 141618437C; Mon, 20 Apr 2026 15:15:31 +0200 (CEST)
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2FF484366
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1776690926; x=1776950126;
 bh=fJOus6g0SvzBJNrFaaQFqChtAC69v/YpX03VTKArW84=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Lcwxz8Ox8SXnXkPAJHf/KQfaI2gGI64In7/wqf101ntNl4tU3FGCUphpxY3P5tPO1
 FRwNpdhcFdL/JidgPwxz1c2xlC7QXVTuxvdvWavDPOm17Q/CLRTf/ENuP1p97dM0hv
 ALVeQLTFhiKCEBv5JiSIExhXc0i3jSsfIQjJFc9A8LykjXWh/nPl+x2fkUKXgWt+nH
 d65Z3KBQAD8b+HLVWMbFDsg6gjr4wWPrVYPRpduRXXTYv8RM4WR2eNUQdmQF04MMC4
 fG+a+SigbSSeMfFVzkxlROrHctRYb4KiG9FvNUJ6QnoIC5vW+lYFoA4pydzwmx0+mX
 nmGF1PHsVOV7w==
Date: Mon, 20 Apr 2026 13:15:23 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
Subject: cmd: fatload: command doesn't update $filesize after next calls
Message-ID: <904e82be-40df-45d1-afc9-bb658ac9be8c@proton.me>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 61bedf1917c07f99e73aadae47c04ec1a24edc8d
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------dc89c907ff7f479ab717576d317cd3bdbba623df354e08628a197f83a7cd60e0";
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
--------dc89c907ff7f479ab717576d317cd3bdbba623df354e08628a197f83a7cd60e0
Content-Type: multipart/mixed;
 boundary=7a8f01e420cd5a1778694cf9cfd61fb4f6c5869799d2c1f0e84206eb75b3
Message-ID: <904e82be-40df-45d1-afc9-bb658ac9be8c@proton.me>
Date: Mon, 20 Apr 2026 15:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Krottmayer <krotti83@proton.me>
Content-Language: en-US, de-AT
To: u-boot@lists.denx.de
Subject: cmd: fatload: command doesn't update $filesize after next calls

--7a8f01e420cd5a1778694cf9cfd61fb4f6c5869799d2c1f0e84206eb75b3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I'm figured out an issue with the command 'fatload':

Here the file list with the command 'fatls':

---
StarFive # fatls mmc 1:3
  3048997   firmware.itb
   149225   u-boot-spl.bin.normal.out
     3184   depp.efi
    12318   hello.efi
    44122   jh7110-starfive-visionfive-2-v1.3b-8G.dtb

5 file(s), 0 dir(s)
---

As you can see the files have different sizes.

First invoke of the command 'fatload' saves the correct size in
the variable $filesize:

---
StarFive # fatload mmc 1:3 $loadaddr u-boot-spl.bin.normal.out $filesize
149225 bytes read in 9 ms (15.8 MiB/s)
StarFive # echo $filesize
246e9
---

When trying to load a new file with 'fatload', the variable $filesize
still contains the old size from the previous call:

---
StarFive # fatload mmc 1:3 $loadaddr firmware.itb $filesize
149225 bytes read in 9 ms (15.8 MiB/s)
StarFive # echo $filesize
246e9
StarFive #
---

Has somebody noticed the same issue? Noticed in U-Boot version at least

v2025.10 and v2026.05.

Kind regards,

Johannes K.

--7a8f01e420cd5a1778694cf9cfd61fb4f6c5869799d2c1f0e84206eb75b3
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
--7a8f01e420cd5a1778694cf9cfd61fb4f6c5869799d2c1f0e84206eb75b3--

--------dc89c907ff7f479ab717576d317cd3bdbba623df354e08628a197f83a7cd60e0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmnmJusJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcme2J1FF8MEl24OAFN8yfslsFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AAE4YAQDnR5k/h4jxUUHb7W358RljprROJgdW8jt9lwlX
7hmU2AEA9vWiEv04EvAfo8/NA0Y41s+1Y8DMgWEpEKhupAyvDwk=
=Hg7P
-----END PGP SIGNATURE-----


--------dc89c907ff7f479ab717576d317cd3bdbba623df354e08628a197f83a7cd60e0--

