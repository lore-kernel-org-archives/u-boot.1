Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D9BC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 14:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1318682977;
	Mon,  5 May 2025 16:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WcXOcv5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E8A82991; Mon,  5 May 2025 16:44:33 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7583E8212B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 16:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-401e77e5443so2804302b6e.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746456270; x=1747061070; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S/TttMcPyDNLe+REumHGkvKZ+DzFaDfzT8RppQ38TNs=;
 b=WcXOcv5YAyzTQ9rMLEsWyijcI352CXzcmuRubEaUpvhs1OHxwza0L4VkonH7AUFIIq
 l9ZP/fvf5YsDeqXgfXkiOwaRtIpyGyXjSNtHMf1y2iDhm7/mChjOzo0CfdXgCgnkk2TZ
 g8R0nbDZeIk2iu1GHqXxfa4Q9bpABfJJYLMeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746456270; x=1747061070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/TttMcPyDNLe+REumHGkvKZ+DzFaDfzT8RppQ38TNs=;
 b=KWAulsN+Fm8QwsQSf9I7BPgdnDV7t9wTPyM3+IX0+gsEI4//+idrvgDmDcWuPSI2br
 p7XQKuqFY79ZugsKMmmmLSqiXH1tpt4KiFZtOM4CZc3d5utY/z5rfsWD7kD95gHv/aMk
 lz+2VPmWE8vIHKulse99u39lEx28DbI0owhgzQHmcR7jipJ/fB0JD+Z5sD692aGKaNVO
 VO7/dqzzMq/FG4fia5qkUyyjPifRB9EPm9kbute5KkU0mS6vs6wudtrdfOM9L9VNuubJ
 oIIXq/y1TvUZCCejljybBO3q9pJk+/ujGZZlB7zsHFe8fbmlXkgfN84qhRN8MsdKEEdV
 qwEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyLtkM5M82Uzbe3Hk53hHbbUK8aCWcasaLQ9I3Fvzu3kHMCInnmYhLl4hrV/ymVyBQ1YY8m/g=@lists.denx.de
X-Gm-Message-State: AOJu0YydoWVbYpwDPUX67100giy3etZjAP+/uOqOsd+6gX/aL2ODMYG/
 3Awn0aIa77ACDZCEaHj4nSJtuAz5sNhkPqOpLJ0ZbkxloEWJgKRm/dKVLloR/vc=
X-Gm-Gg: ASbGncslVJs1NdTcKP+62z8s0Iy65ZT1PFwQuXUiJXvDP5xMhlXY/B/W35Y7qvK4N+8
 GDgfIq72QRVufppNwty6gzh1+C0D+DAvE5tomC8SOgiStXs+W30cW9tFI8JKT3jpu5SzW8+cDKW
 iQKeiyt9cn0mVvE/d+5iUk6q1PhgWIUKMeiZdePJH8XSBa784lF5bPXDp6na8a7CZfGdZSDeEkv
 rV0CPpmj0reQT2ulOb7BbdyxNxhSyLEKPb34wVGtz6tNHqPKdCMO+ISNI1j2CY2K3Tk5SKv+Sq2
 AzbgVBZPEQV+IZ5X67YeJLpwa1KSv+U6n4nTtisWeUVEDUc9y4MyXDoffMV/4OUT0lNS4XTedro
 tWQ==
X-Google-Smtp-Source: AGHT+IE6uop2Vhiwk9XOsDdivNbCW2t78PQvNhKJ+9OeUeoTzNIVo9OAMsioV1BZeY9Ts8CZa92iPQ==
X-Received: by 2002:a05:6808:251a:b0:3fe:f41d:465e with SMTP id
 5614622812f47-4035a5daa20mr4650204b6e.37.1746456270226; 
 Mon, 05 May 2025 07:44:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033dc61752sm1843850b6e.40.2025.05.05.07.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 07:44:29 -0700 (PDT)
Date: Mon, 5 May 2025 08:44:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Dockerfile: use lz4 instead of lz4-tools
Message-ID: <20250505144427.GB5430@bill-the-cat>
References: <20250505144314.299359-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uHMuNu/fUs3tVzl2"
Content-Disposition: inline
In-Reply-To: <20250505144314.299359-1-heinrich.schuchardt@canonical.com>
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


--uHMuNu/fUs3tVzl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 04:43:14PM +0200, Heinrich Schuchardt wrote:

> Since Ubuntu Jammy lz4-tools is only a virtual package which pulls in
> lz4 as dependency.
>=20
> Update documentation too.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uHMuNu/fUs3tVzl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYzssACgkQFHw5/5Y0
tyxHZAv/YUBJ0uh6Aa16qDFVmykXz+0RwA9afuA7puMvrvWg+R4NdbN6SZAPMIcO
vNQPu/gmcu4CkDif0fLb995Jce4S/cZzO4+8FEaVorUvt4B2B29zNOj3JZ4PqidJ
zal3+jWtZlZkjHLgPQLqRr0kol55EeTrTyPqRHAihOdJ/UT7eEzXeIPNTmmqpgap
DCjA0QPkmgLQ+WwaWOEBTZXnOfdby5sHNhXiV91SRz64HPYAmlkgQTsmh+g1weAV
uFj68fQijUwoNF6N+vYnYvqofbdUpc8374YyJJ0W4CVAVCc/ojNio22MNa2Tevkf
zP6TFIzPsOg7ZedUvp6NQmd4DYnrIv6UwM1iP/zfM+fBb7qvxK3obBZKHp86qs+U
yzxdiGkk8zZ2IlF8t+ZuvgMi1ynKmo6XSw5XX7xNGVSbHy82iJGMPL9b4fQUBZ8Z
QoKrUmna6cx9tJxlx4iTDT+I7RWCNqAyTTF2NY8pdaLxUv3HX2dRHzZtXPFEU9l/
G/NJzE/q
=CAvy
-----END PGP SIGNATURE-----

--uHMuNu/fUs3tVzl2--
