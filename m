Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE80AD21699
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 12:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5F1881A5;
	Tue, 15 Oct 2024 14:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mo6i5HOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB662882BE; Tue, 15 Oct 2024 14:49:07 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C83387FC7
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 14:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e3e5c4a01cso3512748b6e.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728996544; x=1729601344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fI8teiX58FGmwoV/BB/WqnjD3dF8/Wun/hYVtip8eSE=;
 b=mo6i5HOM4LgArG+LBeZbhHiECInlyB09xQRJ4t9+fJE7SJaE8wc8JjSS7HQhywPW9S
 OqLrC4apqbPv0aBWnBk9or3j8npnnYLBgHPQpQxSA907vv0xs5nfwuwRP930hRfACMcG
 u/C71+bSMibM3rWwpwGUMVtWxQmLrPD0ipEt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728996544; x=1729601344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fI8teiX58FGmwoV/BB/WqnjD3dF8/Wun/hYVtip8eSE=;
 b=IeyRYgVaEFU/cq+U/V75EbnD79zpdEvfaRz2k/rWyUUe8exnRnVb1fibwV5grua8HF
 w8ODkkqwQrvTBQEPpTRUgbnqYvDQh3GHq8xzRkR2EcUtiKTVUd5m7+v208CIbUpKQ7Z5
 T6CHz4wkRbRzFpv0LkyxW1UxxS1H3vxnbbagYE7BrS3+RxodSNc6wg8m781oMWnDWQNO
 m6l7/6TpkAvGB3ia7uBDQtj35o92GHceVxTRQtJ2/epBij5ueB6xbv5EYtvX8CTqLmME
 63V59EnDLvVx29iwcpSNRwKZsNXTD4tFDJe/bBdrhe/cGiUDCbB1YuipWhFo78krCLOV
 RHUA==
X-Gm-Message-State: AOJu0Yz9N+ZKlE3ljvslvQoXwneJpW8Nm8VtEEnxK+Pm9LoKbbh7VHas
 twLILB2Xpt0V+chyu4fiMiNHxEW/iqesap8FS+NBSYRGZ9FwMxoWfP6feQrnIHk75tmv4sJhEN4
 fXSc3zyGVWGFcazOk3P7Qvh55X68h9MekAU9u
X-Google-Smtp-Source: AGHT+IFJvfoG7hilzS+j/+ydBne502BnGgilF1dzKFupHH4eD+lFi2mxWmvAydWCyI34AeiBVzXHqdN6NWB48LqrCNM=
X-Received: by 2002:a05:6808:f91:b0:3e5:db5c:eb27 with SMTP id
 5614622812f47-3e5f026413amr260360b6e.10.1728996544005; Tue, 15 Oct 2024
 05:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
 <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
 <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
 <a0077320-9c92-44ec-9614-3de1fc1d36a6@amd.com>
In-Reply-To: <a0077320-9c92-44ec-9614-3de1fc1d36a6@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 06:48:53 -0600
Message-ID: <CAFLszTjt6rrHUzg=evPS5-FyvMrZ1DocwyVc9x1Pq2K9XMokCg@mail.gmail.com>
Subject: Re: [PATCH] binman: Add option for pointing to external description
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Thu, 10 Oct 2024 at 07:03, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 10/9/24 23:14, Simon Glass wrote:
> > Hi Michal,
> >
> > On Wed, 9 Oct 2024 at 07:21, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> Hi,
> >>
> >> On 10/9/24 03:55, Simon Glass wrote:
> >>> Hi Michal,
> >>>
> >>> On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
> >>>>
> >>>> Adding binman node with target images description can be unwanted feature
> >>>> but as of today there is no way to disable it.
> >>>> Also on size constrained systems it is not useful to add binman description
> >>>> to DTB.
> >>>> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
> >>>> target from DTB for binman itself.
> >>>>
> >>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>> ---
> >>>>
> >>>>    Makefile    |  2 +-
> >>>>    lib/Kconfig | 10 ++++++++++
> >>>>    2 files changed, 11 insertions(+), 1 deletion(-)
> >>>>
> >>>
> >>> Doesn't this defeat one of the purposes of Binman, i.e. to document
> >>> images? We do want the .dts to include the image description. What
> >>> sort of problem is this causing?
> >>
> >> We have two boot flows.
> >> The first one (default one) is using Xilinx FSBL for SOM initialization with fit
> >> image (DTBS) + u-boot.elf + tfa.
> >>
> >> The second one is using U-Boot SPL instead of FSBL. This flow is used by
> >> buildroot for example.
> >>
> >> In perfect world I should describe both of these flows. I sent description for
> >> the second as RFC here.
> >> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com
> >
> > OK I'll take a look.
> >
> >>
> >> but it is also reasonable to describe the first flow but I really don't want
> >> both descriptions ends up in the target image.
> >
> > Why not? Knowing what is in the firmware is one of the goals of Binman.
>
> If this is single binary composition with clear layout then likely fine.
> In our case where we target evaluation boards which can boot out of different
> boot devices it will be more confusing.
> For these I want to generated all images also for testing purpose not only
> images which you will burn to qspi.
>
> >>
> >> The second part is if you look at RFC and how fit-dtb.blob is composed. It is
> >> one DTB + DTBS which are composed from overlays.
> >>
> >> xilinx_zynqmp_kria_defconfig has
> >> CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
> >>
> >> That's why binman node should go to this DTB but because other images are
> >> composed with overlays binman node is spread to all DTBs inside FIT image.
> >>
> >> It means one binman description is in fit-dtb.blob 14 times which is far from
> >> ideal.
> >
> > Yes, but I think what you are saying is that U-Boot doesn't need the
> > description, so you don't need it to appear in the dtbs in the FIT. Is
> > that right?
>
> Yes.
> I know that there is a code around it but as of now I don't want to use any of
> this feature.
>
> > If so, then I think we should add a way to remove it, in Binman,
> > perhaps with a property in the top-level binman image.
>
> Works for me but keep in your mind that for SOM this should be removed from all
> combinations and for me it is easier not to add that description there instead
> of adding it and removing it.

OK, I think you are saying that the description is repeated in each
.dtb since each is built by U-Boot's build system and then they are
added to the FIT.

But what is to stop people from not bothering to fill in the binman
description in U-Boot? I worry that vendors will have instructions
like 'build U-Boot with the in-tree devicetree, which has no binman
node, but pass this option to use this other file (not in mainline,
just our special vendor branch), just for Binman's use',

Where do you plan to keep this other file?

>
> >>
> >> Third part is that I can't see binman node in DT schema or bindings that's why I
> >> expect this will be reported and I can't see any code which removes it before
> >> handing off to OS which is required for System Ready IR.
> >> And IIRC removing is also problematic for measured boot.
> >
> > I did start this e.g. [1] but have not got back to it. Help would be
> > appreciated if it is important to you. I am not sure about System
> > Ready IR, but we shouldn't need to remove this.
>
> I have seen this description but this target only boot images inside MTD.
>
> SR IR requires DT to pass dt-schema. It means make no sense to add binman node
> to DT if this is going to be reported.

We need to get the schema in, then. IMO that whole idea (or checking
dt-schema) makes little sense, unless the schema includes firmware
nodes. Is there somewhere that explains why this is useful?

>
> > Also, please add an fdtmap somewhere so the image can be listed.
>
> Thanks for reminder. I remember this option and will explore to see what it does.

OK

Regards,
Simon
