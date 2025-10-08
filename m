Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E12CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565C1839DE;
	Wed,  8 Oct 2025 18:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aPe7Bwk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FCEF83A2A; Wed,  8 Oct 2025 18:49:10 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48EEF839B9
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-44181f9e5b4so60196b6e.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759942147; x=1760546947; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=apHc1MizMlqKwg6h5enoKrWWCK2tWvDKaoiQtKx9x5c=;
 b=aPe7Bwk/6QT1R/2+iDMtRoh9P4waRrjZsSmEmP4xbpp74k8crHTANUXckdXHcOw+LR
 SFAGjTCUeGn5AMwvZfEg57zGJvuRX/S+Q/BkSTYmMRd+E4xVhaXCoJgWVmSMEKB+rgFw
 2P4hWD/fl6W/aa8HhI0kYhYB36z+j9S0Hla1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759942147; x=1760546947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apHc1MizMlqKwg6h5enoKrWWCK2tWvDKaoiQtKx9x5c=;
 b=fyjs+Ffh17KJetrU30BstVyKrfWL2HKjqvZH/80/Q3K0g1IbtAx4NCvv/s9t5NDq1S
 fjN5wmmn5T3eDlrMCXPJu5YgdMhSMMLbnzGfSDCla81RMM8j8xNUJXsljsasW6wktMS0
 G6A6XG4hFUxODpC5EaMlEx2g2ipRaNTx+Flv1lPNSWJNniy+QwOwZ7s8wf8wgIvQAmhd
 pHSwD2kIZR/b6xDS4FauPQT+s9y1UkJXndgbSMDLeJ9dWTOxLlszvUf7rotY7ZfZHILF
 J+GpLd8nPhJDF1QsmSwqSH8DWQUsjzxwpA7IQo2VMymZUMw9gbeW2pKrzLjhJz6nQfE5
 92tQ==
X-Gm-Message-State: AOJu0YzhQ3imvXczQeua67WE04EWQDpOaJIQqTPCet0O4ZmjHwVzX05R
 cbEsdaguJJItSK6IAFAFRR2J/yt8/UqMWq7uhHHzEJihck3hbmAqJT/Etva5ccGJTWk=
X-Gm-Gg: ASbGnctLbkDmBiTwEqH+Ib5D817MEB1orIHT6TsbyBIRQ86NG5PltOT603Wz5RB2/AB
 rJBmYOK4Qjys0iOnO4qF3H7ggRRZ1l3vpsG+bF1YVqka36xe6AhN4zqGrZBcjG5wh/BeGZifAda
 S90N0Nuj6BzX+4iilFUwmcz1jLPOz9K23o6cL3/hu3XK5IavZBZ/MVO/LGRZhkmNpp8PqMqLfPP
 QIRWymB0D9JkHvAkPaBh0CmxtGH7je+Kb16mdIcpQANewQ/9E4yyGmN+8zyKi3CcI1Og3W7s/6A
 lj/N6jpfqbxdYWJqCinpkiC1OuS6XVrTbUsAcQTK9oGR1if6mqx4jzwZnpDUckRyXQUdqfN4p1i
 7JF10+pwnAbTqO6Pi5I+jyDY1l9km91oO0F923WpJb+un+rhUZAehyWkeoeYnVcKJsLBT1WTGGX
 z2NqPiJ2gb2w==
X-Google-Smtp-Source: AGHT+IGZBEf/OxZtw/yOMA7XHbMAjXZ1bjhIH+LpMZwzUjPLpAZEfn6MqlC+fz+mcH/WSZYPKk17PQ==
X-Received: by 2002:a05:6808:2209:b0:43f:5861:5152 with SMTP id
 5614622812f47-4417b2f7672mr2096533b6e.11.1759942146990; 
 Wed, 08 Oct 2025 09:49:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189af329asm84655b6e.2.2025.10.08.09.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 09:49:06 -0700 (PDT)
Date: Wed, 8 Oct 2025 10:49:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com,
 kever.yang@rock-chips.com, hl@rock-chips.com, tim@feathertop.org,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v1 2/2] spl: prevent loading args file in secure falcon
 mode
Message-ID: <20251008164903.GD298503@bill-the-cat>
References: <20251008113605.1055826-1-anshuld@ti.com>
 <20251008113605.1055826-3-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jjfa7/AfBebvnUuQ"
Content-Disposition: inline
In-Reply-To: <20251008113605.1055826-3-anshuld@ti.com>
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


--jjfa7/AfBebvnUuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 05:06:04PM +0530, Anshul Dalal wrote:

> The expected payload for the SPL in secure falcon mode is a fitImage
> that contains the kernel image and the DT. This removes the need to load
> an additional args file, which exposes an additional attack vector since
> it can not be verified.
>=20
> Therefore this patch disables loading of the arg file when
> SPL_OS_BOOT_SECURE is set.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--jjfa7/AfBebvnUuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOaV/AAKCRAr4qD1Cr/k
CvLeAQCJF3P0bkAfogJh3P12/DAk6yp4fA5etpLnHM1mBAjLFgEAiTfAM2gHmmHu
4hrP3LA7wWw83TG2MdmjErc8BA5iIQM=
=MNHo
-----END PGP SIGNATURE-----

--jjfa7/AfBebvnUuQ--
