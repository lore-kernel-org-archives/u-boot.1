Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ABDC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93347807F1;
	Mon, 17 Feb 2025 15:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PnqiUZO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2788083C; Mon, 17 Feb 2025 15:14:17 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BEA980104
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa5af6d743so6650804a91.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 06:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739801652; x=1740406452; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b9JNuqKagY4OKDddEQkL4m4DT24sSDx/XYdj25NLPjQ=;
 b=PnqiUZO2IoH+nshen8qa0SDBQTzAHO/A5+0H7a7eOpYiFAr/+/bCZ3O09J0ImVfZMB
 R5hhVsT+clWubd3YyFdY8UB2LeLI+a1ivNwouG6XABWwe+Ty4WcbDnSNeAHh5W9ibZNY
 Y+25RnKr/hHrsnJuTOwq1WEm8c7j17a2XnZ/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739801652; x=1740406452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9JNuqKagY4OKDddEQkL4m4DT24sSDx/XYdj25NLPjQ=;
 b=eVxTbbhRj3KRfQ92h4jJCdMFMA6n11QC/VgSnfEWLxTpy2riw9+ah6Kv1KvAPPcT9T
 Q7M9Euvc1Q1iEK7/v7Tz6SiGRC8SoOKNfkMFJs0vylI9JJKT05NA89+gx7iEz7RNiDxP
 TOGN1IaOQKpxy7OtubQgtLSyHx0tOLQ9tcpoDEklgc7IXTjBu/hy5TL4RL9hQkch8bXI
 IpPnwz9/6KVtgN4YUXp3za8ErlrFVEP4G6sbON3EytXS71Sk0mCdnAa4ul426HhVt3Tw
 T/EeacV2lu1UCUmkBoC6UbUh6n5ATaQufJ0PCyRkFBmgNWkFu7nBVLI9RMhZtQrDjGjS
 +0MQ==
X-Gm-Message-State: AOJu0YwkxobviDag7/q2I29bOnILbmFsZYbnoAk8NK6+LsdhowI0biEt
 AADsxAY7UZBtm3WNdm9Q2mqrYlXcqn2683eiW5R/+aTdd/AeON6v+DDwSKukgt8=
X-Gm-Gg: ASbGncspPmX5i0SqlrsS2zAsERABYEeTsj/CVc08ITfj4HS4blQFMeKRl8dE4nNMibW
 mhtetrZpabJ77adosC8GRlh85eo4HWfisFRk74hTxkyTfM9t0dOe8r+YTTuD7IYdDJHoPF7Vo3u
 kAwRTGwxy08XONJFngX4KZ7oahosJKEvlRT+0dhyV2p8c/jetI2y7qPcWpM51EYgIc/5Ti9N14U
 LzYv23qsTfb/XqyAfe5tIXeae6qLQV0j6sZ+2b+MJVaEWTpTbZzoFbx35FhboYX2SyyUz0kM9u9
 R+aOpXW52GyHRQ==
X-Google-Smtp-Source: AGHT+IGm/Yrz8XmvfR3RF8FpCEnsgTyi2vlfQehky1xWBZMSRrl2ELeyphncNhF2OBHq75bgF1wrbg==
X-Received: by 2002:a17:90a:d44c:b0:2ee:bf84:4fe8 with SMTP id
 98e67ed59e1d1-2fc41153f71mr13997670a91.30.1739801652490; 
 Mon, 17 Feb 2025 06:14:12 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220e0232190sm67893105ad.186.2025.02.17.06.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 06:14:11 -0800 (PST)
Date: Mon, 17 Feb 2025 08:14:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250217141409.GJ1233568@bill-the-cat>
References: <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
 <20250215181227.GT1233568@bill-the-cat>
 <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
 <20250216160744.GA1233568@bill-the-cat>
 <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
 <20250216215230.GE1233568@bill-the-cat>
 <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P0mt4cuSfWN3pQ1+"
Content-Disposition: inline
In-Reply-To: <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
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


--P0mt4cuSfWN3pQ1+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > This is a global default, so put it under 'default' l=
ike the tags.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > >
> > > > > > > > > > Please make v4 include the way you redid the second pat=
ch and be on top
> > > > > > > > > > of mainline, thanks.
> > > > > > > > >
> > > > > > > > > That's enough versions for me, so I'll let you do that, i=
f you'd like.
> > > > > > > > > It probably doesn't affect your tree as not as much is do=
ne in
> > > > > > > > > parallel.
> > > > > > > >
> > > > > > > > I am disappointed.
> > > > > > >
> > > > > > > I'm sorry to disappoint you.
> > > > > > >
> > > > > > > The background is that I looked at the difference between our=
 trees
> > > > > > > and the gitlab files are quite different. My CI runs take abo=
ut 35
> > > > > > > mins and it seems that yours is around 90 mins. I would like =
to reduce
> > > > > > > / remove the delta (for time and patch diff), but I'm not sur=
e how.
> > > > > > >
> > > > > > > My goal is to get CI runs to below 20 minutes, best case.
> > > > > >
> > > > > > I'm sure CI could be quicker still with a number of faster runn=
ers. But
> > > > > > if you can't be bothered to make changes against mainline, what=
 is the
> > > > > > point?
> > > > >
> > > > > If you recall, I was working with your tree and had various ideas=
 to
> > > > > speed things up, but you didn't like it. So I've had to do it in =
my
> > > > > tree. This is not about more runners (although I might have anoth=
er
> > > > > one soon). It is about running jobs in parallel.
> > > >
> > > > And I wasn't sure more runners in parallel would help (as it would =
slow
> > > > down the fast runner which is what keeps the long jobs from being e=
ven
> > > > longer) as much as adding more regular runners would (which we've d=
one)
> > > > and noted that in the end it's a configuration on the runner side s=
o to
> > > > go ahead. And I reviewed and ack'd the patches here which exposed t=
he
> > > > issues your path revealed. I just can't apply them because they nee=
d to
> > > > be rebased (and squashed).
> > >
> > > You have already added tags for things, but (IIUC) they are around the
> > > other way from what I have added.
> > >
> > > I have a tag called 'single' which means that the machine is only
> > > allowed to one of those jobs. The world-build jobs are marked with
> > > 'single'.
> > >
> > > For other jobs, I allow the runners to pick up some in parallel
> > > depending on their performance (for moa and tui that is 10).
> > >
> > > So at most, there is a 'world build' and 10 test.py jobs running on
> > > the same machine. It seems to work fine in practice, although I would
> > > rather be able to make these two types of jobs mutually exclusive, so
> > > that a runner is either running 10 parallel jobs or 1 'single' job,
> > > but not both. I'm not sure how to do that.
> >
> > So unless I'm missing something, in both cases the bottleneck is that
> > for world build jobs you don't want anything else going on with the
> > underlying build host. You could register 10 "all" runners and 1 "fast
> > amd64" runner (and something similar but smaller for alexandra). If you
> > update the registrations on source.denx.de can you then shut down your
> > gitlab instance?
>=20
> I've put a tag of 'single' on things that should run on the single-job
> runner. Everything else can run concurrently, e.g. up to 10 jobs. So I
> have two runners on the same host. E.g. tui-single has 'limit =3D 1',
> but 'tui' has no limit and is just governed by the 'concurrent =3D 10'
> at the top of the file.

Yes. And you could move those runners to the mainline gitlab. There is
no "single" tag, that would be the "all" tag. And "tui-single" would be
"fast amd64".

> From my side, I have found it helpful and refreshing to have a gitlab
> instance which I can control, e.g. it runs in half the time and if my
> patches are completely blocked by Linaro, etc., I have an escape
> valve.

Yes, and I have no idea what any of that has to do with anything other
than leading to confusion about what tree is or is not mainline. Since
you own u-boot.org and ci.u-boot.org is your gitlab and
https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.

--=20
Tom

--P0mt4cuSfWN3pQ1+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezRDEACgkQFHw5/5Y0
tyxdHgwAtMIUns7fykWFhhJ9GmkQPjfvQgkQ1rPpvqPoiVeAZiNEKBRnfMR7pm9q
vATkpVfGfE1fCMIKnON3ZAv3ZA9h/CLyUpAt/8JuJ6VA4JSDdSztMWB1owE5e4L2
JcemJg+qSjvX4XGxltTrZtq97abwoATCcrMxgqfI+uO+PELKyy92RpeU3EvWMVO8
sHjJxiaSWaO09Df1ws2RkoGK0BLUECgABSZQCLFPYY0HfselLYUO0IMldQi8zOY3
50TYfRm/G6J6swhhdyPFD2IqPtumma404TtuB7mGMOI9xT3Mv8MtDBB9CRBigHFm
pmha2lkZWCc1QcvWGQR543Tv1GrSJRVDeRuXgBr1yvNUV2w4WAiyh5ekuESaW2mQ
lya97QAC5oklmUE1hE9T+oYZz/4XpTXncE7Rm2jOWMsW8tkboH81N1yWk3YKsFdD
thQ1ECGaYnbJsGgA0mZLR4BWuDhv3T7ryuo2gR3oFSPJR9C9uqfC5ypO5p7UUAV1
0g517sIB
=Cmyc
-----END PGP SIGNATURE-----

--P0mt4cuSfWN3pQ1+--
