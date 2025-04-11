Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A34C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 19:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E09682B27;
	Fri, 11 Apr 2025 21:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iBPMaHxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B725482B34; Fri, 11 Apr 2025 21:13:09 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510CD82B17
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 21:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72b82c8230aso711091a34.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744398786; x=1745003586; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1H6IvTwizt3XIjPSiLVuaAkzvc0leaeQBANmMETa/yo=;
 b=iBPMaHxg57ubsVCE6DmP62thXSUwkEILWzA6I6txU6xMELjBSPbghThCjcMTgO/zsI
 m//uSP/WDbl3LsbsLLLVbETc+gcA0t1s86VmUB9ng2ikwiLLGxUJFiMJkNbxAxXxNv3K
 NfPrK9aV7keqw63Q0P2INE93oqoAUEcdrrQ+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744398786; x=1745003586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1H6IvTwizt3XIjPSiLVuaAkzvc0leaeQBANmMETa/yo=;
 b=sKtQzTVU8pvgoNUh+mjYk0Dfitd7B8BE+8JKXyfIV8U+5pXlHJ6LH/SiL5cQF/1PSj
 jIld5C+eWxgTcOy1ipBDZgVR9eOAxik/TN8CL0mL2xpwCOZhOlHN4CyRL8c7QriFNRCZ
 QLYORTjc/u7aXmt3e0LDkjTTI7/JabUaC1RMThH8rAhxWC8GtXs4KNQBXO+ktySb2I0b
 rCV4VG4JiJKuAvs/7XHwoaP/gko3vKN0da+Wvt9Wj37vC4gCqMy5MEsKEr909e3jMXvs
 oSdWYt3VgFuZvWc1WNtR6soJ8vmRGmFOrMfvjRa9g6uM6ctcVyTuv9P1+cRI3Wac7Gq3
 W8FA==
X-Gm-Message-State: AOJu0YyQiXLMByFotMemmVMrXXJesJQ9PPDH1nos5L0V3JvIb9EHwEKq
 RnsLehnZM1+GYXv/SMcbtdsDLgVm0gWuZ0fxUEBlNXmUUF1yFpfu00GoNekApb0=
X-Gm-Gg: ASbGnctMhJ2PZBqQeLPJBLRIhOwu4CXCY/nLE4rXDl7yMIDmcUxm+3VvRmonRXbk5xT
 94wQIdsN8+a3gMMLtR3kwxyDdfiJUlK953qTK1kaEj9ykPp2iMLYtcaZychQ5nYnbnho45OttDm
 tO9Gn3GccKeJ5W9e/p1BeixkEDPqx6VgTRNwWO1zatkTVtJkTx8erOnI3LaFtKtNp1XvjbGN3pa
 y49K2kvwZP47DfCcM6R0WqZrswrURZy1Zog2/6l9HK4MCIHyevjVP/W97sjvpwztYSx9/1kb4q5
 muOEBs4fChp9TvbvuOZ3t9qLE6JO5zwDzLfpOEk2z66FvC3j7HOnE4C/xpkx0WlqbvnKtMRI51N
 hpw==
X-Google-Smtp-Source: AGHT+IHh3LjPAO/tj36iLEXfO6QTFaR9PzvohludShh3E7uQuPSFGe+BUGuAZqSkcEJ62KWYMbe2Zw==
X-Received: by 2002:a05:6808:2e4c:b0:3f8:a088:3e45 with SMTP id
 5614622812f47-400850f9706mr2630710b6e.36.1744398785741; 
 Fri, 11 Apr 2025 12:13:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400763b6c95sm1072636b6e.48.2025.04.11.12.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 12:13:04 -0700 (PDT)
Date: Fri, 11 Apr 2025 13:13:01 -0600
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
Message-ID: <20250411191301.GZ5495@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-10-sjg@chromium.org>
 <20250319145218.GG2640854@bill-the-cat>
 <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
 <20250319153510.GJ2640854@bill-the-cat>
 <CAFLszTg8a7CCiyyVVQdHDHNJ3MEP-Zxbbao_riy+iTzDt2u-KA@mail.gmail.com>
 <20250330144542.GQ93000@bill-the-cat>
 <CAFLszTiRXB+DpXOgyHiNCF9HoitzYW0EO9fyS2cKKCP8cQaR4A@mail.gmail.com>
 <20250401164856.GH5495@bill-the-cat>
 <CAFLszTiL2=RVf9u96E=0=JKraaeKwFiTf+W1De3bQvFCCnwdGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="st4lsUeb1ZlXESkd"
Content-Disposition: inline
In-Reply-To: <CAFLszTiL2=RVf9u96E=0=JKraaeKwFiTf+W1De3bQvFCCnwdGw@mail.gmail.com>
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


--st4lsUeb1ZlXESkd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 06:55:02AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 2 Apr 2025 at 05:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 02, 2025 at 04:49:18AM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 20, 2025 at 03:41:33AM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 19 Mar 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 19, 2025 at 03:04:28PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > Add an extlinux image that contains a few Ubuntu entries.
> > > > > > > > >
> > > > > > > > > Increase the number of sandbox-USB-hub ports to permit th=
is.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >
> > > > > > > > I don't understand what this test adds. In neither the curr=
ent Fedora
> > > > > > > > test nor in this new test are we actually booting something=
, we're just
> > > > > > > > taking a sample extlinux.conf and making sure it doesn't fa=
il. Is it
> > > > > > > > that we're testing in a useful fashion now having two label=
s?
> > > > > > >
> > > > > > > I didn't think so either, which is why I never did this befor=
e. But it
> > > > > > > turns out that there were some bugs, too.
> > > > > >
> > > > > > I don't understand you, sorry. You don't think so either to wha=
t?
> > > > >
> > > > > I didn't think we needed two extlinux examples on different boot
> > > > > devices, but we do.
> > > >
> > > > I'm not sure it's particularly clear what you're doing here then, or
> > > > why, but I'll find some time to read it all more deeply.
> > >
> > > OK. This test case is how I found the bugs/problems in bootstd that
> > > are fixed in this series.
> >
> > It should be (a) better explained and likely (b) instead of dropping in
> > a seemingly verbatim installed file a specially crafted bit of content.
> > We aren't testing "Ubuntu". We are testing multiple labels.
> >
> > > > > > > > We should probably be clear about what we're doing in the t=
ests and
> > > > > > > > instead of adding seemingly arbitrary distributions add an =
extlinux test
> > > > > > > > and testcases.
> > > > > > >
> > > > > > > This is not actually a test case. It is simply creating a new=
 image.
> > > > > > > The test cases are in the other patches, so please take a loo=
k there.
> > > > > >
> > > > > > Nothing in this series quickly reads as adding tests and fixing=
 problems
> > > > > > with extlinux parsing, it's all bootmeth stuff?
> > > > >
> > > > > It isn't about the actual parsing of the .conf file, although I w=
ould
> > > > > like to add tests there as we have none apart from what I have ad=
ded
> > > > > in my PXE series. It's more about having multiple devices with
> > > > > bootable OSes on them. This series tidies up and fixes this. We n=
eed
> > > > > to have an image available on more than one device to spot these
> > > > > problems.
> > > >
> > > > And the existing tests for pxelinux that we have in mainline alread=
y,
> > > > don't forget those.
> > >
> > > Yes. But those tests actually don't use bootstd, do they?
> >
> > No, they're testing pxelinux, the thing you said we don't have any tests
> > for.
> >
> > > > > Currently we have two accessible to sandbox, one extlinux and one
> > > > > EFI*. I decided to add a third, using extlinux.
> > > > >
> > > > > Again, this is not a test case, but provides an image for the test
> > > > > cases in this series.
> > > >
> > > > Adding mocked up things for use in sandbox is adding test cases.
> > >
> > > One is a test image for use by tests; the other is a test. Perhaps you
> > > are just saying that there is no point in having one without the
> > > other? Otherwise, I'm not sure what to do with this feedback.
> >
> > Maybe I clarified better above now. You're not testing Ubuntu (or Fedora
> > or Armbian or ...) you're seeing if various pxelinux files parse
> > correctly. Making the tests be clearer about what's being tested is
> > what's missing at least in part.
>=20
> You want me to remove the word 'Ubuntu' from the test files? This is
> what I get when I install u-boot-tools so I am trying to use that,
> rather than invent my own thing. This is the same approach I've taken
> with Fedora and Armbian and I think it makes the most sense.

I seem to be unable to explain that if you're constructing tests, I'd
like to see it clear that you're constructing test files. You're not
testing "Ubuntu" or "Fedora" or "Armbian" here. I'm not nak'ing this
patch as at the end of the day, it's adding some test, even if it's also
I believe being done in confusing ways.

--=20
Tom

--st4lsUeb1ZlXESkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5ab0ACgkQFHw5/5Y0
tyx1Dwv+ORf5l/WMVypYrTGMEqFJd9sSJ4spzjrDqHY2PESAPNIv+qgtTZYUTt5G
dBh2RXd1bzyhkLcti/49lRD9IjRupb/M2+MJVbIinyem7rYluxuwiKzvJ3klON95
pKNqhijYZvjZSZef2alrdqvQ5nYnYrZzfzccE/FlKg1POiAud5HkH4deP7CHsP8w
qHM7MT/jAGrjkisCKrZFe4vNVVoev15IngZQUOGoJ6uxMetpfHKgGPot7gDnpUD6
iVe9Ke6soKY+OC18QhowDwa0SEngC3H6Q/gcgO6REg6/XJkZ1r93+sNH+NquNNVy
HlOcQdx7WxVjWn/ZslzxjO4RLUrxuYZdbt+1x7bMlI90rqHtdbg4u2qwF4Z03vle
/6gJr5konwpBsCAakitBe+tLrbRX1/pSXnPPywLkDZ3ZxqyGBkqH5icNcd4ggD+7
eZiWlbo49qQ6Kz2MZcOzbHsRqdz9Rdge7WtfDz0GVMtayfTNh2jIUqLY26e6Rur1
rYzylKVw
=CaZc
-----END PGP SIGNATURE-----

--st4lsUeb1ZlXESkd--
