Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EC3CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 22:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2918387E;
	Sat,  4 Oct 2025 00:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QwqRxKdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D5883775; Fri,  3 Oct 2025 16:18:12 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879C4836C1
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 16:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-5d3fb34ba53so1881954137.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759501088; x=1760105888; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/obcyREZ/oUsqHOEDjNU/6+rg9C+EJwQ4DI8F4/UFs=;
 b=QwqRxKdMRY05V7d1gLYX0yCxaoKa1r0jgAZU6ta90INKVW+AW98IOfX4zfQtRhHu7q
 WcS8Y0DLQtMkptdaABX61V7yjBSjI/O1yre0j37+DPtb1LbNVWlNLIz7G3lcqi0HL8np
 oe3YVcAdUYdj2sYmMVC3QwMRjeNojgr7lu5W8wtiqsqNx7EaZTr/4TntzNcQDjKa5P2x
 7Mxtb7huXTjqQD7nPlE3Gi+mRk6seZvPTD6Pszn3RT92B7GyLnmPjvgZsK+HxK8yK4p8
 c1UjgaikbvfK2XIQPEASQJyTUjGhRoqz6aH55jGtWFsSFTXJdToLO2EG8TnhMFFeCTOW
 ZHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501088; x=1760105888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/obcyREZ/oUsqHOEDjNU/6+rg9C+EJwQ4DI8F4/UFs=;
 b=LHD6ICiXdvUGaZeRihRJ1mpMoMqsvFX7QyiotjesYdhLnJbNYzGzt56Qa7hckaVh7C
 QMoeutrUbDHkzw2odj06z9eZc1EZcrgfZIpfqMvNAb0gN2/Z1Qup/fD68DcTpDYHislJ
 a9bfD5I/1YV1Ydy1LUR6+Rh5FcP/tUILCipdDSBBQ2ejlTmW/BMdCjrmkNHyfcmUw56f
 4A9Ak0iAiJMusnjNQYmwqMGRGHAQvkl2rxhJWSeB6P0FSoir2Y1iDHj4VXbZCIrHrTzh
 XObb7SqXd2wg5SyD8evDAc3aiUh24idsRA5GyOOr4Qp5rYHBQ24m0fT65zK16lanm+YD
 2XpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMTiEFUlFWGtbEGqjkRUSaMD819qiCWiVRkrmauFproLfAp4E5N8HpCwJc+KhMqEQkL2ah/gI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4vpaRUIUys8D8yfX1dy0vI7JsRWmgg6m9cTeLmC5D/+i9aO1u
 V6x1nZuetBNwq6RGr5GgfW3Y17VXc6FpcNW5mDbMC5Eldyfnx6MyMMGCFlIHI72tify9Zrq4zjp
 KoVTUfxvJNL0msBXALCbWoE0qJfxScVI=
X-Gm-Gg: ASbGncsLQ4gFdb6Pd2yfRaxg2oyS8W6D9U4sVEQziTEaDNXp9I73mX9uGXXrY65Jszd
 65jhllTnCPndJgbbkx0YHs9d4vGlaeqyLpuHH9aUJ7xTXQgalm0Wc9rBTx6yxiDEIQUmrK0Xgi+
 KQIXRMm/9v0PzFwfCLActHtuTe29vKxKvjWBXWZCE8Sc/++HEUYLvz3TJdnQyTciYBGbPEzdSep
 HevvuTz0NWpOMg8VWyE/Vp2ZAkQgRg=
X-Google-Smtp-Source: AGHT+IEmaPvjLdq5yJSsnxwAqDROoZ6RRrRFeWA6U6ctG07FFDVZdL1XkXEy7F60W97aAdyBeMTqseLMd7AH++5eUPE=
X-Received: by 2002:a05:6102:b15:b0:55d:cfa5:9d52 with SMTP id
 ada2fe7eead31-5d41d1423e3mr1220808137.27.1759501087948; Fri, 03 Oct 2025
 07:18:07 -0700 (PDT)
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
 <CAFLszTgOf2iM7C1X_NM+E3MwO=nNKMBi9f2rUX6e1GqS3kq8gg@mail.gmail.com>
In-Reply-To: <CAFLszTgOf2iM7C1X_NM+E3MwO=nNKMBi9f2rUX6e1GqS3kq8gg@mail.gmail.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Fri, 3 Oct 2025 22:17:31 +0800
X-Gm-Features: AS18NWBdw7KBhRCLcwSIAdbbNcAgHWo-X0o1vIhkuUh8gF6eNe4S8PNWggMjb3I
Message-ID: <CAJwFiGKRatcPK7-rcgR_66-LsM6omCVZj+ugqSX1dhb9a+ChSw@mail.gmail.com>
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
X-Mailman-Approved-At: Sat, 04 Oct 2025 00:45:09 +0200
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

Hi Simon and all

Simon Glass <sjg@chromium.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=882=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Aristo,
>
> On Mon, 29 Sept 2025 at 08:20, Aristo Chen <jj251510319013@gmail.com> wro=
te:
> >
> > Hi Simon
> >
> > Simon Glass <sjg@chromium.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Aristo,
> > >
> > > On Thu, 25 Sept 2025 at 07:50, Aristo Chen <jj251510319013@gmail.com>=
 wrote:
> > > >
> > > > Aristo Chen <jj251510319013@gmail.com> =E6=96=BC 2025=E5=B9=B49=E6=
=9C=8824=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:33=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > > >
> > > > > Nishanth Menon <nm@ti.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > > >
> > > > > > On 07:51-20250924, Tom Rini wrote:
> > > > > > > On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> > > > > > > > Hi Aristo,
> > > > > > > >
> > > > > > > > On 9/24/25 04:43, Nishanth Menon wrote:
> > > > > > > > > On 06:37-20250924, Nishanth Menon wrote:
> > > > > > > > >> On 10:59-20250914, Aristo Chen wrote:
> > > > > > > > >>> This patch series enhances FIT image robustness by addi=
ng **memory
> > > > > > > > >>> region overlap detection** to `mkimage` and fixing exis=
ting overlaps
> > > > > > > > >>> in DTS files and `binman` tests.
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >>>
> > > > > > > > >>
> > > > > > > > >> Looks like i see a build regression in linux-next after =
this series.
> > > > > > > > >
> > > > > > > > > I fat fingered that one.. sorry, I meant u-boot next.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Fails at commit 4d84fa1261eb, last pass was on commit d81=
c1118580f
> > > > > > > > >
> > > > > > > > >>
> > > > > > > > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced9=
4105f76
> > > > > > > > >
> > > > > > > > > I  believe there are outstanding comments on V1 that have=
'nt been
> > > > > > > > > addressed either. Can we revert/drop this series for now =
while the
> > > > > > > > > comments are addressed?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Similar to Nishanth, I am seeing a build regression, itb.ma=
p:
> > > > > > >
> > > > > > > Sorry for the noise all, I've reverted this in next now.
> > > > > > >
> > > > > >
> > > > > > Thanks Tom.
> > > > > > --
> > > > > > Regards,
> > > > > > Nishanth Menon
> > > > > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A=
3  1A34 DDB5 849D 1736 249D
> > > > > > https://ti.com/opensource
> > > > >
> > > > > Apology for introducing the regression, I will find time to fix t=
hem,
> > > > > and thanks Tom for reverting my patch set to unblock others
> > > > >
> > > > > For TIFS stub entries on AM6x platforms and the starfive visionfi=
ve2,
> > > > > sounds like the image in the FIT will be selected during the runt=
ime,
> > > > > so they are not really overlapping each other. I will need to fig=
ure
> > > > > out other way instead
> > > >
> > > >
> > > > Thank you all for the feedback on my FIT image overlap detection pa=
tch
> > > > series, and apology again for the issues that I introduced
> > > >
> > > > Currently what I have in my mind is to have the following 2 changes=
 in
> > > > my patch set
> > > > ### 1. Add support for mutually exclusive image groups
> > > > Some platforms load only one image from a group at runtime. In the
> > > > device tree, we may have something like this
> > > > ```
> > > > tifsstub-hs {
> > > >     // ... existing properties ...
> > > >     mutually-exclusive-group =3D "tifsstub";
> > > > };
> > > > tifsstub-fs {
> > > >     // ... existing properties ...
> > > >     mutually-exclusive-group =3D "tifsstub";
> > > > };
> > > > ```
> > > > The overlap checker would then skip validation between images in th=
e
> > > > same mutually-exclusive-group, while still catching genuine
> > > > overlaps
> > > >
> > > > ### 2.  Change from build error to warning
> > > > Given that there may be edge cases(such as
> > > > starfive_visionfive2_defconfig) not covered by current CI pipelines=
,
> > > > changing overlap
> > > > detection from a build-stopping error to a warning initially. This =
would:
> > > > - Alert developers to potential memory layout issues
> > > > - Avoid breaking existing working configurations
> > > > - Allow time to refine the detection logic based on community feedb=
ack
> > > > - Enable a gradual transition to stricter validation once the appro=
ach is proven
> > > > The warning could later become an error once we have confidence in =
the
> > > > detection accuracy across all supported platforms.
> > > >
> > > > Feel free to let me know if you have any concerns or suggestions
> > >
> > > We should try to have discussions on FIT on the spec github as well,
> > > e.g. filing an issue at [1] and referring to it here. I'm not sure ho=
w
> > > to link github discussions to a mailing list, so that perhaps just
> > > create an issue?. FIT is used by most firmware projects at this point=
,
> > > many of which don't follow this mailing list.
> > >
> > > Regards,
> > > Simon
> >
> > I just opend an issue[1] in the github repo, I don't know if we should
> > continue the discussion there or should
> > we continue the discussion here in parallel?
>
> I don't know if it is possible to cc the mailing list from github or
> vice versa. Probably the important thing is to have an issue so
> non-U-Boot people can see it (as you have done with [1]).
>
> For now I've added a comment on your issue.

Thanks for the feedback in the github issue!

Currently Ahmad Fatoum is suggesting to have multiple configurations
and selecting
between them at runtime instead of having a single intentionally
conflicting configuration

I may need need input from TI folks whether this idea makes sense to you or=
 not

I don't have the device to verify this concept, but I am happy to
write some preliminary
POC code

Best regards,
Aristo

>
> >
> > Best Regards,
> > Aristo
> >
> > [1] https://github.com/open-source-firmware/flat-image-tree/issues/32
> >
> > >
> > > >
> > > > Thanks for your time and guidance!
> > > > Aristo
> > >
> > > [1] https://github.com/open-source-firmware/flat-image-tree/issues
