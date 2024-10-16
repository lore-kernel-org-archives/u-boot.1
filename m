Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE52D2A538
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07D887D1A;
	Wed, 16 Oct 2024 20:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qp1J48Ci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0596487D1A; Wed, 16 Oct 2024 20:07:26 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D714188D91
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbf2fc28feso757066d6.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729102041; x=1729706841; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mMAXUHfajEE2KjuMHDNzaqc59QUPylzAFhCKXzTx3Ic=;
 b=Qp1J48Ci4j5dWGVvK1i1YkvWb1MvTIpvUpyf0gRFH7nyxhgGie4SLDkSjJCtCn9E+E
 3QvZeiGI3QAuuSWffKM/5MeRoCOQSfKeY5jtWsduj4FI70QyHgDPPOrzB+VeuShh4xOP
 JzQq9EauMvSzTvKn51KN82qsgHjGJVrhiCaEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729102041; x=1729706841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMAXUHfajEE2KjuMHDNzaqc59QUPylzAFhCKXzTx3Ic=;
 b=vG6zwfxWbDia+fil+Ag+xWDkn530d6qBsNoA37PV+9qih5TfTX4CR4tLgu4YlR81Qq
 BNxnjQJ4SaWuIaeGqTFrrptAbb7l2FbcTdI560/+gbKlTntZnrTmUcioo4juuhuLEs2s
 KNGQjrB3Ol/dAw/Gp+hRO1DoyjcN2lARfabCgWX3Lf3altYQ2rcOpjViFZYOr5pVJmLS
 Q1C89IcrH6YhJZY9naE/SUo/K87MJdwHdI/Lgwa+8CzjQV9/Wap9HcHma/Y9/CmNX+6q
 yTmoBqQeOjjY9TcfTZ8WPFOumpIUXcE9GPvPuRYJwoULHRxr0yv9/R48a3+zBZhB2bLe
 FZSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsX7cRpjCI23tD0tDRSKZnn++KRUFeNTegqOGBFuO1Q+1aK0zFfPGBLV0FDvkjMCKoX7m+jGU=@lists.denx.de
X-Gm-Message-State: AOJu0YzoGenF2kIO7u9F2ZRYa8JiFgCcrD5ST0TJSlqcyT44iSh5x8ig
 4NfriSRHir91sMdZwv6S+fw93sGpP1nqHAAS5eSpLem1gJGeTuzGvKkmKHCN2Kc=
X-Google-Smtp-Source: AGHT+IHIH6/JQrzBihXH78OuhRXdQCvwOhwtvTw+2a1o8tcZZqqYMcQaj7fPUsbR/tDJ85Izfq7dFg==
X-Received: by 2002:a05:6214:428a:b0:6cb:e53d:dd7 with SMTP id
 6a1803df08f44-6cc2b8d1747mr68334396d6.19.1729102040574; 
 Wed, 16 Oct 2024 11:07:20 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22924381sm20319266d6.52.2024.10.16.11.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 11:07:19 -0700 (PDT)
Date: Wed, 16 Oct 2024 12:07:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH 08/17] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Message-ID: <20241016180716.GD4959@bill-the-cat>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-8-f640c8f3bc1b@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PKQqzq0kaIi62nki"
Content-Disposition: inline
In-Reply-To: <20241016-imx95-v1-8-f640c8f3bc1b@oss.nxp.com>
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


--PKQqzq0kaIi62nki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 03:18:01PM +0800, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
>=20
> @protocols is an array of protocol identifiers that are implemented,
> excluding the Base protocol. The number of elements of @protocols is
> specified by callee-side. Currently, set it to 4 is enough for i.MX95.

This needs to be in the file too for documentation generation to pick
up, thanks.

--=20
Tom

--PKQqzq0kaIi62nki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQANQACgkQFHw5/5Y0
tyzRPgv9EqarB2suwDzbk9kWRAeN2GJ/M3vPJkWPjl33iUHrRkkhHi/qtaOatCVR
AX9Wwt/QginLtUNRi4ON8ZcwwZtUVoetyXqQwthVNT8LVywDTr9Z5pHuTakcOzBF
5ie1Y7yy+zQ71gBxwsSYQ4N0Au5+hAfwPtvqvv3JBpOGy6O2pjRP/glZGtEbb3pz
Hp+JhdwV+w0uJR8tC4uwpOKDYUAjntpbdBjDWd0PcO02TjGBUSmH+xVeRJtz0957
y8BAR91d4Dk5yiAUa1M/8y90X6AG8iInr/cn7GfqOawKzU2e377wvl1bDgAsXjxB
rJgvCG+XlIaWtoXZurB4AxKvaI83NXE0Yu+AldXwb/dr5fQtnecs3dyyW9b/I3nE
Eh7gl+neZXorO29TM64lFB4UE7+e0dIGubhWEhZZHUUPEegdsyzMzGHSCjNrSMqm
wyaCkPppbUoTOg8TNz5ymm0qa25d5IDwxGfdj3E+Amej+OiuVABxF0nTo1dkOdeB
c9elazV+
=qWmJ
-----END PGP SIGNATURE-----

--PKQqzq0kaIi62nki--
