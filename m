Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A188C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 09:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E324387C0E;
	Wed, 24 Jan 2024 10:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="foiYJwQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44D4287C1B; Wed, 24 Jan 2024 10:03:34 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF7E87752
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 10:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-46afeb936afso403333137.1
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706087010; x=1706691810; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLICkG4ScVUzCgpGbPDyyuuRZpXtom25bWlwVUEPtVo=;
 b=foiYJwQnfkIyPoSnUPfTPO51hd0E7aAdHzwQ/DU7gxGo0J4O1qxiPIcH4HgbfMxTfW
 GZIk6KyUTwOhDXOgYXIAwcTPaRZfT9ozYAf+iWqi2+BlnEQbo8JhQCTyvcPRgCMxJeCT
 VZK6yPv8W+TaHGcD+UPvCJ79x7+uXs6UPMpM7I00rEFn/tr8Tvk5Vv0z+akP6nbi11KY
 D8Q7QMESZcooSvTYrlCNg7dFO1JFaUGTxGgABE2jmL7zrz0IglNtRKImHJu+WDa3mlTK
 ZdX+gjwAgR/Sd9EKQ2AKxuiVA3db6aatOi1GTVux7o+Whvv8tiXq+KQCy9oq7PoNT7eC
 /ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706087010; x=1706691810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLICkG4ScVUzCgpGbPDyyuuRZpXtom25bWlwVUEPtVo=;
 b=g0U2SsMvFGCy9yAWT0iiumbpyaGs/6RrvSrw0xKu7BBzhtW65H7suSsGdYV1SFrvlp
 tF/plW7JepfVwscx5NsaVgnCribvOSinpFcYAFN7E7zQWKNJ2GadSio7eC/IRQrYBqox
 kUi/JGB+kD12kYt69ckZqf2d3DG1jlqPj9YRv2CHsxDh/ks4kJZihyM2/wdJMLLvnoD0
 WYblk+/Y8Oj1TueuXBoLpkXf7YjZMT/pzFXhj4LP7n5Gwj3MQG/8MotlfrhE6SEzCpw+
 o7WT5sAvpum92xBQIpoohMsr5HAi7icrnZ9TS+6yaT41TXOrfxiMSMjcdhQLl3ArEVLz
 z5Rw==
X-Gm-Message-State: AOJu0YzH72mlwkn6zhr5U1AySF8GtDNWRdq9S28mpSNooq9dSbRPNEUL
 OznpWlKfWTJe/C5WchwbefrCvWmreQFh3kI17xpJ+rfqokuO6+FaB61MsMQvZXFp27Ws+h73rQl
 A3ORp6cNxk9E4K4VwB/8qyxLcw+APPTUoWXMLJA==
X-Google-Smtp-Source: AGHT+IHnXbDydUuGIemATwvTpccwd4HLfBSJZjMup2RFfzA3cIe8lba/gUMkrRGMZdInOkTgssBqg1UxQhfU4DHu59c=
X-Received: by 2002:a05:6102:e10:b0:469:85df:dea4 with SMTP id
 o16-20020a0561020e1000b0046985dfdea4mr5040173vst.21.1706087010654; Wed, 24
 Jan 2024 01:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240122114515.760e9cd3@donnerap.manchester.arm.com>
 <20240122164959.GN3652023@bill-the-cat>
 <20240123005834.4ab47bf5@minigeek.lan>
 <CAL_JsqJ1azgskDucTVkF0u_bKJUtNhhiufGdN6OOYicxwHW2_Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJ1azgskDucTVkF0u_bKJUtNhhiufGdN6OOYicxwHW2_Q@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jan 2024 14:33:19 +0530
Message-ID: <CAFA6WYPAemm6cdWatTEesVJP6x7SyVQvnMkwaMO6Z8fWE3KF0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Rob Herring <robh+dt@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
 mark.kettenis@xs4all.nl
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

Hi Rob, Andre,

On Tue, 23 Jan 2024 at 22:12, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jan 22, 2024 at 6:59=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
> >
> > On Mon, 22 Jan 2024 11:49:59 -0500
> > Tom Rini <trini@konsulko.com> wrote:
> >
> > Hi Tom,
> >
> > > On Mon, Jan 22, 2024 at 11:45:15AM +0000, Andre Przywara wrote:
> > > > On Wed, 10 Jan 2024 16:05:36 +0530
> > > > Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I certainly welcome this more automatic synchronisation of the DTs,
> > > > however have one comment about the upcoming sync process:
> > > >
> > > > > ...
> > > > > However, Linux kernel DT maintainers proposed [2] for U-Boot to r=
ather
> > > > > use devicetree-rebasing repo [3] which is a forked copy from Linu=
x
> > > > > kernel for DT source files as well as bindings. It is tagged at e=
very
> > > > > Linux kernel major release or intermideate release candidates. So=
 here I
> > > > > have tried to reuse that to bring DT bingings compliance as well =
as a
> > > > > standard way to maintain a regular sync of DT source files with L=
inux
> > > > > kernel.
> > > > >
> > > > > In order to maintain devicetree files sync, U-Boot will maintains=
 a Git
> > > > > subtree for devicetee-rebasing repo as `dts/upstream` sub-directo=
ry.
> > > > > U-Boot will regularly sync `dts/upstream/` subtree whenever the n=
ext window
> > > > > opens with the next available kernel major release.
> > > >
> > > > I hope this doesn't need to stay that restricted? Can we either syn=
c more
> > > > often, or at least on the kernel's -rc1, and not only on a "full" r=
elease?
> > > >
> > > > The reason I ask is that we have a chicken-egg problem here: withou=
t a DT
> > > > merged into the kernel tree, no U-Boot board support can be merged.=
 And
> > > > without U-Boot support, we cannot boot a kernel, at least not in th=
e
> > > > canonical way.
> > > >
> > > > Since the U-Boot and kernel merge windows are not in phase, for sun=
xi I try
> > > > to sync the kernel DTs either as early as possible (-rc1, sometimes=
 even
> > > > before, when the maintainers have merged them into their tree), or
> > > > sometimes "out of season", if a board defconfig patch is coming up.
> > > >
> > > > Otherwise new board support, which typically has a very low regress=
ion risk
> > > > for the rest of the code base, would need to be delayed until the n=
ext
> > > > release. In the worst case the U-Boot merge windows opens one week =
before
> > > > a kernel release, then new boards need to wait three months?
> > >
> > > Would it be to bad to bring in board X with OF_UPSTREAM=3Dn for one U=
-Boot
> > > release, and then with the next one switch to OF_UPSTREAM=3Dy (and de=
lete
> > > the dts from arch/) for the next release, when we would have gotten b=
ack
> > > in sync?
> >
> > Ah, I didn't look into the actual patches, but if this provision is
> > there, that sounds surely acceptable. It might still be good to sync
> > earlier than the .0 kernel release: if it appears in Linus' tree, it
> > had already seen a good share of review and testing. And with the
> > U-Boot releases being always further away than the next kernel release,
> > we could pull fixes still in time. So we could pick the latest -rc (or
> > .0 release, whichever is more recent) when the U-Boot merge window
> > opens?
>
> That should be mostly fine IMO, but there are the occasional "oops,
> let's change/fix the binding before it's released".
>
> Couldn't you pull in the latest rc in the merge window, but only if
> the .0 release will happen before the next u-boot release. And then
> update from rc to .0 before the u-boot release.
>
> Also, from a quick look at the dts changes during rc releases, they
> tend to come in the later rc releases. Probably that's just the
> latency of going to sub-arch maintainer->SoC->Linus.
>

I agree with your intent to keep U-Boot updated with the latest Linux
DT .0 releases. However, we would like to provide sufficient time (a
full U-Boot release cycle) for U-Boot developers/maintainers to adapt,
detect and fix problems for their platforms wrt. to a new Linux DT .0
release. We can always revisit the syncing strategy to be more
aggressive if everything pans out as per plan.

-Sumit

> Rob
