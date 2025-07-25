Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D57C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09315839B9;
	Fri, 25 Jul 2025 17:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tyI9mvQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D383A839BB; Fri, 25 Jul 2025 17:23:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31F3839B5
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753457021; x=1754061821; i=xypron.glpk@gmx.de;
 bh=42DtQigjfR6xBYB9HOH7vO95PnU6BoGq1YlXQ7Qf16A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tyI9mvQv78gYC1PBpMgsw89gbgqRfVwGIpmfRHNgz5wi4E6QhavEKWwfXCl9v+re
 CugF+8lNaoibFlzBfynqLWu8erZgXyBuB93/EFBek3okEYjf/o7Bcqeo4w2dK8kSj
 L2sX1EGPSimTkCLZL5PrBiDlbeV1vHRW3Ccdy10LkFcjADBaZ/Xm3MX5ydD26+4OD
 YyZAlaH2pUegZ4eXVbmMOKapUZQZiyR59vuFoClqYf78ZwUIQTg8IUE45XUBE5wt5
 h7fC+D7+QvYGclGcJ5TeCrHPWblFwdQReH8/l/6CkkfJ5jrI4wbRWabma9BPfU0f4
 bEZaA++oIX8jXvsfWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQic-1uoeC23uDu-00GTLZ; Fri, 25
 Jul 2025 17:23:41 +0200
Message-ID: <e91ce58d-405a-4161-85b6-36afb63aa1fc@gmx.de>
Date: Fri, 25 Jul 2025 17:23:38 +0200
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
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uh6BgdDyJtxX19PqKEEhM/dwNo9unH8wigoKZT9VEBp1oBVRnf/
 /AtdunbmsRmaAwrWCpcBoo/y1zly+MuJjPPmscrZB+IZV5uXadJNGzHr92T4YRc3wwi6HP+
 6bfaWxNwON8ujsCN3mA6sraWyj2kQAZr46L/Mkpi9WW5sgemGchtZ3tTr+iN1Lt9IjXkN6Y
 BvKVBdyAYDWYUqEXdHIHA==
UI-OutboundReport: notjunk:1;M01:P0:0b0SSqLLr1U=;8cYtNvEG3Bm7bDk8GSbCjXZBd5n
 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
 rA+/ov3MUoe8ojsSgGO1H8WrKzoEhsLk=
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

On 25.07.25 14:57, Casey Connolly wrote:
> Implement support for printing stack backtraces on ARM64, make
> framepointer support configurable by the build system with
> CONFIG_FRAMEPOINTER and teach U-Boot to walk the framepointers and
> unwind the stack when an exception occurs. Also show all 64 bits of the
> exception syndrom register (ESR).
>=20
> Additionally, a new global unwind_stack() function is added, this can
> be called from anywhere to print a backtrace which can be useful when
> debugging certain problems.
>=20
> In the future, stack unwinding with symbol support could be extended
> to for example only emit log messages when a function is called in a
> specific code path. This would allow for less noise when debugging hot
> paths under certain conditions, but this feature is left as future work.
>=20
> =3D=3D=3D Handling relocation =3D=3D=3D
>=20
> Since U-Boot relocates itself at runtime, and can be built to be
> position independent in the first place (effectively "relocating" itself
> when it first starts too), we can't really rely on gd->reloc_off.
>=20
> The approach taken here is to subtract CONFIG_TEXT_BASE from the address
> of each symbol in the lookup table (while it's being generated), then
> when decoding we just subtract the address of the _start label since it
> is always correct pre and post relocation. This allows us to avoid all
> the awkward maths since the symbols are always relative to 0x0 in the
> lookup table.
>=20
> Example output:
>=20
> "Synchronous Abort" handler, esr 0x0000000096000004, far 0xfffffffffffff
> elr: 000000009fc6f768 lr : 000000009fc6f710 (reloc)
> elr: 00000001ffe49768 lr : 00000001ffe49710
> x0 : 000fffffffffffff x1 : 0000000000000009
> x2 : 00000001efdbadd0 x3 : 0000000000000000
> x4 : 00000001efd99a28 x5 : 00000001ffec7676
> x6 : 00000001efdbac70 x7 : 0000000000000000
> x8 : 0000000000000002 x9 : 0000000000000034
> x10: 000000000000000d x11: 0000000000000006
> x12: 0000000000001000 x13: 00000000c3400000
> x14: 00000000fffffff8 x15: 00000001efd99837
> x16: 00000001ffe146b8 x17: 0000000000000000
> x18: 00000001efdbac70 x19: 000000000a6f8800
> x20: 00000001efe06fd0 x21: 0000000000000001
> x22: 00000001ffef5b80 x23: 00000001ffee08c0
> x24: 0000000000000002 x25: 0000000000000000
> x26: 0000000000000000 x27: 0000000000000000
> x28: 00000001efe512c0 x29: 00000001efd99c80
>=20
> Code: 2a010000 b9001260 d5033fbf 92fffe00 (39400001)
>=20
> CONFIG_TEXT_BASE   : 0x9fc00000
> Relocated base addr: 0x1ffdda000
> Backtrace:
> 	<0x000001ffe496d0> dwc3_qcom_glue_configure+0x40
> 	<0x000001ffe494a4> dwc3_glue_probe+0x10c
> 	<0x000001ffe1757c> device_probe+0x254
> 	<0x000001ffe1757c> device_probe+0x114
> 	<0x000001ffe4ff70> usb_init+0x158
> 	<0x000001ffe00fe4> do_usb_start+0xc
> 	<0x000001ffe01018> do_usb+0x78
> 	<0x000001ffe0dec4> cmd_process+0x140
> 	<0x000001ffe04e24> run_list_real+0x6f0
> 	<0x000001ffe05554> parse_stream_outer+0x148
> 	<0x000001ffe04d30> parse_string_outer+0x90
> 	<0x000001ffe0d148> run_command_list+0x50
> 	<0x000001ffe02be0> main_loop+0x28
> 	<0x000001ffe065c0> board_init_r+0x3c8
> 	<0x000001ffddd00c> relocation_return+0x4
>=20
> Resetting CPU ...

Thank you Casey for picking this up.

It working fine but there are some points to think about:

It would make sense to show both the relocated and the non-relocated=20
addresses like we do for elr and lr. The value after subtracting the=20
relocation address is what I need when looking at the objdump.

The format of addresses with and without symbols does not match:

Backtrace:
         <0x0000007f6ba868> cmd_process+0x130
         <0x0000007f6af900> run_list_real+0x718
         <0x0000007f6b0058> parse_stream_outer+0x14c
         <0x0000007f6b06b4> parse_file_outer+0x34
         <0x0000007f6b9dfc> cli_loop+0x18
         <0x0000007f6ad6b0> main_loop+0x50
         <0x0000007f6b0f94> board_init_r+0x378
         <0x0000007f68400c> relocation_return+0x4

Backtrace:
         (0x0000007f6d394c)
         (0x0000007f6c8fcc)
         (0x0000007f6c9158)
         (0x0000007f6c969c)
         (0x0000007f6d2dc8)
         (0x0000007f6c66b4)
         (0x0000007f6ca2c0)
         (0x0000007f69d010)

I don't think parentheses are needed. But if we use them they should=20
look the same for the same content.

I guess symbol lookup could be used in other places in future. I don't=20
see a necessity to let it depend on frame-pointers. Instead=20
frame-pointers should imply symbol-lookup. 'imply' should also work on=20
RISC-V where symbol-lookup is still missing.

There should be at least one defconfig for 32-bit and one defconfig for=20
64-bit that builds with both.

I am missing the function name and offset for the function where the=20
exception actually occurred. Could we treat the value of elr like a=20
framepointer and add it as first line?

Best regards

Heinrich

>=20
> ---
> Changes in v2:
> - Include calling function in backtrace (current LR)
> - Implement support for runtime symbol lookup
> - Use symbol lookup to print more informative backtraces when available
> - Adjust backtrace format and print U-Boot base address
> - Link to v1: https://lore.kernel.org/u-boot/20250703051951.43372-1-hein=
rich.schuchardt@canonical.com
>=20
> To: Tom Rini <trini@konsulko.com>
> To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Leo <ycliang@andestech.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: u-boot@lists.denx.de
>=20
> ---
> Casey Connolly (3):
>        drop unused kallsyms support
>        add support for symbol lookups
>        arm64: implement printing backtraces with symbols
>=20
> Heinrich Schuchardt (4):
>        cmd/exception: missing include string.h
>        Kconfig: make CONFIG_FRAMEPOINTER available on arm64
>        arm64: initialize the frame pointer register
>        arm64: simplify interrupt code
>=20
>   Kconfig                      |  25 ++
>   Makefile                     |  24 +-
>   arch/arm/Makefile            |   9 +-
>   arch/arm/lib/crt0_64.S       |   1 +
>   arch/arm/lib/interrupts_64.c | 133 ++++++---
>   arch/riscv/Kconfig           |  21 --
>   common/Makefile              |   1 -
>   common/kallsyms.c            |  42 ---
>   common/system_map.c          |   8 -
>   include/exception.h          |   1 +
>   include/symbols.h            |  22 ++
>   lib/Kconfig                  |   9 +
>   lib/symbols.c                | 141 ++++++++++
>   tools/Makefile               |   3 +
>   tools/symbols.c              | 646 +++++++++++++++++++++++++++++++++++=
++++++++
>   15 files changed, 965 insertions(+), 121 deletions(-)
> ---
> base-commit: f2f451d9d6d3756458d5037e3e5135e5211582d7
>=20
> // Caleb (they/them)
>=20
>=20

