Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC1CD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D15F89122;
	Fri, 18 Oct 2024 01:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gxg7P7UQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B014489083; Fri, 18 Oct 2024 01:23:43 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08882891CA
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbceb48613so8823436d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207419; x=1729812219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DFeWpzWLNdNZpchtoQyK6xPWcgknmQhC+vHJ+Plj0D4=;
 b=Gxg7P7UQJX10Dj8IpXPAy1Wv7FiO5CjRjvkM0J+YXq9wkcoPiraz83EGqlrre2XFwH
 75Q585JAHuqYecyGic6ChLR1YQvEdVanaMwcUvgrjiKXhLDoBalWg9o3H2857ezBQ1Sk
 7cX68DxcnSKqF/EWpTg2KSaQ1PGSBGsSU+014=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207419; x=1729812219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DFeWpzWLNdNZpchtoQyK6xPWcgknmQhC+vHJ+Plj0D4=;
 b=YDATWbxx8LfLMfAohjreHfMHhg2SyhbgWKqGL3eXlxMmSsJ/inyJPByupQy//FmvEV
 UFPDsOT9vy9ciwfhujbZBEBQm2kIcbbWxb7KfJI449gKTY4zmGK/kSYEH5v00X7I2vb+
 Q6m9KokgXTNHNf2fW022ymRnBxp09oxuzKpYhNzOROzCJZE6NsODt9JfCxLSwIQA9XSd
 OGV+Wmgooo/k13fvmJU9IJPRoIkcamtAJBIuxOCfwL5m+yMA6qioKDZuDnkR/0DiRWNP
 bsSAl48inB3giOkIiPq8M+dMC4ZH6RD88e0ZKno7GU3UdHiDnGi8CeTvSnEfX1n+gTfc
 qnHA==
X-Gm-Message-State: AOJu0Ywp/pZBdvBcqxwyft3pgVFwm0xvfNGfgKsOBrnYjmRuYXdHFJGT
 L44EFVKlUFT+jAudkZWNRlh6ANpUDzL/oFuXn6eRyHo1XX9i5MkYNPydym482cwQfxBIBSI3jsu
 3zFaA/yydobChYjB6Pef8a9y1HFcjg32C6Jki
X-Google-Smtp-Source: AGHT+IGOnOAmJgEl0YbLZUX/TZREgwLc4CMvJfkHanRhtMuo5jKt2l+2lgMdbfGQfP9xh8zmXd+FekOptlB+kAxbAOc=
X-Received: by 2002:a05:6214:2dc4:b0:6cb:27e6:393f with SMTP id
 6a1803df08f44-6cde15deb69mr7977856d6.36.1729207418701; Thu, 17 Oct 2024
 16:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
 <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
 <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
 <a0077320-9c92-44ec-9614-3de1fc1d36a6@amd.com>
 <CAFLszTjt6rrHUzg=evPS5-FyvMrZ1DocwyVc9x1Pq2K9XMokCg@mail.gmail.com>
 <6e7f9046-2e7f-479a-80e1-59e7b20c48f7@amd.com>
In-Reply-To: <6e7f9046-2e7f-479a-80e1-59e7b20c48f7@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:23:28 -0600
Message-ID: <CAFLszThYOt+MtHbxMLLEy5SK_ZfGJvLbp-azk9WOf57VejyQKA@mail.gmail.com>
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

On Wed, 16 Oct 2024 at 00:00, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Simon,
>
> On 10/15/24 14:48, Simon Glass wrote:
> > Hi Michal,
> >
> > On Thu, 10 Oct 2024 at 07:03, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 10/9/24 23:14, Simon Glass wrote:
> >>> Hi Michal,
> >>>
> >>> On Wed, 9 Oct 2024 at 07:21, Michal Simek <michal.simek@amd.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 10/9/24 03:55, Simon Glass wrote:
> >>>>> Hi Michal,
> >>>>>
> >>>>> On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>>
> >>>>>> Adding binman node with target images description can be unwanted feature
> >>>>>> but as of today there is no way to disable it.
> >>>>>> Also on size constrained systems it is not useful to add binman description
> >>>>>> to DTB.
> >>>>>> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
> >>>>>> target from DTB for binman itself.
> >>>>>>
> >>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>>>> ---
> >>>>>>
> >>>>>>     Makefile    |  2 +-
> >>>>>>     lib/Kconfig | 10 ++++++++++
> >>>>>>     2 files changed, 11 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>
> >>>>> Doesn't this defeat one of the purposes of Binman, i.e. to document
> >>>>> images? We do want the .dts to include the image description. What
> >>>>> sort of problem is this causing?
> >>>>
> >>>> We have two boot flows.
> >>>> The first one (default one) is using Xilinx FSBL for SOM initialization with fit
> >>>> image (DTBS) + u-boot.elf + tfa.
> >>>>
> >>>> The second one is using U-Boot SPL instead of FSBL. This flow is used by
> >>>> buildroot for example.
> >>>>
> >>>> In perfect world I should describe both of these flows. I sent description for
> >>>> the second as RFC here.
> >>>> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com
> >>>
> >>> OK I'll take a look.
> >>>
> >>>>
> >>>> but it is also reasonable to describe the first flow but I really don't want
> >>>> both descriptions ends up in the target image.
> >>>
> >>> Why not? Knowing what is in the firmware is one of the goals of Binman.
> >>
> >> If this is single binary composition with clear layout then likely fine.
> >> In our case where we target evaluation boards which can boot out of different
> >> boot devices it will be more confusing.
> >> For these I want to generated all images also for testing purpose not only
> >> images which you will burn to qspi.
> >>
> >>>>
> >>>> The second part is if you look at RFC and how fit-dtb.blob is composed. It is
> >>>> one DTB + DTBS which are composed from overlays.
> >>>>
> >>>> xilinx_zynqmp_kria_defconfig has
> >>>> CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
> >>>>
> >>>> That's why binman node should go to this DTB but because other images are
> >>>> composed with overlays binman node is spread to all DTBs inside FIT image.
> >>>>
> >>>> It means one binman description is in fit-dtb.blob 14 times which is far from
> >>>> ideal.
> >>>
> >>> Yes, but I think what you are saying is that U-Boot doesn't need the
> >>> description, so you don't need it to appear in the dtbs in the FIT. Is
> >>> that right?
> >>
> >> Yes.
> >> I know that there is a code around it but as of now I don't want to use any of
> >> this feature.
> >>
> >>> If so, then I think we should add a way to remove it, in Binman,
> >>> perhaps with a property in the top-level binman image.
> >>
> >> Works for me but keep in your mind that for SOM this should be removed from all
> >> combinations and for me it is easier not to add that description there instead
> >> of adding it and removing it.
> >
> > OK, I think you are saying that the description is repeated in each
> > .dtb since each is built by U-Boot's build system and then they are
> > added to the FIT.
>
> yep

OK, got it. I think we should add an way to make the binman node optional.

>
> >
> > But what is to stop people from not bothering to fill in the binman
> > description in U-Boot? I worry that vendors will have instructions
> > like 'build U-Boot with the in-tree devicetree, which has no binman
> > node, but pass this option to use this other file (not in mainline,
> > just our special vendor branch), just for Binman's use',
> >
> > Where do you plan to keep this other file?
>
> In u-boot repo of course. And all configurations which makes sense.
> And pretty much if vendors wants to hide it they can no matter of this patch.
> I understand your concern but vendors can do it today.

So what value are you going to use for BINMAN_EXTERNAL_DTB ? Is there
a patch for that? Perhaps it should be renamed, since it suggests that
the file is out of tree.

Regards,
Simon
