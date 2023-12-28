Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9CFC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF19387A29;
	Thu, 28 Dec 2023 14:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wagrx3Xb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA87387A29; Thu, 28 Dec 2023 14:37:39 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2735087A01
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cda24a77e0so2159399a12.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770655; x=1704375455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ENGVDTflU/DKfO5ZTkIokNGqLKpQaRZg3/48qkXgKM=;
 b=Wagrx3XbX5wcdiq4YI/uYSIpGbXHIGWXon75hVjXIL5A9HUee0L/GZV35r2crLBNGa
 uruUvMpb722kXerHdR2Y3muLY6Lthrny9IMnACLJ4hhB0LkwGJelH2pzEWrKM42tFAP5
 NVQjIaMl24m560B/ewrvxZ+6/U6Xj/0dOmxoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770655; x=1704375455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ENGVDTflU/DKfO5ZTkIokNGqLKpQaRZg3/48qkXgKM=;
 b=SyU9chQaCOlSqiR4y3Wc2XeFVtN4FXFzraS6uyZMqx2NyP1S1m8Zkc/RisRI+f/MEK
 Bs9nAqn4iEWwonznCawCnm5/upoRa4KZkQz2V75EM2VwsYJrWwqXlwhAafvOOeWExTlH
 3wsnZ4eKPCYISyOcWr/hMKkPmDEPaIlUZm7fb8mDoQZsDqrzqkv/F1ZqU8lKXvRUP1/h
 q5ocjx4lkNQLgiuz6T1ztxeyYnXFTkKOZAvpE/9tEipwbLvxbqMBoympT1fX66Kyintz
 EJrxhPSFFTXQIuZOAEMBjhRhcid219AUvvtxCnSE1/qqZ+nNOZP8r7W660xs8BgcVy97
 fkdQ==
X-Gm-Message-State: AOJu0Yx2jAckLfj4Go1NE8vJOn4Z0vwY7+np5zH9K0z+HVeoajn/TC9Z
 YVkBTKRUCKsZeXM0XYpacAVdw4UNbr4TNhQtPNXBer2LHbd8
X-Google-Smtp-Source: AGHT+IGS6LeeOd1bBV2eH7SmlBnlx0188IwriKBgUWYRFwDWOY9yw6W/2p2m9HFrgqNdC9VQw3gKzR0M4TGrk8/hZ18=
X-Received: by 2002:a17:90b:4c4c:b0:28c:aac9:3c7f with SMTP id
 np12-20020a17090b4c4c00b0028caac93c7fmr89897pjb.71.1703770655517; Thu, 28 Dec
 2023 05:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
 <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
 <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
 <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
 <CAFLszTja0nvhZz3b--TWXS4ABNPpJDPxUvY=9YsvbCN-DFgjbQ@mail.gmail.com>
 <20231227133754.GS2652760@bill-the-cat>
In-Reply-To: <20231227133754.GS2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:19 +0000
Message-ID: <CAFLszTjkHDPyOmt44qxsgjAap4ie=K9DeuyzAbd3zifS1pJCLg@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Maxim Uvarov <maxim.uvarov@linaro.org>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
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

Hi Tom,

On Wed, Dec 27, 2023 at 1:37=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Dec 27, 2023 at 07:56:26AM +0000, Simon Glass wrote:
> > Hi Sumit,
> >
> > On Tue, Dec 26, 2023 at 10:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > >
> > > > > On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > > > > > >
> > > > > > > > Prerquisite
> > > > > > > > -----------
> > > > > > > >
> > > > > > > > This patch series requires devicetree-rebasing git repo to =
be added as a
> > > > > > > > subtree to the main U-boot repo via:
> > > > > > > >
> > > > > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicet=
ree/devicetree-rebasing.git \
> > > > > > > >       v6.6-dts --squash
> > > > > > >
> > > > > > > So, I've played with subtree a little and I think this is the=
 right way
> > > > > > > forward in these cases. If anyone wants to take a look at how=
 this works
> > > > > > > in practice, take a look at:
> > > > > > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-wit=
h-devicetree-rebasing-since-v6.1/?ref_type=3Dheads
> > > > > > > In that tree I started with the v6.1-dts tag, sync'd all the =
configs (to
> > > > > > > have an example of a normal commit) and then did a merge of e=
ach tag
> > > > > > > until v6.6-dts, so provide some history. And git log looks li=
ke what I
> > > > > > > want to see, the squash commit has clear references to what w=
e are
> > > > > > > getting and I make a merge commit that says what I did. If yo=
u pull the
> > > > > > > tree and checkout the branch, all the code is right there alr=
eady,
> > > > > > > nothing further to do. Same with tarball releases. The only t=
hing I
> > > > > > > don't like is the size growth there, but we'll reclaim some o=
f it when
> > > > > > > we delete our obsolete bindings, and then obsolete dts files.
> > > > > >
> > > > > > I spent a bit of time with subtree as well, as part of reviewin=
g this
> > > > > > series, using the instructions Sumit provided. It seems OK to m=
e. We
> > > > > > have to accept that it adds code and there will be changes/chur=
n, but
> > > > > > it is not too different to accepting patches on those files wit=
hin
> > > > > > U-Boot. We will bring in files which U-Boot doesn't use, but U-=
Boot
> > > > > > does support a good proportion of the boards supported by Linux=
, so I
> > > > > > don't see that as a big cost.
> > > > > >
> > > > > > From my experimentation, subtrees seem to have no impact on bui=
ldman,
> > > > > > which is great. Am I missing anything?
> > > > >
> > > > > No it shouldn't cause any regression on existing tools/CI/build
> > > > > systems. It is just a version controlled way of importing third p=
arty
> > > > > source code as a tarball.
> > > > >
> > > > > >
> > > > > > I still worry about the board-level 'switch' between U-Boot DT =
and
> > > > > > upstream ones. I believe that should be at the SoC level instea=
d.
> > > > > >
> > > > >
> > > > > Probably I wasn't clear enough in my earlier replies but this ser=
ies
> > > > > motivates for a SoC level switch only. Patch #7 is essentially a
> > > > > switch for Amlogic meson-gxbb SoC and its derived boards.
> > > >
> > > > OK good...but that's not quite what I mean. You have a fragment lik=
e
> > > > this in multiple defconfig files:
> > > >
> > > > +CONFIG_OF_UPSTREAM=3Dy
> > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"
> > > >
> > > > instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in =
the
> > > > Kconfig.
> > >
> > > Okay I got your point. It makes sense to me. I will do that for v3.
> > >
> > > > We should not have to specify the filename like this. It is
> > > > laborious and error-prone.
> > >
> > > The only differentiation in naming here is just silicon vendor prefix
> > > addition (amlogic/ in this case). The reason for this being that I
> > > just want to mirror the whole silicon vendor directory from DT
> > > rebasing rather than mirroring individual DT files. Given this do you
> > > have any better alternatives?
> >
> > My current opinion is that a better approach would be to move the
> > files first (in the U-Boot tree). That would be easier if we could
> > just copy the Linux arch/xxx/boot/dts Makefiles but for now that is
> > not possible. The Kconfig options for each SoC are similar but there
> > are various differences.
> >
> > Having a different layout is just a pain and it will get worse, as
> > people add new boards, since they need to know to add the correct
> > directory.
> >
> > I will see if I can devise a small series to point this in what I
> > consider to be the right direction, in line with Linux, and the U-Boot
> > commit 3284c8b8 ("dts: generate multiple device tree blobs").
>
> I think we should just go with the approach Sumit has already taken, and
> encourage SoC maintainers to migrate sooner rather than later. There's
> also nothing stopping people from adding vendor directories under arch/
> at that point, and will likely have to happen anyhow for the case of
> platforms that aren't yet in the devicetree-rebasing tree. I am hopeful
> it won't be as much of an issue as my general feedback will change from
> "what kernel release is this dts in?" to "why didn't you set
> OF_UPSTREAM and use the existing tree?"

OK.

But I do want to see a move to using the same dir structure as Linux.

Regards,
Simon
