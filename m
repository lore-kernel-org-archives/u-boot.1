Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5CEC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F9C87861;
	Wed, 20 Dec 2023 22:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dPV+Eb8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5ADE8784D; Wed, 20 Dec 2023 22:01:55 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C8F8785A
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5e784ce9bb8so1067937b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106112; x=1703710912; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1vUEF16jt1troNN2Vdu5pzLWq7zzGcxta0TTw8CDD/o=;
 b=dPV+Eb8DdaP4pbjcvpIWrOXvCnQ8cD9Qrgd34zTJcIwMm248I82VUVU9SllivakbEg
 ZOzCdPP7ZuWVNkliRP0LDXHKPOzrqAaZWe7xhlpP2QEv8wBMEJA/jghmwrVFe7z9Hq84
 y9jUQrC91JcTbqz9krdt/gyrPujUaf0Tmi9Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106112; x=1703710912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vUEF16jt1troNN2Vdu5pzLWq7zzGcxta0TTw8CDD/o=;
 b=AxFgVpPinu/wLZQXZYd/nnDJ9nWdAVLPPs/pXwUfKDVAgsfUXHhnFjdSFAnU+PIBct
 c+We48W4KqERm6y44TX6HBrYtECFSTePmtN8oCl1LNy6EMkfGQUD6ZiKcT/0i7eIsXC5
 unmM/a9SAIwSxtRO6wHdazQm3Qm8BMLxr0fI0r0LmenbOK9RqLASHdG/ukms7y9nQNt9
 qOjhScSwuoOyc9+ivNPoKd5vpqCqf2b7g9F1iJhRkshNBXSRruF6fnjPZlOIhvMMk9qS
 6XgQpo6TaHSpT+Dx+z3faSDGxOUFzfssXZ6RVx4Ac8WP1NxEawBtt3STJ14UJsx1f+ZD
 vj2w==
X-Gm-Message-State: AOJu0Yz+A0Rl+0vaxj/MUsYzn+nmX3NyWF5BKk60BZWCzwWsARyTzaGS
 WjXA5PBi/CHAdp8zTapbbFv5E9azB2nep/R2VE/Z8DttslQ=
X-Google-Smtp-Source: AGHT+IEPuG6060BKtCZULAQvplWTAtXTvTpqRC8/U73b4ZrhhcvCVUPyy7RxoVh46IKGqKdksLCaaQ==
X-Received: by 2002:a0d:d9d0:0:b0:5e5:3969:130a with SMTP id
 b199-20020a0dd9d0000000b005e53969130amr149026ywe.4.1703106112395; 
 Wed, 20 Dec 2023 13:01:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 r123-20020a818181000000b005e7d4a60049sm225687ywf.119.2023.12.20.13.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:01:51 -0800 (PST)
Date: Wed, 20 Dec 2023 16:01:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Robert Catherall <robert.catherall@arm.com>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com
Subject: Re: [PATCH 1/1] arm: afs: Set the filesize env. var. on load
Message-ID: <20231220210150.GW2513409@bill-the-cat>
References: <20231123141601.28056-1-robert.catherall@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xq1GWZfOhirEnbNY"
Content-Disposition: inline
In-Reply-To: <20231123141601.28056-1-robert.catherall@arm.com>
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


--xq1GWZfOhirEnbNY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 02:16:01PM +0000, Robert Catherall wrote:

> The `afs load` command copies data to RAM. Set the filesize
> environment variable to record how much data was 'loaded'
>=20
> Signed-off-by: Robert Catherall <robert.catherall@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>

Applied to u-boot/next, thanks!

--=20
Tom

--xq1GWZfOhirEnbNY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVj4ACgkQFHw5/5Y0
tyyhMAwAj52UgWqwTWapnR1qQe3F9ggvss/Yk73PJfGUsMQKHALKKkkDT+XkzJWU
Y2ZygudTZVo8Y/plCc6r/tfmiQiRObgiojUH8h2/TSC7qhEgJAvnt17rEkOaGGcc
4ieRV/MfVLNyNPgOpXrvYwSykv6rvQinOij3f9KEGr99+2sGhgc5lAx6fxnH0EM5
cBEI3H4b2zRmgGaNv589nqAOD7Y3ErMDqc9y1KUS6t9syPyvvGJ8DnemhDiBgT8e
yAWANCq71r6Hs4aUjvDhWh55bvUkLM8obYI1OSZrVcDprgpFs4Uc06OO1AnpAKPZ
5q7YUCBdHx7DUWpwoRrO3/lRwNUCWSXfiWYB8UTXWuCWSIVUUeEEd9KfpY1cfG8z
rRzbdLudC2nYlabfbpNStcq9FLgYCACIMzwMeNR8w7gQKPcyCKRr7CT3ClwbIjem
UeODwm9j2u+mgESDKZWYJTgBPrH/lT4ldFxB2H4ApbENnmGuBTQSG6OenfumBPgu
JQWWasc6
=/aAS
-----END PGP SIGNATURE-----

--xq1GWZfOhirEnbNY--
