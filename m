Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5791BCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81758362A;
	Fri, 26 Sep 2025 16:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dA0uI3RC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80527836B4; Fri, 26 Sep 2025 16:49:12 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337F7835FD
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so370995566b.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758898150; x=1759502950; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLr54B91d4IpiXhRvBFa2MDGHg0VLo/etFhgutMQM9w=;
 b=dA0uI3RC2C4YIqANmFQeJ0nGjk7uTQ4XxuFJjFYWWGahVssR64ohvmWCJIWVxUwnrk
 a7IKzAHtewljBf420885OGcvJZSxy38MfmLjGxEtWzq3z8zASD54elBUEepSKuMm/hMn
 WSsFoqhT3VnQtOkHF0aDoEL/cd9JKLkNtOfBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758898150; x=1759502950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLr54B91d4IpiXhRvBFa2MDGHg0VLo/etFhgutMQM9w=;
 b=VhLiDaZ11Fbbws/gv0EP0XZpUpxyUoV8XklwJ2WaGjrZCYCwfmiaaR0VGdbGk0TpiB
 vtO7ewQRXkrz0LqctpGy9IJL/MTT9wQ0NaBiGP0fzcOIkXi7ONrBW2ch58thQOZkkP7X
 I3jsq3MoUYvFhPq9GZUHCVyuVrD6voPmispYuImAQKXFnJcLM4PCmGnczxHHxHsLlEGc
 9N6pYkmgeGrOUp0hEWjCvCJU4T9zeAcKb2eXKCqodYrgDmUR4bq1bfMuirOL0QYd5wiJ
 ES2z3JYKecgcf7l9fiFUZ/C6E3A3uLbAsBsaitvF0iAY7fZQgfLXhru4BClAfv3/Pcdc
 NCXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYZ5S8mG045NqPG0avUf7IdjeN83pEvZHLcQuyaMnL+Idl7iDqlsN2jwhtzvdF0esqqk0Tkr4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7Ndl5xKqZMEEtBkBWx/faYKbWj0adUD4VcXpWWIsOEjoK8sD8
 F9iIlfkPNeZnX27fkSsUNxjcKyKReJ9aHnjb1DNPolXTUXpfMmQ6a6gJJyUMAZlvVYmZ+Frw0/5
 ZwTwl7hkefVd+JALppnCzVGcdlj017AmSHyo9GbcI
X-Gm-Gg: ASbGncuDVwbTaBUpu63tDexlnavRfznmSTEF4eQP0l1jMzvGuymZtsM+TMOeF4RKm6V
 SjMC9qEiJL1GEfuM6Km8XjyMU/+yHTmnwSHqYCd+5C/+x9cdEayHNQk+CESFJmN/R5d2Sx6Qj01
 Di1pf8gXsAUV8Lh8KDC7kAmwV3+vi7+ejrBRsITGFJTgXlKZOVAzz5gPnYNqgjELd3krOa40rVA
 opP+ZhmOCsLERuY
X-Google-Smtp-Source: AGHT+IFJ8/O7IYQqkvL6mtxXq5e9wuIEYdoj7Suphvew6rkaRVLttKVMoCGJk+jEASu93GG4YPy5484T5nqDoGKgm5w=
X-Received: by 2002:a17:907:948a:b0:b29:1c4b:3d4e with SMTP id
 a640c23a62f3a-b34b8d96295mr802778266b.28.1758898149550; Fri, 26 Sep 2025
 07:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <20250924135139.GH197373@bill-the-cat>
 <20250924140524.fy46p7ifr4oxh5mc@uncooked>
 <CAJwFiG+M8v3RA9=E296s8xc+NnK3HxwBspw30LsXUBMpzB18ew@mail.gmail.com>
 <CAJwFiGJAkESqDDpsuMe1jxYcZD=G+m+2OFuSW3Jzqh4=Jxm_Qg@mail.gmail.com>
In-Reply-To: <CAJwFiGJAkESqDDpsuMe1jxYcZD=G+m+2OFuSW3Jzqh4=Jxm_Qg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Sep 2025 08:48:57 -0600
X-Gm-Features: AS18NWDDj7B04aV7UojXsbr8kqKBVI_t8eCFVySKIMJ7eTHeaBI2P3GxYkQdBj8
Message-ID: <CAFLszTiNSnyw86oi_k3F0okOmQn2U6pU7SwrQc0e-tGHd_Py=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Aristo Chen <jj251510319013@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, 
 u-boot@lists.denx.de, alpernebiyasak@gmail.com, al.kochet@gmail.com, 
 paul.henrys_ext@softathome.com, bb@ti.com, y.moog@phytec.de, 
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com, 
 n-francis@ti.com, afd@ti.com, d.schultz@phytec.de, d-gole@ti.com, 
 ravi@prevas.dk, carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de, 
 alice.guo@nxp.com, Aristo Chen <aristo.chen@canonical.com>
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

Hi Aristo,

On Thu, 25 Sept 2025 at 07:50, Aristo Chen <jj251510319013@gmail.com> wrote=
:
>
> Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=882=
4=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:33=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > Nishanth Menon <nm@ti.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On 07:51-20250924, Tom Rini wrote:
> > > > On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> > > > > Hi Aristo,
> > > > >
> > > > > On 9/24/25 04:43, Nishanth Menon wrote:
> > > > > > On 06:37-20250924, Nishanth Menon wrote:
> > > > > >> On 10:59-20250914, Aristo Chen wrote:
> > > > > >>> This patch series enhances FIT image robustness by adding **m=
emory
> > > > > >>> region overlap detection** to `mkimage` and fixing existing o=
verlaps
> > > > > >>> in DTS files and `binman` tests.
> > > > > >
> > > > > > [...]
> > > > > >>>
> > > > > >>
> > > > > >> Looks like i see a build regression in linux-next after this s=
eries.
> > > > > >
> > > > > > I fat fingered that one.. sorry, I meant u-boot next.
> > > > > >
> > > > > >
> > > > > > Fails at commit 4d84fa1261eb, last pass was on commit d81c11185=
80f
> > > > > >
> > > > > >>
> > > > > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f7=
6
> > > > > >
> > > > > > I  believe there are outstanding comments on V1 that have'nt be=
en
> > > > > > addressed either. Can we revert/drop this series for now while =
the
> > > > > > comments are addressed?
> > > > > >
> > > > >
> > > > > Similar to Nishanth, I am seeing a build regression, itb.map:
> > > >
> > > > Sorry for the noise all, I've reverted this in next now.
> > > >
> > >
> > > Thanks Tom.
> > > --
> > > Regards,
> > > Nishanth Menon
> > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A3=
4 DDB5 849D 1736 249D
> > > https://ti.com/opensource
> >
> > Apology for introducing the regression, I will find time to fix them,
> > and thanks Tom for reverting my patch set to unblock others
> >
> > For TIFS stub entries on AM6x platforms and the starfive visionfive2,
> > sounds like the image in the FIT will be selected during the runtime,
> > so they are not really overlapping each other. I will need to figure
> > out other way instead
>
>
> Thank you all for the feedback on my FIT image overlap detection patch
> series, and apology again for the issues that I introduced
>
> Currently what I have in my mind is to have the following 2 changes in
> my patch set
> ### 1. Add support for mutually exclusive image groups
> Some platforms load only one image from a group at runtime. In the
> device tree, we may have something like this
> ```
> tifsstub-hs {
>     // ... existing properties ...
>     mutually-exclusive-group =3D "tifsstub";
> };
> tifsstub-fs {
>     // ... existing properties ...
>     mutually-exclusive-group =3D "tifsstub";
> };
> ```
> The overlap checker would then skip validation between images in the
> same mutually-exclusive-group, while still catching genuine
> overlaps
>
> ### 2.  Change from build error to warning
> Given that there may be edge cases(such as
> starfive_visionfive2_defconfig) not covered by current CI pipelines,
> changing overlap
> detection from a build-stopping error to a warning initially. This would:
> - Alert developers to potential memory layout issues
> - Avoid breaking existing working configurations
> - Allow time to refine the detection logic based on community feedback
> - Enable a gradual transition to stricter validation once the approach is=
 proven
> The warning could later become an error once we have confidence in the
> detection accuracy across all supported platforms.
>
> Feel free to let me know if you have any concerns or suggestions

We should try to have discussions on FIT on the spec github as well,
e.g. filing an issue at [1] and referring to it here. I'm not sure how
to link github discussions to a mailing list, so that perhaps just
create an issue?. FIT is used by most firmware projects at this point,
many of which don't follow this mailing list.

Regards,
Simon

>
> Thanks for your time and guidance!
> Aristo

[1] https://github.com/open-source-firmware/flat-image-tree/issues
