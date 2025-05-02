Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C45C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 20:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74650820E1;
	Fri,  2 May 2025 22:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RFAHUUSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F168820F6; Fri,  2 May 2025 22:04:58 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB2D981FAB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 22:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so1662264a34.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746216294; x=1746821094; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JRrGeI214BI+JXFsv/osMiFFvNdx/BddjVBlMMShrA8=;
 b=RFAHUUSQ9Mh1JAmP4yHr2wFU9AYjBMTKz+baWjl8bqBKe11x6+KAkEVMq2O52yVgn8
 7juNOLT8lvoJiVSrp/izzC/JfHq+DPkNOIVphZLHDmBjzYsuBG2lcgkd1CepFJ8mp9ou
 OFkyolporoTKyKE54OjP9BzjORv5b2X/x9b9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746216294; x=1746821094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRrGeI214BI+JXFsv/osMiFFvNdx/BddjVBlMMShrA8=;
 b=LjQuWTdAL1K4bVTLl9Egtusr4OhpQAUengVMvukLaz9Jebmv6usjsqsjodWKxfz3S4
 YMtshaYA5mP1khqadmyz0xEpV+ApB5YceBPfsyL5bV+ZVDd1lkLDu7bMgxzft7N8jszQ
 vhQK8jOKEChz+A35H64AveDkYQOQj7l2zvS+0MKs2rBhykwFNtXp7Sabc7S717K1uh7v
 CJIiBAJCIRH1wCXLsrhy35hIRrPIjemsWXj2GVxPcAN8i1ImZCMAGgdjlkUemIO7Q982
 jkvkQbcoJSDdub6To+jR0JP6ZTgNSp9JLu0zbFetaeuV0VEIULVJf6oyIfVII7XwEVtq
 AMzg==
X-Gm-Message-State: AOJu0YwX/QCy82TOCXpWFBd+bQBMO+97oZM1tmbHjOjy98Cq3CDUyvA5
 PB01PSg90v53161lwvaLz0nKJsvEgiDetQAWF9jeJvUMzEO6qTrrsqxBgsaYaRM=
X-Gm-Gg: ASbGncsJacpW63dH1lDBC4TgBsGV83KDEaAzUfCG+EblDVw8NXr8cY0VCzxNWEZPI+0
 DySlJP02XQxxZUt7vKjEUqos3cPDZpx/gw2tm9M+rS1juoL4Ez2ZPLzz9+5vQXPrXlJK+LjCB4e
 vmraRuu9XrjBrnf6ln/dQhWEUQy80vHQiUFYgIAjpfYkF6qkwAW4X4QTPycaCWPaaqROaUIOH/q
 ewnd6rI6cpP0DSIFqXjP1Vh4eGDU5SXPHuLbr7tD0N9bG8R+kxr/baxufZIZ8M5Pj5RUbyP8VgS
 OVt157il68mG6A9EkuLJqzaIUoLWXuXoBZTcXN6MmDdl5MUYGy7mDhv2jeh9WbrvpNh34NYaDhE
 i3oQQH566yS9v
X-Google-Smtp-Source: AGHT+IHuHqJQIUEGiZkN1VdTyQuEjjbAuWDUtAReLqqT0XPglQ3XtiONoCVa1QT4n4Zt3AW5p4My+w==
X-Received: by 2002:a05:6830:926:b0:72b:9b8e:434b with SMTP id
 46e09a7af769-731e5646176mr376826a34.22.1746216294540; 
 Fri, 02 May 2025 13:04:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31a251esm616773a34.10.2025.05.02.13.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 13:04:53 -0700 (PDT)
Date: Fri, 2 May 2025 14:04:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250502200451.GA1261075@bill-the-cat>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
 <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
 <20250502193020.GZ1261075@bill-the-cat>
 <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GVLfd7fbGYxz9dJE"
Content-Disposition: inline
In-Reply-To: <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
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


--GVLfd7fbGYxz9dJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 09:42:56PM +0200, Heinrich Schuchardt wrote:
> On 5/2/25 21:30, Tom Rini wrote:
> > On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich Schuchardt wrote:
> > > On 5/2/25 17:06, Tom Rini wrote:
> > > > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >=20
> > > > > On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > >=20
> > > > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
> > > > > >=20
> > > > > > > During a recent discussion with Heinrich we discussed why the=
 hooks are
> > > > > > > kept in a separate repo.
> > > > > > >=20
> > > > > > > The amount of code is small, a tenth of the size of the recen=
tly added
> > > > > > > lwip, just by way of example. Testing is a critical part of U=
-Boot and
> > > > > > > one of the things that distinguishes it from firmware project=
s that have
> > > > > > > not kept up in this area. By having the tests somewhere else,=
 we are
> > > > > > > signalling that it is unusual, or difficult, or optional.
> > > > > > >=20
> > > > > > > The hooks mechanism also needs something of an update to take=
 account of
> > > > > > > real boards in 2025. That will be much easier to undertake if=
 the code
> > > > > > > that test/py talks to is in the same repo.
> > > > > > >=20
> > > > > > > This series brings the hook files in as first-class citizens =
of U-Boot.
> > > > > > >=20
> > > > > > > If we do go ahead with this, I will send a different series w=
hich has
> > > > > > > separate commits (with correct author) in the u-boot-test-hoo=
ks repo.
> > > > > >=20
> > > > > > I think bringing more projects directly in to the repository is=
 a bad
> > > > > > idea. Your example of lwip isn't applicable because it's a read=
-only
> > > > > > subtree that's maintained outside of the project (same as the d=
ts
> > > > > > subtree). But sure, lets "Say Yes". That said, we still need to:
> > > > > > - Remove needless examples from the tree.
> > > > > > - Not include personal labs directly in the tree.
> > > > > >=20
> > > > > > That last one is why I really think this is a bad idea. The poi=
nt of
> > > > > > having the hooks standalone is so that any given lab can easily=
 add
> > > > > > support for their lab and manage it, without worrying about dis=
closing
> > > > > > internal layout. There's going to be hard coded default passwor=
ds there.
> > >=20
> > > Secrets MUST NEVER reside in git repos.
> > >=20
> > > I can't imagine that such irresponsible habits would be practiced by =
any
> > > accountable developer.
> >=20
> > I agree it shouldn't be done. And just this week was the most recent
> > time I've seen a company do that internally, because it's internal and
> > was just a temporary thing. We helped them stop needing to do that, but
> > assuming it never happens is a bad idea.
> >=20
> > > Please, have a look at
> > >=20
> > > https://docs.github.com/en/actions/security-for-github-actions/securi=
ty-guides/using-secrets-in-github-actions
> > > https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_pass=
-build-secrets.html
> > >=20
> > > to see how to do it properly.
> > >=20
> > > The same is true for a private lab:
> > > Use environment variables that are coming from outside the repository.
> > >=20
> > > > > > There's going to be repository secrets there. That kind of info=
rmation
> > > > > > really should not be in a public repository. Integrating the ho=
oks with
> > > > > > mainline will make lab management harder, not easier. The point=
 of the
> > > > > > existing labs in u-boot-test-hooks is to provide samples.
> > > > > >=20
> > > > > > I think this is all why no, we should not go down this path.
> > > > >=20
> > > > > Is it worth discussing this, or is your mind made up? I have some
> > > > > thoughts on the last one.
> > > >=20
> > > > I think it's a terrible idea that I already said:
> > > > > But sure, lets "Say Yes".
> > > >=20
> > > > But please do spend time explaining your thoughts and perhaps others
> > > > will also agree with you and I'll feel less bad taking this in?
> > > >=20
> > >=20
> > > Currently when changing a test hook I have to go through these steps:
> > >=20
> > > * fork u-boot-test-hooks
> > > * push a commit to my fork
> > > * update both .gitlab-ci.yaml and .azure-pipelines.yaml
> > > * commit the change code.denx.de
> > > * create a merge request for github.com/u-boot/u-boot
> > >=20
> > > If the test hooks were in the same repo as main U-Boot, I could save =
two
> > > steps.
> >=20
> > Yes, that's true, the steps for updating our CI are a little bit longer.
> > I would be happy to make u-boot-test-hooks more widely writable (so it
> > would instead be pushing to a branch for step 1+2). But I'm also
> > concerned with external labs (which is both the origin of these scripts,
> > and where they're also used).
> >=20
> > Today, I have both a "konsulko" branch of u-boot-test-hooks, internally.
> > That has subdirectories for both "sage" and "lootbox" (the two lab
> > hosts), and in turn py and bin subdirectories for each. There's no value
> > in publishing these changes as there's nothing unique about the
> > platforms there, which aren't already in the mainline u-boot-test-hooks.
> >=20
> > How should I manage these changes moving forward?
>=20
> You could create two branches based on origin/master u-boot:
>=20
> One for maintaining your test lab specific u-boot-test changes and one for
> your private u-boot code changes.
>=20
> Check out the lab specific u-boot-test branch for steering the tests of t=
he
> u-boot code branch.

So now for a lab you need to maintain a branch of U-Boot itself, and
then to test you need to merge your lab support in? And then if there's
problems work back what git hash you tested on, if reporting either
problems, or as part of the "wouldn't it be nice to collect results
idea" work backwards from there? And bisecting problems then becomes a
real nightmare since each step requires a merge.

--=20
Tom

--GVLfd7fbGYxz9dJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgVJWMACgkQFHw5/5Y0
tyy+egwAlhWWuCAhuT0d1E6BDct2yCkRDseNw6L/0hOUZfwjNZosX2kvxpbye1jd
gwO+uN0vhabyVxyo4G8vOBQ2woCXGWteYXJQFpNJVCxyDq7b31aNml+38pLBdKyb
YeQ2KvHldFRw8cWHGIQMWdYLA2oW0SAFa228EBZHBF4iNCPSmmZwghIReKFHJCPv
SNlXfAe08xF+o49igWHbXVLk1/T16hsQWgLKb3MteAlF+s2cPwoQGbNiqOCkgKXC
vxg8H/FR1WrA3M5W9lk9BY4lt1bCFlYUeak4RNeotcp/pH5mBAFcwRiPW/zLCpHX
SyVZ7W/qMQUmU7dv+x77WlEnEZAB6D+Rlpu87asOHURKbVXTNEIL0TDABn/1QiME
2qTkf+GST4fluKeAmSZlBdLJXmOZy1EYwzAXOCSf4pC8+h0CUGs8R4bc97ZbTr7C
hzByYKIa8kkBFFLzYnnehfdeTSGQcHs/cOQH4bcc8HaGEV0KbtTiGavFG5WRe3rd
bOkPQMMF
=f0pk
-----END PGP SIGNATURE-----

--GVLfd7fbGYxz9dJE--
