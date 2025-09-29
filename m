Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6FACAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 14:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA3A82A9E;
	Mon, 29 Sep 2025 16:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B3PVv0E6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88E483448; Mon, 29 Sep 2025 16:20:40 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B0D282A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-8e0c90cac25so3043809241.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759155637; x=1759760437; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ukfbTwMDW2KsCuBle9HBG9MRad6b4IPimJI2vgiLDE=;
 b=B3PVv0E6wMdFlOiWZGWS5nPdpN+zP9mCTdB3zLhv8C8QBideu4reCXhM2/+9dvN7gx
 GFBST7ia06bOSJH0GI89zd41c6DBpU3QyBajbvgNMWZ9w6VDas8g6ccDJHTlSLSGQZ4q
 Q+T3Jd+Ih0lhC6DPA9Yv4ZsSjw6zRQWHwkv6Qmf3CRaVrRAJgk+tw98yflIkhG6gcjre
 imjRniZzFCGdMdr/VVfd/hs0zY+kkewz7o2H7NPsau9rY7exphAOe9AvIE/l85upubw2
 hpf+SOe5hpHn/ImaxF7G1MVtqwKT+vzAqUavOnNt1x/0gal+FZfdawtNhY7loPPfVTdv
 Bq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759155637; x=1759760437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ukfbTwMDW2KsCuBle9HBG9MRad6b4IPimJI2vgiLDE=;
 b=qEmrhoZCOL72XigkcVfKl+Lmlsn+V8ni1rhhIiMZWhxodV5zMErLcdzDSx7V3Nv+Hz
 v49GfJAjf7R40R4aQBrCPbZ3CbUjeGpwsnBwyJ0lHHn176QC3luddL3mqNJqVrSNubZ/
 E395HGtDVtJbMxvTPBg02LzWIOYWuOd/DkPSVpjworYkPak6tcEs413HkmIKzJV6WRBj
 vcW+Pq9qbq3qrzOpA2UztXWjpj6M76gMsr/gax1I6sZ4QsGnq75joAWj6WZZ10Q97NNv
 6fIYzMXUv4HiOBi3K1Rlz5wZKCkMY1M0ySNtaFEqDXiiUuZkrcltrf20SmmqPgMD/hgu
 j/5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8t+0ySDZZNvbqm+Wh0hYpd9+hoIKb0E9KbNqKrGpke4S1XW3eiXaUt0Q9Tkv2w8aSUHRY7dA=@lists.denx.de
X-Gm-Message-State: AOJu0YwpThagh8x/c+FSaOCca7HXqvrAKXmgtGg7WhdpW5h+FXQl2XAe
 AxKhrgPVrgbfVlPRsRKABHGgnFAFBfUvB3s6FAvw8u2nzVaYTN1WHtzrpD8opT+0FJ+96EoXZrK
 sivw1gInfukT2sI1+qmKmK/6ctUgphI0=
X-Gm-Gg: ASbGnctwaVSoqJs9L79vnNVWXDltd+8xNlReeC/dAPOFrBkf2Yh9f1nsAXmAuTZzE0H
 nrKOV2MrZVcn1BNqqYO/Aw4XwY9tH5mBEkKIR7D+iRlOy0l9cII/ypKoX1Zv6ZORfwvXuArXFE9
 j1VmOYlKmKiskloHIzmQrDqnplzhiQcJmJXevKuLN1mpuOrkpGV4LgfHrXXt6aUQ1Z0fOcF1ZE3
 R6al5u96fddTkMrdw==
X-Google-Smtp-Source: AGHT+IHyWGS22kVLbrXVzHhHypv5ohYoObWqOxkMWlrwHWjEdgHvzCWIjeJ4phEhOSgebI0BGXP5WsXxRXo2Oetn/xI=
X-Received: by 2002:a05:6122:1346:b0:54a:992c:815e with SMTP id
 71dfb90a1353d-54bea130eaamr6831318e0c.8.1759155636646; Mon, 29 Sep 2025
 07:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <20250924135139.GH197373@bill-the-cat>
 <20250924140524.fy46p7ifr4oxh5mc@uncooked>
 <CAJwFiG+M8v3RA9=E296s8xc+NnK3HxwBspw30LsXUBMpzB18ew@mail.gmail.com>
 <CAJwFiGJAkESqDDpsuMe1jxYcZD=G+m+2OFuSW3Jzqh4=Jxm_Qg@mail.gmail.com>
 <CAFLszTiNSnyw86oi_k3F0okOmQn2U6pU7SwrQc0e-tGHd_Py=g@mail.gmail.com>
In-Reply-To: <CAFLszTiNSnyw86oi_k3F0okOmQn2U6pU7SwrQc0e-tGHd_Py=g@mail.gmail.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Mon, 29 Sep 2025 22:20:00 +0800
X-Gm-Features: AS18NWAzxJFFp2JhFuBglYl3c5xMawUQH91uq5YYYTZzR3PnSDUwG4wkg4rn0is
Message-ID: <CAJwFiGKD9mdSKiwhug4WdwbrAFe_dj3qq4DcDyznxZu+hQMDpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Simon Glass <sjg@chromium.org>
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
X-Mailman-Approved-At: Mon, 29 Sep 2025 16:32:37 +0200
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

Hi Simon

Simon Glass <sjg@chromium.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=8826=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Aristo,
>
> On Thu, 25 Sept 2025 at 07:50, Aristo Chen <jj251510319013@gmail.com> wro=
te:
> >
> > Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > Nishanth Menon <nm@ti.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On 07:51-20250924, Tom Rini wrote:
> > > > > On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> > > > > > Hi Aristo,
> > > > > >
> > > > > > On 9/24/25 04:43, Nishanth Menon wrote:
> > > > > > > On 06:37-20250924, Nishanth Menon wrote:
> > > > > > >> On 10:59-20250914, Aristo Chen wrote:
> > > > > > >>> This patch series enhances FIT image robustness by adding *=
*memory
> > > > > > >>> region overlap detection** to `mkimage` and fixing existing=
 overlaps
> > > > > > >>> in DTS files and `binman` tests.
> > > > > > >
> > > > > > > [...]
> > > > > > >>>
> > > > > > >>
> > > > > > >> Looks like i see a build regression in linux-next after this=
 series.
> > > > > > >
> > > > > > > I fat fingered that one.. sorry, I meant u-boot next.
> > > > > > >
> > > > > > >
> > > > > > > Fails at commit 4d84fa1261eb, last pass was on commit d81c111=
8580f
> > > > > > >
> > > > > > >>
> > > > > > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105=
f76
> > > > > > >
> > > > > > > I  believe there are outstanding comments on V1 that have'nt =
been
> > > > > > > addressed either. Can we revert/drop this series for now whil=
e the
> > > > > > > comments are addressed?
> > > > > > >
> > > > > >
> > > > > > Similar to Nishanth, I am seeing a build regression, itb.map:
> > > > >
> > > > > Sorry for the noise all, I've reverted this in next now.
> > > > >
> > > >
> > > > Thanks Tom.
> > > > --
> > > > Regards,
> > > > Nishanth Menon
> > > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1=
A34 DDB5 849D 1736 249D
> > > > https://ti.com/opensource
> > >
> > > Apology for introducing the regression, I will find time to fix them,
> > > and thanks Tom for reverting my patch set to unblock others
> > >
> > > For TIFS stub entries on AM6x platforms and the starfive visionfive2,
> > > sounds like the image in the FIT will be selected during the runtime,
> > > so they are not really overlapping each other. I will need to figure
> > > out other way instead
> >
> >
> > Thank you all for the feedback on my FIT image overlap detection patch
> > series, and apology again for the issues that I introduced
> >
> > Currently what I have in my mind is to have the following 2 changes in
> > my patch set
> > ### 1. Add support for mutually exclusive image groups
> > Some platforms load only one image from a group at runtime. In the
> > device tree, we may have something like this
> > ```
> > tifsstub-hs {
> >     // ... existing properties ...
> >     mutually-exclusive-group =3D "tifsstub";
> > };
> > tifsstub-fs {
> >     // ... existing properties ...
> >     mutually-exclusive-group =3D "tifsstub";
> > };
> > ```
> > The overlap checker would then skip validation between images in the
> > same mutually-exclusive-group, while still catching genuine
> > overlaps
> >
> > ### 2.  Change from build error to warning
> > Given that there may be edge cases(such as
> > starfive_visionfive2_defconfig) not covered by current CI pipelines,
> > changing overlap
> > detection from a build-stopping error to a warning initially. This woul=
d:
> > - Alert developers to potential memory layout issues
> > - Avoid breaking existing working configurations
> > - Allow time to refine the detection logic based on community feedback
> > - Enable a gradual transition to stricter validation once the approach =
is proven
> > The warning could later become an error once we have confidence in the
> > detection accuracy across all supported platforms.
> >
> > Feel free to let me know if you have any concerns or suggestions
>
> We should try to have discussions on FIT on the spec github as well,
> e.g. filing an issue at [1] and referring to it here. I'm not sure how
> to link github discussions to a mailing list, so that perhaps just
> create an issue?. FIT is used by most firmware projects at this point,
> many of which don't follow this mailing list.
>
> Regards,
> Simon

I just opend an issue[1] in the github repo, I don't know if we should
continue the discussion there or should
we continue the discussion here in parallel?

Best Regards,
Aristo

[1] https://github.com/open-source-firmware/flat-image-tree/issues/32

>
> >
> > Thanks for your time and guidance!
> > Aristo
>
> [1] https://github.com/open-source-firmware/flat-image-tree/issues
