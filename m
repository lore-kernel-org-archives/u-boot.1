Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673BFCAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1688319C;
	Thu, 25 Sep 2025 16:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WYLd44BY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F201782998; Thu, 25 Sep 2025 15:50:22 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825628004F
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-50f8bf5c518so695726137.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758808219; x=1759413019; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSlWBxNa9iYEciRPsvm6RwYkIZeK2VyQI7JPO48JvY0=;
 b=WYLd44BYAIV/1seokn+t8PayJ3vEnaXyXoc+umo0pCE4OKamnapEQmT4IAlHcN+eIb
 wX5m5O32h+HEY8E0OXaNjb5JoJK7jarOXAcq3NZuGJBkeQfSDcz2qcN5GQDsAePQnO42
 pWXLkdCq0nX0UfLOaBSH8z60M3xFL3tiXkMRl8IKCmVWvKHmY4MuKki4BSUAwrPdTMi7
 W4jEunqqJItdAf7D7Ad+a6nsOewdYhzlmzG/7OU7PUodJvIcsRls18NFj9430ovW7prT
 gzoDg9/u35tbeFb1IOJwzW3T2kgscKmDZOw5pwXaXeYxMVmO3l4zNbLjlZWt/ac4p0oL
 LiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758808219; x=1759413019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bSlWBxNa9iYEciRPsvm6RwYkIZeK2VyQI7JPO48JvY0=;
 b=b1KyL1b0+TLuRQgiOsf70dHOnUMSHDSegrPzaDrWLJr4uAZds0OKsaWXwKq2a0gcdi
 J9IFQ9KV+ZaLDEP6d8XegDpcoxtOQwp44vnUpfNvJckT1IKynl9YND7khmfd8ckKWGEW
 1TThgcnBKSFY2k+LvFSJrSs3sGsMexiUYx1W1dhA9ByQJRjAeGqRgon06714mpbKXc6t
 LkPbVKm+Sza0Oabktfx8oowAIQ8Xu0lNyNxC89ZmCVNJYMXXkDyUsf1UistG+2eHZfVw
 MU34lbxj4bZpqpX3Nky6qA+miPaHUH54l7BfQnG83u4zBCBUWQFxXyKKMc8J8LseqzD0
 TfMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWsmUc4neQb/ugCAhqDTq2PHIB9Bm958fAQ9Hx/McRuoy5zFU4XVd0w+RdmRk8ajowdmB/pVI=@lists.denx.de
X-Gm-Message-State: AOJu0YxRwYmodpxCeiotqBXbzilMfWWWtzjzQIKVuflFkmTZKJcf4RBU
 1Oo8uWZUUPqHDG/PJQSlBAAuiT9+xGm8fYRJ3/pOS3wutiekzxdGNtQUtbC9pHEoP6NvOjquG0I
 WdrR8d/dsncdfmuigJA4HKMT2Wsk+d+Q=
X-Gm-Gg: ASbGncv0GDT+uRxfttynZhKhJQlkZB6lFZmLHkDlrQEgBf1DsNpMMuBEycOpWstAiDq
 UWhBrG9WJCIbOhbPdA0OTKidozEVLr3yY+oymRxGuvMewARrZJDiQgtfzqopQayJriU+KQ3h4P7
 d3+mXElz1VhisQUsWwSXhq0kpviUeqSBnfh+ATm8U7dFag9I40mOaFXSAKI/aOIY010AXUBApUb
 W3JP6k=
X-Google-Smtp-Source: AGHT+IGYcGvU81AOjqmRtbRAVX8zy171XBQuF8BRAH2YQ5iXtQ/CWZRP8KEGB98nDBHONKL1miDARG6I61wdtCNgUnA=
X-Received: by 2002:a05:6102:370a:b0:4f1:37f4:8c32 with SMTP id
 ada2fe7eead31-5accd5f0ba0mr1625627137.11.1758808219120; Thu, 25 Sep 2025
 06:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <20250924135139.GH197373@bill-the-cat>
 <20250924140524.fy46p7ifr4oxh5mc@uncooked>
 <CAJwFiG+M8v3RA9=E296s8xc+NnK3HxwBspw30LsXUBMpzB18ew@mail.gmail.com>
In-Reply-To: <CAJwFiG+M8v3RA9=E296s8xc+NnK3HxwBspw30LsXUBMpzB18ew@mail.gmail.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Thu, 25 Sep 2025 21:49:43 +0800
X-Gm-Features: AS18NWAGOExMc9K27Em5rwGJz0qxoeoSOgWbpydC-5NZevREhbCaYVG9Id9kPiU
Message-ID: <CAJwFiGJAkESqDDpsuMe1jxYcZD=G+m+2OFuSW3Jzqh4=Jxm_Qg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 u-boot@lists.denx.de, 
 sjg@chromium.org, alpernebiyasak@gmail.com, al.kochet@gmail.com, 
 paul.henrys_ext@softathome.com, bb@ti.com, y.moog@phytec.de, 
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com, 
 n-francis@ti.com, afd@ti.com, d.schultz@phytec.de, d-gole@ti.com, 
 ravi@prevas.dk, carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de, 
 alice.guo@nxp.com, Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 Sep 2025 16:09:51 +0200
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

Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:33=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Nishanth Menon <nm@ti.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On 07:51-20250924, Tom Rini wrote:
> > > On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> > > > Hi Aristo,
> > > >
> > > > On 9/24/25 04:43, Nishanth Menon wrote:
> > > > > On 06:37-20250924, Nishanth Menon wrote:
> > > > >> On 10:59-20250914, Aristo Chen wrote:
> > > > >>> This patch series enhances FIT image robustness by adding **mem=
ory
> > > > >>> region overlap detection** to `mkimage` and fixing existing ove=
rlaps
> > > > >>> in DTS files and `binman` tests.
> > > > >
> > > > > [...]
> > > > >>>
> > > > >>
> > > > >> Looks like i see a build regression in linux-next after this ser=
ies.
> > > > >
> > > > > I fat fingered that one.. sorry, I meant u-boot next.
> > > > >
> > > > >
> > > > > Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580=
f
> > > > >
> > > > >>
> > > > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> > > > >
> > > > > I  believe there are outstanding comments on V1 that have'nt been
> > > > > addressed either. Can we revert/drop this series for now while th=
e
> > > > > comments are addressed?
> > > > >
> > > >
> > > > Similar to Nishanth, I am seeing a build regression, itb.map:
> > >
> > > Sorry for the noise all, I've reverted this in next now.
> > >
> >
> > Thanks Tom.
> > --
> > Regards,
> > Nishanth Menon
> > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 =
DDB5 849D 1736 249D
> > https://ti.com/opensource
>
> Apology for introducing the regression, I will find time to fix them,
> and thanks Tom for reverting my patch set to unblock others
>
> For TIFS stub entries on AM6x platforms and the starfive visionfive2,
> sounds like the image in the FIT will be selected during the runtime,
> so they are not really overlapping each other. I will need to figure
> out other way instead


Thank you all for the feedback on my FIT image overlap detection patch
series, and apology again for the issues that I introduced

Currently what I have in my mind is to have the following 2 changes in
my patch set
### 1. Add support for mutually exclusive image groups
Some platforms load only one image from a group at runtime. In the
device tree, we may have something like this
```
tifsstub-hs {
    // ... existing properties ...
    mutually-exclusive-group =3D "tifsstub";
};
tifsstub-fs {
    // ... existing properties ...
    mutually-exclusive-group =3D "tifsstub";
};
```
The overlap checker would then skip validation between images in the
same mutually-exclusive-group, while still catching genuine
overlaps

### 2.  Change from build error to warning
Given that there may be edge cases(such as
starfive_visionfive2_defconfig) not covered by current CI pipelines,
changing overlap
detection from a build-stopping error to a warning initially. This would:
- Alert developers to potential memory layout issues
- Avoid breaking existing working configurations
- Allow time to refine the detection logic based on community feedback
- Enable a gradual transition to stricter validation once the approach is p=
roven
The warning could later become an error once we have confidence in the
detection accuracy across all supported platforms.

Feel free to let me know if you have any concerns or suggestions

Thanks for your time and guidance!
Aristo
