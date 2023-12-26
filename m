Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C15C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E5E878BA;
	Tue, 26 Dec 2023 10:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aTkAM17H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D2ED87831; Tue, 26 Dec 2023 10:47:14 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CB68788E
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9b2c8e2a4so770109b3a.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584027; x=1704188827; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTH8EyXnXsHReQFRovG9exBqhw9ukMNM3tZAlOEkNck=;
 b=aTkAM17HfG4J+rFiXsYF+5R5mMcK4133aKFaxzL6PF3gazRflRnXXYKsQwIzhXX+xx
 vdMHIGC1N/glw2QdsI7duWnfdFzzYhs5GQd0GjGg9mzLnscPJpT2fNSPwbP+NBwNiXAq
 kn+yhX+PrxGxmMtLP7743yQggccuRCvGLEUWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584027; x=1704188827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTH8EyXnXsHReQFRovG9exBqhw9ukMNM3tZAlOEkNck=;
 b=Omfc0/tjN/h9IjYvDWTO3mlDFaGso59DBBnqh301Q+57KHRBpTR1JwtlRefjxYeAY5
 SN99Km1vG9eK/aCUcKiFC3K3NjW8tztA7Jd2M3ZO65agjkzuPQgJVhQWBXARF5oBl/UR
 3/taXsYtE4ha9isWttJ62M36hR+9WAm6f3l+vDapvsQK+acw6/9cJDYV5nm+I8svs3pn
 h0DB9IWhWQwyIP/adI1E5RPX4TSBH+6BBl5EG6oS24Bkn0W7N/sTXKLTfuIPPdC6Obj9
 iOn8u1fjXtTXQGHvPozP4w0/AXOYJG94iTg0r9c5vuWQ3kIDNUXVFUHC7n+/fATNhDVs
 7thg==
X-Gm-Message-State: AOJu0Yw+pk1ShoqYiuvnZGJi0Z+lQBCrU4C8LN6drxvsu5o9Sy8NuafK
 eg6DWnRWK+dXPJS7N2m5Iq/gO9I8/uq8GS3OVxoHer3S+5OE
X-Google-Smtp-Source: AGHT+IE8e241qiYb5ekPhs4E99Q2+MIyFseXCOzghzGZzt/jp8PH3esRtBAlkZsrPsraOaEiC6sMMTsp3EHlUC/T0Ik=
X-Received: by 2002:a05:6a00:928c:b0:6d9:aaf4:7e1f with SMTP id
 jw12-20020a056a00928c00b006d9aaf47e1fmr4811977pfb.30.1703584027571; Tue, 26
 Dec 2023 01:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231221150303.GI2513409@bill-the-cat>
 <CAFLszThCytoBrNEp8BqaNqe9FnzhAznC9dMHHP4g=FcZQH3zng@mail.gmail.com>
 <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
In-Reply-To: <CAFA6WYOd858K3oMxYn3XqS=UhwjMggj3ugfHgk1Ux19DCxRjVg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:55 +0000
Message-ID: <CAFLszTh2hahzuKpwxs+cPBCVfA7TaXbNNjhEmz6-CC9rqHnf5Q@mail.gmail.com>
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

On Fri, Dec 22, 2023 at 5:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Thu, 21 Dec 2023 at 20:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Dec 21, 2023 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Dec 14, 2023 at 07:20:55PM +0530, Sumit Garg wrote:
> > >
> > > > Prerquisite
> > > > -----------
> > > >
> > > > This patch series requires devicetree-rebasing git repo to be added=
 as a
> > > > subtree to the main U-boot repo via:
> > > >
> > > > $ git subtree add --prefix devicetree-rebasing \
> > > >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devi=
cetree-rebasing.git \
> > > >       v6.6-dts --squash
> > >
> > > So, I've played with subtree a little and I think this is the right w=
ay
> > > forward in these cases. If anyone wants to take a look at how this wo=
rks
> > > in practice, take a look at:
> > > https://source.denx.de/u-boot/u-boot/-/commits/WIP/u-boot-with-device=
tree-rebasing-since-v6.1/?ref_type=3Dheads
> > > In that tree I started with the v6.1-dts tag, sync'd all the configs =
(to
> > > have an example of a normal commit) and then did a merge of each tag
> > > until v6.6-dts, so provide some history. And git log looks like what =
I
> > > want to see, the squash commit has clear references to what we are
> > > getting and I make a merge commit that says what I did. If you pull t=
he
> > > tree and checkout the branch, all the code is right there already,
> > > nothing further to do. Same with tarball releases. The only thing I
> > > don't like is the size growth there, but we'll reclaim some of it whe=
n
> > > we delete our obsolete bindings, and then obsolete dts files.
> >
> > I spent a bit of time with subtree as well, as part of reviewing this
> > series, using the instructions Sumit provided. It seems OK to me. We
> > have to accept that it adds code and there will be changes/churn, but
> > it is not too different to accepting patches on those files within
> > U-Boot. We will bring in files which U-Boot doesn't use, but U-Boot
> > does support a good proportion of the boards supported by Linux, so I
> > don't see that as a big cost.
> >
> > From my experimentation, subtrees seem to have no impact on buildman,
> > which is great. Am I missing anything?
>
> No it shouldn't cause any regression on existing tools/CI/build
> systems. It is just a version controlled way of importing third party
> source code as a tarball.
>
> >
> > I still worry about the board-level 'switch' between U-Boot DT and
> > upstream ones. I believe that should be at the SoC level instead.
> >
>
> Probably I wasn't clear enough in my earlier replies but this series
> motivates for a SoC level switch only. Patch #7 is essentially a
> switch for Amlogic meson-gxbb SoC and its derived boards.

OK good...but that's not quite what I mean. You have a fragment like
this in multiple defconfig files:

+CONFIG_OF_UPSTREAM=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-odroidc2"

instead, OF_UPSTREAM should be enabled via 'imply' for the SoC, in the
Kconfig. We should not have to specify the filename like this. It is
laborious and error-prone.

Regards,
Simon
