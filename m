Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB47BD1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D1F88F45;
	Mon, 14 Oct 2024 20:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k9m8yvXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB9E88F45; Mon, 14 Oct 2024 20:23:37 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9948B88CA1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4606347c791so22414251cf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728930213; x=1729535013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y+9xuUi+kFdThyz3lVWQeC2xoyyYuzw3eTBpPQ+MjFM=;
 b=k9m8yvXNHcZogmEsw/JHdOLFDC33RDoeoje8LpNC5ub8YzqLzqN3NfaXHjL6bNUI4Z
 A4SCYFe2cYyyhumBRxNOeL0kwc27ECQ7vc3hL5nKNUo81pLW0NC4ScStdn03HMO05HtH
 0DY6+Qb+L8di3yR8OoIU+VoE/4AqIV7Dj9QVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930213; x=1729535013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+9xuUi+kFdThyz3lVWQeC2xoyyYuzw3eTBpPQ+MjFM=;
 b=N/yro2gRXBJND1Q4Gn2ah9XeluINY9r891OXkRBJ3ybq5QgiRYaCdNYRDXew3X3tiz
 KjJCXkWAtQ9Aln1Og1KAWolEYuQ8G2Wwo4FWY9X8YEW53zTyu00hE20K152ykDmOt++9
 BjrDXJTEps7yM3OeWfJNPYQ94YA/FdSiHKMkG1Gt5Xl0ZFprWBuZ/w4KqGQjjaGsRD/o
 EpnOwvc2kaWCa0HmwkbcMWDRHivr59YqqZNsE+qH/91zWVjS23NnfuE+9rGz5zCAXy9d
 nrmcqq4xdBI2M0u8Ztb9K3StNklBl4tMOxcyvsfKOAJBuuVpqk4RrayGY8ZVcxcrb5z0
 m0Xw==
X-Gm-Message-State: AOJu0YxTHqNrfrDrRceD/E/TWr9NcsL6Xr9UW2yYVk0USdw/tKwSjCyC
 qr4qOKZhTaLspa1uLslSv7RxvZZXVLjwFUZT1tgDI5YobARIMUBpQGuIWh8wyUQ=
X-Google-Smtp-Source: AGHT+IFDszj/fAsf7polU0wE6knXzEJjuAolMhfaxtuyxn4GA1a39qhDh6Y6mbV8ZftQ9GDN0Nb6mQ==
X-Received: by 2002:ac8:7c56:0:b0:458:3e20:65bf with SMTP id
 d75a77b69052e-460583aec70mr157604651cf.7.1728930213503; 
 Mon, 14 Oct 2024 11:23:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4604287df18sm47993861cf.78.2024.10.14.11.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:23:33 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:23:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-next-20241014
Message-ID: <20241014182330.GR53053@bill-the-cat>
References: <b40c18be-9ca8-4ed6-9121-df9f4f1a5058@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DgWoPo7O0keATV4V"
Content-Disposition: inline
In-Reply-To: <b40c18be-9ca8-4ed6-9121-df9f4f1a5058@linaro.org>
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


--DgWoPo7O0keATV4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:51:32AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This is my first UFS PR with:
> - Set of fixes/updates on UFS core for dcache, quirks, memory barriers an=
d startup logic
> - Add myself to UFS maintainers
> - Add UFS DesignWare Controller for AMD versal2 platforms
> - Add UFS Qualcomm controller driver
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 580fb5773634c4a01f907a164b2a05961840b4=
c0:
>=20
>   Merge tag 'u-boot-imx-master-20241013' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-10-13 16:25:01 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs=
-next-20241014
>=20
> for you to fetch changes up to 0c9c501a87e0070b944ffcd8f0d9942353048f41:
>=20
>   ufs: Add Support for Qualcomm UFS HC driver (2024-10-14 08:56:03 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--DgWoPo7O0keATV4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNYaIACgkQFHw5/5Y0
tyz8UQv/eYFSIPA/P4W4fK6NOss/pNwtWxZmwaYtxxUljp5OjXScHVf43ubNz4v7
irO2gqP0iFbl5IGsMZLTyfuskVm/DWgkWXa3soFJ2ET7ULH/nQ7z2P1oGiCsZ/MV
CakJt5X9Iv8L6hAxczghFvtGkl94gr9jdjmJWhXGiOnIejVDjB4aQ2b7mkr2YF7y
XvX5cgGlazviN2s0LKlxuEwm8XRNpkdDQb9gOYwe2Hx+0RCNnqEOyEijYKg30rFB
i+vrWsQ6zFThtaoWSSyvJeNnm9c51/9mKlwW7C02rufKsJzfC/FprESeGnXg84aY
X10WltgQy0tc50s9l5olGzE602FqrqUtwLGiE/YFGCdiw5lER1/0Y8fhOVpPKfnr
v2NTWXjLe2KO3Elt4FWNQ4na/QVuo9e3YZ0uLiZ1JhL8UBCwLgNWx/HeaSHNk6dX
Q5deFhY7HPmTEi3AjlIwRmZ4W7iYgk+1wSQXwIkz+vqPExS1u+O38ROOeyoszU7L
l01nXBod
=S6Ns
-----END PGP SIGNATURE-----

--DgWoPo7O0keATV4V--
