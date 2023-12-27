Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693A6C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 04:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C88876C8;
	Wed, 27 Dec 2023 05:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eDjfA7HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB84C876FF; Wed, 27 Dec 2023 05:41:52 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FDD876C8;
 Wed, 27 Dec 2023 05:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ccbaea0a6cso22787291fa.2; 
 Tue, 26 Dec 2023 20:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703652109; x=1704256909; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3V1O3oa4ZacITwUw8NHVzH7XaNgRlvz7MBOHiWK6TI=;
 b=eDjfA7HTEwW3Flbo862zxPEsuJebFeg51N5YpVGr13taZqho7TBPpsML4DC4Fl8EYO
 TeqLiaLTlLROUxVmY05GCS+JKCGDuQNmAlP+Q9D1lZS3QEqpDUDUVTGF/kgt9rq9JXiM
 sDiyL2ImWFEDTZ0LcyaHpkjU5kmnw0B+dnL+1g9TU3OPEoHGmwF0jmaunKIJ5ElK1Wrs
 ICwjRPI+v4Cp7URfY2q2aLrzxJpP9Ktju0kBN/qi1OprexAag/+v/jysFJ+6hRzckTPI
 E29H/+fgYns2P8WnX0InIu/K/+7eHyMINmIEoIMP96U+al1oLa04f5qAKXhUE3jRh6ap
 DArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703652109; x=1704256909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3V1O3oa4ZacITwUw8NHVzH7XaNgRlvz7MBOHiWK6TI=;
 b=SfGaejhgi0uesIB69D0YUTTx3obwA8Lgv/bKfQPNDuUi5NmIOEzOrbBoaIows3jj2R
 5xCAizdGaW1Rp7SnY22EgYYHXq8aPwAj5qCkt+9I6+XiWmJMSlketXL/ZWNTest6hiiL
 o1qhumYQa7OabSZaI97MSnbDFunTvsMi5ZhDQ9b1ezMeoYHkCjgXtN31uf0sxnpJaV16
 XHw3pwUjvBeR+TV/GU0ARCDRKRKzB5AFscIS+hbE4BCfuyEwgAZM2wnNUlQpYq4ktIsL
 Zzfkkqn3Mx7tqlDGfqccJix9NC8s3/GwYzZg8WPcYcxwJTffoRSiKEUXbPYuRIyFTEIP
 wSew==
X-Gm-Message-State: AOJu0YxnvT/WeF/d3OYrBL7aTmxMr66+o5I132q7VahfuPPY2gUE1fVm
 S7uYto1zw6fUCmsOje8ussFxaSYKIOkOpUCXdbE=
X-Google-Smtp-Source: AGHT+IE+mH/DCBHJ1HC/wCi0RCDZPDHwzkXY1KHfe1F5ZLo3FXiH7uDlx1jdKR2ObMmQbcrIg689dEgq9sXPpgWqKww=
X-Received: by 2002:a2e:2f17:0:b0:2cc:2b59:72dc with SMTP id
 v23-20020a2e2f17000000b002cc2b5972dcmr3253045ljv.17.1703652108893; Tue, 26
 Dec 2023 20:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
 <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
 <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
 <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
In-Reply-To: <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 26 Dec 2023 20:41:36 -0800
Message-ID: <CAJaLiFw64BOfMKLXU_iYkFfuYZnk2XKxwbjVZEWHEJGRdZTkvw@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Sumit Garg <sumit.garg@linaro.org>, Stefan Roese <sr@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
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

Hi Sumit
Hi Simon,

On Tue, Dec 26, 2023 at 2:13=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Simon,
>
> On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > > > >
> > > > > > Prerquisite
> > > > > > -----------
> > > > > >
> > > > > > This patch series requires devicetree-rebasing git repo to be a=
dded as a
> > > > > > subtree to the main U-boot repo via:
> > > > > >
> > > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/=
devicetree-rebasing.git \
> > > > > >       v6.6-dts --squash
> > > > >
> > > > > So, I've played with subtree a little and I think this is the rig=
ht way
> > > > > forward in these cases. If anyone wants to take a look at how thi=
s works
> > > > > in practice, take a look at:
> > > > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-de=
vicetree-rebasing-since-v6.1/?ref_type=3Dheads
> > > > > In that tree I started with the v6.1-dts tag, sync'd all the conf=
igs (to
> > > > > have an example of a normal commit) and then did a merge of each =
tag
> > > > > until v6.6-dts, so provide some history. And git log looks like w=
hat I
> > > > > want to see, the squash commit has clear references to what we ar=
e
> > > > > getting and I make a merge commit that says what I did. If you pu=
ll the
> > > > > tree and checkout the branch, all the code is right there already=
,
> > > > > nothing further to do. Same with tarball releases. The only thing=
 I
> > > > > don't like is the size growth there, but we'll reclaim some of it=
 when
> > > > > we delete our obsolete bindings, and then obsolete dts files.
> > > >
> > > > I spent a bit of time with subtree as well, as part of reviewing th=
is
> > > > series, using the instructions Sumit provided. It seems OK to me. W=
e
> > > > have to accept that it adds code and there will be changes/churn, b=
ut
> > > > it is not too different to accepting patches on those files within
> > > > U-Boot. We will bring in files which U-Boot doesn't use, but U-Boot
> > > > does support a good proportion of the boards supported by Linux, so=
 I
> > > > don't see that as a big cost.
> > > >
> > > > From my experimentation, subtrees seem to have no impact on buildma=
n,
> > > > which is great. Am I missing anything?
> > >
> > > No it shouldn't cause any regression on existing tools/CI/build
> > > systems. It is just a version controlled way of importing third party
> > > source code as a tarball.
> > >
> > > >
> > > > I still worry about the board-level 'switch' between U-Boot DT and
> > > > upstream ones. I believe that should be at the SoC level instead.
> > > >
> > >
> > > Probably I wasn't clear enough in my earlier replies but this series
> > > motivates for a SoC level switch only. Patch #7 is essentially a
> > > switch for Amlogic meson-gxbb SoC and its derived boards.
> >
> > OK good...but that's not quite what I mean. You have a fragment like
> > this in multiple defconfig files:
> >
> > +CONFIG_OF_UPSTREAM=3Dy
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"
> >
> > instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in the
> > Kconfig.
>
> Okay I got your point. It makes sense to me. I will do that for v3.
>
> > We should not have to specify the filename like this. It is
> > laborious and error-prone.
>
> The only differentiation in naming here is just silicon vendor prefix
> addition (amlogic/ in this case). The reason for this being that I
> just want to mirror the whole silicon vendor directory from DT
> rebasing rather than mirroring individual DT files. Given this do you
> have any better alternatives?
>

So how do we handle the case where the DTS exists in u-boot, but not
in Linux? For example, the DTS was developed for u-boot first and has
not been accepted in the Linux device tree yet. Can we set in the
board defconfig like:

# CONFIG_OF_UPSTREAM is not set

Would that allow the DTS to remain in arch/<architecture>/dts?

Thanks,
Tony
