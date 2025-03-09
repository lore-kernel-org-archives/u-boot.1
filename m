Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9533CC28B2F
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 15:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA4A8043C;
	Sun,  9 Mar 2025 16:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jZrSQE/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05396809A4; Sun,  9 Mar 2025 15:37:09 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D794801DE
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 15:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6fd82a1186bso3391347b3.2
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741531025; x=1742135825; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isGgCpOVcvwT185Ky3Aw8QynpUf5mQyPBBjMMB7kLDU=;
 b=jZrSQE/qxWjBwbfMeRl6WC4KJdORkqQHHIgu6dAVGEcDJ7Zg5EiXDoeXApiUsqTFja
 Jt0h/rBKi4DFZKz3+r0+LzCELEFiCqftdpbrtcSwPWsnWQwXA1oXXy1JCsxvp/bbtt4E
 /QpDaEfFto787juFW78qe3MaeO/GeT5sL9EKNfAH7qqo+JwVzwQ9INZFMwo/N4mGKPVE
 aDTI4Z2Hvahu3O8uJYjDfy92oiv0ztxa8HeGrm7oM78ih16SJkLxjT3OUnH+6T9/4eeY
 iL3021Pvw6IXyFJiYt9lh0ZBrhQ9SxEmDw7G0DaItSGffHxYIudeaS3711w+qukJn22a
 o4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741531025; x=1742135825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isGgCpOVcvwT185Ky3Aw8QynpUf5mQyPBBjMMB7kLDU=;
 b=gxdRpmiQ5rdWQ7G9WCvqXVUR5/8de/276EA4cRoIw1qTF9HR+SnXKCwHf+SxONWzjG
 LAm4yp93YIHn2/ydC83zgjDT/rbiEgSCz+uqZTuu2L0+C6YBPQBuKxhPe6D5QOenD0U6
 OXCYkptG3v3L1UEdldCF0BN0F/V6raTAvp3j5Lvv2vxdrgrfPmdCcqYA94BQsLlCehIr
 lT6RujNIW5jX9UmmfwYqJygVIDitpXqSTTxlT+ZVKYYMxcI5DsNGXmWpYIQP9n1aVrss
 JPSaGQz7H2KY5NYUOAgAHFdYMkp+Xa42XHr62E3rA5S4+KrGf5mkYEtnebPe9KLAUtiX
 74nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7IZzsXdohaKhyJdBlTqIWv+pRftj4kJiXaywLtBBLouaTRcE3paFf57XLrU2OdUe/hFeJt7s=@lists.denx.de
X-Gm-Message-State: AOJu0YwhHu6dRjnUg3g7/96EltvOetWAueLD32HvyJtMP573uIbYcaG5
 Q1SKdtm5bPBvU+C209LscdMbAT+LaNKL+pWAZJpNpQg9ZGGNKXSjim6WrqtRCD2vzFE+Hc8Lw+7
 htWcp/ppA5qPBcismHJwJ0eFjO/w=
X-Gm-Gg: ASbGncs0/Vo9xyPj2S2Twu9RDlfFZPbJ2NN5Teqb3wCw9dK6LMlmtBp9Oo28TnmyQPH
 LUE1VpGpKIPofuPIsnSWBB47kvaBqdYe5DJMf9NlmFeaVh3u5NJgoe/STYbVoQoaJhF8Gs7j3Ho
 XpLHfNvIWgWFY516BNc+Iuo1AtrTdjSdEZ7oKQ
X-Google-Smtp-Source: AGHT+IH3UEoubVOk9xUi70GnjfTSWbEp/ZRfBrUZPA+An3Rv+ZYCPX7a0pPHExVQ09ACBFbW/kkhUh0aiAuSuN+x15k=
X-Received: by 2002:a05:6902:330f:b0:e58:1112:c3d3 with SMTP id
 3f1490d57ef6-e6371da30c7mr2502783276.4.1741531025287; Sun, 09 Mar 2025
 07:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241026155220.26300-1-l.rubusch@gmail.com>
 <20241026155220.26300-4-l.rubusch@gmail.com>
 <DM8PR11MB5592B8B7BEB3B45165FD8EECD2E62@DM8PR11MB5592.namprd11.prod.outlook.com>
 <CAFXKEHYGUodqYn0WaVy=b_i+U00qp+isDv_6xu1nWWNGKxbaQg@mail.gmail.com>
 <DM8PR11MB5592F2CD9F1EE6C9C65FC611D2C92@DM8PR11MB5592.namprd11.prod.outlook.com>
 <SN6PR03MB35833692C72A3AFBD22383BCA7C92@SN6PR03MB3583.namprd03.prod.outlook.com>
In-Reply-To: <SN6PR03MB35833692C72A3AFBD22383BCA7C92@SN6PR03MB3583.namprd03.prod.outlook.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 9 Mar 2025 15:36:29 +0100
X-Gm-Features: AQ5f1JoG0b8Sjvu43rXFnmxgV8fm2xHzv3QFTMHmKO3xFvWfY-RGSrXQR5sNnPw
Message-ID: <CAFXKEHaArbTS7AWJ4tgDSv2unWeK9=Korh_661v=FBJEA-Qo2A@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u-boot
 dts
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "trini@konsulko.com" <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>, 
 "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>, 
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "michal.simek@amd.com" <michal.simek@amd.com>, 
 "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "barnas@google.com" <barnas@google.com>, 
 "Ang, Tien Sung" <tien.sung.ang@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 09 Mar 2025 16:02:09 +0100
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

Dear Tien Fong, thank you so much. Please find my answer inlined below.

On Mon, Mar 3, 2025 at 4:35=E2=80=AFAM Chee, Tien Fong
<tien.fong.chee@altera.com> wrote:
>
> Dear Lothar,
>
> > -----Original Message-----
> > From: Chee, Tien Fong <tien.fong.chee@intel.com>
> > Sent: Monday, March 3, 2025 11:05 AM
> > To: Lothar Rubusch <l.rubusch@gmail.com>
> > Cc: u-boot@lists.denx.de; trini@konsulko.com; marex@denx.de;
> > simon.k.r.goldschmidt@gmail.com; sumit.garg@linaro.org;
> > sjg@chromium.org; xypron.glpk@gmx.de; michal.simek@amd.com; Lim, Jit
> > Loon <jit.loon.lim@intel.com>; barnas@google.com; Chee, Tien Fong
> > <tien.fong.chee@altera.com>
> > Subject: RE: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u=
-
> > boot dts
> >
> >
> >
> > -----Original Message-----
> > From: Lothar Rubusch <l.rubusch@gmail.com>
> > Sent: Monday, January 27, 2025 6:24 PM
> > To: Chee, Tien Fong <tien.fong.chee@intel.com>
> > Cc: u-boot@lists.denx.de; trini@konsulko.com; marex@denx.de;
> > simon.k.r.goldschmidt@gmail.com; sumit.garg@linaro.org;
> > sjg@chromium.org; xypron.glpk@gmx.de; michal.simek@amd.com; Lim, Jit
> > Loon <jit.loon.lim@intel.com>; barnas@google.com
> > Subject: Re: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u=
-
> > boot dts
> >
> > On Tue, Jan 21, 2025 at 11:03=E2=80=AFAM Chee, Tien Fong <tien.fong.che=
e@intel.com>
> > wrote:
> > >
> > > Hi,
> > >
> >
> > Dear Tien Fong Chee,
> >
> > > -----Original Message-----
> > > From: Lothar Rubusch <l.rubusch@gmail.com>
> > > Sent: Saturday, October 26, 2024 11:52 PM
> > > To: u-boot@lists.denx.de; trini@konsulko.com; marex@denx.de;
> > > simon.k.r.goldschmidt@gmail.com; Chee, Tien Fong
> > > <tien.fong.chee@intel.com>; sumit.garg@linaro.org
> > > Cc: sjg@chromium.org; xypron.glpk@gmx.de; michal.simek@amd.com; Lim,
> > > Jit Loon <jit.loon.lim@intel.com>; barnas@google.com;
> > > l.rubusch@gmail.com
> > > Subject: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for
> > > u-boot dts
> > >
> > > Introduce u-boot specific device-tree files for Enclustra Mercury+ AA=
1
> > SoMs (Intel/arria10).
> > >
> > > Generic device-tree fragments for linux and U-boot shall be provided =
in
> > dts/upstream. The selection of the generic device-tree fragments depend=
s
> > on a selected boot-mode and a selected carrier board.
> > >
> > > On Intel/Arria10 a handoff setup is needed for initialization of vari=
ous clock
> > / pinmux / DRAM settings only used by U-Boot provided by the current pa=
tch.
> > >
> > > Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  ..._arria10_enclustra_mercury_aa1-u-boot.dtsi |  45
> > +++  .../socfpga_arria10_enclustra_mercury_aa1.dts |  45 +++
> > >  .../socfpga_arria10_mercury_aa1-u-boot.dtsi   |  19 ++
> > >  .../dts/socfpga_arria10_mercury_aa1_handoff.h | 305
> > ++++++++++++++++++
> > >  board/enclustra/mercury_aa1/Kconfig           |  37 +++
> > >  board/enclustra/mercury_aa1/MAINTAINERS       |   2 +
> > >  6 files changed, 453 insertions(+)
> > >  create mode 100644
> > > arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
> > >  create mode 100644
> > > arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
> > >  create mode 100644
> > arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
> > >
> > > diff --git
> > > a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
> > > b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
> > > new file mode 100644
> > > index 0000000000..6e38286572
> > > --- /dev/null
> > > +++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
> > > @@ -0,0 +1,45 @@
> > > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > > +/*
> > > + * Copyright (C) 2024 Lothar Rubusch <l.rubusch@gmail.com>  */
> > > +
> > > +/* Arria10 handoff (u-boot) */
> > > +#include "socfpga_arria10_mercury_aa1_handoff.h"
> > > +#include "socfpga_arria10-handoff.dtsi"
> > > +#include "socfpga_arria10_handoff_u-boot.dtsi"
> > > +#include "socfpga_arria10_mercury_aa1-u-boot.dtsi"
> > > +
> > > +/* Specific boot-mode (u-boot) */
> > > +#if IS_ENABLED(CONFIG_ENCLUSTRA_SDMMC) ||
> > > +IS_ENABLED(CONFIG_ENCLUSTRA_EMMC)
> > > +
> > > +/ {
> > > +       fs_loader0: fs-loader {
> > > +               bootph-all;
> > > +               compatible =3D "u-boot,fs-loader";
> > > +               phandlepart =3D <&mmc 1>;
> > > +       };
> > > +};
> > > +
> > > +&fpga_mgr {
> > > +       bootph-all;
> > > +       firmware-loader =3D <&fs_loader0>;
> > > +       altr,bitstream =3D "fpga.itb";
> > > +};
> > > +
> > > +#elif IS_ENABLED(CONFIG_ENCLUSTRA_QSPI)
> > > +
> > > +/ {
> > > +       fs_loader0: fs-loader {
> > > +               bootph-all;
> > > +               compatible =3D "u-boot,fs-loader";
> > > +               sfconfig =3D <0 0 50000000 3>;
> > >
> > > The RAW read implementation in fs_loader is not upstream yet, I afrai=
d this
> > might not working, you want help to upstream?
> > >
> >
> > Thank you so much for coming back to me! The TL;DR answer is, yes.
> > Pls, start by fixing Intel platform maintenance in the Linux kernel for=
 old
> > Intel/socfpga.
> >
> > For the long story, there are several points here which are probably no=
t quite
> > transparent just on u-boot ML. Let me clarify. Personally, I have acces=
s to
> > some Enclustra hardware and was curious what it would take to upstream =
it.
> > This was/is driven mainly by my private interest, since the company giv=
es
> > a ...does not care about open source. As you will easily spot those Int=
el
> > platforms are not the most recent Intel products either. I picked them =
a bit
> > on purpose, since I did not want to "mess it up" for that company with =
my
> > personal upstream in the first approach. If it went upstream, it could =
be the
> > basis for further Enclustra Hardware i.e. Xilinx/AMD, Microchip and mor=
e
> > recent Intel.
> > That's a bit the background and intention.
> >
> > So, when I started last summer, u-boot community stared with dts upstre=
am.
> > Means, my DTS material needed to be prepared and split up into a linux
> > kernel part and a u-boot part. Due to the bitstream handling and early
> > initialization of registers, also, the u-boot DTS went partly into dts-=
upstream,
> > and partly into the classic DTS places for he intel/socfpga platform. I=
 managed
> > to implement a dynamically adjusted Enclustra DTS, based kconfig option=
. At
> > the end of the day, this all resulted in the dependency to have DTS mat=
erial
> > upstream in the linux kernel repo.
> >
> > Both patchsets were actually prepared and presented on the MLs. For u-
> > boot, you will find all communication concerning the u-boot patches her=
e on
> > this ML. Where for the kernel patches, I got the more general patches A=
CK'd.
> > But the Intel maintainer Dinh Nguyen did not manage to give feedback. I=
 was
> > even able to contact Dinh directly, and he gave me back that he plans o=
n
> > doing. This was in fall 2024. No update since then. - Here is, IMHO, wh=
ere you
> > Intel guys could really help work on solving this situation: Either hel=
p out Dinh
> > for the kernel stuff, or organize replacement. Don't get me wrong, this=
 is not
> > meant to be personal. I'm sure he will have good reasons if he cannot c=
arry
> > out this job currently. Means put up someone who will (co-)maintain the=
 old
> > Intel platforms in the Linux kernel. Also, the Intel/socfpga dt-binding=
s need
> > to be written in YAML, AFAIR. That's why e.g. Rob's DT-check bot will a=
lmost
> > blast you with errors with the comment "can be accepted if the specific
> > platform maintainer is willing to".
> > Platform maintainer does not answer, and I'm not willing writing the YA=
ML
> > dt-bindings for ye olde Intel, when there is no maintainer eventually
> > accepting it.. Hence, accepting the Enclustra Intel DTS, would mean to =
accept
> > them w/o the updated and checked dt-bindings.
> >
> > For the (technical) rest: I have full access to the hardware, i.e. 3 di=
fferent
> > Arria10 SOMs of Enclustra, as 2 further Cyclone5 SOMs. All can be combi=
ned
> > with 3 different carrier boards of Enclustra. The setups are booting in
> > different boot modes (SD, eMMC and some from QSPI flash). After the DTS
> > separation, (re)implementing the mini-drivers based on u-boot DM, I
> > needed to migrate the setup using binman. Building, flashing and bootin=
g
> > into a functional u-boot, is verified for all setups. As you mentioned,=
 parts in
> > the u-boot API are/were still under development, though, but Marek kept
> > me in the loop here (also on ML).
> >
> > I appreciate your patience, for reading this all. In a conclusion, the =
products
> > are still sold. Yes, they are a bit ancient.. what eventually blocked i=
t, is IMHO
> > rather kenel maintenance for old Intel platforms which seems orphaned. =
For
> > me personally, it already paid off a lot from what I could learn! - Yes=
, I'd love
> > to see the stuff upstream.
> > There seems to be less love by Intel, though, for its socfpga platforms=
 on
> > Linux. ;)
>
> Sorry for the late response, I have been following up on this with Kernel=
 team, the transferring ownership is already kicking off, probably Q3 at th=
e earliest. The team is also working on upstreaming the fixes to schema che=
ck failures, primarily converting old text version of device tree bindings =
to yaml.
>
> I will update more once I have more information from them.

Tien Fong, I highly appreciate coming back to me and letting me know.

Is there a possibility to contribute and help out converting old text
files to YAML and/or fixing the schema check failures? This is a huge
possibility for me to learn. If so, just let me know, who would be
maintainer to be put in CC for the patches (probably mostly on kernel
side).

Anyway, let's see during the year.
Best regards,
L

>
> Thanks.
>
> Best regards,
> Tien Fong
>
> >
> > Best,
> > L
> >
> >
> > > [...]
> > >
> > > Best regards,
> > > TF
