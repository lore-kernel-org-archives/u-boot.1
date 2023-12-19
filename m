Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F88C35274
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 02:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CDC8701D;
	Tue, 19 Dec 2023 03:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="l9Au3hGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A5E87032; Tue, 19 Dec 2023 03:15:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CAF986FF4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 03:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702952139; x=1703556939; i=xypron.glpk@gmx.de;
 bh=ajvqpRyr5tN8Gs0n6kePULZT51mYPY411T/+93Bw05Q=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=l9Au3hGkwIgHtM5Bi4/09bcaNC/j56pukaf2f679SUhrSn0H671LSNzeya8SKDVt
 3YGUbxZHgZEmhfWrZsMzj+NFKeT9FdD1M4TvRAJj592DT5hzKRFA/xceFlBQL71Zv
 jUQs32OLfDiccv8VlE04pYHBlhxVsoMy22sUDlEO0WbrHPBpnba9OFM4XImohWixo
 o5tlGfLjZWYDP8ypm3X+8r+wGiAnHd6uDj9gc2JViRVnY0DWRH38xr1Mw7f3/0YgO
 iC92QMn9hF6fm1mX+hCz96LSVAj1esk20kmruLvUNbdFWAudFDIuYPgvsPnqnoJvU
 5IrhiSlhEZQR+2106Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfJX-1r1ioG10O7-00vBzv; Tue, 19
 Dec 2023 03:15:39 +0100
Date: Tue, 19 Dec 2023 03:15:38 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <20231219012600.GQ2513409@bill-the-cat>
References: <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
Message-ID: <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ln5dBtEIkR59Ex0gdPYQmcR1HjAaCnv6MYQYzzQ5MxlELiO/UiF
 aMtOFF1gcPJKsrQicEULiVyx4cpS5hwAU8nB0wOq8XjmpUiZHm6mYtNFJPRGw70VErjG8v8
 QeA6UL4RAUaDsyQQu5Abf1djtR5+mizPyZfUmh8gbrpqeacZiytNALySoH6AnAR55zVBm0j
 8gjZ5n37raK6UEmh13EFQ==
UI-OutboundReport: notjunk:1;M01:P0:3vySec/Mdio=;EiaTg0qyadIkqADchC5NsocbWuy
 h+Qe/V9pjPhO2qg8H8H452bqBz4L7vohIxipqxQNBVqCKCDt0NV7D6Oc5kqZOAj/oWWL+A1iF
 kmsajV/gKbWUzknTW77DLVEo7H/9r97rFlZIY3RkFETnqdvKXEifQp+mqJuk93V+hsr9sT1Cn
 d4cyrYCpLqgPSYHVikaadMJHyweFDhR4mPpHvy7L9oFyizAJmsL0hv6Tf0iYQ5MPlbGbAmVz/
 1xd/QUE7/8naS5XYjlehRGc183xT42PrA9yiZ8MhHjpvc6wDHbAPKhCnF+G9Dq7kpHRDSPtGy
 VBo10BVSVJr5Fe2JAXQ28hoNO+jbSSy/JPVPOujaJZCNvTPffkJ4tCDst4/YZk0HK96sDTZuh
 R817Kvuv3ZNd/spxtfHXoj9Uh/YmLfo5QRlHS7fvXJug56THMQbRuy7DAcGQRqYRmpYsgasCt
 JzIUX1THNOfTLVlvOYpsd7u7HDTOOcvESE7adsLB1vhQ9zJwhzGErawaogxSheuBO/OjS9AHQ
 BCie4Jq38Am4ZFzMdJY4uZJDeEbcH+oJsYi4fGBbpbUOWfWdnLuaFU40ylig/fdXLHGgrik5t
 F2NCNKHu3pe70bVfBotsfiL0XjcNXG9LM6vL+XsaFtRASQ6MGympDvPNj7XxD9HF2//WHLk10
 /u7yvFhniBBDKBMnlrXPbfjdvyiDESxPUI1NHmQTCl97cHnCdetBvogz6TcpkNAU8iVFYlBHB
 T2zdXhOlSFXk5FZNRUdYo1Ef5f5RwG5RLmwMQ5BKLSEdH3AYQVBABU0+U7WxB3v+pn013ZBAx
 AacAMwC61i2xnhaA2NiX8dHiKSYOc/OjfqRK7C0V5tOBGTgtcgKeKBVD8c/vCTr85WYyVnuMQ
 cUW1vH3Bfsp2OOqfZnOmJG1C3oCUIJme0kUvhxiho63/bqUAf+SdA5++NNhHZ74m4gOeYmbAs
 AX/htS+pn+R4776B1Nn6DhSFhZw=
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



Am 19=2E Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt wrote:
>>=20
>>=20
>> Am 19=2E Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsulko=2E=
com>:
>> >On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wrote:
>> >>=20
>> >>=20
>> >> Am 19=2E Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsulko=
=2Ecom>:
>> >> >On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wrote=
:
>> >> >>=20
>> >> >>=20
>> >> >> Am 18=2E Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsu=
lko=2Ecom>:
>> >> >> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt wr=
ote:
>> >> >> >
>> >> >> >[snip]
>> >> >> >> Or take:
>> >> >> >>=20
>> >> >> >> load host 0:1 $c kernel=2Eefi
>> >> >> >> load host 0:1 $d initrd=2Eimg
>> >> >> >>=20
>> >> >> >> How could we ensure that initrd=2Eimg is not overwriting a par=
t of kernel=2Eefi without memory allocation?
>> >> >> >
>> >> >> >Today, invalid checksum as part of some part of the kernel fails=
=2E But
>> >> >> >how do we do this tomorrow, are you suggesting that "load" perfo=
rm
>> >> >> >malloc() in some predefined size? If $c is below $d and $c + ker=
nel=2Eefi
>> >> >> >is now above $d we can throw an error before trying to load, yes=
=2E But
>> >> >> >what about:
>> >> >> >load host 0:1 $d initrd=2Eimg
>> >> >> >load host 0:1 $c kernel=2Eefi
>> >> >> >
>> >> >> >In that case (which is only marginally contrived, the more real =
case is
>> >> >> >loading device tree in to unexpectedly large ramdisk because som=
eone
>> >> >> >didn't understand the general advice on why device tree is lower=
 than
>> >> >> >ramdisk address) I'm fine with an error that amounts to "you jus=
t
>> >> >> >corrupted another allocation" and then "fail, reset the board" o=
r so=2E
>> >> >> >
>> >> >>=20
>> >> >> Our current malloc library cannot manage the complete memory=2E W=
e need a library like lmb which should also cover the memory management tha=
t we currently have in lib/efi/efi_memory=2Ec=2E This must include a memory=
 type attribute for usage in the GetMemoryMap() service=2E A management on =
page level seems sufficient=2E
>> >> >>=20
>> >> >> The load command should permanently allocate memory in that lmb+ =
library=2E
>> >> >>=20
>> >> >> We need an unload command to free the memory if we want to reuse =
the memory or we might let the load comand free the memory if exactly the s=
ame start address is reused=2E
>> >> >
>> >> >Our current way of loading things in to memory does not handle the =
case
>> >> >I described, yes=2E How would what you're proposing handle it?
>> >>=20
>> >> If the load command has to allocate memory for the image and that al=
location is kept, any attempt to allocate overlapping memory would fail=2E
>> >
>> >So you're saying that the load command has to pre-allocate memory? Or =
as
>> >it goes? If the latter, in what size chunks? This starts to get at wha=
t
>> >Simon was talking about with respect to memory fragmentation=2E Which =
to
>> >be clear is a problem we have today, we just let things overlap and ho=
pe
>> >something later catches an incorrect checksum=2E
>> >
>>=20
>> I don't want to replace the malloc library which handles large numbets =
of allocations=2E
>
>I'm confused=2E The normal malloc library is not involved with current
>image loading, it's direct to memory (with some attempts at sanity
>checking by lmb)=2E  Are you proposing a different allocator with
>malloc/free like behavior? If so, please outline how it will determine
>pool size, and how we'll use it to load thing to memory=2E

All memory below the stack needs to be managed=2E Malloc uses a small memo=
ry area (a few MiB) above the stack=2E

>
>> Closing the eyes when the user loads multiple files does not solve the =
fragmentation problem=2E
>
>Yes=2E I'm only noting that today we just ignore the problem and sometime=
s
>catch it via checksums=2E
>
>> Fragmentation only happens if we have many concurrent allocations=2E  I=
n EFI we are allocating top down=2E The number of concurrent allocations is=
 low=2E Typically a few dozen at most=2E After terminating an application t=
hese should be freed again=2E
>
>OK, so are you saying that we would no longer be loading _to_ a location
>in memory and instead just be saying "load this thing" and picking where
>dynamically?

Both preassigned and allocator assigned adresses are compatible with memor=
y management=2E

Architectures and binaries have different requirements=2E On riscv64 you c=
an load Linux kernel, initrd, fdt anywhere=2E We don't need predefined addr=
esses there=2E Other architectures have restrictions=2E

>
>> When loading a file from a file system we know the filesize beforehand=
=2E So allocation is trivial=2E
>>=20
>> The loady command currently does not use the  offered size information =
but could do so=2E
>
>We should be using that information to make sure we don't overwrite
>U-Boot itself, but I don't recall how exactly we handle it today
>off-hand=2E

If the user issues multiple load commands, he can overwrite previous files=
=2E

During boot command execution I guess the different allocations respect ea=
ch other=2E

>
>> TFTP is problematic because it does not transfer the filesize=2E We wou=
ld probably try to allocate a large chunk of memory and then downsize the a=
llocation after reading the whole file=2E
>
>Reading from non-filesystem flash also has this problem, but we at least
>specify the amount to read too=2E But yes, it gets back to what I was
>asking about on how you're proposing to handle network load cases=2E
>

It depends on the protocol=2E Http conveys the size before the data=2E Tft=
p does not=2E

If you don't know the size, you must preallocate a big chunk, check that t=
he download does not exceed it, and downsize the allocation afterwards=2E T=
his is not a new problem but exists already with current lmb usage=2E

Best regards

Heinrich
