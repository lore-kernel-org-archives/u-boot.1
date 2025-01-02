Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A7EE77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 15:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B518007D;
	Thu,  2 Jan 2025 16:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LnEke47A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB44280196; Thu,  2 Jan 2025 16:48:51 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CA28001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 16:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dce7263beaso101079156d6.3
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 07:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735832928; x=1736437728; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7Qm1fRGOzxMhAq/FbusrgwahrnH10EYUhxR4OOO4Rfs=;
 b=LnEke47AJsySpm845GjIbk1rxuRsjPhsRlaLzdI2h1eq0mMsjg/KpTIhWJYbVU5Pyn
 aRSnoaV/rE36Iqn8ZfGdKD/pp0Xy+5gf0SKPcZuWjutLwe83qXoJDaugZIjD4XuVtdAT
 UiUJjEKb6muqMFZZu/lP6lpM9KyGijarlVC7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735832928; x=1736437728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Qm1fRGOzxMhAq/FbusrgwahrnH10EYUhxR4OOO4Rfs=;
 b=NhtYQ9BSRZDE0/5OgxlLx5OWcd+iyFH4h3s2KS5A6EDxGj3J+H5qdI1QiJiOCqSp76
 b/SEOYt/0fuBXMBfwR5ZFT3F3Ig9W8EEfDvsU0pdH4BRhyuP9tLwUlKWgQZF+94AogjU
 Na1tA25tufnoPkOAHpZDZT5E+JfjYNAJonhpgXJW/Ww6Las7sFxlkhe835Mn2a+hkBVJ
 THo4X9WoW3K/8qLn9t2v5BzPaPDnuoYXEwGuM8FbKopLw/A5NAJz/nMwVJRd0ZAxawIx
 vyxEpPGHGixHThBztzAYEY6qXAMtcKPBvUQzLY1TeOoBm+uH/Di0vQfeFsHrL9LHdDAI
 D4Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHYhF6gNoxRHw6cb56NxM2e8nPeYeL9b1kQ4henPpvm3dDidYv89FOET+CSqn1iJ65O5arhfA=@lists.denx.de
X-Gm-Message-State: AOJu0YweC2nshAkHa+s/75wj92fGk0vF3c/4us6tSA6juH5EwSz73t2r
 qPvRn7wtU83Swx1AulbAKiscMJ1SbFTzhbeaaKP4J72yPaCblud+RUAw/9efAZw=
X-Gm-Gg: ASbGncsD4vvqxTTMtAA3ublvPjHM/Fv7ZSOhTMgSGA4ZgyewUPBbIiFdKPJ4d1dsG9t
 m62M0xYNiLuyKrWDdO2g1Q19wGZwAgjK6MHVDY03qsywFcjkLgd/zRnferKf/zFkRFk3IwrVT8D
 cza8pSlTkR5cnbtH4Qx4o3bGqWcIRNgR1kIpYR6t/7NurhdY2ljpmo01MJxvV7HdCKf9vmawpuV
 rSxYsa1Ud108riWs0kQIFqzemi6oTGlWbcujyA4WGgkLQ06imDh/awEcA==
X-Google-Smtp-Source: AGHT+IFLCBIWOij/SQNLTc8tFCb6EWp2VwaYBB5VsM1WWPhoSdehvoYKyFBF8wtTLeTxZyPw5pLGvA==
X-Received: by 2002:a05:6214:238c:b0:6d8:8390:15db with SMTP id
 6a1803df08f44-6dd2331f24emr724385206d6.6.1735832928411; 
 Thu, 02 Jan 2025 07:48:48 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d5638sm132352666d6.117.2025.01.02.07.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 07:48:47 -0800 (PST)
Date: Thu, 2 Jan 2025 09:48:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
Message-ID: <20250102154844.GO3476@bill-the-cat>
References: <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
 <20241216183014.GH1505244@bill-the-cat>
 <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
 <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
 <20241219163604.GV1505244@bill-the-cat>
 <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
 <CAEfUkUJhuCB-5dXt1+FKMAk1t_N_sO6qAZHMK5NJrV7coGH6MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vnwOBvME4q1DALqD"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJhuCB-5dXt1+FKMAk1t_N_sO6qAZHMK5NJrV7coGH6MA@mail.gmail.com>
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


--vnwOBvME4q1DALqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 10:25:15AM -0500, Raymond Mao wrote:

[snip]
> As I said, we need an kconfig here to decide whether a user should look f=
or
> TPM log (and all other handoff information defined by the Firmware Handoff
> specification) from the bloblist or not.
> We don't have such kconfig now.

We do we need this knob? I don't think that we do. The case of bloblist
not existing where we looked for it needs to work. And the case of the
bloblist not having an entry needs to work (or if it *must* exist,
that's a separate option to add, ie CONFIG_TPM_BLOBLIST_LOG_REQUIRED).

> > > There's at least two sets of challenges here. One, being solved by
> > > vexpress64 right now, is that we didn't have CONFIG_BLOBLIST_PASSAGE =
as
> > > an actual option. And in that case, there's no U-Boot before full U-B=
oot
> > > and the bloblist exists for us. Two, U-Boot is what is creating the
> > > bloblist. The contentious parts are *when* it's created and *where* it
> > > resides prior to full U-Boot seeing it.
> >
> > There isn't contention, so far as I am aware. The normal case is that
> > U-Boot creates and uses the bloblist itself. Pre-U-Boot blobs (like
> > TF-A, sadly) are not the normal case and should be discouraged in an
> > open-source project. That doesn't mean we shouldn't support them, but
> > it is the tail wagging the dog.
> >
> TBH, I am confused with this statement which means we should not use the
> bloblist library from the beginning to hand over data from the previous
> stage.
> If U-Boot bloblist only intends to consume the data created by itself, we
> have to introduce another library to do the handoff, like what was done in
> TF-A and OP-TEE -
> then finally we can have a standard handoff library that can be used in a=
ll
> projects and keep bloblist as it was.

Simon doesn't speak for the U-Boot project, he speaks for himself. I
don't see why U-Boot shouldn't look for an use a bloblist for things
that need to be passed from one stage of the boot process to another.

--=20
Tom

--vnwOBvME4q1DALqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd2tVEACgkQFHw5/5Y0
tywSCwwAsbSsSxKztvZEvBCPWTUYxHTnTBhImxKL9xwzyMAsuO+Xgb/SaRBESEjW
c3y9sIsKwCOArGlb121jlEhreaBjw6EZzQcGtw0GlAID1Dkgt00EOmlVv1GLfT+O
m7oUP49Rt7wWcgZ/1WzwU12aYM5O++sokH4I86JDc0R7oD0VAgiLXfD2knQdRsfw
bMw6tpT6LuWYwboQjxRxwrhG45TaDevn13C05fBRECaiAo8K7bLJAUY755F7Y81a
JZ4wJr4liq/5AHdFLozRz+tzx5eZgp9gOak+qQ9ME/v7bT1Vo0QTpT8eNKoIcy4I
DpqHZCYY3bVW0z59Q0uX2XJwA4O9npVVVGsl3wz8dQcYGlJM0LkpRlLwH+EX/V3h
h4i4zZO00wVdSWOBXYhxt7nmsJHdfFKdQ2cbu9pXJohPTNkkLp6xL9VveDntCG3p
j4hbmFPUv37pBdt3uEImyxADPoOuZ+5OkKv/6vGCVUTZD3CFiP1/KLPKWFzBfGyJ
ECiabaNf
=uCV6
-----END PGP SIGNATURE-----

--vnwOBvME4q1DALqD--
