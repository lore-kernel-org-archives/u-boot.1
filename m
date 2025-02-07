Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B78C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 15:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4DA80820;
	Fri,  7 Feb 2025 16:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LeXp85AD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA007807AE; Fri,  7 Feb 2025 16:57:10 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11717807AE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 16:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dcdf23b4edso18983456d6.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738943827; x=1739548627; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+vV2vFureGGMKWKfUjnmjMTeVw15G8iL/m2A2BiXIoM=;
 b=LeXp85AD3W2kOziZ0kgdtFYBiL49qaShly+1wR0lhCx7fdDtLJ563NWEV8+omV43z2
 DaVcR1Yy1kkN9xvILlDbFC+Lny3EK2NB1XVDPe7hMREae320O1Y00xTTHZf72kpvmgJd
 3eQnfqG8IR2DMKNR64owWQQTKdCPSNhVxB0G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943827; x=1739548627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vV2vFureGGMKWKfUjnmjMTeVw15G8iL/m2A2BiXIoM=;
 b=e9na7mxUnasReMoJ6Kgf5mgWhcg/Gk3757txFYrUuoyRmU9mooMQb9Lz/K+VVzczop
 CAfuznHbJ2P90FXeFQmhESEBUCGcnTjIMb0lmhL37k4kyTvvJqf5GdTX7zlGCZwytB8c
 4YNzYll2y/txykTtVMQMKkL9PM/4HJN9bBYCET33XzEVOWpDfuUS7kJO+wilfrOV87sy
 A5BzDbEh4Id3xV55MdG1TMWq2c7I/4rxA4uiTJWxFs0SPXnalNTtrGsvLCyWXmYNiqyZ
 SR21RkU5P03SIPxpGMxJbV/w83G3tzUgb0pPuFIvH8SD7hZ10TQIFSU8uZ9rhwkxfUCk
 CMtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb0E/Nu/7IT9AD8FPsIhVs1yIqc+1M60n5kk3mgTUsl0NrNXa3YK+AJ6E20IQPPU3BzTXGTHI=@lists.denx.de
X-Gm-Message-State: AOJu0YwOm4K1L6cs9zZjMhq5kOR9oENzuJg6ZZRsFtDkS7Fb1uDuJcQZ
 6+/p9L1slBXQvsgcap5QKdil8J2n1VPF5G1enhowTtOXq759rGIIfBQjEHREp7E=
X-Gm-Gg: ASbGncsxcHDr6tvcMIc8wqc6nlIejbk76lEHCLYH7bxVR4tbFFigG7cH1kVYg0e5qkM
 5z6mPl8lXHxPmU26pHbSsAQfuNRrXx3rBZnzm3+2xc9kZFP0l3Z7NF50DQ8F/bb6sa0D6sJDhHM
 ZbwEHGsSTuV1FgyWpTPeyfmN40zeDFbs1TGldVz/qRxAbVTtyhd6sUVZEHCtCu2l8glzKsm74nr
 H7fUSxqSql76nZC1WayVq5+tPDRckswhJtgW4bICnKKHOZpR/NvlnEX3dhY9NcZdgXBvT9bhlVW
 m5AMILz8BQCuC8E=
X-Google-Smtp-Source: AGHT+IGMalxVayjXMteQlEDLaZZvzgLDtlVJK8NX8UlFpeDfokscw55dZOgEGoUGBZqIMsh4aXqY4Q==
X-Received: by 2002:a05:6214:5016:b0:6e4:4484:f35b with SMTP id
 6a1803df08f44-6e4456d9ca2mr40553206d6.30.1738943826891; 
 Fri, 07 Feb 2025 07:57:06 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e445621334sm10340086d6.64.2025.02.07.07.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:57:06 -0800 (PST)
Date: Fri, 7 Feb 2025 09:57:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Chang <zhang971090220@gmail.com>
Cc: yschu@nuvoton.com, JJLIU0@nuvoton.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] board: nuvoton: use an event to replace
 last_stage_init()
Message-ID: <20250207155703.GZ1233568@bill-the-cat>
References: <20250207030359.656796-1-zhang971090220@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oitJ4kjkL51j2SJT"
Content-Disposition: inline
In-Reply-To: <20250207030359.656796-1-zhang971090220@gmail.com>
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


--oitJ4kjkL51j2SJT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 11:03:59AM +0800, Michael Chang wrote:

> Add a new event which handles this function refer commit
> ("91caa3bb89b1 event: Use an event to replace last_stage_init()")
>=20
> Signed-off-by: Michael Chang <zhang971090220@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oitJ4kjkL51j2SJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmemLU8ACgkQFHw5/5Y0
tyxAtAv+OrucmoFl1Eq1lhGMq37/WUoUH6N2DLpXUFf1dbvowiBlRZMb7HCQXgyB
JZlchKZKUDTVV1ep0ScKZQxhHM1r6DAAcw6f08zEwEXOQaPFMjb33OOFytCAIaZ7
xZBXEKJyPgPdCIh9FogNnalCGSXdVoCmYEbD+1AMj0LNhDCFOAyP3MWGZQM8pEt9
kbVEhc9zUfMdo1npdK+9sQsCN/+yyZoDuEUtVxLJ6+K5+t1yBxmyWAsAgDivqePr
/J91KF4og9rExm80zAJyA4SzXuCrDWRd3ofeVAVx9flhArgInPNEkPcWbiZ+rvnd
eubi9gEejcY035RShTHKDcbvJGbjijEz7hOUeoFn2Eq2OhG55aVkeCjDTZgoT9wC
m+nYYYWjDhA9Ds4jDmwo9UVeI2YwGcFdZSJBHbYRa1V/IuVotmh9NDtpdnkO3dIE
jXLDIO7LS2KHk6bSt20gwUzhvxNpO7fVoE4XIFbFcqfsrNkJCgXIGoHi4afh/ZGG
BnSZgwnl
=GJtO
-----END PGP SIGNATURE-----

--oitJ4kjkL51j2SJT--
