Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D801EF36C41
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1518F839D5;
	Mon, 20 Apr 2026 10:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="KUHHsOfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E91840D8; Mon, 20 Apr 2026 10:03:52 +0200 (CEST)
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch
 [79.135.106.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0799983693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1776672227; x=1776931427;
 bh=17/or57IKRXpRfamNyOahAKPZlI6p/3mFdOm3nnCuFo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=KUHHsOfIRZ8ZD3OS+C2eH7XF62C0P/MYwPkwg2pDwNLOfI61VVP4H+0HNRoUjnV8M
 YCqN15v7wROUP+sqEYJ/tpSM0UZKYuS40uKyoQ4RmQa/3icLrlf1dBpvBCSMJpqB09
 k/NK/QIAPYAeAzCeZ3t4O4nhM3sEyZmhxOTCnguVPAHkKTAy9RhFrgl+DYQVseMOnE
 w58BgjMXPv44gMe4XYtB3nnJ7qSAGUDqqppVQhVaxCJplXyOUNiYuKx56EmYr6W4Ww
 tF96zJIivPrigOe5SNmaJjEktWx6Qvq34wKUtKFAZWDvLQmWL5E+cSFKDVw/hyzb+Q
 2PC+Ef51z+zMw==
Date: Mon, 20 Apr 2026 08:03:41 +0000
To: Simon Glass <sjg@chromium.org>, xypron.glpk@gmx.de
From: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tuomas.tynkkynen@iki.fi
Subject: Re: [PATCH 1/1] doc: emulation: qemu-arm: add secure state steps
Message-ID: <112145cf-76d2-41a8-bb3b-376e994b8468@proton.me>
In-Reply-To: <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
 <20260225020042.20823-1-krotti83@proton.me>
 <20260225020042.20823-2-krotti83@proton.me>
 <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 008c0aa75bc54d71f63ad97ec2e774ba100227cf
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------e20fa7c2cf0f0b5aff9f3044183c37772afc5c897158cb43cc0e4ab29b561507";
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
--------e20fa7c2cf0f0b5aff9f3044183c37772afc5c897158cb43cc0e4ab29b561507
Content-Type: multipart/mixed;
 boundary=0eab0f3ac84ec6c331ba6a67336cd1936ebf85e99a175ce494543e7cfe3d
Message-ID: <112145cf-76d2-41a8-bb3b-376e994b8468@proton.me>
Date: Mon, 20 Apr 2026 10:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: emulation: qemu-arm: add secure state steps
To: Simon Glass <sjg@chromium.org>, xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de, trini@konsulko.com, tuomas.tynkkynen@iki.fi
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
 <20260225020042.20823-1-krotti83@proton.me>
 <20260225020042.20823-2-krotti83@proton.me>
 <vL0XSmL7bvrzJnJ1QYRBsd41mQwmxRU-CqKeba5nR_K7-lamAGzbFh5oW-9w5YOpL22aTb5hihI8bok1Y1BpVQ==@protonmail.internalid>
 <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
Content-Language: en-US
From: Johannes Krottmayer <krotti83@proton.me>
In-Reply-To: <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>

--0eab0f3ac84ec6c331ba6a67336cd1936ebf85e99a175ce494543e7cfe3d
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon!

Thanks for the answer.

On 4/20/26 1:23 AM, Simon Glass wrote:
> Hi Johannes,
> 
> On 2026-02-25T02:01:39, Johannes Krottmayer <krotti83@proton.me> wrote:
>> doc: emulation: qemu-arm: add secure state steps
>>
>> Add build steps for building U-Boot in secure state with
>> TF-A and OP-TEE. It includes the full steps for building
>> OP-TEE and TF-A to use with U-Boot. Also a short
>> description how to invoke QEMU with enabled EL3 and EL2.
>> EL3 (machine option secure=on) is required to run TF-A.
>>
>> Signed-off-by: Johannes Krottmayer <krotti83@proton.me>
>> Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
>> Cc: Tom Rini <trini@konsulko.com>
>>
>> doc/board/emulation/qemu-arm.rst | 86 ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 82 insertions(+), 4 deletions(-)
> 
>> +OT-TEE
>> +^^^^^^
> 
> Typo: OP-TEE.
> 
>> +Building (none-secure)
>> +----------------------
> 
> I suspect this should be non-secure is the conventional spellin
g -
> same for 'Running U-Boot (none-secure)' below.
> 
>> +The following file is at least created with TF-A v2.14.0 and can directly passed
>> +with the '-bios' option to QEMU::
> 
> can be directly passed
> 
>> +If the single file doesn't exists 'bl1.bin' and 'fip.bin' can be concatenated with the
> 
> doesn't exist

Thanks for the fixes. Corrected.

>> +    dd if=bl1.bin of=flash.bin bs=4096 conv=notrunc
>> +    dd if=fip.bin of=flash.bin seek=64 bs=4096 conv=notrunc
> 
> Where does flash.bin come from?

With 'flash.bin' I have meant the file 'qemu_fw.bios'. Yes, I agree it's
not really clear. Have changed the part of the text and the file name:

---
If the single file ('qemu_fw.bios') doesn't exist 'bl1.bin' and 
'fip.bin' can be concatenated with the command 'dd' alternatively::

     dd if=bl1.bin of=qemu_fw.bios bs=4096 conv=notrunc
     dd if=fip.bin of=qemu_fw.bios seek=64 bs=4096 conv=notrunc
---

I will create and send a new patch, but before I 
need to know how these
mail patches are applied. As Heinrich mentioned there was an error at
a specific line, although I checked the patch before with the U-Boot
script 'scripts/checkpatch.pl' and unfortunately there were no error
and no warnings shown. Also sent the patch with 'git email'.

Is there a specific script how I can apply these mail patches on a
local branch to test the patches before I can send them?

Thanks in advance!

> Regards,
> Simon

Kind regards,

Johannes K.

--0eab0f3ac84ec6c331ba6a67336cd1936ebf85e99a175ce494543e7cfe3d
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
--0eab0f3ac84ec6c331ba6a67336cd1936ebf85e99a175ce494543e7cfe3d--

--------e20fa7c2cf0f0b5aff9f3044183c37772afc5c897158cb43cc0e4ab29b561507
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmnl3dsJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfZLk7Ugmck+NKnJJpdVQfCFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AACRBAQCHhyghSOQVOkhgAS3twa1QeCCdQ3m5sOAWplzd
sMkjlQD/UTtTnSnEu68BnYvch0Ol4fBrMnTzzTCSh+6wV09qKQk=
=O1C6
-----END PGP SIGNATURE-----


--------e20fa7c2cf0f0b5aff9f3044183c37772afc5c897158cb43cc0e4ab29b561507--

