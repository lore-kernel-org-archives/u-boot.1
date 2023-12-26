Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44D4C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 10:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CDBD8791F;
	Tue, 26 Dec 2023 11:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RUWeedcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C61B8791D; Tue, 26 Dec 2023 11:06:51 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898028791F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 11:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bbbd4d2b4aso110718b6e.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 02:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703585205; x=1704190005; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwYqrVss4rx/3369ml/cHpUW6C+437xQ56QfarLX3/w=;
 b=RUWeedcf7cdUhCuLkxuYosmwb42MgCINuLnoZgyV9XndvwcuuUEu3ewN5oRDcjYYU8
 DT7dBrhI3t3drD0KSt4LIfOErTdVFNS+aMPs+/XmfaCGV4pDCT2HK4FdxhtFF1QNfynu
 9cyZReU8p57AjD3y/Jzz0jucRGWfAaVLkJLM0A3Gqf/P+9Y0fD48slMLxWXOll/MDZQ5
 /1lGy0DaK7OeqfF+nBFVWq0P6GQMwIyRm5IebIc8nUnjWJ2DFLRpTb2b+vNkj2hBZjF7
 lZJl8DrgZxo1hxhYWDsvZHfJcwCaL/siagTAHWgm24I+nl8igXB1S+YTEJgS4ZbY9EAS
 7A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703585205; x=1704190005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwYqrVss4rx/3369ml/cHpUW6C+437xQ56QfarLX3/w=;
 b=uT5TW+PfY3CDz6+oY8d0XZd36+vWG+p6VgO2w3Qpp4CKEdtAf0jeMssEup9K9S0BJP
 hKawvW/k+St/qfen7fR+l+P784pL2BWTAleJMcGDnox6mBd0AE85ZpsdL4YxytnN3DmW
 0j05dDf5xWk/3/pk+QkoXwRnr9TUzJdZI9jdnxbM0j7aLK2laj3C4HIf/sv9qBF4ftuW
 mkPkCscRM8GSUhsweGAyYNdTXpJX2ZLQavDbRnNc9IAplfe65VVKH8Ne+K0pBJwY7RCv
 0/izTiNPfshtN159OxZAicQcwJLMpEY4FlF4Evd02Beos0eyx3lxIK3xgVDhzA1+Mx8W
 gyBg==
X-Gm-Message-State: AOJu0YxEsPgGQf4+a9kBP/f1zOj/oT8B4LV2fOkexaaST+szL0kNHkuy
 2GCMCXxOyRm2gldgtzlvGo7sj7Qg57fbZeIlclMDsSg274IWVA==
X-Google-Smtp-Source: AGHT+IGOCf6iyH9qDtCqhWkpbB2M9jH/KxGduWqYgcJv571IVFUd8od9vAceH2rervnApikYLj5wPxqv0jTgaXgIWVo=
X-Received: by 2002:a9d:66c1:0:b0:6db:9eda:f989 with SMTP id
 t1-20020a9d66c1000000b006db9edaf989mr3484283otm.25.1703585205084; Tue, 26 Dec
 2023 02:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
 <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
 <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
In-Reply-To: <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:36:33 +0530
Message-ID: <CAFA6WYMGMADJc3RSbm+XFGGLLHhEhKRjzgovy5wFBQfjV9=Nkw@mail.gmail.com>
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > > >
> > > > > Prerquisite
> > > > > -----------
> > > > >
> > > > > This patch series requires devicetree-rebasing git repo to be add=
ed as a
> > > > > subtree to the main U-boot repo via:
> > > > >
> > > > > $ git subtree add --prefix devicetree-rebasing \
> > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/de=
vicetree-rebasing.git \
> > > > >       v6.6-dts --squash
> > > >
> > > > So, I've played with subtree a little and I think this is the right=
 way
> > > > forward in these cases. If anyone wants to take a look at how this =
works
> > > > in practice, take a look at:
> > > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-devi=
cetree-rebasing-since-v6.1/?ref_type=3Dheads
> > > > In that tree I started with the v6.1-dts tag, sync'd all the config=
s (to
> > > > have an example of a normal commit) and then did a merge of each ta=
g
> > > > until v6.6-dts, so provide some history. And git log looks like wha=
t I
> > > > want to see, the squash commit has clear references to what we are
> > > > getting and I make a merge commit that says what I did. If you pull=
 the
> > > > tree and checkout the branch, all the code is right there already,
> > > > nothing further to do. Same with tarball releases. The only thing I
> > > > don't like is the size growth there, but we'll reclaim some of it w=
hen
> > > > we delete our obsolete bindings, and then obsolete dts files.
> > >
> > > I spent a bit of time with subtree as well, as part of reviewing this
> > > series, using the instructions Sumit provided. It seems OK to me. We
> > > have to accept that it adds code and there will be changes/churn, but
> > > it is not too different to accepting patches on those files within
> > > U-Boot. We will bring in files which U-Boot doesn't use, but U-Boot
> > > does support a good proportion of the boards supported by Linux, so I
> > > don't see that as a big cost.
> > >
> > > From my experimentation, subtrees seem to have no impact on buildman,
> > > which is great. Am I missing anything?
> >
> > No it shouldn't cause any regression on existing tools/CI/build
> > systems. It is just a version controlled way of importing third party
> > source code as a tarball.
> >
> > >
> > > I still worry about the board-level 'switch' between U-Boot DT and
> > > upstream ones. I believe that should be at the SoC level instead.
> > >
> >
> > Probably I wasn't clear enough in my earlier replies but this series
> > motivates for a SoC level switch only. Patch #7 is essentially a
> > switch for Amlogic meson-gxbb SoC and its derived boards.
>
> OK good...but that's not quite what I mean. You have a fragment like
> this in multiple defconfig files:
>
> +CONFIG_OF_UPSTREAM=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"
>
> instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in the
> Kconfig.

Okay I got your point. It makes sense to me. I will do that for v3.

> We should not have to specify the filename like this. It is
> laborious and error-prone.

The only differentiation in naming here is just silicon vendor prefix
addition (amlogic/ in this case). The reason for this being that I
just want to mirror the whole silicon vendor directory from DT
rebasing rather than mirroring individual DT files. Given this do you
have any better alternatives?

-Sumit
