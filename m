Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3B6C54E60
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 15:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36F2B87F48;
	Thu, 14 Mar 2024 16:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="Y3J7Gu/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A3287F73; Thu, 14 Mar 2024 16:58:26 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C68287F48
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 16:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d28051376eso13119331fa.0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1710431902; x=1711036702;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7oABVEx8/fR/eNKMZgMWAK09ryNWl+6pxTfk8f5Bp0=;
 b=Y3J7Gu/6mOTp6Eu9c3/BBGdaUXEzcZHkR5OZ1J6ZcuCH9M+FF26bbKHu2pXRTzFsgn
 C4nNe7dbV3yAcQ/dw+BTlHG+Mn4mgELSWNUcsn+etnUGK7nvCKhzFvxyFgkgIrcAGFFR
 zkESsE8bGSgOe0K0/avewD+vh37DmFrJUDLmlajsa0h4B13SJmng2I0wML4n9XAq1IvI
 KaEwOxnwYzWhbPaw3hRfzFMTmJmOKWOYmx1CO/eUCns42gpe3ItFgACqzBtYYVizIrAg
 89Au9En7BNXb3dja4kHfPfa9p9aQTS1A4B67fWhSg2ahEko3oTOZ1lOUfggqdgjpFd3O
 u8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710431902; x=1711036702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7oABVEx8/fR/eNKMZgMWAK09ryNWl+6pxTfk8f5Bp0=;
 b=Zn3oZj3+Ec8E1MUTlCCBnPnm4fYJVNU8OMAmHJO7tQGS0f0O2PPgy9JD/K7I6LzqMZ
 aj10voG5rAxlr55SkkGxs7NfY0RLrkZpuW9nw7crhZg2vPPhtMApN64vnyfqW2BPMoN0
 /vI4YpEWLDaJAWE3UQRib8DMCy609RVhpSJoZEI+NmA+HtnsOYXDUIbGzyg1q5Rf8x+p
 gkDTLwaQ+SsKMXOjHQ/7VzG8udC2UJw/M15Wim92YLvjd1b5lpABthdqDs/rYd0ELLtN
 XVeC2NPiRwY4w18OKiCJ/bMyGKe2Tw+dEsBCyVirWB4OKv2PGw+3G1G8KbZnXhO1VtgM
 Z3SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAJDCGhF6l/Kg8nWNFd1jwJHSz99scQoNjZR9XoKvLN62VIO60zrq8P6eJDi2YK747j8srV3wtzq7PBrnyOiiBk2kCnA==
X-Gm-Message-State: AOJu0YzSeDoJ7P0IDizj2VKf9GEaKEv8xyfu5fnIzzznSvAEVpI+cLuI
 fnSOiEWt5GAkp65NXEa40K18tGbD/jVC4duCTB0p7Bz07NHeDokA1G24S3XIDJH36oYKyzVyClZ
 CWN+E/3UNgOGYnoIo3ttGsdyQNtSj6bOgvomysA==
X-Google-Smtp-Source: AGHT+IEFG6KN9FsTh2XdTx6rKcfPD6E4Ldp6rXZHNhxltYi75DbdBIgoNrDj2GTtiAlOzyTlAUOVWda0iBo+EX7vx1s=
X-Received: by 2002:a2e:9788:0:b0:2d4:6916:4dc7 with SMTP id
 y8-20020a2e9788000000b002d469164dc7mr327833lji.21.1710431901780; Thu, 14 Mar
 2024 08:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240312190543.3544532-1-tharvey@gateworks.com>
 <CAOMZO5A8m5gW+MgD8RWrtsd3kpsMaj+cV5CLHuvUkux7daD1jQ@mail.gmail.com>
 <CAFA6WYNV60m4Nv7tm2jCqqYFn9_=WTKmctUrGppCnKA30dxiRw@mail.gmail.com>
 <CAJ+vNU10auPr7wp2AGfX7Ei=Z1kf2dQax1Z21Nwex7-bh_cooQ@mail.gmail.com>
 <CAFA6WYNTXgQ5ze_12rL-B=S-5jiYQFfO8P8BSf1dHFj5_cBA5A@mail.gmail.com>
In-Reply-To: <CAFA6WYNTXgQ5ze_12rL-B=S-5jiYQFfO8P8BSf1dHFj5_cBA5A@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 14 Mar 2024 08:58:09 -0700
Message-ID: <CAJ+vNU3cUfwXhGXzTWf2DtxSsp1KEVZ3nY4dEh15FuTjgkx9pA@mail.gmail.com>
Subject: Re: [PATCH] imx8m*_venice: move venice to OF_UPSTREAM
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Thu, Mar 14, 2024 at 12:50=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> + Tom
>
> Hi Tim,
>
> On Wed, 13 Mar 2024 at 22:01, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Wed, Mar 13, 2024 at 6:20=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > On Wed, 13 Mar 2024 at 06:46, Fabio Estevam <festevam@gmail.com> wrot=
e:
> > > >
> > > > Hi Tim,
> > > >
> > > > On Tue, Mar 12, 2024 at 4:05=E2=80=AFPM Tim Harvey <tharvey@gatewor=
ks.com> wrote:
> > > > >
> > > > > Move to imx8m{m,n,p}-venice to OF_UPSTREAM:
> > > > >  - replace the non-upstream generic imx8m{m,n,p}-venice dt with o=
ne of the
> > > > >    dt's from the OF_LIST
> > > > >  - handle the fact that dtbs now have a 'freescale/' prefix
> > > > >  - imply OF_UPSTREAM
> > > > >  - remove rudundant files from arch/arm/dts leaving only the
> > > > >    *-u-boot.dtsi files
> > > > >
> > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > ...
> > > > >  33 files changed, 13 insertions(+), 10658 deletions(-)
> > > >
> > > > This diff looks great :-)
> > >
> > > +1
> > >
> > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> >
> > Hi Sumit,
> >
> > Thanks for your work on this - I imagine over time this will
> > de-duplicate a lot of work!
> >
> > I have a couple of questions about OF_UPSTREAM I haven't found the
> > answer to yet:
> > 1. how do you determine what the last sync point was in dts/upstream?
> > (ie what kernel version is it currently sync'd with)
>
> You can get that information from merge commits that happen over
> dts/upstream sub-directory. It was somewhat raw information for the
> first time we added dts/upstream as (commit aaba2d45dc2a pointing to
> v6.7-dts [1]):
>
> commit 53633a893a06bd5a0c807287d9cc29337806eaf7
> Author: Tom Rini <trini@konsulko.com>
> Date:   Thu Feb 29 12:33:36 2024 -0500
>
>     Squashed 'dts/upstream/' content from commit aaba2d45dc2a
>
>     git-subtree-dir: dts/upstream
>     git-subtree-split: aaba2d45dc2a1b3bbb710f2a3808ee1c9f340abe
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree=
-rebasing.git/tag/?h=3Dv6.7-dts
>
> However, further syncs would be more clear from merge commit
> description, try following:
>
> $ ./dts/update-dts-subtree.sh pull v6.8-dts
>
> You will see merge commit saying:
>
> commit 57508745cd2b07e55b5c414c6d646de4865418d2 (HEAD -> dt_uprev)
> Merge: 3987e15e88a 14c9e8c0856
> Author: Sumit Garg <sumit.garg@linaro.org>
> Date:   Thu Mar 14 12:20:27 2024 +0530
>
>     Subtree merge tag 'v6.8-dts' of devicetree-rebasing repo [1] into
> dts/upstream
>
>     [1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/device=
tree-rebasing.git/
>
> > 2. how often will dts/upstream get re-synced (not the
> > devicetree-rebasing.git but u-boot dts/upstream),
>
> You can see the re-syncing details here (section: "Resyncing with
> devicetree-rebasing",
> https://source.denx.de/u-boot/u-boot/-/blob/next/doc/develop/devicetree/c=
ontrol.rst?ref_type=3Dheads).
>

Thanks - I was confused about this as I originally figured it was done
via a git submodule. When I looked at the commit history of
dts/upstream it wasn't clear at all because of the first mergebeing
done differently as you explain above. As long as
update-dts-subtree.sh is run with a clear named tag that has the
kernel version in it then it's easy to follow via the short commit
description.

> > who do you suspect
> > will do be doing it?
>
> Tom will be doing that. I suppose we are just in time for a resync
> since the Linux kernel v6.8 was released.
>

Ok, that makes sense. I assume Tom will be updating it on major kernel
releases and possibly rc's leading up to as well.

> Tom,
>
> Do you think we can make v6.8-dts sync for the U-Boot next?
>
> > 3. how would one go about adding a new feature via dt to uboot when
> > the same feature has not yet landed in dts upstream? perhaps the
> > answer is it must land upstream first or do you suspect it would be ok
> > to put something in a u-boot.dtsi that can later get removed as
> > redundant?
>
> From an upstream perspective, we should aim for minimal contents in
> *-u-boot.dtsi, ideally it would be better to get rid of them. For eg.
> all bootph_* properties should all be pushed upstream.
>
> However, from the new features perspective we can consider using
> *-u-boot.dtsi if the changes are minimal like enabling some DT nodes.
> But if the changes are significant then that board can just opt out of
> OF_USTREAM but still reusing all the DT includes. The reasoning behind
> this is to minimize any chances of breakage if DT features in
> *-u-boot.dtsi diverge from DT upstream.
>
> > I ask mainly for being able to add things quickly to a
> > downstream U-Boot repo that lags behind upstream U-Boot
> >

The specific case I imagine is for example I have a couple of boards
that have TPM's that I have submitted dts updates to enable which did
not make the 6.8 cutoff so will be in 6.9. Meanwhile I will want to
pull them manually to our downstream vendor fork of an earlier U-Boot
(which in the future will have OF_UPSTEAM for our boards). Now that I
see this doesn't use git submodules I can just alter the files as
needed if I'm in a downstream fork while upstream can patiently wait
for the sync.

>
> Working downstream can always be fun, allowing additional options (can
> be useful for advance testing too):
>
> 1. You can play around with $ ./dts/update-dts-subtree.sh pull <tag>
> 2. You can manually sync the vendor directories
> (dts/upstream/src/<arch>/<vendor>/).
> 3. You can manually sync/update the individual DTS files too.
>

Yes... very cool. Thank you for taking the time to do this. It is a
significant improvement to U-Boot!

Tim
