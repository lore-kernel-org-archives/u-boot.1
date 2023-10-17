Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDA2CDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 13:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE3986D9C;
	Tue, 17 Oct 2023 15:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JdlLmb0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C7A86EE0; Tue, 17 Oct 2023 15:35:49 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA80D86BB4
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 15:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7af45084eso72810857b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697549746; x=1698154546; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WA1/bjXXqD2JT1SWdLFiy/zmCK+H45KUM77SH7aVVPg=;
 b=JdlLmb0xyjpyARi3y4+dwZFoRCKVDHg7S3ZwSKndn/Aipbfc3X0G/jtQD5vPqcg0us
 4GgTMpsZHiwv0UYauJj70lAaA5usJtqpdupsEOraoksa5huIuprdL02lIH/mJR0k0pXo
 +uiBjcJBqE2nSaQZ/PHpZa1FrPNQGSUI2svJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697549746; x=1698154546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WA1/bjXXqD2JT1SWdLFiy/zmCK+H45KUM77SH7aVVPg=;
 b=XwXRYAVjarv2W77z1ZTriY18NgmnPwFf1HUHypYl3zaKQVX3rPpzYFaaNWxHLI2VPo
 KD7iW/uoQDZgtTi6O7B47PcVbMQAll+fzu0bx+bJ7inHqSqYbM+OVclpQaX0xhE6fwEa
 SI+YPWko0fuN3MsU7teWhNpnERtbizNSUGIMI+mHP9w9Cnbxz5+vxltguZSHuZTEk3fC
 KpZMk4Nm0s6TnNliSMHEEE+UJb+EcxVBWfhCEPA5k4ZDPwHo0Y4MMzKS3BobeGUd4bOC
 o3B1ior9Edug3tsslZgigOaTRdRMdCtyQ/7Nwa2jV5fF0YpIG6/USTsN5w6pmCAulG4u
 XT6Q==
X-Gm-Message-State: AOJu0Yw/8PN2DdmyYU1jIgZXCWgBX/k+I2aMQuVx8AuXDivrhx3SX1mh
 OQXpu53/MrMZSzjLNFiDGz/FE7z40WlMiHCKwYLNfg==
X-Google-Smtp-Source: AGHT+IFp9Q4LFrT/OUhOSF5b+mZLfR+omI/HSxxk0a9Crv4/XjV2Rz0Drngjfp+nhPzYJLE+4HbiWg==
X-Received: by 2002:a05:690c:f0b:b0:579:f5c2:b16e with SMTP id
 dc11-20020a05690c0f0b00b00579f5c2b16emr3370907ywb.31.1697549746463; 
 Tue, 17 Oct 2023 06:35:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 g145-20020a0ddd97000000b00579e5c4982fsm621456ywe.36.2023.10.17.06.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:35:46 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:35:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 09/32] cmd: Use an #ifdef around run_commandf()
Message-ID: <20231017133544.GU3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bK1tXdJEoDjK+RE/"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-10-sjg@chromium.org>
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


--bK1tXdJEoDjK+RE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:00PM -0600, Simon Glass wrote:

> This is not available if CMDLINE is disabled, so add an #ifdef to correct
> this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  common/cli.c | 2 ++
>  1 file changed, 2 insertions(+)

NAK, please tease this file apart in to CMDLINE code, and whatever
inadvertent utility code is also in there.

--=20
Tom

--bK1tXdJEoDjK+RE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUujbAACgkQFHw5/5Y0
tyyVGAv/TAMYsgPaRgQGXSVZUO8ikyIXopauYFBjawCjUjXhM8gjGHKDHZqjxopp
AVcwPDa+VzzBOY7HPmSuPdfYJJGFiwjk3c9bpYlCmveZOI8lk4sbmuWRHQQopwUa
M3xvOgqkaHP535l1ryarQlfdyFAiMBfd9N/D1sBDO/wTqPVvdLO9InWHB2kdfhlV
UTnGpFRxILBg1jxVAjPPPOWjYuoVXpzVP3WgCorLjY9EAc/9rNjT2nzBsbWOPTMI
WpApsDN3AmHWrSBsE7LIUFzt72zhkzJ7q58lKTksvAEYNvyEjtsimQpwWhEbj1lv
/32c7D/T1YcDgoo1iuco4g3Wrhhtxg4lVm/YXnNWVas4mdZfnBGuJbSXxzK86opR
oD+ja3NnAq9o0sqFi5HJcqPWpdFwdDhkWwbVXGxaUC9o2VteEzGhMCyR983czJuY
guVZlf6sm7RfWgirjfji2P2feAdNoCrnZWoi7hKozhpxdhSUaoc+j+dO60Cdo/95
ZLkdSV6U
=t+Uy
-----END PGP SIGNATURE-----

--bK1tXdJEoDjK+RE/--
