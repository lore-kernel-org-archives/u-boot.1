Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F793F4BB80
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 19:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AFC183642;
	Tue, 24 Feb 2026 20:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="deuqBLUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 243F883981; Tue, 24 Feb 2026 20:24:00 +0100 (CET)
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch
 [109.224.244.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3C382BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 20:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1771961037; x=1772220237;
 bh=yqhPeiSOn+H6uIMRcx+4JJeHmpSd8c/CAhtNCmEdt00=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=deuqBLUIC7bm8MIbj2eBB1ejFWwSbBwgfQ5f1qhSqAzq9Vq50P+0nDufQcB1xhYcs
 WVCuQ9C6WDuS9cgWerkkBD0pZc9g4TAXbaiS0G2OlO/f8EWhTualE0/1mz105JGOxG
 oy0AAjT/e9pKSFlVuwjzhSy8C2oyh9sVFFUOp/2bxH/yOCDYRnzGMZ+kATlwX06Ezc
 v56/lkdk+AW0AQLlXXsWq7e/T1iNYV5Yepd//FZVabtrb+Sm26aX7CjajK72U2iedV
 Zh07swYP+lldV0mPpAMv2Aw2ESNoybQKy/cD141Pk+yEY2BmiWrBgk7ZgGv4JbjDK/
 Yb6WuWQatLVZQ==
Date: Tue, 24 Feb 2026 19:23:54 +0000
To: Tom Rini <trini@konsulko.com>
From: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
Message-ID: <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
In-Reply-To: <20260224170908.GZ3233182@bill-the-cat>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 8b6d5ffab00302118e8d56c889307db77a64d144
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------83f846601591812f1c26b5d18e9e0f64a12baaf6f65fb2626b48ef837afda63f";
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
--------83f846601591812f1c26b5d18e9e0f64a12baaf6f65fb2626b48ef837afda63f
Content-Type: multipart/mixed;
 boundary=e16c49e482d16f9cdb562f3c6ccea9560054ccae384a9388bf032576b75b
Message-ID: <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
Date: Tue, 24 Feb 2026 20:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
To: Tom Rini <trini@konsulko.com>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <65qaCRisfTdS6ualFlbblE05vTDAqzvNRNDRt3UyiCGJpXvxpdTVo9Pfx3SFpjbCd5_uH1wrkUCMn8tmgbDO6g==@protonmail.internalid>
 <20260224170908.GZ3233182@bill-the-cat>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
In-Reply-To: <20260224170908.GZ3233182@bill-the-cat>

--e16c49e482d16f9cdb562f3c6ccea9560054ccae384a9388bf032576b75b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Tom!

On 2/24/26 6:09 PM, Tom Rini wrote:
> On Tue, Feb 24, 2026 at 10:26:35AM +0000, Johannes Krottmayer wrote:
> 
>> Hello,
>>
>> I'm tried to compile U-Boot for an QEMU AArch64 environment, but get
>> some error messages in SPL:
>>
>> --
>> Bloblist at 0 not found (err=-2)
>> alloc space exhausted ptr 400 limit 0
>> Bloblist at 0 not found (err=-2)
>>
>>
>> U-Boot 2026.01 (Feb 24 2026 - 10:22:15 +0100)
>> [...]
>> --
>>
>> Started the QEMU instance with the command line:
>> $ qemu-system-aarch64 -m 4G -machine virt -cpu cortex-a53 /
>> bios u-boot.bin
>> $
>>
>> Also the same errors when I use TF-A and OP-TEE with enabled
>> EL3 and EL2 in QEMU and "u-boot.bin" as BL33.
>>
>> Has somebody noticed the same issue?
>>
>> I used the configuration "qemu_arm64_defconfig".
> 
> That's odd. We run it in CI, but as cortex-a57 not a53 with otherwise
> similar arguments. Running with TF-A/OP-TEE is also in CI, but more
> difficult to configure.
> 

I 
have tried it now with the Cortex-A57 but running into the same
issue without OP-TEE and TF-A. Using OP-TEE and TF-A works now
without the issue because I have forgotten to pass the option
TRANSFER_LIST=1 to TF-A and CFG_TRANSFER_LIST=y and
CFG_MAP_EXT_DT_SECURE=y to OP-TEE.

Host OS: Debian 13 (Trixie)
QEMU version:
$ qemu-system-aarch64 --version
QEMU emulator version 10.0.7 (Debian 1:10.0.7+ds-0+deb13u1+b1)
Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
$

BTW: doc/board/emulation/qemu-arm.rst doesn't mention how to build
U-Boot with OP-TEE and TF-A. Should I include the build steps into the
docs and create a patch for the doc? I think it's also useful for
other users.

-- 
Kind regards,

Johannes K.


--e16c49e482d16f9cdb562f3c6ccea9560054ccae384a9388bf032576b75b
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
--e16c49e482d16f9cdb562f3c6ccea9560054ccae384a9388bf032576b75b--

--------83f846601591812f1c26b5d18e9e0f64a12baaf6f65fb2626b48ef837afda63f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmmd+skJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdTkS7yWicRFbdiArUbAvfRFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AAM/wAQDmaWUpu2JmA+2cbvCbZeMyzaAg4AyOcs4X8dbQ
IjhF/AD/WkU9f1JHImkv7LaGb4ZtQqKP6S4vW6uz/cfMZrOgew8=
=mLxO
-----END PGP SIGNATURE-----


--------83f846601591812f1c26b5d18e9e0f64a12baaf6f65fb2626b48ef837afda63f--

