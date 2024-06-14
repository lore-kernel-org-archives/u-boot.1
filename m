Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C5EC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7981388932;
	Fri, 14 Jun 2024 11:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DZae7bkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A28E88995; Fri, 14 Jun 2024 11:07:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484068892B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718356019; x=1718960819; i=xypron.glpk@gmx.de;
 bh=XFQx5rp2mL0Y2JyFen8NbnJliT7+wdmvw16KPuLozTc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DZae7bklPRiQSq5wvIJyLEVmsez4rmSGSsL1ar+9dPMmutmjlmwhL+F0TkCwUizF
 FRs2iorNMRNa7z1NN9KloGoT6viJWJeqTlrY232Of8E+HJZ5VAlZKAXEphROEebyB
 Ov4XutgYEF7QfJeYnAnlhIvaIvOQTiV81N4opU5ZG5Qm3JmypcFrbGI+qezEdbxq8
 /fZzQolbVeQqOioq11qdkCMli8L18/N0mPbBOjTSUbUvEWM26eAtdnjd4nPlIsxeP
 0/rDtEjZcJtnwG/HHttXkqZIi99Zf0fOZj+UJWKT7fqj1v7jIJUYq4oP0CrPgntSC
 D+mvzjvqCmHkhXyjFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1sdAmN2yay-00vnpq; Fri, 14
 Jun 2024 11:06:59 +0200
Message-ID: <973ea069-0524-4c32-8f44-77278521a368@gmx.de>
Date: Fri, 14 Jun 2024 11:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: cleanup linker scripts and sections
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Angelo Dureghello
 <angelo@kernel-space.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20240614065357.182446-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240614065357.182446-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FX0ccuS6Ju5pcv/iu0xmVosD6kOxF1tC9lnhBqhfAHlJzkm84Z7
 7x9ggPXaq/mk1dx/6JpWg4E2tehiL1KBLspaz8qRCi5Gv+C3zWLz4uk4Zk72cXEmGQLK9Y4
 SZQ7STHCADgXLbrk1ma1qE4uXNqBnyh9s/0oafp8gf0aOmBPFvO2+9kJU/16KIKkJ3kVE7d
 NHycQDog+vEFGzwecHV5g==
UI-OutboundReport: notjunk:1;M01:P0:4o0MTnbXbrw=;Etwy4jETfj2hD44cdOsPDJSlJoP
 tmd7lH9uAiXvejk6gAu4dGM4cIFZDBf92NiDUAXtAw8HIVoG2LWrP/9oeh5SaYlMk7p7vtryc
 Ev+h8AG7d75anpBmQ3+qkzzsnmrFxxX4dAA0SwR7XS9qTebps34PEeXa4Zc6ejWGDtFrVuhbR
 Nv2uGtXUO+tvLPSZ/fYPWvxy7KkZXZDkHptbm5gmIEUTrj7Ae80e7/MX6wkqO7OYXXfukt90H
 aWBWfxGViCLI9M4VzcIYfxizTPhwfj63vSdgl8Di0qFHlWr8BeO16fX6R07IOsxV5dhPO7kZ/
 oN+hznLtEwaAYJYf5TcEas8uBvMVlCrQyie9NqNKyyDnJUQa+7evmIsq5/TzNuvi+IA9AjSe4
 tOcZLL9rC4ZwrW3iOWgelmGE1Ow1HbrD2SDZWvnTQMs9v6wNBrpw7Y4lu+xsBPiKB3Yk6WBBl
 ZcUicxgOLLEXUAI3s1i0Pg18pUeA8KUu5Sc3VBAWb9o+yyRoevTpflsLOBMcW/mH5H3x3Hk54
 F7NRSV1oal73AZro5YfFTEUEA725yB+b/gQKsfToGxqLJYh0EO6v+OYxNODOfKi/S7OlNzJFI
 nUSXIVd7ea579+sTsJmOzzf6c5Xt7YxCJC6TYKQeZQmnfe7gz/VlCRBqRVP3Q/v4dUzkmrPjm
 X6d05PJghlZndN/LnEengvBSyULbyRkbuQo1XAhrMVFkkpYcs45UHk3HRFVX19xt4hld33tP9
 8/M2SP/V5bex7tPimgD/s/CfQegosID7cWXERSI6fnxso422xVJRpFTwmDJy4HTpULE+IcAWY
 w/4U9lem7DQAXPZc335xG5tpMnS8Ai6xDmeEUM010MuTw=
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

On 14.06.24 08:53, Ilias Apalodimas wrote:
> commit 6e2228fb052b ("Merge patch series "Clean up arm linker scripts"")
> was cleaning up linker scripts for armv7 and v8 in a similar fashion.
>
> Several commits in the past -- e.g
> commit d0b5d9da5de2 ("arm: make _end compiler-generated")
> was moving symbols to be compiler generated. They were defined as c
> variables in its own section to force the compiler emit relative a
> reference. However, defining those in the linker script will do the
> same thing since [0].
>
> So let's remove the special sections from the linker scripts, the
> variable definitions from sections.c, and define them as a symbols.
> It's worth noting that the linker was discarding the symbols in the
> older binary completely.
>
> - new binary
> $~ aarch64-linux-gnu-readelf -sW u-boot | grep efi_runtim
>     246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14 vbe_req_efi_=
runtime_rand
>    3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_=
mmio
>    6359: 00000000000dedff   217 FUNC    LOCAL  DEFAULT   14 efi_runtime_=
relocate
>    7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_=
services
>    8869: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtim=
e_rel_stop
>    9159: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtim=
e_stop
>    9410: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtim=
e_start
>   10137: 00000000005981bd     0 NOTYPE  WEAK   HIDDEN    33 efi_runtime.=
c.de5bed54
>   10470: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtim=
e_rel_start
>
> - old binary
> $~ aarch64-linux-gnu-readelf -sW u-boot.old | grep efi_runtim
>     246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14 vbe_req_efi_=
runtime_rand
>    3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_=
mmio
>    6359: 00000000000dedff   221 FUNC    LOCAL  DEFAULT   14 efi_runtime_=
relocate
>    7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_=
services
>   10135: 0000000000598320     0 NOTYPE  WEAK   HIDDEN    33 efi_runtime.=
c.de5bed54
>
> $~ bloat-o-meter u-bool.old u-boot
> add/remove: 0/0 grow/shrink: 1/1 up/down: 7/-4 (3)
> Function                                     old     new   delta
> efi_memory_init                              343     350      +7
> efi_runtime_relocate                         221     217      -4
> Total: Before=3D2009902, After=3D2009905, chg +0.00%
>
> [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic o=
nly for shared object")
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Tested with sandbox_defconfig on amd64, arm64, riscv64.

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   arch/sandbox/cpu/u-boot.lds | 20 ++++----------------
>   arch/sandbox/lib/Makefile   |  2 +-
>   arch/sandbox/lib/sections.c | 13 -------------
>   3 files changed, 5 insertions(+), 30 deletions(-)
>   delete mode 100644 arch/sandbox/lib/sections.c
>
> diff --git a/arch/sandbox/cpu/u-boot.lds b/arch/sandbox/cpu/u-boot.lds
> index 52f13af3742f..6ee8095b6cbb 100644
> --- a/arch/sandbox/cpu/u-boot.lds
> +++ b/arch/sandbox/cpu/u-boot.lds
> @@ -19,30 +19,18 @@ SECTIONS
>   		*(_u_boot_sandbox_getopt_end)
>   	}
>
> -	efi_runtime_start : {
> -		*(___efi_runtime_start)
> -	}
> -
>   	efi_runtime : {
> +                __efi_runtime_start =3D .;
>   		*(efi_runtime_text)
>   		*(efi_runtime_data)
> -	}
> -
> -	efi_runtime_stop : {
> -		*(___efi_runtime_stop)
> -	}
> -
> -	efi_runtime_rel_start : {
> -		*(___efi_runtime_rel_start)
> +                __efi_runtime_stop =3D .;
>   	}
>
>   	efi_runtime_rel : {
> +                __efi_runtime_rel_start =3D .;
>   		*(.relefi_runtime_text)
>   		*(.relefi_runtime_data)
> -	}
> -
> -	efi_runtime_rel_stop : {
> -		*(___efi_runtime_rel_stop)
> +                __efi_runtime_rel_stop =3D .;
>   	}
>
>   	.dynsym :
> diff --git a/arch/sandbox/lib/Makefile b/arch/sandbox/lib/Makefile
> index a2bc5a7ee60f..d7d15a50bb6c 100644
> --- a/arch/sandbox/lib/Makefile
> +++ b/arch/sandbox/lib/Makefile
> @@ -5,7 +5,7 @@
>   # (C) Copyright 2002-2006
>   # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>
> -obj-y	+=3D fdt_fixup.o interrupts.o sections.o
> +obj-y			+=3D fdt_fixup.o interrupts.o
>   obj-$(CONFIG_PCI)	+=3D pci_io.o
>   obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o
>   obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o
> diff --git a/arch/sandbox/lib/sections.c b/arch/sandbox/lib/sections.c
> deleted file mode 100644
> index 2f2f3fbfdb86..000000000000
> --- a/arch/sandbox/lib/sections.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright 2013 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - */
> -#include <linux/compiler.h>
> -
> -char __efi_runtime_start[0] __section("___efi_runtime_start");
> -char __efi_runtime_stop[0] __section("___efi_runtime_stop");
> -char __efi_runtime_rel_start[0]
> -		__section("___efi_runtime_rel_start");
> -char __efi_runtime_rel_stop[0]
> -		__section("___efi_runtime_rel_stop");
> --
> 2.45.1
>

