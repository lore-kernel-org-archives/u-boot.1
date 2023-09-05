Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DA4CA0FF7
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8848E86577;
	Tue,  5 Sep 2023 20:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XUpir85z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1560E86667; Tue,  5 Sep 2023 20:43:52 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E834D86575
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59254e181a2so26902617b3.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693939427; x=1694544227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HZ+4FW2N1n8Sr9PpL8dTKn8nOiYiD1uBijMmeaL7mZQ=;
 b=XUpir85zTvA2oTxXJn1IoCYzBWLpTCTqtaQxMG4hKiEII2WJcFKhnyb6Em6vbJdOY/
 ySWYXfK7v5ouoBAJJKCLYon4r1KH/OM6pyq6GgszjYMlTvxYsH7WDSzWm+fQEyOWzImp
 3bF0sGfMelI8tE7BrbXOnGVTCYUx/oysqhEPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693939427; x=1694544227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ+4FW2N1n8Sr9PpL8dTKn8nOiYiD1uBijMmeaL7mZQ=;
 b=DPBtdLt6PYLxaNsqpviLdpU98UaYCLwiZaSE9ujjqpW6iQ1Ciubws5cCu3OFNZe4s+
 Vuz+AvvAIHN9u2FiOs0cTejMr5MuS0Q2SXL+x9TXjdyKv7H6GqGnEzTpsKjL8EjXkIXp
 +SS4lYNq1UshITmw2D2inO4nyuOjAAhle37rENSPTftHQTGQFvQxGvI2gZWfq4noca9N
 LeXgwNwljijzSuLnbJxuwlqSIhnOM3K4YOlwEkbUNGn9RWFdEOpz+k+XCSZzcJhr8rLj
 SAfNCipW7KfyhKC80DuVgCnYntcH+n7056A+BGBnKU94GlK7hMQr26bWJYi971wVmQeM
 9z+Q==
X-Gm-Message-State: AOJu0YzAYKVcjT96QMR9X0oKl4203VV9fexqvqs8uRXE/ou4lEbUBUhh
 rs3p53PI9UlPvKTqzZnNcenDBa/ggYYTYKAh0xuPuA==
X-Google-Smtp-Source: AGHT+IFuWrw4TV1081Q7hoG32t/Cd0YFnzou65bRyabH0hqSul5bCELjUchwn/FMJIlLlYCG2O05cA==
X-Received: by 2002:a0d:ca51:0:b0:589:d942:5e8d with SMTP id
 m78-20020a0dca51000000b00589d9425e8dmr13861160ywd.9.1693939427543; 
 Tue, 05 Sep 2023 11:43:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-51ef-a95e-1d1c-c7f8.res6.spectrum.com.
 [2603:6081:7b00:6400:51ef:a95e:1d1c:c7f8])
 by smtp.gmail.com with ESMTPSA id
 i145-20020a819197000000b00570599de9a5sm3338223ywg.88.2023.09.05.11.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 11:43:46 -0700 (PDT)
Date: Tue, 5 Sep 2023 14:43:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/master
Message-ID: <20230905184345.GM3101304@bill-the-cat>
References: <ZPag2qB1EH18MN8F@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S204AKIukpUlopq5"
Content-Disposition: inline
In-Reply-To: <ZPag2qB1EH18MN8F@swlinux02>
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


--S204AKIukpUlopq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 11:30:34AM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 493fd3363f6da6a784514657d689c7cda0f390=
d5:
>=20
>   nokia_rx51: Remove platform (2023-09-04 21:14:32 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
>=20
> for you to fetch changes up to dfe08374943c0e898fcfaf7327f69e0fb56b7d23:
>=20
>   risc-v: implement DBCN based debug console (2023-09-05 10:53:55 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/17650

Applied to u-boot/master, thanks!

--=20
Tom

--S204AKIukpUlopq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT3dt4ACgkQFHw5/5Y0
tyykuwv+PLw0PT+s4QwqlZiy5611S++KpfQuFzY6BsmwKYbZuM6VnhWk53t046oc
spH0smEdOSogorrxFz6x4TdsJ8p6hYdg8k02eXllKMyjkN79WgRsFT6wZ9hPio6D
LgI/84tGUtvNZ3jMMI/B/CpyFZCnirC9Zk+8Z5ufTOYlSK1bMGm4AuMfiFyaJzge
KlMF0bcTov2gmL+X11RUqhjkIs/hCo2U5FRUVCAcXAnSDViUVQPh8yQY+5ssO3AT
Lc9LREsxZ3kpecA6+i1MV1JHGuiVxhxsmZyEVVn+UmB+E/ea+AoGP/Ud9aWCJFyG
Xpy9IDX71/t56KOuoCtj4YCVnwi+6p5mgOdsii5kVNRKo3EoC50L3zAtNGNwGutc
aXQ43U3wMGElIgN8YaZxdo4D01k+TSacb17rUkdhTj+ISt0vF3ZLglWzWWufG0t5
K0FS/stAjN0RlWavomjQM5NCNenBOvkDtt0y02LU5RknvsFddZRzBgv6V292mBPJ
5u5Q8Ch7
=INfG
-----END PGP SIGNATURE-----

--S204AKIukpUlopq5--
