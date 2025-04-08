Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ED0C369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D16B82E66;
	Tue,  8 Apr 2025 16:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YnVeDQvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A8582E86; Tue,  8 Apr 2025 16:21:03 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8732A82D83
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3f6aa4b3a7fso1655743b6e.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744122059; x=1744726859; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IvBx1lmi65LyJ0wLnfmnoBydiLKTRDSG740gpr53BfA=;
 b=YnVeDQvCDxVaHL0oTdEMiBy+pKuxl+OBLdvWNFU80kUIjxY7PMD7/egCtj1iYgegqw
 0dYx12DzGwXDTFI8qdlfxbLteRTRNoJVSquvd9iIhNH+GLQcRCx4A7fSeobnBZUy+xVa
 kavVVzePnszzhRoG+f0n2H2jgtneuodZ1HwSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744122059; x=1744726859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvBx1lmi65LyJ0wLnfmnoBydiLKTRDSG740gpr53BfA=;
 b=UmxGoUUGeo+cd22DRdsluYI8D/iZaIWPo0j65HZBZ1MmnQSrJxs6wK85ibQtOwmP27
 sZU7ekQgoz/aCt0R6FCIOKHYrvraEeCFdHuhJ7cZhYY4Ax+pTPOdsmPPI9u2uwD9dSnN
 nu6oh8DpAgeHN3TGgG/kW1Pt7jQh3RpIRMYT9hf0hKJyz7MRz00S/F3JJNz0Wb5sfiBD
 Amq4q5yyPEDFs4YLhNHywnCUHqGpGDL80BaR07CtFXNlPr1XVykMwkrfbYkI/ZUhSCIT
 mQLPyRhQQVWcNriLX1IkSWdCrKL2BpI8bwsaMLSdmtPTGiRJfykurPzAQiYmUKnCeZM4
 dJOQ==
X-Gm-Message-State: AOJu0YzsKrbpLyGsJZWvf4rlTwgEUtU7ulw2mDREyZ+Tz7AcR74qxHy3
 kg0pTL4VPveI6OXwioig0M68E0Sogg3r4zHBWiGEScCoa7BZSas7VqY3JfGFsg+7xLW80V1CA4x
 P
X-Gm-Gg: ASbGnctWsVFFwiDVdZjxdU6s/FAgIXtc44eoO/mm9DHoDgusUjoxbqIoEIsXSUmzmVR
 7xRF6kot3fS0Rywgo0rcPlHjnmL9I4TTz6aGWxYVWFYcLIYUbWeee2BOYmt5BeMBM9/X9YBuVh1
 kudVeHO3/IXHOZRio9WdTMGPN0KQ9TWw+1Bej22hZdsbaeRb+RXdf1Hs1zVbH8gd0LNPck011Wu
 1W1M6ZL9mWP/C0q02rb6qWj8SyB/ubGEK41qgWnKQNa2Lpz78hhYjzcp9pnjYQrfQ0M0w/hjfxu
 6VNCF2haWOeLHX1Oal3ybgeCYQE8qTepG+UBJxPepe4ycwe8j4vSCds0P2pXKjcJkyBr8ptbT+a
 daQ9yxA==
X-Google-Smtp-Source: AGHT+IEfT1fZG9m6DIcsw1H6YcpcdKY+FTaCmfc1Yt2+SFjn3miowWdLrbTcykg5gtvX2ISOy0qq9g==
X-Received: by 2002:a05:6808:1b26:b0:3f7:4b65:582e with SMTP id
 5614622812f47-4004da5f0f7mr8814819b6e.26.1744122059194; 
 Tue, 08 Apr 2025 07:20:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400699fd5ccsm464125b6e.33.2025.04.08.07.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 07:20:58 -0700 (PDT)
Date: Tue, 8 Apr 2025 08:20:55 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04 released
Message-ID: <20250408142055.GW5495@bill-the-cat>
References: <20250407220011.GS5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sv9IUghoQWhYjY29"
Content-Disposition: inline
In-Reply-To: <20250407220011.GS5495@bill-the-cat>
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


--Sv9IUghoQWhYjY29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 04:00:11PM -0600, Tom Rini wrote:
> Hey all,
>=20
> It's release day and here's v2025.04. We had some last minute issues
> reported, but then also resolved.  I want to thank everyone that's
> contributed to this release, not just in terms of code, but
> documentation, testing and otherwise ensuring things go as smoothly as
> they can.
>=20
> In terms of a changelog,=20
> git log --merges v2025.04-rc5..v2025.04
> contains what I've pulled since the last RC or:
> git log --merges v2025.01..v2025.04
> for changes since the last full release. As always, more details in
> pull requests (or the tags referenced by them) will result in more
> details here.
>=20
> As is becoming reguarly scheduled, we have a community meeting tomorrow
> (for me anyhow). The meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> April 7th, 2025. 9am (GMT -06:00)

Sigh. As Marek pointed out on IRC, I got the date wrong in the email.
It's today, in about 40 minutes. Sorry for the confusion all.

--=20
Tom

--Sv9IUghoQWhYjY29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf1MMAACgkQFHw5/5Y0
tyxMqAwAnXB5ZjCK9AB4mQskSI0XFYOBkCXGDE9pu/oXtdluinwauaNEBKpjwW4s
owNIGpZmfO02FMr9hnzkd11akbuo1iHrnUvdaLNQTSTgroCS2A0qflVEXNEYK8Nl
JjitrCgqE8iOfBJjely9H7wRnWgWAb7mKjSRBs9cZMgvLDNmYDnDNWO0wbHjKsTJ
vQ/H/mWunebKCI/k4K7qNdCkgdqZdsSK7be1gf2+i9he1sFesDwhdQWv99UvxW40
FYKIt29PqE1y05djQ9opocYnAR+qld72vcvOjKyRo8t8NvRbU/Qd06aGFnHi0D4G
0Fld/APbr3Yaev2kJTpTRr4v4sIgAyOdHY80/TD5oJ/pXRIzwe6SCJytn/y44y5E
Kg/agoNGes5VZVoiw0fARCsdHUCxp/asmWsajlMng5RwGQbVSYqv9FddoxVBw9Bn
jrC1tDfo4GiA8iu83uGuMCdokiwvOlDrA3Px0H/2Wd2BsK7n2dz7f6lqMcUx8V39
nyEspWc3
=1R6v
-----END PGP SIGNATURE-----

--Sv9IUghoQWhYjY29--
