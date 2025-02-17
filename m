Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D35C021AB
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D85FC807F1;
	Mon, 17 Feb 2025 15:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nDFbSd8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4C9809A4; Mon, 17 Feb 2025 15:08:59 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75CBD80104
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f61b01630so83655235ad.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 06:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739801335; x=1740406135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mpYZoDB7+w6HrMlWo8wuzoSdlmQPue1S1+sZlw5EaPw=;
 b=nDFbSd8+ydr0Bq7CpSshuiNhwDfoDMX/UYzgW4MLsndgjqZI6i4FWH8V8sfBOHOV9r
 N6jHmh5Eb5XtROS9WY/UalbMJbEv2Yx1ac+BY37vzyXxX2oiU1tb9bGIO0LpGNwRXw52
 D+UEEv4Ndl1nTLT/Ew9EEJpoZ9B5qZb086J/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739801335; x=1740406135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpYZoDB7+w6HrMlWo8wuzoSdlmQPue1S1+sZlw5EaPw=;
 b=fAC8gXfWUwdYYWdnKkcwmNdWKLsM6IR4rq1AFQrnF9Kyo4O9s1Z7H+RfIlc/aW6+jO
 glZA6dhTc5jug1oTO2us96D6spsc1tHy+PdaxfkKohmIW1L4+GbZMspApv4nWZSgDO8A
 fhC5GBHkG6duZyGjlI8MTI3yOd9QBozW/PhJRWg8xGsPw8OQTa5tYj3NB3eaS01lKnmT
 w6TEYs/wiPdyYEwxAXKaWLz8oCiHblceqYzfQQLBPohbCjiswRBrrbVZsBTHGnsrIV8h
 PAQOveS3pmnoY66S7s1ITlGqQBdPYHgWiyy8GpZrQaXcVqWS62MPtW+tyzYaOpamp9eh
 g+mQ==
X-Gm-Message-State: AOJu0YwPe3Fl2+aY0R5TmXGMFdsWYW4JFyTn6IomrcxJmGzKPXIW55DS
 89f6+xBc2y6OcS+IT79f8/EBCaS5+/cqe6MfcTfvO+EjwS++ntFyOnvyRtPEBRU=
X-Gm-Gg: ASbGncvFGDfdcdK9erqIQodAUfPvhazpaMP60Gh14Kl5LDuXQuYexjcNn/444lPp/vP
 7clPdTTlbV3q6IO3+mIA4aqcKAfUpSZh7f03WYBZXBmAUMRpSfluZJwifdRPMRXSFhhjBlbfl31
 zCuQ1Q3Wtn+2ZURfGIl455YqU8kbwsUmkdAfeP0WUMM77BrEj/gWwx1QpGNd/Vgt/QJYPeQXa1U
 PzuobvtC2pjKhFAQrwPT+WTAqRUNNP3tHtcHYfOB+VtKbhJEJaYWUQSJIe4jD6LxdFcJds1oDxv
 AFHjK7LAK+ByJA==
X-Google-Smtp-Source: AGHT+IEC0s/r79YaWb6w8A4+pdxlMjN4etOkm8QzRLP53Tu0DtC6h7xggGH2mHsK2v2LwCt1T8GWxA==
X-Received: by 2002:a05:6a21:8884:b0:1ee:b7e8:5dfa with SMTP id
 adf61e73a8af0-1eeb7e85fb6mr2759590637.18.1739801334892; 
 Mon, 17 Feb 2025 06:08:54 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7328acf354esm291129b3a.3.2025.02.17.06.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 06:08:54 -0800 (PST)
Date: Mon, 17 Feb 2025 08:08:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250217140851.GH1233568@bill-the-cat>
References: <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
 <20250215182847.GW1233568@bill-the-cat>
 <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
 <20250216150123.GX1233568@bill-the-cat>
 <CAFLszTjM0xXbHqAHHQa4E+8ojesbE+7jrGrw1-6s33NaFENEZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dE0Y7V96pwYqTapT"
Content-Disposition: inline
In-Reply-To: <CAFLszTjM0xXbHqAHHQa4E+8ojesbE+7jrGrw1-6s33NaFENEZA@mail.gmail.com>
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


--dE0Y7V96pwYqTapT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 06:16:12AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 16 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 07:10:31AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> =
wrote:
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass=
 wrote:
> > > > > > > > > > >
> > > > > > > > > > > > The logic of this has become too confusing.
> > > > > > > > > > > >
> > > > > > > > > > > > The primary issue with the patch is that U-Boot nee=
ds to set up a
> > > > > > > > > > > > bloblist in the first phase where BLOBLIST is enabl=
ed. Subsequent
> > > > > > > > > > > > phases can then use that bloblist.
> > > > > > > > > > > >
> > > > > > > > > > > > But the first phase of U-Boot cannot assume that on=
e exists.
> > > > > > > > > > > >
> > > > > > > > > > > > Reverting this commit seems like a better starting =
point for getting
> > > > > > > > > > > > things working for all use-cases.
> > > > > > > > > > > >
> > > > > > > > > > > > Note: The work to tidy this up is apparently underw=
ay. For this series,
> > > > > > > > > > > > a revert is the easiest path.
> > > > > > > > > > > >
> > > > > > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812=
f43be41c3.
> > > > > > > > > > > >
> > > > > > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5Z=
KXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > >
> > > > > > > > > > > >  common/bloblist.c  | 64 ++++++++++++++------------=
--------------------
> > > > > > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > We aren't reverting this change so if you plan to mov=
e this series out of
> > > > > > > > > > > your downstream fork you should start from that and s=
top posting it,
> > > > > > > > > > > that just leads to confusion.
> > > > > > > > > >
> > > > > > > > > > Who is 'we', and start from what?
> > > > > > > > >
> > > > > > > > > We, being the community, in here, the community mainline =
U-Boot project
> > > > > > > > > tree.
> > > > > > > > >
> > > > > > > > > > My goal with this series is to have something that actu=
ally boots on a
> > > > > > > > > > real board, so the bloblist changes are needed for that=
, particularly
> > > > > > > > > > as the 'vbe' board in the lab tests this on the hardwar=
e. I
> > > > > > > > > > deliberately put these two patches at the end of the se=
ries so you can
> > > > > > > > > > ignore them if you'd like.
> > > > > > > > > >
> > > > > > > > > > But for now, as I understand it, there are no users of =
standard
> > > > > > > > > > passage in tree, so actually it would be fine to apply =
them.
> > > > > > > > >
> > > > > > > > > And you can ignore all the feedback you like for your dow=
nstream fork,
> > > > > > > > > sure.
> > > > > > > > >
> > > > > > > > > Part of the feedback in this series already was "Yes, we =
can clean this
> > > > > > > > > up a bit more if bloblist will do its own thing instead".
> > > > > > > >
> > > > > > > > So I see that Raymond's patch is a significant rewrite of w=
hat is
> > > > > > > > there today, with multiple aims and changes. I would rather=
 add my
> > > > > > > > revert and start from a cleaner place.
> > > > > > >
> > > > > > > Also, I forgot to mention that U-Boot doesn't seem to support=
 the
> > > > > > > firmware handoff protocol in SPL? If so, could you point me t=
o the
> > > > > > > code?
> > > > > >
> > > > > > Yes, you never implemented handoff between stages in U-Boot via
> > > > > > register. That's not a use case for the platforms that don't us=
e U-Boot
> > > > > > for SPL.
> > > > >
> > > > > If you let me own bloblist, I'll own it, but for now I am staying=
 away.
> > > >
> > > > Would you be working against mainline again, and not breaking stand=
ard
> > > > passage (as it's been split off) ?
> > >
> > > Sure. The only reason I have my tree is because (I feel that) parts of
> > > U-Boot have become no-go for me. So if you'd like me to maintain
> > > bloblist again, I would be delighted to do so.
> > >
> > > Steps I see:
> > > - Get my boards working again
> >
> > Already done. I'm waiting for Kever to pick up Jonas' small series that
> > brings back output prior to that statement from DM.
>=20
> OK good.
>=20
> >
> > > - Add standard passage from SPL->PPL
> >
> > By who? PPL (and xPL) already reads standard passage via register.
>=20
> I mean implement it in SPL, so it can create the info and pass it to PPL.
>=20
> >
> > > - Figure out what to do on x86 to also use standard passage
> >
> > Standard passage, or bloblist?
>=20
> Well, bloblist today, but I hope we can come up with a standard
> passage for x86 too.

My problem is "standard passage" has a meaning now, so it would be
confusing to call "standard passage" one thing for arm and another for
x86.

> > > I'm not quite sure that BLOBLIST_FIXED can be removed, as it needs
> > > more thought. The phase that creates the bloblist initially needs to
> > > know where to put it.
> >
> > When a phase is running it already has to know what memory is available
> > right now or not, and can allocate as much of a list as it needs now.
> > Later phases can move/grow it.
>=20
> So you mean xPL should use malloc() / simple_malloc() rather than a
> fixed address? Or are you suggesting doing something in
> board_init_f_alloc_reserve()?

My high level point is that a phase must already know what memory it can
and cannot touch, at run time.

--=20
Tom

--dE0Y7V96pwYqTapT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezQvMACgkQFHw5/5Y0
tywDzAwAjAzjYv41ef7Z/ZhZw0FU7Gd3LitFQ6tOAYvcRubBuqS/qAOmDR7XOk/t
/chM7F09sLUWEhLsAXdueEMZ/hz/ErlUq4nBh081rH/NAk9wY1VYg7k5m323nrOc
lIiahdHVVB2UmL8pZVHANOfLitLCS5ejMG4RHvx7+YBiyg3W9YdDmlkTOZxf6EQU
HXsieVq0tL4XodS0AGYbZQJj51ghWr30NpxEYp4CBycrSON6l9VGG+OUB6UU8y2j
iLTcuHSqBuACaJ7qkB/Hw2S/1OUPcSrJ6+v0drQgZs7x5MeE60PaN6UfM1hkUQgG
WI4zojU2J6Eolbh6j87pmZNgTxsYZ9SJwK/DCu/Z4JlX5lkdWHk9KqWyxGlCBApZ
4vopCq3xjFX79GGcs3DWWN5BEJaNqqq6j7WOm8Sr5hihPLTj43fKTH8sAwl2issU
t0+NHx+qcrgKWPlP+gGdhTUPCXfEsjpVIBE7mkIAmtxE00pUcyNthWq4zARpHRij
9UucM9X0
=Innr
-----END PGP SIGNATURE-----

--dE0Y7V96pwYqTapT--
