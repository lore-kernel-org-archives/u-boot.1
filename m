Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9BAC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8CEF87B37;
	Thu, 14 Dec 2023 18:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZczNw9qt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0927D87A92; Thu, 14 Dec 2023 18:51:37 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96BB87B22
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5d33574f64eso84693937b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576293; x=1703181093; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5i9StxwS115ukC9GXdxIdcvAZXtIS0PGEu+hbdF0VI=;
 b=ZczNw9qt9G+xCfhGo+WY0N2pPJFndNDlWDvCvlBkMwpATDdkUws+9RqQ5dDbn1mqh8
 a5rk/oULdvgAR6Kgiz4Py1h6w3jXNYj4sbADUTh+pnmlzB+AKBE63hAoNG258brQ7kbQ
 kCFChQvkIlhe0zzdHvZmw+PNrhUz9W5MYkDog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576293; x=1703181093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5i9StxwS115ukC9GXdxIdcvAZXtIS0PGEu+hbdF0VI=;
 b=h2lyYGhvpvoAT3w9+Tc/y3zkAL7Di6RlvrM7TLukBSxBgyw/D9WXUBPCNG15Lp8d3Z
 S95nOpoQf1gz57BWTaIYKxrTv/IDcUSyWTaASa5rEVurCAZ2F8HXD8bNU4GQoVx06Mcz
 qyBUpH3hGgL/0bBCUm5HMVy9PDuYRVbiJ3A9NFKf7eU3aHtLKSVrBicvNOtL87/Nht5r
 6xGMrRXx4aFP6uYGOpu/1QjOS3GI3kN01UEuFirurTT8o11Xo7Vvf81bUJTnlLUmhnGF
 t9ob9ueXEYkl1ubQTsdvaDSlu9BkSVtKs3+oL8K1jUpCCOhEXuVy6gIEmIfKU8GxctLB
 AfWw==
X-Gm-Message-State: AOJu0YxxPqJTaAY6VdH7/AU7wOcw19Iy0npO4Tnrg6Wwek5oYYldek3H
 Nj9iXZhl1ShtdyvLZ0M3ZcHmPQ==
X-Google-Smtp-Source: AGHT+IGHvbyKIx9gLYewgUfIMIq3oPCsczwSyRst/8Lfn5KftrFK7XTIv4S8TjbBXkj6Mwo3Nk/7Ig==
X-Received: by 2002:a0d:ddcc:0:b0:5e3:7f02:275e with SMTP id
 g195-20020a0dddcc000000b005e37f02275emr1367509ywe.11.1702576292014; 
 Thu, 14 Dec 2023 09:51:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 p206-20020a0de6d7000000b005e3f63083a1sm266000ywe.97.2023.12.14.09.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:31 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 14/21] bootm: Drop arguments from do_bootm_states()
Message-ID: <20231214175129.GH2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BfbfqF5a0OdqFVpa"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-10-sjg@chromium.org>
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


--BfbfqF5a0OdqFVpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:23AM -0700, Simon Glass wrote:

> Use the bootm_info struct to hold the information required by bootm.
>=20
> Now that none of the functions called from do_bootm_states() needs an
> argv[] list, change the arguments of do_bootm_states() as well. Take
> care to use the same value for boot_progress even though it is a little
> inconsistent.
>=20
> For booti make sure it only uses argv[] and argc at the top of the
> function, so we can eventually refactor to remove these parameters.
>=20
> With bootm, some OSes need access to the arguments provided to the
> command, so set these up in the bootm_info struct, for bootm only.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BfbfqF5a0OdqFVpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QKEACgkQFHw5/5Y0
tywVJQwAnzCemX/98trsrHF+2vDojCrLLgLddDcbWUGVvDNwBJmR83wCHN2nN2Nm
PqV3yZdUYPxU/peV2bHG3ctpbAIlKFyFs69Kp1zk756nxXvyOfryFW5G99mHHFfV
cKiOoxegySg7M16UsW+DIxsrDQqg83o25XjHcJxqY2NQhlPieIdVqoWokTfzajt9
UlX8HR7MVn87nrUDgxk3aOfEi1kPpoedOHBD7VjCAOS8cXL7lYPovuSEfKqvQL8N
DvNMuO8GRLdiaQvzH01v8mRYJrgvDG1aYp+N2sNmbU5cpmTmJXgi91kV5LsWKVm5
7W2Q+7KEQVsorcRtgLPIjbMj5lsF/+YDEfUCJa0awac4oMG9uW5OuAYgkr8jgKK3
II0v35J3SqawxolNWURgE1uUUwVgEJ2Yq9cWASza8AwLyxeGMYUeDo1YUfU+nscb
TeNyhp8CvfZejVLkisIJoeqzDSZocE6RyJ3ma6yiJdpjbwxpPi2chRcho37RmVG7
av/iiBJL
=StrB
-----END PGP SIGNATURE-----

--BfbfqF5a0OdqFVpa--
