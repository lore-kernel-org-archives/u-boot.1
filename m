Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61394C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 14:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D49B7878E9;
	Tue, 26 Dec 2023 15:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DqZTftl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A93A87955; Tue, 26 Dec 2023 15:34:42 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C41E6878C1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dbdb8e032f7so3522076276.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703601277; x=1704206077; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kNGni2HaqKwjzk43wxsgsCRcP4a3+TyMjjfsMPNebfQ=;
 b=DqZTftl7mkKaDIXhCJgoj+JjlA56IVZnGZszXpTd01vL26w2+YTSv9hWx9YuQVCjlb
 /ISd7UskrKJYwSUkb/4YuUuFaDet9JcXGt4iXnQriNNl1fPLvvfaolyT2UXgMzfdOPk1
 5YF/qZwkR4ONYjkQXIwp+ktOYyF1b6byP71Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703601277; x=1704206077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNGni2HaqKwjzk43wxsgsCRcP4a3+TyMjjfsMPNebfQ=;
 b=O6NyJr1LN/4C9+GoqsCcCErRRlkVPfc3sjB47uTAgkIKV6BmfPWFU1F5iHcw83a2Oq
 pgHA9nAMz4bx/+AC1LRME2LyoytMSvPj3SO9nG48kNTVXjhd7+KUv1xN9VVSeQ2WW8X6
 1S4xH/gh98+o0MD8Y2WvHFvhtkFpXN0yBBdd6L0kKE5bCKgsfySqmoM5pxbfPMS3t7tu
 +bXLdoHAaU/aStb0uVg7a2L9Qe5Wy2FH1QFiiKnXGpIzJh4QMep8/a7cSkRV9TJu6QWg
 7RHm+vJUuQ7wCd6xyosf0Bo9Rn4eM1px/pMu+VlD1KUzJBH+sAPSqU4l3Ak+rpxbdwBs
 n5nA==
X-Gm-Message-State: AOJu0Yxpv7NHM1/QyPN+Og2cQOfqnCyAsIKKl5dgr90WNtqRuFnS3mUN
 Xtpru4qgXEmWg6Aziu9KISnHGvPM3f6ydw==
X-Google-Smtp-Source: AGHT+IFzTsxqlu/7J8PTqYH/RfMcucrk0+GS+jsDHTI+vU5JweOmZY5lI041gYGut+YnEGuxZqMqgQ==
X-Received: by 2002:a0d:da85:0:b0:5e4:8966:948f with SMTP id
 c127-20020a0dda85000000b005e48966948fmr5850925ywe.49.1703601277435; 
 Tue, 26 Dec 2023 06:34:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n20-20020a819c54000000b005a7aef2c1c3sm5409611ywa.132.2023.12.26.06.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 06:34:36 -0800 (PST)
Date: Tue, 26 Dec 2023 09:34:35 -0500
From: Tom Rini <trini@konsulko.com>
To: sploit em <sploitem@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: CVE-2019-14194 patch bypass
Message-ID: <20231226143435.GK2652760@bill-the-cat>
References: <CADk2PNNTD4o=v5VdJpJSV5btrfEHVbwJvDgApvCrMVp8e8hcrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/JGtuBGIR2EkVujD"
Content-Disposition: inline
In-Reply-To: <CADk2PNNTD4o=v5VdJpJSV5btrfEHVbwJvDgApvCrMVp8e8hcrw@mail.gmail.com>
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


--/JGtuBGIR2EkVujD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 11:16:17PM +0300, sploit em wrote:

> Hello.
>=20
> I was analyzing CVE-2019-14194 and I think the patch can be bypassed.
> patch
> <https://source.denx.de/u-boot/u-boot/-/commit/aa207cf3a6d68f39d64cd29057=
a4fb63943e9078>
>=20
> In nfs_read_reply, rlen is signed int. So we can make it less than zero.
> The value less than zero can bypass the check at line 756. This will lead
> to overflow due that assign has an unsigned int len parameter.
>=20
> For example -1 will become 0xffffffff.
>=20
> [image: nfs_read_reply_cve_2019_14194.png]
>=20
>=20
> I've constructed some code to prove this.
>=20
> [image: nfs_read_reply_cve_2019_14194_bypass.png]
>=20
> [image: nfs_read_reply_cve_2019_14194_3.png]
>=20
> Thanks.

Good find.  A patch to resolve this issue, by someone with an eye
towards other ways the problem could be exploited again so that this
time we don't have other avenues of attack open, would be appreciated.
Thanks.

--=20
Tom

--/JGtuBGIR2EkVujD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWK5HsACgkQFHw5/5Y0
tyzUGwwAl0qNWll+MxuAQy1pzNK44t9hTvBbcJDUC/NyV3VlBUdP8UoQIrIdFdHf
VM3VjOoM9vtD3tUUNEHP0xmKYNVNaxlTQbmoygT9Cpx97dMsPwCmUb9/zj9sviEx
ai/l9ax6CKsZ2uNXI/ZrXjUMmqsudS9T22hZaiMLFtJ6NZX9fRjFgF1Vj7tEGDBQ
+UYBn5ee8aJ4E1VN75zWd/B8O8GLTEKNba8L2zn8sl+5EiwayK/hZGCCScTB2EUV
GPEjaH7j1tIhNBWyD3ANONvt4PPdlgZu25Es4kGoj9w+FmXCfc+Ed2gKer/rqpyF
LcRC5U4xN6r4l+eP9V2G1CUMe4cNG5TCkrjAJM2G5iXIxKXIuvXur0R6GJXJKeQ0
3s1q9rsmwNArJGzPBUQLO4s2GOLmvGuh9wfH/ZA5EXVXvlwb24dz+LRrdGo8Ykll
9U1VC5StVe2+Pnc1IWWSCecKRNYmiWJnEtZX+AbZaQ2znecNvkNsPxJACV7JTgyO
l4I0nkFX
=Ed/q
-----END PGP SIGNATURE-----

--/JGtuBGIR2EkVujD--
