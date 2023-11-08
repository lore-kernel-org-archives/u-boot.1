Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CBEC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 14:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4BD87272;
	Wed,  8 Nov 2023 15:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rWV9Xw8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A668086FB2; Wed,  8 Nov 2023 15:20:55 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2C98721C
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ardb@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id DFD21B81C01
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 14:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D1EC4339A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699453252;
 bh=E82DmwfH2dcxbs9xwMmLiAaOTn5D4Ow/0Cpeotwv8Tc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rWV9Xw8NQwgrRa5bh7nxobt3EqPIBdZysZTWWrerABqOhIeuc1Jnby1BN2RDe6jSo
 wMC3krMIgAV9h8cHBuiFMh3OnoC3PvFNYfXcFr8asqoC8PUIh9NLWF0HfK/5X9PJna
 FtNp1qyXtzlxe51KM8v9HXKo949wd8TvzBYHFjWrIpr/fJT718UUvyZZYNHdr9Gz87
 lpBiEXfyw04EV1dbr6WISFxIDQcdQfSpYgg7s8OXdUzU7Wl5EHf9NVIujRA8jtvOAS
 4hYRkewHrL2b9sIIiuVIjloxGRyoSp0Rqw3Z1EVhordXWA9/lMH6d3wK30okromWFX
 DblWljL7w3jaw==
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2c6b30acacdso91899321fa.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 06:20:51 -0800 (PST)
X-Gm-Message-State: AOJu0YyI1r99zqoENzn+GxU4R1CS5HFj/M5zdF7aUy4SN0LtthsmuSS4
 n63OrLE8SB2TPVP/RK5tT+eAgfbv78rUVXHx3Wc=
X-Google-Smtp-Source: AGHT+IF3AlqJpBLUhu1DTarhTz6FDwvlN0RLFjtbhZO/9hXihKmHvPiQC4/ncAP2kR3ROp5UFGC31vCUAe8Gj7r8AZQ=
X-Received: by 2002:a2e:8e3c:0:b0:2c6:eaf8:49ff with SMTP id
 r28-20020a2e8e3c000000b002c6eaf849ffmr1584451ljk.37.1699453250122; Wed, 08
 Nov 2023 06:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
 <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
 <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
 <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com>
 <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
 <CAL_JsqL+X1DatsGk_Cn1HsbG2GV9AngFWXVysWTiNRu_d9tDqw@mail.gmail.com>
 <CAMj1kXHfh40wxerZGjOn2JJ5Skm5C--Rz2jy8p3XZ2UXKGjw+g@mail.gmail.com>
 <CAL_JsqLpea+FU4gXpaSUSeBP70szJ+mRjJtFei=QW2VoHCFOuA@mail.gmail.com>
In-Reply-To: <CAL_JsqLpea+FU4gXpaSUSeBP70szJ+mRjJtFei=QW2VoHCFOuA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 8 Nov 2023 15:20:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHPVXB2ojzhKbAO47+EDMDzODqjLZ+iOKw=u=Bc7=HPCQ@mail.gmail.com>
Message-ID: <CAMj1kXHPVXB2ojzhKbAO47+EDMDzODqjLZ+iOKw=u=Bc7=HPCQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Rob Herring <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org, 
 Mark Rutland <mark.rutland@arm.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, 
 Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
 ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>, 
 Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 8 Nov 2023 at 14:57, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 8, 2023 at 5:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Tue, 7 Nov 2023 at 19:07, Rob Herring <robh@kernel.org> wrote:
> > >
> > >
> > > All of this:
> > >
> >
> > > > On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > It is not specific to EDK2. Imagine this boot sequence:
> > > > >
> > > > > - Platform Init (U-Boot) starts up
> > > > > - U-Boot uses its platform knowledge to sets some ACPI tables and=
 put
> > > > > various things in memory
> > > > > - U-Boot sets up some runtime code and data for the OS
> > > > > - U-Boot jumps to the Tianocore payload **
> > > > > - Payload (Tianocore) wants to know where the ACPI tables are, fo=
r example
> > > > > - Tianocore needs to provide boot services to the OS, so needs to=
 know
> > > > > the memory map, etc.
> > > > >
> > > > > ** At this point we want to use DT to pass the required informati=
on.
> > > > >
> > > > > Of course, Platform Init could be coreboot or Tianocore or some
> > > > > strange private binary. Payload could be U-Boot or something else=
.
> > > > > That is the point of this effort, to build interoperability.
> > >
> > > [...]
> > >
> > > > > Perhaps the problem here is that Linux has tied itself up in knot=
s
> > > > > with its EFI stuff and DT fixups and what-not. But this is not th=
at.
> > > > > It is a simple handoff between two pieces of firmware, Platform I=
nit
> > > > > and Payload. It has nothing to do with the OS. With Tianocore the=
y are
> > > > > typically combined, but with this usage they are split, and we ca=
n
> > > > > swap out one project for another on either side of the DT interfa=
ce.
> > >
> > > Is perhaps the clearest description of the problem you want to solve.
> > > It's clearly related to EFI though not the interface to the OS. IIRC,
> > > "platform init" and "payload" are terms in the UEFI spec, right?
> >
> > No they are not. This is from the universal payload specification that
> > is being drafted here
> >
> > https://universalpayload.github.io/spec/index.html
> >
> > but the UEFI specification does not use this terminology.
>
> Then I'm confused as to what this is:
>
> https://uefi.org/specs/PI/1.8/index.html
>

The PI and UEFI specifications are both maintained by the UEFI forum.

The UEFI specification covers external APIs for firmware
implementations, i.e., the OS visible interface and the public API for
UEFI device drivers that are not tightly integrated with system
firmware (for example, the GPU boot time driver in the ROM of an
add-in card)

The UEFI forum's PI spec describes system firmware internals, and
defines the SEC, PEI DXE and BDS boot phases, among other things.

It is possible to implement UEFI without PI (which is what uboot does,
for instance), but Tianocore/EDK2 is the reference implementation for
both PI and UEFI, and sadly, there is no discernible distinction
between the two (e.g., both PI and UEFI use identifiers with EFI_ type
and enum identifier prefixes)

'platform init' in the context of this discussion is something
completely separate, and has zero bearing on the PI<->UEFI handover in
Tianocore (which is not really a handover to begin with).

There is code in Tianocore which allows it to run as a 'payload',
which means [presumably] that only the DXE and subsequent phases are
launched from a 'platform init' component that describes the platform
using some of the DT bindings that are under discussion here. In this
case, I can see how some of the ACPI descriptions provided by the
'platform init' might be inherited by the 'payload'. However, I don't
see how such a Tianocore payload would make meaningful use of
boot/runtime code/data described in general terms using this proposed
binding, which is why I keep asking for an example scenario.
