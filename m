Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EE4E7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 16:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973FD80083;
	Sun, 15 Dec 2024 17:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I+VnDDYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D747B80083; Sun, 15 Dec 2024 17:48:34 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABB18006C
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 17:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8f544d227so18752536d6.1
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 08:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734281311; x=1734886111; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1GpPIqunLDr1Uk2nZ8odMG9OCv8nfWOCGXa9RrDhmT0=;
 b=I+VnDDYpWLTWvhgzZ3O8m4WEnie6x9o+3u8xpWQ9iKyK+HkrOexHaKGsZSjQigOcY7
 +Y7oewiV245WmrQL/6V9v1y2h7WBbskOANE0BCc15Vuk8bmpZkg9qMuAaR91dx3Vv3UJ
 GW6kZhDmVaQbts6YYyy9az2eXvGZJJV1digj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734281311; x=1734886111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GpPIqunLDr1Uk2nZ8odMG9OCv8nfWOCGXa9RrDhmT0=;
 b=e45qiZA0szrP9wQkdLx4hIFmV4IeeavvJ3p7mPkn++yggHNdVZazZpVNqWwYCnnMgG
 XxExCQ5y+55bsa125oV2JH0WlEqHBhyBhGsz1lYBX+c8BeAsjl2RcMFGFwOliTiQoSKm
 6L29pkRPgZTCTvpAfl1TzEYLXk32BBisW9WliquPhNsgMe6YI2bjDiGKP9uWQuEouAaw
 eo0XHJ3KOpXVv/Wr4dlEx5fDWbj2fswrnPpAM9Kv5oh67zVUOSuvVDbPWfx2DSDyV4+8
 TPPSbt3GZ9yojEZPAsVQue7ZNs9kPWO1Q98xkUhKd7nhn18E8ZSBQfcS6kQNuadq6CBG
 OUVw==
X-Gm-Message-State: AOJu0Ywze8aUoaAvpQ0P2o2WCCxTKbysyEvrNOW9tQyMk/bX01yYQX/c
 v08wW4SVhGyQY4oWY0GR5uindETBu/KVJkyWJ8Bze/yM3XyASj0FDQiEReg1DSg=
X-Gm-Gg: ASbGncsgAPZ9z8D1WEDeRxFGEtQ1LaM6Srpr10uaA7m4Wch/wELjTX/K3Kz1JSvHPsp
 ia7Q7igHIPzV+ZIVTyPX6u2OnRPnI7H1vm5HhsLvrwUZiuyD6g6Mln4A/jSXvmJmuP9ONIv6IIV
 eVwezv9zfPYmZ0M3p2kfLSWY1SUjcdUdWaX+I/KuYPMIWxuW8sRzr+QB15gtDYFIuZe3yrwW32O
 Y/4gUQfsboqjBHrK+vSXgGgL8JmouBodscmDUrJamBzyRnsEaKNepsW
X-Google-Smtp-Source: AGHT+IE7KtjkKkGpuBNubfONaBONYmmbfNfrzqUfDJf7ACTSclpeCOt1pFgyZs2o2sd3fPpstMZy8w==
X-Received: by 2002:a05:6214:762:b0:6d4:3b7a:313a with SMTP id
 6a1803df08f44-6dc9032064dmr141624266d6.32.1734281311493; 
 Sun, 15 Dec 2024 08:48:31 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd26e5b4sm18180256d6.65.2024.12.15.08.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 08:48:30 -0800 (PST)
Date: Sun, 15 Dec 2024 10:48:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] please pull fsl-qoriq-2024-12-15
Message-ID: <20241215164828.GB1505244@bill-the-cat>
References: <20241215113558.GB20989@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ERHYf5IJED9hWy3L"
Content-Disposition: inline
In-Reply-To: <20241215113558.GB20989@localhost.localdomain>
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


--ERHYf5IJED9hWy3L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 07:35:58PM +0800, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull fsl-qoriq-2024-12-15 for v2025.01
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--ERHYf5IJED9hWy3L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdfCFwACgkQFHw5/5Y0
tywWcwwAo67eFKsrBnhXiWCOR1Zc5sfeU+LLgEe+fSrucSjxd/JBqgrARzgZkVfc
0Nd6/dpJDe0M23ZTIpgJYHC9ZRAdRcnRzS4OzVtq0hHDm0aKPzyhJXwesVZcHQfB
tIwIHM7wcKdqhxFtPQECECUbAjYxikXlGT8CIdcwkpx76Elw6vzT+IHX7ZfdkCkE
hdOc+AUX5kRaLgzaN7gxPTR+8Wsihp5wB0jGC/lNA9gnWxj2GnkGa5tbRiUJzuDo
IOw4DvD15bN/hGXwkhZ8/niG+mPDhOqnAb2AbdgTM3FKWJOTCLRxOFd/+29Pu4Gc
AMP3azGlImgqJcqvIUxzW8BQ5Eb4vFvOZ0tFsQWcA5qd/QDkImVk9Gl+glLKBc67
E0o+JJvSn7p0UsVV76vr0TEWygY3hc6u76ZugPWafJOnXk5OpF2OKrGkr9bo+I98
UXVsOfGXmxlbPHH0b0aU4eiSyxdWfU2gJttbAVoM24QRh/Rxvmjj8w+a8p/XEeXZ
wWmxleut
=BvcR
-----END PGP SIGNATURE-----

--ERHYf5IJED9hWy3L--
