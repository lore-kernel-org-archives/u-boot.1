Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C85BD149D6
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 17:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D234D8901D;
	Fri, 25 Oct 2024 19:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="IeEEO7Jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EC68902F; Fri, 25 Oct 2024 19:13:13 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1413888EB
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e2e32bc454fso2416397276.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1729876386; x=1730481186; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORny14xek4xjdLph4WsCBkzL6DNwkRU44aIrCUkh/kY=;
 b=IeEEO7JlDvIs2l+cmVmX0aUeSkkIM4a+ZtNxZoIV74goTNX+tpRYxb/WnYcRFTJKgF
 w0NuU7CkcMMVa6kQgN2MMLwux6p1hsXs+jSp7gtpeu0Y2aziP+va1BIDGrnmUS8+NlYd
 3nUALtocy+dokmSoZNXf9A18hMQkUuH9HeLixZXeEbQadoICI/e0XM5k4XLeOLB00XdK
 cvXgj7NQMKlhi3W+SaJJvhEAZJcBk8W+sQI6JxZFLHtQ6oYc55b8HiVjgWmBSbT4CqiZ
 Ra0yO9xq80U/i2b+6rAvkCxM9wWdhAgQAG4N9+i/HYQh7sxw1wNNV6iG8JzVRS69QnQr
 LlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729876386; x=1730481186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORny14xek4xjdLph4WsCBkzL6DNwkRU44aIrCUkh/kY=;
 b=VZJY8QdepI3224+1Yc/kY3amvs2N6V4wEZgA8jv3LN/rBh7+UFpW7fmUATyAkdbKkY
 8AgZwLQ6hch1XxQstExhlLRp+z6GHMZzQfo6lSftuSSXDleO3MEr/6llRJBAgFbMq4s9
 fCdhdWuFcDX3cxFHgoJ3VUvkAjRCtAusfsp9sfOisHFpQNMeFMTHV8oni3HvO6Ky2g0Z
 2Xa1VneBAgFKsWoWIJ5th4CrT0L7t7PsLgftIsw1nA+J+PFPkdkXLTMeY3eccAI0Kja6
 LOyBWhRvDQFKnMmhXy7kOTAoKkvcK6qYvbBSDU69adUyJexIWhU1kmaatY7Q3PDRLTZh
 rSAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi0zHsi3D29MCRafS7HqMNV8Djhf2VQAdaM24Ue9rA3B40ac2UM11BvrdbN08VmPWLYyR3hFg=@lists.denx.de
X-Gm-Message-State: AOJu0YyS1x9+mWLtwyAlf2oY9z+3iyr6m/g3ntDSwNtJbvuz79rB+psq
 VzQChEkKRFdsbjRpkPc2Ky64/HEBZAurc9r2yiB0GRSdIp/qEY0hAGfe0OnHQtMLn7J4Fwj1S1D
 Aze6vM1XRRrHSiIF9/xeXrsGii7p3HsgzKxzVgg==
X-Google-Smtp-Source: AGHT+IFj00ASVqTndNriKccUxjw5Iamrh80r1z97IkN+n+JbvpTF22Oy59tPDE00T2jq+1lkiMYF4luJ1GyuKNYgBWE=
X-Received: by 2002:a05:6902:1549:b0:e22:65ee:9a17 with SMTP id
 3f1490d57ef6-e3087c21380mr139403276.44.1729876386468; Fri, 25 Oct 2024
 10:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
 <CAJ+vNU2vZM5B=BhNtsOHU-jGpSsAvR7Sfi91QCFRrOCMYX_Q5g@mail.gmail.com>
 <730eb698b49281729d966c09a3035d14b800406a.camel@phytec.de>
In-Reply-To: <730eb698b49281729d966c09a3035d14b800406a.camel@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 25 Oct 2024 10:12:54 -0700
Message-ID: <CAJ+vNU18QNAy_gKQaisu_6uV6xWTV1CAhWVq-Bx5GabWs804-w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] imx8(m): add optee node to binman FIT image
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "manut@mecka.net" <manut@mecka.net>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, 
 "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, 
 Yashwanth Varakala <Y.Varakala@phytec.de>, "sbabic@denx.de" <sbabic@denx.de>,
 Benjamin Hahn <B.Hahn@phytec.de>, 
 PHYTEC Upstream <upstream@lists.phytec.de>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Teresa Remmet <T.Remmet@phytec.de>
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

On Fri, Oct 25, 2024 at 5:36=E2=80=AFAM Yannic Moog <Y.Moog@phytec.de> wrot=
e:
>
> Hey Tim
>
> On Thu, 2024-10-24 at 08:37 -0700, Tim Harvey wrote:
> > On Thu, Oct 24, 2024 at 12:04=E2=80=AFAM Yannic Moog <y.moog@phytec.de>
> > wrote:
> > >
> > > There have been attempts to get op-tee node integrated upstream in
> > > the
> > > past [1][2]. The challenge is on how to handle the load and entry
> > > addresses where the op-tee image should be loaded to.
> > > Different SoC families and architectures have different RAM base
> > > addresses. Further the final addresses can vary from board to board
> > > (e.g. depending on populated RAM size).
> > > As a result, I propose to solve the issue via device tree where the
> > > optee node itself is defined the same as in previous solutions.
> > > The difference in this approach is to omit the 'load' and 'entry'
> > > properties from the node definition in the <soc>-u-boot.dtsi.
> > > These must be defined in the <board>-u-boot.dtsi.
> > >
> > > This solution avoids the route via kconfig while still allowing
> > > each
> > > board to individually define the op-tee load address.
> > > This is possible as tee-os node has the 'optional' property.
> > > There is no need to keep parts in #ifdefs when no optee integration
> > > is
> > > desired or possible
> > >
> > > I included usage for PHYTEC boards for examples (with
> > > documentation).
> > >
> > > There is one caveat however:
> > > The series in its current form would break all other imx8m{m,n,p}
> > > boards. This is due to the fact that they do not define entry and
> > > load
> > > addr for the tee entry.
> > > During runtime, spl_load_simple_fit fails for the OP-TEE node (no
> > > load
> > > addr).
> > >
> > > [...]
> > > Can't load tee: No load address and no buffer
> > > spl_load_simple_fit: can't load image loadables index 1 (ret =3D -
> > > 105)
> > > mmc_load_image_raw_sector: mmc block read error
> > > SPL: failed to boot from all boot devices
> > >
> > > [3] suggests (Any absent entries are dropped immediately) that
> > > using this proposed solution should work and is allowed. However
> > > [4] on
> > > the other hand clearly states that the entry does not get removed
> > > (which
> > > is the case), rather its data set to 0.
> > >
> > > To me the question now is on how to move forward.
> > > - Is my proposed solution undesired in the sense that I try to use
> > > a
> > >   mechanism that current U-Boot/binman is not designed for?
> > > - Should load_simple_fit check and discard optional entries right
> > > away
> > >   before doing any other processing?
> > > - Should binman be changed so that optional entries do in fact get
> > >   removed instead of being zeroed?
> > >
> > > I am asking for help regarding the questions above since that is
> > > not my
> > > area of expertise.
> > >
> > > [1]
> > > https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.39218=
91-1-tharvey@gateworks.com/
> > > [2]
> > > https://patchwork.ozlabs.org/project/uboot/patch/ZeHDVr-Bzm935-5N@mec=
ka.net/
> > > [3]
> > > https://docs.u-boot.org/en/latest/develop/package/binman.html#optiona=
l-entries
> > > [4]
> > > https://docs.u-boot.org/en/latest/develop/package/binman.html#image-d=
escription-format
> > > see optional: description in [4]
> > >
> > > ---
> > > Yannic Moog (6):
> > >       arm: dts: imx8m: add fit optee node
> > >       arm: dts: imx8mp-phyboard-pollux: add optee load address
> > >       arm: dts: imx8mm-phygate-tauri-l: add optee load address
> > >       arm: dts: imx8mm-phyboard-polis: add optee load address
> > >       doc: phytec: imx8mp: add OP-TEE documentation
> > >       doc: phytec: imx8mm: add OP-TEE integration instructions
> > >
> > >  arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi |  5 +++++
> > >  arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi    |  5 +++++
> > >  arch/arm/dts/imx8mm-u-boot.dtsi                    | 15
> > > ++++++++++++-
> > >  arch/arm/dts/imx8mn-u-boot.dtsi                    | 15
> > > ++++++++++++-
> > >  .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi |  5 +++++
> > >  arch/arm/dts/imx8mp-u-boot.dtsi                    | 15
> > > ++++++++++++-
> > >  doc/board/phytec/imx8mm-phygate-tauri-l.rst        | 26
> > > +++++++++++++++++++++-
> > >  doc/board/phytec/phycore-imx8mm.rst                | 25
> > > ++++++++++++++++++++-
> > >  doc/board/phytec/phycore-imx8mp.rst                | 26
> > > +++++++++++++++++++++-
> > >  9 files changed, 131 insertions(+), 6 deletions(-)
> > > ---
> > > base-commit: fd3f2e3f0edc1f87be4c5a39a0c81037d551c069
> > > change-id: 20240903-phytec_imx8m_optee-8674ef012a36
> > >
> > > Best regards,
> > > --
> > > Yannic Moog <y.moog@phytec.de>
> > >
> >
> > Hi Yannic,
> >
> > Thanks for looking at this - there is a need for a solution for
> > easier
> > integration of a TEE.
> >
> > What is wrong with adding the address via Kconfig? My attempt [1]
> > failed due to something in CI that I just didn't know how to fix or
> > have the time to look into.
>
> Tbf there is nothing wrong with that approach. TI k3 use such a
> solution already [1].
>

Well that sets a decent precedent for a Kconfig solution then.

> I find it pollutes kconfig unnecessarily, but it was my backup solution
> in case this one does not work or is not well received. Do you prefer
> the kconfig route?
>

I was actually hoping for an env variable approach such that if you
had OPTEE_LOAD_ADDRESS defined when you build it links tee.bin in with
that load/entry address but binman doesn't support env variables to my
knowledge and i'm not sure others like that approach.

I also do not like polluting Kconfig but I'm not sure how to do it
otherwise. It's certainly better than breaking boards :)

Based on the existing K3_OPTEE_LOAD_ADDR I would suggest going that
route and perhaps the K3_OPTEE_LOAD_ADDR can be changed to a generic
OPTEE_LOAD_ADDR which defaults to 9e800000 for that soc

Best Regards,

Tim

> Yannic
>
> [1]
> https://github.com/u-boot/u-boot/blob/08ae12be8509daf3d1c5a148b8a50c0ffb6=
457c2/arch/arm/mach-k3/Kconfig#L135
>
> >
> > Best Regards,
> >
> > Tim
> > [1]
> > https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.3921891=
-1-tharvey@gateworks.com/
>
