Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4179AF46C5A
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5850783C2B;
	Mon,  6 Apr 2026 18:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LLmFZvbz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7955983E36; Mon,  6 Apr 2026 18:48:43 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD7C8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 18:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-471618e20a5so699694b6e.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775494119; x=1776098919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iSsrWq3DpBGzt82dh8r/N3GQDgC9DNA0HEMr71FiOho=;
 b=LLmFZvbzA4Z7/2EHtFxvp4MfXJv1ZlYqi8/bRYkHRmy7cjLm+s5AS5qz5zhUt4vNqb
 w2uDadO5OhVnTChA4Qm8HmWNh/jFw6yTs+VSZ5R/OEL2tyb3WrRHFCiS6Z/JzncZNxQ7
 kV63L6DS7etUzEpMDJssJ09CQrpAO3bMS0NbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775494119; x=1776098919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSsrWq3DpBGzt82dh8r/N3GQDgC9DNA0HEMr71FiOho=;
 b=QIDanlBbmyXqKC4tRMMAGouzCOn1QnZr/vsKBpupk16bvdlscfSYTCDF+SZAOqWMmJ
 7XWz5Kt2HBTKSQpy3yRDXZvFWICds3OIiKr1jNGEIsXU3TvrUYbpr/T7Uk6b+fOp0IAk
 bCkQxbEGhiRCYjKNFLTIOdIZN4+NS17S2AravvFUq19trVnXvPWbvRIoYNe418RJg6b8
 p/wQK+1iXbJr3csw0IV0BrDgK8ALTGBJlVtedJkTz1+a6TGFAx1BdyYl4jqpS8M+DO4A
 3+aT2iilLoKLZyUSkILiWmHqydA6+qpRvC+11inGdlw9kfSzodnKCTnZXdN4nikPGKXd
 DiJA==
X-Gm-Message-State: AOJu0YxD+H04J6x1/JrXUuPvu6Z2BYQV8Tnr7RTKRRINB2wdV6zLTjG2
 b5+jUXeKVLTDKfeAAU2uGzQK1SU/nLpPqz174tub8Q+SzkNqUcAzYMleZuR/MjvlGC0=
X-Gm-Gg: AeBDiesGsoS2F4WTP+N8n/8wZAQnM0D2hxTiU38z50IV3bX8cOUj+3saBT0mHLG6TJ0
 WB9DAlia1EAGOfmAFiLwncQ7EBXzdljUsApovJhHEfSm5Px5Wnra2RikCxQKQeddzFiL8npML2f
 uoUODGFtgtR86j+bOssu5B+8e3dxgXEoZkwsapTPKaPjLCkp2hK76M8HxAF4kAtnXs5qNiKyPoj
 v1Q8CnbvJHp1e3sT1FLLZf7vQhNNDKNUw74uN3vedi93uIiDGEJPrS7sr5G1/3QY216ZyJWKaQ9
 3fSVRJRCAApRktccCG6Nlb/9CMbzT+W3q0/Ve2+Bxk8H67nRjkXl5IIkNDNbELBnJh2i41D/wx4
 KtiIqwZpsVvkEWi2cKHfFcMW1jXhtIxPhDWz6T3tTX1CNrxlPP450KX9CP4bx9sVpuM+94YeEqf
 Avrh4vmYippfjcfcDwZZ+TQP0cHhN1b9owrKcKZKJfv9ZXpIpvUqbvVDksV9kr+vOre65BrfDAy
 9mEEWJvMGWkoP/LhjcrX78PElALzR0KGJy4OEq78a1dBDWdDbJTpfuiyiw=
X-Received: by 2002:a05:6820:221d:b0:687:6b:9bee with SMTP id
 006d021491bc7-687006b9f79mr998968eaf.13.1775494119272; 
 Mon, 06 Apr 2026 09:48:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-680a882d978sm8780025eaf.10.2026.04.06.09.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 09:48:38 -0700 (PDT)
Date: Mon, 6 Apr 2026 10:48:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
Message-ID: <20260406164836.GV41863@bill-the-cat>
References: <20260317131839.2418655-1-sjg@chromium.org>
 <20260325201806.GA3445024@bill-the-cat>
 <CAFLszTgEq7e4ee9H3mbNeBOgG-8B8L_-E0LsQNmGPZfXLK2BXA@mail.gmail.com>
 <20260326154716.GA502704@bill-the-cat>
 <CAFLszTjovewJ3YCz-Fu39Tr=W8ZOWo9EC3m1VDVBuEjJG2zcJg@mail.gmail.com>
 <20260327165319.GD502704@bill-the-cat>
 <CAFLszTgV6Kye+gmrJEF1xL5T4JrPxt+QZihYNYhvA=Jn0rVZFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FYTzrHLkM7PvE8cH"
Content-Disposition: inline
In-Reply-To: <CAFLszTgV6Kye+gmrJEF1xL5T4JrPxt+QZihYNYhvA=Jn0rVZFw@mail.gmail.com>
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


--FYTzrHLkM7PvE8cH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2026 at 06:13:29AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 27 Mar 2026 at 10:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 26, 2026 at 01:46:24PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 26 Mar 2026 at 09:47, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 26, 2026 at 05:44:29AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 25 Mar 2026 at 14:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > Various updates:
> > > > > > > - c4 lack signing so does not currently build
> > > > > > > - samus hardware is non-functional
> > > > > > > - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play a=
re new
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > ---
> > > > > > > A sample run is here:
> > > > > > >
> > > > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipeline=
s/29552
> > > > > > >
> > > > > > > At present, coral, play, rpi5, snow and vf2 appear to be genu=
inely
> > > > > > > broken on -next
> > > > > > >
> > > > > > > The ff3399 board needs some investigation.
> > > > > > >
> > > > > > >  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++----=
------
> > > > > > >  1 file changed, 36 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > I have two sets of problems with this patch.
> > > > > >
> > > > > > One, it doesn't do, but perhaps I wasn't clear enough when brin=
ging it
> > > > > > up, change it so that failure to pass is a job failure (it's cu=
rrently a
> > > > > > warning). This in turn means people can't tell expected failure=
 from new
> > > > > > failure.
> > > > >
> > > > > It looks the same as sage...can you post a snippet of what the ru=
les should
> > > > > be? It shows failure for me, when the lab fails.
> > > >
> > > > https://source.denx.de/u-boot/u-boot/-/pipelines/29670 shows a bunc=
h of
> > > > warning for failed boards.
> > >
> > > OK, but how did you generate that? Did you see SJG_LAB=3D1 for the
> > > pipeline? The rules look the same as sage, but perhaps I am missing
> > > something.
> >
> > Yes, I ran the lab job (via the UI instead) in that case and I'm not
> > sure what you're missing in how you've got your lab setup.
>=20
> Just to check, did you pass SJG_LAB=3D1 when you pushed to the pipeline?

Don't recall. Did you find some documentation that says Gitlab treats
them differently?

> > > > > > Two, when you had previously gone about adding at least colibri=
mx8 I
> > > > > > noted that this extended how you were having labgrid build U-Bo=
ot in an
> > > > > > even further non-upstreamable manner. As the sage lab yaml show=
s, we can
> > > > > > bring in external binaries for buildman (and binman) to find an=
d use.
> > > > > > We'll need to extend that logic a bit, to be sure, but it's a s=
olvable
> > > > > > problem with the baseline already there.
> > > > >
> > > > > Not quite. Buildman builds U-Boot, it's just kicked off by Labgri=
d (via a
> > > > > U-Boot 'provider' class), with some pre-built Intel binaries for =
x86, plus
> > > > > BL31, etc. put in as environment variables. My design approach is=
 different
> > > > > from Sage, in that I often connect to boards interactively, send =
U-Boot
> > > > > over USB in some cases (so different files are needed depending o=
n the
> > > > > board) and at the moment I have all boards connected to a single =
server.
> > > > >
> > > > > Labgrid has 90 open PRs, including my terminal one
> > > > > <https://github.com/labgrid-project/labgrid/pull/1571> from over =
a year
> > > > > ago. There definitely are PRs getting in though (20 so far this y=
ear). In
> > > > > terms of upstreaming, my approach has been to break things down i=
nto
> > > > > smaller PRs, but four of them are still outstanding after 18 mont=
hs. I did
> > > > > ask on irc a few times but didn't get a response.
> > > >
> > > > Yes, your approach requires changes to upstream labgrid, while the
> > > > approach I suggested before, and was able to finally get done a whi=
le
> > > > ago, does not, and still allows for using boards interactively. lab=
grid
> > > > even supports python well so whatever tooling you wanted around lab=
grid
> > > > and building u-boot and anything else could be written in that, ins=
tead
> > > > of shell, for example.
> > >
> > > Yes I suspect you are right. One of the design decisions I made was to
> > > put all of the config in one file (the labgrid environment file).
> > > That's not something that the labgrid projects wants.
> > >
> > > I really can't operate with an external terminal program though, as it
> > > loses output at the top for some boards. Also I need the USB drivers
> > > and QEMU changes. Perhaps tougher are the changes to the UBootStrategy
> > > to support sending over USB, different power/reset combinations, etc.
> > >
> > > If I could get some of these smaller PRs upstream then I could start
> > > to do some rework. But until then I'm not it is worth the effort, as
> > > everything will still be downstream.
> > >
> > > I'm definitely keen to replace the shell scripts, probably with
> > > Python. I've had good results with uman being fast to start, having
> > > shell aliases, etc.
> >
> > You've outlined a direction above that I don't think is good for the
> > project as a whole which is why I don't want to encourage it by adding
> > more machines that will only ever work in your version of labgrid and so
> > it not replicable for others. I don't think anything you're describing
> > above can't be done today without making upstream changes and that
> > you've designed yourself in to a corner.
>=20
> Here are the main things that are absolutely required:
> - USB drivers for Tegra, Samsung and Sunxi
> - Servo driver (for Chromebooks)
> - Internal terminal, so that boot output is not lost for some boards
> (I believe we discussed this issue at some length but you have not
> seen this problem yourself)

That's all maybe required, yes. There are indeed various classes for
handling different kinds of drivers, and maybe you need to extend
existing ones, or add another one. I don't know which sunxi case you're
referring to because Pine64+ is working fine today, for how I have one
setup. For the terminal one, it would be good if the labgrid community
could weigh in on your current PR as they certainly know the code better
than you and I.

> - Update U-Boot strategy to support sending over USB and different
> reset/recovery combinations, as well as things like colibri-mx8 which
> need some work-arounds
>=20
> I have PRs up for the first three.
>=20
> Re the last point, I suspect you would argue for separate 'labgrid'
> commands to power on, set reset/recovery, do delays, etc. But that
> logic needs to live...somewhere.

Yes, that's not labgrid, that's something else.

> It is certainly possible for others to replicate the setup[1]. I went
> to a lot of trouble to document it carefully, too. I did a rebase a
> few days ago.
>=20
> As to the direction, I would like to see some progress on the existing
> PRs first, since without that I would only be able to support a small
> subset boards anyway.
>=20
> I do have concerns about performance too. How long does it take to run
> a smoke test for a typical board in your lab?

As long as it takes? My runs on a beaglebone black take longer than
yours, but I'm also running a lot more tests and that's just what it is.
And also using a reservation can take longer than just a direct acquire,
but that's also required for cooperation between humans and CI.

> The main issue is that Labgrid's support for multiple boards in the
> environment is incomplete, but it is improving, e.g. [2]. When I asked
> about this I was told that I should be using a separate environment
> file for each board. I suspect I could move in that direction with a
> bit more tooling.

I don't quite follow you. Yes, there's been changes merged in 2025 (so
after you started your work) that make configuration of some things
cleaner. And yes, you should move in the direction upstream goes.

> I'd also like to move the scripts to Python. For your lab, do you have
> scripts for interactive use, smoke test, running pytests, etc.?

I mean, I don't need a script for interactive use (I could have one, I
just don't see the need) and then yes, I've wrapped pytests around it
for that case.

--=20
Tom

--FYTzrHLkM7PvE8cH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPj4AAKCRAr4qD1Cr/k
Cpr5AQD6TqawCZxzd3V4Z6aVkqzDYiVatt/EMO4mL+tGDpG75AD/dC0FW1/OJiv+
LlIeIjEK65hLR4/Af9mMizQtdwoPowU=
=6NKU
-----END PGP SIGNATURE-----

--FYTzrHLkM7PvE8cH--
