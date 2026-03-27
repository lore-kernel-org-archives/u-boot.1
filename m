Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9244F10F2853
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2A583FAF;
	Fri, 27 Mar 2026 17:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oc4MCA56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864E483FC6; Fri, 27 Mar 2026 17:53:27 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA3F383EB3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 17:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4671cbce32bso657986b6e.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774630403; x=1775235203; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ScFBfXUlDzMoHWRzh/vPny3+1LZ0Ug7Y+J7f/pUhEvs=;
 b=oc4MCA560CP5nJDYkqun7nqCnI3+EfpN7NoRgd1JZsF1hUl7n/lPapQwWxDFoZGx3U
 YcLsLVTslPRoi/PqTRNDyxvOVqswiaHiHFCCruZabAeaTjkG/LV0kBYd2vytOuaTLEVj
 /1OdCn6304/hX2M1jtUqd1lnWV8OJAE2nbvn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630403; x=1775235203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ScFBfXUlDzMoHWRzh/vPny3+1LZ0Ug7Y+J7f/pUhEvs=;
 b=DHJIeXqjiqGRpG2+KRV62QS0oJakgnpnKkNX605yN97XQpe/CtfazBtB/vm7cHBrV3
 9A1A4ys7S8iptikf4G2oJ59TIqd51cCm9PjqJAmnUNEZqcOEa3Dw+f5ob8o0qAFTWH6I
 dxpE11pYLKm9L728F+iVMs5zQrXXKdH2dkH+kh+StxSDLu8f3wQwgJT99d0o3KrB9Rdj
 oU0VlzuPmShNjVasss0yl0cokm01cKMzqv+Pq7PTuStmDj4HNFgYX0JmNvBE1qwXB7U4
 PIkIBJgradohgnXOAeQt3G/PpPdUuqE+jqMAR1EWMykSaJNYg4znchTH+WBqTUZkS58w
 WlWw==
X-Gm-Message-State: AOJu0Yw9u40hb20ktr+MubRFdFj1dJ1S8FS13KxGwskZsCSPDRoQ66ok
 JfB/52dnDiLSGo8VRKe5+lhbr2SgTVShcLeyH2jbICCEGLYOsIZMqGcH/0ISN5lbpeA=
X-Gm-Gg: ATEYQzyeWbJcP1JBl/DCqKWN/OJw0HYqjVQ3VUQswtgmWLHQ2DUqAwXK2B2T0vNpLgy
 YVI0YWrSWiNcGARa7SfSGgFmYBS6j1ceJOthg4ctTGrAT8XebiJB37DpNVBuHew5KlTlEGj3tpJ
 hXFSL0u/ilgC/K8owf/MMnVpzyT8Vba4kl6/+XVnpPv3Gn/NVotPP+ub5mGsb0Q2G9/yUdC0QgC
 4gXU/dDFDmBcnVbWIl3+4RHWS7eyjvqQDPJ0DvhCzGaqfi4rA43j6ieFLU/VyeKnab5UiNg/lHb
 Ma+tzR2TesNiSJO3bA/u8b/RLicl3fsovi7UBP2TSRM6uLJnGnDaDmi79qXiUfd9fFAB04qwDdx
 qpZDOPZkrtHJshJqtYJmAvCvIKem5USdvN1Xqr+ZYPOefI1lbybCB4K0NMFO3339ItkMymFcjyN
 bQ3duu0fhmDFQZPQBjWQ++aNlexzOyrhXih10H/OAQZ/yT3+wRUSD92cudsiIqoBIn9xWpLGVmr
 kHsd8yPvdZSZvMs4yWZ0y8d7lRJLi64DdXQtrMQ1obNdDKD
X-Received: by 2002:a05:6808:1a1c:b0:466:ff3a:c745 with SMTP id
 5614622812f47-46a8a3eb1b4mr1448128b6e.21.1774630403254; 
 Fri, 27 Mar 2026 09:53:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a709434afsm3731438b6e.10.2026.03.27.09.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:53:22 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:53:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
Message-ID: <20260327165319.GD502704@bill-the-cat>
References: <20260317131839.2418655-1-sjg@chromium.org>
 <20260325201806.GA3445024@bill-the-cat>
 <CAFLszTgEq7e4ee9H3mbNeBOgG-8B8L_-E0LsQNmGPZfXLK2BXA@mail.gmail.com>
 <20260326154716.GA502704@bill-the-cat>
 <CAFLszTjovewJ3YCz-Fu39Tr=W8ZOWo9EC3m1VDVBuEjJG2zcJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XEqink8x9e8Yb73X"
Content-Disposition: inline
In-Reply-To: <CAFLszTjovewJ3YCz-Fu39Tr=W8ZOWo9EC3m1VDVBuEjJG2zcJg@mail.gmail.com>
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


--XEqink8x9e8Yb73X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 01:46:24PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 26 Mar 2026 at 09:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 26, 2026 at 05:44:29AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 25 Mar 2026 at 14:18, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
> > > >
> > > > > Various updates:
> > > > > - c4 lack signing so does not currently build
> > > > > - samus hardware is non-functional
> > > > > - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are n=
ew
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > ---
> > > > > A sample run is here:
> > > > >
> > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29=
552
> > > > >
> > > > > At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> > > > > broken on -next
> > > > >
> > > > > The ff3399 board needs some investigation.
> > > > >
> > > > >  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++--------=
--
> > > > >  1 file changed, 36 insertions(+), 10 deletions(-)
> > > >
> > > > I have two sets of problems with this patch.
> > > >
> > > > One, it doesn't do, but perhaps I wasn't clear enough when bringing=
 it
> > > > up, change it so that failure to pass is a job failure (it's curren=
tly a
> > > > warning). This in turn means people can't tell expected failure fro=
m new
> > > > failure.
> > >
> > > It looks the same as sage...can you post a snippet of what the rules =
should
> > > be? It shows failure for me, when the lab fails.
> >
> > https://source.denx.de/u-boot/u-boot/-/pipelines/29670 shows a bunch of
> > warning for failed boards.
>=20
> OK, but how did you generate that? Did you see SJG_LAB=3D1 for the
> pipeline? The rules look the same as sage, but perhaps I am missing
> something.

Yes, I ran the lab job (via the UI instead) in that case and I'm not
sure what you're missing in how you've got your lab setup.

> > > > Two, when you had previously gone about adding at least colibrimx8 I
> > > > noted that this extended how you were having labgrid build U-Boot i=
n an
> > > > even further non-upstreamable manner. As the sage lab yaml shows, w=
e can
> > > > bring in external binaries for buildman (and binman) to find and us=
e.
> > > > We'll need to extend that logic a bit, to be sure, but it's a solva=
ble
> > > > problem with the baseline already there.
> > >
> > > Not quite. Buildman builds U-Boot, it's just kicked off by Labgrid (v=
ia a
> > > U-Boot 'provider' class), with some pre-built Intel binaries for x86,=
 plus
> > > BL31, etc. put in as environment variables. My design approach is dif=
ferent
> > > from Sage, in that I often connect to boards interactively, send U-Bo=
ot
> > > over USB in some cases (so different files are needed depending on the
> > > board) and at the moment I have all boards connected to a single serv=
er.
> > >
> > > Labgrid has 90 open PRs, including my terminal one
> > > <https://github.com/labgrid-project/labgrid/pull/1571> from over a ye=
ar
> > > ago. There definitely are PRs getting in though (20 so far this year)=
=2E In
> > > terms of upstreaming, my approach has been to break things down into
> > > smaller PRs, but four of them are still outstanding after 18 months. =
I did
> > > ask on irc a few times but didn't get a response.
> >
> > Yes, your approach requires changes to upstream labgrid, while the
> > approach I suggested before, and was able to finally get done a while
> > ago, does not, and still allows for using boards interactively. labgrid
> > even supports python well so whatever tooling you wanted around labgrid
> > and building u-boot and anything else could be written in that, instead
> > of shell, for example.
>=20
> Yes I suspect you are right. One of the design decisions I made was to
> put all of the config in one file (the labgrid environment file).
> That's not something that the labgrid projects wants.
>=20
> I really can't operate with an external terminal program though, as it
> loses output at the top for some boards. Also I need the USB drivers
> and QEMU changes. Perhaps tougher are the changes to the UBootStrategy
> to support sending over USB, different power/reset combinations, etc.
>=20
> If I could get some of these smaller PRs upstream then I could start
> to do some rework. But until then I'm not it is worth the effort, as
> everything will still be downstream.
>=20
> I'm definitely keen to replace the shell scripts, probably with
> Python. I've had good results with uman being fast to start, having
> shell aliases, etc.

You've outlined a direction above that I don't think is good for the
project as a whole which is why I don't want to encourage it by adding
more machines that will only ever work in your version of labgrid and so
it not replicable for others. I don't think anything you're describing
above can't be done today without making upstream changes and that
you've designed yourself in to a corner.

--=20
Tom

--XEqink8x9e8Yb73X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaca1/AAKCRAr4qD1Cr/k
CutQAQD4aZX1/fud1g7gKhKTNSVqDTu9nplLtAMnl4W9ThufUQD/brcDw9WYo3Uy
wVRH08ogfHeiZ5M+uMAutLlmvMvFUwc=
=r4OR
-----END PGP SIGNATURE-----

--XEqink8x9e8Yb73X--
