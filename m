Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6275C48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 11:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B46787DCD;
	Sat, 17 Feb 2024 12:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mGxDtBmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D5787E07; Sat, 17 Feb 2024 12:02:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27ABE87C9E
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 12:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708167766; x=1708772566; i=xypron.glpk@gmx.de;
 bh=gETfOjBXgBoh6TBxVd53BNK6XErnvE1RNzVih5PD/PU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=mGxDtBmhZ92egDaVFpIp2DTzeDAH247ib1QYFNu3+Ihf28wObvIadKz0ESrrHTcJ
 wNaAtSEMpwb3Ni9hCYZlgGP5OYOv/wEE6Z5becQRWotn8cvED2BovM4QIy8uZfSQL
 2sRY0hBqGwpCxFn6OMbr4G9+SYgm4CiwRD3HjIoqCsBGXXWGUIq7MRZm5MDr/S2hc
 U2R0Ie5vqOqvujjHlmW1QQtMlh5maXtwfIQFix4PLVtfuVBw+4isPZRHW09V27XUB
 tkMFTmaRF/D7wAZC75MIvr9MTu1IO64cJdlMVNmvYRPv7Rq+mYQneuR7LUV52Mqy/
 LZzdtPwnbSxIbklATA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1qtoV21j50-010MJM; Sat, 17
 Feb 2024 12:02:46 +0100
Message-ID: <d0a7c8f9-70ed-496c-9905-53e300dc65c7@gmx.de>
Date: Sat, 17 Feb 2024 12:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Don't carve out memory reservations too early
Content-Language: en-US, de-DE
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: kettenis@openbsd.org, u-boot@lists.denx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
References: <20240215232534.61854-1-kettenis@openbsd.org>
 <E6C02326-1F4B-446E-86F3-93AACE34814E@gmx.de>
 <875xyoo5mr.fsf@bloch.sibelius.xs4all.nl>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <875xyoo5mr.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZyL85G5w09mRN+OMwavDIpWNI5emUO35geMJfBLs48WrVlJFT2v
 AbxFSN9uk53I2YbKdMVeAs6e1y+jmzGfbZcnDf+sQ32wWdPMjV3rW+Ysh4LWHzWwQYxFX0Z
 5+MSzl7hOVT/peV/rP55z+w4QdDU8DelZcvm4ZeZyU+P7nLlaAcPazqNwPi0KkTCbNj1X4V
 AsgJtrPyUjV1Tqintpo0w==
UI-OutboundReport: notjunk:1;M01:P0:KB3GUnxznX8=;IoDOaPQsGGo/toRnQJ56ZuEOV/j
 S0UiFnbu6yia4ZFKxvJFX0P0SKZcF4UpFdlTRVHCPk+B4mrK10x7c1fApNsIXGwI1dBOFmKXi
 pm/Tnh+4kj6bCRaI4HaVJxYwrZ0dAP9+AuiRjUTfm45Tp2ioKmI25h0xHU9iV2NHKaOq0Irdv
 1bCnteYZP6F6C+c4gNGMOCqKsgKYf+1Ksspp1QXnOwSv927TO5i8B7pixl9/dkh79/g6q+Sk+
 TrpitDcv2ZJ/ZHNTuq15APaHWjxb1ftJcvREAUfBSJ05Ty6Q408y8lH8T2B6dyjtcZ4UDbKjs
 6V9bbSnun0oXNfEu02sLxb0FfhMjDK4kD1EFGFcuqmmOIjK9h0cKyRMzO+ERqxla0FmjW1z0O
 HrG67r0FSMdDASrlsRzEnqLarqQDXJUFg0RTPrvxQkXDMrZy0eMOGT4osvxwgRCSxEJHEkqhG
 mGrRxU0n3AqJk//o0931ln29+xUmJ44FmoLVkHRzDFCQzC4L/O8d8aEEqq1HumOdUHM1uKn/X
 AzcI3gzojx0Wi5AdN7F4pkGMWwyykoT7Wdw8lyWzzLOPzxMNYs8GrVJ7jNW+GqwDVmGtM+htR
 ed8KTVpWLzXMKh8Cn52V27P/1UblkbctuAKT/F7MwmtCj+vjHiPMx6xLJnop+2Ks5MfsCU1CJ
 OVQyJhERyit2ATrXWichG+XOLJn43keJnoebAzni84E1PU4/AIcrOIf6Sr+HTJs9kQqyjDFWx
 U7U8JB+MusXsqJcw+EjLPzrqcD0/PHqlIRyXXscvESl6i9OfUv4ykPNEOeoj2TdRvJIuQM9ZG
 HLPO917xVhpvu1LeAW/XgMyun7Bcp+FgR54xsRBUoGOS8=
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

On 2/16/24 3:17 PM, Mark Kettenis wrote:
>> Date: Fri, 16 Feb 2024 00:38:25 +0100
>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>> Am 16. Februar 2024 00:25:34 MEZ schrieb Mark Kettenis <kettenis@openbs=
d.org>:
>>> Moving the efi_carve_out_dt_rsv() call in commit 1be415b21b2d
>>> ("efi_loader: create memory reservations in ACPI case")
>>> broke boards that create additional memory reservations in
>>> ft_board_setup() since it is now called before those additional
>>> memory reservations are made.  This is the case for the rk3588
>>> boards and breaks booting OpenBSD on those boards.
>>>
>>> Move the call back to its original location and add a call in
>>> the code path used for ACPI.
>>>
>>> Fixes: 1be415b21b2d ("efi_loader: create memory reservations in ACPI c=
ase")
>>> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
>>> ---
>>> lib/efi_loader/efi_helper.c | 11 +++++++----
>>> 1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
>>> index 5dd9cc876e..58761fae78 100644
>>> --- a/lib/efi_loader/efi_helper.c
>>> +++ b/lib/efi_loader/efi_helper.c
>>> @@ -456,11 +456,11 @@ efi_status_t efi_install_fdt(void *fdt)
>>> 		return EFI_LOAD_ERROR;
>>> 	}
>>>
>>> -	/* Create memory reservations as indicated by the device tree */
>>> -	efi_carve_out_dt_rsv(fdt);
>>> -
>>> -	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE))
>>> +	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
>>> +		/* Create memory reservations as indicated by the device tree */
>>
>> Imagine booting the rk3588 board with ACPI.
>
> I'd rather not, thank you ;)
>
>> Wouldn't we miss creating the ft_board_setup() reservations before
>> efi_carve_out_dt_rsv(fdt)?
>
> Yes.  And arguably the these memory reservations should be made way
> earlier, at the the time that efi_memory_init() runs.  I think we're
> just lucky that efi_allocate_pages() doesn't hand us memory from these
> areas in copy_fdt().
>
> Better ideas?
>

image_setup_libfdt(&img, fdt, NULL) must be called before
efi_carve_out_dt_rsv().

Could you, please, add this call in this path, too. Otherwise the patch
looks correct.

Best regards

Heinrich

>
>>> +		efi_carve_out_dt_rsv(fdt);
>>> 		return EFI_SUCCESS;
>>> +	}
>>>
>>> 	/* Prepare device tree for payload */
>>> 	ret =3D copy_fdt(&fdt);
>>> @@ -474,6 +474,9 @@ efi_status_t efi_install_fdt(void *fdt)
>>> 		return EFI_LOAD_ERROR;
>>> 	}
>>>
>>> +	/* Create memory reservations as indicated by the device tree */
>>> +	efi_carve_out_dt_rsv(fdt);
>>> +
>>> 	efi_try_purge_kaslr_seed(fdt);
>>>
>>> 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
>>
>

