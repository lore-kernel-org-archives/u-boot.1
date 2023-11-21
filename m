Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF87EC61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 16:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239CB875A4;
	Tue, 21 Nov 2023 17:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fbdiQe8X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFB9875B8; Tue, 21 Nov 2023 17:42:17 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFDB187258
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 17:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ardb@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3560461A95
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D783CC433CD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700584932;
 bh=aFR/mFQKExXAv/nb9N19ON2XLkx59yXepa2exX1U6mQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fbdiQe8X69JnkXR9G+YL3eKWLpEa9R9p0icP5neCy/qJjCZXxLmCZD/NbohU93wcY
 7SZNvGqDRjTIN4EdDte4XEmQqO13pIkEPKnHBaPukBCH3u5Isy7Ye+sKEUiCpoztrz
 O9+3cOmKQsoDuRGnceCn/iMAutUZb/loXqoXJ0eG/EndcQ0HQSNzYPgGGjHoFXVBip
 MLpYlEajp8IToIRD/xSOQpFuIzgQ+87Qt2+7p6IojhME43Dho6v/ZWdPoh0jtFo6Q5
 Lr35JjycOgRghk1gA7aq7nAlEs8LP3FEIrWIEOED74W6cwpJGzdQuvIWYQ83m7ENRi
 g7G1UzLENPMVQ==
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2c876f1e44dso38703931fa.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 08:42:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yyg4F9UXv+f8RRNhe9akUfHLJyCtXd8y0aLFMC3XsaUSQBb627J
 JKDkiO81vhTIOf7ICfCo73agBXRxcepcwM+CQ1o=
X-Google-Smtp-Source: AGHT+IE1BtBBQXH8IhaD0lfThsj9OIMHKzDOIxlPBJGUB9DukWvY41yZhOqj18nk5W7PFyAXHxOdAkbW6vA0h7iKYww=
X-Received: by 2002:a2e:8e63:0:b0:2bb:a28b:58e1 with SMTP id
 t3-20020a2e8e63000000b002bba28b58e1mr7794383ljk.41.1700584931089; Tue, 21 Nov
 2023 08:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
In-Reply-To: <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 21 Nov 2023 11:41:59 -0500
X-Gmail-Original-Message-ID: <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
Message-ID: <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Simon Glass <sjg@chromium.org>
Cc: "Chiu, Chasel" <chasel.chiu@intel.com>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, "Tan, Lean Sheng" <sheng.tan@9elements.com>, 
 lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
 "Brune, Maximilian" <maximilian.brune@9elements.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, 
 "Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
 ron minnich <rminnich@gmail.com>, "Guo, Gua" <gua.guo@intel.com>, 
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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

On Mon, 20 Nov 2023 at 21:12, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Mon, 13 Nov 2023 at 11:09, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> >
> >
> > Hi Ard,
> >
> > Please see my reply below inline.
> >
> > Thanks,
> > Chasel
> >
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > > Sent: Saturday, November 11, 2023 3:04 AM
> > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark =
Rutland
> > > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Shen=
g
> > > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dhava=
l
> > > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.com=
>;
> > > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron mi=
nnich
> > > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > > usages
> > >
> > > On Sat, 11 Nov 2023 at 04:20, Chiu, Chasel <chasel.chiu@intel.com> wr=
ote:
> > > >
> > > >
> > > > Just sharing some usage examples from UEFI/EDK2 scenario.
> > > > To support ACPI S4/Hibernation, memory map must be consistent befor=
e
> > > > entering and after resuming from S4, in this case payload may need =
to
> > > > know previous memory map from bootloader (currently generic payload
> > > > cannot access platform/bootloader specific non-volatile data, thus
> > > > could not save/restore memory map information)
> > >
> > > So how would EDK2 reconstruct the entire EFI memory map from just the=
se
> > > unannotated /reserved-memory nodes? The EFI memory map contains much
> > > more information than that, and all of it has to match the pre-hibern=
ate situation,
> > > right? Can you given an example?
> >
> >
> > Here we listed only typically memory types that may change cross differ=
ent platforms.
> > Reserved memory type already can be handled by reserved-memory node, an=
d rest of the types usually no need to change cross platforms thus currentl=
y we could rely on default in generic payload.
> > In the future if we see a need to add new memory types we will discuss =
and add it to FDT schema.
> >
> >
> >
> > >
> > > > Another usage is to support binary model which generic payload is a=
 prebuilt
> > > binary compatible for all platforms/configurations, however the paylo=
ad default
> > > memory map might not always work for all the configurations and we wa=
nt to
> > > allow bootloader to override payload default memory map without recom=
piling.
> > > >
> > >
> > > Agreed. But can you explain how a EDK2 payload might make meaningful =
use of
> > > 'runtime-code' regions provided via DT  by the non-EDK2 platform init=
? Can you
> > > give an example?
> >
> >
> > Runtime-code/data is used by UEFI payload for booting UEFI OS which req=
uired UEFI runtime services.
> > Platform Init will select some regions from the usable memory and assig=
n it to runtime-code/data for UPL to consume. Or assign same runtime-code/d=
ata from previous boot.
> > If UEFI OS is not supported, PlatformInit may not need to provide runti=
me-code/data regions to payload. (always providing runtime-code/data should=
 be supported too)
> >
> >
> > >
> > > > Under below assumption:
> > > >         FDT OS impact has been evaluated and taken care by relevant
> > > experts/stakeholders.
> > > > Reviewed-by: Chasel Chiu <chasel.chiu@intel.com>
> > > >
> > >
> > > I am sorry but I don't know what 'FDT OS impact' means. We are talkin=
g about a
> > > firmware-to-firmware abstraction that has the potential to leak into =
the OS
> > > visible interface.
> > >
> > > I am a maintainer in the Tianocore project myself, so it would help i=
f you could
> > > explain who these relevant experts and stakeholders are. Was this dis=
cussed on
> > > the edk2-devel mailing list? If so, apologies for missing it but I ma=
y not have been
> > > cc'ed perhaps?
> >
> >
> >
> >
> > I'm not familiar with FDT OS, also I do not know if who from edk2-devel=
 were supporting FDT OS, I think Simon might be able to connect FDT OS expe=
rts/stakeholders.
> > We are mostly focusing on payload firmware phase implementation in edk2=
 (and other payloads too), however, since we have aligned the payload FDT a=
nd OS FDT months ago, I'm assuming FDT OS impact must be there and we need =
(or already done?) FDT OS experts to support it. (again, maybe Simon could =
share more information about FDT OS)
> >
> > In edk2 such FDT schema is UefiPayloadPkg internal usage only and paylo=
ad entry will convert FDT into HOB thus we expected the most of the edk2 ge=
neric code are no-touch/no impact, that's why we only had small group (Uefi=
PayloadPkg) discussion.
> > Ard, if you are aware of any edk2 code that's for supporting FDT OS, pl=
ease let us know and we can discuss if those code were impacted or not.
>
> We discussed this and just to clarify, 'FDT OS' is not a special OS,
> it is just Linux.
>
> So, with the above, are we all on the same page? Can the patch be
> applied, perhaps? If not, what other discussion is needed?
>

An example of how a platform-init/payload combination would make
meaningful use of such runtime-code/data regions.
