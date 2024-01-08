Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D956C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 23:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8344187775;
	Tue,  9 Jan 2024 00:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYKOD3EQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64941877F1; Tue,  9 Jan 2024 00:54:11 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE918774E
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 00:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sigmaris@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cc9fa5e8e1so27264031fa.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 15:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704758048; x=1705362848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i9v7ns2acAAoCfC401fYRYaPeF4AC6LMXkPKouji6Nw=;
 b=ZYKOD3EQba3TBPJ3nbvNqHjiY11kKqJdbf8Y/tAGD02sw29yNyh8CGhIlZFywcVHbq
 EPmUHmUqLrWiOmNtTSSTSry2m0GcnWitIhTHMTr6s2iHIvu5GZAf9zpLnDrRz2IsEgOu
 28fm6rG4BTqzt8GPg1a5/5BWMdL0kStc5ePABggE3zXvK5gwXD0wKIWL8uZquw9/NZDB
 TOMH9FFw0RtmXaycUQqx9M3DhA9I5SzoNW6A9GmC8ggeUcOiqqkFIKc+EY7HWYy5iTAp
 o77GkJKj0sanQMAKy1MwB8aHViFPVhr/r11spgKf7aDb1jvAaI5XTTbUaeIRbtm21ZZ5
 q0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704758048; x=1705362848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9v7ns2acAAoCfC401fYRYaPeF4AC6LMXkPKouji6Nw=;
 b=ZsHTYdFaHgfD7S1PhXt1lop2jDbB0i7pVwPl2muFSPPubRBv+n4IW+oBqFIxuEyC68
 DtF4V9VN5uf8SciJBPB7haFe5vNA9Progh73j+VFl6mjCy4NCZqqJuEEEnJ83PFD3qu/
 oiyrvtvZX0IEZbnR3LoqnEQGBAeSd0g1P6JLeO6A9sKZvbRjQG+o76I0hmTS3KdYj2I9
 GTu7AOaVQugvYUAj/FaXnjaYBTqIZkU12T1DlbSamEvUPU0YzqbozVFCgP5XtsFBL6b0
 dG0zGQKTWQ25l4wzUTxAPoknnkhVEftY9ASYUQdsCWzyv4xbm55etxA3HIZwz+vsWtxE
 GhVQ==
X-Gm-Message-State: AOJu0Yz0Y21qqcaRO5ibcR2b32a2MfbsC9yNbf5qpXG6AqF53Zx4E49i
 Wbmk/nna+0wVEdDx5KHJ3ShBOXuk6SmoA320q8s=
X-Google-Smtp-Source: AGHT+IE3jY8UXTOaDzA571k3rE8Vub5eoKGIEivpl5zgUcX4p0vHDazPnX5lOZdIMkbELEgyd5OQbAKyiiCiIfVmHY8=
X-Received: by 2002:ac2:5b52:0:b0:50e:7f9e:7c4a with SMTP id
 i18-20020ac25b52000000b0050e7f9e7c4amr1622231lfp.117.1704758048237; Mon, 08
 Jan 2024 15:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20231226164330.63725-1-sigmaris@gmail.com>
 <c52fb0c8-411f-4f97-8998-913e4da79d2b@kwiboo.se>
In-Reply-To: <c52fb0c8-411f-4f97-8998-913e4da79d2b@kwiboo.se>
From: Hugh Cole-Baker <sigmaris@gmail.com>
Date: Mon, 8 Jan 2024 23:53:57 +0000
Message-ID: <CAAXNxMT3SSu-3oth9qL+N-nCcxzZR+b0a0CbYzZP5bOqzdDV5Q@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: rk35xx: expand space for decompressed kernel
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On Sun, 7 Jan 2024 at 17:35, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Hugh,
>
> On 2023-12-26 17:43, Hugh Cole-Baker wrote:
> > An uncompressed 6.7.0-rc1 Linux kernel Image built with the arm64
> > defconfig is about 40MB. This does not fit in to the space between
> > kernel_comp_addr_r and fdt_addr_r, so when uncompressing an Image.gz
> > to this size, the FDT will be overwritten. Rearrange addresses to have
> > 128MiB for the kernel and its decompression buffer, then devicetree,
> > overlay and ramdisk at the end.
> >
> > Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
> > ---
> > Changes from v1:
> > Reorder things to have to have 128MiB for kernel and decompression space,
> > then devicetree, overlays and ramdisk.
> > Update kernel_comp_size to 128MiB.
> >
> >  include/configs/rk3568_common.h | 12 ++++++------
> >  include/configs/rk3588_common.h | 12 ++++++------
> >  2 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
> > index 1b7d3437b1..48f93083de 100644
> > --- a/include/configs/rk3568_common.h
> > +++ b/include/configs/rk3568_common.h
> > @@ -20,12 +20,12 @@
> >       "script_offset_f=0xffe000\0"    \
> >       "script_size_f=0x2000\0"        \
> >       "pxefile_addr_r=0x00e00000\0"   \
> > -     "fdt_addr_r=0x0a100000\0"       \
> > -     "fdtoverlay_addr_r=0x02000000\0"        \
> > -     "kernel_addr_r=0x02080000\0"    \
> > -     "ramdisk_addr_r=0x0a200000\0"   \
> > -     "kernel_comp_addr_r=0x08000000\0"       \
> > -     "kernel_comp_size=0x2000000\0"
> > +     "kernel_addr_r=0x02000000\0"    \
> > +     "kernel_comp_addr_r=0x0a000000\0"       \
> > +     "fdt_addr_r=0x12000000\0"       \
> > +     "fdtoverlay_addr_r=0x12100000\0"        \
> > +     "ramdisk_addr_r=0x12180000\0"   \
> > +     "kernel_comp_size=0x8000000\0"
>
> This (and the prior) memory layout extend over the possible memory
> region that OPTEE may use, 32 MiB at 132 MiB offset.
>
> The following regions is typically reserved for TF-A and OPTEE:
>
> 0x00000000 - 0x00200000 - reserved for TF-A, pstore, shmem, etc (0-2 MiB)
> 0x08400000 - 0x0a400000 - reserved for OPTEE (132-164 MiB)

Thanks, I wasn't aware of this reserved memory. Out of curiosity, is it
documented anywhere more about this & how to use OPTEE on RK3588?
I'd like to try it out, I tried to simply include it in a U-Boot build via
"export TEE=rk3588_bl32_v1.13.bin" but binman expects the given file to be
an ELF.

>
> Following offsets are used by U-Boot on rockchip rk35xx:
>
> @0       - U-Boot SPL
> @40000   - TF-A (@256 KiB)
> @a00000  - U-Boot proper (@10 MiB)
> @c00000  - scriptaddr (@12 MiB)
> @c00800  - loadaddr (@12 MiB + 2 KiB)
> @e00000  - pxefile_addr_r (@14 MiB)
> @8400000 - optional OPTEE (@132 MiB)
>
> May I suggest a memory layout similar to the following be used:
>
> @1800000  - fdtoverlay_addr_r (@24 MiB)
> @1c00000  - fdt_addr_r (@28 MiB)
> @2000000  - kernel_addr_r (@32 MiB)
> @a800000  - kernel_comp_addr_r (@168 MiB) // could also be a400000 (@164 MiB)
> @12c00000 - ramdisk_addr_r (@300 MiB) // kernel_comp_addr_r + kernel_comp_size
> and kernel_comp_size = 0x8000000 (128 MiB)
>
> With that it should allow for a 100-136 MiB kernel starting at @32 MiB,
> depending on if memory is reserved for OPTEE or not. It also leave 4 MiB
> for FDT and FDT overlay in memory just before the kernel. And finally do
> not overlap kernel_comp_addr_r with possible OPTEE memory.
>
> If we need more space then 2 MiB for U-Boot proper we should also
> revise the offsets used for loadaddr, scriptaddr and pxefile_addr_r.
>
> Regards,
> Jonas
>
> >
> >  #define CFG_EXTRA_ENV_SETTINGS               \
> >       ENV_MEM_LAYOUT_SETTINGS                 \
> > diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> > index 46389d087d..70430612ef 100644
> > --- a/include/configs/rk3588_common.h
> > +++ b/include/configs/rk3588_common.h
> > @@ -19,12 +19,12 @@
> >       "script_offset_f=0xffe000\0"    \
> >       "script_size_f=0x2000\0"        \
> >       "pxefile_addr_r=0x00e00000\0"   \
> > -     "fdt_addr_r=0x0a100000\0"       \
> > -     "fdtoverlay_addr_r=0x02000000\0"        \
> > -     "kernel_addr_r=0x02080000\0"    \
> > -     "ramdisk_addr_r=0x0a200000\0"   \
> > -     "kernel_comp_addr_r=0x08000000\0"       \
> > -     "kernel_comp_size=0x2000000\0"
> > +     "kernel_addr_r=0x02000000\0"    \
> > +     "kernel_comp_addr_r=0x0a000000\0"       \
> > +     "fdt_addr_r=0x12000000\0"       \
> > +     "fdtoverlay_addr_r=0x12100000\0"        \
> > +     "ramdisk_addr_r=0x12180000\0"   \
> > +     "kernel_comp_size=0x8000000\0"
> >
> >  #define CFG_EXTRA_ENV_SETTINGS \
> >       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \

Regards,
Hugh
