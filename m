Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E715DC10DC3
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 13:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17878875EB;
	Thu,  7 Dec 2023 14:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M+FF4m/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96DA88753C; Thu,  7 Dec 2023 14:37:52 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C2D874D9
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 14:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7c4602ad8baso211728241.3
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 05:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701956268; x=1702561068; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxDXtWWQrANZgxZZxvieNkWOQAD9VqT3Y548BRLG6OQ=;
 b=M+FF4m/tNG/Pd073yLvpPWBpb01ZPatOiqtGiRDCFKzu/tOwyVvVnAzivCWK0Fw0eV
 yV3aVJGdh/NvN+IRr3D7Vz0jidotWHEdE6l93+u6mbem89yZ02nE7b6+2aWO2D+WKEtk
 O1khKUi8aCrpki4x0jelnlSqoh8K3HJfHJUXn8+2ne+HD3fR1TmxJVh6JPbkMcPKr6gx
 nnUY3B3NJv7nXHsjxx/dpECSdd1qYaT0j6Z6y0ibf1CdyZx1sS5TlqAJNELxdzAU5wF9
 B5a4Ir3V2UeZc/gDcZwdWSzDbacJQjr0D7K23EprtpUujtfj6c/ju044xCVk95FbR35n
 naBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701956268; x=1702561068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxDXtWWQrANZgxZZxvieNkWOQAD9VqT3Y548BRLG6OQ=;
 b=wesBbQrdax63fdk/DtS7YSaBDgRRY/u2F7tLiVrvwvSI8D/PXK0mDg394NfaC5tv48
 C7KZTrQzFntEUQlm+nKJefZ1rOnNjp+XKLxccHOQ9/X9lBaJkAAWFBcNbV4AWqQOM0Qj
 GITptzDTfnplr62XruSF5BTAkqD74YuVfbE6X8/wyqOD0x8q2GkvuBCgxL6nJyc3M+ye
 4YjIbScpAVUtzjWgSb/xlPTgDAAaQ3Nveo1/EjXGONIYqpPAJ0+DFfV5/xYIEaC/MYwF
 dyjMDHtd4FFymoWFkwWfJqIEUSuP4LiAae9p0fK+DswFAL5xGBaBo0Py7QUR0y1wUO1M
 Dw0Q==
X-Gm-Message-State: AOJu0YyIle4l+TqrcNvRpRAcgLTVKyJTsNo5b/m/dEfD3bsMSbi1Xk8+
 S1dp2LSSFzssvO42ApW2b1MbzLq9RvBpYSHRWlg2iQ==
X-Google-Smtp-Source: AGHT+IGyUn3H98toNLv7nRF5UPedyUWIToECEpABMCXPHCdqUFp3m+m6TlofL0CTmjE5nhUfr4aBz3UBKGwlSFs6CfE=
X-Received: by 2002:a1f:c882:0:b0:4b2:f1f8:7f7 with SMTP id
 y124-20020a1fc882000000b004b2f1f807f7mr1901881vkf.6.1701956267740; Thu, 07
 Dec 2023 05:37:47 -0800 (PST)
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
 <CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com>
In-Reply-To: <CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 7 Dec 2023 19:07:35 +0530
Message-ID: <CAFA6WYNqTAVzu_XRPP8gJHh66s5eF29vWRXaxDH=xKSTCkX0+g@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Rob Herring <robh+dt@kernel.org>, u-boot@lists.denx.de, 
 u-boot-custodians@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 neil.armstrong@linaro.org, 
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, conor+dt@kernel.org, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, 
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

On Thu, 7 Dec 2023 at 02:12, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Dec 5, 2023 at 11:05=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Tue, 5 Dec 2023 at 15:39, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 05/12/2023 10:45, Sumit Garg wrote:
> > > > + U-boot custodians list
> > > >
> > > > On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 05/12/2023 08:13, Sumit Garg wrote:
> > > >>>>> @DT bindings maintainers,
> > > >>>>>
> > > >>>>> Given the ease of maintenance of DT bindings within Linux kerne=
l
> > > >>>>> source tree, I don't have a specific objection there. But can w=
e ease
> > > >>>>> DTS testing for firmware/bootloader projects by providing a ver=
sioned
> > > >>>>> release package for DT bindings? Or if someone else has a bette=
r idea
> > > >>>>> here please feel free to chime in.
> > > >>>>
> > > >>>> This doesn't work for you?:
> > > >>>>
> > > >>>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devic=
etree-rebasing.git/
> > > >>>
> > > >>> Thanks, this is certainly a good step which I wasn't aware of. Fu=
rther
> > > >>> simplification can be done to decouple devicetree source files fr=
om DT
> > > >>> bindings.
> > > >>
> > > >> Why?
> > > >
> > > > I suppose you are already aware that Linux DTS files are a subset o=
f
> > > > what could be supported by devicetree schemas. There can be
> > > > firmware/bootloader specific properties (one example being [1]) whi=
ch
> > > > Linux kernel can simply ignore. Will you be willing to add all of
> > > > those DT properties to Linux DTS files and maintain them?
> > >
> > > We already added them and we already maintain them. DTS describes the
> > > hardware, not the OS-subset of the hardware.
> >
> > Let look at some numbers if your statement is justified or not for the
> > example I gave:
> >
> > u-boot$ git grep -nr bootph-* arch/arm* | wc -l
> > 4079
> >
> > linux$ git grep -nr bootph-* arch/arm* | wc -l
> > 267
>
> I have no control over whether anyone has submitted the other 3812 instan=
ces.
>
> > It looks like there is always going to be a catch up game regarding DT
> > properties which either Linux kernel or u-boot or any other
> > firmware/bootloader project don't care about.
>
> As long as dts files in u-boot are manually sync'ed, yes. That is the
> problem and it doesn't matter if we have a standalone repository or
> not.
>
> If you want to move in that direction, start automating what u-boot
> imports. You need to do that for bindings if you want to run
> validation, so why not dts files too?
>
> > > > However, DT bindings are something which should be common, the
> > > > hardware description of a device should be universal. IMO, splittin=
g
> > >
> > > Both DT bindings and DTS should be common. I don't see the difference=
.
> >
> > If we really care about DTS to be common then the contribution model
> > has to change where there is a single repo hosting DT bindings and
> > DTS. All other projects whether it is Linux kernel or u-boot or any
> > other OS/firmware/bootloader are just consuming DTS files from that
> > single repo.
>
> Really, only the kernel and u-boot matter. No, I don't mean I don't
> care about other projects, but those are the 2 with the widest h/w
> support by far and which have a major effort to sync copies of dts
> files in both projects. The rest are just noise in terms of this
> problem.
>
> > I suppose this is something that Linux DT maintainers
> > have objected to in the past for ease of maintenance. I am not sure if
> > you folks are willing to change that stance.
>
> The issue is no one steps up to help maintain such a repository while
> there is lots of review and maintainer work on what goes into the
> kernel tree. I'm happy to direct my binding review attention to
> wherever the majority of the bindings go. But the work on the DTS side
> is mostly SoC tree maintainers and sub-maintainers.
>
> Assume for a minute we have this standalone repo. What happens next?
> We start with an empty repo and then merge and move platforms 1 by 1?
> How many years will that take? What do we do with platforms no one is
> interested in moving? Or do we start with devicetree-rebasing instead
> (That was the plan at one time) and sync u-boot back to that?

Thanks Rob for sharing further insights. So I have given this approach
a try here [1]. Lets see how it can serve u-boot community needs and
thereby bring DT bindings compliance in u-boot.

U-boot community, maintainers, custodians,

Feel free to play out with this DT bindings compliance idea here [1]
and let us know if this approach helps to reduce DT maintainence
burden alongside increasing compliance.

[1] https://github.com/u-boot/u-boot/pull/451

-Sumit

>
> All the work needed to get u-boot and kernel dts files in sync has
> virtually no dependency on a standalone repo. If the dts files aren't
> already kept in sync, someone has to figure the differences and
> eliminate them. Maybe some platforms are in good shape, but it is
> still a manual process. Fix that part, because a standalone repo does
> nothing for you until you do.
>
> > > > DT bindings alone would ease the compliance process for u-boot driv=
ers
> > > > in quite similar manner to Linux drivers.
>
> There's no compliance of drivers really beyond checking if compatible
> strings used by drivers have a schema.
>
> Why is extracting the bindings out a problem? SystemReady has no issue
> doing just that for its compliance test.
>
> Rob
