Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A891DFCB61D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 16:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01839838FA;
	Fri,  6 Mar 2026 17:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rQ9IAdtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2B2838FA; Fri,  6 Mar 2026 17:18:05 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC718382A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 17:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-463967f35d7so6869070b6e.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772813881; x=1773418681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tiumRejNwzAVmZ9NkVZ9ja48EERlTMJ2VF/KwZgZ20U=;
 b=rQ9IAdtP/EbR+xYg7FBRb0Jry6Fd7Z5xTt+zmqfBxR1gXgCpXc/Lqq9vGWjnkAqVdZ
 5LRJ804DqKoSPnEaslOFGCpvteHYCSBex+XTIlT2n/DEx+7qApWq8j8pHjCgPhpdUhUN
 RagPjOJ/16V/EgrgxLlRRxUdmwMYPmVZryZmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813881; x=1773418681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiumRejNwzAVmZ9NkVZ9ja48EERlTMJ2VF/KwZgZ20U=;
 b=ZxKjiDzGJVPvoxNQcIdXWWTjSAwOwCqYgBCUsa3mGvl82efcOWeRvDUrDTHHugcONx
 iJqOWn2z0ncEHP7g/AeI+BfkPC2DAD2V+4Qb7vyVFHeg/2jPoCMm6XopMKrfvYfeEky8
 X2H4wwFxbvePTjReRTEYPiTAEx72SOdjMcoIsDMMqI2z71Ae/qvQwU7Zo0xUppblZRrb
 6osXc0n7f2zSyvfRMcHk/emnE31RTDNKl/AvptaYGo70vFPUQFAnkqANVPJ+LvJjA440
 LUWlQJ3AxIFnnhyphN7jRfVyW9P2zIIPvIfylSvt7UsB19911jym/umTfyvjxLqKFvwZ
 8g/g==
X-Gm-Message-State: AOJu0YxOtJZXfHkuqYdmd7x6TXRostR4TkQprFsStkQR8WVpPYrEoOOs
 GpGRXdZjRf01Kudnoik3RdwOTdv8az5PhB0qzEypeqbHymf8MB1FO+YrTzRGL8HY894=
X-Gm-Gg: ATEYQzxY/DR3m0EPdhVAs0vLvrG96qoNSvdZeoaUrctXm6lDIt4A82dgxaZB7KLF0c+
 oMaW1aBQiROcbjpAeG9kr5A/y9SZHeV3gtNZju0RKXZauEFx+ozZHatyLs0tRV6x+sj3q+Bk2sQ
 cYDq0yHm9eFUieqgd0t1AHwe+vXenDxlpg1fKsFmjlxBxumHglDaMtARlo0UoyyPcHl/X8UFuT+
 fOgzl3INYcn49u0U65jeZr3TVtuOGlFR99I51TOKY2KrgpPQZf2lv3Tl2qCQNSw98YBtU9NfObh
 zv004O3qwmnsto0Tvy6+ZcfEBJ9lOwVa3Ys4MNX614AE1gfYK31NFJzT5vuqWQVNpo1KX0qNj6m
 +4cFMHcyp+BG58NifdRuBaJLrfCIzT6hjr1DYgMp2sy2MOnNrzfGHhHRsSrwZe973leP+OCZPd+
 6JzvfLOMrWzg+XPzXtIsy49Z5HLGvN9Eo8qxEJ4C/Nv7Ki5JVEm+4XzqaKRZdkmdPX4h3kXUm3t
 yyJUjOHLJydUOLjL0SyDsK2iQZGynXQYo5tsHhXjtc/Puid/VJJqZPu2Kbi+A==
X-Received: by 2002:a05:6808:11c5:b0:460:f435:2a70 with SMTP id
 5614622812f47-466dcb6b310mr1447314b6e.47.1772813880820; 
 Fri, 06 Mar 2026 08:18:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-466df93e85fsm912418b6e.2.2026.03.06.08.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:18:00 -0800 (PST)
Date: Fri, 6 Mar 2026 10:17:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.denx.de, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20260306161758.GR1388590@bill-the-cat>
References: <20260306005631.175834-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c7OiNrxC/b/Ai1t6"
Content-Disposition: inline
In-Reply-To: <20260306005631.175834-1-marek.vasut+usb@mailbox.org>
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


--c7OiNrxC/b/Ai1t6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 01:56:22AM +0100, Marek Vasut wrote:

> The following changes since commit b26cc03b7cecaabdb306c2f68eebde764161a5=
45:
>=20
>   Merge patch series "MAINTAINERS: Update ADI ADSP platform maintainers" =
(2026-03-04 14:25:30 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to cd86e8fe811157ea708444a8b3b98564a46b313c:
>=20
>   usb: musb-new: Add compatibles for ti,musb-am33xx (2026-03-05 22:21:30 =
+0100)
>=20

After rebasing to next (there's a pre-req series that wasn't obvious,
and in next not master) applied to u-boot/next, thanks!

--=20
Tom

--c7OiNrxC/b/Ai1t6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaar+MwAKCRAr4qD1Cr/k
CuzWAP9sVhHktxRtUwcjIOOkaKTXgA8BAKkKynIifpVaaoSRIQD+JwvCFqw55ici
xIz7MegPoOyzFboKegirs01wP0ejfAw=
=GA5O
-----END PGP SIGNATURE-----

--c7OiNrxC/b/Ai1t6--
