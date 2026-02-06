Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFD4ECD9B7
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 01:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355ED831AC;
	Fri,  6 Feb 2026 02:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G9Ho1IT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDF88341A; Fri,  6 Feb 2026 02:14:58 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F5E83015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 02:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d18dd2adf7so925351a34.1
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 17:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770340495; cv=none;
 d=google.com; s=arc-20240605;
 b=EO22+ZVpOApTtCJB+SXhluSmwBLURIhhcBaf6LwQ5E1hB1UHa63eVO+kV3vdaZIEZ7
 +rDEdd8/P+KAB/0e3qNlmH46pFBG7qI6cZMg3ru3c8xcJqiup6XOTJoXkBapGMJ8MB0N
 2DD1kynj2OKkH/IQCNNE8DpWJpqbtIlV0Sr4s8WdnjwWeHvOHx7uieZ15rDZyCPfwp/S
 vyNW1ig8ehhPJJ+oXfSkEJKzlXUFRkRd3F5Haawk1o5+l8gj5gLYRocyzm7aDV1F5ovi
 o9vW0JJeGbmaH7KhWWBB6XPtpVrRDLZIdZioeuNOCMQHetyIqit2wEM8Dql9wWkcloes
 r2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fV6lGOUduiLfGmPQlICRdrAKbw6+poYxfuwfS9xliW4=;
 fh=fpGPk3FsjJHSLyqLTkeucVDBk7jdaCS1cK83ZeTkj8c=;
 b=O4LrwyWIDOivsmt3J1FncfPqgcyI3c9LsPDWBnJDyKz5saWi2io4YRJ9a0NziwJfI6
 nepJfswqGMo2BMJ0Tmxg2inNXnAZaRK3Qk4GzzttGmK/u45UoUtCkH8GX86N2jcRsjSC
 xdPeroilhyZYS5VSZOXR0KvbOj7S2+eXGYjJk6mouazUpjZHCv0qmy6rv5AkbRlGxPcE
 XOcLB+CTMQr4cv9TM/+kPkPCMKilccmhf2vM3f+u+oaPCrFfArK7eB8WOZrSeiJJpX9i
 Sbl9YP5IXA+3+avyabA/FtSxtAy3qQG+C8vIIbmG/h8pMTuf1Jv8pWuVzOAWjww1Y85M
 HtwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770340495; x=1770945295; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fV6lGOUduiLfGmPQlICRdrAKbw6+poYxfuwfS9xliW4=;
 b=G9Ho1IT7PL9+n3t/1V8RAiirOFmd0Pjee8fv2WsD0jMlyTg2Pe0CubaJ7B5xGCAer7
 tJqkEanpvUhObQcA/tWF/LQTE6/QsSz/vvaUfrKJ99Mm4i6Z2aDLGlCDnO8FghpDnueC
 kxQRtU5oLMSaQpWKGMWdoJICXKs5mAF6/xNdYxHsFBoQNkLSerLmyrGhD/Cu74OGIczs
 6OVVEkL9HmzyqwJxSiui1vyYtZxWcWkjDzPK43tODnfqTzLwvh8uruCFvx4IDw9N4jGL
 wu7o6vMZl0NmKRBqIcgWJz1vljepdwHaf3PAa362rLJTGdACn7zetWQXrk7F5ywrTO3O
 oEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770340495; x=1770945295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fV6lGOUduiLfGmPQlICRdrAKbw6+poYxfuwfS9xliW4=;
 b=kDJeBZ2Z4u+KwsniHsjDdv4R2FutC8m0xmBlDVWfZXCBny72qSEHLxJhA3Pwmz7Gyi
 ifskA1ylaxYFB0+3q+SGZblI79Q5XLEIgzOxgC1cdg2OsWx3Acm6g6kbgO46EfLtNWrN
 om/599ZBVJ8qzKVb07Fn6z1U10+LWVONyDT/3KnIBaVBsb8ID+T5j901L7K9BB8kO4qZ
 tbGCHCY2TPvosgCqnuayjJk9mGpZWmJ5DVOt354nEcmitfU6dZmcBdSqe5mms6AXYvnl
 +N3GkTk1wszR+29HYnUb+gcARXK/60gfSFDQZ/qa9zaBujXHZY5/mnQc70+URuakxmjj
 s8OA==
X-Gm-Message-State: AOJu0YwMbQDdkAb5NQTzS99c/s5RYX3839/8GlMGggY48/8oNKc+zsW9
 5K8rje+REODfEiQ0T8DnsqiIy00xODG+8KtzW6xtQEJfvrEdcfpqXp/X4IysE5ejPGoXVsN0gQd
 mZ8SkgjxZ602+3jamn/ioutt05oDd7ys=
X-Gm-Gg: AZuq6aIJPY/uuSHXbifdrI3BkCBjQnqiYvwmFPkzQJR68UEp7xCV1jKBXHS0JS2nVMQ
 bAlmi09m7S1eKN+9aSsbNXaLHuWkMcCIU3zIKiVsJrm7SG1DlKuELtRkdR1SZdXb2I293FirLLP
 oxr+LTNByZYqPXsdFGPCFhen57d2tf16MZnt0jZDm0PwQUjZ3PcRfqFMhC72HK+XN9CYM8Df4Rl
 IZpcAkidLvSjXWg9baQxGoW3mCd8VNmgl2g5RZNYoCL8/RLETMo2DBxEGr92o4g6VUCzQjA
X-Received: by 2002:a05:6830:6188:b0:7cf:d1eb:f37a with SMTP id
 46e09a7af769-7d4644892e1mr581194a34.18.1770340495071; Thu, 05 Feb 2026
 17:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20260130183635.2612933-1-trini@konsulko.com>
 <20260205234158.3768337-1-trini@konsulko.com>
In-Reply-To: <20260205234158.3768337-1-trini@konsulko.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 6 Feb 2026 09:14:44 +0800
X-Gm-Features: AZwV_QjMROHZz_5nmNwViXmhAuA5cltwz-qw5UONYRQY2cEDr7IdvreCGVdkJa0
Message-ID: <CAN7C2SCUe39myS9hGhQsdzJn7iB=qvtLX2_3P_jMbJchX3aYzg@mail.gmail.com>
Subject: Re: [PATCH v2] arm: spl: Ensure 8 byte alignment of appended DTB
 without separate BSS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Phil Phil Sutter <phil@nwl.cc>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 6, 2026 at 7:42=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> Historically, when we have an appended device tree and also our
> resulting binary will contain the BSS section, we have ensured that
> everything will be where it's expected to be by declaring that the BSS
> is overlayed with a symbol matches the end of the port of the ELF binary
> that is objcopy'd to the binary we concatenate with. This in turn means
> that the logic to generate a "pad" file, which is the size found in the
> __bss_size symbol, will be correct and then we can concatenate the
> device tree and it will begin at __bss_size at run time.
>
> With commit 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
> we removed this overlay as part of trying to ensure that we met both the
> requirements of the device tree to be 8 byte aligned as well as that our
> logic to generate the -pad file would match what ended up in the
> resulting binary. While it was correct to remove an unused section it
> did not solve ultimately solve the problem for all cases.
>
> To really fix the problem, we need to do two things. First, our final
> section prior to _image_binary_end must be 8 byte aligned (for the case
> of having a separate BSS and so our appended DTB exists at this
> location). This cannot be '.binman_sym_table' as it may be empty, and in
> turn the ELF type would be NOBITS and so not copied with objcopy. The
> __u_boot_list section will never be empty, so it is our final section,
> and ends with a '. =3D ALIGN(8)' statement. Second, as this is the end of
> our copied data it is safe to declare that the BSS starts here, so use
> the OVERLAY keyword to place the BSS here.
>
> Fixes: 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
> Reported-by: Brian Sune <briansune@gmail.com>
> Reported-by: Phil Phil Sutter <phil@nwl.cc>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Cc: Greg Malysa <malysagreg@gmail.com>
> Cc: Ian Roberts <ian.roberts@timesys.com>
> Cc: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Cc: Utsav Agarwal <utsav.agarwal@analog.com>
> Cc: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Cc: adsp-linux@analog.com
>
> So, first, with the exception of:
> axm brppt2 imx28_btt3 imx28_xea mk808 taurus work_92105
> all platforms using arch/arm/cpu/u-boot-spl.lds do NOT enable
> CONFIG_SPL_SEPARATE_BSS. And of those, only brppt2 enables SPL_OF_REAL.
> As an aside, I'm thinking that there is room for a clean-up / merger of
> arch/arm/cpu/u-boot-spl.lds and arch/arm/mach-omap2/u-boot-spl.lds
> (*widely* used outside of mach-omap2). But for this patch, that one case
> is handled correctly, with the first change I explained. All other 32bit
> platforms are handled with the second.
>
> Which means second, 64bit ARM platforms. With the exception of:
> socfpga_agilex7m socfpga_n5x_atf socfpga_n5x_vab socfpga_stratix10_atf
> all ARM64 SPL_FRAMEWORK using platforms use the
> arch/arm/cpu/armv8/u-boot-spl.lds explicitly. These other ones set
> CONFIG_SPL_LDSCRIPT to a non-existant file and then fall back to using
> arch/arm/cpu/armv8/u-boot-spl.lds. There are only 4 platforms which
> don't use a separate BSS section and so could trip up the above as well:
> r8a779g0_whitehawk r8a779g3_sparrowhawk sc598-som-ezkit-spl sc598-som-ezl=
ite-spl
> I have inspected the Renesas platforms manually, and I'm a little unsure
> how this case works on the two sc598 platforms.
> ---
>  arch/arm/cpu/armv8/u-boot-spl.lds | 15 ++++++++-------
>  arch/arm/cpu/u-boot-spl.lds       | 12 ++++++------
>  2 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boo=
t-spl.lds
> index b732133ce76d..39020a1fddde 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -49,12 +49,6 @@ SECTIONS
>         } >.sram
>  #endif
>
> -       __u_boot_list : {
> -               . =3D ALIGN(8);
> -               KEEP(*(SORT(__u_boot_list*)));
> -               . =3D ALIGN(8);
> -       } >.sram
> -
>         .binman_sym_table : {
>                 . =3D ALIGN(8);
>                 __binman_sym_start =3D .;
> @@ -63,6 +57,12 @@ SECTIONS
>                 . =3D ALIGN(8);
>         } > .sram
>
> +       __u_boot_list : {
> +               . =3D ALIGN(8);
> +               KEEP(*(SORT(__u_boot_list*)));
> +               . =3D ALIGN(8);
> +       } >.sram
> +
>         __image_copy_end =3D .;
>         _end =3D .;
>         _image_binary_end =3D .;
> @@ -75,7 +75,7 @@ SECTIONS
>                 __bss_end =3D .;
>         } >.sdram
>  #else
> -       .bss (NOLOAD) : {
> +       .bss _image_binary_end (OVERLAY) : {
>                 __bss_start =3D .;
>                 *(.bss*)
>                  . =3D ALIGN(8);
> @@ -99,5 +99,6 @@ SECTIONS
>
>  ASSERT(_image_binary_end % 8 =3D=3D 0, \
>         "_image_binary_end must be 8-byte aligned for device tree");
> +
>  ASSERT(ADDR(.bss) % 8 =3D=3D 0, \
>         ".bss must be 8-byte aligned");


For ARM v7 on SoCFPGA GEN5 no issue under AC501:

Tested-by: Brian Sune <briansune@gmail.com>

Boot Message as follows:

U-Boot SPL 2026.04-rc1-00154-gb5213bbfdcb1-dirty (Feb 06 2026 - 09:11:02 +0=
800)


U-Boot 2026.04-rc1-00154-gb5213bbfdcb1-dirty (Feb 06 2026 - 09:11:02 +0800)

CPU:   Altera SoCFPGA Platform
FPGA:  Altera Cyclone V, SE/A2 or SX/C2, version 0x0
BOOT:  SD/MMC Internal Transceiver (3.0V)
DRAM:  1 GiB
Core:  29 devices, 15 uclasses, devicetree: separate
MMC:   dwmmc0@ff704000: 0
Loading Environment from MMC... Card did not respond to voltage select! : -=
110
*** Warning - No block device, using default environment

In:    serial
Out:   serial
Err:   serial
Model: CoreCourse AC501SoC
Net:
Warning: ethernet@ff702000 (eth0) using random MAC address - 36:e3:3d:93:85=
:a5
eth0: ethernet@ff702000
Hit any key to stop autoboot: 0


> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index c578c3ebf821..97083319d39d 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -31,16 +31,16 @@ SECTIONS
>                 *(.data*)
>         }
>
> -       . =3D ALIGN(4);
> -       __u_boot_list : {
> -               KEEP(*(SORT(__u_boot_list*)));
> -       }
> -
>         . =3D ALIGN(4);
>         .binman_sym_table : {
>                 __binman_sym_start =3D .;
>                 KEEP(*(SORT(.binman_sym*)));
>                 __binman_sym_end =3D .;
> +       }
> +
> +       . =3D ALIGN(4);
> +       __u_boot_list : {
> +               KEEP(*(SORT(__u_boot_list*)));
>                 . =3D ALIGN(8);
>         }
>
> @@ -48,7 +48,7 @@ SECTIONS
>         _image_binary_end =3D .;
>         _end =3D .;
>
> -       .bss : {
> +       .bss _image_binary_end (OVERLAY) : {
>                 __bss_start =3D .;
>                 *(.bss*)
>                  . =3D ALIGN(8);
> --
> 2.43.0
>
