Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8C0EED632
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 17:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D33B890BC;
	Thu, 12 Sep 2024 19:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jFHYGKnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9BA5890CA; Thu, 12 Sep 2024 19:44:55 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E0D890DD
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 19:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5e174925b7bso37885eaf.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726163092; x=1726767892; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wYCVqJZwFJylF/RUb4haO2+EBTtQ+MrDwn/Oa6SDFlg=;
 b=jFHYGKnAvL4ZQ7pEL4LAZgB/uxh2omIcpD/r5rq0bJVY/Jwz72GOqbE2LY3E9TiRi3
 kQelMjnQ7dcqTh97eopnDOZaafH6WHwYAlhYmrn29IucxNJnLohi5U/lu7ZUKaCmkS7f
 OvRHFtq2WdyOOttrrLFfv3tvGMu/moYdIQCJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726163092; x=1726767892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYCVqJZwFJylF/RUb4haO2+EBTtQ+MrDwn/Oa6SDFlg=;
 b=sNdp2TY6Fke8wi2ikNigAkRbsEsBDTE/dEp8tQ7K73rzQtXTyfT1UMHz0APqhAFFfB
 6bLy+00Do0QCMDmsqkZPLf4da2h0RKj4BN+WkHhYz8SOeAcpKRtMF9COIwWG4d5tHfls
 Zbwf97FRaS4pt84E5Oa0dI2Gi1CJQPQY9BSkEGBEpEj6FKLozRGTJAfCYtrAi2y63zQR
 ajerJ9x8HJwH05rRiDdgbEq5DA6DasRjnWQyu+vivILya07lk3umC5bONP+iaSMN0i3G
 flqlaOtAltqbZjKFhXItvWKycZcAChNZmD0dIh6kfcq9jOA8eSERHoaJnwjb3MnMPxUR
 eplQ==
X-Gm-Message-State: AOJu0YyAVoeD5kppbF4SwBCCGGNComir+o1thGeLJx/Rl+x7RpZ5NVIh
 zbDbT3f2BAmyzzmv+ei0sWxee0gL79KVuBEtT+JEcQlFi9eNrhCAegurs/UlkU0=
X-Google-Smtp-Source: AGHT+IEcxMbLU7nPGEhO+ecwLoU3qfgOwcM4xNH6spILdr1TWglMta9EdLe4LGvVRYU74SfVKJipfA==
X-Received: by 2002:a05:6358:896:b0:1b5:c53d:74b2 with SMTP id
 e5c5f4694b2df-1bc3913ea9emr30520555d.0.1726163091832; 
 Thu, 12 Sep 2024 10:44:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a796a51fsm565375985a.35.2024.09.12.10.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 10:44:51 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:44:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
Message-ID: <20240912174448.GS4252@bill-the-cat>
References: <20240822141013.GQ1626301@bill-the-cat>
 <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
 <20240902153904.GX2479150@bill-the-cat>
 <CAFLszTi4_=n6SmfN8unNx6DgO+C4HQwpxG8gcWuOGUd4Lna_ug@mail.gmail.com>
 <20240910184242.GL4252@bill-the-cat>
 <CAFLszTjfU8m-dQyXXAHJ0FWGfAMdvF3yYDMOofN87qocY0mRyg@mail.gmail.com>
 <20240910185237.GM4252@bill-the-cat>
 <CAFLszTgNPmHD7t4k1BkB_eSVZz7ZgP9=vuoPykm2ZGV0PQxg3g@mail.gmail.com>
 <20240910220708.GN4252@bill-the-cat>
 <CAFLszTj_TEO6K+SU76FHwxsk6awKTXkZ2hS1yJiB5wGA7LMm-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eV3j08byBOgS1/K+"
Content-Disposition: inline
In-Reply-To: <CAFLszTj_TEO6K+SU76FHwxsk6awKTXkZ2hS1yJiB5wGA7LMm-A@mail.gmail.com>
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


--eV3j08byBOgS1/K+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 07:01:37PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 10 Sept 2024 at 16:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 10, 2024 at 02:14:35PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 10 Sept 2024 at 12:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Sep 10, 2024 at 12:45:39PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 10 Sept 2024 at 12:42, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >
> > > > > > On Tue, Sep 10, 2024 at 12:41:11PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 2 Sept 2024 at 09:39, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sun, Sep 01, 2024 at 02:09:39PM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon G=
lass wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > > For most boards, the device-tree compiler is bu=
ilt in-tree, ignoring the
> > > > > > > > > > > > > > system version. Add a special option to skip th=
is build. This can be
> > > > > > > > > > > > > > useful when the system dtc is up-to-date, as it=
 speeds up the build.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >  tools/buildman/builder.py       | 27 +++++++++=
+++++++++++++++++-
> > > > > > > > > > > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > > > > > > > > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > > > > > > > > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > > > > > > > > > > >  tools/buildman/control.py       |  3 ++-
> > > > > > > > > > > > > >  tools/buildman/test.py          | 31 +++++++++=
++++++++++++++++++++++
> > > > > > > > > > > > > >  6 files changed, 66 insertions(+), 4 deletions=
(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > We should probably do this more generically, outs=
ide of buildman. We
> > > > > > > > > > > > > have scripts/dtc-version.sh and if the system ver=
sion isn't new enough
> > > > > > > > > > > > > (and we just need to define whatever the minimum =
version is), then we
> > > > > > > > > > > > > build our (not currently that new anymore) dtc in=
stead.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes I think I did a patch for that ages ago [1], bu=
t it was rejected.
> > > > > > > > > > > >
> > > > > > > > > > > > I'd be very happy for it to be applied as I think i=
t is a better
> > > > > > > > > > > > solution than this one.
> > > > > > > > > > > >
> > > > > > > > > > > > I see that some poor sod tried to do this in Linux =
this morning.
> > > > > > > > > > >
> > > > > > > > > > > Any thoughts on that patch?
> > > > > > > > > >
> > > > > > > > > > I'm open to re-considering [1] again, but we need to ha=
ndle the warning
> > > > > > > > > > problem first. That means...
> > > > > > > > > >
> > > > > > > > > > > Also I do see one problem. Newer dtc version produce =
a lot of
> > > > > > > > > > > warnings, which causes CI to fail. So if we always us=
e the newest
> > > > > > > > > > > version, people are going to see a ton of warnings wh=
en they run
> > > > > > > > > > > locally. Am I missing something here?
> > > > > > > > > >
> > > > > > > > > > Well, it would be great to get our Kbuild logic anywher=
e close to
> > > > > > > > > > in-sync again with upstream. But syncing up the disabli=
ng warning flags
> > > > > > > > > > shouldn't be too hard.
> > > > > > > > >
> > > > > > > > > So, coming back to this patch, the nice thing about it is=
 that it is
> > > > > > > > > deterministic. So people who build U-Boot and don't want =
funky
> > > > > > > > > behaviour will be happy. It will use the internal dtc by =
default. To
> > > > > > > > > use the external one, you must provide an option.
> > > > > > > > >
> > > > > > > > > This patch only affects buildman, but as you can see the =
mechanism it
> > > > > > > > > uses is to set the DTC variable, which people can do with=
out buildman.
> > > > > > > > > It's just a convenience, but useful enough to have a flag=
, I believe.
> > > > > > > >
> > > > > > > > Wait, that's right, we have DTC as a thing that can be set =
in the
> > > > > > > > environment, so why do we need something for buildman at al=
l?
> > > > > > >
> > > > > > > It's a convenience. I have found that it speeds things up qui=
te a bit,
> > > > > > > so I want to enable it most of the time. But we can't do it b=
y default
> > > > > > > and need it to be optional, I believe.
> > > > > >
> > > > > > I wasn't clear, sorry. Why is:
> > > > > > $ export DTC=3D/usr/local/bin/dtc
> > > > > > $ tools/buildman/buildman ...
> > > > > >
> > > > > > Enough?
> > > > >
> > > > > My patch is more equivalent to:
> > > > >
> > > > > DTC=3D`which dtc` buildman...
> > > > >
> > > > > As I said it is a convenience which I want to use all the time,
> > > > > including in CI. Are you worried about changing buildman? What is=
 the
> > > > > issue here?
> > > >
> > > > My question / concern is why do we need:
> > > >
> > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > >
> > > > When we can do it with zero code changes?
> > >
> > > We don't need anything here...but this helps with my productivity as
> > > and can add this flag easily when doing large builds.
> > >
> > > Note that half of those lines are a test and another half are just
> > > plumbing it through all the layers. Any new flag will end up with
> > > this, even if it is a few lines of 'real' code.
> > >
> > > > And then similar to the
> > > > worries I set aside with the "venv" related changes,
> > >
> > > That change does fix a bug. Without the change, we cannot run code
> > > coverage in CI, which I very-much want to turn on once Marek can
> > > figure out the missing Binman tests.
> > >
> > > > you're making one
> > > > tool be clever and work as exactly as expected (but perhaps in a "do
> > > > what I meant, not what I said" manner?) way.
> > >
> > > The only magic is that it locates dtc on the path, but that is the
> > > thing that I find valuable.
> > >
> > > > If we have "set DTC in
> > > > environment, it's always obeyed, can be passed directly to make" but
> > > > also "pass buildman a flag to say where dtc is" why do we need the
> > > > latter if it should already be working, and I think already is work=
ing?
> > >
> > > The flag doesn't tell buildman where dtc is, though. It tells buildman
> > > to hunt for it and use that in preference to the internal build. I am
> > > not suggesting adding anything non-deterministics.
> > >
> > > A general point here...buildman is pretty stable but it is not perfect
> > > and we continue to tweak it to help make it a better tool. When it is
> > > perfect, I will certainly stop sending patches for it. I normally only
> > > send a patch when a bug is reported or something annoys me. The dtc
> > > thing annoys me *a lot* because it chews up ~20% of my CPU for no
> > > purpose. I had not realised how bad this problem was.
> >
> > Thanks for explaining. Whenever you want to pick this one up, go ahead
> > and send it along then. And I guess at some point we should look at (a)
> > re-syncing our libfdt code and (b) switching to using system dtc by
> > default?
>=20
> OK thank you. Perhaps we should file an issue for that? I am trying to
> do one issue a week, although I have failed the last few weeks.

Can't hurt, yeah.

--=20
Tom

--eV3j08byBOgS1/K+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbjKJAACgkQFHw5/5Y0
tyzvEAv6Apf8xKe8k5ukM0V3umd6FsIFZKoCfVHc/3qNOW/7184o+7WQ4Igo6mLf
0kbsopGEpmAK7KnntK6ZVB9ZwoF702uunWZlWIRNTEt4beZ7+jJm4KuHeLksansc
KAbYlL1R1af5TAaUk2z7Uzw79O9+dzK+KVe63DVj4Z/T1QLsH0PO0pGTlYnD7d4f
p0jENP0716TLNZ/p0ce5iO/wk57IUPYVMKfmMEMcSQDg2X4gVZhw4+ctVv7Vlcxa
Xdf9FNOTmdXNky4Pdwj6FOGysckvQIwooo32hi3cVrLTgA5cZQmLIfGAEuPqlQCY
YUzGmSffYZGq5T2ZyZG1efepyiqUc7BrQbwFCN2TnQ5VM76GNuVUccCFr9ln74h2
T294ch8p1nQQWQ7Cv2iogCjDjX9EGcHvVH2JtaxkqwrTsjLycNikt2mBiFlYN4VP
MdwQha3HJSG3Pe7HYCn4WIaJx7mN5nAQ8kFu1X2LQ9mpVk1zjSa2eEPg+21Pto9K
Lwsmb9Zf
=yHQ4
-----END PGP SIGNATURE-----

--eV3j08byBOgS1/K+--
