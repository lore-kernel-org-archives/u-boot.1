Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CA5C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 09:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C115A877AC;
	Thu,  4 Jan 2024 10:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MIYOglLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A2587721; Thu,  4 Jan 2024 10:47:14 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05496877AC
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 10:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4678c4e51a5so64241137.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704361631; x=1704966431; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHZwDYoNMFPVA25b7NOqeSAKVTxxSc+i2wmwXPEeZT0=;
 b=MIYOglLuCs3/Qg+dNTaiwXT8x9PJnBl8VTghSu8BIAnnDWCjGOCijmnsBy0K7WI/Cp
 HAuLzKVEmvMXtMqpdHYK2T9Uql6kI6ZKo0k18JIYhvKNWBYbD+LfhEkcFXPq9qnTQzKH
 kb3H5NvwJDQjCf2UWusemAvz7O4sI9Al31RJ3h+Cf24xaGsOXSn3OCtxnZ/U/vhBzNSP
 D6gMI6aJaM98YyUf11SzEv4w+a+sSTU9uuvDCMYGbWpY9XgeGLkov+9i+pF0J39xDocM
 YLw4mZQx4ZLeHGrPMsZIfK99E+gu0biEw204mgN4xriIRv504YlE/ZtCHUxSRjtqxji8
 hmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704361631; x=1704966431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHZwDYoNMFPVA25b7NOqeSAKVTxxSc+i2wmwXPEeZT0=;
 b=a4ZQrkXlMDsQcIHRnAraNoYU06LvOjuL9UwF27c3MM5Mx00NjvwrDK5UVvqml/GEAl
 Gi93dv8DeMvIaN7HM/Ixu83qeOPr4qT+yYZeE+UAuFE05cmxIdmmHrskIoP6ZzR3LVwe
 aS/slJMsbdh6E5VGFaolZljhDhs0oQVIakDHtdI4GG2uEIHqIOORWSG1PHUDG2kbsrou
 UBGyr4xrCMPI1OGmYhddllP7hZnmh8AriEyd7M57IUFBtS5bubwtCNig/URtGpB9YsXD
 EssKs5tTs7lWowM/sEiBg0MUBjRpXrLEWGSO3k0YHnbkNMTA0feKDcxeTP/pjz8t8STt
 9ztg==
X-Gm-Message-State: AOJu0YxkFqsHxibW8SUhVLS62wSGkYzr8aSILrDm00CfBl/AYSCUoeCN
 G9l8h2/3mvhKYXAdKtCCCNHeSB8RqmkqrJnwKjly36s7fw2Yug==
X-Google-Smtp-Source: AGHT+IHsJ4CzNzuWTNQdpodd65d/UMi85rNeRQobF5UzndKFXN2h2BPyXNlG8sJU/m1Z1Bcgv/043M7G7PqzkXVKfk8=
X-Received: by 2002:a05:6102:50a5:b0:467:ab62:cb43 with SMTP id
 bl37-20020a05610250a500b00467ab62cb43mr147932vsb.13.1704361630740; Thu, 04
 Jan 2024 01:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat>
In-Reply-To: <20240103163201.GL1610741@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Jan 2024 15:16:59 +0530
Message-ID: <CAFA6WYOhbnOsAFQCTNZT-6_Xb_G7cxWOmCDoo+c5aKkxSWxOvg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
To: Tom Rini <trini@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

On Wed, 3 Jan 2024 at 22:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> > On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> [snip]
> > > +In order to maintain devicetree files sync, U-Boot maintains a Git s=
ubtree for
> > > +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It i=
s regularly
> > > +kept updated with every new kernel major release via subtree pull as=
 follows::
> >
> > I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
> > had in the original repo). I don't think it's relevant.

Sure, as Tom pointed out below that we would shift to put subtree as
dts/upstream for v4. Does that make sense to you?

> >
> > We're not likely to regenerate the tree, but any clue what 'git
> > subtree pull' would do in this case? It could happen if we switched to
> > git-filter-repo.

Yeah we just need to modify the prefix as:

git subtree pull --prefix dts/upstream \
       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-=
rebasing.git
\
       <release-tag> --squash

> >
> > > +
> > > +    git subtree pull --prefix devicetree-rebasing \
> > > +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/dev=
icetree-rebasing.git \
> > > +        <release-tag> --squash
> >
> > I'd put this in a script to run. Documentation tends to be not quite
> > correct. A script could also be smarter and figure out <release-tag>.

Sure, I will do that for v4.

>
> Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
> something using subtree, I do hope to learn some lessons from what you
> do there. The first thing is that given the size/nature of the commits,
> I had figured I'd be the one doing this as a subtree pull+squash then
> push, rather than posting to the ML since it'll be huge and
> un-reviewable, but with a note sent off to the ML that people should be
> aware the next sync has been done and retest as needed. But Sumit, were
> you planning to do some of this instead?

I am happy for you to do that. I am happy to assist in case any conflicts o=
ccur.

> The second thing is that if we
> move the subtree part in to dts/ instead (where we will still have the
> Makefile/Kconfig we have today and then our Makefiles within the
> directories, this might get more complex and so really require a script
> to keep it from getting error prone?

IMO, we should give subtree a try and later if it becomes complex to
manage then we can switch to a custom script as well. It is
essentially a sub-directory which we start initially to manage via a
subtree approach but later we can switch to a custom script to sync
that subdirectory if there is a need.

-Sumit

>
> --
> Tom
