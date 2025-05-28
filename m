Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C2EC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 18:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9537A833C0;
	Wed, 28 May 2025 20:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SH/q7vwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B44E4833FC; Wed, 28 May 2025 20:55:54 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968D28338D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 20:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2da14a6f89aso73063fac.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748458551; x=1749063351; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q6CBdEZxRu2e8hrSyHIzith9TE5jugNxToD/yjBDscU=;
 b=SH/q7vwS3HPNPgXtkAUmzbjdL1hNe8IETj0o6c6uQ0dtNWMujgpUTZMY/7d7rFM8Gm
 bCK9lNm4xk0ONSrjIIo+yBVQ7mZedj03I+A+tByk5uBMxwClMhX5sqpz9u5GMFPzSsP3
 0GGcjBk89+Da9RNcg0Y6J1VJI6Jq6sm5iLR+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748458551; x=1749063351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6CBdEZxRu2e8hrSyHIzith9TE5jugNxToD/yjBDscU=;
 b=Y5P0VzXFd7KPT4eoFy8c/X3aCzdVGVj4knh4I72rKi2CHC/8lBdufL6YTOEOUIx4aI
 6/oqLwfUWCufFzJ3WPJtaWCp/1pE8k2kKrDrVR3qfhLMcX0eAcRL37mSDGlo1CQsj5wv
 wBE9nELcOc/z0bTwU/jXR8MTXFeBY05+0MW8ugx7T5430reBbckDb0Sxuy11n5/b8N+M
 3SB/+M4YqFsFJpvf+B8BPaqYAXdRkU+Mnn81T62kgBqQ0G+Qf3XPhALBBxTmXAoxL5uY
 j9E0y+ZXlrBUyFV/FBCUONqYsoILhgk0HNcKiopvtyf1i0Tr5Ay+FL1mkBsexsbFBYYU
 Y5nQ==
X-Gm-Message-State: AOJu0YwGfpXZ9UeOBDdAQq7vqeTnlUCRnm8l8CfW5N0stezPTm/FtlaS
 WVU5FOexbDZ8M6hDK5ym+4yvY/6TcajFAuebgV4nc5wo07LYjrZDVkrKBgkJIfTvqnY=
X-Gm-Gg: ASbGncskiJs5aMW7QWIofweAGDo7+YFok/BXtU/ReWHlU+cqkRfQVuvJtgdfcA7GMC5
 5BAQW7QdasGGqt6b0f1nYUHICunfq2GIJ8nHQ8xCCO/uz/ANCq21geW60o9GqU/CoODLiRR8sN9
 Kh1LXeVfA0pJtPYGhmDFyffP25witmepyhjiZ57MDyKIC0Isqwe0Vt9Z1+0CTUjokfbY2Vegs0v
 6JIAmab3IYokjQ/6I+O0L7rwEJkvWQtdA3uDr9uRrc54+f1xIQjCoT9mWxZAvz7IecepjQ+SizD
 0x6QEivcjxT+/8mPzdvDDddroQTeZcBtAA5nqH9eprAIKxNGRN1hauX+soEGIUURX6kb8+FOeIh
 nBmvcEH1EnxKEEymJ5o6Jk5Q=
X-Google-Smtp-Source: AGHT+IHgO8HiU54+BofcJ31AbTDhxoPDAhGtDuPIJS94xNiYrMr3sXa/X9VRSI1wiI3V00hJ1gAQyA==
X-Received: by 2002:a05:6871:2c88:b0:2e8:f20c:4c60 with SMTP id
 586e51a60fabf-2e8f20c56d6mr1308819fac.25.1748458551303; 
 Wed, 28 May 2025 11:55:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e1a3be7dsm347362fac.36.2025.05.28.11.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 11:55:50 -0700 (PDT)
Date: Wed, 28 May 2025 12:55:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Thiery <heiko.thiery@gmail.com>
Cc: u-boot@lists.denx.de,
 Thomas =?iso-8859-1?Q?Sch=E4fer?= <thomas.schaefer@kontron.com>,
 Michael Walle <mwalle@kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH] arm: dts: remove k3-serdes.h
Message-ID: <20250528185548.GI100073@bill-the-cat>
References: <20250528090536.765499-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9vtvl96POywktK6u"
Content-Disposition: inline
In-Reply-To: <20250528090536.765499-1-heiko.thiery@gmail.com>
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


--9vtvl96POywktK6u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:05:37AM +0200, Heiko Thiery wrote:

> This file is a duplicate and also comes with the sync of the linux
> mainline dts files. By removing this the one from the dts folder should
> be taken that is more up-to-date.
>=20
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
>  arch/arm/dts/k3-serdes.h | 204 ---------------------------------------
>  1 file changed, 204 deletions(-)
>  delete mode 100644 arch/arm/dts/k3-serdes.h

Good find. As I've been removing dt-binding header files, I'm going to
see what other files like this we have that can also go away. Thanks!

--=20
Tom

--9vtvl96POywktK6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3XDAACgkQFHw5/5Y0
tyy0jAv/UZrRQ1UXWdsalL8s7DZFESPU2xCyhGf3KXzySzcMnYnIqNcGe3KL94up
3lhsWbve5c07KtCdh1k/bFO3w54aSX6wS5s/F73ITc7Zgj6SMY1ICiylJ7lxOMiK
rB+cZUdoYz8Cg00ZC1sNxhmrboemVTa7cWazkjLOuOBPrF5d6AXTwda0sA3xIWZJ
7pIVPIep0qdYzXIWoGy9BgYn2gyXFlDNXVJB3hD021xL1ds+sffTm3uU/SQj5kPC
yNSvQ8IkofUN0BWQIW3TO7CZR9fW+kaUFyqe7G/7ooGrlq1KKvssIt6XgaQc1xGr
dPc2ddUf7TYFla3SoHTIFRD2g2tbT5uWJ5381z6BH+UwANwJ1usT+I4SVUgF2eTN
5ehdRw5aUE0hmckK+s8ayo0VCX2IYsQ4MHIhKltYkL53uBg+AdOOUDTjJNT22Wbe
/wYvbK9vqSgvYgKHi/MndgjtbA8rWFRMyYArVfEZimbEpi1wSvH9GMaeZFy8QCZW
DyYBxPsw
=hhXr
-----END PGP SIGNATURE-----

--9vtvl96POywktK6u--
