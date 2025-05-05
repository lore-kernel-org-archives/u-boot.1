Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D419BC3ABBC
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 18:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FD082161;
	Mon,  5 May 2025 20:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MV9UetXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9EBF826AD; Mon,  5 May 2025 20:18:52 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E8D8215B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 20:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6060200710bso2180376eaf.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746469129; x=1747073929; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ASYBVK+qO86bFsw7L06TJezPH7kBdGdZn5xhnF+0Ao=;
 b=MV9UetXjyxxAiIfFiWKsdqyCvsb4uVLyM+K+skaGUcITf+ca/sZMVG3sxh3QZsWnxB
 Y+LzZ9bUQNLgcwOZ2G8ztSHGY5E7AejoFfTJkPlOpFYH+XBGv8guqPH/Ueatymw5ruoz
 eHqTE5MMbXyn2TxZKOGsYyLMu3uDKpEcdHmG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746469129; x=1747073929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ASYBVK+qO86bFsw7L06TJezPH7kBdGdZn5xhnF+0Ao=;
 b=CX0CFX3R0eR/EWk8UqUfp52ZxGqsjs/KCAK+mdfGax077I+LSET9N3rrBURh1ZjIt7
 ezqUhO20XP4dlN87N2MsvI/Tx2AW/iQVwUgOJrp/+Zkj6y04bnvypmNdqs1h/t/Pe/mW
 kLmmvFdV8XCJkXGwiN96G0Q85C47tnxGTONqv0RlYWSrROgsvX3Y7tCuFV0sgvP77Ygq
 iXiWJNQocjQLGpDQ9qdCfz9R3XQFg44A5c3z/LBr9rgoNCP43YA2whNVnfStM/bvBUGK
 wJO6mXuoupTPvZHV+k4dTPdk+ciwYbpuLSUmuI94k0y2lIANaNeGBSAGgX3yxsmmDK0Z
 iRUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyk/X+ZSH377RVWaFSsrdMTqyuGVdBu01lerlkILLRNfjiDlxWPhuuZrU/raQBGKaWEDiiK9A=@lists.denx.de
X-Gm-Message-State: AOJu0YyiEKLkEUckV8WUJtEV2GHE4mB6APnasyfLCVQfh1bcxmLyu8b0
 PzkIiKfujcHZ5LmnO6OTTY34J4JWkK2PRH6WPadrUwZm9nUMQSHW9IuxL2FFFu0=
X-Gm-Gg: ASbGncvOe9ePlJNXlV+IrQHTnYczGA+jPiV1g0+KJDYIn2PWLmJEs5tkq3Orv9743u1
 uNUm5Bb6wcPT8Q4LJtja7m2O9b73vcINrmV2gzdhjwxgkd64ULbAaAfQjhl6vMnHSX4P9amRLpL
 j02Q1abV4nj+2J+JXeCyYQVCCsbiRwhxubsDAErXXK7liWk0usxmPRMjmFXJjCrPF0LXyVoEEOA
 v+Qa49Fj0AcEt2E/pIHoCqP7tq4utjqSipa+sUezMFsMAwHEvY/0JCsdoVrI5XtW9oICU1/68l2
 YOFwTfUY/NCLoNPpvTKVJSZ6ko8iL9zqnIYHByylgxKu8cPFsN5oNyKjyMt2w0pZwqbYS6uleDB
 02g==
X-Google-Smtp-Source: AGHT+IGFM1SeOZaQg5/45ZvaSa4AH2d+EVhehJ+sdXJcRpwRbg3NiBjEvFwTCu0/avau58fPgTRjoA==
X-Received: by 2002:a05:6820:208:b0:606:894b:fd23 with SMTP id
 006d021491bc7-608002d2d3bmr5532805eaf.4.1746469128858; 
 Mon, 05 May 2025 11:18:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7d8b7b4sm1762429eaf.15.2025.05.05.11.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 11:18:48 -0700 (PDT)
Date: Mon, 5 May 2025 12:18:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250505181846.GJ5430@bill-the-cat>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
 <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
 <20250502193020.GZ1261075@bill-the-cat>
 <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
 <20250502200451.GA1261075@bill-the-cat>
 <CAFLszThgJQvA57g8LH0JH6Bq8wk=hnQUnchaUD0SB6v+0JTezg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wzCFW21hxHcsXb1g"
Content-Disposition: inline
In-Reply-To: <CAFLszThgJQvA57g8LH0JH6Bq8wk=hnQUnchaUD0SB6v+0JTezg@mail.gmail.com>
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


--wzCFW21hxHcsXb1g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 03, 2025 at 08:29:13AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 2 May 2025 at 14:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 02, 2025 at 09:42:56PM +0200, Heinrich Schuchardt wrote:
> > > On 5/2/25 21:30, Tom Rini wrote:
> > > > On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich Schuchardt wrote:
> > > > > On 5/2/25 17:06, Tom Rini wrote:
> > > > > > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > During a recent discussion with Heinrich we discussed why=
 the hooks are
> > > > > > > > > kept in a separate repo.
> > > > > > > > >
> > > > > > > > > The amount of code is small, a tenth of the size of the r=
ecently added
> > > > > > > > > lwip, just by way of example. Testing is a critical part =
of U-Boot and
> > > > > > > > > one of the things that distinguishes it from firmware pro=
jects that have
> > > > > > > > > not kept up in this area. By having the tests somewhere e=
lse, we are
> > > > > > > > > signalling that it is unusual, or difficult, or optional.
> > > > > > > > >
> > > > > > > > > The hooks mechanism also needs something of an update to =
take account of
> > > > > > > > > real boards in 2025. That will be much easier to undertak=
e if the code
> > > > > > > > > that test/py talks to is in the same repo.
> > > > > > > > >
> > > > > > > > > This series brings the hook files in as first-class citiz=
ens of U-Boot.
> > > > > > > > >
> > > > > > > > > If we do go ahead with this, I will send a different seri=
es which has
> > > > > > > > > separate commits (with correct author) in the u-boot-test=
-hooks repo.
> > > > > > > >
> > > > > > > > I think bringing more projects directly in to the repositor=
y is a bad
> > > > > > > > idea. Your example of lwip isn't applicable because it's a =
read-only
> > > > > > > > subtree that's maintained outside of the project (same as t=
he dts
> > > > > > > > subtree). But sure, lets "Say Yes". That said, we still nee=
d to:
> > > > > > > > - Remove needless examples from the tree.
> > > > > > > > - Not include personal labs directly in the tree.
> > > > > > > >
> > > > > > > > That last one is why I really think this is a bad idea. The=
 point of
> > > > > > > > having the hooks standalone is so that any given lab can ea=
sily add
> > > > > > > > support for their lab and manage it, without worrying about=
 disclosing
> > > > > > > > internal layout. There's going to be hard coded default pas=
swords there.
> > > > >
> > > > > Secrets MUST NEVER reside in git repos.
> > > > >
> > > > > I can't imagine that such irresponsible habits would be practiced=
 by any
> > > > > accountable developer.
> > > >
> > > > I agree it shouldn't be done. And just this week was the most recent
> > > > time I've seen a company do that internally, because it's internal =
and
> > > > was just a temporary thing. We helped them stop needing to do that,=
 but
> > > > assuming it never happens is a bad idea.
> > > >
> > > > > Please, have a look at
> > > > >
> > > > > https://docs.github.com/en/actions/security-for-github-actions/se=
curity-guides/using-secrets-in-github-actions
> > > > > https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_=
pass-build-secrets.html
> > > > >
> > > > > to see how to do it properly.
> > > > >
> > > > > The same is true for a private lab:
> > > > > Use environment variables that are coming from outside the reposi=
tory.
> > > > >
> > > > > > > > There's going to be repository secrets there. That kind of =
information
> > > > > > > > really should not be in a public repository. Integrating th=
e hooks with
> > > > > > > > mainline will make lab management harder, not easier. The p=
oint of the
> > > > > > > > existing labs in u-boot-test-hooks is to provide samples.
> > > > > > > >
> > > > > > > > I think this is all why no, we should not go down this path.
> > > > > > >
> > > > > > > Is it worth discussing this, or is your mind made up? I have =
some
> > > > > > > thoughts on the last one.
> > > > > >
> > > > > > I think it's a terrible idea that I already said:
> > > > > > > But sure, lets "Say Yes".
> > > > > >
> > > > > > But please do spend time explaining your thoughts and perhaps o=
thers
> > > > > > will also agree with you and I'll feel less bad taking this in?
>=20
> Well firstly, we should bring in the whole git history so I don't
> believe these patches should be applied as is. I did push a branch[1]
> but can send the commands if it helps.

I don't see how that's relevant here, but OK.

> > > > > Currently when changing a test hook I have to go through these st=
eps:
> > > > >
> > > > > * fork u-boot-test-hooks
> > > > > * push a commit to my fork
> > > > > * update both .gitlab-ci.yaml and .azure-pipelines.yaml
> > > > > * commit the change code.denx.de
> > > > > * create a merge request for github.com/u-boot/u-boot
> > > > >
> > > > > If the test hooks were in the same repo as main U-Boot, I could s=
ave two
> > > > > steps.
> > > >
> > > > Yes, that's true, the steps for updating our CI are a little bit lo=
nger.
> > > > I would be happy to make u-boot-test-hooks more widely writable (so=
 it
> > > > would instead be pushing to a branch for step 1+2). But I'm also
> > > > concerned with external labs (which is both the origin of these scr=
ipts,
> > > > and where they're also used).
> > > >
> > > > Today, I have both a "konsulko" branch of u-boot-test-hooks, intern=
ally.
> > > > That has subdirectories for both "sage" and "lootbox" (the two lab
> > > > hosts), and in turn py and bin subdirectories for each. There's no =
value
> > > > in publishing these changes as there's nothing unique about the
> > > > platforms there, which aren't already in the mainline u-boot-test-h=
ooks.
> > > >
> > > > How should I manage these changes moving forward?
> > >
> > > You could create two branches based on origin/master u-boot:
> > >
> > > One for maintaining your test lab specific u-boot-test changes and on=
e for
> > > your private u-boot code changes.
> > >
> > > Check out the lab specific u-boot-test branch for steering the tests =
of the
> > > u-boot code branch.
> >
> > So now for a lab you need to maintain a branch of U-Boot itself, and
> > then to test you need to merge your lab support in? And then if there's
> > problems work back what git hash you tested on, if reporting either
> > problems, or as part of the "wouldn't it be nice to collect results
> > idea" work backwards from there? And bisecting problems then becomes a
> > real nightmare since each step requires a merge.
>=20
> If you have your own hook scripts, they don't have to be in the U-Boot
> tree. That is entirely up to you. In my case I would want them in the
> tree, but in your case you can put them somewhere else.  You can even

But we shouldn't have more "ellesmere" stuff in the tree. That's a
problem. No ones lab should directly be in upstream. We should be
documenting and providing examples for others to use. Perhaps that
fundamental confusion is why you're suggesting this path?

> put them inside the U-Boot directory but without adding them to git,
> if that helps. But we set up the 'PATH' variable to where things are.
> If we need to change things to make this easier for people, we can.
> I'm really not seeing any nightmares here at all.

I don't see how PATH is relevant here either. That won't pick up any of
the configuration files. Might just be able to get away with two
directories in PYTHONPATH instead of one.

--=20
Tom

--wzCFW21hxHcsXb1g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZAQYACgkQFHw5/5Y0
tyzkzAv3bKNyqQRFcvOjK1QYJ0nB/M4IMyp4v44qDg7b0nrUiB2FLTb/E/ESKDpk
9yCV5KIY9xCYDEzWkU6TUEB037ndc6JgAJROcdXLxho3d2paYDFwPlL9RqN2CSQh
8TfC27GsMGLpYaHdVYCJG/XrcaPN3F5pQsQ4kgD78u3I/RTjpnuIf1rPOCFRDucb
r6vALPLq4B73GZ2RR7xM0v46HClU3b6FNSb43eGmYY07EidDOL+1O6jfyyH8MkpC
f6bTe6oCsuPJpJ/uYkjrfqyC72bJrRcrSVPcVDA/kNdplb04gzUXSOYBLxudouDU
5EFEgjYoj1Djb8UPu6nUY5ZAE6eoMRKZC7YIW99AdCHUHKV3u6jdlq3sKZ7CAl0S
dW20SWizZvxlRtXfK3ezNhkQ2Fc4dvCsvTkODgxXC+H5ZdspYJ5hYRH/eLrfpfx5
+QhyhmpTZS3cM+D6/hrj6ro+62KUf1vz8gvxfEUiOOyqFjwz7HzN4gw0O+Tqm4Dz
0yi6xNI=
=wexn
-----END PGP SIGNATURE-----

--wzCFW21hxHcsXb1g--
