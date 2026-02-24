Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E077DF4BB82
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 19:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1B283642;
	Tue, 24 Feb 2026 20:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="RdaOCwv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 848F283981; Tue, 24 Feb 2026 20:51:32 +0100 (CET)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F5882BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 20:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1771962689; x=1772221889;
 bh=r67IB6SlaLCAeJfNUSiK5p0Q7yeD3dwFMbxwM+4ORo8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=RdaOCwv8xkVLxD9r5HpdXCOQzDI442DvAxYHD5FM3pDBXiKYLqC+nYstnkLUxi3ly
 epY8uWvu4Nmy7D+eqAr7sRuZPrQhdRxwXvG4Kf8xcYupXL5BRRVbh2kpBtmcJ9fvcT
 aZtG86r5CjAC2Zkk7wyCyNXoLfPwqrWcJHjASdKZugkFGKjGkfakfZOHeyGrgcWrgB
 5TrTGDMkpOwXro6cINjl9G67se4UfeFknWvUWzE5nz3+8pgZRKXMzSYTczGqIKwktt
 dwmAT0nkXYPGp2x3Vr+bEZOJ0xl9hVIyA0vpDmGAfNc/gC5roGaZe7TkwC+eM2f4HR
 QSRqtAGZD2pNg==
Date: Tue, 24 Feb 2026 19:51:22 +0000
To: Tom Rini <trini@konsulko.com>
From: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
Message-ID: <2e07b2ea-2c5c-40de-ab27-ed1234c3bdab@proton.me>
In-Reply-To: <20260224193312.GB3233182@bill-the-cat>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 45d8d8e2e8b3458f646fe9aa3a78a639213f0d6e
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------9ad91a5f6c8f783aa7a88f05f526917c03264e0b74f26007a915bd07f56b4cdf";
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
--------9ad91a5f6c8f783aa7a88f05f526917c03264e0b74f26007a915bd07f56b4cdf
Content-Type: multipart/mixed;
 boundary=00d5be5a60007bf6679922179939b6e10733cc2864ead4679d27baa32eae
Message-ID: <2e07b2ea-2c5c-40de-ab27-ed1234c3bdab@proton.me>
Date: Tue, 24 Feb 2026 20:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
To: Tom Rini <trini@konsulko.com>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <eWuRINFBfv8gwVVxMHtuvnYoN45dmah7hHtQGlyg7s7xi9zhiy4Vy4_X7_BsB9i919A5j6Z4MCUsrEZJUn1Hkw==@protonmail.internalid>
 <20260224193312.GB3233182@bill-the-cat>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
In-Reply-To: <20260224193312.GB3233182@bill-the-cat>

--00d5be5a60007bf6679922179939b6e10733cc2864ead4679d27baa32eae
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Tom!

On 2/24/26 8:33 PM, Tom Rini wrote:
> On Tue, Feb 24, 2026 at 07:23:54PM +0000, Johannes Krottmayer wrote:
>> Hello Tom!
>>
>> On 2/24/26 6:09 PM, Tom Rini wrote:
>>> On Tue, Feb 24, 2026 at 10:26:35AM +0000, Johannes Krottmayer wrote:
>>>
>>>> Hello,
>>>>
>>>> I'm tried to compile U-Boot for an QEMU AArch64 environment, but get
>>>> some error messages in SPL:
>>>>
>>>> --
>>>> Bloblist at 0 not found (err=-2)
>>>> alloc space exhausted ptr 400 limit 0
>>>> Bloblist at 0 not found (err=-2)
>>>>
>>>>
>>>> U-Boot 2026.01 (Feb 24 2026 - 10:22:15 +0100)
>>>> [...]
>>>> --
>>>>
>>>> Started the QEMU instance with the command line:
>>>> $ qemu-system-aarch64 -m 4G -machine virt -cpu cortex-a53 /
>>>> bios u-boot.bin
>>>> $
>>>>
>>>> Also the same errors when I use TF-A and OP-TEE with enabled
>>>> EL3 and EL2 in QEMU and "u-boot.bin" as BL33.
>>>>
>>>> Has somebody noticed the same issue?
>>>>
>>>> I used the configuration "qemu_arm64_defconfig"
.
>>>
>>> That's odd. We run it in CI, but as cortex-a57 not a53 with otherwise
>>> similar arguments. Running with TF-A/OP-TEE is also in CI, but more
>>> difficult to configure.
>>>
>>
>> I have tried it now with the Cortex-A57 but running into the same
>> issue without OP-TEE and TF-A. Using OP-TEE and TF-A works now
>> without the issue because I have forgotten to pass the option
>> TRANSFER_LIST=1 to TF-A and CFG_TRANSFER_LIST=y and
>> CFG_MAP_EXT_DT_SECURE=y to OP-TEE.
>>
>> Host OS: Debian 13 (Trixie)
>> QEMU version:
>> $ qemu-system-aarch64 --version
>> QEMU emulator version 10.0.7 (Debian 1:10.0.7+ds-0+deb13u1+b1)
>> Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
>> $
>>
>> BTW: doc/board/emulation/qemu-arm.rst doesn't mention how to build
>> U-Boot with OP-TEE and TF-A. Should I include the build steps into the
>> docs and create a patch for the doc? I think it's also useful for
>> other users.
> 
> Yes, some doc updates woul
d be appreciated and please CC the board
> maintainers as well. And perhaps the question I forgot to ask earlier
> is, are you seeing those as fatal errors, or just noting they exist?
> 

My personal opinion:

I see the "bloblist not found" personally only as
warning. But I think the memory allocation issue should be
investigated and maybe fixed, because I think it could have
site effects.

But I don't know the memory allocation code fully from U-Boot,
so therefore the "site effects" is only a guess as normal user.

-- 
Kind regards,

Johannes K.


--00d5be5a60007bf6679922179939b6e10733cc2864ead4679d27baa32eae
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
--00d5be5a60007bf6679922179939b6e10733cc2864ead4679d27baa32eae--

--------9ad91a5f6c8f783aa7a88f05f526917c03264e0b74f26007a915bd07f56b4cdf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmmeATkJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmci16vUCE1YrLRGKxwVz8FNFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AACNWAP0bEYm3A4QT1eRadZVAHv+K8wbCXm6MDOCwGs16
YouzgAEA2CxaWfxGuCEfkUnixqg8PpMP5TctzLW2HlBR/TmtDw4=
=wnPH
-----END PGP SIGNATURE-----


--------9ad91a5f6c8f783aa7a88f05f526917c03264e0b74f26007a915bd07f56b4cdf--

