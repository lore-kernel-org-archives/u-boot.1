Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42963C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 13:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF6C4886FD;
	Thu, 30 May 2024 14:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gIjv8kZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9471A886FF; Thu, 30 May 2024 14:59:58 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CD5886FD
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 14:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43fdb50b928so4486361cf.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717073994; x=1717678794; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b+JnxhDQaev+nO6Rys9xAZU9FqJ1yC4BXHviZiGXVQQ=;
 b=gIjv8kZnVjeegV6wYWt3PxqxMHW7LU5+yid0cvQTdPs40hNn7ar/aCTgy+km+qG6GX
 t9/Pw7epdW+8liR5qwBl/rzXZ+qaYnpgnS44919NtBLTkSVzqwPcmzVIhkgsguPp6HBu
 yP7kCv/MB5d0QjsNIV4SzopIvBsEextoI+7Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717073994; x=1717678794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+JnxhDQaev+nO6Rys9xAZU9FqJ1yC4BXHviZiGXVQQ=;
 b=eWfWOLJ6+K8MxfkC9NeCyv0wWpHJHqH6dmWFIZ3f46/sr06E/1qlriNvdZcGaCcFk1
 m7zL1fbOcR1cZKquQ5U6CNoM+feuQQu9DmhlHYRFzcsSzPRho4apajtnlknHWonvMft1
 lxD7TPtQjTpIYKrvH+Vq7Yi4gEFbxPzxQ/atULKaLawrFufQ2ZFx7OcQCma67EXMyPb6
 Gf/5LMvvv3O5EdS/QJ4f7f6k8y8Wr+8TgtFqprKjyeWNDTaR7lOStEP4dFBvXeb8MBVj
 RMS21urzVE2rvAzW1Kkc0/qxRPrFbdR3GTfJaC3EMftbl9UCKvtowIIxhSZZyCaB7M3R
 NRfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX97AZqHGJUGj1Xs/5xn3LRGFovtMqUsa4e64Sk/j2Xw8U03VDJAaNolWNXPHm440uvEC3pERIiDvnhm5rdxoDiO3VqQ==
X-Gm-Message-State: AOJu0YxSZXh8KeDNgSvI0Fb5g7YN6kCd7RFR0E+QWiJ8o7KkCyVNkHti
 b3ArIj6MTFogdVveYRP47aPRcS8nbSsGL1XDZoO62siVFs73U1GhRse82abUx4M=
X-Google-Smtp-Source: AGHT+IFgh3Nrtdv7/3RS/gAvFMRXyWkdtsF9Qlu65sz4TsuYtnCYw0MgY5hWglzNql7fyEIrK+4Tlg==
X-Received: by 2002:a05:622a:188a:b0:43f:f07a:248c with SMTP id
 d75a77b69052e-43ff07a2ac8mr2935841cf.2.1717073994540; 
 Thu, 30 May 2024 05:59:54 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fe7567b30sm12116611cf.29.2024.05.30.05.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 05:59:54 -0700 (PDT)
Date: Thu, 30 May 2024 06:59:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Andrew Davis <afd@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: mach-k3: am62p: Fixup TF-A/OP-TEE reserved-memory
 node in FDT
Message-ID: <20240530125951.GI3714513@bill-the-cat>
References: <20240520-am62p-fdt-fix-v1-1-49845dcb3667@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DEqm6LCsbdj9UsB0"
Content-Disposition: inline
In-Reply-To: <20240520-am62p-fdt-fix-v1-1-49845dcb3667@ti.com>
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


--DEqm6LCsbdj9UsB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:43:20AM -0500, Bryan Brattlof wrote:

> The address we load TFA and OPTEE is configurable by the
> CONFIG_K3_{ATF,OPTEE)_LOAD_ADDR, but the DT node reservations remain
> static which can cause some confusion about where exactly these firmware
> are exactly. Fix this by updating the reserved-memory{} nodes when the
> loaded address does not match the address in DT.
>=20
> Reported-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--DEqm6LCsbdj9UsB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZYeEcACgkQFHw5/5Y0
tyzOhAv8C978ec/7knKKGWtgAjYsR8ltA9WP2TPWKt21CpmGbmBzukpRyeGRxybY
Uxw5UNOcasyaLpeZFsGvbUzYh7aB7gG1rzM0f6/toq4OiHPD4zwGspAiUXQNfaX7
drdnHmIJtGPJQty8p8/o0c6Sz+Td49r47VvUOef5ui0P31VT2cXhEWo36On4TJb/
SLy6wiSnV7JMVXfmbYE3GUhEJECuka3b2MPdkn1b2v2ZgPfdmkIJ5/jCNgIWE3d/
ABdgXJdhIjz0BgE+LVAwPyGqK5tAt6DfxB22pRS3KoROAWnMZ3/xAKLU6hbG4T4X
T6viS5zitio+FsA87Gy+lY4ZUGZ+eBTsAnDp1XJaCqeRQOJyfZ12+WMpQVqXxFA4
WGjXSlnL/pRY+UkazmqjC+gKepJmPTQpzLJ8M6v7isM4RHu1d+oC5u4RadfabJ7T
sBwzfnduPXNMLff9O7yKUhP7ahI5AUEKHN4tRpfd/Ab74QqL2KeNwCP1ZQs9Hxom
UigeEORa
=m66U
-----END PGP SIGNATURE-----

--DEqm6LCsbdj9UsB0--
