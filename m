Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F6FC25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B45B87A2B;
	Wed, 25 Oct 2023 01:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AegvDl16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD3887994; Wed, 25 Oct 2023 01:17:19 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B48887A0F
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a8ada42c2aso50486567b3.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189419; x=1698794219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X7msGxbTjEu4Mvk+ENjtjPyIG1FpCoMfBqjoCa95MsM=;
 b=AegvDl16ycG1EqY9Nusl3mKmurYKcrFEvV37JHQa8xQz1MNbCztx6pUSbB7yLb0xZV
 1k/A7vHbbyR+F89rVB1TADLy20vR2noKg0xCrkWj+7g8s3p3eezGkJzOCHNw7AStH/rH
 r8hG3n5xLvQlvkZTI2+Bc9Ca+nx+pfFt2zSo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189419; x=1698794219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7msGxbTjEu4Mvk+ENjtjPyIG1FpCoMfBqjoCa95MsM=;
 b=UJfIm1X3vNHR8LmXydAWMltaGWqprHvUAzOmUqOEuBbVyDCi4Cg3Wozj7QoFYtG7IR
 eVVXPy3jEExNe/Gk6mhm5CdXi37U6+U0MIz/6XrNPNyfKKkXDi+akRC7Pta8mAMcXzfD
 WMDbRoJenS8epexIztdI56C/zafycE6mrOqKcj3762MfCGWhtpyCjFFVL1oLrJHxXGwu
 WmdHNVLcR5lditP2b2bJ23nwOSH2M2xLFDxpIBU7DAfC55CEhaRc/LiEko1gcpNI2B2q
 oYfqfgl5XEFeDoUgFBgSPUtZ9Aw2mzJfZoeQI81mFSa7bNNXH3WWXm1Gjw34UdaNSCge
 BpXQ==
X-Gm-Message-State: AOJu0YwVSF98R6w/FDBBF1cKW9mqofj4MfysDUDGZUaZptCNnr2vVD33
 0UiYCBrd4wZopg+5JHdR/crEUA==
X-Google-Smtp-Source: AGHT+IFXSWRHdtVURXzRbySteiARdgPniiBLRsy8UloWzAR7hIFDati8W9yPzXOp/bVvP1qXRE7nzA==
X-Received: by 2002:a0d:ea8d:0:b0:5a7:a989:b85c with SMTP id
 t135-20020a0dea8d000000b005a7a989b85cmr14301299ywe.16.1698189419231; 
 Tue, 24 Oct 2023 16:16:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 x188-20020a0deec5000000b005a815346d95sm4464422ywe.71.2023.10.24.16.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:58 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Michal Suchanek <msuchanek@suse.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 1/2] serial: serial-uclass.c: move definition of
 _serial_flush up a bit
Message-ID: <20231024231657.GD496310@bill-the-cat>
References: <20231016083522.945453-1-rasmus.villemoes@prevas.dk>
 <20231016083522.945453-2-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lmToAKr8cgwYBlnj"
Content-Disposition: inline
In-Reply-To: <20231016083522.945453-2-rasmus.villemoes@prevas.dk>
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


--lmToAKr8cgwYBlnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 10:35:21AM +0200, Rasmus Villemoes wrote:

> Preparation for next patch.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Applied to u-boot/master, thanks!

--=20
Tom

--lmToAKr8cgwYBlnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UGgACgkQFHw5/5Y0
tyyd2gwAk42df23p9V7H/IaEb4TOUlDtOrUTdWCzZjFKDyvc05VwSedog4TAHu4w
xl3It4Mqymm5UWi/SGqw4PZsYljys4dHVWpyjeEqjlzHIJyKvmb8jtN1acOoDFtv
t6TxvHFLG/Cj0yFUVYI87nF/OS9OOnPUYl0W7fvtbrdIAYvBQxQ9OehtitNiWEP9
hSBF7NxzO9yNRsYtmv5c2WUKrbBdTYsCjSxKec4cJ/Imm1HknC1AFK2rkJ+cWy/a
n4o4WAlhwy4ns06Ar04x9mXFLiR3QVQwCcb1NiU+Xq3kJyZLWmDa9eO6SqCvo5M/
QfYxnFg5x7iAJYmBG/DSQYCtAEoYEWG9+NWfdq8bf9IzFiHgTr8VlUvhOJqb8OCk
hZJrn7hu16eWTqVRAhn5IsXfJWMPxhVyFadtb3HlNfowDYCuBvS11/bm+aeIQmma
2/QHIhY9Epbm06uJz2rdZID2tKdJGamqt0L4q4X7GjcUlBWLNxdMaFEoxtur9Fed
xGd3y2T9
=g6W0
-----END PGP SIGNATURE-----

--lmToAKr8cgwYBlnj--
