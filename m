Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3A6E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 17:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA28B890C1;
	Sat,  2 Nov 2024 18:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L+af4Lcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E24890C4; Sat,  2 Nov 2024 18:36:17 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CF7890BC
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 18:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a16b310f5so453565466b.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730568974; x=1731173774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BBWJJRNOfLz6rb+EpjBJ5AI+XlUwZpOENO3SSwZak/I=;
 b=L+af4LcvdF6EiA7ph+allz19/NZQA8EvVzxeD1S2FzYj39q5fzyg2zmVaEW49KL9MX
 iZoOsGHqSQZoTHokFv0wf7CwOiJQnubfZJQGLPsebho9ctazO8T826opp8myovsYii2U
 JyIzCi2bC75QyzRUOIGbLfyhDNavZ17LyFAjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730568974; x=1731173774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBWJJRNOfLz6rb+EpjBJ5AI+XlUwZpOENO3SSwZak/I=;
 b=fVuvg23MRqygxNkz0xSL0uKQR6HPxq6uNN6BZcPcYzyPWKz4SAjYKXGzL42UGZrYWH
 QNbCwE5qovEt5v3xbdsYOQlgcWAg07hXO+XFk6ee0FgyNsVL8g5W+JSJd5+EHfMNwcXZ
 057UuF3/XH6h8GYNczz2/yn95Z/CmuRnr6gb4MPEa+ZrviBeA6fApibiQKnMHj6f4NlC
 bdQzsE1NMiVJMC3pxhjC4ARXiCplRgste2lIWj838Z+gZGinLuGf8R3Cv/9KZ0eQW/Kr
 4wfkLtIiD5qu6ZKxNp7KsVyfgLW5UzxzcDq+KrquIpGa0qg9MyMJyj4Zy6zGUU5v8BVQ
 tcYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaZn6HKLgGmXxxETKnJRt62TspGBn/8W0L7QhH0qw8p81dISkMi4pPO85QHyQPNrNtCRvoqJ8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxu5Es1e1+VJA3XwjLrcH2Qaohfb4G3uaFlRYI2sDDObwaa08AD
 FyYIbKvYyu83WyJjNyjp3IuNP07Va6EUlXzRrwe7jqhDpZfqH5mSatxEe8AgcdVX+VRKdHkP4ax
 Mgxfz6lg0ngjYWz1McEiiLbS8AtHoPBC0zDa+
X-Google-Smtp-Source: AGHT+IFQfAYsDHpPTarf4RNnsSqVbIjCEQodHs+79ke6jLh0kkMqKpM4/9QxHOJjHrzxMmtO6ggpIh9TlX7ThivF3Dw=
X-Received: by 2002:a17:907:7e9a:b0:a99:e850:deb3 with SMTP id
 a640c23a62f3a-a9e508e2c61mr1064364366b.18.1730568974416; Sat, 02 Nov 2024
 10:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
 <d609b656-19db-4dc3-956f-7dbec5de9975@cherry.de>
 <6dc671c5-2f2e-4cd9-817b-5aa50e5a4232@weidmueller.com>
 <7687e15d-c601-4f91-b07f-a4f9d5114362@cherry.de>
 <4ae22738-3292-4c03-902e-4a7aa4b45cca@weidmueller.com>
 <fc0efc26-35ff-4e43-9a73-5e63391448d3@cherry.de>
 <439e1da1-89b1-4bcb-ac43-3f8816c395de@weidmueller.com>
In-Reply-To: <439e1da1-89b1-4bcb-ac43-3f8816c395de@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 11:36:01 -0600
Message-ID: <CAFLszTh=yDPJc2oxCrFmR2ZdKkqFGDH_jwdXCXUEp_+aSvHrkA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Import environment variables from FIT configuration
To: Lukas Funke <lukas.funke-oss@weidmueller.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 Niko Mauno <niko.mauno@vaisala.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Kubik <piotr.kubik@iopsys.eu>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Lukas,

On Wed, 3 Jul 2024 at 02:29, Lukas Funke
<lukas.funke-oss@weidmueller.com> wrote:
>
> Hi Quentin,
>
> On 02.07.2024 15:05, Quentin Schulz wrote:
> > Hi Lukas,
> >
> > On 7/2/24 2:58 PM, Lukas Funke wrote:
> >> Hi Quentin,
> >>
> >> On 02.07.2024 13:37, Quentin Schulz wrote:
> >>> Hi Lukas,
> >>>
> >>> On 7/2/24 1:01 PM, Lukas Funke wrote:
> >>>> Hi Quentin,
> >>>>
> >>>> On 02.07.2024 11:16, Quentin Schulz wrote:
> >>>>> Hi Lukas,
> >>>>>
> >>>>> On 7/2/24 8:48 AM, lukas.funke-oss@weidmueller.com wrote:
> >>>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
> >>>>>>
> >>>>>>
> >>>>>> This series enables U-Boot to import environment variables from the
> >>>>>> selectd FIT configuration. One use-case is that the overall build
> >>>>>> process
> >>>>>> enriches the FIT configuration node with dm-verity information which
> >>>>>> should be injected into the kernel commandline. U-Boot will then read
> >>>>>> these (possibly signed) environment variables and put them into the
> >>>>>> actual Kernel commandline using variable replacement
> >>>>>> (see CONFIG_BOOTARGS_SUBST).
> >>>>>>
> >>>>>> Example:
> >>>>>>
> >>>>>> Config:
> >>>>>> CONFIG_BOOTARGS_SUBST=y
> >>>>>> CONFIG_ENV_IMPORT_FIT_CONF=y
> >>>>>>
> >>>>>> FIT:
> >>>>>>      configurations {
> >>>>>>          default = "conf-1";
> >>>>>>              conf-1 {
> >>>>>>                  kernel = "kernel-1";
> >>>>>>                  fdt = "fdt-1";
> >>>>>>                  env,dm-verity-args = "dm-mod.create=...";
> >>>>>>                  env,bar = "someothervalue";
> >>>>>>              };
> >>>>>>      };
> >>>>>>
> >>>>>> U-Boot cmdline:
> >>>>>> => env set bootargs="rootfstype=squashfs root=/dev/xyz
> >>>>>> ${dm-verity-args} ro"
> >>>>>> => boot
> >>>>>>
> >>>>>> Kernel cmdline:
> >>>>>> Kernel command line: rootfstype=squashfs ... dm-mod.create= ...
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> I think FIT supports storing U-Boot scripts and running those via
> >>>>> `source` command (usually the file extension is .scr).
> >>>>>
> >>>>> I do not know if there's support for automatically loading this
> >>>>> .scr as part of a config node though, but if there isn't I guess
> >>>>> it'd make more sense to support this case than to come up with yet
> >>>>> another implementation?
> >>>>>
> >>>>> What do you think?
> >>>>
> >>>> I wasn't aware of this, thanks for pointing it out!
> >>>>
> >>>> This patch was mainly inspired by the dm-vertiy use-case which
> >>>> requires just env-variables and no (complex) scripts.
> >>>>
> >>>> There is currently no mechanism to source/run such scripts
> >>>> automatically.
> >>>>
> >>>> How would you distinguish between scripts that should run
> >>>> automatically und scripts which are sourced by a specific
> >>>> board/shell-script implementation? I guess there are good reasons to
> >>>> not run such scripts
> >>>
> >>> Scripts in conf would be automatically run? Scripts not in conf needs
> >>> to be executed via `source` command for example?
> >>>
> >>> Not sure what to do if you want a script linked to a conf but not run
> >>> automatically though (and what would be the use-case?). I guess you
> >>> could have a script automatically run (so in conf node) that sets a
> >>> variable to know where to look for the other script that isn't
> >>> automatically executed?
> >>
> >> Sounds like yet another level of indirection. Not sure if this a good
> >> or a bad thing, but makes things definitely more complicated.
> >>
> >
> > Yes, but this isn't an indirection the project has to support. We
> > currently support scripts that are in the images node to source. We
> > would need to support automatically running the script if it's in a conf
> > node and that'd be it.
> >
> > To be clear, I am not blocking this (and I don't have any veto power
> > anyway :) ), just wanted to raise that something else already exists and
> > could be extended to fit your usecase.
>
> Thanks for the clarification, I appreciate your input.
>
> Yeah, I guess it works somehow using the current 'source'-cmd approach.
> Yocto even supports the integration of a U-Boot environment into the
> kernel FIT-image. However, I think the integration for some dm-vertiy
> env variables is quite cumbersome using this approach. I'd rather prefer
> to have the variables directly in the fit-configuration since they have
> no script character. But this might just be personal preference.

This ended up in my queue.

Is this used with boot scripts? We are trying to move boards to
bootstd and get rid of the scripts, for common cases.

If you are wanting to specify the verity hash, I think it would be
better to add that information. VBE[1] has the concept of 'OS
requests' - see static bootmeth_vbe_ft_fixup() for the implementation.

Here it seems we have a request for the verity hash? So can we add it
that way? Are there any other features you are needed?

Using environment variables seems a bit ad-hoc to me.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/vbe.html
