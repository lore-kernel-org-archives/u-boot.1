Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A2C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 17:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C392987063;
	Wed,  8 Nov 2023 18:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="L6pb2Juq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626B1871A2; Wed,  8 Nov 2023 18:54:39 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D958C87033
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 18:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sheng.tan@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso2104466b.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1699466075; x=1700070875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nqqqa5adV4234V9BZcAKeuou46i1inO9zoz8S9OE0AY=;
 b=L6pb2JuqUoCWx40AUe59DUooFXmQXsDAb6O4qrtMCYxUb44O60aq1mqMnxA0B5mtcu
 t96xnk6Jv8FJUkpadzrpotR1MhoP/rlN7AgZvVL1FbIpOTyEo+XSqBP7c1CwOuUM6Mdt
 q6H76wCafzfMEnUzIKUIxXXHlVKuZqeekJD7R0X3bBBovDAV5dpuACy4t7uhaBSJ9vJk
 cn7Of0TTeSon3cr1XseFCWOdJfXmyEjXZxvRI46pbpuDKPzF8U7o4zvVWdWDn6Q072OJ
 lbPk08xtMyii9SZrjQ9uW6il5PB2/D0w/YBiWJPrrbAJxt0kUYhGPMcnnYEwGnmAFlQg
 b4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699466075; x=1700070875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nqqqa5adV4234V9BZcAKeuou46i1inO9zoz8S9OE0AY=;
 b=NV89WrJ5Z6dFJDJZ7qdPU6rBaX6s4lys5byFRSi4LndnophoqB2DZnm2hIwS5V4YJ1
 r/DefD7EQAhlPcMf8m5ATAxRC/SgkPgq6Ug6DUIPAbZQuY/bGDqCz9I+qBd52RPP7UZ/
 nOAmJnj5M+wWLk/6Z2OEI4xpKz8wDYSCwV9Nu4GjHMDpKhZqUuO1SBUbOhKT504qQ/R8
 PLz3oN+EV23xGWEAb3kYxrN4kl8zZ0eKQphBicD4tuoUByXq1/YP+vB3ZYJVdxtqhQmI
 IUjAlY99+wPzbvDPZGf23vdAzApb1hIUYPWX1DPi476dPS4DMONzDNku2pgt1OVAdHdv
 mneA==
X-Gm-Message-State: AOJu0YxfwoKYWTRR98gSD7TWxBXdWkXcJ0von+omxxhqfm5zTdkBOEVB
 sg2IMHfH8PfbAmK682YsVN/1Pb+lVGzC2/b4CE/tRQ==
X-Google-Smtp-Source: AGHT+IGGUaXVEC8ODzR0pAowhKTdsBLJibQJYb8KC968W8vinDdA24VdJbhNzzXdZT00mpflFzotQaBxjMrBqxZ8f7g=
X-Received: by 2002:a17:907:b60a:b0:9e4:4f8:c42c with SMTP id
 vl10-20020a170907b60a00b009e404f8c42cmr1617327ejc.21.1699466075034; Wed, 08
 Nov 2023 09:54:35 -0800 (PST)
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
 <CAMj1kXHPVXB2ojzhKbAO47+EDMDzODqjLZ+iOKw=u=Bc7=HPCQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHPVXB2ojzhKbAO47+EDMDzODqjLZ+iOKw=u=Bc7=HPCQ@mail.gmail.com>
From: Lean Sheng Tan <sheng.tan@9elements.com>
Date: Wed, 8 Nov 2023 18:53:59 +0100
Message-ID: <CAMWxwJ0ev9=t8_e1SsnX0JYchtR0Ct0eWo1W3OmY4WO6GnvZfw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 devicetree@vger.kernel.org, 
 Mark Rutland <mark.rutland@arm.com>, lkml <linux-kernel@vger.kernel.org>, 
 Dhaval Sharma <dhaval@rivosinc.com>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Yunhui Cui <cuiyunhui@bytedance.com>, Guo Dong <guo.dong@intel.com>, 
 Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>,
 Gua Guo <gua.guo@intel.com>, 
 Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Rob,
Sure, I will ask if the edk2 developers who work together for UPL spec
could help to respond here.

Hi Ard,
Regarding this part:
*However, there is no scoping in DT schema as far as I am aware, which
means that the OS may be forced/expected to interpret these regions beyond
simply disregarding them and treating them as reserved memory, and *that*
is something I strongly object to.*

I think that is one of good perspective to look into this, however please
also consider this situation: that everyone is just starting to develop
their own DT schemas (e.g. RISC-V), and there is no way to stop OS to also
pick up those DT nodes. in that case, if we do not maintain a more unified
DT schema, then OS might end up with more conflicting and
possibly contracting DT nodes/ properties (e.g. RISC-V with own DT schemas
using U-Boot (another DT schema) + edk2 payload (another DT schema, like
UPL) to boot to OS. So personally I still prefer a unified DT schema, even
if the OS never uses them, but that would be very beneficial and in control
in the long term if more people are using DT.

For now, the DT does serve as the purpose of communication vehicle in
between platform init and payload, which is still within Firmware stack.
However from edk2 stand point, there is more people want to roll out DT for
more internal usage within edk2 itself, for example:
https://uefi.org/sites/default/files/resources/Embracing%20Modularity%20and=
%20Boot-Time%20Configuration%20Faster%20TTM%20with%20Tiano-based%20Solution=
s_Warkentin.pdf

For sure, it is much easier for us (and time saving as well) to just
maintain DT schema/ format within our own UPL spec, but as mentioned, for
better long term maintenance and community collaborations, we decided to
upstream our implementation back to the main DT schema :)

Thanks!

Best Regards,
*Lean Sheng Tan*



9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email: sheng.tan@9elements.com
Phone: *+49 234 68 94 188 <+492346894188>*
Mobile: *+49 176 76 113842 <+4917676113842>*

Registered office: Bochum
Commercial register: Amtsgericht Bochum, HRB 17519
Management: Sebastian German, Eray Bazaar

Data protection information according to Art. 13 GDPR
<https://9elements.com/privacy>


On Wed, 8 Nov 2023 at 15:20, Ard Biesheuvel <ardb@kernel.org> wrote:

> On Wed, 8 Nov 2023 at 14:57, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Nov 8, 2023 at 5:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> > >
> > > On Tue, 7 Nov 2023 at 19:07, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > >
> > > > All of this:
> > > >
> > >
> > > > > On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org>
> wrote:
> > > > > >
> > > > > > It is not specific to EDK2. Imagine this boot sequence:
> > > > > >
> > > > > > - Platform Init (U-Boot) starts up
> > > > > > - U-Boot uses its platform knowledge to sets some ACPI tables
> and put
> > > > > > various things in memory
> > > > > > - U-Boot sets up some runtime code and data for the OS
> > > > > > - U-Boot jumps to the Tianocore payload **
> > > > > > - Payload (Tianocore) wants to know where the ACPI tables are,
> for example
> > > > > > - Tianocore needs to provide boot services to the OS, so needs
> to know
> > > > > > the memory map, etc.
> > > > > >
> > > > > > ** At this point we want to use DT to pass the required
> information.
> > > > > >
> > > > > > Of course, Platform Init could be coreboot or Tianocore or some
> > > > > > strange private binary. Payload could be U-Boot or something
> else.
> > > > > > That is the point of this effort, to build interoperability.
> > > >
> > > > [...]
> > > >
> > > > > > Perhaps the problem here is that Linux has tied itself up in
> knots
> > > > > > with its EFI stuff and DT fixups and what-not. But this is not
> that.
> > > > > > It is a simple handoff between two pieces of firmware, Platform
> Init
> > > > > > and Payload. It has nothing to do with the OS. With Tianocore
> they are
> > > > > > typically combined, but with this usage they are split, and we
> can
> > > > > > swap out one project for another on either side of the DT
> interface.
> > > >
> > > > Is perhaps the clearest description of the problem you want to solv=
e.
> > > > It's clearly related to EFI though not the interface to the OS. IIR=
C,
> > > > "platform init" and "payload" are terms in the UEFI spec, right?
> > >
> > > No they are not. This is from the universal payload specification tha=
t
> > > is being drafted here
> > >
> > > https://universalpayload.github.io/spec/index.html
> > >
> > > but the UEFI specification does not use this terminology.
> >
> > Then I'm confused as to what this is:
> >
> > https://uefi.org/specs/PI/1.8/index.html
> >
>
> The PI and UEFI specifications are both maintained by the UEFI forum.
>
> The UEFI specification covers external APIs for firmware
> implementations, i.e., the OS visible interface and the public API for
> UEFI device drivers that are not tightly integrated with system
> firmware (for example, the GPU boot time driver in the ROM of an
> add-in card)
>
> The UEFI forum's PI spec describes system firmware internals, and
> defines the SEC, PEI DXE and BDS boot phases, among other things.
>
> It is possible to implement UEFI without PI (which is what uboot does,
> for instance), but Tianocore/EDK2 is the reference implementation for
> both PI and UEFI, and sadly, there is no discernible distinction
> between the two (e.g., both PI and UEFI use identifiers with EFI_ type
> and enum identifier prefixes)
>
> 'platform init' in the context of this discussion is something
> completely separate, and has zero bearing on the PI<->UEFI handover in
> Tianocore (which is not really a handover to begin with).
>
> There is code in Tianocore which allows it to run as a 'payload',
> which means [presumably] that only the DXE and subsequent phases are
> launched from a 'platform init' component that describes the platform
> using some of the DT bindings that are under discussion here. In this
> case, I can see how some of the ACPI descriptions provided by the
> 'platform init' might be inherited by the 'payload'. However, I don't
> see how such a Tianocore payload would make meaningful use of
> boot/runtime code/data described in general terms using this proposed
> binding, which is why I keep asking for an example scenario.
>
