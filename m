Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A744C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2912E87BA8;
	Thu,  7 Mar 2024 18:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TEOY0/fY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F4087C83; Thu,  7 Mar 2024 18:12:12 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ECE687D66
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-68f41af71ebso10438706d6.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709831529; x=1710436329; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HJ2udBAASQyNojzd0ShvNwAsI/jGF5xZIdswg5igSkA=;
 b=TEOY0/fYLZwELcm2koQ0ANuwcwOZm6P0NrZ4S0YaB2NJ0RZeTP0XcYQWfHeb1Ktq4M
 N00vQejCmAwPpUj4ywCaBFpzRR98suEOzbZQQC4D23+RV4eoDB47FbB/z01zz8JjbjRV
 2isAhBKIPgC6PwlH7NWyP0aZOxnNuuNVs4VSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831529; x=1710436329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJ2udBAASQyNojzd0ShvNwAsI/jGF5xZIdswg5igSkA=;
 b=wnqj/C7wmmhR7/3SrpEQlZjY61XmoxtHFS7xXk3Ae0VqbRMG48YsSMTVxNSI+Sfz9x
 bqnr0zZCWO87go/sC8gNBhMkYe+iLHqZh/1Bgz9FJ7AUzBI97yOHUCxwu/HdJVHbSY85
 mlT3GAYz1y8dTBua5gzaWJrukAMMwFPAlTIIiKT7RDu8PC89DyrmlcJObRZpmAkp3dlq
 zZbTFTcxY1+iSknDZFJwpfbKsnmn3Ut+QKXZnABAmpsIPCbywh97MxXsjp5rYdTiOe81
 YRUKX3lrM/LdC0kopECU1ikWSL6Rt9oIz2hr2De9tFWS6sYdY1/c3wPTVlLzmxVDM4Ii
 pWkw==
X-Gm-Message-State: AOJu0Ywkhj2ALJOKfmwUe7q+WH6RskSyVX8zCMdekqbahe4kfPQDJKmO
 Q62ZPoBMli9sN7+zpb0MJpfdLOCHnnPlzlGAiNsNm5qiQwSO3X63pVAUDrxfQhQ=
X-Google-Smtp-Source: AGHT+IG8xklmgoDN8j9AiGkwu3QlhvK5aGGc2w3YOernXFJU1yV6B1p9w0yR3TepChCXBjKjP15u9A==
X-Received: by 2002:ad4:4e4f:0:b0:690:9069:2c44 with SMTP id
 eb15-20020ad44e4f000000b0069090692c44mr6715093qvb.18.1709831529117; 
 Thu, 07 Mar 2024 09:12:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 qj13-20020a056214320d00b0068ee3a50585sm8916986qvb.38.2024.03.07.09.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 09:12:08 -0800 (PST)
Date: Thu, 7 Mar 2024 12:12:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Bob Wolff <bob.wolff68@gmail.com>
Cc: u-boot@lists.denx.de, seanga2@gmail.com, pbrobinson@gmail.com
Subject: Re: [PATCH] Check curve_name for null to avoid crash
Message-ID: <20240307171206.GJ1523872@bill-the-cat>
References: <20240227235704.48386-1-bob.wolff68@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UxViLav+nGZHDuXl"
Content-Disposition: inline
In-Reply-To: <20240227235704.48386-1-bob.wolff68@gmail.com>
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


--UxViLav+nGZHDuXl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 03:57:03PM -0800, Bob Wolff wrote:

> If mixed rsa and ecdsa keys are specified in dtsi, an rsa key can be sent
> into the ecdsa verify. Without the ecdsa,curve property, this function wi=
ll
> crash due to lack of checking the null pointer return.
>=20
> Signed-off-by: Bob Wolff <bob.wolff68@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--UxViLav+nGZHDuXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp9WYACgkQFHw5/5Y0
tyzfqQv/XG+m9z/5GXuiDo1BtN/P7CGLSI3cNSsrUL8XzeUMJfr4Qj/t2hcMHabL
gcMMyCasL8xdZrlA+FpMW3jH1LEucnEpGhKUQexTww6itI0BPQ93LrzDBr1naZ1x
2qI3Y5SqZJHeN3WV5MMPpxcywrCQYvigzuI1P/kc5ypNR2AM41rJ5hms5Ciked20
CDc4EhTg850yWp9q9pEDLYNyDBsjsSKiVJwzXmgQ7KG43qTZKuRkpPQVBwGWLJzu
QI0/O10cbh03eGh9fIcVHwksefJrnu398oGIgEPU1NCO687CnkZ8fWNc7sopMObz
6kEE/pO2XD48Dx4Ozw+4NSTYroaFUZI3DSOqf2yRVlUp6zR3NKC1L9oy47Z13Gsi
Zg03LGiWvIBbEQnOdxUtdUOvSoAW/Gj+MtByl3O8N/QNKpqEnJdbuW8e4kCjba5Z
NcWnojGdWD6E3dgQ79/6D4F9iluOX3WOg7esalIHJuv0y4hyLyMXSFBZhASE9bcF
tY9IoQii
=iQD6
-----END PGP SIGNATURE-----

--UxViLav+nGZHDuXl--
