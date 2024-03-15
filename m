Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B81C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 04:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D446687F5D;
	Fri, 15 Mar 2024 05:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VfVnvUhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1325287F74; Fri, 15 Mar 2024 05:59:19 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D60587F52
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 05:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7dadba3284cso739578241.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 21:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710478755; x=1711083555; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iv8vUNMhVg64Ds/eYMKMvIxISMbmCs87e9fcO+cP/vI=;
 b=VfVnvUhy3hiqiSu6OHI3VPaST8znMjXaw0jlLju9nskfGkUDz33LEP595e5WYq6m61
 tvLd+XouUJgMGjm6IeKfOCGf2kmUcFpxlhaeSpJTjRK2drJFfGvgme7Icjz0sMxjCuPM
 Q2e9s9zsQVzooRhLweP9bqjennh+/C5u4bzYrPINHHLJjuYXWYsbegXSiBRdpAdpyScK
 0dEG2z+NoCZdRSb39UQJ6i1OfaqI7MWELghFx4oKNkSGNB71rg7oRev44yEs1rz3ntvF
 VH6ZOMec9sC5sDI00lO/UbEiydZMAScaYKCTyOFGRASw2Ji2gGVhoOOCzDiGMZZs9dct
 Co0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710478755; x=1711083555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iv8vUNMhVg64Ds/eYMKMvIxISMbmCs87e9fcO+cP/vI=;
 b=efwF9Km1JS/4vcIDR4wPsW1W6pyhtLvUPriLtOdyU0PjXQAxDzwR0jDSBKIS/ZKJEL
 8NkbaV1z4bEo4QQ4xgn8FvI/Fyg+Hitmwwj+luCUd+5y4ai7qmKH6c2uqHAmPTHZsHbu
 5fMm61/U8fD4a+A8xUyRxH0JSAL2ciRzeUT/3DpUF2U9K0hlmBPQp13dshhQ+NQKVXDt
 s7APqVb1vp9QYaDfxmbkc9VsHbfCsFNfwwndDKLueEilgTEt6TUBEi9fOYcVoe2P/5y5
 98A2xan4lo8Gb7q5aeW3tTYS5BgB6LB8KE3EGRG3yDKbwVhSz31oDRHUYjjIbS2hkWF8
 YdcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpQywDzHQiEkXSqpXkUDOFcCcKqdi7xQSoNmqASV/52BWIFIs0FvcQv8WM7FKLiKpF63IpZUKLDyWHfOGqXz2Q43OKtQ==
X-Gm-Message-State: AOJu0YxVMyE3RKmArQAaMo0UQdJMj3CKSN7LLFY6IdzF0hBRzNElB8XL
 Qu6hcGM48U4hFRLzJxIzY7xDq8O/F7u8fYWG22t5Zf7i/3lvwcvxlEKflkd/YiLI2Q6/+vNTHwJ
 q303n1HlkwRRSuB1wPpRmy0zyCr8i69ICMqxOLJNXSKAaW4rL
X-Google-Smtp-Source: AGHT+IH3wi4bWLwGA86R2b+aXJ8rTjsP37iRKioR8NAKzbYjzwi9GdjkiEANNsGFFQf1kcRyyvM8SAZPL+6Ar0aw+Uk=
X-Received: by 2002:a05:6102:1349:b0:475:48c9:c4ed with SMTP id
 j9-20020a056102134900b0047548c9c4edmr4179543vsl.29.1710478754790; Thu, 14 Mar
 2024 21:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240312190543.3544532-1-tharvey@gateworks.com>
 <CAOMZO5A8m5gW+MgD8RWrtsd3kpsMaj+cV5CLHuvUkux7daD1jQ@mail.gmail.com>
 <CAFA6WYNV60m4Nv7tm2jCqqYFn9_=WTKmctUrGppCnKA30dxiRw@mail.gmail.com>
 <CAJ+vNU10auPr7wp2AGfX7Ei=Z1kf2dQax1Z21Nwex7-bh_cooQ@mail.gmail.com>
 <CAFA6WYNTXgQ5ze_12rL-B=S-5jiYQFfO8P8BSf1dHFj5_cBA5A@mail.gmail.com>
 <CAJ+vNU3cUfwXhGXzTWf2DtxSsp1KEVZ3nY4dEh15FuTjgkx9pA@mail.gmail.com>
In-Reply-To: <CAJ+vNU3cUfwXhGXzTWf2DtxSsp1KEVZ3nY4dEh15FuTjgkx9pA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 10:29:03 +0530
Message-ID: <CAFA6WYOcqhzwM9CWOzNRMRZx9Dnsqs0bk1kGWO+TJpdi0aRvww@mail.gmail.com>
Subject: Re: [PATCH] imx8m*_venice: move venice to OF_UPSTREAM
To: Tim Harvey <tharvey@gateworks.com>
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

On Thu, 14 Mar 2024 at 21:28, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Mar 14, 2024 at 12:50=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > + Tom
> >
> > Hi Tim,
> >
> > On Wed, 13 Mar 2024 at 22:01, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > On Wed, Mar 13, 2024 at 6:20=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > On Wed, 13 Mar 2024 at 06:46, Fabio Estevam <festevam@gmail.com> wr=
ote:
> > > > >
> > > > > Hi Tim,
> > > > >
> > > > > On Tue, Mar 12, 2024 at 4:05=E2=80=AFPM Tim Harvey <tharvey@gatew=
orks.com> wrote:
> > > > > >
> > > > > > Move to imx8m{m,n,p}-venice to OF_UPSTREAM:
> > > > > >  - replace the non-upstream generic imx8m{m,n,p}-venice dt with=
 one of the
> > > > > >    dt's from the OF_LIST
> > > > > >  - handle the fact that dtbs now have a 'freescale/' prefix
> > > > > >  - imply OF_UPSTREAM
> > > > > >  - remove rudundant files from arch/arm/dts leaving only the
> > > > > >    *-u-boot.dtsi files
> > > > > >
> > > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > ...
> > > > > >  33 files changed, 13 insertions(+), 10658 deletions(-)
> > > > >
> > > > > This diff looks great :-)
> > > >
> > > > +1
> > > >
> > > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > > >
> > >
> > > Hi Sumit,
> > >
> > > Thanks for your work on this - I imagine over time this will
> > > de-duplicate a lot of work!
> > >
> > > I have a couple of questions about OF_UPSTREAM I haven't found the
> > > answer to yet:
> > > 1. how do you determine what the last sync point was in dts/upstream?
> > > (ie what kernel version is it currently sync'd with)
> >
> > You can get that information from merge commits that happen over
> > dts/upstream sub-directory. It was somewhat raw information for the
> > first time we added dts/upstream as (commit aaba2d45dc2a pointing to
> > v6.7-dts [1]):
> >
> > commit 53633a893a06bd5a0c807287d9cc29337806eaf7
> > Author: Tom Rini <trini@konsulko.com>
> > Date:   Thu Feb 29 12:33:36 2024 -0500
> >
> >     Squashed 'dts/upstream/' content from commit aaba2d45dc2a
> >
> >     git-subtree-dir: dts/upstream
> >     git-subtree-split: aaba2d45dc2a1b3bbb710f2a3808ee1c9f340abe
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetr=
ee-rebasing.git/tag/?h=3Dv6.7-dts
> >
> > However, further syncs would be more clear from merge commit
> > description, try following:
> >
> > $ ./dts/update-dts-subtree.sh pull v6.8-dts
> >
> > You will see merge commit saying:
> >
> > commit 57508745cd2b07e55b5c414c6d646de4865418d2 (HEAD -> dt_uprev)
> > Merge: 3987e15e88a 14c9e8c0856
> > Author: Sumit Garg <sumit.garg@linaro.org>
> > Date:   Thu Mar 14 12:20:27 2024 +0530
> >
> >     Subtree merge tag 'v6.8-dts' of devicetree-rebasing repo [1] into
> > dts/upstream
> >
> >     [1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devi=
cetree-rebasing.git/
> >
> > > 2. how often will dts/upstream get re-synced (not the
> > > devicetree-rebasing.git but u-boot dts/upstream),
> >
> > You can see the re-syncing details here (section: "Resyncing with
> > devicetree-rebasing",
> > https://source.denx.de/u-boot/u-boot/-/blob/next/doc/develop/devicetree=
/control.rst?ref_type=3Dheads).
> >
>
> Thanks - I was confused about this as I originally figured it was done
> via a git submodule. When I looked at the commit history of
> dts/upstream it wasn't clear at all because of the first mergebeing
> done differently as you explain above. As long as
> update-dts-subtree.sh is run with a clear named tag that has the
> kernel version in it then it's easy to follow via the short commit
> description.
>
> > > who do you suspect
> > > will do be doing it?
> >
> > Tom will be doing that. I suppose we are just in time for a resync
> > since the Linux kernel v6.8 was released.
> >
>
> Ok, that makes sense. I assume Tom will be updating it on major kernel
> releases and possibly rc's leading up to as well.

The current policy is to sync on major kernel releases only after the
U-Boot next branch opens. Since we would like to avoid any DT ABI
breakages for U-Boot and at the same time provide sufficient time to
fix problems if any. However if DT ABI turns out to be much more
stable for U-Boot then we can revisit this policy.

>
> > Tom,
> >
> > Do you think we can make v6.8-dts sync for the U-Boot next?
> >
> > > 3. how would one go about adding a new feature via dt to uboot when
> > > the same feature has not yet landed in dts upstream? perhaps the
> > > answer is it must land upstream first or do you suspect it would be o=
k
> > > to put something in a u-boot.dtsi that can later get removed as
> > > redundant?
> >
> > From an upstream perspective, we should aim for minimal contents in
> > *-u-boot.dtsi, ideally it would be better to get rid of them. For eg.
> > all bootph_* properties should all be pushed upstream.
> >
> > However, from the new features perspective we can consider using
> > *-u-boot.dtsi if the changes are minimal like enabling some DT nodes.
> > But if the changes are significant then that board can just opt out of
> > OF_USTREAM but still reusing all the DT includes. The reasoning behind
> > this is to minimize any chances of breakage if DT features in
> > *-u-boot.dtsi diverge from DT upstream.
> >
> > > I ask mainly for being able to add things quickly to a
> > > downstream U-Boot repo that lags behind upstream U-Boot
> > >
>
> The specific case I imagine is for example I have a couple of boards
> that have TPM's that I have submitted dts updates to enable which did
> not make the 6.8 cutoff so will be in 6.9. Meanwhile I will want to
> pull them manually to our downstream vendor fork of an earlier U-Boot
> (which in the future will have OF_UPSTEAM for our boards). Now that I
> see this doesn't use git submodules I can just alter the files as
> needed if I'm in a downstream fork while upstream can patiently wait
> for the sync.
>
> >
> > Working downstream can always be fun, allowing additional options (can
> > be useful for advance testing too):
> >
> > 1. You can play around with $ ./dts/update-dts-subtree.sh pull <tag>
> > 2. You can manually sync the vendor directories
> > (dts/upstream/src/<arch>/<vendor>/).
> > 3. You can manually sync/update the individual DTS files too.
> >
>
> Yes... very cool. Thank you for taking the time to do this. It is a
> significant improvement to U-Boot!

Thanks for your adoption too.

-Sumit

>
> Tim
