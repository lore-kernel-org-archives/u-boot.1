Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC7FC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 12:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0042487F31;
	Mon, 19 Feb 2024 13:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j9kLWUol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 927A087EAD; Mon, 19 Feb 2024 07:40:46 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5981987DB7
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 07:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-47043ace534so21184137.2
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 22:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708324839; x=1708929639; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gih0GO6lxYA6Qn9nK+gMlgd30RbeaRC9NNOqdPxy/iQ=;
 b=j9kLWUol+2mcd92Pha5r94sf2N7BvViAtVTFHp0dkQ/qFHdU9adCI04M8heWGUMmsT
 9C8kgGdLk5Ha62Lgw800v9izGLHkNqCurOMtDdP8g6fA+OLxFqvfxpxChK7y+pWrGQJR
 aQxaaIEnatZ1c3tsndZAVPj1TJDgmX4K+4BNoCrCnXGSkdTmTfB8/eqTO7EGg4Yn5OQN
 7ix4tmD0Bzre272ZQHk4MfZvruX+UJEKYFWj0QNjbBfAA26HUdwyCX9PVpzloU2Wqtaw
 1soUybqMGyaDh513/BJ3fnoYsrNKsejI/68QZ/Go/XYkYK6W581zdLiqouuVJ/SsYNPi
 f4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708324839; x=1708929639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gih0GO6lxYA6Qn9nK+gMlgd30RbeaRC9NNOqdPxy/iQ=;
 b=c3lmQDjkAEWUmYdhkzbq/0eVZ61E9gco79JonDX2dzd2g/GD6V1bM9JDwA9XyaIqYB
 vcNr6AsJDtSV8WMfRfWQt1WfL1FWrOY/ViHo3ZU8Z6NvtqPnmH+uxCn0zjb4appOap3/
 xKgdNtlxdN2SRxP8HuEsrKmAFUoJb+50+oudA+HaMGWmEy1b9kIygV++79cXDYw6jaeH
 sqBB8qAXNtjXP8kZCoBx6jlsr0YoWhOhc6/rJhau4Z2AyL4KVc/pw2GTdTtbZoaiXFeE
 A+gJPKpqeCn9IlhgG0rh3du3BLsIq2t1zG7ncH73u6KqHLQ7Dj2ziO8MWh+xQq+562g1
 5Z+w==
X-Gm-Message-State: AOJu0Yx15UIgzj9gUqs0F7yEBU5r5Xid1VQq8E2+Ikenzizdn8QAqtAA
 ikUkzbQ+rhiae3lfGHCImowaUgpS5DPkczY3wRbNnRNWEhjthUNAhouB4tXLVwqbWIrZrZISD3o
 EPC/TyV4N0IMEbkPZznuKqsJl+vfbQ8OVDSZU9w==
X-Google-Smtp-Source: AGHT+IGi1d5njPRfh80AHzWM6rl0/WwblY3nEx9D98J0ZLsJ/bK1l2mMIlm4YHSwMVp6ywOg9B0iuJaSLe3nrUbbDKc=
X-Received: by 2002:a05:6102:90:b0:470:5edf:42f1 with SMTP id
 t16-20020a056102009000b004705edf42f1mr746234vsp.15.1708324838374; Sun, 18 Feb
 2024 22:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-9-sumit.garg@linaro.org>
 <518d87fc-457e-4d77-ba66-9e3a5aa15279@bp.renesas.com>
 <CAFA6WYOdYK4vAibGEQ9SnNCGMv00AKYkzZu+capfW9E4y=cFHA@mail.gmail.com>
 <e5eec82e-359d-45ad-a01d-6d852fe78d99@bp.renesas.com>
In-Reply-To: <e5eec82e-359d-45ad-a01d-6d852fe78d99@bp.renesas.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 19 Feb 2024 12:10:27 +0530
Message-ID: <CAFA6WYPYSj4Am1jZMyAM-4VpxoqMbBiSOTSVMsjF2MabA-UeXQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] doc: devicetree: Updates for devicetree-rebasing
 subtree
To: Paul Barker <paul.barker.ct@bp.renesas.com>, robh+dt@kernel.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
 nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 19 Feb 2024 13:07:56 +0100
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

On Fri, 16 Feb 2024 at 16:17, Paul Barker <paul.barker.ct@bp.renesas.com> w=
rote:
>
> On 14/02/2024 13:32, Sumit Garg wrote:
> > On Wed, 14 Feb 2024 at 03:01, Paul Barker <paul.barker.ct@bp.renesas.co=
m> wrote:
> >> On 02/02/2024 13:05, Sumit Garg wrote:
> >>> +Dependencies
> >>> +~~~~~~~~~~~~
> >>> +
> >>> +The DT schema project must be installed in order to validate the DT =
schema
> >>> +binding documents and validate DTS files using the DT schema. The DT=
 schema
> >>> +project can be installed with pip::
> >>> +
> >>> +    pip3 install dtschema
> >>
> >> Unfortunately this won't work on recent distro versions, e.g. on Debia=
n
> >> 12 I get:
> >>
> >>     error: externally-managed-environment
> >>
> >>     =C3=97 This environment is externally managed
> >>     =E2=95=B0=E2=94=80> To install Python packages system-wide, try ap=
t install
> >>         python3-xyz, where xyz is the package you are trying to
> >>         install.
> >>
> >>         If you wish to install a non-Debian-packaged Python package,
> >>         create a virtual environment using python3 -m venv path/to/ven=
v.
> >>         Then use path/to/venv/bin/python and path/to/venv/bin/pip. Mak=
e
> >>         sure you have python3-full installed.
> >>
> >>         If you wish to install a non-Debian packaged Python applicatio=
n,
> >>         it may be easiest to use pipx install xyz, which will manage a
> >>         virtual environment for you. Make sure you have pipx installed=
.
> >>
> >>         See /usr/share/doc/python3.11/README.venv for more information=
.
> >>
> >>     note: If you believe this is a mistake, please contact your Python
> >>     installation or OS distribution provider. You can override this, a=
t the
> >>     risk of breaking your Python installation or OS, by passing
> >>     --break-system-packages.
> >>     hint: See PEP 668 for the detailed specification.
> >>
> >> I don't have a good solution to recommend here - there's no consensus =
on
> >> how to install Python tools for use in development. You could use
> >> `pipx`, you could create a virtualenv, and I'm sure there are other
> >> options as well. Perhaps we just need to leave it up to the reader to
> >> find out how to install dtschema on their system.
> >
> > I suppose you haven't installed python3-pip package [1] on your Debian
> > 12. BTW, `pip3` is being used as the common way to install dtschema
> > [2]. Also, every user may not be aware about python virtual
> > environments. So it's better to provide the commonly used pip3 option
> > for installation.
>
> The python3-pip package is installed, it's the pip3 program that is
> printing the error message I saw. This is the new behaviour in Debian
> 12, also seen in rolling distributions like Arch Linux and OpenSuSE
> Tumbleweed since the middle of last year. There is a good guide to this
> from Python=3D>Speed [1] and more detail in the Python packaging spec [2]=
.
> Sadly it's something we now have to live with in recent Linux distro
> releases, and I expect all distros will enable this in upcoming
> releases.

Okay I see, thanks for bringing it up. I hope Rob will take note of
this and update dtschema installation instructions [1] accordingly.

As part of v6, I will rather guide users towards the dtschema github
page in order to get installation instructions.

[1] https://github.com/devicetree-org/dt-schema/tree/main?tab=3Dreadme-ov-f=
ile#installing

-Sumit

>
> [1]: https://pythonspeed.com/articles/externally-managed-environment-pep-=
668/
> [2]: https://packaging.python.org/en/latest/specifications/externally-man=
aged-environments/#externally-managed-environments
>
> Thanks,
>
> --
> Paul Barker
