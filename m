Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7F8C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 06:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A89A68058A;
	Sat,  8 Mar 2025 07:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ngvre4U5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17756808A2; Sat,  8 Mar 2025 07:48:25 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B0680079
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 07:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abf48293ad0so411694866b.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 22:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741416502; x=1742021302; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toXenfOLVSDpNgGSCtbWRkExx6O1OMGTgSGeiMOvIHM=;
 b=Ngvre4U5YqkjdUtmI52ixkP3rGhuizVHE/u+5ht38ls5F8dLJAstBVMt0iaxaZJ/rT
 1dzLvEN0/5UA6TNgsW+SXMG14bQiz9l0b7DODS7Wijehu2yvFm3qojR45J2nAnYr29iN
 M00ErulqUrPwMBCVMTmbZjTXoP356KxmXUwhVZDe6giILZCJf2WOSJeWBC12oWtrAgh8
 Nj9HgM13RTueMeCAXo0rODGz/G3Ip/DZ2jL1n8qIq3xGK/HeqHxR73C4BOem80r+FxMX
 zO0ZqJEqo3pva9aUKfce2cTRPAzOzMs6sIZIXtYljeVykssRVz4Hs88FaHN+cJlwhw+a
 u/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741416502; x=1742021302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toXenfOLVSDpNgGSCtbWRkExx6O1OMGTgSGeiMOvIHM=;
 b=q4P5znaOMwYfcpzld7sOvTTLqu8qLoNU7Yl+Ghx9CPLNGLu+fYtI2R8H0HgUYoaklc
 TomD40tcHTSHAxHaoZGckCrlWOpeuZswMt/ajzdW8Qlwf+VYwZ4E7K4i0bJH91IDOucU
 0OFFBH1LZBhDrlwsiF8oi4XJH0/j+sXTMblNbHs0zqIHgPWwXnoAOoYApgTx2BlLSTUd
 g6Y2gARFTqZ0bBSLowwqZPZqF/3KfnO5FAw3P3r8lP/UeeNYAJwXVMo+J4MtAtCYFdo5
 pIYbsE2i8bnbvoZEzd03oagVftPZi9GDwGJj4iajURnWRHQvh++AyLFkCP3dMBhQ9a/7
 +21A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUah4EQ8rlC/JLs58GQ/L04sRSGUpU38/4AlqGzzX10YbgHLarNE0TyEkyEdYmqQjFQ1m3sL2w=@lists.denx.de
X-Gm-Message-State: AOJu0YwP+Rv60XNVGd82kPA5IABrbUigx1jLGoaJ0/epy0PNWZsDrf3P
 nylZkYQYieZZ8Vm9CzNkO7Q6RWvdtkqstbG2LYLvbCHvLlItbb0Hs4Vz/Pa7lATl71FSJmeOuwi
 K4+vkMJZjbAIBDJskLPlhZj3khEU=
X-Gm-Gg: ASbGncsK6DJo1jjgEaCv+I5DGh37UNogXt0A+JYKhWdMg2D5LYpwiM90KJbYkQbK6Pd
 32bvPhMkgbt7wuzGr6IttQNy7OW0sXfQM9KO1CwlKFdqsfcb2rY+L5wpoOCfh9IREuGcCM7W4w9
 J2/nidAKB7oMlPdG+54rpUY11UsbnjogbcgGvHq55DjhMYyw3LL5Y12ySn488=
X-Google-Smtp-Source: AGHT+IGvDdvdBxzOeRXTVV4rgx+zWP8YwlyHoYQvaQ0GabiVK+iu2Jmsj1RdzaRF7+eNhFVvR1KScQeLlx4hLRSzuYE=
X-Received: by 2002:a17:907:d8f:b0:abb:bcef:837c with SMTP id
 a640c23a62f3a-ac25303298emr558154566b.56.1741416502211; Fri, 07 Mar 2025
 22:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <CAH5Ym4isqLibOv97=9zgYFx-fok-sAa3QetfRgyrQmDQ4MHgmQ@mail.gmail.com>
 <20250306154717.GE2640854@bill-the-cat>
In-Reply-To: <20250306154717.GE2640854@bill-the-cat>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 7 Mar 2025 22:48:11 -0800
X-Gm-Features: AQ5f1Jp--UHYd8ogrPpAbpAo-gieIqucak6t3UQHhsd7nC0C3o3JtIopFzrc2mU
Message-ID: <CAH5Ym4iVdMk9C3qyuOasM7spNU4XzohuYVZ7Z-+OmG3FGm2jzg@mail.gmail.com>
Subject: Re: [PATCH 00/17] Various toolchain compatibility fixes/improvements
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
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

On Thu, Mar 6, 2025 at 7:47=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 05, 2025 at 07:46:56PM -0800, Sam Edwards wrote:
> > On Sun, Feb 23, 2025 at 9:55=E2=80=AFPM Sam Edwards <cfsworks@gmail.com=
> wrote:
> > >
> > > Long time no see, U-Boot folks!
> > >
> > > This patchset consists of various bug fixes and correctness improveme=
nts that
> > > I discovered while attempting to add first-class LLVM support to the =
build
> > > system. These patches are NOT related to LLVM support directly; rathe=
r, they
> > > address existing issues that should be resolved regardless of future =
changes.
> > > For the most part, the patches are mutually independent and can be re=
viewed and
> > > applied separately. If any patch is not suitable for merging now, fee=
l free to
> > > skip it: I will incorporate feedback and revisit those changes as par=
t of the
> > > upcoming LLVM support patchset. I'd like this patchset to be evaluate=
d on its
> > > own merits, based on the current state of the code, without considera=
tion for
> > > future LLVM support.
> > >
> > > Note that the issues addressed in this patchset do not occur when U-B=
oot is
> > > built using the GCC/GNU toolchain. These bugs seem to be specific to =
builds
> > > using other toolchains, like LLVM, and do not appear to affect users =
relying on
> > > GCC/GNU. Therefore, I see no need to rush these changes into the stab=
le branch.
> > >
> > > Again, these patches are mostly independent/reorderable...
> > > ...except that: "arm: Add aligned-memory aliases to eabi_compat"
> > > ...depends on: "arm: Add __aeabi_memclr in eabi_compat"
> > >
> > > Warm regards,
> > > Sam
> >
> > Hi Tom,
> >
> > I noticed that all patches in this series have been marked 'Changes
> > Requested' on Patchwork. While some patches do need changes, this
> > series was intended as a set of independent submissions: each patch
> > can be accepted, rejected, or reordered without affecting the others.
> > Would it be possible to reconsider the remaining patches for review
> > without resending the series?
> >
> > I'd like to withdraw the following patches:
> >
> > - [06/17] arm: Use -mstrict-align when the MMU is off (Incorrect approa=
ch)
> > - [11/17] makefile: Fix symbol typo in binary_size_check (Will follow
> > Simon's suggestion for a more comprehensive fix across architectures
> > in a future submission)
> >
> > The feedback I've received so far was mostly requests for
> > clarification, which I believe I've addressed in my replies. Please
> > let me know if anything remains unclear or if further adjustments are
> > needed.
> >
> > Thank you so much for your time!
>
> It's *really* hard to track parts of a series in that way. If they
> aren't intended to be applied all in one go, please post them
> individually as v2s. The clarifications likely mean a bit more rewording
> of the commit messages are in order.
>
> If it's really hard on your end to resend things, I can go and poke
> through the series (once Ilias has had time to do the reviews I see he
> promised).

Hi Tom,

Well... that's "hard" but not "really hard" for me, so I think what
I'll pitch is this: let's let Ilias (and others if so inclined) have a
week to pick through the series (thanks Ilias!) and offer feedback;
I'll resend any patches that get no/positive feedback as a v2 series
(where the "just skip any patch deemed objectionable" option will
still apply), and any patches that need reworking can be part of my
upcoming LLVM support series. Would that work?

Cheers,
Sam

>
> --
> Tom
