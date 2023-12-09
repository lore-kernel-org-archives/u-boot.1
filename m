Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A07C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16F68744F;
	Sat,  9 Dec 2023 19:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OJERzMH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 566CD8753A; Sat,  9 Dec 2023 19:39:18 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B6A87215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5d7346442d4so29703067b3.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702147155; x=1702751955; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nQ+wOdrfdU+M6AyN2GkLvgCEa214/LZxITFihmjBzls=;
 b=OJERzMH6INgyd64edUv21kdPhwQOcpuEKFaQIiuj5AWWf2AS4pSH16OawIVRTH0Awc
 8B5eXza1I0e9QomibqVTUKtJ603ShiOt0mEOqfe+wiPXZEAaINu2X7WeTyN0dt9N3alR
 o4eoEx6yF7LES1tndn/m8xYDW/oKwQ2G+s6eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702147155; x=1702751955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQ+wOdrfdU+M6AyN2GkLvgCEa214/LZxITFihmjBzls=;
 b=spGA8IfjUAvE0W2wbhol6LOi+/RFnycxk0xfQTi1FHtL8Cpl3QdA4SBdMmTR/DK1g6
 wQOShl/0X4G/DCx361XHWCOwl59YkMl3ABJR+ITJJwvIfyEojxl5fiU4Ddu06LGDxaiC
 0zdmtLwNkaRywdlFzgGp4jLEZdLkJbaUfdUFsGVrLbO5Xyi1mPBC9ePYJ6Gc54vxyzBg
 R5SkO11Qou0+P7sWxElLEtgqAjQJ0xtz2WnrPDwsTp/kmmsZGIkus1hHJsPmAqKqLM1P
 aTPYLwRagPTIKLCGSagGYYzAK7wOzdhsPZ153/9ty16zBM1DUdRSn2MS/I3z7/fYYS+c
 9X9A==
X-Gm-Message-State: AOJu0Yzg4sHt04my0HK5a5OjMbokHMUNSpO/NpZzJG0+Q2Mg1U6okH11
 7PZV/SkvO+6h/ckVGdACxM39tw==
X-Google-Smtp-Source: AGHT+IFSpKW+59ffx7wlWXgebmprpEQ+QdPnp6DPEeSuz5vYIkbCU/Wuxu2Pjepcdttcm2ksSMYRMw==
X-Received: by 2002:a81:8642:0:b0:5d7:1941:3556 with SMTP id
 w63-20020a818642000000b005d719413556mr1382561ywf.61.1702147154850; 
 Sat, 09 Dec 2023 10:39:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 q130-20020a815c88000000b00582b239674esm1643196ywb.129.2023.12.09.10.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:39:14 -0800 (PST)
Date: Sat, 9 Dec 2023 13:39:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 01/14] boot: Reorder FIT and BOOTSTD to be first
Message-ID: <20231209183912.GT2513409@bill-the-cat>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tn6MF6/K31tecaop"
Content-Disposition: inline
In-Reply-To: <20231204003144.899097-2-sjg@chromium.org>
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


--Tn6MF6/K31tecaop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:31:25PM -0700, Simon Glass wrote:

> The boot menu shows Android first and then a timestamp option. Move
> these later since they are less commonly used.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/Kconfig | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Meh? Maybe this should be alphabetical instead, and some menu's added as
needed.

--=20
Tom

--Tn6MF6/K31tecaop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0tEcACgkQFHw5/5Y0
tyx4zAwAjt4OyqNr2jtUhsuKFTKgDkVylELtqaQfmjdjdqDW8+RXs8mbOHJkEdGP
rLQMJ/wk4dWNzkWH/SJWEHFpSIbLF0Ip0qSkDa8RpfQP9HDHChyWuzqNJct+GoWz
DFfQbbTcXw2ImHkGsAD7U7zhYE3XXALrYWSnHOK4aYFCVcL+tg4x60p//jajX4yU
uKrN8rbj76owv5CAMwdzRt7jawXRoDcW9PWZAqQ7vo1LeJiOMYobUGyYKKHKF+ch
EWfxYDrckKcl8Cudn+PL0hFMz/TDL4drSSgCsFEMbMCodmPvA9lOJk0w9wW8a+6p
YWYKm76EMLOwIWUs2nk7E/SwVJhTde9LUpcWUFASnRH6pPfApvgtcDmG89zEObBb
sclj/bJqsauh8/yGCTOVju5Yxw/8vdpuuXAkxseLeUREF5OhCQGw2B2IOcR3CHBg
8Sp3AzgojHi7akuoanjKxQyUUEtq02/2jU58yeYKOGvTs2XyyBAAKClW33UqYaI0
rDv5wlo+
=Utur
-----END PGP SIGNATURE-----

--Tn6MF6/K31tecaop--
