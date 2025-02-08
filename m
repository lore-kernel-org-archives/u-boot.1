Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEB0C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1095580805;
	Sat,  8 Feb 2025 22:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FliNtvjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962A380821; Sat,  8 Feb 2025 22:43:27 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DE5807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f74b78df93so27509707b3.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739051004; x=1739655804; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=beAGWfeoYjeiKr5TozkTvKgM/wq+inJmpspAiO9rbas=;
 b=FliNtvjZ8JYN8qeTmNUMGrTgksDE5QAcKGwtPMPfwMLgfAynIXxAn0IgKM0KtKkPfl
 qvQ1GTvioUxqTzf/xA8PseU07QVPV0UfmseJ1LmNpBjn6G0arnFEKcNquZMOPv9531/r
 +iUw01f9qRS2nhZs7jiNXCqEQ8VKVaHc3QjV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739051004; x=1739655804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beAGWfeoYjeiKr5TozkTvKgM/wq+inJmpspAiO9rbas=;
 b=Z+l31MLiYwAAKgGbszyCO4ojx9FCbFdz8jybop0Q/6XEqF4n87jqaZ9HwdRKd9j7SI
 wKVmvaTnkysAsBOjwtu0WcdsZLwBYKLVKFZoY3ZFjHJ4lslBUilciS338JLz3DY2wX4J
 Gvyik1JIKgs+1/psW1Cab1Vtcnxt8zCWQkjSNcGmO/2EnVDJybaUkMBU9DNlUC0sbGce
 bSagvfvI1FJEtt29D7T8fL4jm5KFJX2qIyjTKKiAo1CnTxJuy/s6FR53fJN18NWM9mCc
 G0ft3mv6wZmLySJEE4bZFeNka11Qm9uzOjA4/zku/BfuwX9iWmQnPaZwr5EAK/4B2j6g
 JmHw==
X-Gm-Message-State: AOJu0YzY+UPWGj/13KyCAqPxf4MDBr7TrgpsdqlQ+ZVH73wODpMK9/9t
 XYkYkXG2ajoaFH5+UEzneg840IEe0Y/9AYZHpDS1U6Qu3TvxS8HnJ9s/DIevwrY=
X-Gm-Gg: ASbGncsOjSCFH4a5V5WKxFiliYJQUyMC6YyfpkK6kwpJDqEcbkTeU3/Q3OcgMKhjujY
 4mqULoN16aT7v+V+GrWPF7u201YeK926BQDrcHwfR+dRVuzgUo/TFxZYicniw+xdiOPeqKlnd0w
 IZyjuCK0nRQ8fcETmofU9YTenhcpgZ1ga/dIZ7cRDx5/e2fqpuFN/zQOCVR2YKOK/oySZ7BJiWl
 7bcjf9vTz0vPS3bHvK6sTOJOLqNd2Pz7u4aVKrsccWS/Ht0D3rCPfuhr94MxSeex+6VTaSWmzle
 JnStY44zKQcWmaA=
X-Google-Smtp-Source: AGHT+IHWR8bn9/dluGB6blVJfAcZyL4A91OSrA//4ciOfXCqV4a4n2VdrmSBAt86lKyDS4AwwtkfOQ==
X-Received: by 2002:a05:690c:7207:b0:6f9:4212:bea2 with SMTP id
 00721157ae682-6f9b2879a3amr73264537b3.15.1739051004230; 
 Sat, 08 Feb 2025 13:43:24 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a605sm10136007b3.80.2025.02.08.13.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 13:43:22 -0800 (PST)
Date: Sat, 8 Feb 2025 15:43:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2 26/29] efi: arm: Disable STATIC_RELA for the EFI app
Message-ID: <20250208214319.GI1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-27-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="foiyys5S8c6lCmMf"
Content-Disposition: inline
In-Reply-To: <20250208171154.1305761-27-sjg@chromium.org>
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


--foiyys5S8c6lCmMf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 10:11:46AM -0700, Simon Glass wrote:

> This feature should not be used with the app, since we don't know where
> U-Boot will be loaded. Disable it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--foiyys5S8c6lCmMf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmenz/cACgkQFHw5/5Y0
tyz2xAv+N1XRJ/HUkgXvdIWIx/WM91ojggaBeyQ93a88Lg2SUb7/9pD0oqaQFK+V
1AtRMJzLMkZAtgq8yVVU1NhY5B+SUEqPn+bIbrvFgAXF+AGNyhlliaNdrT9PptUM
kjvBVq4R/9zPjFjL82487q+3ip+GilulD6n0RIl08pCjOCN/LbByctubPHTn8Nr/
SHDmE1YIItQMqxQC2JgVyZoJq18G19kMWP4X8onDunV7wPh7ce6U5+cLF+SFt9Yf
VV3Ue2qXG0EwjesVCrHnewqN7FnAE0Al1Z3UvzrryrkFinjkPEthJNu1yQHWpnt8
D1RHTmLHpisOcaF/tNDQw3Ia4+JYaychMK9Qu+4UBfTYj2gjd8lESukdaZv7t44J
BfOi5cEZw8ezMF71fDWkidvB1uLPPodjIZBZsFn117kteO0/Ww0B4hyYHnH7VMVR
osMZl8MkmX6ejhz5JlKyOy+RovZ4cojad2dSesH9qV6QvGnljr1GBnGYIuDzp4CC
whnZBMNR
=7Lgg
-----END PGP SIGNATURE-----

--foiyys5S8c6lCmMf--
