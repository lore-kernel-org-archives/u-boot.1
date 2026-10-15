Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A82ECC6B30
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 01:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFF2B608FC;
	Thu, 15 Oct 2026 01:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTn_FK8o1QoX; Thu, 15 Oct 2026 01:52:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3E72608CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792029146;
	b=fuMlC0T822IQ5jQN+XA3oRpg3YNaITLL/qzC23mKPkoqc0X+gTxjfcqeuSxG+4t5PG+7
	 kONRnQWdVRJhoLtRRbGrSm52smLwSIPh/2svJ50Knqg4SrNQS2xLO9dZJ0bGtZzhm362D
	 IdsMGuO4iQDceCY14V6cdlezFB09KyoCxqYuw8O3flfrsnJ+PS1+L7ZQBAh0Y0bRdF8VI
	 kALEfAjAIjSkPmQKX+Ap61I6IxogoEyXWFm4IrM5/g7U60dHbNg5T5m3xqnwg4R46Wdtp
	 Mfud09Q6V+RxvMW9uqogZboAymquD+n6ZeyL82ZzK/NSBulDf6GaeAdivihFfF6118w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792029146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ps6IBqj7+C77nBQ8F7JZVgDRmEVnKTSfXxe4uxsOkYs=;
	b=X662vI1oyMboZ3HH07vO2gCoWTU0Z9vFIg6bS3aq8deFPbSWphZBIaD7ab7K4Z6htxc4
	 kKKldFxxdxkNNCbGDn1qJ0y3zE0fLQrVn0YND7c0R6FDgp4HQ+VFdBXGdKWACKWPBwqhR
	 7BQHkm0pa3K5fojbhVZDCnvOC8KGy4+/LDgnmZyv3LT8bVhjL7/OwCEHAxLpmkP4an4CO
	 d0iUNYCrlhCIANoATHxUMhwkbS12tKh8l2vGO4LYSTW/f2gZ1xuedZIbSNWj4n35R/vmp
	 CdO8RJoUOiDxhgLjBUAIqA1+UEHj7eVZGXtSph8AUbysuuP4i+mieG3TaVRkLkOY3iQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=hKEi6HdV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792029146;
	bh=ps6IBqj7+C77nBQ8F7JZVgDRmEVnKTSfXxe4uxsOkYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0J8EDuo69sfzUaZu/m/1uCvo0/3RtX9MkiyTvmvgsWxcMeJI7vtAeTqxagg1NIW8d
	 iRkrIyQr4KJR+RAXCA2Ui4O6AeRJICA7aoJlmBttRSuoGJyULTCCxgDZhNCHR+GXyg
	 AlY3vqoIAjsqGjdxCk0ge/Ly31g7PLhjz6e9dUO7iXxp6qL09weaJY/uNrZWTDOIEt
	 cNlWcK1YzDdGa4myjTvt76jt9sZ2T54TzqUTz+W5H3HJfs/+xDC1jJ3tFOr0JsOwry
	 hfxjYK5euE9rkw4sMetPFe0NjyysJOPNynEByvb1361rDMDs9m7pcc2d4IeItyw1ef
	 62Im4zLgK5uCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3E72608CE;
	Thu, 15 Oct 2026 01:52:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B0A7255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7144B608CE
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQ_ILlouvvJM for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 01:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BD52608BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792029143;
 b=h1oD958kV5BxfxiUgXvA+d923UfQaRAeKaF8Gt6NnmlWtz7OQDDQ+7/U+ZdmBEgFq8Wq
 qHqXo1lzN0eb6d0b0LgN0KAkG9nzzwrolJQPkUMkLQ9m71E5ySBxI9MfJkFMPyEPt1V1g
 DtZgV4LPXI+0CbliQIdfmRJa9fNDyhVWyOqSsbRwhugG4ZbOdzjv85WOxohA4uYyx/UTe
 JRDDowKsZjcViMp9Rij8nYlaVjwino/48slis5Ak8KU4Ky2saERJ2Za3P1QnPDj7WeUnX
 +NUUSHPBTVDtM98qqiJkvbWSz9UXs+S4F98yl5WeDvqjq2Aka0t0AbEF9ZSp+kDBUiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792029143;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ps6IBqj7+C77nBQ8F7JZVgDRmEVnKTSfXxe4uxsOkYs=;
 b=rfLk08u4rGgA8NCnLa9WwASKUDcrzcaF4utqJ9/VG8Q4vTpIiNIl6ukSNZ0xnw+35bM6
 13+DnLpDOWihD4SjjdqgkUhoIy3IexPaQqjnYGwN/YtdYG876rAn44hLDhi1x3/O9rgPa
 HdnXE2FCRdh1a3Lr4es/ZE4KQnEwcvLQnKGZH9PYQQ7JtZZX12+TaLyeqBjRxFig6Z66k
 dXXlmcO6gSbRKQP9oyL6aiqer/ZGcKud+/hXTGQhKABO6QozQiA+r0EUVQiuz/rq0DZWE
 m80X8RClBvTx8+xHiN9PPVc2/SNg/awTnsdq3Ninn+wuIWXKG5IhuzLwzKV6JYh5wFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hKEi6HdV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hKEi6HdV
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BD52608BA
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:52:22 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8216bf5eb5eso2226885a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792029142; x=1792633942;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ps6IBqj7+C77nBQ8F7JZVgDRmEVnKTSfXxe4uxsOkYs=;
 b=hKEi6HdVhlc1H4NwCPTbkE20/Q/xX251yngvN9ju8E95MdTvMWalbKoHLVj+lqj59f
 6vGwcVc4Cj+dS6cgkr6ovziOfgnWDoK4JCi3b/BXe6HYG399B2FhGlKerMdMbUaDjt8l
 f/lLYRDsKiSSn1ohO7VwzwsTUP6xNvM4mX8ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792029142; x=1792633942;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ps6IBqj7+C77nBQ8F7JZVgDRmEVnKTSfXxe4uxsOkYs=;
 b=WPprfL2kcE1FoJJAJ1su2zPpPvU0MLvyz8zLmlZzemq8C8agpNj4Ij1RoFp6uMaK5e
 SvpGoY+dMBbNmgf5ppH3AHANVSN1WTvuVjLD+Xf8+bzSbjU/hbDfBloeadXLftM0M9ry
 2LJIaHd6mHr3mXLha4EsZaQoyca5VQNuHICxdJVNzOzmUn4y55tXLBo/nY6cWabBGza6
 jzA3TeuQJtfw2Oi5HHRygMRYbhzKw6SaRgNH/5uQigfVwn+nLULJUKbX8PhUt2xWzGai
 jqtZOwu3fJXC4QdfGXoYLi1A8u+27jbbtDXYUPIZ3GY3jDQORg99PQS22oETkkZDaawH
 2S1g==
X-Gm-Message-State: AFq9FYKM/SdYoNMq/dwCbsAek/MF1GZO1XFewutL4HnLVWcYECiR+6Q1
 rqvbCtMRNGdrpD3NFGcu+MLW3oadnZ2oxNVxNXkL5Nmui0TQV1xfC3moeJw4QEubo6E=
X-Gm-Gg: AYBFou3r/9ZBVweOh3w3egM4XTMlULe7GGUhvEQZd0BJXHyFjxHs0IJ/V42bJh/6vbv
 GCZBqUuNRGpqX3a0jQDSiBAt8WRwtqFtJqTLoMFVPD3p6dzqsNLx7TeKgrgUEvbltNSOGIQtwa3
 9VWECQ+oma/dF/n/z4BskR1/NX+DlSQIY9V7r4JrVtQ/tjfS5P6Xz/FevX3CknA39NWci0DF1ag
 78Glo6QK8hZynovj7dvsmZ+f1mAz0KuR2kKrUNWMBg1QBLimG9tdz3JFd+saqoM5OmMQyo5uhx9
 BDqSp91VSCo84l8Dt7pJmF0DXlUmuYX8H11gY05rdneB90jvbJKdrT0cMYFBN7QDpoHGXLOEp8x
 2mULbbhX+kle2Brb9OVh5Zy7H/+VyjTvRvIh++Uh8inE4GObLo+zDpUL5ejP3N47gDasgJ0lt0H
 XwSGE1YihdeeCw0W1/22ke2R9bayp6QGyxn9QIYHmn7A4aWRAS27TOA/cLS0J2tdPEu4L+uctBS
 Q9zlnT5YriTH4SJBIj0455f+Z5pMkHC5WQFu3PnMNMsHfYOevPelhAK59kp+UXyAYYDdZg1w1PT
 inkT3yvXvYhy38NhhbhdMfynrwrZAQ==
X-Received: by 2002:a05:6830:4ac1:b0:806:dbd8:9929 with SMTP id
 46e09a7af769-83095b2dce4mr17877893a34.15.1792029141609; 
 Wed, 14 Oct 2026 18:52:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83618a94fb0sm10907303a34.24.2026.10.14.18.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 18:52:20 -0700 (PDT)
Date: Wed, 14 Oct 2026 19:52:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Takahiro.Kuwano@infineon.com
Cc: u-boot@lists.u-boot-project.org, vigneshr@ti.com, mwalle@kernel.org,
 miquel.raynal@bootlin.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, marex@nabladev.com,
 tanmay.kathpalia@altera.com, raymond.mao@riscstar.com,
 ssunkkan@gmail.com, flaviu.nistor@gmail.com, ehristev@kernel.org,
 jeyu@issi.com
Subject: Re: [PATCH v2 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Message-ID: <20261015015218.GA259661@bill-the-cat>
References: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
 <20261015000349.GA337194@bill-the-cat>
 <889ad89837b346f2ad1d36324179dd30@infineon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I2frASDBstzjAgOR"
Content-Disposition: inline
In-Reply-To: <889ad89837b346f2ad1d36324179dd30@infineon.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--I2frASDBstzjAgOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 01:37:02AM +0000, Takahiro.Kuwano@infineon.com wrot=
e:
> > On Thu, Sep 24, 2026 at 06:10:04PM +0900, Takahiro Kuwano wrote:
> >=20
> > > The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> > > specific fixups. The spi-nor-ids.c has single large ID database. There
> > > are many #ifdef directives in those files and that negatively affects
> > > readability and maintainability.
> > >
> > > This series, as the first step of cleanup, move SFDP logic, IDs, and
> > > fixups to newly source files. Reworking, renaming, and reformating
> > > existing code is not a scope of this series and further cleanup will =
be
> > > taken place in follow-up patches.
> > >
> > > Here is the code size impact when applying this series.
> > > Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> > > manufcaturers are enabled.
> > >
> > > SPI-NOR:
> > >             text    data     bss     dec     hex filename
> > > BEFORE    731133   14696       0  745829   b6165 u-boot
> > > AFTER     732301   14696       0  746997   b65f5 u-boot
> > > DELTA      +1168       0       0
> > >
> > > TINY:
> > >             text    data     bss     dec     hex filename
> > > BEFORE     80492    3744     248   84484   14a04 spl/u-boot-spl
> > > AFTER      80748    3744     248   84740   14b04 spl/u-boot-spl
> > > DELTA       +256
> > >
> > > ---
> > > Changes in v2:
> > > - Rebase on top of next
> > > - Link to v1:
> > https://lore.kernel.org/u-boot/20260612-split-id-table-into-vendor-file=
s-v1-0-dfaaa82cc6f0@infineon.com/
> >=20
> > Sorry, sandbox still doesn't compile:
> > /home/trini/u-boot/u-boot/drivers/mtd/spi/sandbox.c:156:14: error: use =
of undeclared identifier 'spi_nor_ids'; did
> > you mean 'spi_nor_scan'?
> >   156 |         for (data =3D spi_nor_ids; data->name; data++) {
> >       |                     ^~~~~~~~~~~
> >       |                     spi_nor_scan
> > /home/trini/u-boot/u-boot/include/linux/mtd/spi-nor.h:656:5: note: 'spi=
_nor_scan' declared here
> >   656 | int spi_nor_scan(struct spi_nor *nor);
> >       |     ^
> > 1 error generated.
> >=20
> I noticed this and sent an email [1] but seems too late.
>=20
> Thanks,
> Takahiro
>=20
> [1] https://lore.kernel.org/u-boot/637617942d4043cbb3a371fca5fe55c1@infin=
eon.com/

Ah right, oops, thanks.

--=20
Tom

--I2frASDBstzjAgOR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatAxzQAKCRAr4qD1Cr/k
Cs0PAQDUYcn9KstSJKlsgg0sLfZx/C1bZMLIXOGKgSuinR8vKwEA/jg5NVXqkPJO
r3TcsnZpiKDFRjdoo3TyK9TkGsO2jwY=
=LwR1
-----END PGP SIGNATURE-----

--I2frASDBstzjAgOR--
