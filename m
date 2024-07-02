Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20497C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 17:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C100886A0;
	Tue,  2 Jul 2024 19:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mo8rJQOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399FE886A4; Tue,  2 Jul 2024 19:46:50 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BC98836C
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 19:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-700cd43564eso2221395a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719942407; x=1720547207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bOKz7Jti5jv7GLCdx2Rfy9t/FcPSGjcOCN6qZMuRUiE=;
 b=mo8rJQOJc/0jlxkhMUIpiLl3tlyUkdaCIvbG+/9zQ1wwbREL3n+x4SmXj14m/Rw48b
 BW5OP0Fe+EuRi3QGOzWVzx4pX1xUSkIV36uNehmtnFQrGnmyT0VDBpHWhqB2vbTgapBm
 1KmAVP861g1RwcvyIVuWLJWvjClo1dOcSp35A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719942407; x=1720547207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOKz7Jti5jv7GLCdx2Rfy9t/FcPSGjcOCN6qZMuRUiE=;
 b=AXclS8rw+2rV1dYA0heSMoDmo6/TEoNgnCuwF0Xb+zFcco7gpeChJob2JFohc0jNBL
 KZaVrtdRNOL3Cw2tGmt+ZCxuPE/0nH3Vqcd6idAgQdZydt2qu3fMGPiE89udRRccd/kQ
 Y9xcfpZsOUH+0NytwjK+SPhY2WFE4tZAHP5aALzti69mJ4EsAKOeyHQ5PSc9YH0SDOCh
 k2X152cp7m5ktszQ4A0sR/GjFJe3K44DbyqUSzxwIZVtoZAHTEs+y95MNbeNwsmrTuF3
 caUiLjofh3RA2atiy+3s4s0mq+72Wq8wAIi/SGxsbqjSueL054hOub6xW9YgIGClYQTB
 ilQg==
X-Gm-Message-State: AOJu0YwkJ58e7mJTJLuK9mvQwiZAHjhkofWysdtKPhG6dKEu7f/03o84
 4uYDDy8alDU0HQTKnpDHDNbk8Xe6RuLpy5ZJPGaZR+GSbjgGccW2oG1jytWXjMo=
X-Google-Smtp-Source: AGHT+IF5NGm/UBmyLvaedtcuOUthrUpUvFEQzPK5v/j84KPZ7YdxYXD5O7ZxeRhREJuodbrTRjeo2w==
X-Received: by 2002:a05:6870:1609:b0:259:89a5:440d with SMTP id
 586e51a60fabf-25db347d081mr8019570fac.15.1719942406618; 
 Tue, 02 Jul 2024 10:46:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-45.totalplay.net.
 [189.203.106.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e33b73esm2303498fac.37.2024.07.02.10.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 10:46:46 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:46:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH v2] binman: Update cbfstool
Message-ID: <20240702174643.GP38804@bill-the-cat>
References: <20240702163729.2674096-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gyB25Nke171M7vBi"
Content-Disposition: inline
In-Reply-To: <20240702163729.2674096-1-sjg@chromium.org>
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


--gyB25Nke171M7vBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 05:37:28PM +0100, Simon Glass wrote:

> Update to a newer version of this tool, 4.22.01. This runs OK with the
> current binman tests and matches the one in CI.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gyB25Nke171M7vBi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaEPP8ACgkQFHw5/5Y0
tywIlwv9EFD4IVgR9W0Bln7GI19sluDYkVaOfWl3wj7BrFs6YTwdUftltn+c1tvQ
u2LmhjEss1mDijOq1f+IuTfAPFzGFueCNk13Q+LP9L3q1tSsEAvT4jjQEYoiqZd1
sGb1ws24sxGRL4Sfs6WaLyfD8znc1ZNrtAQaUARsl8sbd4URoQwuurFXG18IkLzY
QclSLbXBTygXYyMDQRt/fVj7q2pQoEogmSYDjAv18br6eoviXO/Hmx9WrFaUzlaN
aSEhKyx98MbcFcKQP1+CK/pPsBESVMVAwoPfQccdgJ0SGfGnYtA40F7gsb360SiU
lRyawR+ma/Zy9UuByRo+2PzJm3s2yYjuVbVugNLuJdV5yHJkUPJjEey5PRzHkq/R
CCPFB6FfLneNUZm7qbzNSncdOWggg4eKrmktmHNhmDSODk+ac4PiBsSHzGoh6wFQ
31zJwZhxovca4SMt4zSDZ2mgWn/fQXDrviMUqS2RrTpfrxcW/2sm+AHeEddd5xrv
ckeXeDdD
=xhY1
-----END PGP SIGNATURE-----

--gyB25Nke171M7vBi--
