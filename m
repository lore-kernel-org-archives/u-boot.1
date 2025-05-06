Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF524C3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 19:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419B981FAB;
	Tue,  6 May 2025 21:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hFZnvfT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5737820F6; Tue,  6 May 2025 21:28:06 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA0081F66
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 21:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f6dccdcadaso4596573b6e.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746559683; x=1747164483; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ae83uGC9yH5OSM+lWXUoxJZJmUTY+w0X8ZFBviclB2k=;
 b=hFZnvfT7rT8dwRTK92dSDg7+5Ea+D1paPotNCem2RbwZEsagtLpCSze0zmmqs3L4rY
 xJcfPgLZqIG7nJN1zzeQue4rmzuXXg1uHvlKRKqPy7Eim82Ij+DYyKFFyimPUCnUBVkY
 HdZicwTXVLci/qLkZUx+0qe4MiA36gQe89dc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746559683; x=1747164483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ae83uGC9yH5OSM+lWXUoxJZJmUTY+w0X8ZFBviclB2k=;
 b=YzklSKarPexzII9sy8VzZ9VUydGraMFNknDuaFxgU4SpMuwo+dkguLc3i7y43qIqYA
 F4iCtMRnRmHJJeSv7hVye4ZCVR5PxclpfBtvHe1XSUSwxPGu8YLDqVFEW8ZC16KWYvm9
 kIrp3+SOmw0CvQNUW6BQgtW5bfjC//fOI3PdAk63VI1CVzNXEwWOWqulp32en5kTJUWV
 r7UXv+9pw2iFawnmRVvE8fN1UOeI+0iO4JlDBy0uzXyg70z5izd26iwhiarBkA7J1RJu
 EvlxG2oltEEVEksybci5fc2T90eoebXmwYapE99atP4W8X2vZHfjbiqasHn6WZWN/eUL
 Lg/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7gck9oHg5N0577yGu+0/hWz1kPshkcsTzS+GRL/13PjctQ6mpc0XLW7e4JCxAVcUXpvI+Jbo=@lists.denx.de
X-Gm-Message-State: AOJu0YyvcLsLDKSacyYgN71UGHC9c3bYm23Mx325S/qInApLNqiUVAEZ
 HeI25X1JeDSmRFdr4wHo/Ctkoc2dxx3zQInsbzczrwFIa1RtClcYxM46Bi4focQ=
X-Gm-Gg: ASbGncutkDUW1KOAMm8bWGRjkR1F+rst3iH/Cl4fhzy5To0Xtu1mx52q51XwFPrYlfr
 VVMBSgA2AA1732uLuSg+5XiFFGp0awb8gVyV6S/L+aqjt2ha8fhEK3OVVxx5+CevZ5O7R81vw95
 tJ+fmvS/6C+x0Zc+CsTSHD1ecgu4lAS2hxmS5ccZ00rEj5PNbF78nKrui7o7/67c4PfNr6In5gd
 ZnlkK8H8YPNF1jJQT697O8taIgvWMt9ZjhefBnEna6SQ27qTYVJs44SluTuWv5Yffgq1QndBe5m
 05zi2A2FIpt1lgqog3qTNBQNFuGUGRLZGixzqDXdaS4IHa5ejaXm+BYuoq7k/vX5bQJ6MYsrrZp
 Crw==
X-Google-Smtp-Source: AGHT+IEXcMAd/WBXfeKWNql96taUfI1hk5MG6qARdogWS+gJGEBSI1c9wK8CxgmYBWk7cn9X79aT2Q==
X-Received: by 2002:a05:6808:1204:b0:403:5150:c351 with SMTP id
 5614622812f47-4036f06df23mr369652b6e.6.1746559682626; 
 Tue, 06 May 2025 12:28:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f32370asm58415b6e.6.2025.05.06.12.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 12:28:01 -0700 (PDT)
Date: Tue, 6 May 2025 13:27:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250506192759.GG5430@bill-the-cat>
References: <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
 <20250502193020.GZ1261075@bill-the-cat>
 <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
 <20250502200451.GA1261075@bill-the-cat>
 <CAFLszThgJQvA57g8LH0JH6Bq8wk=hnQUnchaUD0SB6v+0JTezg@mail.gmail.com>
 <20250505181846.GJ5430@bill-the-cat>
 <CAFLszThgq8afbSL8zHqP6nCoB+F5wU6M0MbAoYRsJh8iMi8orA@mail.gmail.com>
 <20250506162537.GX5430@bill-the-cat>
 <CAFLszThX4c9qO2cJiYqJ+9v2zfXsLtdkoMwE1-OCubD9Bbgcmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="29XzfoJ1Rpek/sfB"
Content-Disposition: inline
In-Reply-To: <CAFLszThX4c9qO2cJiYqJ+9v2zfXsLtdkoMwE1-OCubD9Bbgcmw@mail.gmail.com>
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


--29XzfoJ1Rpek/sfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 08:10:30PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 6 May 2025 at 18:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, May 06, 2025 at 03:23:59PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 5 May 2025 at 20:18, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, May 03, 2025 at 08:29:13AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 2 May 2025 at 14:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, May 02, 2025 at 09:42:56PM +0200, Heinrich Schuchardt w=
rote:
> > > > > > > On 5/2/25 21:30, Tom Rini wrote:
> > > > > > > > On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich Schuchar=
dt wrote:
> > > > > > > > > On 5/2/25 17:06, Tom Rini wrote:
> > > > > > > > > > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Gla=
ss wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > During a recent discussion with Heinrich we discu=
ssed why the hooks are
> > > > > > > > > > > > > kept in a separate repo.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The amount of code is small, a tenth of the size =
of the recently added
> > > > > > > > > > > > > lwip, just by way of example. Testing is a critic=
al part of U-Boot and
> > > > > > > > > > > > > one of the things that distinguishes it from firm=
ware projects that have
> > > > > > > > > > > > > not kept up in this area. By having the tests som=
ewhere else, we are
> > > > > > > > > > > > > signalling that it is unusual, or difficult, or o=
ptional.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The hooks mechanism also needs something of an up=
date to take account of
> > > > > > > > > > > > > real boards in 2025. That will be much easier to =
undertake if the code
> > > > > > > > > > > > > that test/py talks to is in the same repo.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This series brings the hook files in as first-cla=
ss citizens of U-Boot.
> > > > > > > > > > > > >
> > > > > > > > > > > > > If we do go ahead with this, I will send a differ=
ent series which has
> > > > > > > > > > > > > separate commits (with correct author) in the u-b=
oot-test-hooks repo.
> > > > > > > > > > > >
> > > > > > > > > > > > I think bringing more projects directly in to the r=
epository is a bad
> > > > > > > > > > > > idea. Your example of lwip isn't applicable because=
 it's a read-only
> > > > > > > > > > > > subtree that's maintained outside of the project (s=
ame as the dts
> > > > > > > > > > > > subtree). But sure, lets "Say Yes". That said, we s=
till need to:
> > > > > > > > > > > > - Remove needless examples from the tree.
> > > > > > > > > > > > - Not include personal labs directly in the tree.
> > > > > > > > > > > >
> > > > > > > > > > > > That last one is why I really think this is a bad i=
dea. The point of
> > > > > > > > > > > > having the hooks standalone is so that any given la=
b can easily add
> > > > > > > > > > > > support for their lab and manage it, without worryi=
ng about disclosing
> > > > > > > > > > > > internal layout. There's going to be hard coded def=
ault passwords there.
> > > > > > > > >
> > > > > > > > > Secrets MUST NEVER reside in git repos.
> > > > > > > > >
> > > > > > > > > I can't imagine that such irresponsible habits would be p=
racticed by any
> > > > > > > > > accountable developer.
> > > > > > > >
> > > > > > > > I agree it shouldn't be done. And just this week was the mo=
st recent
> > > > > > > > time I've seen a company do that internally, because it's i=
nternal and
> > > > > > > > was just a temporary thing. We helped them stop needing to =
do that, but
> > > > > > > > assuming it never happens is a bad idea.
> > > > > > > >
> > > > > > > > > Please, have a look at
> > > > > > > > >
> > > > > > > > > https://docs.github.com/en/actions/security-for-github-ac=
tions/security-guides/using-secrets-in-github-actions
> > > > > > > > > https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gi=
tlab/07_pass-build-secrets.html
> > > > > > > > >
> > > > > > > > > to see how to do it properly.
> > > > > > > > >
> > > > > > > > > The same is true for a private lab:
> > > > > > > > > Use environment variables that are coming from outside th=
e repository.
> > > > > > > > >
> > > > > > > > > > > > There's going to be repository secrets there. That =
kind of information
> > > > > > > > > > > > really should not be in a public repository. Integr=
ating the hooks with
> > > > > > > > > > > > mainline will make lab management harder, not easie=
r. The point of the
> > > > > > > > > > > > existing labs in u-boot-test-hooks is to provide sa=
mples.
> > > > > > > > > > > >
> > > > > > > > > > > > I think this is all why no, we should not go down t=
his path.
> > > > > > > > > > >
> > > > > > > > > > > Is it worth discussing this, or is your mind made up?=
 I have some
> > > > > > > > > > > thoughts on the last one.
> > > > > > > > > >
> > > > > > > > > > I think it's a terrible idea that I already said:
> > > > > > > > > > > But sure, lets "Say Yes".
> > > > > > > > > >
> > > > > > > > > > But please do spend time explaining your thoughts and p=
erhaps others
> > > > > > > > > > will also agree with you and I'll feel less bad taking =
this in?
> > > > >
> > > > > Well firstly, we should bring in the whole git history so I don't
> > > > > believe these patches should be applied as is. I did push a branc=
h[1]
> > > > > but can send the commands if it helps.
> > > >
> > > > I don't see how that's relevant here, but OK.
> > > >
> > > > > > > > > Currently when changing a test hook I have to go through =
these steps:
> > > > > > > > >
> > > > > > > > > * fork u-boot-test-hooks
> > > > > > > > > * push a commit to my fork
> > > > > > > > > * update both .gitlab-ci.yaml and .azure-pipelines.yaml
> > > > > > > > > * commit the change code.denx.de
> > > > > > > > > * create a merge request for github.com/u-boot/u-boot
> > > > > > > > >
> > > > > > > > > If the test hooks were in the same repo as main U-Boot, I=
 could save two
> > > > > > > > > steps.
> > > > > > > >
> > > > > > > > Yes, that's true, the steps for updating our CI are a littl=
e bit longer.
> > > > > > > > I would be happy to make u-boot-test-hooks more widely writ=
able (so it
> > > > > > > > would instead be pushing to a branch for step 1+2). But I'm=
 also
> > > > > > > > concerned with external labs (which is both the origin of t=
hese scripts,
> > > > > > > > and where they're also used).
> > > > > > > >
> > > > > > > > Today, I have both a "konsulko" branch of u-boot-test-hooks=
, internally.
> > > > > > > > That has subdirectories for both "sage" and "lootbox" (the =
two lab
> > > > > > > > hosts), and in turn py and bin subdirectories for each. The=
re's no value
> > > > > > > > in publishing these changes as there's nothing unique about=
 the
> > > > > > > > platforms there, which aren't already in the mainline u-boo=
t-test-hooks.
> > > > > > > >
> > > > > > > > How should I manage these changes moving forward?
> > > > > > >
> > > > > > > You could create two branches based on origin/master u-boot:
> > > > > > >
> > > > > > > One for maintaining your test lab specific u-boot-test change=
s and one for
> > > > > > > your private u-boot code changes.
> > > > > > >
> > > > > > > Check out the lab specific u-boot-test branch for steering th=
e tests of the
> > > > > > > u-boot code branch.
> > > > > >
> > > > > > So now for a lab you need to maintain a branch of U-Boot itself=
, and
> > > > > > then to test you need to merge your lab support in? And then if=
 there's
> > > > > > problems work back what git hash you tested on, if reporting ei=
ther
> > > > > > problems, or as part of the "wouldn't it be nice to collect res=
ults
> > > > > > idea" work backwards from there? And bisecting problems then be=
comes a
> > > > > > real nightmare since each step requires a merge.
> > > > >
> > > > > If you have your own hook scripts, they don't have to be in the U=
-Boot
> > > > > tree. That is entirely up to you. In my case I would want them in=
 the
> > > > > tree, but in your case you can put them somewhere else.  You can =
even
> > > >
> > > > But we shouldn't have more "ellesmere" stuff in the tree. That's a
> > > > problem. No ones lab should directly be in upstream. We should be
> > > > documenting and providing examples for others to use. Perhaps that
> > > > fundamental confusion is why you're suggesting this path?
> > >
> > > I don't see why ellesmere shouldn't be in there. It is a lab used for
> > > U-Boot and therefore part of the project, as I see it. If we end up
> > > with lots of labs from people then we can worry about that problem
> > > then. Today, we have the opposite problem: not enough labs.
> >
> > You're also unaware of the number of labs we have because today there's
> > no need for them to post anything. And no, your lab specific
> > configuration is not appropriate or useful in the general project. This
> > is another example of you having a problem seeing the difference between
> > "this is good for me" and "this is good for the project". Reference
> > material should be associated with the project in one way or another,
> > not your specific lab.
>=20
> That's not quite it. I don't mind seeing other people's labs and in
> fact it would help a lot. You ended up sending me an email with lots
> of stuff after I had floundered around for hours trying to
> reverse-engineer a test. If it had been in-tree I would have solved it
> in 5 minutes.

Yes, we need better documentation. This has been known for some time.
It's somewhere on my TODO list to follow up on the RFC I sent before.

> > > > > put them inside the U-Boot directory but without adding them to g=
it,
> > > > > if that helps. But we set up the 'PATH' variable to where things =
are.
> > > > > If we need to change things to make this easier for people, we ca=
n.
> > > > > I'm really not seeing any nightmares here at all.
> > > >
> > > > I don't see how PATH is relevant here either. That won't pick up an=
y of
> > > > the configuration files. Might just be able to get away with two
> > > > directories in PYTHONPATH instead of one.
> > >
> > > PATH is enough to run a hook script. Yes you need PYTHONPATH as well
> > > if you have stuff in those files. Nothing changes.
> > >
> > > But Neil's comment was 'So this will definitely remove the ability to
> > > have test hooks out of the U-boot tree ?', not 'Do I still have to set
> > > my PYTHONPATH / PATH' to where my tree is ?'.
> >
> > Yes, I think you don't see how everyone else uses this then. If everyone
> > else has to set PATH to point to an out of tree copy of
> > u-boot-test-hooks which is no longer maintained what has anyone gained?
>=20
> Perhaps access to some useful examples. But they certainly have not
> lost anything.
>=20
> >
> > I'm open to suggestions on making the workflow Heinrich outlined for
> > hooks easier, I'm happy to make the repository writable to other
> > custodians, but moving them in-tree makes lots of problems and seemingly
> > solves few.
>=20
> At this point I believe the hooks should be in-tree and I have not
> heard any real argument here yet. Neil had the wrong end of the stick
> and your argument is that people who don't want their hooks in the
> tree won't gained anything by being allowed to put them in the
> tree...well, sure.
>=20
> If there is any compelling argument, I'd really like to hear it.

I think the best compelling argument is that you continue to have the
wrong end of the stick yourself as your labgrid implementation bears
little resemblance to how the rest of the hooks are implemented and
used, based on your comments about how nothing would be lost and there
would be no problems.

--=20
Tom

--29XzfoJ1Rpek/sfB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaYr8ACgkQFHw5/5Y0
tywMYwv/SN18rlEvosb+LIRRXVWX+hFp2pCgxqK5xpPIpQzRPB93iBPyxYBgY7qR
GdU5rKxyrrY2PQ0Wg523T/muuDFV/bGNtKqJo0acsNwL7iXuLRJFKQmd2nYT6niq
ZnKKhNkmh9z3Sro0RAkpqszFlu+Bk4f//nDQIOkJhYlByEJzP8aWPCyWrdDaUN2D
6u7K7UUi/NBjtOrnujiGQSqxAnyYfNJcBfcepEkU9hIMngXOt1Ig3j0pI8/SKEGh
wfm2qeTKG+GY8DvfHe12RcowvuciaOM7omD/JCbVhMZZbbSc1prkzIF3HJhoOGMi
R5kVMcVjvMEbAeDaX8SiVlNRy6eqh2YbUPgfAL4kZOkzGcOgv5MbB0otthr8x627
hWtdhe+1Z5iVOVd91y+iPk1X/0o8S3a++5FaZ3udh98HOtz0M/kUBP08fq+S1UaQ
XztOrSGltcFwRgUuuaTrMCY5Z/V2pSfHHVlbs9nDqG+vnLkPY+mXrP7sVvVr6FgF
OLPWSu3A
=fq6T
-----END PGP SIGNATURE-----

--29XzfoJ1Rpek/sfB--
