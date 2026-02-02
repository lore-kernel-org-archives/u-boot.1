Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E5E7DF11
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 17:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C474683F2D;
	Mon,  2 Feb 2026 18:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cITg0ySD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A768683F2E; Mon,  2 Feb 2026 18:42:36 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D28E83EC8
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 18:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so4059838a34.3
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 09:42:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770054153; cv=none;
 d=google.com; s=arc-20240605;
 b=T5h/EDc89hKSO1FRedJLmG/A3tqjNUZyMwfjK4iGtCWB5vdxCPEATG4e7msShuCkgv
 eg+TIVqREbBCMLXISAIRdLCsl0ihqviHwKmwwcASn2Ck1IcCgxtpeL28YGS27l+6J3hw
 be0f/1YFGRhBUGBvSSRjBJwn1yxU/HdQi07QLbR7Et1iOY0QI83Ber5KJ5djJ/USmeqL
 QKSr/JZlDNij55c1mv1whUpfN4TStJ/T8UbvrobpExXLDdzPwZ5zAMBu4MRdUs7iBrTr
 JciEuQdTtoFhBSW2A4SntZcZGegAEZr0dUv05bcoLmAuhSaukJdQEpp/cV8cXdIMo4L4
 YmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FrT3DyTSVhBoJA+7jdx8M1KqqZx1PSNAi5SykXOiEBE=;
 fh=SocK4OiObrDE01rf4A/mD/sAU8tp2xGapfK+9vDyWYA=;
 b=In0vJAoVol/ly97/j29BYb+9nc5N7j7DC0xhSh+YG7TZApCerf953WvvIsop+4yuid
 T8CHFLH+xe1kV1vpuo/mFP9mBfHN8bRAW9aJTWB+TfYIobAMPQybAKCXWS/ZgZJtYeqW
 334K9yhCcBBwMH14An7MFFnVgeAdIjIjMYRzr0JXYjhrnut3RiS8hFiktiErZiOKMG66
 Ck4TOuiJZaeSV/3w6RPb9O8GomHoSJRltvc6XE2lxsV9wZnc3YYKjnaFGV7PxGaKFvZx
 A9VI8JeUibKp4isk0nf6H1aPpX8yJMNkDCnU29gjNbM3HNj1Q+aZFkRKFM0Zb2gFIOaP
 0upA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770054153; x=1770658953; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrT3DyTSVhBoJA+7jdx8M1KqqZx1PSNAi5SykXOiEBE=;
 b=cITg0ySDO2LuwCqeoYLc6qy30V/vsvHPsZkUSUaDQL/mQaHFUZLgFA3lf94Rbnf0bg
 8JbIG97QaMwBaMSIJQoxEiDe0FqnlqjrR/6xLb7oStbGWSRhdxzJ+FuaDOtsH8QhI9Qa
 DCutWoLqEdq/9jNaJGYHsllnFNgCwIRJrjvtu3tTL6d+GNB39Guso/HwZZ1IZIhNZgQr
 MFm53t2u1eQUO/j5wsOfdhmbd5LnkE7/KdpnBfUGET+vK43K/YnICHA7MsGKtuBLEJpS
 STFWgyhz9vY9FzYbizZIvU8FdgrV+FwrF38/wCYY7qpfIZTQ1wfsOxP1RporJQk9+PTP
 8vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054153; x=1770658953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FrT3DyTSVhBoJA+7jdx8M1KqqZx1PSNAi5SykXOiEBE=;
 b=mCL+vcDc32RJ8Z7fTnGYKkSt9CcrHaAWtxT/9/U8aTLyydkuT9wJe3iCIfN0fUktcR
 s2U0jxX1biDjXwo34Av2SruWYzZDxn8gY2HVtDfuilmJY26zYRC54m8NEJa2vb4IF+c+
 qAzzFzz2/0bdp95kSNt+czgGk3XuZ4vFSbpT9+o6+svapvH/5G4YTue3Fgwjnijnoy01
 aFuWb+pcmQ/Td1S4Osy7Rp2MbN8NVrDuuTdXh7iZAUeGPWYkooqNCMlbTumsk4NKrqhC
 wZ6cX4fQBDMwgpM4VEZz/BQ0faqFdUy49u/YHvIjyUNhmFTO7KWedWeV62WDdn1ZvfdC
 FVZg==
X-Gm-Message-State: AOJu0YzuVCBviRYvAOQWrdJgwBjAdOM2WAqoMbgbKbynpN7uFE/gAkHn
 gowLcCCzd+e3n/uSMN+pOH1nE74s3HlZjpiE2dWYic0Jx+O5BjczX1MGPGyVC594Myjih+GIl34
 thdX09GiX85qF+3fRKrumWQO3LBXQ7r+0WCFN4Q2wGA==
X-Gm-Gg: AZuq6aIKNZJjEGl8k/NFtHhBwei7apDGvg5ldyIfNY8R9HQdKUFsA9Ot+3ugZRw/Xaw
 myl4Zb/MpDHzf2Tnx2GJ4TLVQeSoJzwnHa9GjG1ejR8DUuWwGBhDNMeaTkXJZlj1dIQRbGt/toK
 KvPcG0be6oMNkPBQlXNiDp/YI9PLj7yjrpoA28mNkA21cTu98TUT3TdW8VRmSj1CFjURoby0qRL
 2RcwQkfpnvWbmhhkBqkPDAm7yY+tM6IRGHKpje3+0prkUtX9EzHQ8SansDIWNOvB6A5XzsstYlU
 4DycDQ==
X-Received: by 2002:a05:6830:4992:b0:7cf:d201:c32d with SMTP id
 46e09a7af769-7d1a5233613mr7199460a34.3.1770054152863; Mon, 02 Feb 2026
 09:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20260130183635.2612933-1-trini@konsulko.com>
In-Reply-To: <20260130183635.2612933-1-trini@konsulko.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 3 Feb 2026 01:42:21 +0800
X-Gm-Features: AZwV_QiZcz8YGwl9eHT1-orxvBgHQW_ZiTyhQ8QAzVRZ-fubn62q5Qrpa4McHUk
Message-ID: <CAN7C2SD5=Fg2ATWz7YmC-BxLOVC6L8KTmYL_tSYxyoA=HaYXHg@mail.gmail.com>
Subject: Re: [PATCH] spl: Ensure final section before BSS is non-empty
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sat, Jan 31, 2026 at 2:36=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> As part of ensuring that we make a binary image to append our device
> tree to and that it will have an 8 byte alignment, one problem was
> overlooked. That problem is what happens when we have a section that
> only contains ALIGN statements and linker references, but nothing else.
> What happens in this case is that we will have a section in the
> resulting ELF that has is of the NOBITS type. This in turn means that
> when we use objcopy to turn the ELF in to a binary for further
> processing, it won't copy anything. This then becomes a problem when we
> do not have a separate BSS and instead append a "padding" file to act as
> the BSS, and then append our device tree to that. The solution here is
> to ensure that the final section in our SPL image is something that will
> always exist with contents, in this case __u_boot_list.
>
> Fixes: 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
> Fixes: f150843499b3 ("riscv: Update linker scripts to ensure appended dev=
ice tree is aligned")
> Reported-by: Brian Sune <briansune@gmail.com>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Ilias, if there's anyone else you can get to look at this which
> understands linker scripts better please do. I think I finally see *how*
> things go wrong in some cases but I'm less confident in my explanation
> above. Thanks.
>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/u-boot-spl.lds           | 12 ++++++------
>  arch/arm/cpu/u-boot-spl.lds                 | 10 +++++-----
>  arch/arm/mach-aspeed/ast2600/u-boot-spl.lds | 10 +++++-----
>  arch/riscv/cpu/u-boot-spl.lds               | 11 +++++------
>  4 files changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boo=
t-spl.lds
> index b732133ce76d..29252d870f91 100644
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
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index c578c3ebf821..5f807323f856 100644
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

For ARM v7 on SoCFPGA GEN5 Cyclone V boards:
AC550
AC501

Tested-by: Brian Sune <briansune@gmail.com>

>
> diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-=
aspeed/ast2600/u-boot-spl.lds
> index 303ace2f61ca..260a0a79dd0a 100644
> --- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> +++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> @@ -39,16 +39,16 @@ SECTIONS
>                 *(.data*)
>         } > .nor
>
> -       . =3D ALIGN(4);
> -       __u_boot_list : {
> -               KEEP(*(SORT(__u_boot_list*)));
> -       } > .nor
> -
>         . =3D ALIGN(4);
>         .binman_sym_table : {
>                 __binman_sym_start =3D .;
>                 KEEP(*(SORT(.binman_sym*)));
>                 __binman_sym_end =3D .;
> +       } > .nor
> +
> +       . =3D ALIGN(4);
> +       __u_boot_list : {
> +               KEEP(*(SORT(__u_boot_list*)));
>                 . =3D ALIGN(8);
>         } > .nor
>
> diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.ld=
s
> index 35de28db8f3a..5a65e6653f25 100644
> --- a/arch/riscv/cpu/u-boot-spl.lds
> +++ b/arch/riscv/cpu/u-boot-spl.lds
> @@ -31,18 +31,17 @@ SECTIONS
>         .data : {
>                 *(.data*)
>         } > .spl_mem
> -       . =3D ALIGN(4);
> -
> -       __u_boot_list : {
> -               KEEP(*(SORT(__u_boot_list*)));
> -       } > .spl_mem
>
>         . =3D ALIGN(4);
> -
>         .binman_sym_table : {
>                 __binman_sym_start =3D .;
>                 KEEP(*(SORT(.binman_sym*)));
>                 __binman_sym_end =3D .;
> +       } > .spl_mem
> +
> +       . =3D ALIGN(4);
> +       __u_boot_list : {
> +               KEEP(*(SORT(__u_boot_list*)));
>                 . =3D ALIGN(8);
>         } > .spl_mem
>
> --
> 2.43.0
>
