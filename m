Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD167C369AB
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 18:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C0282EA2;
	Sat, 12 Apr 2025 20:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ruza8ugU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 181EF82EB8; Sat, 12 Apr 2025 20:41:41 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB59F82E9F
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 20:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6047ec0c998so39515eaf.0
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744483297; x=1745088097; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oD012yVSVsIel6IMjHq0+ogI1TQvI+/KYlMgA01jqO4=;
 b=ruza8ugUXfFuswIYlFRDY1Q7BBRv9PDydCWqBkSq53EFyUcneabbCG36U5SJiySRHp
 9XRjg2NrXlxky3FIgL7bKupq7KoOQX5nnfd+XqwGYuEOd3buZVgZXrDI8g/hr1BAbFWS
 js1UiPGlHORY/qOifu+HDiUQI6XkTxnBej0BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744483297; x=1745088097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oD012yVSVsIel6IMjHq0+ogI1TQvI+/KYlMgA01jqO4=;
 b=U7Iz3qvVuSz6hkKrcyMiLujDyyXPO8lxirg+8sslKPX7QLuLUXrr25Yxot3Nzc1JCd
 6OmtEVpWkL3jZ3QWP1CPeAsSGgb4QNjnKFz/BoscF3Mmg80YIPypAP6+K/bBo0UQbt4q
 qIbH/Nqy4DV+FkQlj8a2YL4rGGQG7K9ebN2jyVQO3nt0zJhC7bREQEO6U8B2TGqu8Ft5
 pjs2AhadIg7uodToeDm4zVTECV5V8cTS5BOOkPDNWTMlP+J/BpbnCy4FEjbpFOlIgNO/
 83GZat97HnVW8nZQiONrdlcqh0i6qjnpt784tspnhhR1TLnXaAR7GuBNQ/JZGeq+zHe4
 IyYQ==
X-Gm-Message-State: AOJu0Yx4UAN8IsjCDqmRcWxA9omLllkqE3IKBHdkqYLeNnH91wbwUryn
 q8c1lns8XlnIdAL0Y7v3vQp5+xTdk3b/NVHWavTc7SQolD2H1Gaxpw/MBlRaZ/I=
X-Gm-Gg: ASbGncsm8IrNlXPkf33ABUDOh/34d0X++gBLzRa2EtjquVELi+QdTzro33ocmaIQGir
 aG8K2SJgYS5uh7gWERuQ7m0+A6RhXY92d1PbJAbfiNC6yzMB3xfRor3cC5A3WG6r1scVAoB3Jpt
 jSo+tx7ozy67Gi51zkxAPMOsRSUEJ+l5TGDR831MRynX9hR5OtrRPTIqXO2zKvl6wq0zbWE/GZl
 DZSiC7Wyv1EMqzK2NLb9UQaDuSFUf5wnw5fKYVzHv9bc0Fb8Zf46ToxLhKQGqk9jYs0BxGXJAyr
 xfYFLv/cvi8t40ByZfNeKnu7BjuPUfrpC5cIFZqEwBdD6H22Uf2KwG9PsZoPpB9y0uZalcjQYpP
 1iw==
X-Google-Smtp-Source: AGHT+IGph7CHfMaW8Maokca45iypbSCcw6rse3O/AiaE9F2LUUkBpbmB4srtib/6OeG2zCkEWTcQNg==
X-Received: by 2002:a05:6820:812:b0:603:fada:ac53 with SMTP id
 006d021491bc7-6046f58569dmr3505685eaf.2.1744483297158; 
 Sat, 12 Apr 2025 11:41:37 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f522cfdsm1347707eaf.9.2025.04.12.11.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 11:41:36 -0700 (PDT)
Date: Sat, 12 Apr 2025 12:41:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 09/17] test/py: Add a test image for Ubuntu
Message-ID: <20250412184133.GB5495@bill-the-cat>
References: <20250319145218.GG2640854@bill-the-cat>
 <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
 <20250319153510.GJ2640854@bill-the-cat>
 <CAFLszTg8a7CCiyyVVQdHDHNJ3MEP-Zxbbao_riy+iTzDt2u-KA@mail.gmail.com>
 <20250330144542.GQ93000@bill-the-cat>
 <CAFLszTiRXB+DpXOgyHiNCF9HoitzYW0EO9fyS2cKKCP8cQaR4A@mail.gmail.com>
 <20250401164856.GH5495@bill-the-cat>
 <CAFLszTiL2=RVf9u96E=0=JKraaeKwFiTf+W1De3bQvFCCnwdGw@mail.gmail.com>
 <20250411191301.GZ5495@bill-the-cat>
 <CAFLszThC+P+3RRAakH2vdfWAsitOJ9us74EOeqq_UhxBfvw4CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yQvqS5b/YkCO2nSX"
Content-Disposition: inline
In-Reply-To: <CAFLszThC+P+3RRAakH2vdfWAsitOJ9us74EOeqq_UhxBfvw4CA@mail.gmail.com>
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


--yQvqS5b/YkCO2nSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 06:45:02AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 11 Apr 2025 at 13:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 02, 2025 at 06:55:02AM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 2 Apr 2025 at 05:49, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Apr 02, 2025 at 04:49:18AM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 20, 2025 at 03:41:33AM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 19 Mar 2025 at 16:35, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Wed, Mar 19, 2025 at 03:04:28PM +0000, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > Add an extlinux image that contains a few Ubuntu entr=
ies.
> > > > > > > > > > >
> > > > > > > > > > > Increase the number of sandbox-USB-hub ports to permi=
t this.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > >
> > > > > > > > > > I don't understand what this test adds. In neither the =
current Fedora
> > > > > > > > > > test nor in this new test are we actually booting somet=
hing, we're just
> > > > > > > > > > taking a sample extlinux.conf and making sure it doesn'=
t fail. Is it
> > > > > > > > > > that we're testing in a useful fashion now having two l=
abels?
> > > > > > > > >
> > > > > > > > > I didn't think so either, which is why I never did this b=
efore. But it
> > > > > > > > > turns out that there were some bugs, too.
> > > > > > > >
> > > > > > > > I don't understand you, sorry. You don't think so either to=
 what?
> > > > > > >
> > > > > > > I didn't think we needed two extlinux examples on different b=
oot
> > > > > > > devices, but we do.
> > > > > >
> > > > > > I'm not sure it's particularly clear what you're doing here the=
n, or
> > > > > > why, but I'll find some time to read it all more deeply.
> > > > >
> > > > > OK. This test case is how I found the bugs/problems in bootstd th=
at
> > > > > are fixed in this series.
> > > >
> > > > It should be (a) better explained and likely (b) instead of droppin=
g in
> > > > a seemingly verbatim installed file a specially crafted bit of cont=
ent.
> > > > We aren't testing "Ubuntu". We are testing multiple labels.
> > > >
> > > > > > > > > > We should probably be clear about what we're doing in t=
he tests and
> > > > > > > > > > instead of adding seemingly arbitrary distributions add=
 an extlinux test
> > > > > > > > > > and testcases.
> > > > > > > > >
> > > > > > > > > This is not actually a test case. It is simply creating a=
 new image.
> > > > > > > > > The test cases are in the other patches, so please take a=
 look there.
> > > > > > > >
> > > > > > > > Nothing in this series quickly reads as adding tests and fi=
xing problems
> > > > > > > > with extlinux parsing, it's all bootmeth stuff?
> > > > > > >
> > > > > > > It isn't about the actual parsing of the .conf file, although=
 I would
> > > > > > > like to add tests there as we have none apart from what I hav=
e added
> > > > > > > in my PXE series. It's more about having multiple devices with
> > > > > > > bootable OSes on them. This series tidies up and fixes this. =
We need
> > > > > > > to have an image available on more than one device to spot th=
ese
> > > > > > > problems.
> > > > > >
> > > > > > And the existing tests for pxelinux that we have in mainline al=
ready,
> > > > > > don't forget those.
> > > > >
> > > > > Yes. But those tests actually don't use bootstd, do they?
> > > >
> > > > No, they're testing pxelinux, the thing you said we don't have any =
tests
> > > > for.
> > > >
> > > > > > > Currently we have two accessible to sandbox, one extlinux and=
 one
> > > > > > > EFI*. I decided to add a third, using extlinux.
> > > > > > >
> > > > > > > Again, this is not a test case, but provides an image for the=
 test
> > > > > > > cases in this series.
> > > > > >
> > > > > > Adding mocked up things for use in sandbox is adding test cases.
> > > > >
> > > > > One is a test image for use by tests; the other is a test. Perhap=
s you
> > > > > are just saying that there is no point in having one without the
> > > > > other? Otherwise, I'm not sure what to do with this feedback.
> > > >
> > > > Maybe I clarified better above now. You're not testing Ubuntu (or F=
edora
> > > > or Armbian or ...) you're seeing if various pxelinux files parse
> > > > correctly. Making the tests be clearer about what's being tested is
> > > > what's missing at least in part.
> > >
> > > You want me to remove the word 'Ubuntu' from the test files? This is
> > > what I get when I install u-boot-tools so I am trying to use that,
> > > rather than invent my own thing. This is the same approach I've taken
> > > with Fedora and Armbian and I think it makes the most sense.
> >
> > I seem to be unable to explain that if you're constructing tests, I'd
> > like to see it clear that you're constructing test files. You're not
> > testing "Ubuntu" or "Fedora" or "Armbian" here. I'm not nak'ing this
> > patch as at the end of the day, it's adding some test, even if it's also
> > I believe being done in confusing ways.
>=20
> I actually do understand what you are saying. Indeed I am not testing
> the OS booting, just that we can parse the files that they use to
> describe the OS. I think it is better to use real files rather than
> invent things that are not used in the wild.
>=20
> Perhaps the commit subject is bad. 'Add an extlinux file as used by Ubunt=
u' ?

However you would like to expand the subject / body to clarify further
is fine, thanks.

--=20
Tom

--yQvqS5b/YkCO2nSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf6s9UACgkQFHw5/5Y0
tyy+FAv/TaVicQ53LNan+gTZOMcVMf14KbfyB+vbSbGXDTNa37473ZNHB+E+RnSm
/6jCKznNxbv14stP7idySI0dX8Xgir/vJo33e8aRNuGZeETsStc8rn+v3SZrRPug
d+TOcOdErBsE+jfshmcbpmw9RfgW/+zKo/4GcQw+17SshyL6pAfjLWymZC2n0eVq
eYvWlud4KvWp4MjksJsIi9Ak0Amp499Nr2uFZ6J0b/Ey55qw1upoHTS8qr6VIGPG
TQj8BFO+ZS0uT7w61aSyHu2J2nwdc1gA8f2xF1RWEkXF9EQuHf/mjwK24YeQ/Qui
SIH492+t6ee5r0HU2Ap7eySAwAUCrOOZbwOxzXRBUtZKFDqRecl66jeAoh1/W8dB
1FauqtZwnb2DsmyhWL7kQpUWHKeXzA7egPPCZU8anJu6S89FOZ3XWyAA05xR1fkm
ymmKrFjRQbgEjOs5tSwrPE59VdVHOQRyYYwmQOqb0wG5b2e1wPRwTGxZ++OvIjR2
ILX81Tln
=5Smr
-----END PGP SIGNATURE-----

--yQvqS5b/YkCO2nSX--
