Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06752D1CA0E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 00:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B7988E7B;
	Tue,  5 Nov 2024 01:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hWiOjnPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B589988ECC; Tue,  5 Nov 2024 01:13:11 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3869088DC7
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 01:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b153047b29so318691685a.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 16:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730765588; x=1731370388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j9yL78W7TEeumkLMNrm/grLmgvU0VALK1LHOWTqFyb0=;
 b=hWiOjnPKcUUz2B96XaQk4Wl5J9fIkh7IJujr9xib5VNHi7Z1FozfNuDCv5kkjgzKhM
 QBz+hQh4etbfMOdy6mnSvMWU/zdfltVJJXuhy2vb2NnNnACOwKQCCwU2BoEPPTFAVR2S
 BGGRYYm1u9zc+oREcAIQgNOFhH9kFXJVWQMIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730765588; x=1731370388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9yL78W7TEeumkLMNrm/grLmgvU0VALK1LHOWTqFyb0=;
 b=PXXDX1eVT6rdqGs+fx7vvhTAw5AhJY+UJ1QE0nWMK3zHfjWay0U07AZ9jezT+KqMdg
 mWMV2Y+K5ylEis6wldcqrPIXDXb2wQi0BAQ7G4d/ZfBminKUVP9UX8DjvYiZqRSC3eYG
 8UYAOkEwboDEP3+dp8INKAePysTe/VvcwOSPbwYt0OiQCLHWYU2VioLehX3vYpwWZxeo
 sUlHom5WWsD0vtlRyIqX56eO73TG+N4ixpR450CPsUbUSMZGT/vA8ktdTVVqD3yL49Mm
 6IEldWW19n6QE0X+iqDmVInUKPS6aIMeaBPlr0UCf9BgYckzgNlMYDtugJVo+LsjiOUJ
 kVfg==
X-Gm-Message-State: AOJu0YzE3m2YTGdz5txlEIAte+LFwVMgkt+Wtpg1m+S3C19ELyU9vkQE
 w4T9JC0X6/uoUoodAPFNEukqlE9O9Ewcyx/XKsC/KGLsTKWjYh3XZorStavGU+U=
X-Google-Smtp-Source: AGHT+IGTG0PwFEWIz8wa9RGrAU63vZ5v/NBEuenGjxETrBWyqog9zWvmfM6Ck7nCmnEyo73xtW4zWA==
X-Received: by 2002:a05:6214:498f:b0:6d3:5ca6:b3f6 with SMTP id
 6a1803df08f44-6d35ca6b434mr193928036d6.45.1730765587786; 
 Mon, 04 Nov 2024 16:13:07 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcaf1csm53988056d6.47.2024.11.04.16.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 16:13:07 -0800 (PST)
Date: Mon, 4 Nov 2024 18:13:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v8 10/11] test: Support testing with two board-builds
Message-ID: <20241105001304.GB3600562@bill-the-cat>
References: <20241104224550.677442-1-sjg@chromium.org>
 <20241104224550.677442-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="65xW/Yr8o6+UDMFi"
Content-Disposition: inline
In-Reply-To: <20241104224550.677442-11-sjg@chromium.org>
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


--65xW/Yr8o6+UDMFi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 03:45:37PM -0700, Simon Glass wrote:

> The Beagleplay board uses two entirely separate builds to produce an
> image, rather than using an SPL build for this purpose.

You forgot to reword this :)

--=20
Tom

--65xW/Yr8o6+UDMFi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpYwUACgkQFHw5/5Y0
tyxQ9wv+O1w5KsUBxP6Ds10CqTfSDMbXAi9Ju7IvZ/DrzBDlrlhhkrDwITxU6J3i
bfhcROMnZUhSqcXeEvMV2fFVYPcL3jJsaQVGr/ulbYSBfaVVKqYJtpNnUuL0uW45
SJFIsNMXv163jBkirckjnV5oWnGDiGoLmPa8MjkiNFJ1IS+GL+dngQklwXV9i2CZ
l8ZmKDHxAl12oJB+esfh5gVZOgxo5+IQWPEB8WqF0p0OlEOPwPyJUBXeFRIkhTIv
HhyEzHjxZTn4qJ/c0J/SOWxpIjB+GpMAluDLvFYJQHvMjWd3ynPo90+AVcCAtZFn
GY/A7kt7NBb+2tKumeL3Ck/zNKcvSc9DbWIvuK0eA2bvLzpqO/yBASmH6TEXRwwA
sbwhwhrksOR0VODZ7B+OHxMl0O5WiI99vtgqtpmsXDQ5ZFcVGVJrxsA/BAlGwi0Z
ebu+g9igTvgT39wEuF+0scEk93mVNB/okTzDte/doDsgeOntKuddiabpsJHc5tww
bxvrnqbP
=6yGa
-----END PGP SIGNATURE-----

--65xW/Yr8o6+UDMFi--
