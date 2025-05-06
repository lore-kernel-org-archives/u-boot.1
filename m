Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BF4C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A31938214B;
	Tue,  6 May 2025 18:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hT8F7H1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD4F82163; Tue,  6 May 2025 18:25:44 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641EA8210D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-605ff8aa9d2so1515739eaf.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746548740; x=1747153540; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6vl+osqtZ0mWvIhjT4EwLZf4CLP1lDDVjEqigDD2fjg=;
 b=hT8F7H1oHnSZL0IZ76GITBwrNnDwprRF5nvWNtCSasxsuRaI4OIxM45Dd2d2UM5p3b
 2jupE4R+fhIjYqTv94T2Fx+J0xRO8USC2FJ7B10ZIKF4L4Z7zbYnhna8xMw1Pl/0qVla
 vmIseCgbWdBMZts++XFQ6p1unBpwTVmmmMzCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746548740; x=1747153540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vl+osqtZ0mWvIhjT4EwLZf4CLP1lDDVjEqigDD2fjg=;
 b=nieud/U2m8ZLfVC7foWjznq9jOfIrpfabYCsFvRNh2G+ps6wqO+VyG0vLuvP8CqbCl
 QISu7otMFImWKcfftuibAZiW2a5K2Nd/3HRPMt4G4wdRMdHlVmqMMl3s9jRYj7GFp7+F
 pTL5eivO7Gzwp/pIQDYyYcWYwA0u41h9hR630MVyLkroRcT2iCHj8wEd5uqu9d3JELcP
 uPKl3BM7HhalrDBMxGgcOYc/5nRbFsSK4kenVGSaG5Q/U8p5wjYcYH2AxH/wUyOi5Nt3
 OkTr+ajSmwRJsJgnvEQ4YorcHBtcQdJ5MYW2PzV0WWMPYnOrPK44OXUAoXxN2NeAmOuS
 GcYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSSN7PE7bCq0bpMsD3s1jeZtNDfWAGdnMiqRiRUSYhAG6RmljqY8ChTDwUNY5GvboYlnkcB58=@lists.denx.de
X-Gm-Message-State: AOJu0Yxq/SREp5natiNKCZz/QiuiDs3B1h4dz+DtVgPOusjcwg2YqpMA
 c5B9z2FNveqNid2U8ONQ7UMj+/AJoO+KhpbOP7IN13AUyZ1PYzZZk3GmkhSSOj4=
X-Gm-Gg: ASbGncvU0veWnNeGr69L0qhYHI5zfYPgldRzaO1kkiAxoCMCmWik2HsygyYl9dNFrkX
 vEoB3XdsTsyfBw0z8jyFoSdl5pVDnySzJ/8YTDN6Cx3U2LfrIP/ht6ZNdzBe6+XnRaFdtEFxoov
 3fij44ZbSkA2ikGf6tujBaINKkOCvlf61RQDITeC11nQuGqBZCANtkQHyycg2tSrqReHKRGQt9L
 MqO20L4W39Vlx9dzeETv8jiUIHD1h/nPb5dGRDzLpdp1dsNbHJCDvbi3828APQQ7dXvR6acyw4C
 SdL4j0vFrt06SAwUa0jaWfsMuO9LNsPK9sLMSjq6GgBiqlMPrsviJILst/ZYeHiWBNWWvbUfebc
 s/w==
X-Google-Smtp-Source: AGHT+IFq+avuF299Uv2NveaTy7eNnOwpJB+fvL/n1yLBjK5J63dFQMNckIHRfQPmUQnQBptqHTvQEQ==
X-Received: by 2002:a05:6820:200c:b0:5fe:9edb:eafe with SMTP id
 006d021491bc7-60828d37e56mr57452eaf.5.1746548740051; 
 Tue, 06 May 2025 09:25:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fb7786sm2234082eaf.30.2025.05.06.09.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:25:39 -0700 (PDT)
Date: Tue, 6 May 2025 10:25:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250506162537.GX5430@bill-the-cat>
References: <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
 <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
 <20250502193020.GZ1261075@bill-the-cat>
 <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
 <20250502200451.GA1261075@bill-the-cat>
 <CAFLszThgJQvA57g8LH0JH6Bq8wk=hnQUnchaUD0SB6v+0JTezg@mail.gmail.com>
 <20250505181846.GJ5430@bill-the-cat>
 <CAFLszThgq8afbSL8zHqP6nCoB+F5wU6M0MbAoYRsJh8iMi8orA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YKiGwWTmFk3Jn4aw"
Content-Disposition: inline
In-Reply-To: <CAFLszThgq8afbSL8zHqP6nCoB+F5wU6M0MbAoYRsJh8iMi8orA@mail.gmail.com>
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


--YKiGwWTmFk3Jn4aw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 03:23:59PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 5 May 2025 at 20:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 03, 2025 at 08:29:13AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 2 May 2025 at 14:04, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 02, 2025 at 09:42:56PM +0200, Heinrich Schuchardt wrote:
> > > > > On 5/2/25 21:30, Tom Rini wrote:
> > > > > > On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich Schuchardt w=
rote:
> > > > > > > On 5/2/25 17:06, Tom Rini wrote:
> > > > > > > > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > During a recent discussion with Heinrich we discussed=
 why the hooks are
> > > > > > > > > > > kept in a separate repo.
> > > > > > > > > > >
> > > > > > > > > > > The amount of code is small, a tenth of the size of t=
he recently added
> > > > > > > > > > > lwip, just by way of example. Testing is a critical p=
art of U-Boot and
> > > > > > > > > > > one of the things that distinguishes it from firmware=
 projects that have
> > > > > > > > > > > not kept up in this area. By having the tests somewhe=
re else, we are
> > > > > > > > > > > signalling that it is unusual, or difficult, or optio=
nal.
> > > > > > > > > > >
> > > > > > > > > > > The hooks mechanism also needs something of an update=
 to take account of
> > > > > > > > > > > real boards in 2025. That will be much easier to unde=
rtake if the code
> > > > > > > > > > > that test/py talks to is in the same repo.
> > > > > > > > > > >
> > > > > > > > > > > This series brings the hook files in as first-class c=
itizens of U-Boot.
> > > > > > > > > > >
> > > > > > > > > > > If we do go ahead with this, I will send a different =
series which has
> > > > > > > > > > > separate commits (with correct author) in the u-boot-=
test-hooks repo.
> > > > > > > > > >
> > > > > > > > > > I think bringing more projects directly in to the repos=
itory is a bad
> > > > > > > > > > idea. Your example of lwip isn't applicable because it'=
s a read-only
> > > > > > > > > > subtree that's maintained outside of the project (same =
as the dts
> > > > > > > > > > subtree). But sure, lets "Say Yes". That said, we still=
 need to:
> > > > > > > > > > - Remove needless examples from the tree.
> > > > > > > > > > - Not include personal labs directly in the tree.
> > > > > > > > > >
> > > > > > > > > > That last one is why I really think this is a bad idea.=
 The point of
> > > > > > > > > > having the hooks standalone is so that any given lab ca=
n easily add
> > > > > > > > > > support for their lab and manage it, without worrying a=
bout disclosing
> > > > > > > > > > internal layout. There's going to be hard coded default=
 passwords there.
> > > > > > >
> > > > > > > Secrets MUST NEVER reside in git repos.
> > > > > > >
> > > > > > > I can't imagine that such irresponsible habits would be pract=
iced by any
> > > > > > > accountable developer.
> > > > > >
> > > > > > I agree it shouldn't be done. And just this week was the most r=
ecent
> > > > > > time I've seen a company do that internally, because it's inter=
nal and
> > > > > > was just a temporary thing. We helped them stop needing to do t=
hat, but
> > > > > > assuming it never happens is a bad idea.
> > > > > >
> > > > > > > Please, have a look at
> > > > > > >
> > > > > > > https://docs.github.com/en/actions/security-for-github-action=
s/security-guides/using-secrets-in-github-actions
> > > > > > > https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab=
/07_pass-build-secrets.html
> > > > > > >
> > > > > > > to see how to do it properly.
> > > > > > >
> > > > > > > The same is true for a private lab:
> > > > > > > Use environment variables that are coming from outside the re=
pository.
> > > > > > >
> > > > > > > > > > There's going to be repository secrets there. That kind=
 of information
> > > > > > > > > > really should not be in a public repository. Integratin=
g the hooks with
> > > > > > > > > > mainline will make lab management harder, not easier. T=
he point of the
> > > > > > > > > > existing labs in u-boot-test-hooks is to provide sample=
s.
> > > > > > > > > >
> > > > > > > > > > I think this is all why no, we should not go down this =
path.
> > > > > > > > >
> > > > > > > > > Is it worth discussing this, or is your mind made up? I h=
ave some
> > > > > > > > > thoughts on the last one.
> > > > > > > >
> > > > > > > > I think it's a terrible idea that I already said:
> > > > > > > > > But sure, lets "Say Yes".
> > > > > > > >
> > > > > > > > But please do spend time explaining your thoughts and perha=
ps others
> > > > > > > > will also agree with you and I'll feel less bad taking this=
 in?
> > >
> > > Well firstly, we should bring in the whole git history so I don't
> > > believe these patches should be applied as is. I did push a branch[1]
> > > but can send the commands if it helps.
> >
> > I don't see how that's relevant here, but OK.
> >
> > > > > > > Currently when changing a test hook I have to go through thes=
e steps:
> > > > > > >
> > > > > > > * fork u-boot-test-hooks
> > > > > > > * push a commit to my fork
> > > > > > > * update both .gitlab-ci.yaml and .azure-pipelines.yaml
> > > > > > > * commit the change code.denx.de
> > > > > > > * create a merge request for github.com/u-boot/u-boot
> > > > > > >
> > > > > > > If the test hooks were in the same repo as main U-Boot, I cou=
ld save two
> > > > > > > steps.
> > > > > >
> > > > > > Yes, that's true, the steps for updating our CI are a little bi=
t longer.
> > > > > > I would be happy to make u-boot-test-hooks more widely writable=
 (so it
> > > > > > would instead be pushing to a branch for step 1+2). But I'm also
> > > > > > concerned with external labs (which is both the origin of these=
 scripts,
> > > > > > and where they're also used).
> > > > > >
> > > > > > Today, I have both a "konsulko" branch of u-boot-test-hooks, in=
ternally.
> > > > > > That has subdirectories for both "sage" and "lootbox" (the two =
lab
> > > > > > hosts), and in turn py and bin subdirectories for each. There's=
 no value
> > > > > > in publishing these changes as there's nothing unique about the
> > > > > > platforms there, which aren't already in the mainline u-boot-te=
st-hooks.
> > > > > >
> > > > > > How should I manage these changes moving forward?
> > > > >
> > > > > You could create two branches based on origin/master u-boot:
> > > > >
> > > > > One for maintaining your test lab specific u-boot-test changes an=
d one for
> > > > > your private u-boot code changes.
> > > > >
> > > > > Check out the lab specific u-boot-test branch for steering the te=
sts of the
> > > > > u-boot code branch.
> > > >
> > > > So now for a lab you need to maintain a branch of U-Boot itself, and
> > > > then to test you need to merge your lab support in? And then if the=
re's
> > > > problems work back what git hash you tested on, if reporting either
> > > > problems, or as part of the "wouldn't it be nice to collect results
> > > > idea" work backwards from there? And bisecting problems then become=
s a
> > > > real nightmare since each step requires a merge.
> > >
> > > If you have your own hook scripts, they don't have to be in the U-Boot
> > > tree. That is entirely up to you. In my case I would want them in the
> > > tree, but in your case you can put them somewhere else.  You can even
> >
> > But we shouldn't have more "ellesmere" stuff in the tree. That's a
> > problem. No ones lab should directly be in upstream. We should be
> > documenting and providing examples for others to use. Perhaps that
> > fundamental confusion is why you're suggesting this path?
>=20
> I don't see why ellesmere shouldn't be in there. It is a lab used for
> U-Boot and therefore part of the project, as I see it. If we end up
> with lots of labs from people then we can worry about that problem
> then. Today, we have the opposite problem: not enough labs.

You're also unaware of the number of labs we have because today there's
no need for them to post anything. And no, your lab specific
configuration is not appropriate or useful in the general project. This
is another example of you having a problem seeing the difference between
"this is good for me" and "this is good for the project". Reference
material should be associated with the project in one way or another,
not your specific lab.

> > > put them inside the U-Boot directory but without adding them to git,
> > > if that helps. But we set up the 'PATH' variable to where things are.
> > > If we need to change things to make this easier for people, we can.
> > > I'm really not seeing any nightmares here at all.
> >
> > I don't see how PATH is relevant here either. That won't pick up any of
> > the configuration files. Might just be able to get away with two
> > directories in PYTHONPATH instead of one.
>=20
> PATH is enough to run a hook script. Yes you need PYTHONPATH as well
> if you have stuff in those files. Nothing changes.
>=20
> But Neil's comment was 'So this will definitely remove the ability to
> have test hooks out of the U-boot tree ?', not 'Do I still have to set
> my PYTHONPATH / PATH' to where my tree is ?'.

Yes, I think you don't see how everyone else uses this then. If everyone
else has to set PATH to point to an out of tree copy of
u-boot-test-hooks which is no longer maintained what has anyone gained?

I'm open to suggestions on making the workflow Heinrich outlined for
hooks easier, I'm happy to make the repository writable to other
custodians, but moving them in-tree makes lots of problems and seemingly
solves few.

--=20
Tom

--YKiGwWTmFk3Jn4aw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaN/cACgkQFHw5/5Y0
tyyg8QwAr07dAOnkQviile/2W/7WjEQEG9FrEfbLh14xYbUhw4UdGpyPHGuDOLkH
AV9JC0BOh+Si8He/YpB0m5Pi5ZY2/dc39ftTcq/ozFl1DbWCHO+NoUACSaxYsTnY
Z2zcGXCrwo6MJfNGogNdvJzSOFIO4nMpu/oRoyI9gw02cWNSiwM0A15g+WI0r5wt
Bg/WIA7gb6dZMNqIYGwYkqYAaVAG+wDNVZ9cbr2DiMTiX9o52YVLoRuq8n1blXGI
pZSx3sqIGGfjLfFJw6MIUIhJckO1c+gBAiz1mIGXM6SEv0X0jgI+q74FzQJhoSZt
UN/KXh4UVuMvn3b+fpFMgPuQLA7WljP3d7oxoydtdzExsubOoLDbECBu7zCNuYg5
r9lr1C011wSCrzMu4rtZSYvQrNM4U3VV8WGXY6P0/UWnZM1iip9WaT/0ffTI4poL
bmZdDSc4bKh+RjKb2TauAY+VFSbIx90ShGgLzt6ybk0AbIR0rW+3aumQ4sXkXIMO
fVjRAlQ2
=xj3v
-----END PGP SIGNATURE-----

--YKiGwWTmFk3Jn4aw--
