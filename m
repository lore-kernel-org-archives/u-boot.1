Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7906C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 18:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF5787136;
	Thu,  7 Dec 2023 19:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GlsGiwvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0462D874C7; Thu,  7 Dec 2023 19:51:25 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B8A86BAC;
 Thu,  7 Dec 2023 19:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robh+dt@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 4344FB82A07;
 Thu,  7 Dec 2023 18:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992DFC433C7;
 Thu,  7 Dec 2023 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701975081;
 bh=b5VRirMKI+dPPPskcwQt1GSFDQfapRV9Ebfhdq4ykj4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GlsGiwvlGOEwxj+jZt2xzL5uEVWmyI65UFa31DN/G6q7fx5WbXSKQWiL4ezLPkSBF
 NzRu4AV1n5LiC/0pq+fdi17nq5K89/YrI1UGlgnc770rUmde66X8eGphTH1rb82159
 Kz9k5X3yWi6oUqgPbk5tGpP3byByrOnwZPdf5PfKsirdf9T3YxmuIAGmOdzn38ozSy
 ZWLn03u67LgffRZq6uoxOP50hW2X2qZUZkPe8SpBVpHy9QekMID5alSxVnQnLW0nKo
 KXo1uFcSVKhkVIQgMbTvnbjpsgNVBXK38FkwZSdlQY/KFnhGkCrhmtzm5uOhpH2+DN
 SuFVqFddcZJwA==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-50c0478f970so1144074e87.3; 
 Thu, 07 Dec 2023 10:51:21 -0800 (PST)
X-Gm-Message-State: AOJu0YwjygAEnjfD64m7VDmubkF5gnr25pCfi9Pu0VBEn+jpn5MRtHRf
 NBky+G7ENsiS4MIpie5A1W1H/hKEPNoYIseCLA==
X-Google-Smtp-Source: AGHT+IEJUajS59MlUkq7pBUCYWvBfnz46EOd+wBrZr0P2s9GVq7WgslZOAf+mch3PWI1HcfSPyCFMvSq9i9WSCt+Wdo=
X-Received: by 2002:ac2:57ca:0:b0:50c:c7d:9ef2 with SMTP id
 k10-20020ac257ca000000b0050c0c7d9ef2mr1503385lfo.131.1701975079817; Thu, 07
 Dec 2023 10:51:19 -0800 (PST)
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
 <5C77B3D5-3659-40BC-86BB-E73E7034E017@shokubai.tech>
In-Reply-To: <5C77B3D5-3659-40BC-86BB-E73E7034E017@shokubai.tech>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 7 Dec 2023 12:51:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLBQCStz39-5d0CSnZzuSfc6473d2=HEY2NF7Hm83L9YA@mail.gmail.com>
Message-ID: <CAL_JsqLBQCStz39-5d0CSnZzuSfc6473d2=HEY2NF7Hm83L9YA@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: ff <ff@shokubai.tech>
Cc: Sumit Garg <sumit.garg@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, 
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

On Thu, Dec 7, 2023 at 2:08=E2=80=AFAM ff <ff@shokubai.tech> wrote:
>
>
>
> > Le 6 d=C3=A9c. 2023 =C3=A0 21:42, Rob Herring <robh+dt@kernel.org> a =
=C3=A9crit :
> >
> > =EF=BB=BFOn Tue, Dec 5, 2023 at 11:05=E2=80=AFPM Sumit Garg <sumit.garg=
@linaro.org> wrote:
> >>
> >>> On Tue, 5 Dec 2023 at 15:39, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 05/12/2023 10:45, Sumit Garg wrote:
> >>>> + U-boot custodians list
> >>>>
> >>>> On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
> >>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>
> >>>>> On 05/12/2023 08:13, Sumit Garg wrote:
> >>>>>>>> @DT bindings maintainers,
> >>>>>>>>
> >>>>>>>> Given the ease of maintenance of DT bindings within Linux kernel
> >>>>>>>> source tree, I don't have a specific objection there. But can we=
 ease
> >>>>>>>> DTS testing for firmware/bootloader projects by providing a vers=
ioned
> >>>>>>>> release package for DT bindings? Or if someone else has a better=
 idea
> >>>>>>>> here please feel free to chime in.
> >>>>>>>
> >>>>>>> This doesn't work for you?:
> >>>>>>>
> >>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/device=
tree-rebasing.git/
> >>>>>>
> >>>>>> Thanks, this is certainly a good step which I wasn't aware of. Fur=
ther
> >>>>>> simplification can be done to decouple devicetree source files fro=
m DT
> >>>>>> bindings.
> >>>>>
> >>>>> Why?
> >>>>
> >>>> I suppose you are already aware that Linux DTS files are a subset of
> >>>> what could be supported by devicetree schemas. There can be
> >>>> firmware/bootloader specific properties (one example being [1]) whic=
h
> >>>> Linux kernel can simply ignore. Will you be willing to add all of
> >>>> those DT properties to Linux DTS files and maintain them?
> >>>
> >>> We already added them and we already maintain them. DTS describes the
> >>> hardware, not the OS-subset of the hardware.
> >>
> >> Let look at some numbers if your statement is justified or not for the
> >> example I gave:
> >>
> >> u-boot$ git grep -nr bootph-* arch/arm* | wc -l
> >> 4079
> >>
> >> linux$ git grep -nr bootph-* arch/arm* | wc -l
> >> 267
> >
> > I have no control over whether anyone has submitted the other 3812 inst=
ances.
> >
> >> It looks like there is always going to be a catch up game regarding DT
> >> properties which either Linux kernel or u-boot or any other
> >> firmware/bootloader project don't care about.
> >
> > As long as dts files in u-boot are manually sync'ed, yes. That is the
> > problem and it doesn't matter if we have a standalone repository or
> > not.
> >
> > If you want to move in that direction, start automating what u-boot
> > imports. You need to do that for bindings if you want to run
> > validation, so why not dts files too?
> >
> >>>> However, DT bindings are something which should be common, the
> >>>> hardware description of a device should be universal. IMO, splitting
> >>>
> >>> Both DT bindings and DTS should be common. I don't see the difference=
.
> >>
> >> If we really care about DTS to be common then the contribution model
> >> has to change where there is a single repo hosting DT bindings and
> >> DTS. All other projects whether it is Linux kernel or u-boot or any
> >> other OS/firmware/bootloader are just consuming DTS files from that
> >> single repo.
> >
> > Really, only the kernel and u-boot matter. No, I don't mean I don't
> > care about other projects, but those are the 2 with the widest h/w
> > support by far and which have a major effort to sync copies of dts
> > files in both projects. The rest are just noise in terms of this
> > problem.
> >
> >> I suppose this is something that Linux DT maintainers
> >> have objected to in the past for ease of maintenance. I am not sure if
> >> you folks are willing to change that stance.
> >
> > The issue is no one steps up to help maintain such a repository while
> > there is lots of review and maintainer work on what goes into the
> > kernel tree. I'm happy to direct my binding review attention to
> > wherever the majority of the bindings go. But the work on the DTS side
> > is mostly SoC tree maintainers and sub-maintainers.
> >
> > Assume for a minute we have this standalone repo. What happens next?
> > We start with an empty repo and then merge and move platforms 1 by 1?
>
> What about leveraging SystemReady-IR compliant board maintainers and star=
t with a core of motivated people ?

I think there are 2 ATM. Synquacer and i.MX8 variants. Synquacer only
has a DT in u-boot, so not really anything to do there. I'm pretty
sure the certified DTBs for i.MX8 don't match what's in u-boot or the
kernel tree. Hopefully, it's just a subset, but still, there's a gap.
I don't know that there is motivation there either.

Note that SystemReady currently only requires every node with
'compatible' have a schema. It does not yet require no schema
warnings. If we went with a 1 by 1 approach, I would push that
platforms have to be free of warnings.

> > How many years will that take?
>
> Should all platforms following that organization be a goal?

You mean should all platforms be moved? Absolutely. I don't think we
want to solve the problem of having DTS files in 2 places by creating
a 3rd place.

I don't really think 1 by 1 is the right approach. I was just
enumerating how this could work. It's not that useful to say we need a
standalone repo without working thru the logistics of how exactly that
will work.

Rob
