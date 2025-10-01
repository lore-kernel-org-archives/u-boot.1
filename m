Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB6CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 16:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3213880107;
	Wed,  1 Oct 2025 18:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MgJZWxY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E98D28328F; Wed,  1 Oct 2025 18:27:49 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E4B800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 18:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so313572966b.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759336067; x=1759940867; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcEkMYjG3YyGM7l1EAFfos4AAchhHJmQ1Ass5WvlLYo=;
 b=MgJZWxY12e0CfxeJBiwauQSt4IaDUbE2DOKgOQs8SJW4j/IFOZEmJdvaVj+nFm+p7J
 f/+MEocxjga18572zygPlQjUK/UH8nDXrFgA0941XhA6V1j48+i/6m0XzBWQ4zaUBSZm
 ggVd4hA0Y1cVb99ugD8/3+AlTI+eEJ73larSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759336067; x=1759940867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcEkMYjG3YyGM7l1EAFfos4AAchhHJmQ1Ass5WvlLYo=;
 b=uIUpTxiniB48HsrjkGsaIUozAs25ULYDJYj8g1eZMMrCdlWQK75HUdAg6oOI/e2Rpc
 WbCu/uhRLXzjW4ejsjIVwpMYBJDO8vo3Rjj3sXqvr8X1T+mMtiu0fa1M0467nH8xC6UV
 tw1tad9BjhLPgwYKgoKoeRvvqVC9cIeod4sTux8DBBwLzKy297sIPl8M/9Aw2wyVAYzv
 JOg0+o7FO5RfmAyXNePJzWGjJzyBS9oPjm7n5C0mySbWbC0fboX9P6RsRoHLZKNdaRLC
 0sC+Wi/Xor3F0yuPgpjeLnneXMSSBlmFRNo9MPzPETRxw4oG/8w/6j6DWSNzbg5Qd23R
 w+Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd2qa18ZMSKtz4a9tKzGCBMQdO+PmwOriC5qMsUN8UGCVBDQlXaxRN8lRyxDSjgF3lejpOemk=@lists.denx.de
X-Gm-Message-State: AOJu0YyLKUBfKWXW7kI3x/QlGPWMNHKjoLaFGWZ1NCugMvcQCJfLevcw
 kTJEiMrFeXeMWuXsAxCACqFg60dyctiPAcryw+dqZuIASJSpQg5bIbTwIB4ad+AJUZw7Wf4lLRs
 Ph+br1fyWmOZaqotIGSClphZRcmJ3s5Y24VTrRvRX
X-Gm-Gg: ASbGncsr0lb88l/n59dT9bmVvqnW33zLu3eOxfcXlREerlXg+ijbxPT4RPwolVpLMR3
 2MUOVDTkjtn0g7RtezGj27+LloC/GX3j66gNuWud1ihQfouHKuMn5873jc7nByscUkzuMS1T12v
 lpfN5nUaaYR9FrTXLP7OlLCvROly2wSPRGJbE8UqjJ2BqPmUU6gb0rhpieGzOO8oKh5THnpYaxP
 1suejtjZHvpcHqhsAz9brVMm18Dgg==
X-Google-Smtp-Source: AGHT+IFXh4MKIGv9qvowJ+CUbzJITE6HCv9W/2fvc7pQERgi2xnz3pmG6R52uuZGfY69FHbTOMa1mxbNL4Y/+nQBgwg=
X-Received: by 2002:a17:907:9703:b0:b46:57fd:8443 with SMTP id
 a640c23a62f3a-b485a9880dcmr28234166b.24.1759336067013; Wed, 01 Oct 2025
 09:27:47 -0700 (PDT)
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
 <CAJwFiGKD9mdSKiwhug4WdwbrAFe_dj3qq4DcDyznxZu+hQMDpA@mail.gmail.com>
In-Reply-To: <CAJwFiGKD9mdSKiwhug4WdwbrAFe_dj3qq4DcDyznxZu+hQMDpA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Oct 2025 10:27:33 -0600
X-Gm-Features: AS18NWAtG-Xcwe380YdCVplQx2vet0YkNuxdC0Ga2SLDWXvzbP_lr-olWGQpOEw
Message-ID: <CAFLszTgOf2iM7C1X_NM+E3MwO=nNKMBi9f2rUX6e1GqS3kq8gg@mail.gmail.com>
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

On Mon, 29 Sept 2025 at 08:20, Aristo Chen <jj251510319013@gmail.com> wrote=
:
>
> Hi Simon
>
> Simon Glass <sjg@chromium.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:49=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi Aristo,
> >
> > On Thu, 25 Sept 2025 at 07:50, Aristo Chen <jj251510319013@gmail.com> w=
rote:
> > >
> > > Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > >
> > > > Nishanth Menon <nm@ti.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On 07:51-20250924, Tom Rini wrote:
> > > > > > On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> > > > > > > Hi Aristo,
> > > > > > >
> > > > > > > On 9/24/25 04:43, Nishanth Menon wrote:
> > > > > > > > On 06:37-20250924, Nishanth Menon wrote:
> > > > > > > >> On 10:59-20250914, Aristo Chen wrote:
> > > > > > > >>> This patch series enhances FIT image robustness by adding=
 **memory
> > > > > > > >>> region overlap detection** to `mkimage` and fixing existi=
ng overlaps
> > > > > > > >>> in DTS files and `binman` tests.
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >>>
> > > > > > > >>
> > > > > > > >> Looks like i see a build regression in linux-next after th=
is series.
> > > > > > > >
> > > > > > > > I fat fingered that one.. sorry, I meant u-boot next.
> > > > > > > >
> > > > > > > >
> > > > > > > > Fails at commit 4d84fa1261eb, last pass was on commit d81c1=
118580f
> > > > > > > >
> > > > > > > >>
> > > > > > > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced941=
05f76
> > > > > > > >
> > > > > > > > I  believe there are outstanding comments on V1 that have'n=
t been
> > > > > > > > addressed either. Can we revert/drop this series for now wh=
ile the
> > > > > > > > comments are addressed?
> > > > > > > >
> > > > > > >
> > > > > > > Similar to Nishanth, I am seeing a build regression, itb.map:
> > > > > >
> > > > > > Sorry for the noise all, I've reverted this in next now.
> > > > > >
> > > > >
> > > > > Thanks Tom.
> > > > > --
> > > > > Regards,
> > > > > Nishanth Menon
> > > > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3 =
 1A34 DDB5 849D 1736 249D
> > > > > https://ti.com/opensource
> > > >
> > > > Apology for introducing the regression, I will find time to fix the=
m,
> > > > and thanks Tom for reverting my patch set to unblock others
> > > >
> > > > For TIFS stub entries on AM6x platforms and the starfive visionfive=
2,
> > > > sounds like the image in the FIT will be selected during the runtim=
e,
> > > > so they are not really overlapping each other. I will need to figur=
e
> > > > out other way instead
> > >
> > >
> > > Thank you all for the feedback on my FIT image overlap detection patc=
h
> > > series, and apology again for the issues that I introduced
> > >
> > > Currently what I have in my mind is to have the following 2 changes i=
n
> > > my patch set
> > > ### 1. Add support for mutually exclusive image groups
> > > Some platforms load only one image from a group at runtime. In the
> > > device tree, we may have something like this
> > > ```
> > > tifsstub-hs {
> > >     // ... existing properties ...
> > >     mutually-exclusive-group =3D "tifsstub";
> > > };
> > > tifsstub-fs {
> > >     // ... existing properties ...
> > >     mutually-exclusive-group =3D "tifsstub";
> > > };
> > > ```
> > > The overlap checker would then skip validation between images in the
> > > same mutually-exclusive-group, while still catching genuine
> > > overlaps
> > >
> > > ### 2.  Change from build error to warning
> > > Given that there may be edge cases(such as
> > > starfive_visionfive2_defconfig) not covered by current CI pipelines,
> > > changing overlap
> > > detection from a build-stopping error to a warning initially. This wo=
uld:
> > > - Alert developers to potential memory layout issues
> > > - Avoid breaking existing working configurations
> > > - Allow time to refine the detection logic based on community feedbac=
k
> > > - Enable a gradual transition to stricter validation once the approac=
h is proven
> > > The warning could later become an error once we have confidence in th=
e
> > > detection accuracy across all supported platforms.
> > >
> > > Feel free to let me know if you have any concerns or suggestions
> >
> > We should try to have discussions on FIT on the spec github as well,
> > e.g. filing an issue at [1] and referring to it here. I'm not sure how
> > to link github discussions to a mailing list, so that perhaps just
> > create an issue?. FIT is used by most firmware projects at this point,
> > many of which don't follow this mailing list.
> >
> > Regards,
> > Simon
>
> I just opend an issue[1] in the github repo, I don't know if we should
> continue the discussion there or should
> we continue the discussion here in parallel?

I don't know if it is possible to cc the mailing list from github or
vice versa. Probably the important thing is to have an issue so
non-U-Boot people can see it (as you have done with [1]).

For now I've added a comment on your issue.

>
> Best Regards,
> Aristo
>
> [1] https://github.com/open-source-firmware/flat-image-tree/issues/32
>
> >
> > >
> > > Thanks for your time and guidance!
> > > Aristo
> >
> > [1] https://github.com/open-source-firmware/flat-image-tree/issues
