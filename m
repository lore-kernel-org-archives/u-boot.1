Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0B8CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4945E846F4;
	Thu, 25 Jun 2026 17:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LFop/vQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8AA084704; Thu, 25 Jun 2026 17:29:26 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0728460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c07ea058c1aso417580966b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401364; cv=none;
 d=google.com; s=arc-20260327;
 b=VY0Rz9DLDq65chD0CQ7tn622MWi/FEKcHTuJaM30dZ0Z/4qqxQPTzNBOrZFGAvT67t
 1VbPeqzJHFgBIrQ1me6CV+0FVm4uPifjj0EshHzo1saO071i+itCCL3cqFv/Zwk2rMKt
 Ti6cD13dvXVVG7NNF1wCxvdQxcqEHsa3X/shza15CXL7Nb/00gfOskrN8XHG26ubWB6S
 ULxlnEXKlJwv/cXy6BwyOuDbiTXelEy2mvMAzVdIDDSrPG/Db/Ej0zuL8n5hTJ8g1Ewy
 AxDlIOVqSN4pINg7LiKTjxpsx2eITO256TdlaQsmtrk5q3iyorD7s63VO5AnZQhUi3YA
 DKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E+XTUVYUF4/LPljDtOFe4HFl+C+yIGKHTVlSjxtTOnw=;
 fh=+jZ8d24Pa3/tmsDKsiMp9DzoaU3CD5ZiMbu7okigp6s=;
 b=q2xu5EjhaJp0q0lewgAuV50eMvfBTs2osqIoEzLvx9RBowI+1rUf2Uqqon0j0B7WY4
 lZanTELvp9brIIsmnu8KkO4QrjNYbMkUwxiYENdUKqNez4mU6TTPgdxujKTLaMAIzp9o
 PehdG1ZL0w2Udn43XDXeR7I7rj4C8ecztxZvu+9YooW+jljx5r25SdQQlBZkW/hHbZ4L
 U8sQanynukj7H7FheNBa20PkH5/eI/excTG8wm+HRLJQsCpkj/FRW2xDBQ3QPyuKhLqD
 uvkxhWMLULBi5uwS3U05PpZdR0uQT7YHh5aXOdKEIBCqw8nT3CBEQ4AOw7V1ZWli56Tt
 z9Ow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401364; x=1783006164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E+XTUVYUF4/LPljDtOFe4HFl+C+yIGKHTVlSjxtTOnw=;
 b=LFop/vQNCA+R/3LRMYyKSFc01g4jfzcfx39BHj2HXbMGjsnS3NkqLCMJSVXHg6hYul
 bQey7S/W+2PYrxcLJ5hdx2w+mw6cudKvEbFsT5gqAPVLhXIY2FzocFh6CVltJ0ngomw1
 zOKnGMfRscReaMm6NomWKe9B73eB+aZOfZ4mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401364; x=1783006164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+XTUVYUF4/LPljDtOFe4HFl+C+yIGKHTVlSjxtTOnw=;
 b=IbN3HLgMY8hMr70tc60t9ZGl8PDe2wZKlJMruhIIvH4BcrJciv45g4ZM4MBpCx4a6z
 H7VfisuwRF7SkkBhpUHzIY6cuZ9VG8S2Z2KPGMR+uExE80udg8+Jip4Z8vwZjs8ddLT6
 vKgmH6ANDd3FJmph02F9oKVmLQIr65/ZZrfZoQVCkiwYLhaHmw3Herb4wupL7lV878pK
 i1Y93Dp6+6wRV3QPhz3mOn91f6jMlacK4bS1kKZJJX8XHhEx3owPNwHLB0eRyZhEnVvJ
 d2ShnPvi7FK1DysforlXQwVIQdzAC7WDJz00wclc7wFxDo2hAzJgrsnGXvp86PRr8k0w
 msKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSp9yzt9ZM/VDl7fQfrHBfudsco/Futce4jknV1mYNj0Hf0zp0YXCaGn7zUDLyGFLWw8EZnIs=@lists.denx.de
X-Gm-Message-State: AOJu0YyXz4sXBx4Eajjvn+wafhOgmk2z5H0Ev0WSN83e9kQDOniPZvu3
 7Ne9OsOF0ZDtHlO/GjU4mNl7G1vetxy9i5bNJjlQ63AWqOxCi/T0ZrQVBw+SqYKaArDSaW6fwxC
 Q4SMvxVz3m4+buNPBkRdTXHTwukkvI+a7bN5FOoGM
X-Gm-Gg: AfdE7cm8ScKS9P3CnGk71VRNZ+Bc9kKYxr9uvAavfHiJRVjXjw1JMu+ImCetJTL9n3X
 vW1uiMkOx+MWbli5bhoDmtsrI/tyw/nj2B1Pz2CA/NKu1Y/HfDscu2HppED0VUUMmOgaUXv1sDU
 m68/GdcgBcNCCGdVgD2SbCjQlEMKvTxaDS4DbZi3dYNwt0H9bp8BK2iibJl2cUqyZYenuGyOvjF
 g+5NveSzjz4phug8s1TDZZi7xdKyRYh9UIEu0I4UeXLwu8/2AVUbMtGXG50l0V15wE34XUuPg==
X-Received: by 2002:a17:907:7b9a:b0:c12:11d5:719c with SMTP id
 a640c23a62f3a-c1211d57806mr130989766b.50.1782401363877; Thu, 25 Jun 2026
 08:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260619231719.3823195-1-rs@ti.com>
 <20260619231719.3823195-2-rs@ti.com>
 <CAC_iWjLszH6_c4DXFV2qqQoyhEC9R7emeOKoBO4WvEn5Zza2SA@mail.gmail.com>
 <DJFTGZ0I5LGG.218A8NZ1QBD6G@ti.com>
 <CAC_iWjK+ceFGMkdH0QmkDXcxu8YxD4uDr3dUgwpmajS8+pw9sw@mail.gmail.com>
 <DJGOC6IRTWKF.2ONXRLRZWJWQ7@ti.com>
 <CAC_iWjKEXzK6M6TLVLJ3ysgDx+9oCL6qv3tvhRqx+w-WYbXChA@mail.gmail.com>
In-Reply-To: <CAC_iWjKEXzK6M6TLVLJ3ysgDx+9oCL6qv3tvhRqx+w-WYbXChA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:29:11 +0100
X-Gm-Features: AVVi8Cdg7lootZ9TPrGrLbcKKp1jjyC3RmE5F5ia53vWT5wRiSsv_ZBVcqvbkBo
Message-ID: <CAFLszTjqbACpY=TWsg==Fif2iYSFdO7SWaTZJuV_-neg3zNqdg@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] board_f: add a board_setup_dest_addr function
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Randolph Sapp <rs@ti.com>, robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com,
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

Hi,

On Wed, 24 Jun 2026 at 08:05, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Randolph
>
> On Tue, 23 Jun 2026 at 22:26, Randolph Sapp <rs@ti.com> wrote:
> >
> > On Tue Jun 23, 2026 at 2:37 AM CDT, Ilias Apalodimas wrote:
> > > Hi Randolph
> > >
> > > On Mon, 22 Jun 2026 at 22:15, Randolph Sapp <rs@ti.com> wrote:
> > >>
> > >> On Mon Jun 22, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
> > >> > Hi Randolph
> > >> >
> > >> > On Sat, 20 Jun 2026 at 02:17, <rs@ti.com> wrote:
> > >> >>
> > >> >> From: Randolph Sapp <rs@ti.com>
> > >> >>
> > >> >> Add a weak definition for board_setup_dest_addr, as a way for specific
> > >> >> boards to override the gd->relocaddr address before the relocation
> > >> >> actually occurs.
> > >> >>
> > >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> > >> >> ---
> > >> >
> > >> > board_get_usable_ram_top() can be used instead.
> > >> >
> > >> > Cheers
> > >> > /Ilias
> > >>
> > >> It *could*. Just felt a little weird to artificially restrict the usable memory
> > >> because the stack just barely runs into one of our reserved regions long enough
> > >> to break a dt reserved-memory allocation.
> > >
> > > I am not sure I understand this without an example. We always relocate
> > > to ram_top for now and that's why that function exists. I've already
> > > started to clean up the relocations a bit [0]. I don't want to add
> > > more functions to tweak the reloc address unless necessary. Generally
> > > speaking the reloc address should not be board specific at all imho.
> > > If there are areas that we shouldn't use they need to be described in
> > > the DT and the core code should look at that. I am ok keeping one
> > > function to change this, but not more. We also have
> > > arch_setup_dest_addr() which isactually board specific (look at
> > > arch/powerpc/lib/stack.c which is the only place we define it).
> >
> > Alright, I'll add a little information about the specific predicament we're in
> > because of this board. Our ram_top is something like ~26MB away from a reserved
> > memory region defined in device tree. After the relocation, before we can
> > reserve the dt regions, we actually creep past 26MB of utilization. This makes
> > the dt reservation fail in the LMB path, but later the utilization retracts.
> > This lead me to find that some useful warnings were disabled [1] and other odd
> > things were occurring as a result.
> >
>
> Thanks this helps.
>
> > We can't even parse the dt without first reaching into one of the reserved
> > regions. With everything using physical addresses we can't really relocate the
> > active reservations to avoid this.
> >
> > To be clear, I don't even like the solution I proposed here because it requires
> > coordination between a device tree and a local configuration.
>
> I think the reality is that we will always have 'special' cases and
> we'll need a board function that tweaks the reloc address. But that
> should be the vast minority. I don't think we can solve this with a
> single commit. But cleaning up the core code will give as a pretty
> good idea of how many 'special' cases we actually have.
>
> >
> > There just isn't enough wiggle room here when u-boot doesn't have a real stack
> > size limit. We can't fully plan out a memory map ahead of time nor can we
> > account for this at runtime. Please inform me if I'm missing something here,
> > still fairly new to the way u-boot handles things.
>
> Ok so from what I read board_get_usable_ram_top() does solve your
> problem, right?
> I suggest you just define that and revisit the whole thing once I
> clean up a bit more.
> For example, I don't see why we need arch_setup_dest_addr() and we
> just can't define board_get_usable_ram_top() for the affected ppc
> boards.

+1 that woud be my question too - we are trying to simplify things and
avoid options only used by a few boards, where possible

>
> >
> > Thanks for look at this Ilias. Hard to get these kind of discussions otherwise.
>
> YW, I do care about abstracting this nicely and reducing the board
> specific code So if you have more of these cases feel free to cc me.
>
> Thanks
> /Ilias
> >
> > [1] https://lore.kernel.org/u-boot/20260604155038.3182-2-rs@ti.com/
> >
> > >>
> > >> Initially this was proposed because there are multiple runtimes with their own
> > >> allocation techniques that could potentially take advantage of that space. If
> > >> it's still preferable to use board_get_usable_ram_top though I will change it.
> > >
> > > [0] https://lore.kernel.org/u-boot/20260617074846.84362-1-ilias.apalodimas@linaro.org/
> > >
> > > Thanks
> > > /Ilias
> > >> >>  common/board_f.c | 9 +++++++++
> > >> >>  1 file changed, 9 insertions(+)
> > >> >>
> > >> >> diff --git a/common/board_f.c b/common/board_f.c
> > >> >> index fdb3577fec09..d9d09ac94bf2 100644
> > >> >> --- a/common/board_f.c
> > >> >> +++ b/common/board_f.c
> > >> >> @@ -328,6 +328,11 @@ __weak int arch_setup_dest_addr(void)
> > >> >>         return 0;
> > >> >>  }
> > >> >>
> > >> >> +__weak int board_setup_dest_addr(void)
> > >> >> +{
> > >> >> +       return 0;
> > >> >> +}
> > >> >> +
> > >> >>  static int setup_dest_addr(void)
> > >> >>  {
> > >> >>         int ret;
> > >> >> @@ -362,6 +367,10 @@ static int setup_dest_addr(void)
> > >> >>         if (ret)
> > >> >>                 return ret;
> > >> >>
> > >> >> +       ret = board_setup_dest_addr();
> > >> >> +       if (ret)
> > >> >> +               return ret;
> > >> >> +
> > >> >>         gd->initial_relocaddr = gd->relocaddr;
> > >> >>         return 0;
> > >> >>  }
> > >> >> --
> > >> >> 2.54.0
> > >> >>
> > >>
> >

Regards,
Simon
