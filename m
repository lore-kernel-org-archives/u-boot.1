Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2583D11195
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F5088FB5;
	Sun,  3 Nov 2024 23:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lSz6+uKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8463089030; Sun,  3 Nov 2024 23:46:36 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 290798912B
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-462d8b29c14so1666591cf.1
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 14:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730673992; x=1731278792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9tXJ/41keO4ItNOEIPd/KjDuwjbidw+6FOp2Lie1uhg=;
 b=lSz6+uKWVLRCC0jkrWZdKAQcVT20Yu0f42GVmjLy7v+CrgOWZLfVfAAVZ2Xe7z9kud
 Tp41j2IolqqPobJmSEbRIx+DiKzXlN5Ujf1eBVMFjjiDg+FdT1OByg2x80veI5hndVZq
 u5fA4/zlJPTFINhC01dU6IpqmHlpaiIgsJnNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730673992; x=1731278792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tXJ/41keO4ItNOEIPd/KjDuwjbidw+6FOp2Lie1uhg=;
 b=E4tKAmePonz9aGkHcGi+pM20/hKtffNSS+AQ6rxslbxWcEQNObXLFehe1/oRHShIb2
 /yDi6w3Fd0l8GfwTvd6/HEikwoJgMLkYU8JVxdFdNzscePGYmZUQ/h/ZNV5T4hl12zIZ
 J1+FR6m37JznGQBQgyCrCAFnnYvpwe7Ici4JI8ipVJyMjBfjs+qZrFyLkxHgX4ddfaM4
 hiNluS1m5Ko40Ilk0eA4/oTH4Npi4m4GxfNJwVSGJD08olhKru+meAORL94VtJkJ3kKT
 ctpwIi9RoeXFpgCY0DkHGNdNOgaMW79tgEOf7WKZHT/c2AzmQ/SJJ0y1TdeKOKa8BaCh
 3QZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDeQx5s0YOiWxON3io5wf7A+j+zLGJADcxgq8wnvibhyHVnDLMoqVy89f/tF/LWtObxUFEFWQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyovaO9+zzFfmYgqaeAq1/dOXPsxICg57aStfGMHEIiWQ4yq/Eb
 1Dv0tm/G8rbmgP2w98JSy1dSVQBG/TUhusEVa9hEu/sfNH4DoI0nKcKTQp0fhDU=
X-Google-Smtp-Source: AGHT+IErJB3ylHteFGFNHkbnnf8il/wNmlALNrI4ylvrVPHzAimnuQsk/r46Ku4yIxs6hsGK52ULDg==
X-Received: by 2002:a05:622a:408:b0:461:6157:99d0 with SMTP id
 d75a77b69052e-4616157a277mr277811881cf.41.1730673991958; 
 Sun, 03 Nov 2024 14:46:31 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0c7009sm41146511cf.43.2024.11.03.14.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 14:46:30 -0800 (PST)
Date: Sun, 3 Nov 2024 16:46:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: run longjmp() test only on supported
 architectures
Message-ID: <20241103224627.GF3600562@bill-the-cat>
References: <20241103175400.155790-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UNSeN+ZgDV/Wprrf"
Content-Disposition: inline
In-Reply-To: <20241103175400.155790-1-heinrich.schuchardt@canonical.com>
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


--UNSeN+ZgDV/Wprrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 06:54:00PM +0100, Heinrich Schuchardt wrote:

> We have only implemented longjmp() on the EFI architectures.
>=20
> Define a symbol CONFIG_HAVE_SETJMP and have it selected by the relevant
> architectures.
>=20
> Use CONFIG_HAVE_SETJMP to decide if the longjmp test shall be built.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--UNSeN+ZgDV/Wprrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcn/UMACgkQFHw5/5Y0
tyxuPgv+LHep7BWBVWOJ6rW0ppczo2JUeC8In2mmc+tAF3AYHGdchAPcLOY/KpAw
LwL9qrL8fVS0pPCCRH+ZGkvs3N5iu6oeBeLIVrv2nEdKgUg+BBj4rknZAznVkZyY
SMziBBDndGYV7ajIBqaL00rz1LPZnvT+RcoQOgJmcLmkWMdLjyGNbdXqd1rHJEm/
oHOV34IpMS/pim4VCzjJbvpMTEQYXiPbIQ0+BpBOYEV+jt1yZIlc1E7ZatLXk3hZ
FbR+bDmbgxh3eWzDwotfjvtJ3THMWODC4JDLkwwvSHRxPoCmJ6EtjwsRvCKsSFmA
VD+dnMinD0PB9EqE5zJ32vcGYxYFxno9/vn5ELuMR5CsbpRoyPBpIRUtW6m8rrUU
MBuk5RmQW0JfUv6TW5CgPcVfwWIpRgG1uSt/ms1deMcsFN2dZ565wLRk/BgIXLXN
qUfMXze4uIYgqwlVnukkI5Z8djFQ5b25pwE/ZMX86tY3dhQyWVXICY282fMSXhzK
cMdrbLoA
=MhFR
-----END PGP SIGNATURE-----

--UNSeN+ZgDV/Wprrf--
