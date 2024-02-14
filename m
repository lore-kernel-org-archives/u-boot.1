Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03094C48BC4
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 11:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF7087DEC;
	Wed, 14 Feb 2024 12:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="RgBrq6Oo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3756E87DF9; Wed, 14 Feb 2024 12:16:07 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCDA987DE6
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dcc7cdb3a98so1874973276.2
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1707909358; x=1708514158;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WULajc2RgFy56p26opL14oOcnFP4UnUu0ivHMw8L1NU=;
 b=RgBrq6OoStV8OTSoAsvWcF9Bs7GlM5Iq5X5jL5iCzUADq1uNJnrIe3YeWGSbTxTS7C
 fmclNfy9GWr2ccCX3tzJh+FxnUtTogSNnyPmhxYAWFk5qQHXx2RDhOVaWm62BUINFFku
 gksK+Vw9ukHLj/0iWwffuLQczSkBDzkOXU6yDBRv3vwU2liMCtQzNyS4ZU9UHBDuf6HN
 o3bLLz0ByJmyorefrZp96vqN8l7sCFiK/kDVozNPSiy1sgP5INhOQDKS1Qn4l9ywJ3ui
 2x5fc8WwITqelQpb/FSwk97A2trsb/eK8v5aAO/894dS5nV09nJc63CUY7oGp+yWsCak
 pZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909358; x=1708514158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WULajc2RgFy56p26opL14oOcnFP4UnUu0ivHMw8L1NU=;
 b=hfur2m20vSe3IuxbXpCca4yJA8Rso/t758mzEbuEkSih6ziENz//ZbHrk8m+HLB+/j
 WWvmtoQCpiWamVW5Vzy8aG+Ad/65YbPqRFojniVvBKOP3WHItYq4F4zQSYOyvOsUuZq4
 KVnpQXrUSKqjVJP1lvHqBB7+Tbi+S+6dBR1bkVQooOXDBglOFL0rPKG68LfK/J7jCDWo
 U0p/M+XOiAAkElHDGuGWrIAv4E3Jcl+ZGW8iSV57lz6gNos9cSuHUELYW7ggJRt2jEaE
 8tX68x6jk40gOSz9qj73EOlDKzzSgiGq72FVfCed4g+/rCgn71Dt5m0Yq02xGBhp/OMM
 Nozw==
X-Gm-Message-State: AOJu0YwVojyNvTbUnxf1Rj7iUMAoE+U03b3hXqhhWsrmemIOxXAApMkL
 I4w69JkZCSK0L07Tj8qWfOIBsemy2FvenKFjRDT79Wfuv2YTP6aRjuNGvBqVSohrDSL2ERslxYa
 yeWYhQ8w1W3sMxDcKDhnrHqzBs42HlvyB7t6q
X-Google-Smtp-Source: AGHT+IHGGbYfhVgGCCUFosjBTmMvQ4N+RbB8vqjnVpIqnLnFGGfhmyTn08aRjhOX7xF+lxnQcMDg5FzSTMf4cKXzndU=
X-Received: by 2002:a25:2708:0:b0:dcd:c3ba:d788 with SMTP id
 n8-20020a252708000000b00dcdc3bad788mr37540ybn.47.1707909358393; Wed, 14 Feb
 2024 03:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20230413062008.981238-1-bmeng@tinylab.org>
 <20230413062008.981238-9-bmeng@tinylab.org>
In-Reply-To: <20230413062008.981238-9-bmeng@tinylab.org>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 14 Feb 2024 12:15:47 +0100
Message-ID: <CAHTX3dKP2guG2=4MM_WgMH4NRU5yH281GLgAXHfnDLHLg4jKBA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] riscv: Update alignment for some sections in
 linker scripts
To: Bin Meng <bmeng@tinylab.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Scull <ascull@google.com>,
 Leo <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Bin,

=C4=8Dt 13. 4. 2023 v 8:21 odes=C3=ADlatel Bin Meng <bmeng@tinylab.org> nap=
sal:

> Some sections in the linker scripts are aligned to 4 bytes, which
> may cause misaligned exception on some platforms, e.g.: clearing
> the bss section on 64-bit hardware if __bss_start does not start
> from a naturally 8 bytes aligned address.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>
> ---
>
> (no changes since v1)
>
>  arch/riscv/cpu/u-boot-spl.lds | 2 +-
>  arch/riscv/cpu/u-boot.lds     | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.ld=
s
> index c3b4907905..d1113a59aa 100644
> --- a/arch/riscv/cpu/u-boot-spl.lds
> +++ b/arch/riscv/cpu/u-boot-spl.lds
> @@ -44,7 +44,7 @@ SECTIONS
>                 __binman_sym_end =3D .;
>         } > .spl_mem
>
> -       . =3D ALIGN(4);
> +       . =3D ALIGN(8);
>
>         _end =3D .;
>         _image_binary_end =3D .;
> diff --git a/arch/riscv/cpu/u-boot.lds b/arch/riscv/cpu/u-boot.lds
> index 1c937aebee..15b5cbc585 100644
> --- a/arch/riscv/cpu/u-boot.lds
> +++ b/arch/riscv/cpu/u-boot.lds
> @@ -57,7 +57,7 @@ SECTIONS
>                 __efi_runtime_rel_stop =3D .;
>         }
>
> -       . =3D ALIGN(4);
> +       . =3D ALIGN(8);
>
>         /DISCARD/ : { *(.rela.plt*) }
>         .rela.dyn : {
> @@ -66,7 +66,7 @@ SECTIONS
>                 __rel_dyn_end =3D .;
>         }
>
> -       . =3D ALIGN(4);
> +       . =3D ALIGN(8);
>
>         .dynsym : {
>                 __dyn_sym_start =3D .;
> @@ -74,7 +74,7 @@ SECTIONS
>                 __dyn_sym_end =3D .;
>         }
>
> -       . =3D ALIGN(4);
> +       . =3D ALIGN(8);
>
>         _end =3D .;
>

This change has actually a side effect on SPL and its behavior. You are
enforcing here that symbols _end
or _image_binary_end are 8byte aligned but if previous section are only 4
bytes aligned you are forcing 4byte gap
between the end of u-boot-nodtb.bin binary and symbol reference.
It means when you want to attach dtb behind SPL you have a problem.
DTBs should be 64bit aligned. It means alignment of 8bytes is fine but you
need to also make sure that
spl/u-boot-nodtb.bin is 8byte aligned.

Pretty much talking about change like below but it would require to change
all u-boot-spl.lds to make sure that end symbols are
8byte aligned that appended DTB is 8byte aligned all the time.

Thanks,
Michal

diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index 407fc52376a5..486360f10176 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -320,7 +320,7 @@ endif
 endif

 ifneq ($(build_dtb),)
-$(obj)/$(SPL_BIN)-dtb.bin: $(obj)/$(SPL_BIN)-nodtb.bin \
+$(obj)/$(SPL_BIN)-dtb.bin: $(obj)/$(SPL_BIN)-nodtb-align.bin \
                $(if
$(CONFIG_$(SPL_TPL_)SEPARATE_BSS),,$(obj)/$(SPL_BIN)-pad.bin) \
                $(FINAL_DTB_CONTAINER)  FORCE
        $(call if_changed,cat)
@@ -328,7 +328,7 @@ $(obj)/$(SPL_BIN)-dtb.bin: $(obj)/$(SPL_BIN)-nodtb.bin =
\
 $(obj)/$(SPL_BIN).bin: $(obj)/$(SPL_BIN)-dtb.bin FORCE
        $(call if_changed,copy)
 else
-$(obj)/$(SPL_BIN).bin: $(obj)/$(SPL_BIN)-nodtb.bin FORCE
+$(obj)/$(SPL_BIN).bin: $(obj)/$(SPL_BIN)-nodtb-align.bin FORCE
        $(call if_changed,copy)
 endif

@@ -390,6 +390,9 @@ OBJCOPYFLAGS_$(SPL_BIN)-nodtb.bin =3D $(SPL_OBJCFLAGS) =
-O
binary \
 $(obj)/$(SPL_BIN)-nodtb.bin: $(obj)/$(SPL_BIN) FORCE
        $(call if_changed,objcopy)

+$(obj)/$(SPL_BIN)-nodtb-align.bin: $(obj)/$(SPL_BIN)-nodtb.bin
+       @dd if=3D$< of=3D$@ conv=3Dblock,sync bs=3D8 2>/dev/null;
+
 OBJCOPYFLAGS_u-boot-x86-start16-spl.bin :=3D -O binary -j .start16
 $(obj)/u-boot-x86-start16-spl.bin: $(obj)/u-boot-spl FORCE
        $(call if_changed,objcopy)

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
