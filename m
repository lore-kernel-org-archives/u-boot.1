Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D6BCF8565
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 07:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB3988E50;
	Thu,  3 Oct 2024 09:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DYFuJMZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DA788E50; Thu,  3 Oct 2024 09:58:40 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470BB891B1
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 09:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4a3c11892ecso261645137.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727942317; x=1728547117; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jR9hLYxwoP5RK6RZXaHikQ0W23fUwHbJHm9EraNsr+A=;
 b=DYFuJMZr0Z0WsBQgEt2ZGl2fg/iOy8pgeb+JkCBb0mqEzTzU/EnonQhXB1Bcwzuyqf
 R5+9qW4LArMluF9TGCqsfxEKYmgRjrrXms3cVn6IOXwk0zF1J85WhAfzLpGO8syJs1EZ
 ZJXTf6xaOhfsH2DWYvF6pQ4edQuUT48Lz4R5SANYA+IE49FhvCewv5iX1bDmGx6ND0kn
 47yypMs1QbsbrAAH+NnD3wK4ZtoQHHyZDOzFu637Ng6WlBlgRN2GA9KbhD1AndD9kR9g
 e3HgGwZh3QOC7J4pyEUrR+EkPIFfvZ+8KGv2mcZoYQlnP8YZ1ZzfRcPJX2ycZjJ5I853
 wygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727942317; x=1728547117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jR9hLYxwoP5RK6RZXaHikQ0W23fUwHbJHm9EraNsr+A=;
 b=QLVsTsvoUz/0tEB6meQ0sA15O3Mn7K+LV1DyW+e9ritjnn+WRkR8TspSLnAAwi1NbV
 UOVy5HfVVokdUQdl7oLX/eWq8hgJZykVXg5/lAYUZCUG0ga/sngdrvBRqjI/1j85P+QV
 0K37t5r6x4Saw1aY/jCzYqrRTCKSi4yzIVDA3d75Httfq5w16j0DcMvj4b+ZzA9Jrxd/
 ToEzkI6gNHH6gz62fg5U+DpH/+S7MHMst4ex1w77iXIPG8P/m0TVdzbRZdlXbE6Xpv+O
 2QcPR30XR44J2HphosxUNbHM6jX1+fGJgc9hKzZ+3/ExSk4dUD75YZRfJyMQaHHkdjub
 CktA==
X-Gm-Message-State: AOJu0Yy5JyMYGAmrN3nPqDPMFU/QExguJN6YkaDxEeqqzw9y2KMSkIcF
 x/XEYSHUGQfmVlI4nFQN9iBwdC3QgHeN3BMdvxgrSj6c4vXCjW7YLY7A7Tv+p/5k9GkFO43BqPP
 va+flwHLxj93VRGWWj0G2hJ2QicyjODwDQrmw/w==
X-Google-Smtp-Source: AGHT+IEowOChd0iKnF+uyZ+vk540HaJluz04Op7Zhs9kjCbmrrmC9X9u0D66/9UuyafC2T0kLkPWClTsVRGPdkNrdow=
X-Received: by 2002:a05:6102:ccb:b0:4a3:bb4d:1965 with SMTP id
 ada2fe7eead31-4a3e6923760mr4816125137.28.1727942316985; Thu, 03 Oct 2024
 00:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
 <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
 <75eb6eb6-dd55-4509-a041-a5941286493f@denx.de>
 <CAFA6WYM8KJQkTQ6YtMC7ByKU-h1Yss9K50veWmsnni3gYsgj_w@mail.gmail.com>
 <066867d2-6d16-4ebe-9a42-8ce58d3889ec@denx.de>
In-Reply-To: <066867d2-6d16-4ebe-9a42-8ce58d3889ec@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 3 Oct 2024 13:28:25 +0530
Message-ID: <CAFA6WYNy+XzWvMcfJqmLRfinKUPnvx7Ha42xOxF4a=izPKMr4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 1 Oct 2024 at 20:57, Marek Vasut <marex@denx.de> wrote:
>
> On 10/1/24 3:35 PM, Sumit Garg wrote:
>
> Hi,
>
> >>> On Sat, 28 Sept 2024 at 03:20, Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> Currently the enablement of OF_UPSTREAM results on the build system
> >>>> searching for DTs only in dts/upstream/ . There are platforms which
> >>>> use U-Boot specific DTBOs applied on top of U-Boot control DT during
> >>>> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
> >>>
> >>> I would like to understand the need to maintain DTBOs separately from
> >>> DTBs. Why aren't we pushing DTBOs to Linux kernel sources as we do for
> >>> DTBs?
> >>
> >> This is a stopgap measure, I would like to start reducing the amount of
> >> U-Boot DTs for iMX platforms, but the DTBOs are still in U-Boot only, so
> >> I would like to have some middle-of-the-road solution until the DTOs get
> >> upstreamed to Linux too.
> >>
> >>> Jan recently pushed those so-called U-Boot specific DTBOs for a
> >>> TI platform which were accepted in the Linux kernel upstream. This
> >>> patch will just deny the ability to build those DTBOs from dts
> >>> upstream tree. IMHO, this takes a step backwards on the whole notion
> >>> of OF_UPSTREAM.
> >>
> >> I don't think this will deny building those DTOs which are already
> >> upstream. With OF_UPSTREAM enabled, this will build:
> >> - Upstream DTBs
> >> - Upstream DTBOs
> >> - U-Boot local DTBOs (and NOT U-Boot local DTBs)
> >> The DTs that are bundled into u-boot.itb are searched exactly in that
> >> order too, upstream ones first, upstream DTBOs second and finally the
> >> U-Boot local DTBOs. The upstream content should always get higher
> >> priority if there are any leftover DTBOs in U-Boot which are also upstream.
> >>
> >>> If we really want a middle ground solution to allow migration to
> >>> OF_UPSTREAM easier then we need to find a way to build DTBOs from both
> >>> directories (local and upstream dts). I would imagine that will likely
> >>> complicate building and packaging DTBOs.
> >>
> >> I believe this is exactly what this commit does ?
> >
> > Okay I see, probably the commit subject was too confusing for me:
> >
> > "dts: Add ability to build DTOs only from arch/$(ARCH)/dts"
> >
> > I can see the benefit that it provides to people migrating to
> > OF_UPSTREAM. The negative part can be people just not pushing the
> > DTBOs upstream which should rather be easier as we have seen Jan
> > pushing DTBOs upstream.
>
> That (push your stuff upstream, reduce the duplication in U-Boot) is up
> to maintainers to request.
>
> Strictly enforcing either/or means setting the entry bar to OF_UPSTREAM
> higher than the entry bar to Linux kernel, which is not gonna work.
>
> Giving contributors some middle-of-the-road solution might in fact
> expedite the switch to OF_UPSTREAM, even if it may not happen all at once.
>
> > There is also magic added by this patch
> > regarding which DTBO is actually being used (local or upstream one),
> > the packaging ordering can be magic to someone debugging a boot issue
> > on a particular platform.
>
> See discussion above, the ordering is well defined.
>
> > IMHO, the OF_UPSTREAM migration can wait until all the required DT
> > sources (.dts and .dtso) are present upstream. If we start to mix and
> > match DT sources then it is going to turn into maintainers' hardship
> > again. However, I am still open to further convincing arguments for
> > this.
> With some Linux kernel architectures, it takes months to get a singular
> patch review out of the maintainers.

Okay I see the pain but we already have that rule for .dts files for
OF_UPSTREAM switch but having a different rule for .dtso files is
going to make maintainability complex. The Linux kernel
sub-architecture maintainers remain the same for both .dts and .dtso
files.

> For systems which already have DTs
> upstream and only have DTOs left, the OF_UPSTREAM conversion and DTO
> upstreaming can be done in parallel, hence expedite the process.

Fair enough, let's try to find a middle ground to gate the local DTOs
behind a config to make the use of local DTOs explicit. How about
CONFIG_OF_UPSTREAM_LOCAL_DTOS?

-Sumit
