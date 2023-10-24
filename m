Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1EAC25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF3E87A21;
	Wed, 25 Oct 2023 01:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O3VEjC3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD3E879FA; Wed, 25 Oct 2023 01:16:53 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18370879F2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a877e0f0d8so2596977b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189402; x=1698794202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HEMhNt9W9XUyeX0p/C6q4bpfHnUS7L1yOibKYB91Cuo=;
 b=O3VEjC3URZpGOGu9D3o4XMZKx19AWf/nZNWfA94v02zyd1R/FlOVJ+w9Yf2FdK6Pcf
 4YoBuluHIYh4fQAkalySN+sLM44dNqBPnmZchk1XcR6b2kKgcJ9Gxa+A12NcZuew1bQO
 fIO6oJbyvfBfYhDOZ3r+6rJ0PKvXncPST//lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189402; x=1698794202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEMhNt9W9XUyeX0p/C6q4bpfHnUS7L1yOibKYB91Cuo=;
 b=swJjS0WZdYRASHcGRFsf1++nwZzGNkHEidFMaP/W3l48PhsPPh3fGfHOreNatU8QQJ
 3AunOtTKnISJGQmRiEgkfj3n/wFe+FFVk9O405CskypL0JfHlv7k8U8e2b2UzwsL+jsX
 bJCv+DtMq6iPFwLKbPtLmRq3AWxtWQxOmAi2nN81VsRnz1I/RVrGmCiqPDFzye2w2bU5
 foKlEV/F4gsWnAFIlnUYBFCVj0dM7jjzs+77k5ngK9uI1mFVFlRfasGsvzf2pTzvgGtn
 YdmdDMwKLbt09b3k/LhSbaEwnqMDsQ84t3j2zDFHZmqmj8s4q6mHWPhp+GwZQ9UUPkqQ
 ofUw==
X-Gm-Message-State: AOJu0YzyF/npLjDpfftcg5vBkSjJFymoMt/h3RbSDq8ZxFTFZAFmDRps
 eEqegxVpoeHx7Jly2QMQHMiNtA==
X-Google-Smtp-Source: AGHT+IGZY3zDGorMJ5PoOq9A2QUzoqgFph8O88dtGlp1IscHrS4rz8/85P5Un4T0Zw+z7jBOA8yVMQ==
X-Received: by 2002:a25:3108:0:b0:d9b:c9be:f3d9 with SMTP id
 x8-20020a253108000000b00d9bc9bef3d9mr17806423ybx.29.1698189401841; 
 Tue, 24 Oct 2023 16:16:41 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 y134-20020a25dc8c000000b00c64533e4e20sm3963097ybe.33.2023.10.24.16.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:41 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pavel Machek <pavel@ucw.cz>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Detlev Casanova <detlev.casanova@collabora.com>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>
Subject: Re: [PATCH] pstore: Use root address-cells/size-cells as defaults
 for reserved-memory
Message-ID: <20231024231639.GZ496310@bill-the-cat>
References: <20230826121652.2487643-1-andrej.skvortzov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SLp95A4fPdEJ+Bwb"
Content-Disposition: inline
In-Reply-To: <20230826121652.2487643-1-andrej.skvortzov@gmail.com>
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


--SLp95A4fPdEJ+Bwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 03:16:52PM +0300, Andrey Skvortsov wrote:

> u-boot adds reserve-memory node, if it's missing, with following
> properties:
>=20
> ```
>     reserved-memory {
>          #address-cells =3D <2>;
>          #size-cells =3D <2>;
>          ranges;
>     }
> ```
>=20
> But with these default address-cells and size-cells values, pstore
> isn't working on A64. Root node for A64 defines 'address-cells' and
> 'size-cells' as 1.
>=20
> dtc complains if reserved-memory has different address-cells and
> size-cells.
>=20
> ```
>      Warning (ranges_format): /reserved-memory:ranges: empty "ranges"
>      property but its #address-cells (2) differs from / (1)
> ```
>=20
> This patch takes into account address-cells and size-cells of the root
> node and uses them as values for new reserved-memory node.
>=20
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--SLp95A4fPdEJ+Bwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UFcACgkQFHw5/5Y0
tyxGVAv+JyRvP2ixkka1OSSCtkNDtiKcd1FjYnBw9HU2fNySSVzYS3CWH4htcENi
2hBJ/hPOkeu90WW5lXpDUInZT8jha5Tfs7dEasT7NfnS3iWFFYfEVeQA9TdgSVWc
ujuehvyLf09C3ze3KKtVVQEV5ZhtSs13iBHa1cCmpCKleoefVSLj+ZifKUvVtf5J
+OYGYAuk/vFgEm571IOivGOsY9hk23LKL9PSwy5aineQEBuGkAFMPjz8QAEHssJr
+pC2glDGtlRLji5TaYUCuvpkO89TH/I9E7lfM6twPTy+nMBOVV6jbsHKVwyKMrZu
crpMpEskm9pBfSmHTXntdpjAzgAq71MWcIoWsNsbdAyjzgvlk94fDiKmMEkhLaAV
M+Kb6GXtH9fYDQ1Pt8SR3CC7h4QZq7D89ZwnRn2F/hrf6z0V01KJm3U+U2J+3QQz
U+PMcUPHBz8Ug2YXFcHxVq4lzNnxxFcn+OWK1CWE4tMXbxclfzI0KSMhSv44MJS1
Z3gPZc3a
=Yd30
-----END PGP SIGNATURE-----

--SLp95A4fPdEJ+Bwb--
