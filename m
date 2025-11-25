Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD16D0EE04
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 16:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52642840ED;
	Tue, 25 Nov 2025 17:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TLfBERLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FBC840ED; Tue, 25 Nov 2025 17:35:31 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4CD840E0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 17:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6574ace76dbso2286238eaf.3
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764088527; x=1764693327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n80dGBicgH5yHiTu/RtAFG37Qz1+ctlevPZytox4M4Q=;
 b=TLfBERLnHD8jM05YrsC17XwJOq+y2mmhkw+5x+hxpAkKHDsmC9H1IFhNU1rFNMub2l
 km49pFiptSsZVsx29dvMuMlxFjPdPTP56y1IwiAB90SvY+7uVxMdNEG6B/jeHtr+P8Pn
 qb5rfNlmv3RFwuZBy7R+J5XtQIprfmxDYybYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764088527; x=1764693327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n80dGBicgH5yHiTu/RtAFG37Qz1+ctlevPZytox4M4Q=;
 b=OnBIadMDVETivIM0jSwBkFm3q1DiiVRrpCxUgB9sHGjBq8h+YdCAHd1krAU1bOfT04
 1V1SWoLKxiXCvDNzavodgTZ3FaT+RYyJm711gNn7T2iGp6eD4jPFqN3PAk9E6YxZEMHJ
 uvBWLwoxQJSkmsnPmj5eGfiMFJFkQ2P3Idcqo9FZAWypAXQPLsIJARWqkmN67oct6pj0
 oY8vnjq10ucKnlXKasRYpUwYGwHfd1fmwEuvYq/jG+q81PgAm/cs2EtiTaNyu4rGehOm
 E2tOFa7WrL9JKFCbkl0gBzIz5yayxVofUKXohLwF463rxuIVunTFGjuG87GXfNw4rTe3
 13hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlBGqrXzdkfvgiyKgljt46K42m0c2O4bU77MrMLzbgi4zHGgtrS/EvBSaSq+YOTuLOmnDm3e4=@lists.denx.de
X-Gm-Message-State: AOJu0YzghdXfGyZsc/N3sL55CDki4mDvLaHPomnef7/DYMusUSt+E5By
 EY8XqbgCexoq5szvcFrrTv2zrfElegsyRLga27VqJ0Ri6jTsUsrr/ZQ128f9V2z2Cck=
X-Gm-Gg: ASbGncuZG/duruS4TRjXKJg2XU4zPuL7sj0xnAnTozg/HviQviWuDDAyzTrU6uIBA/V
 m/kd3iFPAuo0AlRxLWnuS+aL7hvN79AzwEn10LHBo+ttSxwiF2/HuJ6CjT5tJE67hOYer/Rm0Yt
 +nAk3NBhou4i3kaS9an6fjxPTzkDedRLYry8pNJGZEw4MBSrIRqihwvgz9iA2QsmeuqyJmYzRrG
 Nwp+HRrzlW+wGxcbT2UfFvexpQlw8cq+Tg3wQTyUCTn00N5gOTJWrZIIV+qllxgtigiTfTcKCTD
 OjiOhH0X7O6b35ip7719Wma3o6vjEjJUQ6izJzqDgLe0eBvp9EAufnpYtb4BJnedw2VrDEYJ/Qi
 0ISXpa8fL9/FRfjv5d0ZyrSH/hAi0Nw7CGKHq/juVav3XBkKQ7qbNURm6ArbePWhcq1DMZb7ehn
 L1bQ0A0NkoCUIkWmo70dp6cOoO0LerD5Tvm7rL0Sdij4TjIQ==
X-Google-Smtp-Source: AGHT+IGxHWs+moq8Lt7o6X+o4hGjmwbMTLQUl219qwXJ46vqaH3ed7KjKAXLrJkIAnDfpe713qpJMA==
X-Received: by 2002:a05:6820:1ca2:b0:657:6746:cd0a with SMTP id
 006d021491bc7-65790b7e8bdmr5177369eaf.8.1764088527544; 
 Tue, 25 Nov 2025 08:35:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782bacf02sm4306829eaf.15.2025.11.25.08.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 08:35:27 -0800 (PST)
Date: Tue, 25 Nov 2025 10:35:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: Re: [BUG] silent hangup when debugging lib/fdtdec.c
Message-ID: <20251125163524.GQ2125796@bill-the-cat>
References: <20251125161427.1155-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oa+VwdpgGfpr3QaJ"
Content-Disposition: inline
In-Reply-To: <20251125161427.1155-1-Alexander.Feilke@ew.tq-group.com>
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


--Oa+VwdpgGfpr3QaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 05:14:12PM +0100, Alexander Feilke wrote:

> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>=20
> Description: U-Boot hangs silently during boot when enabling DEBUG in
> lib/fdtdec.c
>=20
> Not sure if its really a bug or rather a configuration issue on my side.
>=20
> Minimal steps to reproduce: <see patch>
>=20
> The hang is caused by `panic("FDT overlap");` later inside the if block.
> (see `lib/fdtdec.c:1279` in `fdt_find_separate(void)`)
>=20
> Additionally, no boot log can be seen because serial is initialized after
> loading the devicetree in this boot stage (see `common/board_r.c:665` in
> `initcall_run_r(void)`)
>=20
> Tested on i.MX6 with configs for tqma6d_mba6 and other tq boards that are=
n't,
> mainlined yet (tqma6ulx_mba6ul and tqma7d_mba7).
>=20
> Any idea what to look for to fix this on our side?
>=20
> Thanks in advance,
> Alexander
> ---
>  lib/fdtdec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index c38738b48c7..0f2f7c948cd 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1257,7 +1257,7 @@ static void *fdt_find_separate(void)
>  	/* FDT is at end of image */
>  	fdt_blob =3D (ulong *)_end;
> =20
> -	if (_DEBUG && !fdtdec_prepare_fdt(fdt_blob)) {
> +	if (1 && !fdtdec_prepare_fdt(fdt_blob)) {
>  		int stack_ptr;
>  		const void *top =3D fdt_blob + fdt_totalsize(fdt_blob);
> =20

For very early failures you might need to look at enabling DEBUG_UART
which wires in a more direct "just write this to serial port".

--=20
Tom

--Oa+VwdpgGfpr3QaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSXayQAKCRAr4qD1Cr/k
CrT+AQCFv3VtsYiwdPO3i4Fwej6U8JHzwWkKWtzfZ+7EtXpL/AEAoXVUegXb6YGd
g1r2qg+upOCs8mVtpEdyK4rXEGCi3wg=
=nKTg
-----END PGP SIGNATURE-----

--Oa+VwdpgGfpr3QaJ--
