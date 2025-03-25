Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023C3C3600C
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 16:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37457810E8;
	Tue, 25 Mar 2025 17:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h1JWQuWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13ED8186D; Tue, 25 Mar 2025 17:24:29 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D1E806FC
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 17:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227914acd20so63936575ad.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742919866; x=1743524666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=glY9Gj0pAcjeHJzq8VOsWq0U7N0G41qMMF4IVFrrbrw=;
 b=h1JWQuWkxuclYhisVlQ1eMS7HxbiNOyowCUTvkPgHsT05WLEI0vULf0YYN9b+ahnJG
 KyDCtprzClHwXNTd0DERbnlaDT9FSkLl2onm7e7uxwhJHtZnTqtLm28Hx1ENp0nw4Loa
 hkDoVeWw4FdNtqruRPKQuInmpYao1wH3q8Ksk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742919866; x=1743524666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glY9Gj0pAcjeHJzq8VOsWq0U7N0G41qMMF4IVFrrbrw=;
 b=s1BazUXgIJSlttcB3ZLdkvzCm6KxFCPQrndM789nKJIxeGvsb9l880t5noIjGRjgpo
 MPMUJ3ZnBnbvuh4r1Ha2Rn1mTf5q4eX4Xj5hKfiAcQI4spPrhA/SRkkWruYAkHSwAYEg
 ELbaInsepSAN+QXzQBlNYXKs7YlkETliyGEgoSyqA76AfGVllxtwdajSV7J0k+O3YV+M
 otXZGTonrejNIcnJW7bp/jaH6Hi8oF40hRJ5c8tXpXIFramMazcsY0GX4MY7I27W2nbJ
 Fgq18sIkK8OQ1aWE2+6CKwEPi1/CDmQ0sagVcBzdlRa4sKaZGcbPsldcX0jrn5SxoBd1
 ft9g==
X-Gm-Message-State: AOJu0Yx4ITddXjdIKQA4q2YFtRVmPOPBV2mBejTs/rDEJ9SPSscqhtdI
 Ve8wXWG9+pyf1mITc+uCe7IUf6A6Gn4/mqrf7wNhnBVI0ZXznUyegIICxYpJptg=
X-Gm-Gg: ASbGncv+AQ4r7P1GQQJkzvkC+0PPrwjDuzQzD9EQ38bS6n1EWZQ5xqgL0IBTWFJ7pls
 OHCUnZOqknFCmboFCIp20d4AC3zXZjS88R5FoSHYx3JTR5CAgZoAvMCSMlsLh1Fbc07OqGsHv5r
 S+HDiPYScYOIwagqDCEfBex/EReOpOY5Wwj2ropHN164X0cRk7Jd+Mgv7zGCiTNhlOfwfu1akvp
 nu6ZWGB/LDzlU6XTpd6RdCgNxeMJGAoPmnQOwmFgIedXixPA3L6AA3ZWd3AoG2u01FZ6ETkxcVD
 shP4jotAGdIEtIvR1MHphoQvL0FTWlh0yvvkx6Hmqow=
X-Google-Smtp-Source: AGHT+IE4IdW1wv73OQqLW8ddAYmljy/rauyqdbQPFxT3o6fO5KdEu9pvyk5Ay+ChhHCAMtR9IdmfKA==
X-Received: by 2002:a05:6a00:6ca2:b0:736:b3cb:5db with SMTP id
 d2e1a72fcca58-7395162b1d7mr601615b3a.11.1742919865678; 
 Tue, 25 Mar 2025 09:24:25 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a25375sm7936606a12.47.2025.03.25.09.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:24:25 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:24:20 -0600
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
Message-ID: <20250325162420.GI93000@bill-the-cat>
References: <20250319145512.2391122-1-sjg@chromium.org>
 <20250319145742.GI2640854@bill-the-cat>
 <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
 <20250320142121.GQ2640854@bill-the-cat>
 <CAFLszTgsMu1ZtK1Z-u6cmH6k__0Qhn+G2SPh8w_NdrihLkQ7jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sRiQ3gEGdPhoX2Fj"
Content-Disposition: inline
In-Reply-To: <CAFLszTgsMu1ZtK1Z-u6cmH6k__0Qhn+G2SPh8w_NdrihLkQ7jA@mail.gmail.com>
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


--sRiQ3gEGdPhoX2Fj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 07:38:45PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Mar 2025 at 15:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 20, 2025 at 03:39:26AM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 19 Mar 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass wrote:
> > > >
> > > > > This series collects together some new features for expo to make =
it more
> > > > > useful for boot menus:
> > > > >
> > > > > - measurement and display of multi-line text objects
> > > > > - internal alignment for objects (e.g. centred text)
> > > > > - editable strings in text fields
> > > > > - new 'box' object to draw a rectangle
> > > > > - highlighting of menu items, rather than just relying on a point=
er
> > > > >
> > > > > Expo's boot menu is restructured so that it is possible to iterate
> > > > > through various bootdevs and update the menu as new ones are foun=
d. This
> > > > > is more in keeping with how bootstd works.
> > > > >
> > > > > A new textedit object is added, intended to provide a simple text
> > > > > editor. Future work will complete this.
> > > > >
> > > > > With this series the boot menu has a better layout and appearance.
> > > > >
> > > > >
> > > > > Simon Glass (52):
> > > >
> > > > I see you haven't internalized the "don't post massive series" feed=
back
> > > > yet. Please, stop posting massive patch series. Figure out how to
> > > > logically break things down in to smaller chunks that can be
> > > > meaningfully reviewed.
> > >
> > > I could split this into two series of ~25 patches, perhaps. Would tha=
t be OK?
> > >
> > > I believe no one else is using expo yet, apart from postmarketOS,
> > > except the trivial case of 'bootflow scan -m' but I'm hoping that will
> > > change in the future. I believe that Linaro is mostly encouraging EFI
> > > bootmgr and the text-based menu. That could be converted to use expo
> > > but I doubt anyone has looked into that, particularly as grub is being
> > > pushed as well. I did look at converting the existing menu code a year
> > > or two ago, but it seemed better to eventually deprecate it.
> > >
> > > Also, there is a following series which I split out and will post
> > > separately, but not for a while as I have a lot outstanding.
> > >
> >
> > It would make sense to split expo out to its own series as there's not
> > likely to be any feedback there. All of the other parts of the series
> > already have something else in their subject and that would be logical
> > places to split this up more and then assign to the appropriate
> > custodian. Thanks.
>=20
> This is the expo series and it only has expo patches, so I believe we
> are OK there.
>=20
> The bootstd series is small and its own thing.

OK.

> I can split up the strim() / test series,

OK.

> but I'm still unsure what
> you are asking for with respect to code which is not yet used. I can't
> reasonably do all of a) send code only when it is needed by later
> patches in the series and b) keep series sizes small and c) keep
> series related to a single topic.

I don't see why you can't do that. It is in fact really hard to review
how useful some library functions you write without seeing how they're
used and if in turn we should be doing something different. You might
need to defer or break out as it's own some refactoring changes in order
to meet 'b' above. However "here is a thing" and "here's using a thing"
are still a single topic.

--=20
Tom

--sRiQ3gEGdPhoX2Fj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfi2KgACgkQFHw5/5Y0
tyz9cQv/a+wkeuz3hjWsMHRj1CPFrhpjtf/0ILs/jPKmVOXRhrurUJvKIWlD/3Ka
l4QnPLelVnJBORrL1fPxe+xn61wUglcRoKmky/HnemhDEnglFgWMycE+3SEVELEi
hYo+6NLvQsytSxeZ+/QyZKcmTTGj1dOb7jQKNvzWBBl2g/4lWmLTuBE1Ck37KXRx
qBumouL2mlkGd19t/ThDj5KTBlD8kJRe2zwDwrvaw2RyzvHreZrn35EKa+lZPbv8
kxhvmrbtpwS+OUiRO4qDtqnx6qtXzhqDAvU0hGWeNISfUUOktxQEtKdmc3W4RK2U
G1IuDvDt55sGRMtarpndQ9p3zQS3JaR2Bg2e6puq9/7HODNbCg5+Xz6c5hdOd5vh
wafsBCLqopwICiI2EKopCU5MrvG44RkM56Cm9/9P6Ygck2zJKzU3nmiQGtabTMVQ
KIEQooH90jHp9ajFSHub3kPrQZ+8Pp3ZXVqK0LAhk9hRZ0puIqX4qjzAzaGL7g8l
xDasQOwo
=7/YI
-----END PGP SIGNATURE-----

--sRiQ3gEGdPhoX2Fj--
