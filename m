Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A239BC4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 19:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F36D3876D3;
	Mon, 12 Feb 2024 20:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jljq4fXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A36A876D3; Mon, 12 Feb 2024 20:58:57 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C9787061
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 20:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc75c2c3574so2459758276.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 11:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707767932; x=1708372732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=evM634QcrtddImD4WyG0/SqA5Nmb13Fjhjdkk2EuoFg=;
 b=Jljq4fXfj8qqQaZLBnThmCdm+qGntIZKwNzocRDUWfWM6IuyDldEbXWwe47j3fHNWc
 WMAlXZaqhXrFr93b1LCe/zrorARF/FxGbsID+GZ5mNdZibpTn5G7i/l1cpWqLKVA0GYM
 0pMm6lJAUoRij1JAbcyK136ACEd2+XVSxlFnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707767932; x=1708372732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evM634QcrtddImD4WyG0/SqA5Nmb13Fjhjdkk2EuoFg=;
 b=JH++2uwn3JbK56QgQuwy9yQMs42xc8wiU3eLx16A134JvmRCwp70ZsCjQ3oXBUDVbq
 Ev3Cl0zaT2stvii5KZyPgh1Z073DhhqBrWy2fef7gSXLWTy0lOUUvJWJumJo8u6iKGjQ
 Klv2CnHmu3j1r6RgkDu9QLvCTFus5smlkWO1fq6q61LiW5NV25UWlPK2ya7TCu5L8tC2
 Ipptxk2D2IFrg77WSAR8u9jtl3+tbnKan739WTIMdsplsGRV6QFU6e01kkNU5sS6z5MJ
 9awkCN9kyGc21DCyVPAHHOrbi6B8qTDgIUJG/4S6+Oj21UiqAcHQGaYacl+tNNOPNo+n
 9dsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUODhWJ1cjPgvnFkcsAhee/PP8ZrvdGcKmeli4Rx+V0qEF4puWiiSvzVEzFkehrcexRbh2ImPREKYJ8iEKkGjV/BE3g1w==
X-Gm-Message-State: AOJu0Yw675Il7mZmpueBItVtJ36eHjafg2LIRTh0irf0c/NW3oS6M80m
 thrOAHFxDlkWYIRw3cO8tqd6ePC3AUwf1MpPAc7x5ivgSIevMTcm3V3K4M0/PiQ=
X-Google-Smtp-Source: AGHT+IH/ltXIYzsmYBeGhFSNSwP473YVusZzUrJx2/fS2x/hDVR81v/rAA0x/A+GufP9UlzaEg8dZw==
X-Received: by 2002:a25:84d2:0:b0:dc2:53b0:6353 with SMTP id
 x18-20020a2584d2000000b00dc253b06353mr5618262ybm.38.1707767932270; 
 Mon, 12 Feb 2024 11:58:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWTz72rIP+0prI8Kv2EVi4NZk2VJ+fNkeCsSLGPsbE1rADDSZYtXuav3FLSqYksAJpnY/FxIzoxWOSCvkNMhJ7FTnAUftduYIVIYmCmNqKWxAozkb6wjsMCSXUx8um6o4rigOeZEcrrqIhiWSCLJOsjq70=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 u61-20020a25ab43000000b00dc6e1cc7f9bsm1361941ybi.53.2024.02.12.11.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 11:58:50 -0800 (PST)
Date: Mon, 12 Feb 2024 14:58:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Nils Le Roux <gilbsgilbert@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] net: designware: Support high memory nodes
Message-ID: <20240212195848.GN3040305@bill-the-cat>
References: <20231202093952.33256-1-gilbsgilbert@gmail.com>
 <20231204010930.071a5ba7@slackpad.lan>
 <20240210173703.73d18367@minigeek.lan>
 <20240212184031.GL3040305@bill-the-cat>
 <20240212195640.49bd927e@minigeek.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4eVM1B1Be+HvzG8E"
Content-Disposition: inline
In-Reply-To: <20240212195640.49bd927e@minigeek.lan>
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


--4eVM1B1Be+HvzG8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 07:56:40PM +0000, Andre Przywara wrote:
> On Mon, 12 Feb 2024 13:40:31 -0500
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Sat, Feb 10, 2024 at 05:37:03PM +0000, Andre Przywara wrote:
> >=20
> > > On Mon, 4 Dec 2023 01:09:30 +0000
> > > Andre Przywara <andre.przywara@arm.com> wrote:
> > >=20
> > > Hi Joe, Ramon, Tom,
> > >=20
> > > for some reason patchwork put this on my plate, but it looks like
> > > genuine network code to me, and the problem definitely doesn't affect
> > > sunxi.
> > > As tagged below, I am happy with this change, so if there are no
> > > objections, can one of you take this patch, please? =20
> >=20
> > I believe I delegated it to you since Ramon doesn't often have time to
> > put together a PR, and since it seems otherwise fine and relevant to
> > platforms you're the custodian for, I was fine with you grabbing it. But
> > yes, I can pick it up directly instead.
>=20
> Ah, that's fine, I just didn't know and didn't want to interfere with
> any other ongoing merges. I am preparing a pull request for this
> week, and can surely put in there, unless you want to beat me to it.

I've already thrown it through CI just now, so no big deal.

--=20
Tom

--4eVM1B1Be+HvzG8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKeG0ACgkQFHw5/5Y0
tyya5QwAk+PunNX7KRBuXD9BTzNSfhOYoVRCdJWHs1TLDRIzibFLeYw+kwAym4n2
11XefP9P5cOu1+arpampa0ZGc5OKBNTyfeSukG21XMJmXmAQHf9RYrGwffT4VV90
hhATHp9fcPISlCPcsoAYsl7d0HsEchwLyROTkibvc/yPpcMt/HViUcAom5xsoj7G
+SRGFAV2VSeSShFQSTC7c/m95LOI0pcZFg5ktG/lE4GVmajcI57Bo7KVOLZaTyWL
/LkpezIQeJ2v8TqFWV0zYmfte2Pwk00HR966bNV2e7ZiwGoxa2SIQdNdtSeQ9HND
OG/tQ/pGHmbuzLMO52fynvOl3r3ouMb/LCV2G+9xDCl5vzz8c9lYv1r6+pet5t/K
SWr0tgoREtMaPmGsSaI7Uev/hRSEmgvJG2R6Au96QPbV16HzQ+7N+T6MWIJxH7Mw
u4BzJ43OA7J1KNr4qRTY7hlWRDGhAk81inQSIm3Ksg7doB9yQBmVvu4DvWIxUZTn
WksEveiV
=pgFW
-----END PGP SIGNATURE-----

--4eVM1B1Be+HvzG8E--
