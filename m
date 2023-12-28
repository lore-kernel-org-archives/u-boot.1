Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC1EC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0B287A8A;
	Thu, 28 Dec 2023 14:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kCiRdYx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C8487A8E; Thu, 28 Dec 2023 14:37:55 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC82F87A89
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28c7e30c83fso1162504a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770670; x=1704375470; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQFGXpLrk6kSnjFKU1ozfQPXzl29UyLg+epm/ZpWMUs=;
 b=kCiRdYx2ghqBZJL+XGfpCDUeMW71MaU/x+arIk90IGF4lhuyW8ivE5h5O8jmLeK5Gr
 J7GwolqqGwT8pUwG78vGwQ8e5m7Lc5mYNlefH93W8kB3dCXXKn4HqNmDK0QpMdM5AefF
 yk++bZEC8A1k7lNHfxSdjJUY+9b0Fr2+GBnXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770670; x=1704375470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQFGXpLrk6kSnjFKU1ozfQPXzl29UyLg+epm/ZpWMUs=;
 b=dCkwtKoQ2ZY3RfE0gOS3LCrtwi1wTkj8zvk4GSPUlNJZE5CFsrnZscymzRzpPg/9gp
 2fV7P7p375c1wCLtds08iYJCtGt55rsgxbmff1RY/D15VNDQ/tGdIuXa3pbJb+sE5SIq
 3xeft7E/Pj4/5olSnzS9PNiWMW6uCy7BGgRLVToLIvg5apnlqKCqlongq6/ALxjW2Z65
 /3slsdO1v7nVKjGVrfa3hXABdZBC+xd5dlRdZxWzsT9lEhjBC5BV2DfIqq5HPKOS4CcA
 We4nUYE6Gf4nf6wXBWAFLPZNNCkvf8Q+b3CYPp74py+zeCNZVmxDxoEYmBDeNy1iFya/
 34Kg==
X-Gm-Message-State: AOJu0Yy6oZgAKK8kAFVdGJSeZ4qApWHdzlQgex7da09tN/jmOt7t5REl
 HamOPst9+9z/0Z9+ok5le0UGspmi4HI/iEvpppUe1RrUj8Uv
X-Google-Smtp-Source: AGHT+IFsZJrO/VHQntphMGWANN0xKKbMOIfKxR/oUyuYHulsQcR0pMpVjVgmGFqTHxzmy8950SPO+/RLE4luoQ7eSok=
X-Received: by 2002:a17:90a:8b88:b0:28c:a634:e4b9 with SMTP id
 z8-20020a17090a8b8800b0028ca634e4b9mr324745pjn.34.1703770670068; Thu, 28 Dec
 2023 05:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-5-sumit.garg@linaro.org>
 <CAPnjgZ37QMzyVNxd8608dMBXVPed-PAU39CAhOrMRHVedEnSkQ@mail.gmail.com>
 <CAFA6WYMeLoD_z1W+iK3C6yj44dO_pdM71bhd6gK14gB==75gxw@mail.gmail.com>
 <CAFLszTgnOHQJGin-=32syDVPAkLXAni7QFd3WV_xtW0a2D84Bg@mail.gmail.com>
 <CAFA6WYO6Q9s0x+-N0XV+Hyw-07nuwR8ib9-p4=P15JHccb5avw@mail.gmail.com>
In-Reply-To: <CAFA6WYO6Q9s0x+-N0XV+Hyw-07nuwR8ib9-p4=P15JHccb5avw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:18 +0000
Message-ID: <CAFLszTi0DsJQx++de=bLreUtKhnchzH63e=wgF+9WQe+vD6VAQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
To: Sumit Garg <sumit.garg@linaro.org>
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

Hi Sumit,

On Tue, Dec 26, 2023 at 10:20=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Wed, Dec 20, 2023 at 12:01=E2=80=AFPM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wr=
ote:
> > > > >
> > > > > Allow platform owners to mirror devicetree files from devitree-re=
basing
> > > > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64)=
. Then
> > > > > build then along with any *-u-boot.dtsi file present in arch/$(AR=
CH)/dts
> > > > > directory.
> > > >
> > > > Also add a new Makefile for arm64.
> > >
> > > I suppose you are referring to dts/arch/arm64/Makefile which has been
> > > added by this patch.
> >
> > Yes, I just mean that you should mention this in the commit message
> >
>
> Okay, I will append the commit message.
>
> > >
> > > >
> > > > >
> > > > > This will help easy migration for platforms which currently are c=
ompliant
> > > > > with upstream Linux kernel devicetree files.
> > > > >
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >  dts/Kconfig             | 11 +++++++++++
> > > > >  dts/Makefile            | 17 ++++++++++++++---
> > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > >
> > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > index 00c0aeff893..96396f12b67 100644
> > > > > --- a/dts/Kconfig
> > > > > +++ b/dts/Kconfig
> > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > >           enables a live tree which is available after relocation=
,
> > > > >           and can be adjusted as needed.
> > > > >
> > > > > +config OF_UPSTREAM
> > > > > +       bool "Enable use of devicetree imported from Linux kernel=
 release"
> > > > > +       help
> > > > > +         Traditionally, U-boot platforms used to have their cust=
om devicetree
> > > >
> > > > U-Boot
> > > >
> > > > (I think I mentioned this, but you thought I said U-boot...but it
> > > > really is U-Boot). Perhaps grep your patches next time.
> > >
> > > Ah, I see. It looks like I missed that bit, and will take care of it
> > > in the next revision.
> > >
> > > >
> > > > > +         files or copy devicetree files from Linux kernel which =
are hard to
> > > > > +         maintain and can usually get out-of-sync from Linux ker=
nel. This
> > > > > +         option enables platforms to migrate to devicetree-rebas=
ing repo where
> > > > > +         a regular sync will be maintained every major Linux ker=
nel release
> > > > > +         cycle. However, platforms can still have some custom u-=
boot specific
> > > > > +         bits maintained as part of *-u-boot.dtsi files.
> > > >
> > > > I'm a bit nervous about this. It means that boards chose between th=
is
> > > > dir of the local files. It means there is some effort to switch.
> > > >
> > > > I wonder if we could default to using the rebasing thing, with boar=
ds
> > > > having to 'opt out'? So this should be 'default y' ?
> > >
> > > Ideally that should be our migration path going forward once we get
> > > enough boards migrated to use rebasing repo. But at this initial stag=
e
> > > we have to put some effort on migrating boards to use rebasing
> > > subtree, although effort should be just adding (given DT bindings
> > > compliance) following to defconfig (see patch #7):
> > >
> > > CONFIG_OF_UPSTREAM=3Dy
> > > CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> > >
> > > and create a mirrored copy of:
> > > ../../../devicetree-rebasing/src/arm64/amlogic/ into
> > > dts/arch/arm64/amlogic/ with modifications to add targets to
> > > dts/arch/arm64/Makefile.
> > >
> > > I am happy to put in that effort but certainly for new board support
> > > that would like to import DT from Linux it should be the default. Tha=
t
> > > stands true for the Qcom platform series for which Caleb is currently
> > > working on.
> >
> > The problem I see is that this is board-by-board, so will never
> > happen. Changing one board (e.g. rockpro64-rk3399) typically involves
> > changing the .dtsi files it includes (e.g. rk3399.dtsi) so it is
> > hard/impossible to do one board without doing all.
> >
> > So this is why I believe the setting should be on an SoC basis, not on
> > a board basis.
>
> Sure, I will enable OF_UPSTREAM on a per SoC basis.
>
> >
> > >
> > > >
> > > >
> > > > > +
> > > > >  choice
> > > > >         prompt "Provider of DTB for DT control"
> > > > >         depends on OF_CONTROL
> > > > > diff --git a/dts/Makefile b/dts/Makefile
> > > > > index 3437e54033d..8098bf8191a 100644
> > > > > --- a/dts/Makefile
> > > > > +++ b/dts/Makefile
> > > > > @@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
> > > > >  DEVICE_TREE :=3D unset
> > > > >  endif
> > > > >
> > > > > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > > > > +ifeq ($(CONFIG_ARM64),y)
> > > > > +DEVICE_TREE_LOC :=3D dts/arch/arm64
> > > >
> > > > dt_dir ?
> > >
> > > Okay I will rename it.
> > >
> > > >
> > > > Should we move the arm64 DTs to arch/arm64 ?
> > >
> > > IMO, the migration path should be to use rebasing subtree via
> > > dts/arch/arm64/ and dropping DTs except *-u-boot.dtsi from
> > > arch/$(ARCH)/dts. So moving DTs from arch/arm/ to arch/arm64/ seems
> > > like a redundant change to me.
> >
> > I can see that argument, but having two different directory structures
> > would be confusing.
>
> I can see your point but U-Boot arch arm64 code is also contained in
> arch/arm/. However, I would suggest first migrating to DT rebasing and
> then we can do a move for the leftovers (*-u-boot.dtsi and such). A
> double move won't add much value.

OK, so long as you are planning to do that next?

Regards,
Simon
