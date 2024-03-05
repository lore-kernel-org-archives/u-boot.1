Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD36C54E5C
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D5D880A8;
	Tue,  5 Mar 2024 17:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hjdfCi2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09AC688065; Tue,  5 Mar 2024 17:11:54 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D0AA88078
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7881f80b2aeso54875885a.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 08:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709655110; x=1710259910; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qRt65tTNBW0/7nOKl7aSYCGLLN/grz34oeQRfbw321g=;
 b=hjdfCi2fkoh+Tza/mx0nLTbVRadgLth/ICIz6OW/hjDXhRS3oKPPwUOTNLYVBXrwpJ
 O3n1w/qFa2JeT41Toy805Gn4uxokL4mj51ScislU41OEM88WyXOAAYCUCpS+wtwCIeuN
 OFNWDeJY9nQzNi9dUncOp+FpK9te2qJDSepb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709655110; x=1710259910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRt65tTNBW0/7nOKl7aSYCGLLN/grz34oeQRfbw321g=;
 b=BGxaMBtads8eWnuoYJ6Qi7FAtIi9R7QxBaT4o0F4SDbXp0WdJATFWwL5LhJILWuNEl
 RyC6qSeoPjtflt2/7O7sHGMBhji6fBqYzRIikL1F6SwarYyclOJYWvQ5v8GXaBWToi73
 J3jTs/SGFv/ela7YIfQEj1Cx/A7AKfuhiya5JDDW5BglSePJl6EJTuFkc3M1iaJlyhWb
 LOJdBruUIztdaLmGOKih99VtyZq7t9m2tbIHQagQrB6hvvUhcD3XZTeeyABTrQbAdjRS
 GShDPumoLv6SpU4c6lwGqF38N5Tph/0ipJ9HSn6W77hWvnOQ9Us1yX+1VLiaSZsyJCWL
 0g6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoxKlAqTFKPqVlS59SXwhqhvBPIDiePJ6DgoGTVisNexn7R22voLJHpNFj3T3oNFAikZyhAmdtWnSgQUYsCbB2JCHe9Q==
X-Gm-Message-State: AOJu0YzVvCpWYIo2JUbhZGBf4P5q81jrjwPhfhy4yXqoPnTg9nf0AHfn
 EDE6/IJE7qb7lmjTaRZemdksAx9sYYPJ/fi4q0i5H8ZiQEb4hhNpZZMtPCakyj0=
X-Google-Smtp-Source: AGHT+IHJFaybLEyONms2OWlfuy9NDl593X8hD1+J6/zGG+0NtjaGH5iBjur4jSziIHDl4AF0m4HfDw==
X-Received: by 2002:ae9:e50e:0:b0:783:bfb7:77d5 with SMTP id
 w14-20020ae9e50e000000b00783bfb777d5mr2073774qkf.78.1709655110070; 
 Tue, 05 Mar 2024 08:11:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 pi36-20020a05620a37a400b00787c0e4ac78sm5601939qkn.106.2024.03.05.08.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 08:11:49 -0800 (PST)
Date: Tue, 5 Mar 2024 11:11:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Hari Nagalla <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v3 00/13] Hello Again Everyone!
Message-ID: <20240305161147.GA2810225@bill-the-cat>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t04HOTmFz6bawdPr"
Content-Disposition: inline
In-Reply-To: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
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


--t04HOTmFz6bawdPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 03:19:06PM -0600, Bryan Brattlof wrote:

> **Note:**  This series depends on the v6 OF_UPSTREAM work from Sumit[0].
> Patch #11 was added to fix some Makefile.spl targets to allow SPL builds
> to complete with the OF_UPSTREAM series.
>=20
> The AM62Px is an extension of the existing Sitara AM62x low-cost family
> of application processors built for Automotive and Linux Application
> development. Scalable Arm Cortex-A53 performance and embedded features,
> such as: multi high-definition display support, 3D-graphics
> acceleration, 4K video acceleration, and extensive peripherals make the
> AM62Px well-suited for a broad range of automation and industrial
> application, including automotive digital instrumentation, automotive
> displays, industrial HMI, and more.
>=20
> Some highlights of AM62P SoC are:
>=20
> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>   Dual/Single core variants are provided in the same package to allow HW
>   compatible designs.
>=20
> * One Device manager Cortex-R5F for system power and resource
>   management, and one Cortex-R5F for Functional Safety or
>   general-purpose usage.
>=20
> * One 3D GPU up to 50 GLFOPS
>=20
> * H.264/H.265 Video Encode/Decode.
>=20
> * Display support: 3x display support over OLDI/LVDS (1x OLDI-DL, 1x or
>   2x OLDI-SL), DSI, or DPI. Up to 3840x1080 @ 60fps resolution
>=20
> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>   external ports (TSN capable).
>=20
> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3xMMC and SD, GPMC for
>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>   1xCSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
>=20
> * Dedicated Centralized Hardware Security Module with support for secure
>   boot, debug security and crypto acceleration and trusted execution
>   environment.
>=20
> * One 32-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
>=20
> * Multiple low power modes support, ex: Deep sleep, Standby, MCU-only,
>   enabling battery powered system design.
>=20
> For those interested, more details about this SoC can be found in the
> Technical Reference Manual here: https://www.ti.com/lit/pdf/spruj83
>=20
> Proof-of-Life: https://paste.sr.ht/~bryanb/af2ac108a9362549aa326f182e8791=
8d52bf2d71
>=20
> Currently, while more peripherals are being added in Linux[0], this
> series will only support UART boot.

Please rebase this on top of current -next, there's conflicts with other
TI patches I've merged now, thanks.

--=20
Tom

--t04HOTmFz6bawdPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXnRD8ACgkQFHw5/5Y0
tywuJwv/TDK2MFDtzYNXNCIqDFCURyNX8+YYCTyONfK9VDivDHRfBBCDwMdZGT7E
jAyeymqifwyPQOUSAQQHlxrT//qGbFefHeJueMNiDNozxbtMP6je830u1+JvYefr
sM49rg4S3uOm/u3/g7dy4mIjlxvD7352NbTVhYhnU46T6d65eS/t6eU/g2jjoyX0
y3dCVZOzenwD85iWJjQVzfN+JlpL+0OPXCLVblTcQ6mYtgFkzkZogZHQUwyRlZml
VjHo5hgs5vIV0kVbfJ65hGqng/Vv0vH/L17Kfh2b6Ae+hjeJiwJeQKCGbSXBwNUC
r/zAk+zjfPWzDRxkJTKCssfZeRTXn40+Jxof4/7j8o92QzuMeMJN7auKoBHmI1q5
HZP4VNrDjuocO/rCnXr9umuWC0yypHvCd52En3p33ShLjUbhDWZVj0hlxOIFW6G/
+ANhJ5PltzQ79qlvSerep2ngdEKe2ivlBNSAEQDOwukaTAy7OzeELDtdad1fdtli
ljVpRYRq
=PLyx
-----END PGP SIGNATURE-----

--t04HOTmFz6bawdPr--
