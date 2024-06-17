Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E746C2BA1A
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03A488398;
	Mon, 17 Jun 2024 19:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qry0syD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5704883B1; Mon, 17 Jun 2024 19:43:08 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E798811A
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d229baccc4so2255963b6e.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718646185; x=1719250985; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jX7WAjhooRKk4tXAM3BPYNQD/j2dwBU8fhCBQAGUBOA=;
 b=qry0syD+FNH9MqkBd7+m3p+Uh1VjoofVrIjrKWeHy0kZ91/FB78/nkni+9b7UFNrkS
 AZUjoM+JzDKiYvdRCUcypHr0FufCVkon16HBQeILfsU1urlx7iEaGuZz/XVjsGsUp1dA
 /BmPGq2YeJcjp/gmI50VMBxmq1moIfu7HKrV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718646185; x=1719250985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jX7WAjhooRKk4tXAM3BPYNQD/j2dwBU8fhCBQAGUBOA=;
 b=la/HYV7sgk3goHxzy8/z6D5PWTfhOFwuf7v3wDPelQOeKIH+PGlaIuecuQnfzJodyF
 pIhscxTP9uwgQRqHKFRl2jK3aLSHivK8WmCMJuIn1RkDLhCUr+V/p0neSnqGag3GJ4H7
 ZDJiYUuz3N6OHFPmzvRbw+OtKRBwLX5QcSUZeyaV7o/3RpFT2wOcGz5RjBpnS/9oGaww
 zPoEm8KhHcYtFlOv8fv+snDYnz3Y4Qm2Gv26J0Se/R2XilWn4LAti0CXzZNICPtMZCI4
 rdB9Wd7eKEHXZBYY5yGydIL1RLf17JN2bBeCd9wQH2chEW78rM35PUSKKy1Co7b3YbdE
 jC2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7XQH8DjOFE8MFJNeM9GPFFabFIMFgLB+aeGKwlk4uwRoYhhCEozQN67xeTxRTrKf1qmi2M90i8j2PwMSAR4e8HIl4tA==
X-Gm-Message-State: AOJu0YzRlRIJd8SXF55uERHqHT9Iod8xo9CynFTijRudUmvGsxU37NkU
 qFPQ9Do/AsHZZFEc0wPjXLv39A8p9IQhwI0bOr6AtPZxVA1f0PNBIGVC+Xj4/fQ=
X-Google-Smtp-Source: AGHT+IE2tLtOx0J6kKGlyz04JMS0tiysSm8KhX4Hc1SWZeBQ3MvD1gNQ4ZIcYOpAHuXoNfqJ4icIwQ==
X-Received: by 2002:a05:6808:1394:b0:3d1:4261:6450 with SMTP id
 5614622812f47-3d24e984639mr13013636b6e.39.1718646185422; 
 Mon, 17 Jun 2024 10:43:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d24762c09esm1538301b6e.25.2024.06.17.10.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 10:43:04 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:43:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/4] Initial support for new Tegra 2/3 devices
Message-ID: <20240617174302.GD68077@bill-the-cat>
References: <20240615091950.239610-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sFnnLZv5sE67LAjX"
Content-Disposition: inline
In-Reply-To: <20240615091950.239610-1-clamor95@gmail.com>
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


--sFnnLZv5sE67LAjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 12:19:42PM +0300, Svyatoslav Ryhel wrote:

> Patchset includes initial support bringup for 4 new Tegra 2 and
> Tegra 3 devices which include Asus Transformers with Tegra 2,
> Microfost Surface RT, Lenovo Ideapad Yoga 11 and Wexler Tab 7t.
> All setups are tested on real hardware and pass buildman.

Did you test it in CI as well? Thanks.

--=20
Tom

--sFnnLZv5sE67LAjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwdaYACgkQFHw5/5Y0
tyztxwv/WB/3+JaPkLFUbnByOrP+sNVidKCYJ4W24CnR++tFGJhNZUFyLbeeeESZ
8s9Cx0gZGdft/pSBhxN765PrXo34s2tD7VshoVneBylEoRNcXNqkZNO+iGIOqyst
wpTADtvgL40s90alCDlLeiq0D3ParlYpDG4L1ZWePuMgVWo2Pw059ny6vOXa3Nsy
3kPn925n5cv7G5opn0T/OMET8NSy5OJuMZtqmfJPWE39a6+2iEFzsAQ8aNZatRPX
fPEZSZGnN9nAhFxEpxFuJYrXEJMk3VvD27aTpi0HeDyDEeo1rtrgtBVwAushiT8+
VcHCdDq9+U8Mf3CkzmOL84aVSMeGx0HfSZbRn75G3FD7sUBJG6Dk6MXtVkXR7fZ+
/IRETyIjTmX29GCZEi+nZdtEKYJAvzCjuyb5f8WM1ML1gGHoWoFH/JAlVBvmYKAG
E1YUQxy58fN1vbl1YTaFUFcgMI/PdMaEHLAh+L9uodo2L+lup+o3GY4UU4gPc2BN
0Yj0n6kO
=pUW3
-----END PGP SIGNATURE-----

--sFnnLZv5sE67LAjX--
