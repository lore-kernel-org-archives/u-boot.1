Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6485ACCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 14:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9658583C62;
	Wed, 12 Nov 2025 15:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bAK1Xpyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED3483C65; Wed, 12 Nov 2025 15:09:58 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC66583C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 15:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6d2ec149eso363996a34.1
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 06:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762956594; x=1763561394; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iQT29HJJhBCSTnY7TYPI0WIq5sGVJouC46zqmVutL3I=;
 b=bAK1XpybWFG+V8/FIRROrmoX9Wan9f+5VyRjd+6ckT7BmwHCwyqFQ+JW/ihfuhpgxV
 9x2ThVyQAJOJY38LCZFw3FiznrJ3x7Ngkdlz4yYGvuXlNtlrWAOnHVT0wWGWAk9yFccx
 DFURIXVUId8tGu82LrQy4ScypuSSHhfuA4t/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762956594; x=1763561394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQT29HJJhBCSTnY7TYPI0WIq5sGVJouC46zqmVutL3I=;
 b=cNmb1W35OoFFlwronHC2jdOpx0zSl+48wsJJeqbNosWBlnW9xsySUXTdIyYa9dcDS+
 QZPs7MYJE1rVutpHDGOjbvGghZoYe9SIVaqyV5qguana9rVgAd2xV+m9Nd58MemTO63K
 4oIKjhqp5zcvi2lscK9GQBA/0B5RlI+Z9tkv4SI7PHr+lGcXMUhLxFtX1GEtECPs0qSa
 qb6SapwzIPdiWv2g3b5/dXcrgdoHIbgJF+AECksS+TqFJfwW+scZVtGJQpGUXJF7qsmb
 3nV0nrDQWBGexaSRFA9BGLP6eRnSKm6FKDFOqECCKHAl5aS/9k489YRBuujGvCaXWFYu
 sOrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRCN9QSmf0FjKVDVxngTK6p3ykwSgywzVnAebp+6i45cLMRkuQ+TXLNW6EwH5XuWZRwknSLd4=@lists.denx.de
X-Gm-Message-State: AOJu0YzdSM0t2eBfbjAQ2niM6nmLhFrbOWxkZM+TqFkqSSY+V8eIVJ5o
 CHdEy1kaxm/179NgM/IhyULe67sle2jG5sJSo7tuGiRd0FoGnw1rpy91q6y0C6P/58o=
X-Gm-Gg: ASbGncsf7Ox3zkv1NbBzF16UcQ+v+Lp1oXtbO0kuudNMnvljg4W5rAwKWRk7mcrMyDs
 N4lLY1qKOHVnwDkfZwGz8/yngzuglAPzyqxcOw8dX8UNrQCSJfEyG3gv6Rl2DZM/W5ZYKqc1RvT
 U/34fY4j0y3E9m6h7opDhhFTFspNZmpQ87GO+GhJRQic9IbfhkNt1ZjGnWLdLY9z2GatE9ViPrT
 SFQkYewxI6zWhH58kjMOhxdsJguHsMU+Vkoz1SELp6Vrb2OQV+npk8L/ZvDnHw6AkkcBRqnZEkU
 QmHAOWb9ESMiagqzMR5BTED5gWhcxn9HlmdzOMrxPUtYkdAgFmDakln/YyMz6rAZcJx8xMx0FZ8
 up7Qq2sqTnVuW+ynRBFJpkJ6v9yXxNSIY3myAWBCxIGfcYxJnQ/H/nuxvq4RbFf3DePIIkFVYzI
 u8BLTnR3GeP2092K6r3Pa/P/5/g5QRZvcNvHEm6MQ=
X-Google-Smtp-Source: AGHT+IGRGUdeukDggD4Dx4PZCB6UUB+ZcVfT7PnnWMAcJJcgtF1o88Eslm9SyN9C1mFjFzrwyrGWag==
X-Received: by 2002:a05:6830:4513:b0:7c5:3663:ae04 with SMTP id
 46e09a7af769-7c720c23dc9mr4280819a34.15.1762956594590; 
 Wed, 12 Nov 2025 06:09:54 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c705a92b23sm5701449a34.23.2025.11.12.06.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 06:09:53 -0800 (PST)
Date: Wed, 12 Nov 2025 08:09:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH] doc: board: ti: k3: Update TI firmware repository URL to
 GitHub
Message-ID: <20251112140951.GZ6688@bill-the-cat>
References: <20251112104218.487754-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u7Fr8t9w7/HIlr5U"
Content-Disposition: inline
In-Reply-To: <20251112104218.487754-1-vigneshr@ti.com>
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


--u7Fr8t9w7/HIlr5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 04:12:17PM +0530, Vignesh Raghavendra wrote:

> Update the TI firmware repository URL from git.ti.com to the
> GitHub mirror at github.com/TexasInstruments/ti-linux-firmware
> which is much more reliable.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Reported-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--u7Fr8t9w7/HIlr5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRSVKwAKCRAr4qD1Cr/k
CqnPAPwKOT0ybcTbfPRfb6kfsoxRUs0fF+TDSj8Vz+1ABoy59AEAj+ElRo4CsJbz
E5X9RLddPc2Ma1yq7BMVhy1PanNqLgI=
=53XD
-----END PGP SIGNATURE-----

--u7Fr8t9w7/HIlr5U--
