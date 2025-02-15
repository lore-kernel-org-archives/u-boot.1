Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FBFC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 18:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A843380756;
	Sat, 15 Feb 2025 19:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gG7DDJLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AF0B809A4; Sat, 15 Feb 2025 19:21:22 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE6A80077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 19:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-219f8263ae0so55259035ad.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739643678; x=1740248478; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iJn1STYw8WFeS+p8ospBRUXO+gwKZSTO84T6pD2X+BY=;
 b=gG7DDJLM9CXaZXawOOtnnCz9egJ/oQmZ1t2IgcB9gabo7jveYse3xuflcnuiO8ZZ9z
 fZzK47Ip13bGdOs3km/pBFeU2Yk/u+g2j7Xqvupz42zbiquy5FAJOGUAhfsRloz1ni5U
 3Xuy8gdWf+y54rBNZ8Y4NrQ+xiKSV64VTJT8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739643678; x=1740248478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJn1STYw8WFeS+p8ospBRUXO+gwKZSTO84T6pD2X+BY=;
 b=k0guIQa5mwtMlXTl46PhqQIwmWXl9Q+mgp29X7m9KAKrZgCh/0vP5GApf2zZdbHq6K
 12IG9tZ05PA5JmaGb1EJ/aO0xN+Ux7ZTtLyabAUAhNg1FoDIaDMRTYCCc2fyE7xO4hXm
 YgaBQ8zW7A8ek0CqjG6fmndlA2IVk4C+gm8wcz57UgAEYLnKz0Voa8TdW3rXDbdKq+S8
 axET9XHJ1DGeF1r/Y2XNr8SMs3UMugM0BGUBaT9k8RVI2RfgsKTZtShXamTk8cofzBi/
 RB44LG5cXG4YHMAeIxGIAroM1YXAJsm6KmQvLnenSwYgtkPjgQpc3j8NnvhD/XTHDwwK
 abXg==
X-Gm-Message-State: AOJu0Ywi7pbxg9lrhPfp/SbHmgsorc+UfMJoY+7iszozZOSjDBjXxLFH
 JkoUKqXEysEZ7a6S8b09qt4U/LvxOXjcx7MPty1Ug7B6R1ek2G6lde+cHInKiio=
X-Gm-Gg: ASbGnctLzR9KFmniO+se7vsxGdHPRVizWis6+Au4qAacClO6M1XUs4Ybd0PNmZhWDqj
 p0tSOq05lgGKfeDEv/PZ3BBQtOcAyzmqoCXWJWKPL3YX6Dt2XcqKoQoeOQtFQOPo8FwMIPV9tLr
 rJuADEDs2e99Xunjjmiowmch7W6TDyo1gbC6Brv5ai0tziPEZdx+02et2FT/KiPSlJR0cMLAx+R
 AN4jIn7q3a+tmPurzkKwNZq+ivy0tCSUQhhiPH0Oo1zv156kL08xTXVWd7gHMTzEKSrwx0yt3eE
 JrOJfY0dyd6xKA==
X-Google-Smtp-Source: AGHT+IEc/okAO9kJ5UGHTLiis4DGDvkecmcm23btNeVS3UQ1VFl6ucq+gRHTg7PPkVkHlJtdVXfLgA==
X-Received: by 2002:a05:6a21:3988:b0:1e1:aba4:20ab with SMTP id
 adf61e73a8af0-1ee8cac55a4mr6241996637.5.1739643678261; 
 Sat, 15 Feb 2025 10:21:18 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adf06b0ada5sm38330a12.19.2025.02.15.10.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 10:21:17 -0800 (PST)
Date: Sat, 15 Feb 2025 12:21:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
Message-ID: <20250215182112.GU1233568@bill-the-cat>
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250124191830.GS60249@bill-the-cat>
 <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
 <20250215144652.GN1233568@bill-the-cat>
 <CAFLszTjnFH3tY5p5e0FNvufqVLzEAD8Sc7Fed=csuSQdMbebPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fJYB3ts0g6fQ7Rf1"
Content-Disposition: inline
In-Reply-To: <CAFLszTjnFH3tY5p5e0FNvufqVLzEAD8Sc7Fed=csuSQdMbebPw@mail.gmail.com>
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


--fJYB3ts0g6fQ7Rf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:24:08AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 05:06:42AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 24 Jan 2025 at 12:18, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> > > >
> > > > > This series implements read_all() so that it is possible to read =
all the
> > > > > files relating to a bootflow, make adjustments and then boot.
> > > > >
> > > > > Unfortunately quite a few things stand in the way, so this series
> > > > > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > > > > required support in pxe_utils and the differing code in the extli=
nux and
> > > > > PXE bootmeths. There is very little new code, but quite a lot of
> > > > > refactoring.
> > > > >
> > > > > The bootm, booti and bootz commands have all been refactored prev=
iously,
> > > > > so that they can operate without needing CONFIG_CMDLINE to be ena=
bled.
> > > > > At the, time, zboot was left alone, since it is x86-specific and =
a bit
> > > > > more trouble.
> > > > >
> > > > > However it turns out that the booti support doesn't work with com=
pressed
> > > > > booti images, so this series resolved that problem too.
> > > > >
> > > > > This series adds a programatic API for zboot and uses the forthco=
ming
> > > > > bootstd 'image list' to collect information from an extlinux file=
=2E It is
> > > > > therefore possible to parse the file, load the resulting images a=
nd then
> > > > > examine/adjust the resulting bootflow, before booting.
> > > > >
> > > > > The addition of options to extlinux resulted in the PXE and extli=
nux
> > > > > bootmeth having slightly different features. This is tidied up in=
 this
> > > > > series, with common functions for both. This allows the same feat=
ures
> > > > > (loading images as a separate step) to be provided for PXE.
> > > >
> > > > With v4 of 45/46, this fails with lwIP on Pi in the PXE tests now. =
You
> > > > likely don't need more than CONFIG_NET_LWIP=3Dy being added but for
> > > > completeness here's everything:
> > > > CONFIG_UNIT_TEST=3Dy
> > > > # CONFIG_CMD_EFIDEBUG is not set
> > > > CONFIG_CMD_BOOTMENU=3Dy
> > > > CONFIG_CMD_LOG=3Dy
> > > > # CONFIG_CMD_BOOTEFI_SELFTEST is not set
> > > > CONFIG_IPV6=3Dy
> > > > CONFIG_IPV6_ROUTER_DISCOVERY=3Dy
> > > > CONFIG_CMD_TFTPPUT=3Dy
> > > > CONFIG_CMD_WGET=3Dy
> > > > CONFIG_FIT=3Dy
> > > > CONFIG_FIT_SIGNATURE=3Dy
> > > > CONFIG_FIT_BEST_MATCH=3Dy
> > > > CONFIG_SYS_BOOTM_LEN=3D0x4000000
> > > > CONFIG_NET_LWIP=3Dy
> > > > CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000
> > > > CONFIG_BOOTSTAGE=3Dy
> > > > CONFIG_BOOTSTAGE_STASH=3Dy
> > > > CONFIG_CMD_BOOTSTAGE=3Dy
> > > > on top of rpi_3_defconfig.
> > >
> > > I just noticed this response (a bit behind on email), but I don't
> > > think it is reasonable to require out-of-tree changes. We just need CI
> > > to pass, along with any labs. This whole series seems to have been
> > > blocked?
> > >
> > > If you like, I would be willing to debug it if this series is applied,
> > > and send a follow-on patch. I have a second rpi3 in my lab which I
> > > could add to gitlab, along with the changes above, so we can catch
> > > this sort of thing in future. It would have to be added with some
> > > documentation, so others can figure out what is going on. Just to be
> > > clear, I have no issue with LWIP, just with this series being blocked
> > > due to out-of-tree changes.
> >
> > I don't know what "out of tree" changes you're referring to. I guess you
> > mean the test I noted above? It's only out of tree because you didn't
> > follow up with Heinrich's buildman patch to allow using fragments. If
> > that was applied then it would be worthwhile to have the Pi targets in
> > your lab do more tests, including the above. And please note this is my
> > lab that fails.
>=20
> I suggested a file format to specify combinations that we test. You
> wanted them to be created as separate boards. If you don't want to
> reconsider my proposal[1] you could create a separate in-tree rpi3
> board with these options. That would actually be easier for my lab,
> although with Heinrich's patch it wouldn't matter much, as you say.
>=20
> Heinrich's patch[2] is fine but needs a test. Are you asking me to write =
it?

Yes, I much prefer what Heinrich did. As he's apparently been too busy
to address your feedback, it would be helpful if you finished it.

--=20
Tom

--fJYB3ts0g6fQ7Rf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmew2xgACgkQFHw5/5Y0
tyzJOQv8DE23qJVJK3nnpffQAEicC3EF+GKHTmXCirCPZr9S9NJ09WsY3InKmr8a
Eh4wwV2D8rUfRBBsZIeLvrE3okEWrYy75dDlNMyXcB9ygrqCbqS8fu5Vh4etI2l+
6sMBhtYD+n2TNpTbrwmAxwf8N7/kmgBuM/DIq6bAs6lVHvuXr9RAXSDTd5v5P7mU
foGAFr/zBuhXfNdo/0qY2HguzTGUgAvizeFcEH1bjg1Pb4+3vwoC6HUuKzvrb5Et
DXWLcdUY2cz5jtbZ8IMdZ0vfyr6KcRgjkSQZfhmQYVdYStvmaxSN4emU15yJ/X5P
6SiULL93PSaQxwHlrg83RSq/0CYeHKDCGfDw+WxtbTzH5YIgcmvlP7xiI3bsimBv
EEVsdpmyQiO9XgqTUgW3bZPzXLJpb2z+I3ocKBFJAs86l0wURsPTNkAqvgi8+BI8
FumDZ0XFHfTzQIJD4hl7n21D9wWECjVxR60zsp+l6gPqq9fqCriKgvtar5UyHQUT
BkbILvpl
=oV8h
-----END PGP SIGNATURE-----

--fJYB3ts0g6fQ7Rf1--
