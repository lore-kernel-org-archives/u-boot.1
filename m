Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB8BC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 17:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC770876DE;
	Sat, 16 Dec 2023 18:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PUnKfNcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83A587705; Sat, 16 Dec 2023 18:12:59 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D2487600
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 18:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f33069b79so10946d6.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702746775; x=1703351575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3bVIRHpmdF4uV8QHsVx+K6CrS/MLIGF+7WYVjc7tgl8=;
 b=PUnKfNcPa69rsIOqQ/w6lqRGwOnncNaLC4cYObOlC2eCqISm0j5rSDnlbEsfduOzxJ
 m6BEyEGeTWy+Npb54Tr+DA9cClM4L52GxYo31gGgELqgcXhBRE6mfJbUMUYlnYnPJoiN
 sBsFnt0la/RBcLPaLiD8JpPIzL+9FAPaDCo9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702746775; x=1703351575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bVIRHpmdF4uV8QHsVx+K6CrS/MLIGF+7WYVjc7tgl8=;
 b=ZmLw+5L/0EJFgw/xl2p3M/WtnQ6ljMuhh7uvvbamsXTVgp7hAJf+lJGKbejuHdu60E
 ctUZKIkIKuIlwczPFjL2AljgqVlQQbxef8pEcki2I3GeMYnFiX8C9FAKEwKgnOgkp2Wv
 XcGpvSzOHGSOHbaPUMO0p6AV4faUmpoZgYE4NWEnwn22yu0FpqKmUirQxw+mslkr/OHZ
 DDnWVOJL6cKSeFHnHJYY6LOPOVVIQlTdC56ceET//OTQIk0zoACCVKHkWjRMJRSq1plO
 Gd9C99u9GHMBM4gdKOABAgnl4dr/nbgWR0LxnPegHB/6dnCXVrM2GP4y0jDr7vmlDpts
 n/Sw==
X-Gm-Message-State: AOJu0YxrA2Q9E8HMiTEZKzOcp5kUwq4bKda6sdliZOMkO/A5ocxM9Y7H
 V1puHw4ehr3+7/KThCWc510IZQ==
X-Google-Smtp-Source: AGHT+IGTFc8fiI8RcQLSDJecSEJ215e5d+sG3PB0mkHwp+ikwl3KD7eLvZnickMU5gW0on05MZ0YEQ==
X-Received: by 2002:a05:6214:2409:b0:67f:1dbb:d3c2 with SMTP id
 fv9-20020a056214240900b0067f1dbbd3c2mr2931293qvb.16.1702746775009; 
 Sat, 16 Dec 2023 09:12:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a0ce284000000b0067ef9cf41easm3230912qvl.6.2023.12.16.09.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 09:12:54 -0800 (PST)
Date: Sat, 16 Dec 2023 12:12:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v3 17/22] bootm: Create a function to run through the
 bootm states
Message-ID: <20231216171252.GT2513409@bill-the-cat>
References: <20231216031446.2222362-1-sjg@chromium.org>
 <20231216031446.2222362-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PRMXNphcVJX52V6/"
Content-Disposition: inline
In-Reply-To: <20231216031446.2222362-13-sjg@chromium.org>
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


--PRMXNphcVJX52V6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:14:21PM -0700, Simon Glass wrote:

> In quite a few places, the bootm command is used to handle a boot. We
> want these to be done without needing CONFIG_CMDLINE, so add a new
> bootm_run() function to handle this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PRMXNphcVJX52V6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV92pQACgkQFHw5/5Y0
tyyDlwv7BfesxFVt0yyEUhjITSwbQ/4cv0weMXB+kjcO3dPsaFKIEEDIngD4nyUH
rwpCcMjUz2tzxyId3XuChp498c731+zbwZMfzKLpIHQfWJjvAz7cQM4Qj3WG4UWF
7aDWTLzG4cU0ONzr3MwIHMi6UGM3gOp9T6VkKiHAyN24QijDENWcI48v4OYxAVuw
ctvgi+dM3W8gxTT7NkX84b/IAz6k0SVaYsRqaU6SNaph5m0x3MyxDwPQ47cd+y0+
DI4IVPu2hH9AuQVDqn2OjstOlOUBu2VNaFYYzkNPEt4/5/+1SS3jXQiCPXjYqW8t
hjByYRPd0ue3kNU7W5UIybF+DUfYnLcPXUHTinRmn9oBfhEJG62qNr9wx2HIo9Pq
qga70fkd64wxedP4BPXByNdlWTWK0GclXjQmH3EKmYXGzn8eMLBQ7HWEBP2TCqtX
Y2774VPh9xWQQbktm77PqM+NLoOZ6PvOPlz+p6heDSlYZ8Tp++3pHkMoxDRV1fFt
xFjKGsVT
=+HpC
-----END PGP SIGNATURE-----

--PRMXNphcVJX52V6/--
