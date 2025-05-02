Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755A5C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 19:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CBB8820E1;
	Fri,  2 May 2025 21:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JDB5x31Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60041820E2; Fri,  2 May 2025 21:30:28 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C25781F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 21:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72ec926e828so732070a34.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746214224; x=1746819024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KMnKdHXSKhI4VdfUUh8biuOQjPKiN84b8+6eEZJJ8C0=;
 b=JDB5x31YGC86uwWBQKsH0/y4UV05sm2dOIsQtzoOWoIy7gkgUAl3tMcqtAbOQ3LqsR
 YOXExA06xNbufo3+zO5iFD0Ol81ePWTKpoNB6ERdJPe90zo8MK95diJc348nY8iLTNZc
 so2NjyDUyVvTNfrkPYWaIwqQRtAy1yzF4A90I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746214224; x=1746819024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMnKdHXSKhI4VdfUUh8biuOQjPKiN84b8+6eEZJJ8C0=;
 b=f1OoQDEWyfHX6UNmHKazwjyFr3HjETdPuBfWx14+NfgpWA2kqZJk/x/x9UuGeGMvPp
 ppCVScqIPcQrls45KxurEzednm+GbnXU5ltAk9jxiq4VeDOL6bKkEH8MdlFR7uloIOBK
 VSroNXJtBDqjukodboMijx0rWUWPomuzD5PXqy13Lj4xYnbOLh9v+eKwFwuvo/NLsThF
 4Ntlt+O3XUinF57Y3mQ1o7y6p+YqwaGAppXVzMVsfGoQaolHXqFAQx0zonD/8IG/t9KJ
 nXxbRwHCPtcmNT4xaC7x56Sv38z+n+Ho0Zu2He9cCrfzxV0tHNoHH9ojbWs6b6KWNo1t
 QI7Q==
X-Gm-Message-State: AOJu0YxBDDoIYV3JQWWXuvj5jj3jmDPjkZfyN/6X5EZzYT+nn2f+IpIh
 rr5srSfF1dSDJVdjpY4ZlJGAUrJhVfLzjSdIejyeLI57pVUTYB5U+n3JoHyUWrs=
X-Gm-Gg: ASbGnctD1bITmRwri4BKlqi4IiKefBqDsIJmPGgOikQ77qluwZZ7WWZnpBmqXs9J01v
 OCeSks4vzJXGaQSQTY/EW4QZiXQtopoGgq/3J0dL+YXR6XcpbpSoNY3qoEigutVZeITZyLBB9fH
 DUeuM9/2YRU78XyJlVnyfPhAJdJH5OsMvYqGDMr9pjV0p/GGQBIDNmQFp5RFuofl+OegcyDEGKl
 apor/QSlYkqQULiSAkcm9i46weyN0DHKdRllcRXfneog6Rg3+3tBlIvXsc/s5q6lgbE0/6+/mCW
 L0osT77rDOGrU6Zbvf3cS4miHOQUlQcRB57DhrWwNA0acl4V2sI08GXddegGaZSGqaaApAVmS2X
 vwQ==
X-Google-Smtp-Source: AGHT+IG5/67OiJqh6RkmOqmoXGWA/lPSJwzhJvw2kOrHGCj/lDqUe2JOzNrIiC92NXontwl/S5jWvw==
X-Received: by 2002:a05:6871:341e:b0:2d5:2955:aa6c with SMTP id
 586e51a60fabf-2dab330f1eemr1907583fac.31.1746214224128; 
 Fri, 02 May 2025 12:30:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0f8512asm750865fac.24.2025.05.02.12.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 12:30:23 -0700 (PDT)
Date: Fri, 2 May 2025 13:30:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250502193020.GZ1261075@bill-the-cat>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
 <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YOwAMPoOBB+xw2It"
Content-Disposition: inline
In-Reply-To: <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
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


--YOwAMPoOBB+xw2It
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich Schuchardt wrote:
> On 5/2/25 17:06, Tom Rini wrote:
> > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >=20
> > > On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
> > > >=20
> > > > > During a recent discussion with Heinrich we discussed why the hoo=
ks are
> > > > > kept in a separate repo.
> > > > >=20
> > > > > The amount of code is small, a tenth of the size of the recently =
added
> > > > > lwip, just by way of example. Testing is a critical part of U-Boo=
t and
> > > > > one of the things that distinguishes it from firmware projects th=
at have
> > > > > not kept up in this area. By having the tests somewhere else, we =
are
> > > > > signalling that it is unusual, or difficult, or optional.
> > > > >=20
> > > > > The hooks mechanism also needs something of an update to take acc=
ount of
> > > > > real boards in 2025. That will be much easier to undertake if the=
 code
> > > > > that test/py talks to is in the same repo.
> > > > >=20
> > > > > This series brings the hook files in as first-class citizens of U=
-Boot.
> > > > >=20
> > > > > If we do go ahead with this, I will send a different series which=
 has
> > > > > separate commits (with correct author) in the u-boot-test-hooks r=
epo.
> > > >=20
> > > > I think bringing more projects directly in to the repository is a b=
ad
> > > > idea. Your example of lwip isn't applicable because it's a read-only
> > > > subtree that's maintained outside of the project (same as the dts
> > > > subtree). But sure, lets "Say Yes". That said, we still need to:
> > > > - Remove needless examples from the tree.
> > > > - Not include personal labs directly in the tree.
> > > >=20
> > > > That last one is why I really think this is a bad idea. The point of
> > > > having the hooks standalone is so that any given lab can easily add
> > > > support for their lab and manage it, without worrying about disclos=
ing
> > > > internal layout. There's going to be hard coded default passwords t=
here.
>=20
> Secrets MUST NEVER reside in git repos.
>=20
> I can't imagine that such irresponsible habits would be practiced by any
> accountable developer.

I agree it shouldn't be done. And just this week was the most recent
time I've seen a company do that internally, because it's internal and
was just a temporary thing. We helped them stop needing to do that, but
assuming it never happens is a bad idea.

> Please, have a look at
>=20
> https://docs.github.com/en/actions/security-for-github-actions/security-g=
uides/using-secrets-in-github-actions
> https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_pass-bui=
ld-secrets.html
>=20
> to see how to do it properly.
>=20
> The same is true for a private lab:
> Use environment variables that are coming from outside the repository.
>=20
> > > > There's going to be repository secrets there. That kind of informat=
ion
> > > > really should not be in a public repository. Integrating the hooks =
with
> > > > mainline will make lab management harder, not easier. The point of =
the
> > > > existing labs in u-boot-test-hooks is to provide samples.
> > > >=20
> > > > I think this is all why no, we should not go down this path.
> > >=20
> > > Is it worth discussing this, or is your mind made up? I have some
> > > thoughts on the last one.
> >=20
> > I think it's a terrible idea that I already said:
> > > But sure, lets "Say Yes".
> >=20
> > But please do spend time explaining your thoughts and perhaps others
> > will also agree with you and I'll feel less bad taking this in?
> >=20
>=20
> Currently when changing a test hook I have to go through these steps:
>=20
> * fork u-boot-test-hooks
> * push a commit to my fork
> * update both .gitlab-ci.yaml and .azure-pipelines.yaml
> * commit the change code.denx.de
> * create a merge request for github.com/u-boot/u-boot
>=20
> If the test hooks were in the same repo as main U-Boot, I could save two
> steps.

Yes, that's true, the steps for updating our CI are a little bit longer.
I would be happy to make u-boot-test-hooks more widely writable (so it
would instead be pushing to a branch for step 1+2). But I'm also
concerned with external labs (which is both the origin of these scripts,
and where they're also used).

Today, I have both a "konsulko" branch of u-boot-test-hooks, internally.
That has subdirectories for both "sage" and "lootbox" (the two lab
hosts), and in turn py and bin subdirectories for each. There's no value
in publishing these changes as there's nothing unique about the
platforms there, which aren't already in the mainline u-boot-test-hooks.

How should I manage these changes moving forward?

--=20
Tom

--YOwAMPoOBB+xw2It
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgVHT8ACgkQFHw5/5Y0
tyw4rQwAq7teBd/bzxHG+yhu5vNtJQLUc2tFIrRSSSXeaqsvLilFZFPRdhaJeusO
EJS/HfmxtqcwCa5AhCUsb4d9twvcqGKQ8YbEhA9uSUxI7Fd6jfqEAMpA+pZvoMsq
uamCGZapsjiqrL1/zwUpDHyylogYxGV3ZtqD0zXxBBdxCyjbCeUimygZHXjOpMMn
P8kVFKwNa+7aB4kFMfg/ndokZZOWQ+KtJsrvy0NA7TLIZ8/fYcqBTGFOB+yHEIsX
E64eE9zza9resSkCvbqoqKVIafpXTsE8qY1ffLI49TX1KlG2aenSEj04NcudTq9Z
nqTADI5ktnUQFbduaAb1KD1MhkAl4BCCgqM+d7/pTIj7dKQSxDqx0MfyEla2skk8
UVFnokZVnei2Xo++0BKrgbtVje8+f9WQzrx0j+AlcBERnULInSLaZGdFVNfSMOOf
X7Hp1awf3L6rBlVqZIY/0WjiFpmb9C05iqoqNZfiiFNAvMZdTMjcZwtc3OrLM2nD
Ygpi+zam
=J6Hi
-----END PGP SIGNATURE-----

--YOwAMPoOBB+xw2It--
