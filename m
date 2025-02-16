Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D779EC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 22:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD10E80BA8;
	Sun, 16 Feb 2025 23:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F80C8fBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D14808B6; Sun, 16 Feb 2025 17:21:43 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DB0801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 17:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so74966575ad.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739722899; x=1740327699; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a/u0yz4dUHBk66C8mOcc/veN/phYDiVGWrxM92dmCGk=;
 b=F80C8fBy9f1naNSAw13VHv3Vbn3lBIHc4HnGEJufnAFitoXli5sMIdgC4R0h/49c71
 KRaeXxd6DHmdW0JHAL97z7ZxjyTBydPOBUjFmwExLQDY+x8WadM/FwneK87y8ifcRIhQ
 gF6IjqgRGFrK6R/x0xAq0IuIOx6h6UxMxDQkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739722899; x=1740327699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/u0yz4dUHBk66C8mOcc/veN/phYDiVGWrxM92dmCGk=;
 b=XK/rwEaRJ7obw5xvOvSf8nNTpFaeKTo7g3IKi5f3AhB0bDnxvtwSb9/IsiDero5LT4
 9kTlPs9MxViFQKgarpPAUZWeu7p7XoliXg37BV7xwPqiEGSdX0ho0kYyxY1hK9ide+HV
 xLucdPMAB2F7em/I4OV9b1bkUkM4Yjxw4qxr6fEDLrssuKbTw6dLdnkuL7FtAQg+h1aC
 fTnMVk70H9OivqsgTRl9oBIHaRJhSVhm8F2a6FGuKBYv4mWlJExdpAPvBIbVOUJIcS+O
 TMJM8s85skQgZFV+0kNLJbKSZuoZ7NcfTSQupacg/TX+TJs6tT/e31GXpSqvTJilWflp
 EfQg==
X-Gm-Message-State: AOJu0YwZbjdRqVOP5OcXfRBJCsiBqqztDWzMTznomYrQ54/DOSOJ7OQj
 FtognlpjCk+WSNnb5a7XtAt27I75CicEmo0ZdLbxEm32w/ygXCBsPY6s5Ew5DD0=
X-Gm-Gg: ASbGncsHCsx6N9CA+V+5HlBdutZaXKumaXtVVhUSt6taBwSwkJ8MJwQ1AaSkFCtA8pU
 JPUwwExCLRCuyp2wl4c2XGzvYHQZA2nQYtkc39YNa5TB4PcTe8Deo4ejXPed2wGlpXEKvE+jtW7
 5wgdH+yk3enjDoVGAYL3NCX4fkVJVSoKpVKqtv1iCctDB7r3x+Aw9FJhVG/9GVvSustHZnMkaNI
 1r8m74ns617Q2Fhqx2PGprrnaUEaUXCagT3huaoz2jDbsg5GC5aasRt+gVMJwvbKyhstX+UQfPR
 /tYL+0WlmQYKOw==
X-Google-Smtp-Source: AGHT+IFoGuH7BddNsAlf0Y+QgruLNfnjl8LWjmUr9b43dS533kzDIvrYwbAHPIsBIM5PFfdu1EgfvA==
X-Received: by 2002:a17:902:ecc7:b0:220:d6c3:17b8 with SMTP id
 d9443c01a7336-22103c602abmr93336045ad.0.1739722899131; 
 Sun, 16 Feb 2025 08:21:39 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm57386065ad.153.2025.02.16.08.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 08:21:38 -0800 (PST)
Date: Sun, 16 Feb 2025 10:21:32 -0600
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
Message-ID: <20250216162132.GC1233568@bill-the-cat>
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250124191830.GS60249@bill-the-cat>
 <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
 <20250215144652.GN1233568@bill-the-cat>
 <CAFLszTjnFH3tY5p5e0FNvufqVLzEAD8Sc7Fed=csuSQdMbebPw@mail.gmail.com>
 <20250215182112.GU1233568@bill-the-cat>
 <CAFLszTiG10LVJLeN=rvNBQxH=bHehnTYLTRJ7DGQ0qSOMK=epQ@mail.gmail.com>
 <20250216161516.GB1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QtU/3hg+OyuXmnUy"
Content-Disposition: inline
In-Reply-To: <20250216161516.GB1233568@bill-the-cat>
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


--QtU/3hg+OyuXmnUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 10:15:16AM -0600, Tom Rini wrote:
> On Sun, Feb 16, 2025 at 07:09:57AM -0700, Simon Glass wrote:
> > Hi Tom,
> >=20
> > On Sat, 15 Feb 2025 at 11:21, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 15, 2025 at 10:24:08AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 15 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 15, 2025 at 05:06:42AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 24 Jan 2025 at 12:18, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > This series implements read_all() so that it is possible to=
 read all the
> > > > > > > > files relating to a bootflow, make adjustments and then boo=
t.
> > > > > > > >
> > > > > > > > Unfortunately quite a few things stand in the way, so this =
series
> > > > > > > > finishes off several pending items: zboot without CONFIG_CM=
DLINE,
> > > > > > > > required support in pxe_utils and the differing code in the=
 extlinux and
> > > > > > > > PXE bootmeths. There is very little new code, but quite a l=
ot of
> > > > > > > > refactoring.
> > > > > > > >
> > > > > > > > The bootm, booti and bootz commands have all been refactore=
d previously,
> > > > > > > > so that they can operate without needing CONFIG_CMDLINE to =
be enabled.
> > > > > > > > At the, time, zboot was left alone, since it is x86-specifi=
c and a bit
> > > > > > > > more trouble.
> > > > > > > >
> > > > > > > > However it turns out that the booti support doesn't work wi=
th compressed
> > > > > > > > booti images, so this series resolved that problem too.
> > > > > > > >
> > > > > > > > This series adds a programatic API for zboot and uses the f=
orthcoming
> > > > > > > > bootstd 'image list' to collect information from an extlinu=
x file. It is
> > > > > > > > therefore possible to parse the file, load the resulting im=
ages and then
> > > > > > > > examine/adjust the resulting bootflow, before booting.
> > > > > > > >
> > > > > > > > The addition of options to extlinux resulted in the PXE and=
 extlinux
> > > > > > > > bootmeth having slightly different features. This is tidied=
 up in this
> > > > > > > > series, with common functions for both. This allows the sam=
e features
> > > > > > > > (loading images as a separate step) to be provided for PXE.
> > > > > > >
> > > > > > > With v4 of 45/46, this fails with lwIP on Pi in the PXE tests=
 now. You
> > > > > > > likely don't need more than CONFIG_NET_LWIP=3Dy being added b=
ut for
> > > > > > > completeness here's everything:
> > > > > > > CONFIG_UNIT_TEST=3Dy
> > > > > > > # CONFIG_CMD_EFIDEBUG is not set
> > > > > > > CONFIG_CMD_BOOTMENU=3Dy
> > > > > > > CONFIG_CMD_LOG=3Dy
> > > > > > > # CONFIG_CMD_BOOTEFI_SELFTEST is not set
> > > > > > > CONFIG_IPV6=3Dy
> > > > > > > CONFIG_IPV6_ROUTER_DISCOVERY=3Dy
> > > > > > > CONFIG_CMD_TFTPPUT=3Dy
> > > > > > > CONFIG_CMD_WGET=3Dy
> > > > > > > CONFIG_FIT=3Dy
> > > > > > > CONFIG_FIT_SIGNATURE=3Dy
> > > > > > > CONFIG_FIT_BEST_MATCH=3Dy
> > > > > > > CONFIG_SYS_BOOTM_LEN=3D0x4000000
> > > > > > > CONFIG_NET_LWIP=3Dy
> > > > > > > CONFIG_BOOTSTAGE_STASH_ADDR=3D0x02400000
> > > > > > > CONFIG_BOOTSTAGE=3Dy
> > > > > > > CONFIG_BOOTSTAGE_STASH=3Dy
> > > > > > > CONFIG_CMD_BOOTSTAGE=3Dy
> > > > > > > on top of rpi_3_defconfig.
> > > > > >
> > > > > > I just noticed this response (a bit behind on email), but I don=
't
> > > > > > think it is reasonable to require out-of-tree changes. We just =
need CI
> > > > > > to pass, along with any labs. This whole series seems to have b=
een
> > > > > > blocked?
> > > > > >
> > > > > > If you like, I would be willing to debug it if this series is a=
pplied,
> > > > > > and send a follow-on patch. I have a second rpi3 in my lab whic=
h I
> > > > > > could add to gitlab, along with the changes above, so we can ca=
tch
> > > > > > this sort of thing in future. It would have to be added with so=
me
> > > > > > documentation, so others can figure out what is going on. Just =
to be
> > > > > > clear, I have no issue with LWIP, just with this series being b=
locked
> > > > > > due to out-of-tree changes.
> > > > >
> > > > > I don't know what "out of tree" changes you're referring to. I gu=
ess you
> > > > > mean the test I noted above? It's only out of tree because you di=
dn't
> > > > > follow up with Heinrich's buildman patch to allow using fragments=
=2E If
> > > > > that was applied then it would be worthwhile to have the Pi targe=
ts in
> > > > > your lab do more tests, including the above. And please note this=
 is my
> > > > > lab that fails.
> > > >
> > > > I suggested a file format to specify combinations that we test. You
> > > > wanted them to be created as separate boards. If you don't want to
> > > > reconsider my proposal[1] you could create a separate in-tree rpi3
> > > > board with these options. That would actually be easier for my lab,
> > > > although with Heinrich's patch it wouldn't matter much, as you say.
> > > >
> > > > Heinrich's patch[2] is fine but needs a test. Are you asking me to =
write it?
> > >
> > > Yes, I much prefer what Heinrich did. As he's apparently been too busy
> > > to address your feedback, it would be helpful if you finished it.
> >=20
> > Yes I can do that - so are you OK to apply this first?
>=20
> No, I am not. It (a) doesn't apply to master (or more appropriately now,
> next) and (b) breaks my lab. I'm actually now a little confused about
> why qemu_arm64_lwip doesn't break in CI too. I bet it's because while we
> do:
>     - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.q=
emu_arm64_lwip_na
> we don't have a similar link for the boardenv problem (so yes, your
> patch to make it say something would be good, but also, ugh, that
> https://source.denx.de/u-boot/u-boot/-/jobs/1025936 shows 6 skipped,
> nothing passed means we didn't *look* for anything more than green light
> / red light).
>=20
> So I'm going to go and fix things so qemu_arm64_lwip runs tests for
> real, and CI would fail on this series. And Michal, is there a reason we
> don't enable network tests in the boardenv files for xilinx? That's
> using lwIP now too, but since most of the tests don't run, it would also
> not fail there due to being skipped.  You can use the qemu boardenv
> files as examples of how to automatically get something available for
> tftp.

And it looks like Azure would like fail as only gitlab was missing the
symlink for the boardenv file. Azure logs get dropped much quicker and I
can't see if I have that failure anymore, but I can see most tests run
on qemu_arm64_lwip.

--=20
Tom

--QtU/3hg+OyuXmnUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeyEIwACgkQFHw5/5Y0
tyx+Wwv/ag7G2GCW7FQmraphKoBVCYQb5JJFhhmYzb4BfW/RdQIPT5nGL0anzexl
65HVF7JONdyJqjVBp71DvaybjAsM/b2Rb3EM1RGfsEqrPQhQdd0tQuqsLD7mv9v6
6FmqtHybSwZfHhUDRovaUu+IxnF3T+wKr4lZOjXiIu8uu7JgSKXsPTBajJFcKDQa
MC6SXqCuoJ3oYtzuXvEwEVxqgc+vvVX/TlwFG+yei7VigCjVvwRjPUbECxAfBIn5
/+q8F9ncOXbxmXFm9Tjl0z3dtDPnqyiLrHvwgdmRGwFW9pM4G2R2E82OQ0Kfb0ME
cUPi+f5kmza6YKj3GMISSjUaVvA4cXrqp/cGq46/ANh7Tr8L4h6xRw5LRRTIt3vd
DSQM4k7QtEvPEiUFo7EALMrS08Emynvr84uSD1fEGlNkJDW82VUI1Zkj/jO5qW7X
p7BQAv/ECr2g9OGq3m+dZOeJyBFRNm5/3MRcYGqskZYpdZ6uErLSC+g6H8WXFijz
5krdtk7X
=ulo/
-----END PGP SIGNATURE-----

--QtU/3hg+OyuXmnUy--
