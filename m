Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C13C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 21:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 691C087A39;
	Mon, 30 Oct 2023 22:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aeSWYQjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204E887A23; Mon, 30 Oct 2023 22:35:45 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1665F879FD
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77897c4ac1fso340668685a.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698701741; x=1699306541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sSf7DZSYKCN246A2D5Uy0UGDgRccg8VRAwf4zqTGQXE=;
 b=aeSWYQjQKTvjAV2n8ZLGyi0bnm0CfvZgPII+qQhj4KdWbZNu2RZIb2kNMhLJXuw/tn
 /iK+b+MBtKycjWJZMULcEUKazQxKz5sKPvgmuBdLA5UssHzgEJF2PrMOOB5lq6mpGqN8
 pad84g6PEOw9ZisWd9ZvbPVWBImoVkC4SqpaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698701741; x=1699306541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSf7DZSYKCN246A2D5Uy0UGDgRccg8VRAwf4zqTGQXE=;
 b=t9TbkM+US/E6wXpHf0oJSEssPdSWS58Lipsl8gKHVIEMvkQdulZu5wq1+KPm4Jswa8
 Drj1k/DYu7D1+Ifrnu/0yKkcgLqdmOeHyQly8v/C6Atq4ZRXdm4OfW1PAeTI0t2IwAJq
 5JlDy7+KA2jwEFE7iDXx9zsnbAhFAPr2YpM/QK/rP7QMDSSR+evm4YbB5e2w+yDxzbh2
 zbULMRi9kfc1f77XknKk7VQ9PRKiCEWjK6gVH/bVHabjX/i3RWuBuUPD7Rta1Og36nug
 z2wpiOb2fw/U9QiQsLDSGevGYvcNhj8zESrgJvw4tzawB/HtfwO5reVn+gsgEmK/hpWP
 01hQ==
X-Gm-Message-State: AOJu0YzJn2uRIY1vJllLR3FMHOQusJ3OqlMcT0dUQWscgK1hzk6vttAY
 rt3nWV9Lf8+3we/eSaKQ//qddGUDyj3wY6SejKr/AA==
X-Google-Smtp-Source: AGHT+IFsG90M+7G3w480/aSVbtiUXBiSUpLOjN+cfxLbYwV5351FMhbQpikW/Rduch7Fb15ncHJF9A==
X-Received: by 2002:a05:6214:1d25:b0:66f:bbf8:d665 with SMTP id
 f5-20020a0562141d2500b0066fbbf8d665mr13274811qvd.25.1698701741370; 
 Mon, 30 Oct 2023 14:35:41 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 c16-20020a0cd610000000b0065d89f4d537sm3781557qvj.45.2023.10.30.14.35.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:35:40 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:35:39 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] common: Reword CONSOLE_RECORD_.*SIZE help texts
Message-ID: <20231030213539.GZ496310@bill-the-cat>
References: <20231019150435.750483-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Y/zKZg8rV4w+5tq"
Content-Disposition: inline
In-Reply-To: <20231019150435.750483-1-trini@konsulko.com>
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


--7Y/zKZg8rV4w+5tq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 11:04:35AM -0400, Tom Rini wrote:

> Make it clear that in the options for setting the console record buffer
> sizes that we are talking about buffers for that feature specifically
> and not the general console buffers.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--7Y/zKZg8rV4w+5tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVAIasACgkQFHw5/5Y0
tyzrBwv/SpK7QaalhoBtcK203pOcH0Jh+WM9NxcPaVumtnINjxojPoplY/4DjhOO
I7TONWiVZnAJe/j2A7QRfhWEEXPzE+z0Qvfjceo5C2ykBeNTC85ZnDay4l97Tfa4
H1Nu1tRDJ0TMKkQ+hi2T8iKziKPY/7eokQLkl0aSuU4ozyoQIcrY+0gCMIoNDPnm
2pgAtkfW6GjOffEU+oGKh7AiGsNG1UfYBwODslI+4nGjYHcDW17OwVSVgqbn7xIt
CaU/36V2hJjNEYl2yw8DFaKNj9DHFqjle3LI4mtpHKuXKFoRA71Qb+4E5rhQRHyt
PTNGTA5WmgG8aYxNFI7EpEfH3S7k0pAO87v24yfZyth7CT+q5IHXeamh4fQQGQIn
eI2nks0SRDqUh5p9DvdiLs8To8T7hzTvpF4UKgdCuyB8h+swK4x4eTxx4BDZIhA4
c3KTgTufyfvvtHqPo1oNMKve/8UirP+25ie2RkIBGqp5933QmhXYPrgvpKb5qVyL
e9FRgGgq
=P14H
-----END PGP SIGNATURE-----

--7Y/zKZg8rV4w+5tq--
