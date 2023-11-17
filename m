Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D2C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ADAA874D0;
	Fri, 17 Nov 2023 14:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lCwP3K37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A4F7874E0; Fri, 17 Nov 2023 14:41:31 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 673F386FF7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7789aed0e46so120877185a.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228485; x=1700833285; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0JoI4EPvgWsIm9RV7/snusGGCJH46Z6HzE+NpV+PP1w=;
 b=lCwP3K37eGA4jbIes5vKQlo9Reuk879jPU0Iq3crLlqKmf1+yKzmLVwjD6rP6oiXo+
 xvrUx1jbURZED5IyOm6bzVqpo3e4s6cR/G99qSY3rC8EOrZQtImtdjMPOaCTR/iARMMd
 bQFYEEyKDAxmR+ZSdGNfxuCAPokf0Cp1tmxtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228485; x=1700833285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JoI4EPvgWsIm9RV7/snusGGCJH46Z6HzE+NpV+PP1w=;
 b=vGzc9rjdrs4bT9DBG1MY2m7wpE6z4h+MGvqj54DK92xf0x4YW35SV9gcOhfAy2xp3c
 4778CK4Cr1alSO09dcJ3BhAKB2e6g3hYiN332DbJPSDpwcoiyIRJPakUvqcTyEzEYyYK
 z6LRNK/rRHEeqbzJQl0vmG2AcR08LwDNGKceo73bGqxzPP/hn+Kleb7cWuwLPdTgeb1V
 lB2ey760PL+jFdZmOFmYWv3Nyi3cc0I/4mkCIo/VrBJhF8pUFt4f1qBsN9NjoV+ijx8F
 qxLNqolw//yeURjxPttWKJO5oyHjzJvVk6kbB/BVCF7TYkA/M9meI57tYJC8GFXioCv4
 JV/A==
X-Gm-Message-State: AOJu0YwzAaRoY9b72t3sAlOg98HzVlxFukJtxKCpNvH2xu2u2Omrx/ol
 l8D8OuvlQP3UagXhlxCT5eDLSw==
X-Google-Smtp-Source: AGHT+IFRfi+NIHmjU99wIJbY603smQYSJPlYzHvyt5JWUqVlVdTMuomb/S5u8ghkvYUsomM6DhT2fA==
X-Received: by 2002:a05:620a:4c89:b0:77c:1fa1:529e with SMTP id
 to9-20020a05620a4c8900b0077c1fa1529emr606511qkn.54.1700228485186; 
 Fri, 17 Nov 2023 05:41:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a05620a0e9200b0076ef004f659sm606665qkm.1.2023.11.17.05.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:24 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] bootm: Enable legacy VxWorks booting from FITs
Message-ID: <20231117134123.GN170968@bill-the-cat>
References: <20231027200741.1542324-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="57QIw3vMuFxnPrru"
Content-Disposition: inline
In-Reply-To: <20231027200741.1542324-1-sean.anderson@seco.com>
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


--57QIw3vMuFxnPrru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 04:07:40PM -0400, Sean Anderson wrote:

> This works without issue, so don't fail.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Applied to u-boot/next, thanks!

--=20
Tom

--57QIw3vMuFxnPrru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbYMACgkQFHw5/5Y0
tyy1wAv+IZgSZyPwnIno1LZomblysdkGPLSTiUc/0+rvjmnb/bWUwx8Bq2OMG7SK
A0maMKhxSv38NrWpjAnMcI/E4ajshRm3X5mLEQQLPe8Bzc6yM02OKySPwpBnP9oZ
w2ZrrU2b5BU0NZST8DiBlRkanMytP2FB34JzN5LNs4L33JG7t0Zs75LarWoSXplY
pMyWSlQN6BuP7qFA7/3bFS2Nk/l6g5yMuYW/QC+Zu0Ep0cFEoKAiQHdjJ4Eg/FBG
fQS6uslw6k6rlf/PBCA3+QDQc3R888+f4r7cnpPbKqjMxXL3q8kFujusECBJEaz6
UYtV94viZ4uapuZvi3yBXjICbH13geOseAMbZtBVJUJnZ59VkN3BEKmGmI7/NlKj
uodrq+TImFuJ7BAhdAd+JZmFV/o9Et3YkPoX9EdgvGf++73eIbm/6taLRgxQ2QOh
4INB38G1VQ6Z+tDmmlAtt/kCxD8Wpw5M4BMkTCTNhhR2DXB5OR1qle0UOKCzjqU6
eiP7xNNe
=idKX
-----END PGP SIGNATURE-----

--57QIw3vMuFxnPrru--
