Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40FDC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 23:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFBB8043C;
	Tue, 11 Feb 2025 00:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ukyDi/mu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5235F8043C; Tue, 11 Feb 2025 00:36:14 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE6E800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 00:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6f666c94285so44095567b3.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739230570; x=1739835370; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tTSrvXXGZ5/JOVaFCtFkP7IxRhvwk5pCsCZxQBPlH8w=;
 b=ukyDi/mu58yE32IOH9ZJaCdhhwVpgkVC0ANjFm6p+gQfQ7TkCehdlRDQqMtabzrcOy
 qlX1MZ5DEe5yIUj4lIgG95Q4pph4nQPyQEESC5EoX+RaXotAXdAf7Ec72igbDU3xsSc2
 Pa3lWPRy3WcMV9eVpjIjabivYgo+r5eFt6aYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739230570; x=1739835370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTSrvXXGZ5/JOVaFCtFkP7IxRhvwk5pCsCZxQBPlH8w=;
 b=P5CYS1Ga2X2zuDVaZ0UvfUlQhyfFJ6wmOhQ1iLRhUMM5aVI8bcDX5aCrN2x2YJ7XmV
 tJCHzrMk+jVBgXuEL6nrgbmQJAUEzDEkfzECEDnFsFzJT87ipykIOVKGpqTId4oEHKPU
 QS57MMT+Uq/huXfbKmQ474gH7kiFWZEX0I7BH8E9tQOxtRv/lwF7lyTtwPZcjRuQo3g9
 zhjXk6OUFK87YaKsUNdHCVrr7yi1oDurjVj5CKo4vfR7iYGZiewZYJpCLZbEQa5vOt9o
 LwoOJH4riwKlBfJ1k1ptcJZQxxg3dkMTcnEpPo1peVSfjTd8brfL/3sQa2NAc1uaTXbk
 HAJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqlI19iZnl2gF/OeHtbGFfE9FAxC3jxHM+M29dF0oxAI9zUm4Lt8S1zl/xN5yGs4NjBXfntsw=@lists.denx.de
X-Gm-Message-State: AOJu0YxOyMTqNijfToUOr7YSue9S1lyVadkKubJSL8/1qosLvKAoCGpR
 Pax2w4M0rlKeIq4+y7Sson6Jnp9KLQqyg8PlH1br1FB+wOKR8LwsUWk/QsdGFHo=
X-Gm-Gg: ASbGncuUiBrbfLVl5XJQPmQlVsb3JyoCRXd9OxYuDSO4wqnUbJ0smSbKEYulUOvQLEI
 VxT/r3XJr+1lyJBf/SZjAvnUEN4TJDhnNtHNvPs8Lfgpw8HJxixIxYlGMkEyjIMI7rWDVeZyEXT
 psM20wO11r6NBaAbx65++tpy5xh3GzPS7hRqFkJ4z574/PjOZP4amp8DTbFsnyOwvMzzn/k4XUM
 kM+6FA7Zu2y5GDY3OHy6A4cYpdT7f82kmZQtN/QeyoDTJXu4u+Vkxt/b+7fuAaL0zlaRqXEqWVl
 etx/JA14hyA/7l0=
X-Google-Smtp-Source: AGHT+IGDGQ+RsFxvoU+qdz00ktQe+doY/m4eTDdP35u68eNs5huB8cKAAhm/UMw9yRO0rRoLtUjMBA==
X-Received: by 2002:a05:690c:3707:b0:6ef:4696:f1cc with SMTP id
 00721157ae682-6f9b28b407dmr148003437b3.22.1739230570612; 
 Mon, 10 Feb 2025 15:36:10 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a5b0sm18758097b3.93.2025.02.10.15.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 15:36:09 -0800 (PST)
Date: Mon, 10 Feb 2025 17:36:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v5 00/10] Introduce K3 remoteproc driver for M4 subsystem
Message-ID: <20250210233607.GV1233568@bill-the-cat>
References: <20250210202944.1071931-1-jm@ti.com>
 <af33ccc9-de0d-479b-9890-2c9c7f2996bb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gz2rF34WxbNUHWyy"
Content-Disposition: inline
In-Reply-To: <af33ccc9-de0d-479b-9890-2c9c7f2996bb@ti.com>
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


--gz2rF34WxbNUHWyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 04:43:31PM -0600, Judith Mendez wrote:
> Hi Tom,
>=20
> On 2/10/25 2:29 PM, Judith Mendez wrote:
> > Some K3 devices like am62x and am64x have a M4 processor in the MCU
> > voltage domain. This patch series introduces remoteproc M4 driver which
> > will be used to load firmware into and start the M4 remote core.
> >=20
> > This series also adds support for R5F cores on am64x SoCs in patch 2 and
> > sets up environment to load FW in remote cores in patch 3,4,5.
> >=20
> > This patch series also enables remoteproc drivers by default as per what
> > remoteproc sybsystem is supported per SoC, thus all remoteproc options
> > are now deleted in configs/* since they are no longer required.
> >=20
> > This patch series was tested on am64x EVM, am62x SK, am62ax SK,
> > am62px SK boards.
> >=20
> > Any additional tested by's are welcome since I was not able to
> > test any additional boards.
> >=20
> > Tested by running the following commands in u-boot prompt:
> >=20
> > =3D> setenv dorprocboot 1
> > =3D> run boot_rprocs
> >=20
> > Links:
> > v4: https://lore.kernel.org/u-boot/20250206015406.2702944-1-jm@ti.com/
> > v3: https://lore.kernel.org/u-boot/20250130223256.1944522-1-jm@ti.com/
> > v2: https://lore.kernel.org/u-boot/20250129225233.467139-1-jm@ti.com/
> > v1: https://lore.kernel.org/u-boot/20250123010759.810799-1-jm@ti.com/
> >=20
>=20
>=20
> Forgot to add Andrew's Reviewed-by, apologies. If this series version
> is picked up, could the tag be added? If not please let me know so I can
> re-spin with Andrew's tag.

b4 should grab them, thanks.

--=20
Tom

--gz2rF34WxbNUHWyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqjWcACgkQFHw5/5Y0
tyxvbgwAriIXPosOwBt5MQYwM95e+jMRg5s4UTiu/Gnr2thdIfD/0mqtfg1m1Z06
VsMKos2M/phEKYcRGVIzmMSMWfY7y0h/1RdNefCGlLkr3s4zefGipBvPN0XX1IOk
QceSORb7tojEeuq+usfiOOnqEPOPaJ6HYC6l4LHMkEnn/4F7zoqkaxuti1xti8wp
vz7gzs03trPDPx3L+hncADKpehIGrn5sQlpsNt7CbbF98O+xH46WwX2ULpCuiYcl
3CD19OkMn8xmQYbO5L+Q7+NtxbbkoNGq2qA1l2b8cF1lBl7IGP4xJNdWBs48Ekb6
/6vmSQLwrDl0l7+hWjT1SPsOUUt+TPNBv8wE7W6d+tihBCx5Gm/HyX5zePsAefMK
g57Hc17S0umqlaNW65aafcnBFjOK57WDdRt1y98K3UAkjqkrvWhxKu3k74NpBYOP
/1WrDPT+ygalYiREugFd30W2TK13Xt3CEJQ3n1nFmHyGCTkSuj3kqhjRR8o4PclC
rjD3Hc8E
=7zvM
-----END PGP SIGNATURE-----

--gz2rF34WxbNUHWyy--
