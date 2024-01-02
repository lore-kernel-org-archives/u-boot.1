Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF61C4706F
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 00:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990C6876E2;
	Tue,  2 Jan 2024 01:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hxkAMvhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4FC287708; Tue,  2 Jan 2024 01:03:11 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44E0B86FFD
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 01:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e7c1012a42so71621217b3.3
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 16:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704153788; x=1704758588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5e3lWbc0cYk3/BpOcUnwfZ0cwqBI16UmiLkkhbtLPbA=;
 b=hxkAMvhui35U8tmg/6IwBVIgBXl11Hwl0CQ6Fl3z+8Ns6B3z44CCGTnXYC/maKtK2A
 rJ0lyENUnl0pdYuc7RMQza8a+v3RmoX4nEju9e9VQy0focpu1IKKEEoufZuWVvG6Bi0U
 IAM+6F7iNRM/YxsuguUGPTLV1eQ1vhm/5TfRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704153788; x=1704758588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5e3lWbc0cYk3/BpOcUnwfZ0cwqBI16UmiLkkhbtLPbA=;
 b=IGMU9+GQuJhepmPKpQsEfd0wsc2F376QE6tIGlK4ypbmeGUo9Pq1Qgs0MI+dYXDClj
 CqDKrEu/HHkSnTPOxVXv6JTFGtK/JF2kay+jCgRTjZunqbmKCKZoE/63XwxIV0JgOZeo
 XMa9bwQ5jv21nqVdQexp25p4bZlnDtrNZqMi6ymk19iotdKqo9XHDa+SiMETjJWsV6Sb
 NZzcqbab15x7oiDn/Mpqwo1doig5UMlnQ8R4yq6n92YLTRESiiRH3OUSMhjd7O+4LZds
 mkyOXebPMfkPkrO6DK+jI1xcdGjOCoc8XPcRPNgMsNodHnc5F8itQur0cttHbAP2fSjG
 sMAg==
X-Gm-Message-State: AOJu0YyHRJBxb/KEngJBThZc127lBa7Z3AkAUusT7Fj8PHz8Bu2cN0fF
 99mKnGAspBLaXevUeukrNBTOvwCmkcxI7A==
X-Google-Smtp-Source: AGHT+IGv5aq8NmUPCkVyycHTnIgYWeSw1TRYmkyqZajGKayKHjyNasci/3iQ62xhw58QFxg6D/gJhg==
X-Received: by 2002:a0d:eb52:0:b0:5e4:8583:b52d with SMTP id
 u79-20020a0deb52000000b005e48583b52dmr8634049ywe.58.1704153787986; 
 Mon, 01 Jan 2024 16:03:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 z17-20020a81c211000000b005e71fbbc660sm11503631ywc.137.2024.01.01.16.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 16:03:07 -0800 (PST)
Date: Mon, 1 Jan 2024 19:03:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm next
Message-ID: <20240102000305.GJ2652760@bill-the-cat>
References: <CAFLszTiz8oT9tTA-w+qVnxy2=mjCya8RMXdbswS1GtoxV+hO8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cyK32UjSfIAUuhqw"
Content-Disposition: inline
In-Reply-To: <CAFLszTiz8oT9tTA-w+qVnxy2=mjCya8RMXdbswS1GtoxV+hO8w@mail.gmail.com>
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


--cyK32UjSfIAUuhqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 01, 2024 at 10:31:57AM -0700, Simon Glass wrote:

> Hi Tom,
>=20
> This is for -next
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/19131
>=20
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D57&view=
=3Dresults
>=20
>=20
> The following changes since commit 2b28c3b871cd5d55b19f0a86cef970139f8ab9=
52:
>=20
>   Merge patch series "Modernize U-Boot shell" (2023-12-28 14:38:25 -0500)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-next-1124
>=20
> for you to fetch changes up to e266d2731145681a55d862360f1b61690b0c6820:
>=20
>   bloblist: Update documentation and header comment (2023-12-31 07:21:02 =
-0700)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--cyK32UjSfIAUuhqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWTUrMACgkQFHw5/5Y0
tywe8Av+PbcFpP2OLHbItJ1U/1+e2CbZVZUjwT/8vM8KbbUyh7ZrgJtBfrdeExka
nVQUc2lLyqTCxfyIGZ+lsgJlULzDdpAdGR1I3dfem73MMgcwfksWLLv87GkEoRey
Gaurcn74o1eKfPdTm7OoHywY1MunfbZ9LfKcd61/DiTrsulj79xFP4Ha2TiQx7uD
DV2lVOmH1xmJdrD0C+Qe0fN1h4j/m1pyWrj9VkOI8p7iCX5lEBTT712GnIMrRftQ
va+jxz3AXI59KLoBmnuibNxlNftn3qqJ2AdHYhnnoSNUmdxEAK5/hJkXTpFLy8eO
Zu6k3pYI/nKfVq6LFsaL2A18vURqnLjG45pig7I7Pjui1/lGvCQYZS4aDaM7wfb3
zUhdcrlkpsfS22gOADb0YfheGEtU+yhAjBZGmpNLCIG/E+W6bfyDCCBNtNC7rvax
s3Cu4HrtIZFodWZzVEw7zunoJLxhddVhu0u3bXcuP66XtsVM6Qv/ZReyKBP6JIck
cX4w59Dh
=1pLV
-----END PGP SIGNATURE-----

--cyK32UjSfIAUuhqw--
