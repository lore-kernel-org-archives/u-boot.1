Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B20CD80C1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6275286D9C;
	Tue, 10 Oct 2023 14:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XR75Wp0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92E486D9C; Tue, 10 Oct 2023 14:58:34 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C018586D85
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59f82ad1e09so70322027b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942711; x=1697547511; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YF+pi+efNqYMXdutfX5BCHUVuOlTMtILgky47T+oW/M=;
 b=XR75Wp0ndVZRF6oHJLcVwU7Fx5Ax67T9AUEWeiKt57+NDySIsjqq6R8eoY6eTexwVC
 J0qmHDfzLcl6ssPPvWnC0KCFI1BYYPTQi0l0V3q3IuJm4U/yZFekbpG6Llx5jd9B4cXa
 iBzIp9Glhx8/gxyHS7jQLw3g1Nixvkgw6EBvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942711; x=1697547511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YF+pi+efNqYMXdutfX5BCHUVuOlTMtILgky47T+oW/M=;
 b=YlFcbtvh/ogoLm/f1DAR6LL5CEN9uRkxbjV6d4NFrgg51VQmoSQDKPcZMaCPpuHjFb
 XpdEmjPq2z0tfAglklTHGiY3q14FUlDh6fh23QL+iL6Bfq6WT4Uw1/AbQyjhoDMQFc6M
 LQIooGQf8KMY3OoseGB3jei+VhZFJ0s6oi6KPaa3UAqFdl7iPaxs7+DmBMA8Hjch2lrv
 bX3Djek2WS2jVXJLG8ePRwfTcqGJ48eWLKSkuUD8L+zhX4kdAt8ORL54S6gCSeJQy9T7
 D0GIWQWaQmOJDDnRyA7Rf1KtoHxRazuxTiTZZLahR/jvPzb+NeEQKz7NVhLYwkk6kFmL
 rOvQ==
X-Gm-Message-State: AOJu0Ywwhh7Ice2vkki23FKhGUuKyYkhkPActues5LKBVjiacSbx7cbU
 welnHSlKUFTQJMlaOy8+SgPwgQ==
X-Google-Smtp-Source: AGHT+IGxJ2ifh6QOWbSLw0Nqtd4+1R0gfg7zeiwYEHbs6yh6bU0OatGtuGFIRqj2PVADCxTEZ82TqA==
X-Received: by 2002:a81:af4b:0:b0:5a7:af65:4ec6 with SMTP id
 x11-20020a81af4b000000b005a7af654ec6mr3133138ywj.32.1696942711527; 
 Tue, 10 Oct 2023 05:58:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 q65-20020a0de744000000b005a4c2316412sm4457164ywe.137.2023.10.10.05.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:30 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, patrick.delaunay@foss.st.com,
 sjoerd@collabora.com, sjg@google.com, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, michal.simek@amd.com, dsankouski@gmail.com,
 kettenis@openbsd.org, sumit.garg@linaro.org, sam.shih@mediatek.com,
 mark.kettenis@xs4all.nl, sjg@chromium.org, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 1/2] lmb: remove overlapping region with next range
Message-ID: <20231010125828.GA2227687@bill-the-cat>
References: <20230926112443.4190471-1-u-kumar1@ti.com>
 <20230926112443.4190471-2-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TvJ5pL82awMLn2E9"
Content-Disposition: inline
In-Reply-To: <20230926112443.4190471-2-u-kumar1@ti.com>
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


--TvJ5pL82awMLn2E9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 04:54:42PM +0530, Udit Kumar wrote:

> In case of new memory range to be added is coalesced
> with any already added non last lmb region.
>=20
> And there is possibility that, then region in which new memory
> range added is not adjacent to next region. But have some
> sections are overlapping.
>=20
> So along with adjacency check with next lmb region,
> check for overlap should be done.
>=20
> In case overlap  is found, adjust and merge these two lmb
> region into one.
>=20
> Reported-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--TvJ5pL82awMLn2E9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSnQACgkQFHw5/5Y0
tywKuAv8Dwpc5NuLf+owPLfeOWuWPJ2BwKADU6ErQhFZ9W6S7lxV8nE5PrC/6b3S
3WsXFlfJGGB9KJCNjBHkDgwldcfz9140l4uKSpQnVkfHDWkI4F5lkUkOm+ES0FYu
uBGEzioQxYt8HvnsT79QBSm8FQq5J7J0zESh6QnJ+39AmJs0fWicgmigjU5gaqVK
iSHJKNuHxcnEicp/1eptgJ/u8VrGx1tVHX0kURubrNZ1kW/13MMVl7/c2QDML/DH
aaIC16WeB6H5MtYFWfjer5WIc+Z7LSNft0R1oHb4z6GdUX62PU1V1N7ZsIkHWebE
DZGq1SHfsQSDRzA/+GeNsPF/DDNK4ETTXJTr2KLzSxd3+j35+dckQ0AfaKx4G4FF
CwX33+Wx6/tuPqt3xJa/bXJ5KNwr7BpAk/jNn2yqcopxP5XbfdoBP870gANH5ruG
VkGpPpFT+A09RnNpn/NLXXF+WahhBJjwzplFNUXKK93GbceSxiJ2Jokhrb3hkQYO
6MHXdeI6
=EXQY
-----END PGP SIGNATURE-----

--TvJ5pL82awMLn2E9--
