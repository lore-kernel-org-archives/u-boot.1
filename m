Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5035606A32A
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DJzU77jF;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=D02SXIaE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 733416069A;
	Fri, 20 Nov 2026 15:41:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6ebNiCc0323; Fri, 20 Nov 2026 15:41:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B4377606CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795189264;
	b=VgeZh3vpVwTWgJKq4Pdf+bp8d+RXSbve90M9oeODV7v5dzyavVqTpty3SDBYp/8mCdfu
	 Th5xz254rPbTN502RBgRXtMam9MgXLs0tJkXgo1TY8IQu/JpxYAhtETowbidbfe11u78V
	 NoSVmpbIuMEXrUWg9hDIzCkzdTsWP3TsRxdr/AQC9rentBBm3g/YOB0fgojA7WViPiZIT
	 9e7HIXypoRF+BUMPm+WuCCB9ptbH4TfCRwLq4oYKQefC4/m54RXeWyArAAGZ3PmLSbPAg
	 3cuSJ9FbnShz2ezYw2npM5PKJmCnHtipjStLnQkQ2bywoPublQVkTSyUu9ngKoQxW5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795189264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SbCBNu/Fp/oYJqIJV+gcKZpIngllj0PJxe3F7CJ2shQ=;
	b=oT9OFnHOIdOl2WEzHTISh5NCrm6xEqudQDGtsU5oPhwF0Nni5OKW+ZRf2oaCZcBZhhFO
	 eiQ1YusffSq5NHXa3HEVw9PNSNGCJq5+YjrSqw4VcAEBV11xMnhQXWgJ+QjoY/NRU/p5K
	 IK4KdI9SDvobyLAt/cPhOEYhFUx6yYN0ZqFMytrFieZ2RxRcmboSEcWa0YxuBTzq7gwq4
	 NIfzYLdvpKAg2dP964r9WY/XpGuQV5ID8+0CCnE5jxYIeF/s+lAhXpnUWOTTh2sAkv4CU
	 ArqnzK6ZwLTt1SAl9IyxQ14CSMFl56N9IsQgXuXX7NbjChimQR7HI2pvYG7VmyMow5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795189264;
	bh=SbCBNu/Fp/oYJqIJV+gcKZpIngllj0PJxe3F7CJ2shQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DJzU77jFIVe565ygXTrD8hJXxixKg+OxWp848a/qbaZufFBYaiXMTt0YCLG4ejCWv
	 pog5+jAu+p/USg0sMQEb6KfCh7fMKwn/nUmFUF+1xLNUqgiC2ilcbxeFI3QtWhhbU7
	 emqEF1AtppXHY+MNjeZISvl+tHGT6bmRY9ZBkz+isb3aDiUJZRZIhkmafx37PKBAnT
	 BcZilsGhtmp6zuI5ZndzUMty24r2Xx7ft4sC59iZlmgtB3bqfmPnkHg5vwXjokFwLr
	 kUudA7IrZnP1cbriXT0+m/LI8A0VlyY0zOhjaQRY0yTbcm2alEC+KdBGhToPsg3iEw
	 jdAYpQExIKvbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4377606CE;
	Fri, 20 Nov 2026 15:41:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18C36E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15D4D816F0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Xz-Uq6UxmEx for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:41:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40EE5813BA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=D02SXIaE
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40EE5813BA
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:41:02 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-8479f46ecd8so428373a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795189261; x=1795794061;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SbCBNu/Fp/oYJqIJV+gcKZpIngllj0PJxe3F7CJ2shQ=;
 b=D02SXIaEUkxrVP9E6CGbMNhmciajNmEoVoh+xwyXzI+/mdMhckszNzNLAUHLdEr+3z
 MDVfs8V0wXFiVyKNVCYc0kCp2DxwH77nAcT+TjwJnUApP7R7gewoR1hQbiCRXXcAyGvx
 xHysHSfyVahG3wjd1ybtZenb5Cf2aKXL0IJCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795189261; x=1795794061;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SbCBNu/Fp/oYJqIJV+gcKZpIngllj0PJxe3F7CJ2shQ=;
 b=ZeqFivm9jdQk1AUDhNokhGG7yRCzSFnA8pScjBjshklb+YqTY3C2V0ifku4pu4uyKB
 9LcgY9NkEmaP/nIAPLou9z60NXJzBhqgejJ++LapAuxBONAJH02e7WI1yHPN66FlENgG
 FLe+RwDUcYKbYsbbXokG0fSlW2vEPnv/7DXlwRGRJAxdIiZdiQUk7G6Gep0VRP9oPPNS
 PnjAjR7IiLRd6Wc9GRE0aHAFBg33CztGiZUbVGI4fft7WB+/XNAf1JS7EWj4v/6QD1ho
 NR34ePguVbl1gjDynsDKTZ/iIpXIGoN/Ws0647sh0IKaAY5bnq9oS+opCjgaEgp29+l9
 8YBQ==
X-Gm-Message-State: APuU4Z96EZko8QxQhq23MNNSNQT0z/lNuLyg0qNUfRx9yKylZO3umKsQ
 o7sh1tZ0whPMvMGdzoXdG7t9fzqGtqXVGkB6/YxLPSNfvMMICmnwYACkgC3HQ1PUYWk=
X-Gm-Gg: AYBFou2Gi3lZBGJp6jn2kmeyKIiSluRliCWe4CNaJsg/vh0qbow/G5XRNKCJnjytmPu
 VdpwSR/VbuTFS6TeAy51lwVV9M4+5HOSp6C8PnbpntkKNz5Qkr0AuwDgOzXoLgyY8JnWIk5tGVa
 0lLg9/SaMHB3hobyIchlMQiP0a6sIgPiB3ADHb69CDPgaE2GcnkDGNRMgzvURa5TaKP6HekEWIO
 XqTUOE0ILbqF8+iv6sMiZYdhWIl7XxtX+m7UmfJ34VtxFfyRVDWZ6pKEWVlHiq9v7kiXQS09Aog
 uC1KKwr8AkS+t23QtaMiTZCmmSskyZRlscM5x5Y0tRnGd1BwSVH/m7XQwly4d+K/nj6RYnEiWli
 GmmhQ97eVtXsDJ/Uf5PEEoPh0spxwi+ZCQD2ZQ+JhTaxHsGcfjrGV6oDCkBFYBkvFTlxupGhJOO
 3Thy+ZFoUvl533DRygHEQ4rasD+V3DOt1me/PajkQ/yVeUE0j+D2pvlRCmadD05IgQ8An4pYKYy
 3KylalK9VZJ389EqBifEfLhRm8Yx1SDDQI7f5xfbFaGZb9Jv6w6zBb81au9Yd/57VIM4BZoGvZT
 f1nBmC5MLNQUPsciKkMs6C5wpx1LK2xZkz/OKvueQMrm9RDPhZDLxGHz1oSQ+LTQWq01BU8yuv7
 A/WVVfDSuEDiiN27lF6QUqUaRrJPWiXo5g64AAT7QgoZbJGj6nB0Bm/D8hTZ6X2jGtew1DsWG+S
 F2YuF3qUFyBDBgDfY2iyNeAHSpu2JeFLg=
X-Received: by 2002:a05:6808:e90:b0:4f3:e98f:fa19 with SMTP id
 5614622812f47-57a0c4b90eamr4207904b6e.61.1795189261511; 
 Fri, 20 Nov 2026 07:41:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm2603114b6e.3.2026.11.20.07.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:41:01 -0800 (PST)
Date: Fri, 20 Nov 2026 09:40:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.u-boot-project.org, alpernebiyasak@gmail.com,
 philippe.reynes@softathome.com
Subject: Re: [PATCH] binman: pre_load: add sign-size parameter for partial
 image signing
Message-ID: <20261120154058.GD3176972@bill-the-cat>
References: <20261120153626.51467-1-paul.henrys_ext@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9iHtste+4bD5ZppQ"
Content-Disposition: inline
In-Reply-To: <20261120153626.51467-1-paul.henrys_ext@softathome.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--9iHtste+4bD5ZppQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 04:36:26PM +0100, Paul HENRYS wrote:
> Add an optional sign-size property to the pre-load entry type, allowing
> users to sign only a leading portion of the image rather than the whole
> thing. When set, only the first sign-size bytes are hashed and the
> image_size field in the pre-load header is set accordingly.
>=20
> This modification is particularly useful when signing FIT images whose
> data are stored externally to the FIT and hashes are already
> calculated and stored in the FIT header.
>=20
> Assisted-by: Claude Sonnet 4.6

Our AI policy is currently "Please don't", and I do owe and have been
half drafting a longer write-up on that.

> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/binman/etype/pre_load.py                | 46 ++++++++++++++++---
>  tools/binman/ftest.py                         | 41 +++++++++++++++++
>  .../pre_load_ecdsa_sign_size_too_large.dts    | 23 ++++++++++
>  .../pre_load_rsa_sign_size_too_large.dts      | 23 ++++++++++
>  .../test/security/pre_load_sign_size.dts      | 23 ++++++++++
>  5 files changed, 150 insertions(+), 6 deletions(-)
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_sign_size_t=
oo_large.dts
>  create mode 100644 tools/binman/test/security/pre_load_rsa_sign_size_too=
_large.dts
>  create mode 100644 tools/binman/test/security/pre_load_sign_size.dts
>=20
> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load=
=2Epy
> index 7890c1c62a8..3612307d4ab 100644
> --- a/tools/binman/etype/pre_load.py
> +++ b/tools/binman/etype/pre_load.py
> @@ -53,6 +53,11 @@ class Entry_pre_load(Entry_collection):
>          - key-name: Filename of the private key to sign
>          - header-size: Total size of the header
>          - version: Version of the header
> +        - sign-size: Number of bytes of the image to sign (default: sign=
 the
> +          entire image). When set, only the first sign-size bytes are ha=
shed
> +          and the header image_size field is set to this value. This all=
ows
> +          the runtime verifier to authenticate a leading portion of the =
image
> +          while ignoring any trailing data.

Why does this comment need to be almost 5x as long as all of the others
for this function? Thanks.

--=20
Tom

--9iHtste+4bD5ZppQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawBqBgAKCRAr4qD1Cr/k
CparAQC8W1OGYwBsdH9L4p8hmHBo78KI+NY7LVdqQU/h7Lpi2gEAquWPrbAAPfz/
XQxlrJS0kAgcylrkLxCPyGPN45KSjgI=
=oCDW
-----END PGP SIGNATURE-----

--9iHtste+4bD5ZppQ--
