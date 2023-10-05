Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC95E92707
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E84586D53;
	Thu,  5 Oct 2023 16:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GEqOwuT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0ABC86CB7; Thu,  5 Oct 2023 16:49:38 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B69986D30
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a507c72d3eso11919857b3.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696517373; x=1697122173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BxWAgO9qiF5xAEraUu8qOxtAryc210wuiUDnX+QOC6o=;
 b=GEqOwuT/I5CN2Md7mavGYHwPmhz9G9vb1QRxf+PvT/BxDNGVowyZE3Nj1D70ymWDW9
 tDdrWixLlUY3CL8D2uoqbu2i+aha7/jZSXZDk8tWtzFQg50Rf28IT/6OJWo9DK9mYW0M
 2vVkHS5rRH5BEkVYJpyzqp3bqsIQdF42MrtY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517373; x=1697122173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxWAgO9qiF5xAEraUu8qOxtAryc210wuiUDnX+QOC6o=;
 b=vNCS7IkQrTJjA4le05Hh200I+N/bS3GOYvFd2Mt5ral7+xgkJM0igFMdZH8LdWHfNe
 OQUWoEtwujihN/LHbv8hkOdX5Mp28xzVm06HVlZg6LMsnmbtOVywvtlxA1lChoAIFFSY
 8NwVhVu4ufwbUp+3afzNTgKlE/TDb80ZHY+UgKqTvFRbJzeRE1hdzpvEw0ehNY7MQLoG
 6Bj0gxo/FG89TR8gpnRgMkMesrU8lBuK1jNWGudVCxeR8yo6cANh1KJ2wrKAjWiiLvSJ
 22k/S1P68BjfgvvEc8z8wDqtiWeqFPFfMd2V63qf+S+3u4tbnO6+6eJa0hpjC/gWiT0r
 +0zg==
X-Gm-Message-State: AOJu0YyvoiplYXJHC7wD5HFqbsu8SWujmG+NmckRLEFPlQ9r0IUqvAXi
 X1Etm3eVhOv5eQstHQ37uwRHKA==
X-Google-Smtp-Source: AGHT+IGGalNp26OSSQmROndEOi7Q9dKfuR4gzRcoyn4UK9d8SSbMXt+2NdLf+V1JuJ7ZCI9dMenPMA==
X-Received: by 2002:a81:8104:0:b0:59b:bacb:a84f with SMTP id
 r4-20020a818104000000b0059bbacba84fmr5854728ywf.47.1696517373420; 
 Thu, 05 Oct 2023 07:49:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 o64-20020a0dcc43000000b0059f5828346csm555312ywd.3.2023.10.05.07.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:49:32 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:49:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org,
 jonas@kwiboo.se, srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] arm: dts: k3-am64-evm: Fix boot
Message-ID: <20231005144931.GN8465@bill-the-cat>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <20230929134646.214781-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="opGfJLwliNyZmfGn"
Content-Disposition: inline
In-Reply-To: <20230929134646.214781-2-rogerq@kernel.org>
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


--opGfJLwliNyZmfGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 04:46:41PM +0300, Roger Quadros wrote:

> Since commit [1] A53 u-boot proper is broken.
> This is because nodes marked as 'bootph-pre-ram' are
> not available at u-boot proper before relocation.
>=20
> To fix this we mark all nodes in sk-u-boot.dtsi as
> 'bootph-all'.
>=20
> Move vtt_supply and cbass_mcu node to -r5-evm.dts as
> it is only required for R5 SPL.
>=20
> [1]
> 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc af=
ter relocation")
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Nishanth Menon <nm@ti.com>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--opGfJLwliNyZmfGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUezPsACgkQFHw5/5Y0
tyxyRQv+NaFX6GOn66obipp78AbgsDS0jnrblxaincQq2bxWwQbTkD0w6yzkID/P
SuZkzZQbKXFU95ScoSr1S1CnCmBvJLUIzgPwla9lutzfjcZ+wIKGl8gslDTdMEnP
gmGr2hw8b93AXzqvJbhtZeIPj0cCAX+DQpLJgOWP4L+IddFFUBS1j5KvbUJgRgF+
s8W7XJRBEBbjs0JOpDZow37ADC9gyGpE772CRMwQzEsT13qLPbjn8QBfmh1bCZ+i
mKlJPKSQZ1prqQNEus76i4ZmMfB2faR/ZDBd9aZxxU+DDjQqfCx1Ohl2PmC9wOpA
nJDeaT8LzW9X1cIGuVzVuHA9n5HvVaWSFCReuanTiWOzvXX6XHlR0IuK46hRpF5d
rd9NT2JJnwag4wL+G6duu/6B7v46/HoH9983IWh5hTqk5Ra8iyXa3/cK9JsHweXJ
LVKaMuh8KWb2hjJFTaOenCiUG2MBdzD91xPAlZl2ABgWesa5smCg21s3lW0+yoZU
XtySL+iA
=T5vv
-----END PGP SIGNATURE-----

--opGfJLwliNyZmfGn--
