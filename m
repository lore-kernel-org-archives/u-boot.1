Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD603C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E9688867;
	Wed, 12 Jun 2024 18:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X2UGs61E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866FD88867; Wed, 12 Jun 2024 18:02:42 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72B8883F5
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5b96b249d56so560734eaf.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208158; x=1718812958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RwZ7bOTnYwDLrx1N13vjTjQ0prMHtIsJUBe9KpXvEAY=;
 b=X2UGs61Eny2gzM7Zci6N6x8hkSpfiCaKe/3wiYIvTbHyUXIQBWtfN9R90b1WpLpCv3
 7cVad0RgLACyC9O3rZzEzq6SerthqJE4RBaFK1xsgUZf2t5EBbMqMxuApbhA+NEZcOXs
 a0FEIMag7Zoai3czf+xag0CBJKU+X7NTZjbzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208158; x=1718812958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwZ7bOTnYwDLrx1N13vjTjQ0prMHtIsJUBe9KpXvEAY=;
 b=bHs7FxQGcR+dtz7FVdFmwM0ZADWpAWyyjovKkt9cZg95WDAXWATp3hNHTdS5bi1PAp
 i2Y1lu312eRwtxrr0+zUTenW9wLnubYKmPoQeowKGan3A2HjUYqfERaXNkSTCDu0GHlt
 /oMXrF/7cK9lfnLHzYiIX+jx81wn3TL2nm+zD6JcFnEGO38CVxn2cTOS6jCCm3mAijCD
 k3FIhswa/QaxwojeCFQJOzIdMdIGPJQQ06AmTIM++3okxPeqaucW46rdEX0eoRSdCReo
 DjmwfJZsP1mwCMuvST+a4ZJ+yPOXLDg2JS9C8QQHUzHY2DIKaA+3pcfWjsQZKwnc75ui
 eDfQ==
X-Gm-Message-State: AOJu0YwntjYNgr+SYPECr7Drptha+AoPTQyDXriHyrJEF8IGm8Tn192b
 /mpLw1XDESB4BAtsc0rRFFt7ugzsS9COUUQLr0YvvdSACjD9PNPNCANVWmSHQJDtLz5JJful/iW
 cecc=
X-Google-Smtp-Source: AGHT+IEcetkOlPB50QWkDNkkZUexptXrU7kYzTO8TN+IWWX+eAFBGQZniyv1Jc1xqEAedHeXVFOXpA==
X-Received: by 2002:a05:6871:7a6:b0:24f:d9e5:b208 with SMTP id
 586e51a60fabf-2552b1b1af5mr54735fac.6.1718208158285; 
 Wed, 12 Jun 2024 09:02:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254ab072356sm2041395fac.53.2024.06.12.09.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:02:37 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:02:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks PATCH 1/4] qemu-vexpress*: Pass -audio none
Message-ID: <20240612160236.GW68077@bill-the-cat>
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
 <20240611210025.798978-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EwwV/HhBpogCW5yG"
Content-Disposition: inline
In-Reply-To: <20240611210025.798978-2-jiaxun.yang@flygoat.com>
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


--EwwV/HhBpogCW5yG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:00:22PM +0100, Jiaxun Yang wrote:

> Those boards have build in sound card which cause
> problems on CI runner.
>=20
> Pass -audio none to disable sound card backends.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--EwwV/HhBpogCW5yG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxpwACgkQFHw5/5Y0
tyxRSQwAtzXnr7+Kbn8qsqhU4j00LniWD8OkEZz9H3qkkTNO+eW7SUO+3deIzHHt
NCI5KAfuSJD0VvCiPhVhpjZpYOLPWgrVYroskkBXkV4PPeVXOhcqaNIn366mGHuJ
G2jHyzShUxLu4FyHJPjX3OObOPjguZWt9DBX3dkXuvSzD34BKVQGLc39TCaFDH1T
m/6oac17Vkh/rYsxNMTl4szdXH2NXnevDvwQWWpfnTtWj2ye/QClX52jji7Cldc2
gj2s9v7qIa28+cHF/hrbOP3eMCV9xxVteCag0zj1CWmk/AG/rdEbQDcUrPST/dlA
ywJN3o8806MtW0lV+DxJDxV1l/ijHuQ0Xs38Wr9Ew8cBvimLulov3zAsLhCer485
K1CsSGksbw3XducIgzmbQtqc3Cx8nBYJYcpvNQDC5yC+pFYYdfKlMNmfBGy+EbZH
+S/7ynaw4GOSiWd30gwmNXZjIKVYuipF1EgPFEA5IQA/PU+ULvbsgRsa7afwE+RI
0QJ9LUuH
=4hCV
-----END PGP SIGNATURE-----

--EwwV/HhBpogCW5yG--
