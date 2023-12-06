Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BBEC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 20:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F80870FC;
	Wed,  6 Dec 2023 21:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kHyohIk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78938721C; Wed,  6 Dec 2023 21:42:44 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07D7870F4;
 Wed,  6 Dec 2023 21:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robh+dt@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2148261E8F;
 Wed,  6 Dec 2023 20:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAD5C433AB;
 Wed,  6 Dec 2023 20:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701895358;
 bh=ggp+XIPhO15WDgS3W3AX7qL3knO3YvVJR7Lw8eHACIM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kHyohIk+rBIdXzzScBOfIXUC1gl9W/ecAiUBmcCIOFuXU9cFx3lVenPHA4D07kriL
 xb3ZeyhgeYeiKIVM+fSnefg1luGwD0nDeeOc/Zcb4uJxNbzbOheko5wuD+/FYwIUVf
 VUbgsqgbIHLT2ycURDNtTEVYFOasztzyphMpwP5i0/sDBIFv98FIH3ZniTBeEcY9ML
 xVqcl53IkKuHy9Xygs6ypekWDyrVRXs1U0jnr4yUQT4hqVwLWl0tl+DH6yOzBiOaXo
 MV8BNasCVJ3Lm9/ND/CBpVCePTSbSbmFDiL763LyH0zlm1yTaAiJxMeQg5AKxDt5kK
 /No4qomTFAPVw==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-50c05ea5805so292702e87.0; 
 Wed, 06 Dec 2023 12:42:38 -0800 (PST)
X-Gm-Message-State: AOJu0YyUPk/CxUYm0LxfBk1yQh61DJAE9h/ryFhOe/ovD4+XSPQUefNT
 BabdXS74Gu+1UPOoZpgIAvUZANDexoAm3W6+og==
X-Google-Smtp-Source: AGHT+IEQ7RrVcCA72/WaghhgxNwD4T/QPbAudBDeTdDkteHD8bcIpHP3xQzOgWALwQ0/8k6LooilxO3RNmizW9hbwFQ=
X-Received: by 2002:a05:6512:3c90:b0:50b:e4a7:7986 with SMTP id
 h16-20020a0565123c9000b0050be4a77986mr1089421lfv.124.1701895356929; Wed, 06
 Dec 2023 12:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
 <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
 <34334add-4017-46f6-873a-d9233e29f640@linaro.org>
 <CAFA6WYN_uf0+tHm7RxXXz_7U3tdbdsK1rttnQN-rcfRknrcDQA@mail.gmail.com>
In-Reply-To: <CAFA6WYN_uf0+tHm7RxXXz_7U3tdbdsK1rttnQN-rcfRknrcDQA@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 6 Dec 2023 14:42:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com>
Message-ID: <CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 u-boot-custodians@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, conor+dt@kernel.org, 
 Caleb Connolly <caleb.connolly@linaro.org>, neil.armstrong@linaro.org, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
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

On Tue, Dec 5, 2023 at 11:05=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 5 Dec 2023 at 15:39, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 05/12/2023 10:45, Sumit Garg wrote:
> > > + U-boot custodians list
> > >
> > > On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 05/12/2023 08:13, Sumit Garg wrote:
> > >>>>> @DT bindings maintainers,
> > >>>>>
> > >>>>> Given the ease of maintenance of DT bindings within Linux kernel
> > >>>>> source tree, I don't have a specific objection there. But can we =
ease
> > >>>>> DTS testing for firmware/bootloader projects by providing a versi=
oned
> > >>>>> release package for DT bindings? Or if someone else has a better =
idea
> > >>>>> here please feel free to chime in.
> > >>>>
> > >>>> This doesn't work for you?:
> > >>>>
> > >>>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicet=
ree-rebasing.git/
> > >>>
> > >>> Thanks, this is certainly a good step which I wasn't aware of. Furt=
her
> > >>> simplification can be done to decouple devicetree source files from=
 DT
> > >>> bindings.
> > >>
> > >> Why?
> > >
> > > I suppose you are already aware that Linux DTS files are a subset of
> > > what could be supported by devicetree schemas. There can be
> > > firmware/bootloader specific properties (one example being [1]) which
> > > Linux kernel can simply ignore. Will you be willing to add all of
> > > those DT properties to Linux DTS files and maintain them?
> >
> > We already added them and we already maintain them. DTS describes the
> > hardware, not the OS-subset of the hardware.
>
> Let look at some numbers if your statement is justified or not for the
> example I gave:
>
> u-boot$ git grep -nr bootph-* arch/arm* | wc -l
> 4079
>
> linux$ git grep -nr bootph-* arch/arm* | wc -l
> 267

I have no control over whether anyone has submitted the other 3812 instance=
s.

> It looks like there is always going to be a catch up game regarding DT
> properties which either Linux kernel or u-boot or any other
> firmware/bootloader project don't care about.

As long as dts files in u-boot are manually sync'ed, yes. That is the
problem and it doesn't matter if we have a standalone repository or
not.

If you want to move in that direction, start automating what u-boot
imports. You need to do that for bindings if you want to run
validation, so why not dts files too?

> > > However, DT bindings are something which should be common, the
> > > hardware description of a device should be universal. IMO, splitting
> >
> > Both DT bindings and DTS should be common. I don't see the difference.
>
> If we really care about DTS to be common then the contribution model
> has to change where there is a single repo hosting DT bindings and
> DTS. All other projects whether it is Linux kernel or u-boot or any
> other OS/firmware/bootloader are just consuming DTS files from that
> single repo.

Really, only the kernel and u-boot matter. No, I don't mean I don't
care about other projects, but those are the 2 with the widest h/w
support by far and which have a major effort to sync copies of dts
files in both projects. The rest are just noise in terms of this
problem.

> I suppose this is something that Linux DT maintainers
> have objected to in the past for ease of maintenance. I am not sure if
> you folks are willing to change that stance.

The issue is no one steps up to help maintain such a repository while
there is lots of review and maintainer work on what goes into the
kernel tree. I'm happy to direct my binding review attention to
wherever the majority of the bindings go. But the work on the DTS side
is mostly SoC tree maintainers and sub-maintainers.

Assume for a minute we have this standalone repo. What happens next?
We start with an empty repo and then merge and move platforms 1 by 1?
How many years will that take? What do we do with platforms no one is
interested in moving? Or do we start with devicetree-rebasing instead
(That was the plan at one time) and sync u-boot back to that?

All the work needed to get u-boot and kernel dts files in sync has
virtually no dependency on a standalone repo. If the dts files aren't
already kept in sync, someone has to figure the differences and
eliminate them. Maybe some platforms are in good shape, but it is
still a manual process. Fix that part, because a standalone repo does
nothing for you until you do.

> > > DT bindings alone would ease the compliance process for u-boot driver=
s
> > > in quite similar manner to Linux drivers.

There's no compliance of drivers really beyond checking if compatible
strings used by drivers have a schema.

Why is extracting the bindings out a problem? SystemReady has no issue
doing just that for its compliance test.

Rob
