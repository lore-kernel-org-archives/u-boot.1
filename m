Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50272C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEA586F88;
	Mon, 13 Nov 2023 19:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ACMp7Zz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1220786F88; Mon, 13 Nov 2023 19:36:29 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B35C486784
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-66d76904928so29003626d6.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699900585; x=1700505385; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=McRKQqErCcVhL72QJ1TgD9FKVZDYysZlpVMbexHX95Q=;
 b=ACMp7Zz1sew/R1SVk1MsQh7MKGmN530y0MONIiStU1eExzjFx/ywR6ByJcbmdVVq+5
 RFaCy4PZysB+XaVpWlJr0qYURC3CKh0Qg5q6qPoP6a40XJV4lRaS1JRKQ73UVDZaWM6B
 Z+iB49pYsjUqym9n5PThEfsquGHVQXodiIark=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699900585; x=1700505385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McRKQqErCcVhL72QJ1TgD9FKVZDYysZlpVMbexHX95Q=;
 b=P+XgAjTnkIWc5hqkDIOektVtdOkYEMS7ZLEeYDmi++qFcI7ONLDTfE5kIhy+0a1JMF
 YH9TCtpZVGooF8wpBP3L7+fm13MzYOl4rdsMdc4yRiYv0ZSjhm5ZtrqpCvdC0W+gNwgi
 MINOjCV+WrK7FYOxDeTMeq7VOsQ1ImZT6KF3Pk/AycBxa8RocOuW12ADMyVijROcDxpM
 wwTgtVyC6Bu9U6dpbADa39llDuf/I7AzJsp5AOorJxEkwIiLbFWdu+iUNcPFT/GVg4Ao
 HDuFCpDu+Y7GiaQ0KGOcnrn25XfZnSKQSJ88qsatFDIsRDB7XR1XCe61iXbRpQwbciwW
 vp1w==
X-Gm-Message-State: AOJu0Yw/keHnYolQImwVg+CCiFsTUlK5SYLEz/zPy5yvUQhPqKVbKKRd
 uLqLM9upZWzbOeuk5uOVB/XvZvOU8X2x+sIU2rBtPg==
X-Google-Smtp-Source: AGHT+IGIJaRTblFbK1T6ygkw33tpTbynMIyYDW4tBwUamb/SlPpvYuLf3kH2sLqGmw6aqk5tR0gm1w==
X-Received: by 2002:a0c:ebcf:0:b0:66d:25f7:de15 with SMTP id
 k15-20020a0cebcf000000b0066d25f7de15mr29151qvq.31.1699900585478; 
 Mon, 13 Nov 2023 10:36:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-631c-486f-62f0-4c29.res6.spectrum.com.
 [2603:6081:7b00:6400:631c:486f:62f0:4c29])
 by smtp.gmail.com with ESMTPSA id
 k12-20020ad453cc000000b00677af708ebfsm2007457qvv.126.2023.11.13.10.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 10:36:24 -0800 (PST)
Date: Mon, 13 Nov 2023 13:36:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2024.04 =
 u-boot-stm32-20231113
Message-ID: <20231113183623.GK6601@bill-the-cat>
References: <b3779eaa-b063-446b-94a9-a5f458182f75@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TIoCXF8bGJpPMCru"
Content-Disposition: inline
In-Reply-To: <b3779eaa-b063-446b-94a9-a5f458182f75@foss.st.com>
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


--TIoCXF8bGJpPMCru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 01:36:22PM +0100, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related patches for u-boot/next, v2024.04: u-boot-s=
tm32-20231113
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/18567
>=20
> The following changes since commit 3b6db6901ff5babbb9d21f0fca750996e29d85=
e0:
>=20
>   Merge branch '2023-11-10-improve-semihosting-armv6' into next (2023-11-=
10 12:52:33 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20231113
>=20
> for you to fetch changes up to 01a701994b0590b6452516a7c67353359d053c94:
>=20
>   stm32mp2: initial support (2023-11-13 10:55:38 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--TIoCXF8bGJpPMCru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVSbJ0ACgkQFHw5/5Y0
tyyc6gv+OZ7fKiYkjQUpHICIdwSLp6JHnilVQVulQO0jo3QyfhxSzxFg9YU9YZQD
p8I870KkugX8NQq7bnpGCDp+IKLZapkTF93szQr7//zVe6FhIf0UF/tsJq1PmKms
C0j5iMWadrec9nYMy944uxXfLoDBZkKf+GrekcaEjHevVEIAxONIBbD1QOnqcr95
DFXUNquNYMObGupYa+zyeNbkV5tHGVEAnT4H1JbxOg3dW0t6V3HLi2woro7tFewX
jHTFSCnQzmRjjwRnYES5R6R4gtxSCxRnnqlSDdvAYL5Kgn6IzUwT2Oef909DG4NK
mOWN+H7AB9GvCJnSjM4WjpleJeNENl9DTkkLwR0iMXqaIV0WQEdwKMV8dPp3dNhC
k6BzZ6bb1EGHVE/36eyFd8H3Tx3fV3b9rU5TPB6cMwjfkz4J560H7FQ4ITTQZBkD
i+VcI4A2c6rrRVdkEC10PY7QLbCfqCtzdaZWqKlBm9uXoNN5xNc/7EwdVyLn5w0G
lkBS94bj
=iZbs
-----END PGP SIGNATURE-----

--TIoCXF8bGJpPMCru--
