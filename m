Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48441C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9123884F1;
	Fri, 26 Apr 2024 17:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gyy34Bt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31107884F3; Fri, 26 Apr 2024 17:51:22 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DCD883D9
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78ecd752a7cso150291085a.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714146679; x=1714751479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UVDGGm0Bn1T1lmR24poQV/M8kMSRb4axZ9q+CS/+mIA=;
 b=gyy34Bt/mqmfkxdJc4VsK835Q+0Emxxqwn7w9Pdcg2pbhx/jaKGrImiTq93IhwHtRx
 Lr1w4KBjYVUBgoVFs3QBb5A4HkrQkLDahhJOJ5RAEDTpIn4jQQCNde8/gyPftL//2Wh1
 sdY8qzTifPCr/useNDi5OlJksmPtBsmSvfSOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714146679; x=1714751479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVDGGm0Bn1T1lmR24poQV/M8kMSRb4axZ9q+CS/+mIA=;
 b=toDJh7CjoBv9XkJWkSpotP+RzOpMSjBXKpjg6TpySSGiY7eJRErcfEXbNSOW4kB3Rg
 pJvqzcNbkY1nWD8pIWRFJre83pGWwYnivUByk+a2zV1cGnfNJCQz8RmASHCLqOFTnne/
 XnEmhVIq8PbPByszKhmD8O8HpNaidruXun6yIxkkK92ySAnoCtoos6QX685vKU5tpXVT
 ATYErxFjfCMFhoaN1aS1i5CXb2OnKL9dB7xManXl75D0Vf/eyYZRHYVqe65Bjw8CCO1t
 zTLnjLQ9a/xDhHCmb6WTlDj01w8QLPYYKYdU7G22HQP3v7s+Nbl4yAhqhlKBM6WeTONQ
 yHsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ7kF3piB+ho+pYcAT7RBnJQDa5Dl2oVrtofQngk2as3KRTVeWNp4eBlrukR6sm1lBiwq9YAX0eaaQiaoUY/npdBQibw==
X-Gm-Message-State: AOJu0YxE3QqvhY9eV9zIC+CdLEnyD5vfL6DgS7dCyps9fkEG/Sc7Rvv3
 NnooHm7yrwNx9uOY1pDD33Chm9mlcOPNoBZvZGEXcc0Y9Rmd9NBft6zcLwVgm14=
X-Google-Smtp-Source: AGHT+IFN+wVHkf4TfF81BQsxy3HUkDZbA5vzOFFx6kE5rMSnbDJE8U0e83rtY1wzVjuAqj5F7rZQWA==
X-Received: by 2002:ad4:5be2:0:b0:6a0:a541:79f6 with SMTP id
 k2-20020ad45be2000000b006a0a54179f6mr3506186qvc.56.1714146678852; 
 Fri, 26 Apr 2024 08:51:18 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a0caa48000000b006a07be4361bsm5190006qvb.6.2024.04.26.08.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:51:18 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:51:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, kernel@puri.sm, u-boot@dh-electronics.com
Subject: Re: [PATCH 2/2] imx: hab: Use nxp_imx8mcst etype for i.MX8M
 flash.bin signing
Message-ID: <20240426155113.GH1054907@bill-the-cat>
References: <20240425230721.497441-1-marex@denx.de>
 <20240425230721.497441-2-marex@denx.de>
 <CAJ+vNU34Zrn8znALzZqsDnkWifhVbz3D4D_hyNurKzH0cn30Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XszCgWTx0gAI+mYX"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU34Zrn8znALzZqsDnkWifhVbz3D4D_hyNurKzH0cn30Lw@mail.gmail.com>
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


--XszCgWTx0gAI+mYX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 08:30:23AM -0700, Tim Harvey wrote:
> On Thu, Apr 25, 2024 at 4:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
> >
> > Update documentation and use nxp_imx8mcst binman etype for signing
> > of flash.bin instead of previous horrible shell scripting.
>=20
> Hi Marek,
>=20
> To be completely fair we are just replacing a shell script and
> template file with a python script
> (tools/binman/etype/nxp_imx8mcst.py) which also creates the template
> file.
>=20
> I could care less about shell vs python but do put huge value in the
> idea of making signing easier and doing so without modification of
> U-Boot code. The current implementation requires a couple of things to
> be enabled in defconfig which can be done with a seperate
> 'out-of-tree' defconfig but this new proposed implementation requires
> changing a u-boot.dtsi which is a tracked file.

A counter-point is that with using binman for signing we start
eliminating differences between different semiconductors on how to get
something signed.

--=20
Tom

--XszCgWTx0gAI+mYX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYrzWoACgkQFHw5/5Y0
tywC2wwAov2iTi/ykYfhD6sOgvLS9ayvNO68Katowxn+UnyELE5nAhYvJk4nKrnK
H2eGHyPZQ/sLIIvUyj0jJWAvBh7VOt7Qsat2x1ROr3pfb2p5TiU1HvARWRUcLqBE
aKnFRAh/btr3mRv2jWutOY2CLNlyhoUp0tvwOMuPeby94BVtP+v8UKOdxfnl5cyt
Brugr/L1O4aiG0UJjlS6PrdgUGXY9KjsMDTDwTVsxkTG5JUrivFSQloxBIpWUDgu
o/e5jGleGhsNN1fHOzjwCpqmVAzDckB8y1I5ndVthnutgVroZ6lb8FNZQ6164czi
8RT8aVSRuVONmcQ+kST+//VHzRNFAgNzbk/YtQwSVV0QCkaO6Kh/T9PiY0LVZTwa
8psz5IijYRJZ5ALL/6CUTW26Ud2qqDX+D47v70t6YUDdc4tWz1YWZTNUi3hW/cw9
5BGc/Hdhtzi60SJCPpfuASb9JKyKYdcsstV9xqoon+tqNNjKEolKAtr6oQ1NnZNZ
GX/aoZyD
=rJuo
-----END PGP SIGNATURE-----

--XszCgWTx0gAI+mYX--
