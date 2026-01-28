Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADDBD3F083
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 16:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D9184034;
	Wed, 28 Jan 2026 17:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J7GH0VV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D178405F; Wed, 28 Jan 2026 17:47:10 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F898401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 17:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45f09874c4cso45462b6e.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 08:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769618827; x=1770223627; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0qdv8zUef3IBzp2K7WzcShE2AJTRr5C4GQSQUpe5zCs=;
 b=J7GH0VV/0JfozSYEoBDsM7ivSIcIkvE7I2SJ9oRCUpAcYDNkeIHJcwRnDzAGEYq7M2
 SRF08V9axNpm1hTsVMJOkVPAJ/oddLf/QpFDuNdprWgWbuEMSqu5XjGR2/5n6D6zcEUo
 oJDnf/cEl73OlmDNl1/iN8aoXR7QPavAqZFkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769618827; x=1770223627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qdv8zUef3IBzp2K7WzcShE2AJTRr5C4GQSQUpe5zCs=;
 b=ReizgjwTzkqiB5zk+Rz+APlYOXcz9x+EjvGTo0y/h3EmvuOfRtzEgeZ2+O0IWUmpH7
 T/AhAFrN4kRvwuyXS8vzhK9IF5MzAWh0QFy9Hl+Pm0aHUSiATOTEZV9mifcmgehMlEEc
 +tNlqgdGV/9EZZL5ZZo1YMx45nPCX/hKJyXjoJnHbMBSZyzoYJf/c992DGTRdySETcy4
 OxEG15FF9hEksywV2SIMfs4qMCDkAIKS5d35euj+ZsJtsOAaDzQk1oShu8A66ulMsX0r
 egIEn72lYRvZgzExoE7qL4jQnWMHaKSHhvUfUsmA5PqdhfDrG4b+nfJnX8aAG5FJK7VQ
 Ei7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5VdCcihlORy7IBSOQP1d2ot4eVZcgO2kdGYk1V4y/xYtCjn3Q3iyolGqJ5O+xGA9z1jMu7Qg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyn1frWQ+S7qstoOrK6eFDbmoGAN6spD3kJrPt2oLOkbiNbc+Vf
 XIFLs5QlC7NiGjKuxqsZ20nFB9bzjfqBnaX9XUYNPRM20Tmx2/4TYQZTqEu3P3ptd/6IpAQUoON
 F8TO8L2A=
X-Gm-Gg: AZuq6aLrWxzdPG4Xgc6Intwr47uHEAFjYRova9b6UtDo1i0wK1PTn17LSMSy1yXo0TU
 ImAOnaRDnZHineZHcVxfJhiz349zdaUx8e/1/+PJ0YGyFMrSRuq1S1rViHpn7Gjh6ynWXD7Uby8
 IFC2FcHsavTnYJJrGwWuF9ZfH6CxtixlITr8UyjmX+GwEeDNtwzS3cbk6Wg3BrT+nedyPB181xf
 8Z9bWG4aoj0wW9lp2cMqtR9HNW6o2WJi2t7fPe+pImkOZ6/NpGeJAqXKiwEGo4UVMS/FLHYbrqW
 wp4nZ8fBu3MQ+VezAfTuiqxWVYWf91C2q9l7BSQT5XDdj0opuP32AOLm4d7yATYv+qo6g2dlyTk
 7/IeokOoYaOTc8UB3lJgU1cDxGbCwoYaKwCBKgvEoi2tf3Q1liF4JvLOJAOe0XpjwYOktuQFxne
 nTpBGIN/vThpo9CQ3iButVYp/ypIh6VL36+0vFyNCOaVbWLFcO8MZlxz3TTPpWP6pEH9UZ8NTmJ
 CXiou+KWJuObgwWeYe/DWErnhKLKJHqi6y39JA=
X-Received: by 2002:a05:6808:c3f2:b0:455:8b5b:c763 with SMTP id
 5614622812f47-45efc6f6e3emr3225046b6e.67.1769618826833; 
 Wed, 28 Jan 2026 08:47:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08d894f5sm1627010b6e.5.2026.01.28.08.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 08:47:06 -0800 (PST)
Date: Wed, 28 Jan 2026 10:47:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Mateus Lima <mateuslima.ti@gmail.com>, alison.wang@nxp.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv7: Add CPLD support via IFC to the ls1021a-iot
 board.
Message-ID: <20260128164704.GM3416603@bill-the-cat>
References: <20260113142303.441190-1-mateuslima.ti@gmail.com>
 <aXGZVQhGzIrtXY86@nxa18884-linux.ap.freescale.net>
 <CAP8WwTH5=Aqy+QLLRv9QGJ3RTbwyMXA88BsO4eJOB-WawHfHMg@mail.gmail.com>
 <aXbNSAUDjG83gKsq@shlinux89>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K5FGKpMjTocs0h5j"
Content-Disposition: inline
In-Reply-To: <aXbNSAUDjG83gKsq@shlinux89>
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


--K5FGKpMjTocs0h5j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 10:11:20AM +0800, Peng Fan wrote:
> On Thu, Jan 22, 2026 at 10:12:36AM -0300, Mateus Lima wrote:
> >On Wed, Jan 21, 2026 at 11:13=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com>=
 wrote:
> >
> >> On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
> >> >This patch adds CPLD support via IFC to the ls1021a-iot board.
> >> >
> >> >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> >>
> >> CI report build failure.
> >>
> >>   CC      drivers/video/hitachi-tx10d07vm0baa.o
> >> In file included from drivers/misc/fsl_ifc.c:8:
> >> include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or direc=
tory
> >>    16 | #include <asm/ppc.h>
> >>       |          ^~~~~~~~~~~
> >> compilation terminated.
> >> make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o] Erro=
r 1
> >> make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
> >> make[2]: *** Waiting for unfinished jobs....
> >>   CC      drivers/rtc/ht1380.o
> >>   CC      drivers/video/hitachi_tx18d42vm_lcd.o
> >>   CC      drivers/rtc/i2c_rtc_emul.o
> >>
> >> make[1]: *** [Makefile:2191: drivers] Error 2
> >> make: *** [Makefile:362: __build_one_by_one] Error 2
> >> Cleaning up project directory and file based variables
> >>
> >> Regards
> >> Peng
> >>
> >Hi Peng,
> >
> >Thank you for the test, and apologies for not having validated the patch=
 on
> >other targets.
> >In fact, this driver was not being used by any target (neither ARM nor P=
PC)
> >and after this patch it became enabled again. However, PPC targets fail
> >when trying to include the asm/ppc.h header, which is not available for
> >some reason.
> >
> >For now, I am thinking of submitting a v3 of the patch adding an explicit
> >dependency on ARM, something like:
> >
> >+ depends on ARM
> >
> >This way we would avoid building the driver for PPC targets.
> >What do you think about this approach?
>=20
> It should be ok.

This has lead to:
WARNING: unmet direct dependencies detected for FSL_IFC
  Depends on [n]: ARM [=3Dn]
  Selected by [y]:
  - ARCH_P1010 [=3Dy] && PPC [=3Dy] && MPC85xx [=3Dy]

WARNING: unmet direct dependencies detected for FSL_IFC
  Depends on [n]: ARM [=3Dn]
  Selected by [y]:
  - ARCH_P1010 [=3Dy] && PPC [=3Dy] && MPC85xx [=3Dy]

For example on P1010RDB-PB_SPIFLASH.

--=20
Tom

--K5FGKpMjTocs0h5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXo9hAAKCRAr4qD1Cr/k
CtQIAQD2gtV65lSR7NSnTiBzRq0wMG2A12m3o3kwe10DW7WrVwD/RMrtCrggvIAx
jSqAHkxOBOMTglFLO06XjUHvAlC3QQU=
=77PK
-----END PGP SIGNATURE-----

--K5FGKpMjTocs0h5j--
