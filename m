Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1C6C10DC1
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 17:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A88870F4;
	Mon,  4 Dec 2023 18:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A5xYf9fI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD63870F2; Mon,  4 Dec 2023 18:01:54 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFAB86D37
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 18:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robh+dt@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 0E023B81076
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 17:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9425C433CC
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701709310;
 bh=HouZitkEa3BlZ1+iedR46jeMbKp0nskkQObZLwF3fhE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=A5xYf9fIyeYugM4bzJ7V7c6EsGCmyGMbCx70ZzUhOg7SO5uruyoT+deQUCCBy2eYA
 apLlW8x9EauiZgHwj5hMNvre9Pp6fReLgXh2s3+9f4RBuYUtqAPUdNSk3tY/7j2SfM
 KTFS2NYQkIyon+TLOhvWNNGelcufhLoIGjvKvQc1x1OBkaxD6z0NbkiZn4hq3DF0eT
 FxLdXw1b5gw1ruDHM8KBBuSfltbCvqKh/plsSRfoR+AZHsAmwq67MzWMSR4Hp5yRpe
 meoBBipv62UU56GiXjsoJXg1LPly+rffkXqxagqW4ZvYSXSUX2Ckn7KBVWMmL8L3Xa
 N/T/Tfffdy4bw==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-50bc22c836bso6276478e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 09:01:50 -0800 (PST)
X-Gm-Message-State: AOJu0YxM7GWt2TO5pZJJJ4tOZsjQmor95meU9op/azj+YsNeOLPyBIle
 1915rVUGxarGCnSqXU3Mt0ZNh6GJkZIuwV5b7A==
X-Google-Smtp-Source: AGHT+IGRO6s7f1oPcENESyOug3YsUnbDD8pWvujj7N3gIwoJP67HqHjdeVpb9VI8zpYHBkE7D7ZfLfqDSxgFLr+5OEg=
X-Received: by 2002:ac2:5f6c:0:b0:50b:f648:e17a with SMTP id
 c12-20020ac25f6c000000b0050bf648e17amr971752lfc.108.1701709308770; Mon, 04
 Dec 2023 09:01:48 -0800 (PST)
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
In-Reply-To: <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 4 Dec 2023 11:01:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
Message-ID: <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, 
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

On Sun, Dec 3, 2023 at 11:33=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> + Linux kernel DT bindings maintainers, EBBR ML
>
> On Thu, 30 Nov 2023 at 20:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Nov 30, 2023 at 01:02:25PM +0530, Sumit Garg wrote:
> > > On Wed, 29 Nov 2023 at 22:06, Neil Armstrong <neil.armstrong@linaro.o=
rg> wrote:
> > > >
> > > > On 29/11/2023 16:34, Caleb Connolly wrote:
> > > > >
> > > > >
> > > > > On 23/11/2023 07:04, Sumit Garg wrote:
> > > > >> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@lin=
aro.org> wrote:
> > > > >>>
> > > > >>>
> > > > >>>
> > > > >>> On 22/11/2023 14:27, Tom Rini wrote:
> > > > >>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> > > > >>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> w=
rote:
> > > > >>>>>>
> > > > >>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> > > > >>>>>>> Hi Caleb,
> > > > >>>>>>>
> > > > >>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connoll=
y@linaro.org> wrote:
> > > > >>>>>> [snip]
> > > > >>>>>>>> =3D=3D DT loading =3D=3D
> > > > >>>>>>>>
> > > > >>>>>>>> Previously, boards used the FDT blob embedded into U-Boot =
(via
> > > > >>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as =
a secondary
> > > > >>>>>>>> bootloader, so we can instead rely on the first-stage boot=
loader to
> > > > >>>>>>>> populate some useful FDT properties for us (notably the /m=
emory node and
> > > > >>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined w=
ith the memory
> > > > >>>>>>>> map changes above, this let's us entirely avoid configurin=
g the memory
> > > > >>>>>>>> map explicitly.
> > > > >>>>>>>
> > > > >>>>>>> Since with this change, we don't need to embed FDT blob in =
the u-boot
> > > > >>>>>>> binary, so I was thinking if we really need to import DTs f=
rom Linux
> > > > >>>>>>> for different platforms and then play a catchup game?
> > > > >>>
> > > > >>> For now, yes.
> > > > >>
> > > > >> But why? Is there any value added by larger u-boot specific DT (=
most
> > > > >> of the nodes being unused by u-boot) than what currently u-boot
> > > > >> supports? The more important part is to get alignment with Linux=
 DT
> > > > >> bindings. If you need to have memory/reserved-memory nodes in u-=
boot
> > > > >> DT for generalization purposes then you should import those part=
icular
> > > > >> nodes only.
> > > > >
> > > > > I've been thinking about and hacking on this for the last week or=
 so,
> > > > > sorry for the delayed reply here.
> > > > >
> > > > > The value is in preventing any of the existing bindings from regr=
essing,
> > >
> > > That is actually best addressed in Linux by checking the DTS against
> > > yaml DT bindings. We don't have that testing available in u-boot and
> > > only depend on careful reviews.
> >
> > I would absolutely love for someone to make another attempt at updating
> > our kbuild infrastucture so that we can run the validation targets.
> >
>
> Given that EBBR requires [1] the platform (firmware/bootloader) and
> not OS to supply the devicetree, it becomes evident that
> firmware/bootloaders import DTS from Linux kernel (where it is
> maintained).
>
> But currently u-boot doesn't have a proper way to validate those DTS
> against DT bindings (maintained in Linux kernel). Although there are
> Devicetree schema tools available here [2], there isn't a versioned
> release package of DT bindings which one should use to validate DTS
> files.
>
> @DT bindings maintainers,
>
> Given the ease of maintenance of DT bindings within Linux kernel
> source tree, I don't have a specific objection there. But can we ease
> DTS testing for firmware/bootloader projects by providing a versioned
> release package for DT bindings? Or if someone else has a better idea
> here please feel free to chime in.

This doesn't work for you?:

https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebas=
ing.git/

Note that I would like to revamp this repo to use some modern CI job,
use git_filter_repo python module rather than git-filter-branch, and
move to devicetree.org GH, but if projects aren't relying on this
repo, I'm not motivated to do that work.

Rob
