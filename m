Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2FBD6D22E
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 15:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F7083DEE;
	Thu, 18 Dec 2025 16:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d7eWjDLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7374683E21; Thu, 18 Dec 2025 16:03:04 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E6983DE4
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 16:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78e7cfd782aso6031747b3.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766070179; x=1766674979; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gu0vdhcHChm9g7IpJld7/CqnvFxY8y+ABgkNcRGUgNA=;
 b=d7eWjDLh0dzr2JPcJCG6KIwYX3lbASaKHaAmYt/H8cG2N377qq0kvg0HQPqH8i8Mie
 ClcfOJ1jNgzGpM1iPXLQom38wMghSeCQnXUhY8BtqVxgzN1wVMj2iit/AevyYsa4058R
 E3ok6h9lpTOS1KB5+6sdBkv7NH06wR8znL8R7mRKs8gINjHS3jRLcpvC8LR661CtrCOX
 baId9n5YONI2y2DVA/9QzxPEf5rPZFqxB0ZMXqRmhdwbE9FsjzIorgc6z8TVPP98le+B
 a6Xt8l6o+rUdLJzJPHpKCGS/ko42R1bg2U5hQmXh7oaW44pxg0p05HZhevXIKWB5KfLX
 U5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766070179; x=1766674979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gu0vdhcHChm9g7IpJld7/CqnvFxY8y+ABgkNcRGUgNA=;
 b=Q9TKbzcgCqN3DCRmiTqsOIIVr3xUbMLztdz1a4iNaJ7seJjaNyQUzzROLvwI8d3ZLj
 CU3nbyA7eQf8P0nPadmbvAM+h5jp03phom/h6l4+8EiwsKF5TM8PfI/elLU1r0FmNnB9
 AKdMameVOZtObtkq8c5/3lryj7A8khqLcvHc3lblBN8dFELpBByJY1e8o6pvOKYfOkva
 d09ZYqcA9Gy0+bomQps0ihYRwJOJ0EtnAo2Rxq3EY899DrqdcURLN7jTQy72eZuH2GJB
 c9tmkd6S8lIwb6HkZuKD8AN8Wz2RyCp4b5IO/KRSpdX6jDwWPbuLI6dbtW/J/OdL+kpI
 xt8w==
X-Gm-Message-State: AOJu0Yz8SVhbdMjJ9nbSQ1xz45MoEIM1hCanxofTNxO7ZxS1hIqhic69
 Wza8b/YGRBcx193EBL8CxCUrSEOKfHOK5taAPbGNqHAbxcRHtxTv48kff1Ev10QQinw9KJzE4xL
 uTdJs0lZEPYRrR+yNLWeN8RB8GmZVQ84PL2E5BNXXeQ==
X-Gm-Gg: AY/fxX7UKBTLYKRduWMY/HGfSu2S9au7D415di0dE/vFIpcK44Z8tTureTtjzHJMqW7
 2yi8EVs08J40aWbsxmpCPdY4/LL7n1z9TyVXnm205+V3aRLzby/DkALRrkTbJ6lX7vQeOmhMV7J
 ZpMTMEnrIfkMFgMqnRggipeMUuhVt3OKaQ1OvEFZH/ASXD8iHjXqsPC4hgXYrLhdTgUTMoQBVm7
 A5rwpWtaO3MDGNd+1WKxrUZyfpAKk8jh3ldGS9D+HVy9ZXThrCkgAhJhyR9d0naI6bidr/BfnvD
 Cj7OXU8tKKPn7UfWIS7f5H3DVPm98anK0onO4XcyFX3uLjmFQvBucldlRHvW9NkQB2QnUlwlLfP
 aWpArQjqiuPSzMhXKjBkV3cZsUdxUquqoDHW0owD5AZ53i/fCN3gTM7EIjqSB9X9XavFWNKYOzD
 x8bSf4M6PTyCbYZYw9h9P1IJsXD5pN9Ue27/iqAPfu1kDzYE8cHF9kTtbAR0DDE/U8Jw1Dwh+CA
 6OJny8sLiKYgpDJr8qAPV48U8Idjw4Hp4en+wpcnNgfuHw/7y2MgKbH6OZczi95FRamJixTuQez
 fPVeH9CCpEEldFRWwCf4VrcNlgEbX78=
X-Google-Smtp-Source: AGHT+IFc51+GT4YtJj15SPxqs5yeCYCAfOI6Amxy22IKnmH3z6/+qwDvwH0L/atCRT12tPOnQ9/PFGQh2BplnAja5BU=
X-Received: by 2002:a05:690e:1405:b0:63f:abf6:1c9 with SMTP id
 956f58d0204a3-645555e893dmr15912752d50.25.1766070177813; Thu, 18 Dec 2025
 07:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
 <CAC_iWjLT1OJxADQ5bZaz_E7shWbGUJSnDQK7_dQM7agOKEvK0A@mail.gmail.com>
 <20251218144902.62ca232b@kmaincent-XPS-13-7390>
In-Reply-To: <20251218144902.62ca232b@kmaincent-XPS-13-7390>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Dec 2025 17:02:21 +0200
X-Gm-Features: AQt7F2rYoMJKuJ8RLqOal8FFFr7k342Equy0l1CydZUi2eI0gGW_eGFI4U06CgM
Message-ID: <CAC_iWjKmPDxupZ2pP-ZouxsOLPWKdo7pkgPgR4VFgOjnt=BQiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Add support for fwumdata
To: Kory Maincent <kory.maincent@bootlin.com>,
 Jose Marinho <Jose.Marinho@arm.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>
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

Hi Kory,

+CC Jose who maintains the spec from Arm

On Thu, 18 Dec 2025 at 15:49, Kory Maincent <kory.maincent@bootlin.com> wro=
te:
>
> Hello Ilias,
>
> On Thu, 18 Dec 2025 14:04:12 +0200
> Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>
> > Hi Kory,
> >
> > I haven't lost track of this, I'll try to have a look as soon as I can.
> > For the record, I still don't think this is a great idea. I'd rather
> > have people follow the design docs.
>
> I don't get it. What are your arguments against this tool? It is a simple=
 way
> to change the content of the FWU metadata from Linux.

DEN0118 doesn't explicitly require UEFI. However,  the Arm
architecture is officially supporting the EFI spec. Even from a Linux
kernel perspective, booting with EFI is encouraged. There is certain
functionality you don't get without EFI. On top, there are
manufacturers that keep the metadata in the secure world. I understand
that the tool is a handy way to change that from Linux.

>
> > I understand the acceptance capsule feels 'weird', but there was a
> > good reason for it. There's a PR with an update to the spec, which
> > makes the acceptance substantially easier now that all the ecosystem
> > parts are in place [0[
> >
> > [0] https://github.com/ARM-software/edge-iot-arch-guide/pull/21
>
> This design guideline is for one use case of FWU Metadata. It needs UEFI =
and
> capsule update.
>
> FWU Metadata is an update standard for ARM architecture, it is not depend=
ent on
> the implementation. UEFI with capsule update is one implementation, but w=
e could
> have others.
> https://documentation-service.arm.com/static/660be6391bc22b03bca92702

I've been involved in the document design since the beginning and the
primary goal was to consume this via EFI & capsules. That's why that
second document(MBFW) I pointed to exists.

>
> On my case (ST board) there is no UEFI, I have TF-A (FSBL) that reads the=
 FWU
> metadata to know the location of the FIP Image (SSBL which contain U-boot=
 and
> OPTEE).
> During the OTA process, Linux is updating the FWU metadata to change the =
active
> bank and the bank state with this new fwumdata tool.
>
> Note that the previous development of FWU support in U-boot as not been
> developed in a generic way but bound to the UEFI capsule framework which =
is not
> ideal.

Yes, that was on purpose, I reviewed and helped in most of that.

> On my case if I want to read FWU metadata in U-boot I have to enable the
> UEFI capsule config for nothing.

That's ok. That's an ST call, but I am merely trying to explain the
reasoning behind the two specs

Regards
/Ilias
>
> Regards,
>
> >
> > Cheers
> > /Ilias
> >
> > On Fri, 12 Dec 2025 at 18:23, Kory Maincent <kory.maincent@bootlin.com>=
 wrote:
> > >
> > > Add a new fwumdata tool to allows users to read, display, and modify =
FWU
> > > (Firmware Update) metadata from Linux userspace. It provides function=
ality
> > > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > > metadata, change active/previous bank indices, modify bank states, an=
d set
> > > image acceptance flags. Configuration is done via fwumdata.config fil=
e.
> > >
> > > Made a few change to mkfwumdata tool along the way.
> > >
> > > Here is an output example
> > >
> > > $ ./fwumdata -l
> > > FWU Metadata:
> > >         Version:            2
> > >         Active Index:       0
> > >         Previous Index:     1
> > >         CRC32:              0x1f21ff7b
> > >         Metadata Size:      120 bytes
> > >         Descriptor Offset:  32
> > >         Bank States:
> > >                 Bank 0: accepted (0xfc)
> > >                 Bank 1: accepted (0xfc)
> > >
> > >         Firmware Store Descriptor:
> > >                 Number of Banks:       2
> > >                 Number of Images:      1
> > >                 Image Entry Size:      80
> > >                 Bank Info Entry Size:  24
> > >
> > >         Images:
> > >                 Image 0:
> > >                         Image Type GUID:
> > > 65ae85ad-1fb3-0b46-8c5d-285543aa6eab Location GUID:
> > > 51513491-da07-2a4f-9bea-375ea53b1b5c Banks:
> > >                                 Bank 0:
> > >                                         Image GUID:
> > > cb2df442-f929-6a44-a374-672d92eb2aa7 Accepted:    yes (1)
> > >                                 Bank 1:
> > >                                         Image GUID:
> > > a839a18f-395c-484f-83b8-0354077c8f9f Accepted:    yes (1)
> > >
> > > Changes in v2:
> > > - Fix a small offset mistake in last patch
> > >
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---
> > > Kory Maincent (6):
> > >       tools: gitignore: Add mkfwumdata to the git ignore file
> > >       tools: Reorganize mkfwumdata tool into fwumdata_src directory
> > >       tools: mkfwumdata: Improve error message specificity
> > >       tools: mkfwumdata: Add bank count validation for FWU metadata v=
2
> > >       tools: Add support for fwumdata tool
> > >       tools: mkfwumdata: Remove dependency on fwu_mdata.h header
> > >
> > >  MAINTAINERS                           |   7 +-
> > >  doc/develop/uefi/fwu_updates.rst      |   4 +-
> > >  doc/fwumdata.1                        | 222 +++++++++
> > >  tools/.gitignore                      |   2 +
> > >  tools/Kconfig                         |   9 +-
> > >  tools/Makefile                        |   4 +-
> > >  tools/fwumdata_src/Kconfig            |  19 +
> > >  tools/fwumdata_src/fwumdata.c         | 854
> > > ++++++++++++++++++++++++++++++++++ tools/fwumdata_src/fwumdata.config=
    |
> > > 33 ++ tools/fwumdata_src/fwumdata.h         | 138 ++++++
> > >  tools/fwumdata_src/fwumdata.mk        |  10 +
> > >  tools/{ =3D> fwumdata_src}/mkfwumdata.c | 106 ++---
> > >  12 files changed, 1315 insertions(+), 93 deletions(-)
> > > ---
> > > base-commit: 31bf4a1c308773895a8e7ea047b3cea037e4c922
> > > change-id: 20251107-feature_fwumdata-58508d61e1d3
> > >
> > > Best regards,
> > > --
> > > K=C3=B6ry Maincent, Bootlin
> > > Embedded Linux and kernel engineering
> > > https://bootlin.com
> > >
>
>
>
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
