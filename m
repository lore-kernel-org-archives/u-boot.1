Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FD8C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 07:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C766587655;
	Tue,  5 Dec 2023 08:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l1lsSank";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC568718A; Tue,  5 Dec 2023 08:13:36 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB71387655
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 08:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d7b1a8ec90so16768987b3.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701760411; x=1702365211; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8x/KON2Fmch9oHEwA2F33eHwMjO6yn9P0c4M+7zilgE=;
 b=l1lsSankYOm5j6bM929Sg2rYHI98WPTTJs3dAt9Y5JSBROd5rW0CVkTK+RhXzF1uoX
 Vp37GE5kFZbpYem2qGV7HD96FKfDaTVE19roJdbidoaAg3BNkbwYa2sMUMk3q8XB3uCt
 KxRDVKV20ADyITQqK5UWmjEEEX6cufqd2yvafp7jOUl/uC2ePpzYRPdbxe5kkNs7acyV
 9/i1sb9U60TjTWizEfpIMxMty+vdxG4Z9zFhqF+f22JpBXkNsA9sjoor0TZ2V/dN53Vy
 h9ojQnd6ncWu3Dc+RaGUCOj4oQEmXn7d2ebDJm2qI37yVjuEkBOcH53h8MGBFlU+hFFp
 6a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701760411; x=1702365211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8x/KON2Fmch9oHEwA2F33eHwMjO6yn9P0c4M+7zilgE=;
 b=vzEoL4CNMOuY/QRLlEAm1/WbmEVzTj3s/4fKzA39zeIxELXo0k11P7BSlOshuMgKu1
 f9uFfwaqZuKfknANNMUIoI0P+ryPR5Ma7RsyYHTO6Bv5xXsX1V3YQCWIW4gvRICKkvBH
 H3dO/M1zTsRWjdNX2jp6vZuLAEZz889ESAHiI/xqaxfrxemrfIORtmaetW+OtVSS9Mhe
 2VRBFdIQkwSqOWIyygZYLjT0k3UQUsF8FSJmD7vgRp4fOGHXpyADUArSy6iGzWSUadA7
 f3TazVoARkmV5wjbGG7b97hQfyH/rQtiozeat/uFoJyl2xUzWwIKBNdTMHhqkycKdXgx
 l80Q==
X-Gm-Message-State: AOJu0YwequSw7FSIApUMZqnfyFzgZYsvni5TPh3fuBBJm7ZqRyQGTAUJ
 6QdFMyA4ZAK2Fhsg0KamronGyWSKvlEyWUWP+Vwe1A==
X-Google-Smtp-Source: AGHT+IGVJzwZCQqzJ7GSlJoG4zgLX8vRP+Y0VmRMzuf5WAPAjjnItGbDerO4HO+NaB/jrHnd3jMJcgLGbSJWpPsDOM4=
X-Received: by 2002:a81:9104:0:b0:5d1:bffb:b2b5 with SMTP id
 i4-20020a819104000000b005d1bffbb2b5mr2311132ywg.52.1701760411592; Mon, 04 Dec
 2023 23:13:31 -0800 (PST)
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
In-Reply-To: <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Dec 2023 12:43:20 +0530
Message-ID: <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Rob Herring <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 conor+dt@kernel.org, 
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

On Mon, 4 Dec 2023 at 22:31, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Sun, Dec 3, 2023 at 11:33=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > + Linux kernel DT bindings maintainers, EBBR ML
> >
> > On Thu, 30 Nov 2023 at 20:05, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Nov 30, 2023 at 01:02:25PM +0530, Sumit Garg wrote:
> > > > On Wed, 29 Nov 2023 at 22:06, Neil Armstrong <neil.armstrong@linaro=
.org> wrote:
> > > > >
> > > > > On 29/11/2023 16:34, Caleb Connolly wrote:
> > > > > >
> > > > > >
> > > > > > On 23/11/2023 07:04, Sumit Garg wrote:
> > > > > >> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@l=
inaro.org> wrote:
> > > > > >>>
> > > > > >>>
> > > > > >>>
> > > > > >>> On 22/11/2023 14:27, Tom Rini wrote:
> > > > > >>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> > > > > >>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > >>>>>>
> > > > > >>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote=
:
> > > > > >>>>>>> Hi Caleb,
> > > > > >>>>>>>
> > > > > >>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.conno=
lly@linaro.org> wrote:
> > > > > >>>>>> [snip]
> > > > > >>>>>>>> =3D=3D DT loading =3D=3D
> > > > > >>>>>>>>
> > > > > >>>>>>>> Previously, boards used the FDT blob embedded into U-Boo=
t (via
> > > > > >>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot a=
s a secondary
> > > > > >>>>>>>> bootloader, so we can instead rely on the first-stage bo=
otloader to
> > > > > >>>>>>>> populate some useful FDT properties for us (notably the =
/memory node and
> > > > > >>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined=
 with the memory
> > > > > >>>>>>>> map changes above, this let's us entirely avoid configur=
ing the memory
> > > > > >>>>>>>> map explicitly.
> > > > > >>>>>>>
> > > > > >>>>>>> Since with this change, we don't need to embed FDT blob i=
n the u-boot
> > > > > >>>>>>> binary, so I was thinking if we really need to import DTs=
 from Linux
> > > > > >>>>>>> for different platforms and then play a catchup game?
> > > > > >>>
> > > > > >>> For now, yes.
> > > > > >>
> > > > > >> But why? Is there any value added by larger u-boot specific DT=
 (most
> > > > > >> of the nodes being unused by u-boot) than what currently u-boo=
t
> > > > > >> supports? The more important part is to get alignment with Lin=
ux DT
> > > > > >> bindings. If you need to have memory/reserved-memory nodes in =
u-boot
> > > > > >> DT for generalization purposes then you should import those pa=
rticular
> > > > > >> nodes only.
> > > > > >
> > > > > > I've been thinking about and hacking on this for the last week =
or so,
> > > > > > sorry for the delayed reply here.
> > > > > >
> > > > > > The value is in preventing any of the existing bindings from re=
gressing,
> > > >
> > > > That is actually best addressed in Linux by checking the DTS agains=
t
> > > > yaml DT bindings. We don't have that testing available in u-boot an=
d
> > > > only depend on careful reviews.
> > >
> > > I would absolutely love for someone to make another attempt at updati=
ng
> > > our kbuild infrastucture so that we can run the validation targets.
> > >
> >
> > Given that EBBR requires [1] the platform (firmware/bootloader) and
> > not OS to supply the devicetree, it becomes evident that
> > firmware/bootloaders import DTS from Linux kernel (where it is
> > maintained).
> >
> > But currently u-boot doesn't have a proper way to validate those DTS
> > against DT bindings (maintained in Linux kernel). Although there are
> > Devicetree schema tools available here [2], there isn't a versioned
> > release package of DT bindings which one should use to validate DTS
> > files.
> >
> > @DT bindings maintainers,
> >
> > Given the ease of maintenance of DT bindings within Linux kernel
> > source tree, I don't have a specific objection there. But can we ease
> > DTS testing for firmware/bootloader projects by providing a versioned
> > release package for DT bindings? Or if someone else has a better idea
> > here please feel free to chime in.
>
> This doesn't work for you?:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-reb=
asing.git/

Thanks, this is certainly a good step which I wasn't aware of. Further
simplification can be done to decouple devicetree source files from DT
bindings. AFAIK, DT bindings should be forwards and backwards
compatible. So if you pick up DTS or DTB from any project tree
(upstream kernel or stable kernel or u-boot) then DT schema validation
would ensure that corresponding DTS or DTB doesn't regress the DT
bindings.

Ideally, it should be more user/CI friendly if DT bindings can be
easily installed alongside devicetree schema tools [1].

[1] https://github.com/devicetree-org/dt-schema

>
> Note that I would like to revamp this repo to use some modern CI job,
> use git_filter_repo python module rather than git-filter-branch, and
> move to devicetree.org GH, but if projects aren't relying on this
> repo, I'm not motivated to do that work.

As Tom has shown interest in this, I think we should be able to add
the DT validation checks during normal u-boot builds hidden behind a
Makefile option (dtbs_check).

-Sumit

>
> Rob
