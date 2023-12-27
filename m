Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65A2C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5688786A;
	Wed, 27 Dec 2023 08:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RAXxG2m4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD37877CD; Wed, 27 Dec 2023 08:56:43 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ABF5878CA
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78104f6f692so383332585a.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703663797; x=1704268597; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=908n8smTq7NiCgOaDnozfw9wemBndKn7Bo7vptgt5mk=;
 b=RAXxG2m48Z7twUt6TrRaY5DwXmwDhQYPIR4KOKUCSL1VKkT28WyS6WN7WTakm4bcy5
 LIcrVklQg8Icc5wJpx0TBzDN7OdACj6uyTWEWMu7HbxA3bMlF7xzs0dHEwmI1jknZB00
 wH9dkt5hbVuGHLiPpK3FrhHoPmBRPuOKyxkjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703663797; x=1704268597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=908n8smTq7NiCgOaDnozfw9wemBndKn7Bo7vptgt5mk=;
 b=asAmqpcn5VXEKcQLLUVqf722iIGO66YV040vOXvo0NsuMLBpURGZlW/wAnAbnRxReS
 1TDTPt4bQmTtik/cjh7hs+up4gwNOEycPQn7CmRQvAA9Fvu9uSfMtqvnWbEM15zC3itz
 qavD4ela7ubPtpCCui7BYPGqlVMFf+T/+GKqHKE/encHuDCY15MJYiZohIfGw4+pmTIa
 POjeVHH4sAP+Is312MH5Hz2SvCQT7vW3txyUpTSdx/WPAwIE7aPSe3WXsJCDdcWeH7id
 NFF2QHP4PMksElUdXuZh0DUSsqghIbwhimZBT2vZhTZa8+MrSxbHJsHwu2c9JawC4IDH
 Gdfw==
X-Gm-Message-State: AOJu0YxNWnZy6GCk6QKtHIGSbegYSDOsOqU4yfg6+hnbJtwDDxJy2Hg5
 9dE87bt58EJK72NJnJ/oPe8Bo/RmaVNivxThxpc6uv0N2nN8
X-Google-Smtp-Source: AGHT+IHvRboulb3rKLuWj9QYeyYRX5MKfLHo4Qu1wlkxJ2bMptuU/WSxipC2jGOKPLoIh6pl38XBrsUJ5xUSdrb7l2U=
X-Received: by 2002:a05:620a:24d5:b0:781:1c15:6992 with SMTP id
 m21-20020a05620a24d500b007811c156992mr14908170qkn.26.1703663797210; Tue, 26
 Dec 2023 23:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
 <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
 <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
 <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
In-Reply-To: <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 07:56:26 +0000
Message-ID: <CAFLszTja0nvhZz3b--TWXS4ABNPpJDPxUvY=9YsvbCN-DFgjbQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>,
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

Hi Sumit,

On Tue, Dec 26, 2023 at 10:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
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

My current opinion is that a better approach would be to move the
files first (in the U-Boot tree). That would be easier if we could
just copy the Linux arch/xxx/boot/dts Makefiles but for now that is
not possible. The Kconfig options for each SoC are similar but there
are various differences.

Having a different layout is just a pain and it will get worse, as
people add new boards, since they need to know to add the correct
directory.

I will see if I can devise a small series to point this in what I
consider to be the right direction, in line with Linux, and the U-Boot
commit 3284c8b8 ("dts: generate multiple device tree blobs").

Regards,
Simon
