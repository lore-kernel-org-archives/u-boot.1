Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A583FD33990
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 15:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28D889098;
	Mon, 28 Oct 2024 16:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZlUry5or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C8989099; Mon, 28 Oct 2024 16:20:17 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C8388908F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5ebc0dbc65dso2601945eaf.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730128814; x=1730733614; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j3bjAfjCsp6czpbJTGdq9tdDjouF56UWtnYmA5A7K8I=;
 b=ZlUry5orTTJcOXvO/QqzUjWJ+PoAagPfwCKXOSHibOERvXH0upTPwICQ9PX2fr46Rn
 1YDzJKoDYtVvoU8R4emtsO6vcdSlnyVX13ICta2UmFUwXsn1YhQU6jzLDpmc+ggxPadM
 Zj79kJ0PeZgEMgnB885W084L3XEhRC4Z27RCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128814; x=1730733614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3bjAfjCsp6czpbJTGdq9tdDjouF56UWtnYmA5A7K8I=;
 b=eq4rRB4ikC2/5/lupMQgwrj31DsJeeb69BlQEjV1vlT2FTMzzCZvF5rGzS16LfZ691
 wamOn2ADMxYkARFJD4XU3VdlnntbHUP11LQPWuOftZfCQV394W8Um4PAI7mKWWo5JQZE
 YA7j02OwX33cpqRuWJH0+k4xYz7/nc/DcOzWHPFAh53rXgjBqyV55NTGhQ/KWiWMm4l0
 S5oC+1ux/B65/145N5l2R7YgqyHshsaDGcp8f02Dr3YvQjOEPRiOfnlQD8K3Gv6d7Bj9
 if9Y0bkSsSLWOVgTKX25PKhX5uIDcc4H5scoQ12l0NiIjhdI0fOM2A+8A12VgXmkgHLa
 p6qA==
X-Gm-Message-State: AOJu0YwCPubSa8CYYrReCm9MJch/oxAkZ62vA281jtcb7FhYlOoFetRE
 EPJbwSbxXHMCKRCpeRHrTGf/dNOhnVms0A8bZQr7ICgeN1+Lt9cW3GCesLfh4ETsWMQ7T9HK9+M
 BKQI=
X-Google-Smtp-Source: AGHT+IHLytGQXHRnUFvCrTz0HngzgCXF+WJE6WCdnr4Oo0GVDp+1cm3fOW+AFJwhG19MjQbSGU7Eew==
X-Received: by 2002:a05:6358:5921:b0:1c3:6e1d:c434 with SMTP id
 e5c5f4694b2df-1c3f9f68b85mr219753255d.25.1730128813629; 
 Mon, 28 Oct 2024 08:20:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d331b0dsm327365085a.91.2024.10.28.08.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:20:12 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:20:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-ID: <20241028152010.GP4959@bill-the-cat>
References: <Zx-C0_rHzfNmG-yt@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TBFiG5Gqz9d6ENOi"
Content-Disposition: inline
In-Reply-To: <Zx-C0_rHzfNmG-yt@swlinux02>
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


--TBFiG5Gqz9d6ENOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 08:25:55PM +0800, Leo Liang wrote:
> Hi Tom,
>=20
> The following changes since commit 28dc47038edc4e93f32d75a357131bcf01a18d=
85:
>=20
>   Merge branch 'u-boot-nand-20241005' of https://gitlab.denx.de/u-boot/cu=
stodians/u-boot-nand-flash into next (2024-10-05 11:19:24 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>=20
> for you to fetch changes up to f07daa5967f65771f90221ee9bfad9814e549647:
>=20
>   riscv: mbv: Align DT with QEMU (2024-10-28 17:49:25 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/23049
>=20
> ----------------------------------------------------------------
> Michal Simek (1):
>       riscv: mbv: Align DT with QEMU
>=20
>  arch/riscv/dts/xilinx-mbv32.dts | 30 ++++++++++--------------------
>  board/xilinx/mbv/Kconfig        |  6 +++---
>  configs/xilinx_mbv32_defconfig  | 12 ++++++------
>  3 files changed, 19 insertions(+), 29 deletions(-)

Why is this for -next and not master? We're not so far in to the cycle
that next is open, and this seems clear enough to pull in today. Thanks.

--=20
Tom

--TBFiG5Gqz9d6ENOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcfq6oACgkQFHw5/5Y0
tyxUBQv/Q2Xs2fnNB8guEQA8j5RofVr11cOO+nKjN9bKZ503rVuQIyJL2/rA3PyE
Xy0yLFGLKU9V7KT+zgEojjl7HTZZIiy3Eiu/Hbxgu3j3lod3J/rn6SnJgaoTPVjI
PUiweMZKdbZVOytHWMS/fjYX0s64Hem7dETcVfsydzKTRKTFtSy55Kg+LUfDan3a
AhJYtb4w/ClURBFdgpKS6ipyn6QNM6qK0gwQ1OxB/wnbeumb47HAlY8EdRCghO9N
JcnkdOZ6HC6oJm3D236XQnpvVFZl5OFpuyrVzd+TJb56fhOLntC2oeuUr9q0aNus
HMxp8PA1AAMyfhsVtYjVXAPsgEdqZuDDKSq/AL0V+rSt//YQUu0e8LFu/7y/OcS1
Lj/0tROgHVcxO2oMBWdp3oM6sAFc2chFi4G+2HEA9AyB3yaX232wfMYhj4NmFYP8
MFFzolYbwp9OGFWO/SUDCXFOzpPUh9T6GwErUfM0uXDiy8ieK6ASx0rVm8bNyBLo
i39XX7vs
=ytEd
-----END PGP SIGNATURE-----

--TBFiG5Gqz9d6ENOi--
