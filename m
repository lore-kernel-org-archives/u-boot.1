Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7017EEF8FF0
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 14:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0BD83F61;
	Wed,  4 Mar 2026 15:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UJZcnCQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E23C83642; Wed,  4 Mar 2026 15:39:27 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACA1A83F61
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 15:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c9537f90so5005541a34.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772635163; x=1773239963; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eXcRsLGl3I63tzMYGmV3MNF6zNIak5UIxMKaoXJ9glA=;
 b=UJZcnCQhInZ7ohNILewiupVn1g+iguPXci0MamS+YLFBz/nbkUS3OCqIs/jikCSTAv
 hd39ax+7VDP2O9t16hj7s3sGpwINS1cTnF5lxatOD8e9XBLqV1wG3lLh4zZ9yN6913bR
 Sk/pF4pjQII6wxr8/gRRnFyMtrLciSEO4MlJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772635163; x=1773239963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXcRsLGl3I63tzMYGmV3MNF6zNIak5UIxMKaoXJ9glA=;
 b=CGKTo7mv6ujgzUaqDa2oPE3ZZ2wqo02hna/dJorGjdxWORsNOKHb+eh5/GvAfU2dxi
 UW1QNbc7Cn5YINfybaWB47eVunuwE71spvk0bTrvWw5wsk73kCTLJkTZTFwe36/zlMBV
 +A6ZpBMPQPYVvLoTMXNA9ZnJkHsHDqKSKACeHkRexmO9AsonaM9We2o3p6FGDow3VheB
 BgQ1EDB6ezXNoRN+Sw4AGM3pzlOnbdyvEWJzciy04nsiz5P379nnNaKJdKCGM/IsZQm3
 XF3WHi3btGRWjfZeQEmaSIxo1u8zSJ2cSzwiJzv1sfgXivVBuAkJztrfgqa0jezS26+g
 iQDw==
X-Gm-Message-State: AOJu0YwuoeB6I19/tsGmLyDT3VXX2hc63F2fa0/JUZH8ksUJeW/pXt87
 sJ14FkNgHrJRYTAJ5tVXZB6uhDmNThAmrMOq8tX/axKwuVWhkAAOwC6MJlp2ulG3qOM=
X-Gm-Gg: ATEYQzyLSrGJRrbT2NxJJtbV8zH6hLhzNBmIZVC2C7a7/XuA5bQ/S3FvaqJ516zUv1P
 CusAbaXANzYE7R5lCeZQT7qGUntrTG49WG/Mz2cN6HzOG89cy31lTPiJ2RyhUaey9/OtXEeaLBR
 8PIBgpqdDP0kJdjmTOvkyBfwdY7DR0ZD9ljbqgxG9kvt1UmRUMUWcysI8InebukKJ1LouBUBg8/
 +65mzrf0CPSQ5y5e/Dv41qahxWxjIL7fCT66MJBilUEtINs1mTmAmtiSjV+IlB+BIdE0MLIwpgp
 fJCx9KwoSZxwEFSx5ihTOKPN376FCsZpxYN8IAF/8CQ4DidN0VMvyT0J7EHItlHTRxvZiU7CiSi
 4f2Kns/vV5Nwq+kPfsAT2EMFmfueSZ7b8g5wdB3droW1VMgmJ0ZeXsQ86v3OHJZ/g2wYzE6Em+D
 6L69RhBA+kgEc7huHjVxJCc0uxVmzltQRzPcDq9D5eYExCALbPUUcgFabM8W/Gjgt0Kp7Pe+JDw
 3aLAa3mGr8Y4LIqIU2F634BPShocb++8zIgu6mO9gGaKucZV04=
X-Received: by 2002:a05:6830:6acd:b0:7d1:956f:355f with SMTP id
 46e09a7af769-7d6c7f66fabmr1312488a34.9.1772635163440; 
 Wed, 04 Mar 2026 06:39:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5864743b9sm16782274a34.10.2026.03.04.06.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 06:39:22 -0800 (PST)
Date: Wed, 4 Mar 2026 08:39:20 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Message-ID: <20260304143920.GT1388590@bill-the-cat>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mcavv0UY548d+31l"
Content-Disposition: inline
In-Reply-To: <20260304032441.31558-2-dinesh.maniyam@altera.com>
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


--Mcavv0UY548d+31l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 11:24:40AM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Fix and align Kconfig dependencies for Cadence NAND in SPL.
> Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
> non-SPL NAND_CADENCE option. This avoids incorrect symbol selection and
> keeps SPL Cadence NAND support self-contained.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Mcavv0UY548d+31l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaahEGAAKCRAr4qD1Cr/k
CoxqAQDgyQ3cuq1Yhc7Jdq9+uEc2LTIZDIm0LiJmTcEUQRF2cgD8DSp8O+RZ7MBP
TgH5Urzx+IxGHxVQ5VzNdal9MQ16rQk=
=hJdx
-----END PGP SIGNATURE-----

--Mcavv0UY548d+31l--
