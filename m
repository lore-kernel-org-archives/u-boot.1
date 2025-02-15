Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0865C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 14:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B29A80C6F;
	Sat, 15 Feb 2025 15:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sqkQ4ER/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FBA80C98; Sat, 15 Feb 2025 15:47:05 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA26780756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 15:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6fb2a0e4125so23010547b3.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739630818; x=1740235618; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qYAb0WGnublzmugQEjKcImcH5NkVF4MrNSyV5I8OBpM=;
 b=sqkQ4ER/FTWSLJHadPUguFryqKTpkKHOIqVw31BO1+M390/5trggULTyGF+MXCwxOf
 jymlkKHBETVsjdj1iNAIKeNMeGFuvgGD6XkhF8nZJA44Zy7WREIsYSnFA0AtR+mWFmnA
 fc6u3kzNVb84CIzPX/PnuGHyE5Yho9/s6c+Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739630818; x=1740235618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYAb0WGnublzmugQEjKcImcH5NkVF4MrNSyV5I8OBpM=;
 b=V64iL0fCGNwGVUlztS/gFt71Dl5WLmWP3gCzJn63EMCS6FXYLwKksFJjsuy4Tgwn2o
 EzWRPot5QbsU38JEEAvOGu5DK2vv4vL/3Uk89yf13LiHLf+BuHlXbRw1+5OQfekwn7xO
 3jGPaZ7lGBoiChxICKIXxKeK2IQO8NOjFOLSrhARE49eU+2M0H5Z7UyJKnHIJ8uZWjzn
 ygSmsDCrH86H5lXWmc68ZHKYGQP0dbxawBaj7pxJx62LifL4H7JNoylRrSoXQFO4l8bh
 Mc+8KHrU+xDv6NG7pfNE6R1wMyVLa/Y1x8h9lueipIJSSi3dJ0WjFER78G5diWsFkOqX
 wGow==
X-Gm-Message-State: AOJu0YzgBPqOUVIdZha23osaL44fPQEhcXG1sN6fWmcef5ndqL1AReqE
 gkbAS/PRsYCb+TnzIeS545/PhgHEG9j392fUfSG+o9ZS4phEbk/betIiJDS7wuI=
X-Gm-Gg: ASbGnctwlkZ7gvB3DMWxEKmyFRrabWQpWjtpHk2M9B+tNGpjlCEIHLCj9wVuV7JUoYW
 hnpeKvnGGAEOHTftlGQ1tpcckiMN2/QEyahtf9t9tSAvBfFfmfD15WjkZhY+AefCn7KAeP5DJQW
 4Ulki2CppQDSykLHMqD1tncvmcs1N/lqRiKRo32hAzdDyrCDvoybGgOOTq0QaOEbJXtlBqPI59k
 G+P5Rr92LY6TYe4sUKWo/49ke9+bvRO7795Hfta+q5DsXHhThmMIcxF8IzhVLk2ygDOe9y25J+5
 Ek1HYk68DqMUHw==
X-Google-Smtp-Source: AGHT+IFBXGVzX44w2P0fuH7beZ4rNkrnND+cmyhwymsrVEZX1GXgBtYXPx5sCHyh10orjeod0d2PeQ==
X-Received: by 2002:a05:690c:19:b0:6f9:9e80:46bf with SMTP id
 00721157ae682-6fb5831bd5emr28129237b3.29.1739630817479; 
 Sat, 15 Feb 2025 06:46:57 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb360954adsm12327557b3.53.2025.02.15.06.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 06:46:56 -0800 (PST)
Date: Sat, 15 Feb 2025 08:46:52 -0600
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
Message-ID: <20250215144652.GN1233568@bill-the-cat>
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250124191830.GS60249@bill-the-cat>
 <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P8rVZOIQleFBsDjT"
Content-Disposition: inline
In-Reply-To: <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
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


--P8rVZOIQleFBsDjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 05:06:42AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 24 Jan 2025 at 12:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> >
> > > This series implements read_all() so that it is possible to read all =
the
> > > files relating to a bootflow, make adjustments and then boot.
> > >
> > > Unfortunately quite a few things stand in the way, so this series
> > > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > > required support in pxe_utils and the differing code in the extlinux =
and
> > > PXE bootmeths. There is very little new code, but quite a lot of
> > > refactoring.
> > >
> > > The bootm, booti and bootz commands have all been refactored previous=
ly,
> > > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > > At the, time, zboot was left alone, since it is x86-specific and a bit
> > > more trouble.
> > >
> > > However it turns out that the booti support doesn't work with compres=
sed
> > > booti images, so this series resolved that problem too.
> > >
> > > This series adds a programatic API for zboot and uses the forthcoming
> > > bootstd 'image list' to collect information from an extlinux file. It=
 is
> > > therefore possible to parse the file, load the resulting images and t=
hen
> > > examine/adjust the resulting bootflow, before booting.
> > >
> > > The addition of options to extlinux resulted in the PXE and extlinux
> > > bootmeth having slightly different features. This is tidied up in this
> > > series, with common functions for both. This allows the same features
> > > (loading images as a separate step) to be provided for PXE.
> >
> > With v4 of 45/46, this fails with lwIP on Pi in the PXE tests now. You
> > likely don't need more than CONFIG_NET_LWIP=3Dy being added but for
> > completeness here's everything:
> > CONFIG_UNIT_TEST=3Dy
> > # CONFIG_CMD_EFIDEBUG is not set
> > CONFIG_CMD_BOOTMENU=3Dy
> > CONFIG_CMD_LOG=3Dy
> > # CONFIG_CMD_BOOTEFI_SELFTEST is not set
> > CONFIG_IPV6=3Dy
> > CONFIG_IPV6_ROUTER_DISCOVERY=3Dy
> > CONFIG_CMD_TFTPPUT=3Dy
> > CONFIG_CMD_WGET=3Dy
> > CONFIG_FIT=3Dy
> > CONFIG_FIT_SIGNATURE=3Dy
> > CONFIG_FIT_BEST_MATCH=3Dy
> > CONFIG_SYS_BOOTM_LEN=3D0x4000000
> > CONFIG_NET_LWIP=3Dy
> > CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000
> > CONFIG_BOOTSTAGE=3Dy
> > CONFIG_BOOTSTAGE_STASH=3Dy
> > CONFIG_CMD_BOOTSTAGE=3Dy
> > on top of rpi_3_defconfig.
>=20
> I just noticed this response (a bit behind on email), but I don't
> think it is reasonable to require out-of-tree changes. We just need CI
> to pass, along with any labs. This whole series seems to have been
> blocked?
>=20
> If you like, I would be willing to debug it if this series is applied,
> and send a follow-on patch. I have a second rpi3 in my lab which I
> could add to gitlab, along with the changes above, so we can catch
> this sort of thing in future. It would have to be added with some
> documentation, so others can figure out what is going on. Just to be
> clear, I have no issue with LWIP, just with this series being blocked
> due to out-of-tree changes.

I don't know what "out of tree" changes you're referring to. I guess you
mean the test I noted above? It's only out of tree because you didn't
follow up with Heinrich's buildman patch to allow using fragments. If
that was applied then it would be worthwhile to have the Pi targets in
your lab do more tests, including the above. And please note this is my
lab that fails.

--=20
Tom

--P8rVZOIQleFBsDjT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmewqNwACgkQFHw5/5Y0
tyxa0gv9GkWCzaNtUytHggU04OxH+3IN2uRukp8M7qa1ow7XQF1cYES2igbsjSaG
bBSuYTD0hAYrtJMNWwFa95PvmgyrLu3I4cElBNUpVI45H9TnomUFPbmUXgs92/w9
yy18zESxaQAd3AYhJFwc99XJ5vojEdbAQIwdpdi6MdJxyIYMsYd2clw++kU9GWwN
UCU3SkQibDCvXpuBE9qfj96WhsVt8pHXTB0qD/ppr6BgQeLnF1kqDO8Y+S0OLfXR
hg6qeA9V6zPwf8OGsNTfLr/7MFz/OyAJ4h4iSPVHWUKZC/1EQ7ii/6JkUtq8APfP
KCJo1J7KmGKQDPBMMYNTfW/RV5qMMMGRgsypDKXD1y3cjRQbpvVK/LOUG8WYgkhY
Slbi1El8pzsN6s1EMfsCbQesMUOFz5w61pgtpAiXEg4G0AOs//vFd/vjvZhS0DUN
enBFRFK31mLiDRpzmn5cLgjWKi6dZxBJPOchIW70z266zTtEC1v8j6V3a/j5dqFQ
NG+WRdwn
=Ekgr
-----END PGP SIGNATURE-----

--P8rVZOIQleFBsDjT--
