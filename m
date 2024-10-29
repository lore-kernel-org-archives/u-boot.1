Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9F6D7494D
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164BC891C9;
	Wed, 30 Oct 2024 00:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cl8iuOdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B30C891C7; Wed, 30 Oct 2024 00:53:14 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58049891A3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b18da94ba9so35963385a.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730245991; x=1730850791; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9JgUSiOV8BW4HNOc1J/JLe062zKdE6WS4qccPNo2CIk=;
 b=Cl8iuOdSzm+caVCBfznCCd5PnIeTKYRNaoXzFuiBOP+8F2v7hfLSIlBzPB07h8QWf7
 bDZg1N2d9YbdJwFO5kpt3ui/CPgdVMnMftW3u/+I8KNxylx6mtp6KLwYN2EayKZiAoaR
 sLNCKvLJ+hiTpJPJZ412kjEgdeBKmhVRn2Dtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730245991; x=1730850791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JgUSiOV8BW4HNOc1J/JLe062zKdE6WS4qccPNo2CIk=;
 b=aIhvA9vHlIhsdlNwNSHYoKBX5wPNZzA7lPZ73IblyCuSYQazPpRE4CNiFoGE9zE6cH
 3WQBN27qBkR74//iDYGiMQtp+HDuvd5+mtVXe1eKR8PYCo9W38uIsLXGLyB9FOXbcqMx
 CAEva1c2ooe7St17v51gv3HI6pzn4cgWlvMrZrBnbvi7LqehJ6iAExdHbvGNljZHENrg
 GOJmew/miuvLSkjsAHm1As24lrP/FMDlx9ph6GkibZLRlh3euRuw9L5Iv+Yscgz43ZxN
 wBwGRKWC4mTJ2adwvDJTuKbP09fJ+3FwP7DqoiIEburgDSl0bmUKYpMl8FHM1OaxR/v8
 HYTw==
X-Gm-Message-State: AOJu0Yxh2fBclc2CToSJKZkuEGkkNCoQdUzzvLuuR3LjZDDSR1uNLHVb
 Oev3KHQ0UIdTs6VYfQQ4wL+nmPkYhOJMcFWnpQbdWqBPxfTp78j1f+nAz9Nyuko=
X-Google-Smtp-Source: AGHT+IHoTOEjJKmfZN27DVBGvX5evKkx7DqlBXboYhVr0eJBE8uy/okp02QIZl9pY2ACAF6HcMdeOA==
X-Received: by 2002:a05:620a:4047:b0:7b1:4cc0:5e32 with SMTP id
 af79cd13be357-7b1a9cd2884mr687163185a.9.1730245991209; 
 Tue, 29 Oct 2024 16:53:11 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d343bf9sm462761085a.104.2024.10.29.16.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:53:10 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:53:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 03/11] test: Allow connecting to a running board
Message-ID: <20241029235308.GD2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0vi8JnKNVPpR4CKp"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-4-sjg@chromium.org>
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


--0vi8JnKNVPpR4CKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:37PM -0600, Simon Glass wrote:

> Sometimes we know that the board is already running the right software,
> so provide an option to allow running of tests directly, without first
> resetting the board.
>=20
> This saves time when re-running a test where only the Python code is
> changing.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I'm not NAK'ing this, but this is not a open to errors kind of change
that I like. It also feels like an unrelated "I find this change useful"
kind of change.

--=20
Tom

--0vi8JnKNVPpR4CKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdWQACgkQFHw5/5Y0
tyyBJgv/bz9X9TTjCDwv+kRzR/ifNvap/w31Cu7lU8yaYymQHurNuw5veCdpvGRl
wagwMbFQaeKK5zHPOdvC808vqEMkDii1itQFu/XX6hic9xAqkbzu2SVPn1PYz9CO
HjPdtipwgc/HRdg1GCPaZfX9XMANFP8/uB04uQ5vtGGs/9sv89R8rSlTeVyzuGG2
hnVad2yjmvNlXnwQ0kL45TcNhFM6lgjw6EEkcYFswKLH5TaMrgAHlcaOC8sFknlA
dsL+n4KNzxfXo7tPtFkHfgTL5dLLX2Ncv/2oP0AysawpwHEYJ1xGQsEaM0a+QPPw
7EfBBNKc6rQLUGRhTduOuUvJS69f9FMnVmgVReI2MCmy3jpfWBRSMHSob170TKXN
5m/Q4zG5C7sbMkBwlMpD9wu7H3T4yZyzHLFxHC0dQOWXOiUcQDMVYMFAdQTIyAPF
gpFc7j3ZihDQ3URQyDCh3a85edLrqZ88coRzKU5cvx+onYRN694FkTznbiMPgLUl
uOI38QiM
=W7+f
-----END PGP SIGNATURE-----

--0vi8JnKNVPpR4CKp--
