Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E031AC3DA62
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 17:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E353987F8D;
	Wed, 17 Jul 2024 19:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ok8Qsf96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6449787E2E; Wed, 17 Jul 2024 19:58:12 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEBEA88A99
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 19:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-25e134abf00so24488fac.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721239088; x=1721843888; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mClJVLhFYxjAZAx/xGL9TrjzwEydGQM48iUuAOPfX8Y=;
 b=Ok8Qsf967zTnwYyGYQx9GV5f+hcD5+91dkSj/70/Mve8Q0H4BQwFJk+x2LLjdU/g5T
 rybrNQYboWWysPMVj1gdO1+QXfW3fXqJBYeu0VZPDlwIHoNGWHR8KMS1rqolg0AAkzoJ
 NBrY7fUzDmx4jHi404wSEY0QfSOUiZqSidnmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721239088; x=1721843888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mClJVLhFYxjAZAx/xGL9TrjzwEydGQM48iUuAOPfX8Y=;
 b=lWS5j57PKqJCf/qTStpZZU5a/lJf/QP+qREqHvlOys/xJVtD1Lf+6J1P+C62XZxQVs
 csqPldB3Ebv2pM2D1fVY+n9YiswSbxK36ALUAuCMnJRgsbN+doL9Awe8L9i6E8ZDEt+1
 CBwcqjCLlxRqKtx6PjQXZZrJ2Y4SnaK4JWMINsvJBDkx3FnPvEQ8+OSWhj/Fyei8Zp0o
 iokjzl5klZyp68QjNDkMI/QxDpS0tnr5syBcpgH4Ob2+acWC5iv50dPT57wgnzZH8/Hz
 hcM6mCFbaKHOZmbU1O7Iji29Y9MeGLTnTyJJK9QWUM55oaVDM84H2otD3S4eBMrHm1pa
 EW4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXotT7+zyQ9z0C5avvdGcOQ+Z+xNXc3E920VF6hMHy+FkIvUv+sAmSsnphHv2WXAvewcqPEqRrLun+pJTgQZwG+cd4/A==
X-Gm-Message-State: AOJu0YzK1waHUQOtzCKTs3c6xjM/UDHf79/0lD73BODRDcduRo/RTqIZ
 5eARRPebSeenBuyvdTQM/9stGopYw8L+G3v+47EWfLkGhieAp4UBqfzq5BeMfOY=
X-Google-Smtp-Source: AGHT+IFVyH59T/KxQMxPzSBSC6WHHlmK0Rqyhyuqtu0M5VZ5gzFBgU9xM3U0TNRcDifgMaeRrUTC9Q==
X-Received: by 2002:a05:6870:638b:b0:25e:118e:ce89 with SMTP id
 586e51a60fabf-260d916b881mr2230364fac.11.1721239088658; 
 Wed, 17 Jul 2024 10:58:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee5d7c44sm22532fac.23.2024.07.17.10.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 10:58:08 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:58:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Philippe REYNES <philippe.reynes@softathome.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, sjg@chromium.org,
 abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] lib: sha256: add feature sha256_hmac
Message-ID: <20240717175806.GS561963@bill-the-cat>
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
 <CALeDE9PSADyPUwBuHH46V2Of-HxyYJbo2VOdfQe-_soS6CHCvg@mail.gmail.com>
 <e874bdd7-273e-465e-8516-3207db9ea245@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DQRVv3btDgLK9m2C"
Content-Disposition: inline
In-Reply-To: <e874bdd7-273e-465e-8516-3207db9ea245@softathome.com>
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


--DQRVv3btDgLK9m2C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 07:08:27PM +0200, Philippe REYNES wrote:
> Hi Peter,
>=20
> Le 16/07/2024 =E0 18:56, Peter Robinson a =E9crit=A0:
> > This Mail comes from Outside of SoftAtHome: Do not answer, click links =
or open attachments unless you recognize the sender and know the content is=
 safe.
> >=20
> > Hi Philippe,
> >=20
> > It might be useful to have a cover letter explaining what the plans
> > for this code are, great that there are tests but adding code in
> > without it being used isn't always a feature so a cover letter with
> > some details often helps with the context.
>=20
> You right, I should have added a cover letter.
> My goal was to add key derivation and use this feature to fill a key
> manager,
> and then provide those=A0 keys (or some of them) to the kernel. So the ke=
rnel
> may (for example) add them in the KRS.
>=20
> Do you know if there are some work or interest in a key manager for u-boot
> please ?
>=20
> >=20
> > Also if you're not aware there's work to integrate MBedTLS [1] and I'm
> > not sure if that also may provide the functionality.
>=20
> Good point, I miss it. MBedTLS has the feature of key derivation.
> https://mbed-tls.readthedocs.io/en/latest/getting_started/psa/#deriving-a=
-new-key-from-an-existing-key
> So unless someone wants to use key derivation without all MBedTLS,
> this serie is not very useful.

Unless you object, I would really prefer to have this been a feature
U-Boot only has with MBedTLS enabled as one of the goals with that
integration is to have U-Boot leverage existing and well
audited/monitored codebases for security sensitive code paths when
possible.

--=20
Tom

--DQRVv3btDgLK9m2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaYBi0ACgkQFHw5/5Y0
tywCNQwAjxvs2EHvgeklQFV74/5O7QVfsodhgh+3uJ7uk+J4pB7fsCPUwejPEGk2
35Z3Kpp+rjf5JQX8YQwQFopGLsHpgBC+rYyl9qvJ+3mJJC8Zt9ck82HYjpZD9GVt
vWV/xQ4Bk8blBbD1PKsTn5TuY1AxETI501oWtXSNaRzZBfF5tDg+5JZXWP7TzssO
tCtgphppNZTthXKszjUuJThubk5GcWkYE8TnAPyEYCWOO/+evxbfntkVgIzAuvhl
r9ofbOhBLyx2bItHhGtkmx4PknwP98T/qxTOm1zWORbGXgAw4EROyUS3cXiQ6wFw
edZo7z/9wxYhPFAnbrn8DbgpHUMax5n7XIzgqyy+N/v60BYrSbDJ8BPO5IeY0fiA
J/kEtyOKFuYwdOp3clxoD8yiC/rH2fpIMu4Rx4jNP4RBG2Wlw7v0Kr9DSbbZ0HX8
s+TnqIdXz1hvPw8rqIDGXrBwa8AFH+ghBf8mVoA6dW8ytpRw4xQ7kOMJwPDHzc0i
87HqIK7r
=/Q4M
-----END PGP SIGNATURE-----

--DQRVv3btDgLK9m2C--
