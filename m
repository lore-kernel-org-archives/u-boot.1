Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E01FD4F08
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 17:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA960840CB;
	Tue, 10 Mar 2026 18:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lP6nTQHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7AF840EE; Tue, 10 Mar 2026 18:51:17 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCFF8409A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 18:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d73ccee442so3029254a34.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773165074; x=1773769874; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VU4nLi56XHNM+8cnNeZ7YSStkRHlkmUwyP4ztG1Hzi4=;
 b=lP6nTQHTIJ6CMGsUHIufq7Lyj+KLYzaUK+K0HrkezSBD/TZk1hfkHqN+2RMcmNnxR6
 egF40XtlfBoMxQVW/SuIRfrkU7GYuQRCePzkp5/orFMwzj6/+HS963gqT1uaDsT+brnj
 KcGZGQ/Zv5QD4BU/cfTzGjmfw3R6CmfJBSprQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773165074; x=1773769874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VU4nLi56XHNM+8cnNeZ7YSStkRHlkmUwyP4ztG1Hzi4=;
 b=blzS3IgSHmujBfCmR/0bYM33mdyyvQQxpBJcEzPWwBLDd9udufZoOiVWN5dXrY+awb
 X2z3R/cdos+HMCUzlUEoO3uZMh8td94Sv3f0vAA6KLzS4/V+bZaCHtR3gxCWwb1pz+3O
 dgpToK0W/aUyjE0RedJ/M475Kv8KCTX1hXFuI5cIa9uPm3e8eHFPIZCrRIjYfmP+YnNV
 uEC62ExYs6+xx0lYd6zxtbSXtL+/agqsHs+gzNi3y+GZZTH+tIrsYRXyLi9TuIyFmYer
 uBJbVpMj/EUOTdV3sjwzW2bmhMCNEg2MgTheLMbqiE7t0ENgNGdOwhzOt3R+5a0r2iLI
 a+Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2BFR+nuYsNkG6hNbEQvfiPdBMLwzhCBlusvhOi2gxNcfHn6/9Ylid4i+o835IyfYaY2lfjzg=@lists.denx.de
X-Gm-Message-State: AOJu0YwR93NfPoHI+PB0CohzR6loL365k1wRsbZSIklAPRj1fqxiEMI+
 mkbx0ah9yQnWX/jcEMPZ6zIyBx8dsPnegnha1aE75HkPs79KFCpA7fT1eMYy/+s6ACA=
X-Gm-Gg: ATEYQzyF1Y6GIOhj5sqMPL7CXsWmPJlLnaSTSAD73/Az7FGnZu2skywqc3LJkimuW4M
 KlzDOfrOBQjUJPpsylsBx2Bz9RTyEF0TpdQZj0QZxZpw7gr2o7RX1Lv997PCJSUj2Qhoi1P0ThR
 4szP/ulE2rz+24UQ/qjq/LV4zVvVc54pW4se1Mn3ahpTTAtySelXRKhdIsGZ1MzvYpf8xZH53OS
 sVMuQvKjQ1Mg90bl1WUzTXzyL8g6myg+IKB0oUvJT8okY8LXJDO1fUEBRTwY5YWYgD3TjtO4/sY
 2UXB8ZL+gIVmTghyv6YCyEoij38QrqF01cy007t06470Oy7E1roh32npk/OGSwujlHlrC1h5ygW
 zMXtFTz7RQe0IJc0DA8u8Hg4sGpMwSXZBQVQPl0Vscv5NVN/5tqrR2YwNEGt3UgJpYYrLtlsIud
 GqpcjSDARMUXzwdXIv9WCSw04dCCjXJU1zv3jbZ36CpQ4iTz1q7W8zx+9sxGOUtVVQfXF9IKrx0
 ONY1MiEfXVwKNmbVrg+UI/cmbSkiMaNh8Bc9NHKEi9LDA==
X-Received: by 2002:a05:6830:620f:b0:7d1:9217:94e with SMTP id
 46e09a7af769-7d72702d716mr10293453a34.26.1773165074097; 
 Tue, 10 Mar 2026 10:51:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d75039b811sm3766764a34.16.2026.03.10.10.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 10:51:13 -0700 (PDT)
Date: Tue, 10 Mar 2026 11:51:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, u-kumar1@ti.com, n-francis@ti.com,
 u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH 0/2] Update AM62AX and J722S CPSW PKTDMA Resource Sharing
Message-ID: <20260310175111.GL1388590@bill-the-cat>
References: <20260224120557.1476390-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uZZJmkjuWH/XGVfx"
Content-Disposition: inline
In-Reply-To: <20260224120557.1476390-1-s-vadapalli@ti.com>
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


--uZZJmkjuWH/XGVfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 05:34:46PM +0530, Siddharth Vadapalli wrote:

> Hello,
>=20
> This series updates the resource sharing for CPSW PKTDMA resources
> of the AM62AX and J722S SoCs while maintaining backward compatibility.
>=20
> Series is based on commit
> 4f70106beaf Prepare v2026.04-rc3
> of the master branch of U-Boot.
>=20
> The updated resource sharing changes made by this series have been valida=
ted
> with Linux running on the A53 cores of both AM62AX and J722S SoCs verifyi=
ng
> Ethernet functionality.
> Test Logs:
> 1. AM62A7-SK:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/ecc69e5d9cd3f09ca767bc2=
108ce1d0d
> 2. J722S-EVM:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/d5b3509d548be194fbafb41=
480a6c15e

Please rebase this to current -next, or if critical for v2026.04 please
confirm that. Thanks.

--=20
Tom

--uZZJmkjuWH/XGVfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabBaCAAKCRAr4qD1Cr/k
Cp3qAQC1wZItB72o9LulaIDRhfD0UbO6Z09das/3I7ujDkg99AD8CftsspfF7sgv
NNR2KJsbX+lLltBuffu0IO/G/FMLOgc=
=BPJ1
-----END PGP SIGNATURE-----

--uZZJmkjuWH/XGVfx--
