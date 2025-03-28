Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E64DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2465081951;
	Fri, 28 Mar 2025 17:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fYm1IO/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7518C810EA; Fri, 28 Mar 2025 17:42:15 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCB881E5B
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f9a7cbc8f1so702718b6e.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743180130; x=1743784930; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S4yFTMxDVvy62cPI3eLWl4aijzlDObieEoLnsgVUbCs=;
 b=fYm1IO/jSod+3DjHcItPNbaUw5vPg+15RB5wVhWnnU8atliVlB4sKnTTGKjtowQsvn
 TmIMzcgQg75QFXbsUuhxUqe49lmIpTmJ6Uzbwn2a8Yq07nc+S4gUjjq3JhszIXa4KM4Q
 89wpNM+kZAdhTYV0BvM0Om8ZXdTLHrUjgnmZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743180130; x=1743784930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4yFTMxDVvy62cPI3eLWl4aijzlDObieEoLnsgVUbCs=;
 b=Dya77cxtIUI2Yg11Iz7rzSEACX0d7KqHrxO51Vq8sBHfJurmVobn90KsIwFPLPecSe
 Ict+GkO1uxx8ZPZshxfswzHM1FflejONZx/285sJ+plD9VR7KiN+DJxkyZ61oDD7wjwR
 0vHtcMVwwR/PiUyP/XtG5J4vBnr98lQIH3HM5fptRdiOsh8tRS9e7ZZcrb+MnwEnN13C
 egM4QRXJAQQz7w23EU8WXKdpwgeb19DGH5cJykuEYtPAFTPqwcm9Z6xhstXLV5poyN+F
 yd5frYMxM3z53DflOogNesQXIMlPCexMZqAt45PSkSxHI4kAnicjaFl7Xed0/dLIm7IM
 Wu7A==
X-Gm-Message-State: AOJu0YxEONfxibn6RJOnPeswn24nXNauv0kUCu4d0BTQSUF/OIh43ovO
 ElsIFqn98aPpXUeMReW8Pva+odAmaN5S6aHN0NCVaMcTCMDyKjZudlaVUG+zQ8w=
X-Gm-Gg: ASbGncsHMPaMLDuLVXcxW1gbIRzC5kducKjZPofzTvnYraC9pj4Wsq8zcmPO0sYdPvz
 IfzpQaNhsOyQVjwoiwmb9OhcGNw+0wvU8uZhtW+8rbSDqeUnaYyO5UPxt+RRFQFk7/TzA3cIego
 RXhWZvXN2C9cyvWte2TY9xgteAZVbTmMR2YiPMqg9Mt/UEjAOPGkMpeLrUOpTSUfAvsn1NZpDoW
 fg7GcIhz+fePP10fLgfP7zZHciCE6KDu3plDU5Cyx8J2ir8S0k1boz/T4eC1Xo6I2UgPvzy/DgJ
 ADO99l8SphvHUhWs9VWyh1AU5Ub9z7+YYfujsK0KI8wCcY5sSKfxX45EliZyjHgyzoCkIF6CJNv
 FytLoOw==
X-Google-Smtp-Source: AGHT+IHKXMJk9uRXgJSm1BijQqN6wnx7jlcwupzolXILLcYIjXX5vwZtsuUknF+IXlJNT6GztBG0GQ==
X-Received: by 2002:a05:6808:448e:b0:3f6:7fc4:a0b5 with SMTP id
 5614622812f47-3fefa54e0ecmr4617599b6e.18.1743180130466; 
 Fri, 28 Mar 2025 09:42:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6028461b46csm387252eaf.34.2025.03.28.09.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:42:09 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:42:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/52] expo: Various features and improvements
Message-ID: <20250328164206.GE93000@bill-the-cat>
References: <20250319145512.2391122-1-sjg@chromium.org>
 <20250319145742.GI2640854@bill-the-cat>
 <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
 <20250320142121.GQ2640854@bill-the-cat>
 <CAFLszTgsMu1ZtK1Z-u6cmH6k__0Qhn+G2SPh8w_NdrihLkQ7jA@mail.gmail.com>
 <20250325162420.GI93000@bill-the-cat>
 <CAFLszTj49W-Vk_4xpmvtyFH6AH1QAZTLRM7x1k-Bhz7a3uEuBQ@mail.gmail.com>
 <20250327141742.GP93000@bill-the-cat>
 <CAFLszThJqyEQLvngTdxwqa-fsox5jjHBMYVryo6vPA7k_6jhUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Jc2ER5Isp4swimH"
Content-Disposition: inline
In-Reply-To: <CAFLszThJqyEQLvngTdxwqa-fsox5jjHBMYVryo6vPA7k_6jhUA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--7Jc2ER5Isp4swimH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 07:05:35AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Mar 2025 at 08:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 27, 2025 at 07:36:02AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 25 Mar 2025 at 10:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 21, 2025 at 07:38:45PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 20 Mar 2025 at 15:21, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 20, 2025 at 03:39:26AM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 19 Mar 2025 at 15:57, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > This series collects together some new features for expo =
to make it more
> > > > > > > > > useful for boot menus:
> > > > > > > > >
> > > > > > > > > - measurement and display of multi-line text objects
> > > > > > > > > - internal alignment for objects (e.g. centred text)
> > > > > > > > > - editable strings in text fields
> > > > > > > > > - new 'box' object to draw a rectangle
> > > > > > > > > - highlighting of menu items, rather than just relying on=
 a pointer
> > > > > > > > >
> > > > > > > > > Expo's boot menu is restructured so that it is possible t=
o iterate
> > > > > > > > > through various bootdevs and update the menu as new ones =
are found. This
> > > > > > > > > is more in keeping with how bootstd works.
> > > > > > > > >
> > > > > > > > > A new textedit object is added, intended to provide a sim=
ple text
> > > > > > > > > editor. Future work will complete this.
> > > > > > > > >
> > > > > > > > > With this series the boot menu has a better layout and ap=
pearance.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Simon Glass (52):
> > > > > > > >
> > > > > > > > I see you haven't internalized the "don't post massive seri=
es" feedback
> > > > > > > > yet. Please, stop posting massive patch series. Figure out =
how to
> > > > > > > > logically break things down in to smaller chunks that can be
> > > > > > > > meaningfully reviewed.
> > > > > > >
> > > > > > > I could split this into two series of ~25 patches, perhaps. W=
ould that be OK?
> > > > > > >
> > > > > > > I believe no one else is using expo yet, apart from postmarke=
tOS,
> > > > > > > except the trivial case of 'bootflow scan -m' but I'm hoping =
that will
> > > > > > > change in the future. I believe that Linaro is mostly encoura=
ging EFI
> > > > > > > bootmgr and the text-based menu. That could be converted to u=
se expo
> > > > > > > but I doubt anyone has looked into that, particularly as grub=
 is being
> > > > > > > pushed as well. I did look at converting the existing menu co=
de a year
> > > > > > > or two ago, but it seemed better to eventually deprecate it.
> > > > > > >
> > > > > > > Also, there is a following series which I split out and will =
post
> > > > > > > separately, but not for a while as I have a lot outstanding.
> > > > > > >
> > > > > >
> > > > > > It would make sense to split expo out to its own series as ther=
e's not
> > > > > > likely to be any feedback there. All of the other parts of the =
series
> > > > > > already have something else in their subject and that would be =
logical
> > > > > > places to split this up more and then assign to the appropriate
> > > > > > custodian. Thanks.
> > > > >
> > > > > This is the expo series and it only has expo patches, so I believ=
e we
> > > > > are OK there.
> > > > >
> > > > > The bootstd series is small and its own thing.
> > > >
> > > > OK.
> > > >
> > > > > I can split up the strim() / test series,
> > > >
> > > > OK.
> > > >
> > > > > but I'm still unsure what
> > > > > you are asking for with respect to code which is not yet used. I =
can't
> > > > > reasonably do all of a) send code only when it is needed by later
> > > > > patches in the series and b) keep series sizes small and c) keep
> > > > > series related to a single topic.
> > > >
> > > > I don't see why you can't do that. It is in fact really hard to rev=
iew
> > > > how useful some library functions you write without seeing how they=
're
> > > > used and if in turn we should be doing something different. You mig=
ht
> > > > need to defer or break out as it's own some refactoring changes in =
order
> > > > to meet 'b' above. However "here is a thing" and "here's using a th=
ing"
> > > > are still a single topic.
> > >
> > > You could just review the code itself, perhaps, rather than worrying
> > > whether it will never be used? For me, creating and maintaining a
> > > series through acceptance into your tree is still a lot of effort,
> > > unfortunately.
> >
> > No, that's a no-go. Reviewing a library without knowing how it's going
> > to be used is not effective.
> >
> > > While on that topic, it seems that the sunxi and rpi series have still
> > > not been applied to your tree. It would really help to see some
> > > movement on those after all these months.
> >
> > I provided a detailed explanation of what's still wrong with the sunxi
> > series.
>=20
> From what I recall this is that you want Heinrich to do a workaround

Please don't go with what you recall. Please read:
https://lore.kernel.org/u-boot/20250310155336.GJ2640854@bill-the-cat/

Which is what I promised to do.

> with bootmgr and bootstd, but you don't want to disable bootmgr from
> sunxi. In either case, there's nothing I can do here. The series is
> probably getting more and more out of date anyway. Andre might pick it
> up, but I doubt it, given all the arguments about it.
>=20
> > The Pi maintainers are still actively working their way through
> > things.
>=20
> Is there any ETA?

I have pinged them about it.

--=20
Tom

--7Jc2ER5Isp4swimH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfm0VoACgkQFHw5/5Y0
tyzH/gv/aAWMqb+RLzvPN41junMnBSPr7VrFWkPyDBWf4hHVPdjkjFQlyupcHB4x
nIphWMasCtYgKJ0mJqoHLVx3ijZIXqDlIAHbjsmn+DM70Oa2iYkaK8l0BMR3q4+R
tDNzKYd+UkHAcNFaeJvFQSymcUwWnSLFG68QrfpvL854x1oBYB8i6F4XD34ycXeL
LqxUZpf3waJaeO+PixMxr1SI0YVbbsKPXeoY4DuGQptyFLpnlZsJJ4YL0GDB9Hdx
1HNjIQSNo8uCN00doK9Txyngvf+rkrWUXPR244MAE/ijKfxrx3bHP80TMDAr13zQ
8Z7TWpcl7qgWMhcpn7AjYrMeJMmMGLDO8YUSJYI+XTLP2v+zCGrP5fdUJ6b044tI
efRT92Y9A0bnnuDiUD/O+Z5ev4Okotxkz5O9TqUv5E5WsxbjY3drl2Ccn7GGAwDa
AAccby9PTWfgbQ/YkgSN/eSvtN0DpYmfaMt6sZ7RLeRdJD/ONQXOC/1usGZ8f3fQ
NZOw7hCI
=Gpd2
-----END PGP SIGNATURE-----

--7Jc2ER5Isp4swimH--
