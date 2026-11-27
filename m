Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA5606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l3jrfzW4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NmTHQXad
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1303C60D8A;
	Fri, 27 Nov 2026 19:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id so8cOQjhYT6S; Fri, 27 Nov 2026 19:22:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFC7160D64
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795807342;
	b=Vml6twe6ugOZMMCcdBXCua7jJEVKsI7A7zTvg455EhC3/9Bs3R6IsFcFJ3IkNjL/w+Vt
	 +DDMsfmkv6mQIq6Uave+2XrIaDjAB1uC3HrIm+4RRoWRLJ++dwIaX7o+DpoW+SaM33rpW
	 r5xaxL5KccPSv2c+/dIlPv4VHOVvpPCXzJCPc0mBEi8uamgL7OFHmcnULAKu8o/yn6ZZ4
	 MLzP+Z8hUr/iol1xkR6gZgB4rJSYnmuiNT6eXCnjQK2Z16/bS0P3dpq/7TwgM755xERkG
	 rSf0jlpcz75+v/9gIwBmgQTD7HuPC8qI8ItgLRDq8bw8dA5h1UE+Xc/VLmehgWQz8Sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795807342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hzodx1mzNBXA/4r8Mn/Lm17d5WK4DqnvOFsyeOU5WY0=;
	b=F3trAygcof4gpp1iI6tXJLDdEPrET2FQSaOib76MA83Im45QWEf1IMGjgmCUEXb7Ub/w
	 g1EjD+b1gc0wMW+ehnhYMyFFJKhwRGrFQ4/taYKPtljnF7NLhslqfyLLu2Stvwd1OhMsg
	 0Lc1yYX3v+ko6KeC6ZA1f1u6DywOYjvEnfVDRemeByv/mbI9V05T4WoyWNe5U/ClymN3e
	 Tu09UU1kewDLujRVl3SnKANiCg4kk8uDd07jR7p7Hxl2qzoMoHNJ8ttp14O3I6+sdVVWK
	 VJ7ocp//jn45VfKlYS7VPtTpzTRgoZmMGxfMV3RCetnzcIdA4MiBlZ9TSEB91AQYgGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795807342;
	bh=hzodx1mzNBXA/4r8Mn/Lm17d5WK4DqnvOFsyeOU5WY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l3jrfzW4gG91u4CGIMTl3hEwMI026pna7dS1B4Ef3Q8zr+ZBuQ/kgfj8U1caPaTzf
	 RdVcszPFnSBzsnOT0SF5l0pEB8oe9yDvbrEokcgBjQwY373u339L0JpndioVrWAmfo
	 Fm4IMQhaoPbJwimYsvEnHn/lmk9SXr/w/HQ/IXfjpotOwJSOdoY9oCLhqvqG+GhJoc
	 pih8/Ir0wSdPWom4fLktXKFVWuxmp2ZdLiUxbjBiaOMyYZiyk9eJtXOgXjouDA+lX/
	 PqeH6KWYeRIHT5qPIVpMjVorooO8v/eGlAkRPayG6w+7EgiD2uvzx2DpMRNTdG+zHV
	 +GeuPTe2k+1MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFC7160D64;
	Fri, 27 Nov 2026 19:22:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 402D92FE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 312F5812E4
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QzQODXbUt4Uf for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2353680DEA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NmTHQXad
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2353680DEA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:22:18 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-862a5b64755so4706761a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795807337; x=1796412137;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzodx1mzNBXA/4r8Mn/Lm17d5WK4DqnvOFsyeOU5WY0=;
 b=NmTHQXadRr12ISNBxgpYAyEKzsm8OfjNJaHq49SX9deA4TbYc9VmlkPKg3LykhpdFt
 3TOeq2zTl1egmLs/lL3eVKxhZJAMFO8Xqxr1jryMQaf9Um9pjrdjDdH55kXlznb1BAfx
 pVWO6TigLeweU60TpJqW1yh1lG1cjcciLM7lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795807337; x=1796412137;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzodx1mzNBXA/4r8Mn/Lm17d5WK4DqnvOFsyeOU5WY0=;
 b=aeDBijpYdzyNkfgVOaBVXfs+xFNBOFWixahTDyV2tLW4tng0SaDYvIhmnm38iQ5biU
 sg+bzni9qa8aSu7ujZe+EjjRsE9X5kVX+hNMVM7DX8a/up5X3iVNhgwchkM/oK4tMpte
 D4BnHcFJf5tISBzEobpitDrD9ungYqwoY5nklcDGHFL81EAZHq205VSnnX+kBMwNfLpv
 6RPTXjcK4HZYQzxVeDZUZ4X+LzlubPuWtSqok8i9fg/KxAlGWHsmY+jkUEesnNhUJnD5
 Fz7hoj1PnJbeibSNYiTk3VB2OJJsZzDBB+F1h+Sks/J2ad39EApP75Ug0E2XmFqvf7n6
 0W3Q==
X-Gm-Message-State: APuU4Z9H75uHGi0xmJJaZQ+2mfupYDYIZ7uH90Hl5tC6VWVWtGb187Lc
 HH0eDU+Iadp9IOgo5GHz0pBqY10SgRtLzV6mAOkGIgeM9dvDbZcTbM3Y1+B7Tl9eUPEM/2Z6lMG
 dxwTEMYFqL3Yd
X-Gm-Gg: AZFdTZdclRFxLeFY8eMZ+Zw+rOde/BkBV3DyqQV5ibHSAg65/KjaHW/QZYGyGHKS9pZ
 jLRlv0vninF1mR0mnPFKEEZzeXuTvW6XCpsRwJ0k9IN88owIkCd/kWvCc3gHornTozSLhf/k6mf
 s/PiAt3GYkEF6WGT5UJHO5ucVqUV+kYbTtY7TyTQJupEc1ScrrSLCVCOoEpqgA3qW3776dxLncz
 hQ07iO7Y/dkgoq0d/kugFU926u6anRXOFEcFjFF0NFYIj3llq0jKdoZ9G1lyPJU/5IMhuoAtt4X
 gQBjLZR98vka7B8vrZKoHHAj/wFN9U2qdV4oL5XJipsXHKFaBNL8G0IHZ0ZFevFgrszTC+L8ZGh
 mCBqI88YZWGtAk1BjVo6RsBuLC9eUe0GpaYGxPMguUEaFD+N20vzFc/tEHZymX7wsjwmBlUnqSK
 /FnZ6QgUgXbQMbsNmHMYARGhYn+Q8O4gI/GjySuND5vghi+MdjE/5SEEo09cqgL8E4ItQ3BApMW
 s4Y7jIH7fg8VpPWyLMK6iwNOffHShrK1mM+gbglBHzt2k+0EqbsggvpodeV1nRpPWp6XpPIlY2J
 /FJz3109bM7l76yi6YeXliGii6IJot+lip4VJxCsqmlCSiB3/4WAnmlVGWZoq8CmL0E8hzhAUYl
 yvEu/eC8Mfhv3FyEMz4fztdKSNcrXj6JovXpS4xxaw+1FzVSt5S0toY1fNuzafdiTITfkTvaKzQ
 fLEN2f4l5kauZ2Xn0oGhMpg1bm+tvQOn8=
X-Received: by 2002:a05:6808:19aa:b0:4b9:e65b:8c36 with SMTP id
 5614622812f47-57a09400cdfmr27470571b6e.36.1795807337569; 
 Fri, 27 Nov 2026 11:22:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34763004sm18044005b6e.8.2026.11.27.11.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:22:16 -0800 (PST)
Date: Fri, 27 Nov 2026 13:22:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 4/4] Dockerfile, CI: Update to the latest Ubuntu
 'Noble' build
Message-ID: <20261127192214.GQ3176972@bill-the-cat>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261127162927.3545062-1-trini@konsulko.com>
 <20261127162927.3545062-5-trini@konsulko.com>
 <0f72e884-5be2-41a8-b18c-b5e2b16b7fa8@cherry.de>
 <20261127180223.GN3176972@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Uw7varLnyoE5Czgh"
Content-Disposition: inline
In-Reply-To: <20261127180223.GN3176972@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Uw7varLnyoE5Czgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 12:02:23PM -0600, Tom Rini wrote:
> On Fri, Nov 27, 2026 at 06:56:01PM +0100, Quentin Schulz wrote:
> > Hi Tom,
> >=20
> > On 11/27/26 5:26 PM, Tom Rini wrote:
> > > This bumps us to the ubuntu:noble-20261110.1 tag and also brings in
> > > recent changes to our own Dockerfile.
> > >=20
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Changes in v2:
> > > - None
> > > ---
> > >   .azure-pipelines.yml    | 2 +-
> > >   .gitlab-ci.yml          | 2 +-
> > >   tools/docker/Dockerfile | 2 +-
> > >   3 files changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > index fcf7aafade6e..46509eeb7df6 100644
> > > --- a/.azure-pipelines.yml
> > > +++ b/.azure-pipelines.yml
> > > @@ -1,7 +1,7 @@
> > >   variables:
> > >     ubuntu_vm: ubuntu-24.04
> > >     macos_vm: macOS-26
> > > -  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Ja=
n2026
> > > +  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20261110.1-24=
Nov2026
> >=20
> > The image pushed to DockerHub will not match the one you could be local=
ly
> > (you can see the layers are different in https://hub.docker.com/layers/=
trini/u-boot-gitlab-ci-runner/noble-20261110.1-24Nov2026/images/sha256-feba=
8c676839085d4afd52fbd88409be3836f73a72ad16a01a5114e3e2640b63).
>=20
> Correct. There's both non-functional changes (using bash for everything,
> for example) and visible changes (mkbootimg is a smaller repo, but as
> you noted on IRC nothing uses it in-tree).
>=20
> > Do you want to push a new tag maybe or maybe specify that you're using =
an
> > image based on the v1 but that there should be no logical change betwee=
n the
> > two aside from different layers with only impacts at build time (the
> > resulting image will be the same. Or maybe there is? Can you check what=
's
> > the shell that will be used by default when running the container (the =
one
> > you pushed and the one you may have created just now to validate the v2=
 of
> > the Dockerfile)? I'm wondering if the SHELL instruction applies to the
> > running container or not (it does say it applies to the ENTRYPOINT
> > instruction).
>=20
> Historically, there have been times where the Dockerfile and container
> don't match up, because of changes to make things build (timeouts, or
> mismatch in requirements.txt files). I had intended to let this be
> another instance of that (I did a build, I didn't do a --push), but as
> you note the SHELL change does matter. So, let me push a new tag, lets
> that populate and confirm CI is fine.

The updated pipeline is in progress, but some jobs have already passed,
and I'm waiting for Azure to start firing them off too. Assuming full
passes of both, I'll note in the cover letter the tagged image doesn't
quite match up, and then get started on more substantial changes (my
goal is that v2027.04 will not ship with this container in use, so this
oddity will go away).

--=20
Tom

--Uw7varLnyoE5Czgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawnYYwAKCRAr4qD1Cr/k
CvWjAQCSi8rSluvuN/cWC+nGzOrFuoYSFUyo/gENX4nse/MxlQEAoimhzirohpRN
gvxMEUf3JYtm3Jq691UVKYJPxIRDiQc=
=hc86
-----END PGP SIGNATURE-----

--Uw7varLnyoE5Czgh--
