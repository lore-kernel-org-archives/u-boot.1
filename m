Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEDACFB448
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C378588B3F;
	Mon,  7 Oct 2024 17:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NO0/28hG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8177E888B2; Mon,  7 Oct 2024 17:23:43 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7C5886A7
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb37b34a87so34691236d6.0
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314620; x=1728919420; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wW+B/wezzODB0UKurOyhEBgX0UXSNKOzIoxkTwGrLIw=;
 b=NO0/28hGyYzuOtjBAQh7CFLfX5nmOhuad46IaPCl6FRGiWs8ncoFMdiuzxhjILhY9r
 YvaKgKaTt3tuxEkvf/3G9TVfcj14lV2NZNQItvmIeA9mKogJfnuVLPn5p43fZO+Vegl0
 Z4oKkFsf0AYg1cw7qjP6jpJRuoSc9Zc3joKOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314620; x=1728919420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wW+B/wezzODB0UKurOyhEBgX0UXSNKOzIoxkTwGrLIw=;
 b=JFptpIYbniD+/qB8jpc/ukmumt7Gs3evWZ8PaLDm2xMTdSfW26IvwIZXsGgZaC+zCg
 uXcgu5Dz8RpmDd9p8EBs1EKRsRGo/x4zM+yOBnWLp9uItG63I2m/cl4pZTRGrnBXjcxe
 obCjTdC1vnk5tuuX6P4lmXHX1ZnbBzHhQmgwySrDSfv3+EuNcgC9zSLvlqPKQP7iCP/D
 EcxK98jSdAetOQJ98sIle9MqdQmZ4v4ZVOqc7/wBc4aNMi41EiQN7+R0ILLI6Iok821W
 1GKd7L1biPiNc/2BjcKdK5F15viaTw+eYna5Uj8dk59itAq0YNzkESjvpqaF/P0ws//C
 AeTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwvf0yCNfSOGxiffD8DB9nosWpvmimbX+PKTfRYanCRFmVG/aZkq8csdFZd0gc+2z1JhOxlEQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxKvitvyAYeEkN6X1dF//owcYImrZO/MQScE6nG+NAmtvs2UvY+
 x6314CaJtT+SwLAdGQFYH2soQVdULWbiCnxuZCR+MKlUVcAVccg+TclsXWu5KybhKOlJ5w2Iiu7
 RABQW4Su32w9FS61Yb5VTOP/nYlvziJTL3Jcy
X-Google-Smtp-Source: AGHT+IHwkqCBAjMysyYPjde797l5XVI/Uz2l959cPMd0J0AKOFoTQs65ljtELsJWIEalgUbqvf0DsvPoEW5CZAN3fFc=
X-Received: by 2002:a05:6214:3a87:b0:6c3:69be:a3e with SMTP id
 6a1803df08f44-6cb9a4f9252mr179248726d6.43.1728314619732; Mon, 07 Oct 2024
 08:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
 <5c4686da-f39f-4a48-ba57-4d2f7fb3e66a@gmx.de>
In-Reply-To: <5c4686da-f39f-4a48-ba57-4d2f7fb3e66a@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:23:28 -0600
Message-ID: <CAFLszTjQgorrZ9LOqR1jbSifGEqRE=zpZbNhprqPip+owKN4tA@mail.gmail.com>
Subject: Re: [PATCH v11 03/29] linker_lists: set LINKER_LIST_ALIGN to 8 for
 CPU_MIPS64
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Alexander Gendin <agendin@matrox.com>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On Fri, 4 Oct 2024 at 06:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 03.10.24 17:22, Jerome Forissier wrote:
> > Note: Patch posted separately [0].
> >
> > [0] https://patchwork.ozlabs.org/project/uboot/patch/20241003142030.1610222-1-jerome.forissier@linaro.org/
> >
> > CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> > exception may occur. Fixes an issue found on malta64 with QEMU:
> >
> >   Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
> >   31                      if (!strcmp(name, entry->name))
> >   [...]
> >   ld      a1,0(s0)
> >
> >   (gdb) p/x &entry->name
> >   0xffffffffbe04b0d4
> >   (gdb) p/x $s0
> >   0xffffffffbe04b0d4
> >
> >   $ grep __u_boot_list /tmp/malta64/u-boot.objdump
> >   4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >   arch/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 8f1f4667012..8f4df849801 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
> >   config LINKER_LIST_ALIGN
> >       int
> >       default 32 if SANDBOX
> > -     default 8 if ARM64 || X86
> > +     default 8 if ARM64 || X86 || CPU_MIPS64
>
> Shouldn't we set 8 byte alignment on all 64bit architectures including
> riscv64?
>
>      default 8 if 64BIT
>
> @Simon
> I would not know why 32bit X86 should need 8 byte alignment.
> I am a bit astonished that you chose 32 byte alignment for the Sandbox.
> Is there any justification to use more than 4 on the 32bit Sandbox and
> more than 8 on the 64bit Sandbox? If yes, we should document it via a
> comment.

It was really long so I put it in the commit message. Please check
'git blame' as there is often stuff there:

linker_lists: Fix alignment issue

The linker script uses alphabetic sorting to group the different linker
lists together. Each group has its own struct and potentially its own
alignment. But when the linker packs the structs together it cannot ensure
that a linker list starts on the expected alignment boundary.

For example, if the first list has a struct size of 8 and we place 3 of
them in the image, that means that the next struct will start at offset
0x18 from the start of the linker_list section. If the next struct has
a size of 16 then it will start at an 8-byte aligned offset, but not a
16-byte aligned offset.

With sandbox on x86_64, a reference to a linker list item using
ll_entry_get() can force alignment of that particular linker_list item,
if it is in the same file as the linker_list item is declared.

Consider this example, where struct driver is 0x80 bytes:

    ll_entry_declare(struct driver, fred, driver)

...

    void *p = ll_entry_get(struct driver, fred, driver)

If these two lines of code are in the same file, then the entry is forced
to be aligned at the 'struct driver' alignment, which is 16 bytes. If the
second line of code is in a different file, then no action is taken, since
the compiler cannot update the alignment of the linker_list item.

In the first case, an 8-byte 'fill' region is added:

.u_boot_list_2_driver_2_testbus_drv
            0x0000000000270018       0x80 test/built-in.o
            0x0000000000270018
_u_boot_list_2_driver_2_testbus_drv
.u_boot_list_2_driver_2_testfdt1_drv
            0x0000000000270098       0x80 test/built-in.o
            0x0000000000270098
_u_boot_list_2_driver_2_testfdt1_drv
*fill*         0x0000000000270118        0x8
.u_boot_list_2_driver_2_testfdt_drv
            0x0000000000270120       0x80 test/built-in.o
            0x0000000000270120
_u_boot_list_2_driver_2_testfdt_drv
.u_boot_list_2_driver_2_testprobe_drv
            0x00000000002701a0       0x80 test/built-in.o
            0x00000000002701a0
_u_boot_list_2_driver_2_testprobe_drv

With this, the linker_list no-longer works since items after testfdt1_drv
are not at the expected address.

Ideally we would have a way to tell gcc not to align structs in this way.
It is not clear how we could do this, and in any case it would require us
to adjust every struct used by the linker_list feature.

One possible fix is to force each separate linker_list to start on the
largest possible boundary that can be required by the compiler. However
that does not seem to work on x86_64, which uses 16-byte alignment in this
case but needs 32-byte alignment.

So add a Kconfig option to handle this. Set the default value to 4 so
as to avoid changing platforms that don't need it.

Update the ll_entry_start() accordingly.

Regards,
Simon
