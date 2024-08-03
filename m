Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D50C3DA7F
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 00:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D11888440;
	Sat,  3 Aug 2024 02:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ghBivcyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513908847B; Sat,  3 Aug 2024 02:35:43 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC7A881A1
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 02:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70968db52d0so2963600a34.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 17:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722645339; x=1723250139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bQT8ymfrRDUY9zt6/2Qo8KOD0zpQjVwwSbNrN6E/PB0=;
 b=ghBivcyKKbAOIBeV4i4Wc2N+0GzB1ERI+ablEfFL+a8dL2fTCwJyxiWxyLz3Fnkbd3
 VUoYVDRY7EztcIPVQfN7uUfgch1jWGxKNaFZk7+5l4uyayZZ9RU4jY3XrQMUI1T+m9hI
 yghvcUl+5XydMejMrTW58jufXH+9rV/Kkrr64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722645339; x=1723250139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQT8ymfrRDUY9zt6/2Qo8KOD0zpQjVwwSbNrN6E/PB0=;
 b=a6fqZ670v4Bl2ip38hXlcZB9Ve2WK338cYnTf39IZwKk/fRt9S8NmxSUC0t/rSV3J9
 akHj8g8AhzsOrjBtFZpttlWxo7C6TKI8SqgzV0K3TOVP9IZayF7enL7N97YkcX7trfIs
 giT0Nq/gz0PICOGRFtgHwXz68LXUOoypnM8fqlpSGCSFm8W+qBzj76cuDFj2tJ0bCF6K
 Mx80Bu2FLXefWt+i9Gm7GkncOCkUTKcwwVY9pcySjCM+UIWWwMo2b83nHByNUrrrk4Cz
 SszXRC34FwnHIR0x4p04w0BKfMbBs9LcQ5SZJuoTWt3iXPicKOrqt3W9sucSUeJisQzm
 mWmw==
X-Gm-Message-State: AOJu0YzPcuKLrRAre+/NfA8yUnBkASJhYf3krGun7xD/6x2Egj7wTGdd
 cYi6PaBQ1ALvOGWJ6oBs4p02LvcR6ddfAI7k8NldcWAQ6DxsL4WmRAovbjNnilM=
X-Google-Smtp-Source: AGHT+IG8ZjYSsG4UmQdL36ITqaaDFAVYUHwwOmX160wzmheQrFfmsqWSvde7xwcj+IU93aVlrt900g==
X-Received: by 2002:a05:6830:6f46:b0:709:3921:7920 with SMTP id
 46e09a7af769-709b99625d3mr5489306a34.26.1722645339690; 
 Fri, 02 Aug 2024 17:35:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31ec1342sm933972a34.41.2024.08.02.17.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 17:35:39 -0700 (PDT)
Date: Fri, 2 Aug 2024 18:35:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240802
Message-ID: <20240803003536.GR3794063@bill-the-cat>
References: <20240802192309.1777601-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HXk7bAxwuq8Cmn/m"
Content-Disposition: inline
In-Reply-To: <20240802192309.1777601-1-festevam@gmail.com>
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


--HXk7bAxwuq8Cmn/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 04:23:09PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit a70d991212c9684e09ed80ece69ce1ff7bfd9f=
08:
>=20
>   clk: clk-uclass: Print clk name in clk_enable/clk_disable (2024-08-01 1=
5:35:28 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240802
>=20
> for you to fetch changes up to 0ee02e1c252da85a6ac75865ca33accde69072b7:
>=20
>   config: Adjust Phytec imx8mm module config to support NVME disk (2024-0=
8-02 15:16:54 -0300)
>=20
> u-boot-imx-master-20240802

Applied to u-boot/master, thanks!

--=20
Tom

--HXk7bAxwuq8Cmn/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmate1UACgkQFHw5/5Y0
tyxaPwv/c2pXda2R+dAHPzTl7ozXfQkCAAW+CqYr2yzvroXaG9N4bgnswBU7MFeD
fGeWgAybWO4DW/jIv89c5Ha5JhFl9GNN5aBBIX0hbNpEzDJ7Qy1wXOt7WIIv3PZ/
Y56Vnw3OZ0x9qYI8S7ljWsCFnOgRoD/HZ23U5cFIhAdG4xoSopjOOVkEOOc3KFLq
0Lhz2aYOjKts2KyzJZcPdEpo5WH+b+rbO0dPUN59p4Xv+ErDrCgQjtjjfDiUBDMA
zeCLu6UvV50x08S80W2FEUhpdIJWZzD2xSStOSYOCnUFNS5RMZG5V3fq1q0NRpIx
yVZM8mP35lOwgx6Aql3vKORnBgz1tKXMksef/iYoD8KwgG0U9SteGCCqeapUBlMi
JhGX9cfy1B6RM4B9jwW5mdyXOzjq9flhOSHw8XEm72GC1zeIi1bw1i/ocNEUCNMi
Z4RZesrFd/Lv+cEprzA3+vbuUpRG95QSuSUJh7oJaq1T2TkSJyf8ypb7/TcbWfHY
Zq1l+XXO
=VuWd
-----END PGP SIGNATURE-----

--HXk7bAxwuq8Cmn/m--
