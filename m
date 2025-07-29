Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D19C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C9B8277D;
	Tue, 29 Jul 2025 17:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iV5vLgew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B8482BA1; Tue, 29 Jul 2025 17:34:26 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C607382103
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753803255; x=1754408055; i=xypron.glpk@gmx.de;
 bh=cDerpflVPcafT1Te0stqBzUhoy91PG9KMUDYlE+dckw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iV5vLgewjTf3iSo7/k4iqvOXsseQzuQV6GsezSEQvvzf8wZ9/Nyywi1X7aK+2gxy
 Z2gRUNfpbS87QsK34LTS9Mbgxug2FxifZbpjf3eGZ2SxqTScvdPZnTtvwQ4+/mSeA
 soz7JPz0Lu9Shlwqr7oaYvOBUHPFVAZS79xuwgyVe3xOOnDgPy9rfOHu70ON/4b6b
 tBunlNyZKvw715TyPesumnyjcmfuQ4IoxKC0KJcv9iU7kF4wFtJ6zILV2LxLo2LzR
 Ky8UUFGZJVrz0yvciGkyG+92Pn5iXfEl5RAFuvuM2+AMBzvrt87ytbkuJAEFfD2zS
 NC7BXln98rWuDvKWAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1v3pUx1upY-00SaHu; Tue, 29
 Jul 2025 17:34:15 +0200
Message-ID: <eaeb50e6-cdb7-40ab-baa1-d280ad61ed61@gmx.de>
Date: Tue, 29 Jul 2025 17:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm64: stack backtraces
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
 <e91ce58d-405a-4161-85b6-36afb63aa1fc@gmx.de>
 <81467621-2ad5-4980-bc3d-2be38a3ee725@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <81467621-2ad5-4980-bc3d-2be38a3ee725@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zSqDAi34q5xlVXc6iPTfnOKw9KBAi4h3ghRuO0vVwqgL1NlgLaj
 Ib/dKjo6urknvRwyuAn/Wm8uxvfobX1z+GFH3Om/5NEknFphJBzNolHwCBvtf1uurR5E1/A
 T6yaypScO4Q+woDrtxK0E+nQf/vnMjJkhkn83+RXDHmk1eyLxopT5+S8cxR/O1UrOmEJIYa
 Cu3rym70gYOJ/j9h23Eew==
UI-OutboundReport: notjunk:1;M01:P0:7fS+KXdIiOg=;QLqTVCVLaGWQJw3Lt4dM+an3qY2
 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
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

On 29.07.25 14:34, Casey Connolly wrote:
>=20
>=20
> On 7/25/25 17:23, Heinrich Schuchardt wrote:
>> On 25.07.25 14:57, Casey Connolly wrote:
>>> Implement support for printing stack backtraces on ARM64, make
>>> framepointer support configurable by the build system with
>>> CONFIG_FRAMEPOINTER and teach U-Boot to walk the framepointers and
>>> unwind the stack when an exception occurs. Also show all 64 bits of th=
e
>>> exception syndrom register (ESR).
>>>
>>> Additionally, a new global unwind_stack() function is added, this can
>>> be called from anywhere to print a backtrace which can be useful when
>>> debugging certain problems.
>>>
>>> In the future, stack unwinding with symbol support could be extended
>>> to for example only emit log messages when a function is called in a
>>> specific code path. This would allow for less noise when debugging hot
>>> paths under certain conditions, but this feature is left as future wor=
k.
>>>
>>> =3D=3D=3D Handling relocation =3D=3D=3D
>>>
>>> Since U-Boot relocates itself at runtime, and can be built to be
>>> position independent in the first place (effectively "relocating" itse=
lf
>>> when it first starts too), we can't really rely on gd->reloc_off.
>>>
>>> The approach taken here is to subtract CONFIG_TEXT_BASE from the addre=
ss
>>> of each symbol in the lookup table (while it's being generated), then
>>> when decoding we just subtract the address of the _start label since i=
t
>>> is always correct pre and post relocation. This allows us to avoid all
>>> the awkward maths since the symbols are always relative to 0x0 in the
>>> lookup table.
>>>
>>> Example output:
>>>
>>> "Synchronous Abort" handler, esr 0x0000000096000004, far 0xfffffffffff=
ff
>>> elr: 000000009fc6f768 lr : 000000009fc6f710 (reloc)
>>> elr: 00000001ffe49768 lr : 00000001ffe49710
>>> x0 : 000fffffffffffff x1 : 0000000000000009
>>> x2 : 00000001efdbadd0 x3 : 0000000000000000
>>> x4 : 00000001efd99a28 x5 : 00000001ffec7676
>>> x6 : 00000001efdbac70 x7 : 0000000000000000
>>> x8 : 0000000000000002 x9 : 0000000000000034
>>> x10: 000000000000000d x11: 0000000000000006
>>> x12: 0000000000001000 x13: 00000000c3400000
>>> x14: 00000000fffffff8 x15: 00000001efd99837
>>> x16: 00000001ffe146b8 x17: 0000000000000000
>>> x18: 00000001efdbac70 x19: 000000000a6f8800
>>> x20: 00000001efe06fd0 x21: 0000000000000001
>>> x22: 00000001ffef5b80 x23: 00000001ffee08c0
>>> x24: 0000000000000002 x25: 0000000000000000
>>> x26: 0000000000000000 x27: 0000000000000000
>>> x28: 00000001efe512c0 x29: 00000001efd99c80
>>>
>>> Code: 2a010000 b9001260 d5033fbf 92fffe00 (39400001)
>>>
>>> CONFIG_TEXT_BASE=C2=A0=C2=A0 : 0x9fc00000
>>> Relocated base addr: 0x1ffdda000
>>> Backtrace:
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe496d0> dwc3_qcom_glue_configure+0x=
40
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe494a4> dwc3_glue_probe+0x10c
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe1757c> device_probe+0x254
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe1757c> device_probe+0x114
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe4ff70> usb_init+0x158
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe00fe4> do_usb_start+0xc
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe01018> do_usb+0x78
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe0dec4> cmd_process+0x140
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe04e24> run_list_real+0x6f0
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe05554> parse_stream_outer+0x148
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe04d30> parse_string_outer+0x90
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe0d148> run_command_list+0x50
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe02be0> main_loop+0x28
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffe065c0> board_init_r+0x3c8
>>> =C2=A0=C2=A0=C2=A0=C2=A0<0x000001ffddd00c> relocation_return+0x4
>>>
>>> Resetting CPU ...
>>
>> Thank you Casey for picking this up.
>>
>> It working fine but there are some points to think about:
>=20
> Thanks for taking a look!
>=20
>>
>> It would make sense to show both the relocated and the non-relocated=20
>> addresses like we do for elr and lr. The value after subtracting the=20
>> relocation address is what I need when looking at the objdump.
>=20
> OK, I can see why that would be useful, I'll give it a whirl.
>=20
>>
>> The format of addresses with and without symbols does not match:
>>
>> Backtrace:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0000007f6ba868> cmd=
_process+0x130
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0000007f6af900> run=
_list_real+0x718
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0000007f6b0058> par=
se_stream_outer+0x14c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0000007f6b06b4> par=
se_file_outer+0x34
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0000007f6b9dfc> cli=
_loop+0x18
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0000007f6ad6b0> mai=
n_loop+0x50
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0000007f6b0f94> boa=
rd_init_r+0x378
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x0000007f68400c> rel=
ocation_return+0x4
>>
>> Backtrace:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0000007f6d394c)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0000007f6c8fcc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0000007f6c9158)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0000007f6c969c)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0000007f6d2dc8)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0000007f6c66b4)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0000007f6ca2c0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0000007f69d010)
>>
>> I don't think parentheses are needed. But if we use them they should=20
>> look the same for the same content.
>=20
> I was trying to differentiate between the addresses being symbol=20
> addresses vs lr addresses, but yeah maybe the different parentheses=20
> doesn't add much here. I used the <> to follow the kernel style.
>=20
>>
>> I guess symbol lookup could be used in other places in future. I don't=
=20
>> see a necessity to let it depend on frame-pointers. Instead frame-=20
>> pointers should imply symbol-lookup. 'imply' should also work on RISC-=
=20
>> V where symbol-lookup is still missing.
>=20
> Makes sense to me.
>=20
>>
>> There should be at least one defconfig for 32-bit and one defconfig=20
>> for 64-bit that builds with both.
>=20
> Hmm, well I'll enable it in qcom_defconfig for sure, I don't have any=20
> 32-bit boards to test though, can you help with this?

QEMU is good enough for ensure compilation and manually testing using=20
the exception instruction or lib/efi_selftest/efi_selftest_exception.

I did not test your code with a crash in an EFI application yet.

Best regards

Heinrich

>=20
>>
>> I am missing the function name and offset for the function where the=20
>> exception actually occurred. Could we treat the value of elr like a=20
>> framepointer and add it as first line?
>=20
> Oh yeah, I messed this up actually we should pass elr in except_msg(),=
=20
> I'll fix that.
>=20
> Kind regards,
> // Casey (she/her)
>=20
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> ---
>>> Changes in v2:
>>> - Include calling function in backtrace (current LR)
>>> - Implement support for runtime symbol lookup
>>> - Use symbol lookup to print more informative backtraces when availabl=
e
>>> - Adjust backtrace format and print U-Boot base address
>>> - Link to v1: https://lore.kernel.org/u-boot/20250703051951.43372-1-=
=20
>>> heinrich.schuchardt@canonical.com
>>>
>>> To: Tom Rini <trini@konsulko.com>
>>> To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Cc: Rick Chen <rick@andestech.com>
>>> Cc: Leo <ycliang@andestech.com>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: u-boot@lists.denx.de
>>>
>>> ---
>>> Casey Connolly (3):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drop unused kallsyms support
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add support for symbol lookups
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: implement printing backtra=
ces with symbols
>>>
>>> Heinrich Schuchardt (4):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd/exception: missing include st=
ring.h
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kconfig: make CONFIG_FRAMEPOINTER=
 available on arm64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: initialize the frame point=
er register
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: simplify interrupt code
>>>
>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 25 ++
>>> =C2=A0 Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 24 +-
>>> =C2=A0 arch/arm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +-
>>> =C2=A0 arch/arm/lib/crt0_64.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
>>> =C2=A0 arch/arm/lib/interrupts_64.c | 133 ++++++---
>>> =C2=A0 arch/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 21 --
>>> =C2=A0 common/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>> =C2=A0 common/kallsyms.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 ---
>>> =C2=A0 common/system_map.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 8 -
>>> =C2=A0 include/exception.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 include/symbols.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 ++
>>> =C2=A0 lib/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
>>> =C2=A0 lib/symbols.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 141 ++++++++++
>>> =C2=A0 tools/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>>> =C2=A0 tools/symbols.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 646 ++++++++++++++++++++++++++++++++=20
>>> + ++++++++++
>>> =C2=A0 15 files changed, 965 insertions(+), 121 deletions(-)
>>> ---
>>> base-commit: f2f451d9d6d3756458d5037e3e5135e5211582d7
>>>
>>> // Caleb (they/them)
>>>
>>>
>>
> .

