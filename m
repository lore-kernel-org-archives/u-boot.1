Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB518C28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 00:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40DF2810F4;
	Sat, 29 Mar 2025 01:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="naDgOSjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C189281951; Sat, 29 Mar 2025 01:09:32 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C611809A5
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72c40235c34so818918a34.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743206969; x=1743811769; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u0B579CsTPAlV+YXlEPT72MI3YCnZ2z+4Vjf+gkfKbs=;
 b=naDgOSjRA0pTSRR30q8M3JmoO8lE5io2gRWXO7UAwyxXs6AsYYZiYPLzQngXw8tHhq
 za73hiWTn5DwExnnsvGKsIWnAXdCZkA81S3I++4Ndykn7FbeDiaf2pplPsoVh1r/yc4K
 h68ua6vzxbrHMuzHprOzgMYcDh3K9KMOIfZio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743206969; x=1743811769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0B579CsTPAlV+YXlEPT72MI3YCnZ2z+4Vjf+gkfKbs=;
 b=NY0YESGtbD4t7wfSKra4i0z1x0lnrPgYXTmngtg87dLIIvIkdhEI3360iSrXbWJ1A/
 6THg8ZUeVoqQH8TbSs4w6mPs+k70Q+vUIK/AyYpluRmSNqF3jwxs7QxZLAtBgFNGX/qx
 iL6YugwEZYufM2kTdtYrT2yQQIaLZAUtObry4D8ylyl9CX/tSsyqHBhz2m9lNdLiuOxp
 VNsgVQEpeydTH3/KCgRpeAcDZpF9R6cMKRNi5vwpdi/hqIHviVOTcdpAAI6mZG412cVf
 i7Ty+tDIEBKM7sD2Mjjx6vPhP/pgWJIcxER/+Yz5aUMQUUwcg2XxaefTaU9tT6JkPchx
 9Gzw==
X-Gm-Message-State: AOJu0YyRHX1gk69qt7SYQQNJMi9ugW3sCp+FpNnvbGWZ2IkQJDqFPpRe
 +rsRCG9I1V8StA+rFOygN9qb9FAOkWP+ShFbbLzsG0+zNK5wMDMHLye9BwkZCTk=
X-Gm-Gg: ASbGncvJV5QTemjxBxrm/cJOoiEgZg/cIZHNPD9mvBtFEqywnv54Oc3krGjczA2Zgo3
 1I7NQoPpNRhu+JyzbuzBo6HjzQQ6701n5OaRbiPCpgeXeGrfNY1v40TmO1CfrvASQAdfIT6yCjj
 uCclkaPws0njuZD9k1eA3OhPQ35bOrDEbndW5tvS/1rw1Y7vv06SdjlqYRr0Z1ICoMrPV4X1npq
 lrG6Ju/G0TkdOFDcZWARjedML2Nmk7YguAcZ6F+hZuZdjGW9wqkfuNJT9NVFvoq5vN6lB65GBA/
 OKgSfnPhbgZfwhaAqqIh7uPM+N2sTJcpnAozguiX4zmQ9kmEkJcN0YpHEI67ghMofvqhJMfGA2w
 UzH1J5DHWrm1axVFU
X-Google-Smtp-Source: AGHT+IFnBWUdrqG1wMte6j0gRnzZ5+A4d53zHo03UuVfLVvHFUyvVtqlI+zz7MzQI2PbagcjS2LJaQ==
X-Received: by 2002:a05:6830:681a:b0:72c:3235:3b97 with SMTP id
 46e09a7af769-72c6380774dmr997850a34.22.1743206968602; 
 Fri, 28 Mar 2025 17:09:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a856e0asm667090fac.31.2025.03.28.17.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 17:09:27 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:09:24 -0600
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
Message-ID: <20250329000924.GM93000@bill-the-cat>
References: <20250319145742.GI2640854@bill-the-cat>
 <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
 <20250320142121.GQ2640854@bill-the-cat>
 <CAFLszTgsMu1ZtK1Z-u6cmH6k__0Qhn+G2SPh8w_NdrihLkQ7jA@mail.gmail.com>
 <20250325162420.GI93000@bill-the-cat>
 <CAFLszTj49W-Vk_4xpmvtyFH6AH1QAZTLRM7x1k-Bhz7a3uEuBQ@mail.gmail.com>
 <20250327141742.GP93000@bill-the-cat>
 <CAFLszThJqyEQLvngTdxwqa-fsox5jjHBMYVryo6vPA7k_6jhUA@mail.gmail.com>
 <20250328164206.GE93000@bill-the-cat>
 <CAFLszThoz9D=JRzwrfJmeu0dAZ3R7bNS-5UJ2JfzU4a-qx6=aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zCjGYaCHfVJuZAAo"
Content-Disposition: inline
In-Reply-To: <CAFLszThoz9D=JRzwrfJmeu0dAZ3R7bNS-5UJ2JfzU4a-qx6=aQ@mail.gmail.com>
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


--zCjGYaCHfVJuZAAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:41:29PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 28 Mar 2025 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 07:05:35AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 27 Mar 2025 at 08:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 27, 2025 at 07:36:02AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 25 Mar 2025 at 10:24, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 21, 2025 at 07:38:45PM +0100, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 20 Mar 2025 at 15:21, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Thu, Mar 20, 2025 at 03:39:26AM +0000, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Wed, 19 Mar 2025 at 15:57, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > This series collects together some new features for e=
xpo to make it more
> > > > > > > > > > > useful for boot menus:
> > > > > > > > > > >
> > > > > > > > > > > - measurement and display of multi-line text objects
> > > > > > > > > > > - internal alignment for objects (e.g. centred text)
> > > > > > > > > > > - editable strings in text fields
> > > > > > > > > > > - new 'box' object to draw a rectangle
> > > > > > > > > > > - highlighting of menu items, rather than just relyin=
g on a pointer
> > > > > > > > > > >
> > > > > > > > > > > Expo's boot menu is restructured so that it is possib=
le to iterate
> > > > > > > > > > > through various bootdevs and update the menu as new o=
nes are found. This
> > > > > > > > > > > is more in keeping with how bootstd works.
> > > > > > > > > > >
> > > > > > > > > > > A new textedit object is added, intended to provide a=
 simple text
> > > > > > > > > > > editor. Future work will complete this.
> > > > > > > > > > >
> > > > > > > > > > > With this series the boot menu has a better layout an=
d appearance.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Simon Glass (52):
> > > > > > > > > >
> > > > > > > > > > I see you haven't internalized the "don't post massive =
series" feedback
> > > > > > > > > > yet. Please, stop posting massive patch series. Figure =
out how to
> > > > > > > > > > logically break things down in to smaller chunks that c=
an be
> > > > > > > > > > meaningfully reviewed.
> > > > > > > > >
> > > > > > > > > I could split this into two series of ~25 patches, perhap=
s. Would that be OK?
> > > > > > > > >
> > > > > > > > > I believe no one else is using expo yet, apart from postm=
arketOS,
> > > > > > > > > except the trivial case of 'bootflow scan -m' but I'm hop=
ing that will
> > > > > > > > > change in the future. I believe that Linaro is mostly enc=
ouraging EFI
> > > > > > > > > bootmgr and the text-based menu. That could be converted =
to use expo
> > > > > > > > > but I doubt anyone has looked into that, particularly as =
grub is being
> > > > > > > > > pushed as well. I did look at converting the existing men=
u code a year
> > > > > > > > > or two ago, but it seemed better to eventually deprecate =
it.
> > > > > > > > >
> > > > > > > > > Also, there is a following series which I split out and w=
ill post
> > > > > > > > > separately, but not for a while as I have a lot outstandi=
ng.
> > > > > > > > >
> > > > > > > >
> > > > > > > > It would make sense to split expo out to its own series as =
there's not
> > > > > > > > likely to be any feedback there. All of the other parts of =
the series
> > > > > > > > already have something else in their subject and that would=
 be logical
> > > > > > > > places to split this up more and then assign to the appropr=
iate
> > > > > > > > custodian. Thanks.
> > > > > > >
> > > > > > > This is the expo series and it only has expo patches, so I be=
lieve we
> > > > > > > are OK there.
> > > > > > >
> > > > > > > The bootstd series is small and its own thing.
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > > I can split up the strim() / test series,
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > > but I'm still unsure what
> > > > > > > you are asking for with respect to code which is not yet used=
=2E I can't
> > > > > > > reasonably do all of a) send code only when it is needed by l=
ater
> > > > > > > patches in the series and b) keep series sizes small and c) k=
eep
> > > > > > > series related to a single topic.
> > > > > >
> > > > > > I don't see why you can't do that. It is in fact really hard to=
 review
> > > > > > how useful some library functions you write without seeing how =
they're
> > > > > > used and if in turn we should be doing something different. You=
 might
> > > > > > need to defer or break out as it's own some refactoring changes=
 in order
> > > > > > to meet 'b' above. However "here is a thing" and "here's using =
a thing"
> > > > > > are still a single topic.
> > > > >
> > > > > You could just review the code itself, perhaps, rather than worry=
ing
> > > > > whether it will never be used? For me, creating and maintaining a
> > > > > series through acceptance into your tree is still a lot of effort,
> > > > > unfortunately.
> > > >
> > > > No, that's a no-go. Reviewing a library without knowing how it's go=
ing
> > > > to be used is not effective.
> > > >
> > > > > While on that topic, it seems that the sunxi and rpi series have =
still
> > > > > not been applied to your tree. It would really help to see some
> > > > > movement on those after all these months.
> > > >
> > > > I provided a detailed explanation of what's still wrong with the su=
nxi
> > > > series.
> > >
> > > From what I recall this is that you want Heinrich to do a workaround
> >
> > Please don't go with what you recall. Please read:
> > https://lore.kernel.org/u-boot/20250310155336.GJ2640854@bill-the-cat/
> >
> > Which is what I promised to do.
>=20
> OK, so I'll reply there as you still have the wrong end of the stick.
>=20
> >
> > > with bootmgr and bootstd, but you don't want to disable bootmgr from
> > > sunxi. In either case, there's nothing I can do here. The series is
> > > probably getting more and more out of date anyway. Andre might pick it
> > > up, but I doubt it, given all the arguments about it.
> > >
> > > > The Pi maintainers are still actively working their way through
> > > > things.
> > >
> > > Is there any ETA?
> >
> > I have pinged them about it.
>=20
> OK thanks. But that's not an ETA. Raspberry Pi is a widely used platform.

Which is exactly why I'm quite fine with being slow about changes that
aren't bug fixes.

--=20
Tom

--zCjGYaCHfVJuZAAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnOjQACgkQFHw5/5Y0
tyyv4Qv+M5vsa3UgK8QDP4vKJJrijI06KkrvvYvM2EyxjNOsqbtDroqiwa+hSn0Z
rj7ZVKF12jkXqGw0BJZu2PvoNN8eLTyZ9AaWpDLxifCnXFgnBL3/89Y1aQrPrPWC
ypT7YFSgMTykzcBNyGRP1oETt0dYu7y6719F/4rjeZVOHnKDh4OxRMnK1VDDWAjr
sq9YJ6grqOtYpH8Ai+11/xvbo0fubbk9+RHM827SjdhZhgCM9a7T55s8IgWdkeXg
+eC5N3Gin9LozuASRrdI8EiC+kZVHysRXDOpC8XZNrXOTsJTpm63HHVRm2KZk37J
+kStWj068tJELWjHYKAGQ3a+7KlEx6ZQywNK+xMy6fJdLVv0lGKETFQwTUIM914F
P9VaDz5fsyqJyX3PVUbvyB4sjLKqeEEhtXAXI4VqxgEzbqnbmfZtghl4qgXynFnL
7/8JDohc7YpcKN3404/b4x6SZBKmjmbHkwaa5kHtcgm7qR47G5J0SgJ98MzpAd9d
SFEJdVk1
=+BeT
-----END PGP SIGNATURE-----

--zCjGYaCHfVJuZAAo--
