Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538D8D49232
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 14:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5FE837F2;
	Fri, 12 Dec 2025 15:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K1skFGRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D278334F; Fri, 12 Dec 2025 15:51:02 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032E383981
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 15:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4557f0e5ed2so734212b6e.1
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765551059; x=1766155859; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W2SqQOUuN+v4qorfGocNdVStSymc/TTGx1maD9MRE7s=;
 b=K1skFGRqQSOkJ3sYy2hhh2tq+itiEpe6DkA/c5OcM+qL2KGjgicR8eszQ1OfxTW709
 R9HGR2InyA+Tdj+T72pJP8GATh+iHDpjPjYpg02GkBRzh2mEhDum1HfeOh8TzXCDo/UH
 ARALm0mzNUD3PLwSwVhg8TiXvoPdBrKwT28nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551059; x=1766155859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2SqQOUuN+v4qorfGocNdVStSymc/TTGx1maD9MRE7s=;
 b=TVJ7qilOD9W1vpxn+QkZ1LspkvXoejR9yrH++UOSMPffg/b9QEoOtOFZgJTBt7CpUh
 cNogyUBHPn7jeNtu499DgNcxaKQKIZrfO8u7H4WIDtO0AnhnoDRCF4F3d9FcIwL8Amop
 E/n85LeYqlI3BimbHMae84noxDzCCbfmcYZeAde9RQPis6RrcY2n4qVyNP1HBk7EKT2+
 VdvhTr2ZQOqyEVLKn9x+3nxd6q/4DT7/aO6F3U7O6HZR+ZiOY+lIKCIdInhMdA8c1tJO
 WPjYCIkIdL1ueBuvsLf0Fbebd/vjcJqjmVoX4/BHdmGRxiFnmmt0lcRqhHqdWh+P26wY
 P5nQ==
X-Gm-Message-State: AOJu0Yx4GEfS9o1LuxCMP8z8VcA9lMdtrPArIj5L48xZ7vuQ2Yelrj/6
 JWOl1fKwcA1hG+U3SviT3nRlq5/6MlcrZ2x3xgvXg79DTgxJRw0rE7bfVpLuC3frTBs=
X-Gm-Gg: AY/fxX51sKQpJ3L+OfaN5xjy+sXy3/ujzf/WyqFWon2xVoESgMIxyZGlV6nhUehdiEQ
 xYfjx+5ef48LJ88+gb3/IStPpt/vbcxzVtI1wr5nHlqaqnxepY9oRCrPYrWLhcORMlk/7U2wezT
 /llZGLg57Zgg0+UN5HoGYZ4+09neSm+/Rmyz3wDqKeuZxMHsOXhUDsZ1kVV9Z1w4AN6jFl0fuTQ
 uScCZhzER4tF2ORlAmTH1Ddr7ia2W7333qac32IMdDX1EcDuDZ8TFgvK0GcCPPaBRO4h6K8IlNA
 7pHn20UA34Kz2LbATtCvR3Y9nZPm1e7eg6To08YDjBv+2L/yRFf9BgmoxdBIxby6KRrVidy3Wxb
 5w8eDGh1fM2fLonEpiCCsgvq8qq0F2s7BeccZzBgH5MjjpmtQ9B54SXW3bpeh+Ywg+ar36F5Nrw
 VaWdlxMsb+MGNOz9HRzxndtGAHJKGpKsfcjy+JbeoKyQ29ehzEJQ==
X-Google-Smtp-Source: AGHT+IHANr+9ATXh6BQWcKaJykrqe9CmZ/nxEtfoG6m8uUcz1iw2eaDpANt6vEVVTEmTMA/A10h3yQ==
X-Received: by 2002:a05:6808:16aa:b0:450:bc8e:cfcd with SMTP id
 5614622812f47-4559a53ca9amr2664636b6e.4.1765551058670; 
 Fri, 12 Dec 2025 06:50:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe4e42b4sm1116076fac.13.2025.12.12.06.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 06:50:58 -0800 (PST)
Date: Fri, 12 Dec 2025 08:50:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
Message-ID: <20251212145056.GR303283@bill-the-cat>
References: <20251209025634.14466-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YOh0UF4YPqugKnFm"
Content-Disposition: inline
In-Reply-To: <20251209025634.14466-1-mibodhi@gmail.com>
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


--YOh0UF4YPqugKnFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 06:53:52PM -0800, Tony Dinh wrote:

> This reverts commit b32dda34506b4f486bc803d0c7251f987edd2455.
>=20
> Currently, scsi is broken and causes data abort. I did a bisect and found
> that this commit was the cause. Reverting it and scsi is working again.
>=20
> =3D=3D=3D Error Log with data abort
>=20
> U-Boot 2026.01-rc4-tld-1-g0e0a198a68be (Dec 08 2025 - 17:42:05 -0800)
> Synology DS116
>=20
> DS116> scsi reset
>=20
> Reset SCSI
> scanning bus for devices...
> Target spinup took 0 ms.
> SATA link 1 timeout.
> AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> flags: 64bit ncq led only pmp fbss pio slum part sxs
>   Device 0: (0:0) Vendor: ATA Prod.: FUJITSU MHY2250B Rev: 890B
>             Type: Hard Disk
>             Capacity: 238475.1 MB =3D 232.8 GB (488397169 x 512)
>=20
> DS116> ext2ls scsi 0:1 /boot
> data abort
> pc : [<3ffa5d3e>]	   lr : [<3ffc1515>]
> sp : 3fb65ad8  ip : 0000000c	 fp : 3fb7f220
> r10: 00002710  r9 : 3fb6aed0	 r8 : 3fb85e40
> r7 : f10a8100  r6 : 000003e8	 r5 : 000003e8  r4 : 3fb65ae0
> r3 : e38e39c1  r2 : 00000000	 r1 : 3fb65ae0  r0 : 00931767
> Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
> Code: 3ffd b510 6803 460c (6bdb) 681b
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Any comments Balaji ?

--=20
Tom

--YOh0UF4YPqugKnFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTwrzAAKCRAr4qD1Cr/k
CmwnAP9iOA1JMZBqWjR051jpS9ZujA9QB+lWTtExpnrb8HSPVwD+PY7KEbWrhSLt
rp0To+IYpSK+6V0skimqDRONwEumZwQ=
=eTTi
-----END PGP SIGNATURE-----

--YOh0UF4YPqugKnFm--
