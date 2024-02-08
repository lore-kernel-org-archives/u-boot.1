Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F76CC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 20:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EB487CED;
	Thu,  8 Feb 2024 21:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VVHlxnjH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4976F87CF9; Thu,  8 Feb 2024 21:19:00 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8680587E34
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 21:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-60498c31743so2970607b3.3
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707423533; x=1708028333; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=422oiRhhLWfVhJobgkg0Z3TfEExcrbOGtJr38uEa8ZM=;
 b=VVHlxnjHgXLPQXk4zdCNsus+j8WcKC1phTvsyu+BKwMZbGnzawQuKWR0jPJGN/nZWk
 SKK1ZqsiVoDjSksANed6Y0kKnysIY09kUaQrEhvavsQuv/jPOh0rAYfd07nT5ZCMAa2d
 dXW68Au0NUxiyFt3BkNasczw3yH0XWCQ4KZ1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707423533; x=1708028333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=422oiRhhLWfVhJobgkg0Z3TfEExcrbOGtJr38uEa8ZM=;
 b=Xh5BgHZ1PkM9vjLJbxVFsPvVXchZj5T6sc6N6Q/BLxxjyZ3VQ3SJZSAQbxZJoM87wh
 Ssw+KV//94WwdmOqNz/0lPj+oJ9loqOkrUm22p3DtGSFMk46+770OLHnj3b/NdCAnl+S
 aBVAWVFGxJFGfenue8f0WBMqirbJg165i4JsdopOZSGZqVD2IOAzFdL3xjb+1bcy1Jq7
 lrlwVVopz10R5o/D7+ghCSSiZ4CE4lr9CihdaTPuk8tpGZhCWJcIJ7KmAUV5ByvdaAXT
 +iijAsMeyeKpDJ+slWDEG8FTWq8XTZP3gvrT7YXuGdAEEL/JGdsxtouG/p2MFUy3Mkvv
 leiA==
X-Gm-Message-State: AOJu0YxlvT3kVpuPYrvtvEEIZjpGVHfEJjcAWnttSY6//dKLdv59/VE7
 uI3LQp1VSYBG/cP5NmCrNDWLXWHfoCVqjGq4suB4cyDtAdGW3RvbwqQ0Of4Diul6VETC+NxUX1F
 bbAg=
X-Google-Smtp-Source: AGHT+IFVbGFT/M3If+uJKYsaTO9kuMFWp22C4PddzvKKyTOy8AVT9iZYbxeeCQPkl7LLHQkyFf1gjw==
X-Received: by 2002:a0d:c341:0:b0:5ff:d871:b4d with SMTP id
 f62-20020a0dc341000000b005ffd8710b4dmr482748ywd.44.1707423533301; 
 Thu, 08 Feb 2024 12:18:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 i204-20020a0ddfd5000000b005ff8e964b10sm23885ywe.35.2024.02.08.12.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 12:18:52 -0800 (PST)
Date: Thu, 8 Feb 2024 15:18:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: Please pull u-boot-imx-master-20240208
Message-ID: <20240208201851.GL1152441@bill-the-cat>
References: <20240208143633.1345238-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vIr5qdJ3Em+ZynBA"
Content-Disposition: inline
In-Reply-To: <20240208143633.1345238-1-festevam@gmail.com>
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


--vIr5qdJ3Em+ZynBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 11:36:33AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx, thanks
>=20
> The following changes since commit 0101a2ffe125911ebf89172b495f5ff14f2fd0=
58:
>=20
>   Merge branch '2024-02-06-assorted-fixes' (2024-02-07 09:47:47 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240208
>=20
> for you to fetch changes up to 8dcf1df48dff339b172d1bce2a38a965ee4aafca:
>=20
>   phycore-imx8mp: add support for booting and flashing emmc via UUU (2024=
-02-08 10:11:46 -0300)
>=20
> u-boot-imx-master-20240208

Applied to u-boot/master, thanks!

--=20
Tom

--vIr5qdJ3Em+ZynBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXFNysACgkQFHw5/5Y0
tyzDkwv9ERbh//tzbZ3QcyuIUrZq8q4mxvksunG9+oyVm/XqDj+eqZcyqYoo45c1
qBiWha6KwO1U61cRV2Z6MHUW9c4P8fu1hOo4VZpOnITPr8Du2VKxFyL0rVx3YZTz
7yySRrOszsJwCrUuZ/WSTquxuse5acJKq5sL5WXatATE8wCm1JfzhaYKjFQWXHle
cNl5+14sNAy1lS6nxnirHzV4f1D/rHzxvMwpvPsH/sFKeMs4eJUaQC5cKZemvUgS
uphyytkt5Ipgqwzd8uZB+W+2gsiFzpYLJXtrCDUldPVYu/POYK989q1x/TlaJ0Lr
RCLGI8VZ4xmZBzQAxjnTNxugW7qEaKHujNGzj6DNoq/feNWK3vMHCXq5l4EU7HUj
N0ZaX2UvlbzBTC808a0SpiTEJXHXL073mXTsOw6GReG9cyVNB83zfJB9p/QjhhVK
+lYGSdymfgdFCQTL5HIA7qvNaPRGMqZiZpdYkh/m0yTDQDxsWXgrbpF4d/MQD4RZ
VEN74pQZ
=l3Q6
-----END PGP SIGNATURE-----

--vIr5qdJ3Em+ZynBA--
