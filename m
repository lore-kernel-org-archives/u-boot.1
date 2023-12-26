Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA13AC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 16:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E1748786A;
	Tue, 26 Dec 2023 17:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BkhMjHHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5761878AF; Tue, 26 Dec 2023 17:11:47 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95F087869
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 17:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e6c8b70766so36739487b3.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703607104; x=1704211904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J9A4qPTOjA0s2Pj8/WnHNwYz7yDwIXvGEfeRQ5ddwr0=;
 b=BkhMjHHovcGNMV1jijzLlKwpAtRADQcdM8lP/NxmxWffUrq83ZrhSzI/9prx56bQUe
 1UqnV7oZUsdY2g71M2VAx4gxaHqzX+NgeBGcPqe+BHuz8XA/3lY66ai54Zqx7k/Coaca
 /FfzLzI7eUzLWOK2eHxtQD5fbzRUbC2AEbqwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703607104; x=1704211904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9A4qPTOjA0s2Pj8/WnHNwYz7yDwIXvGEfeRQ5ddwr0=;
 b=ZztFqvtbAAurmksYEzKY02xD4cNiwLwIqgIJvS16l3wb+j2E5usYn/DH8oBC9Ii9XB
 rEKd+KIeMc8LohMK1T/3SQUoGU3gXNHmy7wedLnyLOqCetpMDh0SEwqrvr/sM/hCl8Iw
 O78V+MsD9K9SD135XDTYuR455MvTmzi4SbTDijvj3aq8M3PnzeNN2ScOwlvAW87eewOD
 uUamGnpvH+skWH4AWtLILM8TGsxyTg5RYosfpGNq/n9fYzOc8Z4YmpfPBxR2rivgKkMr
 vdFkI1YcZqUFXUyYEsvOGEUgAgpYQzh8/V/JOHGJa2Eq8K+iFRXQrdMi/JcLMrhpGIb0
 cgwQ==
X-Gm-Message-State: AOJu0YxLxfJR7NOmX/RsrykMQGiLcfs+akFdxAZpc8Lngack6+VAvaVO
 4isUxnyjmtiJabROVH6lCfTi9AkS6iee5A==
X-Google-Smtp-Source: AGHT+IGKKNEs5L5OY04AoGywlOJSz0suLVqgbMpYN0FrcQ0yzw0V8YvCtFEcttQekDMxcRmx1y/y+w==
X-Received: by 2002:a0d:fc02:0:b0:5e8:c7e4:e7a6 with SMTP id
 m2-20020a0dfc02000000b005e8c7e4e7a6mr4353013ywf.71.1703607104340; 
 Tue, 26 Dec 2023 08:11:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 u66-20020a818445000000b005e6d6903934sm5580123ywf.9.2023.12.26.08.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 08:11:43 -0800 (PST)
Date: Tue, 26 Dec 2023 11:11:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sjg@chromium.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, bharat.gooty@broadcom.com,
 rayagonda.kokatanur@broadcom.com
Subject: Re: [PATHv3 8/8] Makefile: add dtbs to clean
Message-ID: <20231226161141.GO2652760@bill-the-cat>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
 <20231226154619.5071-9-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6eALlFQRsBPz9qOX"
Content-Disposition: inline
In-Reply-To: <20231226154619.5071-9-maxim.uvarov@linaro.org>
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


--6eALlFQRsBPz9qOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 09:46:19PM +0600, Maxim Uvarov wrote:

> CI test checks that generated dtb has to be cleaned up.
> Use the same clean procedure as Linux top level Makefile has.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6eALlFQRsBPz9qOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWK+zYACgkQFHw5/5Y0
tyw7PQv7B5VnsfNaOvf725BRbyRDPCAglsK5d4DoV/dUeYZUb2q1OIz1W9nEq+FP
UFnkmWxjvkOs8KNRm9QXvM0et3iPCRrY3vaYow2EtnFSPKv9TD29IeSXAahzTVFs
1JsNBvQiAdwXiYmevNiLISVJt8BE89Ux8s4vquoyOjAVe8XykXx6bSo5z0tpTKiF
iDEh0dVW6o/bprHHQvGiuiIYF78QoOiAl2tI+n1bNGlhdGMa+P2EIa3h5YUFo8KH
9V/4DNpRwtIqBeS14mOKoAiV9PvTaHEO/07C3AUsGDvGYdAJ3Km+zwarL4K9EK9Z
7VmX8P84MLnfs80Bq2CR/nq0rho9zDbffXjTbsmhlmbcMUx5DdoDvJoH/WIBP9C+
SyyMdwc8pW0FYMcyDBATQRMbjd+H5w21mQky8cJ8CJXJ9p1LbkxUqzSnpWnsS4zL
MD0C7dKAINerJcL+tVDiPKV+CV15LzJddKq2xH8R6PYAl4PXFZ3F3bb+GZZ225wE
de/UQUz9
=QwoR
-----END PGP SIGNATURE-----

--6eALlFQRsBPz9qOX--
