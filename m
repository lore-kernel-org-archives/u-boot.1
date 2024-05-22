Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90046C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDAF8885B;
	Wed, 22 May 2024 18:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="NNVXGvfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333F8880CC; Wed, 22 May 2024 18:33:37 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8413188287
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-df4d8d9be36so799731276.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1716395613; x=1717000413;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/+DfeTtMcGGEGSvzpMR0DuH5IaoDEnuYFDFf+yEbmA=;
 b=NNVXGvfZF65n1gN32inIFxj/L/8kOsTDqQsngUMlgcs8AIUzo//GYVPe/2rjWMyloL
 1Vo8FGND5yCxWpT9nNQlw6XrZyzjZ28OD1o4fEMayEk5Z1mfmyjBvKbRl9oL5eaEPaI1
 88IDcxBQPWmMobsd/pfp1rymiQBbY8VPp5tIuDufI1UxirgFcdGzXhvhQnh5EEonU4nK
 Xyik4aCzWcFRc1hQ1OzG8GlMkzk9YSjoYoJJANv+ynpLd6B7G3jnTDe8tisbHNBjr03s
 UGv9Db6o5AcFN8VQsnCDYyfpSnRPfhyeBOcV7HuFvZMJA6sx++R7g4Y616Tqon3VE+84
 eAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716395613; x=1717000413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/+DfeTtMcGGEGSvzpMR0DuH5IaoDEnuYFDFf+yEbmA=;
 b=mJnf6MWhIdffrnMNNqibifFT9esUtzCPOpqXpJbOzaMES6HnV6MeG6nI2xHZaXwCBi
 swfi97XRu39moo1gGqShJSMvJPf40rAq7/W5+wmvO5X3QWRiN5dP5nTzNtaOlrqToNWh
 jAiagCLFv36QCr/l2IuWDlfUJEhMfR+/nVFXog0TbcCFza1cweVJBQ6jm61gucb1H2jc
 4/2GYaiFR0phmqIm5aG1/9InTtbEBjw9hQwvOPzXv7Fe9Jh1/KRMnnvANV9MF6aFySzP
 9qppkcs8LlbSnxkrr025oecqcN67yM1Iq0C/hRlFdLjT67Ie3OZLSFuhxZib3fzDPylX
 kLsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlwF0j0j7ANgRVqHfXLU2nUINblvSCQKWJzMtYLKGwRdTTlU64Npz/iNfV02cUNJXOlMbY0F6ksW4Can8vt4EzHSYqaQ==
X-Gm-Message-State: AOJu0YywaI0Z5oIqapkijP37R724VlR1vcss5bivgtNsNo9a16609ObN
 oplzZHX5WM3LxaE+hobsrR/iaBwmTbD1YJpPNjygZN8Ff5ylTGUwOhSKWaIwJiaDsbaDF7X4XEf
 +wNpmfqPoegsz3fDBaDpn3t7gePdNakhUS+QU
X-Google-Smtp-Source: AGHT+IH0C9vqCpAYEm7zfipKnTjvJEgPmxS3oFEeACpT6Kima27IC0JXcCBoMYoP+mMcnv2g3jTITR4NcrqW7DKOIAI=
X-Received: by 2002:a5b:d4d:0:b0:df4:e089:d182 with SMTP id
 3f1490d57ef6-df4e0dd45dcmr1849573276.19.1716395613040; Wed, 22 May 2024
 09:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240521205955.3569600-1-tharvey@gateworks.com>
 <5cf2c7a1-4766-4343-a037-3893a03f14df@amd.com>
 <CAJ+vNU3O_cuo8i0w6XZGyrAs3zTqXRcrrpDsD61WfFt3C7AHLQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3O_cuo8i0w6XZGyrAs3zTqXRcrrpDsD61WfFt3C7AHLQ@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 22 May 2024 18:33:21 +0200
Message-ID: <CAHTX3dJ7-Jcf5HNgB6NKomNEZj5CKhOJhTd89JLpgLMAiBv2OA@mail.gmail.com>
Subject: Re: [PATCH v3] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@denx.de>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>
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

st 22. 5. 2024 v 17:19 odes=C3=ADlatel Tim Harvey <tharvey@gateworks.com> n=
apsal:
>
> On Wed, May 22, 2024 at 12:47=E2=80=AFAM Michal Simek <michal.simek@amd.c=
om> wrote:
> >
> >
> >
> > On 5/21/24 22:59, Tim Harvey wrote:
> > > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > > randomize the virtual address at which the kernel image is loaded, it
> > > expects entropy to be provided by the bootloader by populating
> > > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot=
.
> > >
> > > If we have DM_RNG enabled populate this value automatically when
> > > fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> > > is enabled as it's implementation uses a different source of entropy
> > > that is not yet implemented as DM_RNG. We also skip this if
> > > MEASURED_BOOT is enabled as in that case any modifications to the
> > > dt will cause measured boot to fail (although there are many other
> > > places the dt is altered).
> > >
> > > As this fdt node is added elsewhere create a library function and
> > > use it to deduplicate code. We will provide a parameter to specify th=
e
> > > index of the rng device as well as a boolean to overwrite if present.
> > >
> > > For our automatic injection, we will use the first rng device and
> > > not overwrite if already present with a non-zero value (which may
> > > have been populated by an earlier boot stage). This way if a board
> > > specific ft_board_setup() function wants to customize this behavior
> > > it can call fdt_kaslrseed with a rng device index of its choosing and
> > > set overwrite true.
> > >
> > > Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless n=
ow
> > > but left in place in case boot scripts exist that rely on this comman=
d
> > > existing and returning success. An informational message is printed t=
o
> > > alert users of this command that it is likely no longer needed.
> > >
> > > Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> > > randomization and completely ignores the kaslr-seed for its own
> > > randomness needs (i.e the randomization of the physical placement of
> > > the kernel). It gets weeded out from the DTB that gets handed over vi=
a
> > > efi_install_fdt() as it would also mess up the measured boot DTB TPM
> > > measurements as well.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > Cc: Michal Simek <michal.simek@amd.com>
> > > Cc: Andy Yan <andy.yan@rock-chips.com>
> > > Cc: Akash Gajjar <gajjar04akash@gmail.com>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > Cc: Devarsh Thakkar <devarsht@ti.com>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > Cc: Marek Vasut <marex@denx.de>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > > v3:
> > >   - skip if CONFIG_MEASURED_BOOT
> > >   - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
> > >   - pass in rng index and bool to specify overwrite
> > >   - remove duplicate error strings printed outside of fdt_kaslrseed
> > >   - added note to commit log about how EFI STUB weeds out kalsr-seed
> > >
> > > v2:
> > >   - fix typo in commit msg
> > >   - use stack for seed to avoid unecessary malloc/free
> > >   - move to a library function and deduplicate code by using it
> > >     elsewhere
> > > ---
> > >   board/xilinx/common/board.c | 35 -------------------------
> > >   boot/fdt_support.c          |  6 +++++
> > >   boot/pxe_utils.c            | 35 ++-----------------------
> > >   cmd/kaslrseed.c             | 45 +++++---------------------------
> > >   include/kaslrseed.h         | 19 ++++++++++++++
> > >   lib/Makefile                |  1 +
> > >   lib/kaslrseed.c             | 51 ++++++++++++++++++++++++++++++++++=
+++
> > >   7 files changed, 85 insertions(+), 107 deletions(-)
> > >   create mode 100644 include/kaslrseed.h
> > >   create mode 100644 lib/kaslrseed.c
> > >
> > > diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.=
c
> > > index 30a81376ac41..f741e8957818 100644
> > > --- a/board/xilinx/common/board.c
> > > +++ b/board/xilinx/common/board.c
> > > @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *b=
d)
> > >       if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFI=
G_NAND_ZYNQ))
> > >               fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
> > >
> >
> > one more thing here. Please also removed unused variables.
> >
> > board/xilinx/common/board.c: In function 'ft_board_setup':
> > board/xilinx/common/board.c:707:25: warning: unused variable 'ret'
> > [-Wunused-variable]
> >    707 |         int nodeoffset, ret;
> >        |                         ^~~
> > board/xilinx/common/board.c:707:13: warning: unused variable 'nodeoffse=
t'
> > [-Wunused-variable]
> >    707 |         int nodeoffset, ret;
> >        |             ^~~~~~~~~~
> >    AS      arch/arm/cpu/armv8/cache.o
> > board/xilinx/common/board.c:706:12: warning: unused variable 'buf'
> > [-Wunused-variable]
> >    706 |         u8 buf[MAX_RAND_SIZE];
> >        |            ^~~
> > board/xilinx/common/board.c:705:25: warning: unused variable 'dev'
> > [-Wunused-variable]
> >    705 |         struct udevice *dev;
> >        |                         ^~~
> > board/xilinx/common/board.c:704:16: warning: unused variable 'n' [-Wunu=
sed-variable]
> >    704 |         size_t n =3D MAX_RAND_SIZE;
> >        |                ^
> >
>
> Hi Michal,
>
> Thanks... missed those. What defconfig are you building that gets to
> this codepath?

xilinx_zynqmp_virt_defconfig

>
> I'll send a v4 after another day or so for others to respond.
>
> With these changes (and the previous response) do you have a rb or
> tested-by tag for me?

The rest looks good to me and no problem to provide tags.

Thanks,
Michal
