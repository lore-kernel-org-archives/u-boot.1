Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDB6C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 10:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19F1878EE;
	Tue, 26 Dec 2023 11:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nzdv/9V3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B805D878EA; Tue, 26 Dec 2023 11:20:40 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B874C878EE
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 11:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7ccdb4b764cso188573241.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 02:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703586036; x=1704190836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwDh/R1uZbwZ2lOFQdSFxIywPwY7KDMNpmc4GOsCeVM=;
 b=Nzdv/9V3vidPEa28U+/mx9r7lmk2PPlLoF7MDs5t8QvdM8CIttJXvq5o5NNFHzI94x
 o/f6qCysgnE6vjPWkZ8khMgmUQDZrYp+85lWDolElL4w1DfrUjkDTin4Dl81oIDBoeEx
 MG2Z7nDeArRzdiWbroJqxUOz8vcS6AJO2jFTap3LDdFJZqcH6ZljuusPSp5r3lm2C3fD
 0DpAq9DK1pR+piPhfdzxg+r/vkbaj7uYpN20ZZ2dBJC9JiOR+1X7OMZZsrGWld8C6olH
 /CyqdsozLdAQc/ikqruFjOvAsgq0wvLXDPE/fUjwRD1RCNKjNXy9StYXHQY+rhBVAFcH
 V5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703586036; x=1704190836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwDh/R1uZbwZ2lOFQdSFxIywPwY7KDMNpmc4GOsCeVM=;
 b=k48VOShklsdRUXrGZ8+zSDMXB3R9bo36++wzq3B+2NAvBSF60uQbgV/kWRmGSS9H4x
 WXXlGzJ3NKIAALGWQB80yvldgdbTyCX+WubfZKhhPRmlpNPYYDZhsl7lFXkXZgHdM3Yn
 61OXqwC1RyxarLSld7JjzPAw9UYk8vCzIZQWKf1pmk5XCzGlRbVtnpc0MMRoFhQT1uIe
 iwXBn84gv28j3pVdFrgNtpfTP47ZnWeYdUNtuisn4NTcbwC68VjvKTAIMwn++CVHK1kH
 n1fGvgeJExopnB22ReHJcLsTzTxUUOwkxLZlWOepPTo/pBOXebjM/fvVpUZsl+SIFEv7
 0nhA==
X-Gm-Message-State: AOJu0YzcSG6C1iHBGiBLQuTee6WZzihY7HsxHPadIm+VHO8dAtulM18U
 QdNWABiV5ze/tw7/IWblTKk9vrK83B5lO4+02lIpjqSCP/qJUQ==
X-Google-Smtp-Source: AGHT+IES95DXy7hQgwJRNGe0pyPLqExEonzw5FpjBcQ1aTbx/LQJBoPsoXTNR/EF+DMDG+XLWaASBJbBg0tgFW7BfQk=
X-Received: by 2002:a05:6102:e13:b0:465:ddb9:79f2 with SMTP id
 o19-20020a0561020e1300b00465ddb979f2mr2355985vst.24.1703586035721; Tue, 26
 Dec 2023 02:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-5-sumit.garg@linaro.org>
 <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
 <CAFA6WYMeLoD_z1W+iK3C6yj44dO_pdM71bhd6gK14gB==75gxw@mail.gmail.com>
 <CAFLszTgnOHQJGin-=32syDVPAkLXAni7QFd3WV_xtW0a2D84Bg@mail.gmail.com>
In-Reply-To: <CAFLszTgnOHQJGin-=32syDVPAkLXAni7QFd3WV_xtW0a2D84Bg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:50:23 +0530
Message-ID: <CAFA6WYO6Q9s0x+-N0XV+Hyw-07nuwR8ib9-p4=P15JHccb5avw@mail.gmail.com>
Subject: Re: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Wed, Dec 20, 2023 at 12:01=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > Hi Simon,
> >
> > On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > > >
> > > > Allow platform owners to mirror devicetree files from devitree-reba=
sing
> > > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). =
Then
> > > > build then along with any *-u-boot.dtsi file present in arch/$(ARCH=
)/dts
> > > > directory.
> > >
> > > Also add a new Makefile for arm64.
> >
> > I suppose you are referring to dts/arch/arm64/Makefile which has been
> > added by this patch.
>
> Yes, I just mean that you should mention this in the commit message
>

Okay, I will append the commit message.

> >
> > >
> > > >
> > > > This will help easy migration for platforms which currently are com=
pliant
> > > > with upstream Linux kernel devicetree files.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  dts/Kconfig             | 11 +++++++++++
> > > >  dts/Makefile            | 17 ++++++++++++++---
> > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > >  create mode 100644 dts/arch/arm64/Makefile
> > > >
> > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > index 00c0aeff893..96396f12b67 100644
> > > > --- a/dts/Kconfig
> > > > +++ b/dts/Kconfig
> > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > >           enables a live tree which is available after relocation,
> > > >           and can be adjusted as needed.
> > > >
> > > > +config OF_UPSTREAM
> > > > +       bool "Enable use of devicetree imported from Linux kernel r=
elease"
> > > > +       help
> > > > +         Traditionally, U-boot platforms used to have their custom=
 devicetree
> > >
> > > U-Boot
> > >
> > > (I think I mentioned this, but you thought I said U-boot...but it
> > > really is U-Boot). Perhaps grep your patches next time.
> >
> > Ah, I see. It looks like I missed that bit, and will take care of it
> > in the next revision.
> >
> > >
> > > > +         files or copy devicetree files from Linux kernel which ar=
e hard to
> > > > +         maintain and can usually get out-of-sync from Linux kerne=
l. This
> > > > +         option enables platforms to migrate to devicetree-rebasin=
g repo where
> > > > +         a regular sync will be maintained every major Linux kerne=
l release
> > > > +         cycle. However, platforms can still have some custom u-bo=
ot specific
> > > > +         bits maintained as part of *-u-boot.dtsi files.
> > >
> > > I'm a bit nervous about this. It means that boards chose between this
> > > dir of the local files. It means there is some effort to switch.
> > >
> > > I wonder if we could default to using the rebasing thing, with boards
> > > having to 'opt out'? So this should be 'default y' ?
> >
> > Ideally that should be our migration path going forward once we get
> > enough boards migrated to use rebasing repo. But at this initial stage
> > we have to put some effort on migrating boards to use rebasing
> > subtree, although effort should be just adding (given DT bindings
> > compliance) following to defconfig (see patch #7):
> >
> > CONFIG_OF_UPSTREAM=3Dy
> > CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> >
> > and create a mirrored copy of:
> > ../../../devicetree-rebasing/src/arm64/amlogic/ into
> > dts/arch/arm64/amlogic/ with modifications to add targets to
> > dts/arch/arm64/Makefile.
> >
> > I am happy to put in that effort but certainly for new board support
> > that would like to import DT from Linux it should be the default. That
> > stands true for the Qcom platform series for which Caleb is currently
> > working on.
>
> The problem I see is that this is board-by-board, so will never
> happen. Changing one board (e.g. rockpro64-rk3399) typically involves
> changing the .dtsi files it includes (e.g. rk3399.dtsi) so it is
> hard/impossible to do one board without doing all.
>
> So this is why I believe the setting should be on an SoC basis, not on
> a board basis.

Sure, I will enable OF_UPSTREAM on a per SoC basis.

>
> >
> > >
> > >
> > > > +
> > > >  choice
> > > >         prompt "Provider of DTB for DT control"
> > > >         depends on OF_CONTROL
> > > > diff --git a/dts/Makefile b/dts/Makefile
> > > > index 3437e54033d..8098bf8191a 100644
> > > > --- a/dts/Makefile
> > > > +++ b/dts/Makefile
> > > > @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
> > > >  DEVICE_TREE :=3D unset
> > > >  endif
> > > >
> > > > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > > > +ifeq ($(CONFIG_ARM64),y)
> > > > +DEVICE_TREE_LOC :=3D dts/arch/arm64
> > >
> > > dt_dir ?
> >
> > Okay I will rename it.
> >
> > >
> > > Should we move the arm64 DTs to arch/arm64 ?
> >
> > IMO, the migration path should be to use rebasing subtree via
> > dts/arch/arm64/ and dropping DTs except *-u-boot.dtsi from
> > arch/$(ARCH)/dts. So moving DTs from arch/arm/ to arch/arm64/ seems
> > like a redundant change to me.
>
> I can see that argument, but having two different directory structures
> would be confusing.

I can see your point but U-Boot arch arm64 code is also contained in
arch/arm/. However, I would suggest first migrating to DT rebasing and
then we can do a move for the leftovers (*-u-boot.dtsi and such). A
double move won't add much value.

-Sumit

>
> >
> > >
> > > What about the subdirs used in Linux?
> >
> > I hope I have described above regarding how subdirs are mirrored.
> > However, have a look at patch #7 for the amlogic/ subdir example.
>
> OK
>
> Regards,
> Simon
