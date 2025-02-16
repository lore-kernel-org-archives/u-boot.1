Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAB4C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 22:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870F98056A;
	Sun, 16 Feb 2025 23:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h8n5cxhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B2E1808B6; Sun, 16 Feb 2025 17:15:28 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F591801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 17:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d132f16dso51927255ad.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 08:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739722522; x=1740327322; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeCuTkvahaioU621BsF1evYM8yOtRUrDSIAdRBD2wJU=;
 b=h8n5cxhLoP1yyE/TqKoIgwpbqe3bqru4hWL2fCxgzo6RUq0BoB1toK+BKZlQ6jBp2f
 2/BlCEgQsJP8/eCGnmuRHx5URo4279I9p2gbktIQgm1pr00cYNaQS9eFsb6mcXCmcyp6
 mUoKRlLYLUsEknALvXdShpCmkyD5f8IeQM5rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739722522; x=1740327322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZeCuTkvahaioU621BsF1evYM8yOtRUrDSIAdRBD2wJU=;
 b=H2CQy3utkt5nsFBcTakRZH3muy9prhg5GlafdeWO287SiW1KA5+yjz4g/XcKZ8H7P/
 PSw/USIq3pqj9Hso+1OoFvu6dcDlhiR0ytGmZzVd0+7Q9KsdPAxls3Hq90mTOhzl88gx
 YFubhGCbiZ7JbSfdErUkVdKxYkAi305fLhQs8iUYG/TmcLnqkTnYoyHpTe654/k/X5Wu
 lk1wxYmwi9vUgN6NMEi28m5XfXe+5xNONvohyBG8REHcUxCdblDA3d1BLSvIBX6HZfas
 myrJCaAghJzYkNc+AGB1IJONlsUR8s8S1ZhNvrQWQNHJt/mBoZqKw2UEFYkFXiPI2C//
 uWJA==
X-Gm-Message-State: AOJu0YzwJfQi+oCRq80ZUI4eHit3i4/plkRDn3yrI7RoWqyPA0W+O9Y8
 HE9X3n6dpWVidFU7W9Expw39BKXHO/upbR7oX33STtDNGElgU6xd/wH8CDFQ27A=
X-Gm-Gg: ASbGncuu8BqIh83/8XeSscTuW52hw13RKMz6JQ6AV0PJI7bzsfSj0dO4df5uSWS03lV
 ZcQgmDq/NEaTcskADpOdvBTYZ4GbkOy1xt+6OAwZqBp/qmpM/7yVg6dOnZQQi1B1e5l/TdwyIFG
 vXzs459/dan+q+N/tvmu6s4ztlWOOlaRmtMe1B8QUN60fdyjrin/3S4wbB64hZiU0oETfyZhk9N
 8oimWon8wnITDJ497vUN458Da6zrHY0WP5eO9v7GaiqtWHdZG9KWEN7NZqZ8Z4DoGPK5KTqluM+
 2qQsIKsU2AY7JQ==
X-Google-Smtp-Source: AGHT+IGoCHqWY+jVgr25efKMPo+60Xqq4wUzKexd7unaNAlYpQREwTJX5qR8+kHoYM+vszX6atNUxw==
X-Received: by 2002:a05:6a20:72a8:b0:1ee:6866:cf10 with SMTP id
 adf61e73a8af0-1ee8cbd1824mr10646173637.39.1739722522504; 
 Sun, 16 Feb 2025 08:15:22 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adead486c0dsm1686102a12.61.2025.02.16.08.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 08:15:21 -0800 (PST)
Date: Sun, 16 Feb 2025 10:15:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Michal Simek <monstr@monstr.eu>
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
Message-ID: <20250216161516.GB1233568@bill-the-cat>
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250124191830.GS60249@bill-the-cat>
 <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
 <20250215144652.GN1233568@bill-the-cat>
 <CAFLszTjnFH3tY5p5e0FNvufqVLzEAD8Sc7Fed=csuSQdMbebPw@mail.gmail.com>
 <20250215182112.GU1233568@bill-the-cat>
 <CAFLszTiG10LVJLeN=rvNBQxH=bHehnTYLTRJ7DGQ0qSOMK=epQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IOUCjHeYVaDNSKLj"
Content-Disposition: inline
In-Reply-To: <CAFLszTiG10LVJLeN=rvNBQxH=bHehnTYLTRJ7DGQ0qSOMK=epQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 16 Feb 2025 23:02:56 +0100
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


--IOUCjHeYVaDNSKLj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 07:09:57AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 11:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 10:24:08AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 15, 2025 at 05:06:42AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 24 Jan 2025 at 12:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > This series implements read_all() so that it is possible to r=
ead all the
> > > > > > > files relating to a bootflow, make adjustments and then boot.
> > > > > > >
> > > > > > > Unfortunately quite a few things stand in the way, so this se=
ries
> > > > > > > finishes off several pending items: zboot without CONFIG_CMDL=
INE,
> > > > > > > required support in pxe_utils and the differing code in the e=
xtlinux and
> > > > > > > PXE bootmeths. There is very little new code, but quite a lot=
 of
> > > > > > > refactoring.
> > > > > > >
> > > > > > > The bootm, booti and bootz commands have all been refactored =
previously,
> > > > > > > so that they can operate without needing CONFIG_CMDLINE to be=
 enabled.
> > > > > > > At the, time, zboot was left alone, since it is x86-specific =
and a bit
> > > > > > > more trouble.
> > > > > > >
> > > > > > > However it turns out that the booti support doesn't work with=
 compressed
> > > > > > > booti images, so this series resolved that problem too.
> > > > > > >
> > > > > > > This series adds a programatic API for zboot and uses the for=
thcoming
> > > > > > > bootstd 'image list' to collect information from an extlinux =
file. It is
> > > > > > > therefore possible to parse the file, load the resulting imag=
es and then
> > > > > > > examine/adjust the resulting bootflow, before booting.
> > > > > > >
> > > > > > > The addition of options to extlinux resulted in the PXE and e=
xtlinux
> > > > > > > bootmeth having slightly different features. This is tidied u=
p in this
> > > > > > > series, with common functions for both. This allows the same =
features
> > > > > > > (loading images as a separate step) to be provided for PXE.
> > > > > >
> > > > > > With v4 of 45/46, this fails with lwIP on Pi in the PXE tests n=
ow. You
> > > > > > likely don't need more than CONFIG_NET_LWIP=3Dy being added but=
 for
> > > > > > completeness here's everything:
> > > > > > CONFIG_UNIT_TEST=3Dy
> > > > > > # CONFIG_CMD_EFIDEBUG is not set
> > > > > > CONFIG_CMD_BOOTMENU=3Dy
> > > > > > CONFIG_CMD_LOG=3Dy
> > > > > > # CONFIG_CMD_BOOTEFI_SELFTEST is not set
> > > > > > CONFIG_IPV6=3Dy
> > > > > > CONFIG_IPV6_ROUTER_DISCOVERY=3Dy
> > > > > > CONFIG_CMD_TFTPPUT=3Dy
> > > > > > CONFIG_CMD_WGET=3Dy
> > > > > > CONFIG_FIT=3Dy
> > > > > > CONFIG_FIT_SIGNATURE=3Dy
> > > > > > CONFIG_FIT_BEST_MATCH=3Dy
> > > > > > CONFIG_SYS_BOOTM_LEN=3D0x4000000
> > > > > > CONFIG_NET_LWIP=3Dy
> > > > > > CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000
> > > > > > CONFIG_BOOTSTAGE=3Dy
> > > > > > CONFIG_BOOTSTAGE_STASH=3Dy
> > > > > > CONFIG_CMD_BOOTSTAGE=3Dy
> > > > > > on top of rpi_3_defconfig.
> > > > >
> > > > > I just noticed this response (a bit behind on email), but I don't
> > > > > think it is reasonable to require out-of-tree changes. We just ne=
ed CI
> > > > > to pass, along with any labs. This whole series seems to have been
> > > > > blocked?
> > > > >
> > > > > If you like, I would be willing to debug it if this series is app=
lied,
> > > > > and send a follow-on patch. I have a second rpi3 in my lab which I
> > > > > could add to gitlab, along with the changes above, so we can catch
> > > > > this sort of thing in future. It would have to be added with some
> > > > > documentation, so others can figure out what is going on. Just to=
 be
> > > > > clear, I have no issue with LWIP, just with this series being blo=
cked
> > > > > due to out-of-tree changes.
> > > >
> > > > I don't know what "out of tree" changes you're referring to. I gues=
s you
> > > > mean the test I noted above? It's only out of tree because you didn=
't
> > > > follow up with Heinrich's buildman patch to allow using fragments. =
If
> > > > that was applied then it would be worthwhile to have the Pi targets=
 in
> > > > your lab do more tests, including the above. And please note this i=
s my
> > > > lab that fails.
> > >
> > > I suggested a file format to specify combinations that we test. You
> > > wanted them to be created as separate boards. If you don't want to
> > > reconsider my proposal[1] you could create a separate in-tree rpi3
> > > board with these options. That would actually be easier for my lab,
> > > although with Heinrich's patch it wouldn't matter much, as you say.
> > >
> > > Heinrich's patch[2] is fine but needs a test. Are you asking me to wr=
ite it?
> >
> > Yes, I much prefer what Heinrich did. As he's apparently been too busy
> > to address your feedback, it would be helpful if you finished it.
>=20
> Yes I can do that - so are you OK to apply this first?

No, I am not. It (a) doesn't apply to master (or more appropriately now,
next) and (b) breaks my lab. I'm actually now a little confused about
why qemu_arm64_lwip doesn't break in CI too. I bet it's because while we
do:
    - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qem=
u_arm64_lwip_na
we don't have a similar link for the boardenv problem (so yes, your
patch to make it say something would be good, but also, ugh, that
https://source.denx.de/u-boot/u-boot/-/jobs/1025936 shows 6 skipped,
nothing passed means we didn't *look* for anything more than green light
/ red light).

So I'm going to go and fix things so qemu_arm64_lwip runs tests for
real, and CI would fail on this series. And Michal, is there a reason we
don't enable network tests in the boardenv files for xilinx? That's
using lwIP now too, but since most of the tests don't run, it would also
not fail there due to being skipped.  You can use the qemu boardenv
files as examples of how to automatically get something available for
tftp.

--=20
Tom

--IOUCjHeYVaDNSKLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeyDxQACgkQFHw5/5Y0
tyxH/Av/QCZ6MoE3bBzIbm74itu7mn0g4MDFoBM+CGl/ZPF4/NheqH8H7Hmkf2t4
ywsETHsaRLJnagKM5BOv8VdzmlC34ZucEatzTOL7bBxaCdSMFRi3Nu9y+pSzY/iy
g9znw8xLdcpIfrWo2L5WtAHR3gxS6E2pNp4adysCJvOsXUvlQldYO0JlH9zhUXVL
J4703oSj71o8l2UuIs4IQ5Adf/F3+T8BF6wC7dyz5vA9KAajV92IVq9ct3R4glRH
DaNR9mBgmvbI6WAuUwZ0fcHW3sY9naxyuenOGgmkwifMIsvdz60KgSzWuSdQCVWR
ILYbouml4Q+zubduec4FQyX0YgmRJ0DwBrLN/93qKtK+k4Ei2EnYczuEXf/NZf0t
BwKqFKdsckc0lkWplMg9MgQfpiJKn8hCH4I7jb01OyeSsiykcuQCNQVL1j4I4kAO
a+cVZSp7wTZsN1chdfhE7P6doJF3nqpnaoMrr1mg/TRCXpo/Fvz6TmEqh/WhC/xi
xmlhUUh+
=LcfT
-----END PGP SIGNATURE-----

--IOUCjHeYVaDNSKLj--
