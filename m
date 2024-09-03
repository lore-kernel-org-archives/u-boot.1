Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B72CD343D
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 15:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD7288B59;
	Tue,  3 Sep 2024 17:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QMST6oO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA38388B68; Tue,  3 Sep 2024 17:11:55 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6862988B4B
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 17:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a802deeb9aso337981085a.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725376312; x=1725981112; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ph1LJMHsmtpatXAcm4sqHv2XVNHFuzrN/NCdoCiW2YM=;
 b=QMST6oO3TyHdX4CawHCSPnjfMSRaXk1HpJaTWjgh2OiG9t9/64RZjHlPuLNCbouEyV
 GLDdqgmmgkjxOMdrEY4JMycGSFCNjbkcZzQGMTYQcwuCji0GqHloDxha2BZ7smqO2j1W
 vIbf/wk8SsETaXWEawMzf5+9CqVHMf+WyV8Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725376312; x=1725981112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ph1LJMHsmtpatXAcm4sqHv2XVNHFuzrN/NCdoCiW2YM=;
 b=MvCtjV0xGv25aUTUf4DcXsSBpNF+yPc+Eld51AuToq1uxfdLepoPsDlJA++NbZLAvz
 +8Uptb9O9sloGw856PhouRfOyg2/N24jGnjiXbarbA7FsxZLpGMXETOBBEd3/m3PYcJo
 g8lRHDQtdkgFRi7xYlXyFL2+QNt6L+ngIy6rDsTzdhktUO2hbv529Zqbw4/rdbCOZAh2
 S8EXj94ZS8W5xo6Zp7JqpUUF8kRF4crX5vg7SrSqFXczVElaZpkWKlkqYM3KRWSVVjsl
 pF2HKOmotHoaHF6kzuNLvBJD9KlUXRuop1JeJE29BlOG4snQit6TzO4TRkYFXZHxQ398
 ytWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0s3JDz+XD1Ry4FZyMib+v80D+L07QGlghesbRGmIBAw7CrBRPVFFTL7e4Ukw1HEFM+Z0PdTo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8zgr10YF+G3c70Op9GfTuKDwaXlZ7+G+TPC30XT9t4kY7J3tw
 9ChmmIQOlR5FYnJb4SvB+YkkEUuv1UiJ71zXTmKMLG5857s7fF7l5K114VGGrA0=
X-Google-Smtp-Source: AGHT+IHRd9CngohIGbaovJEUmMpGZmleyai01T9cbS5PEXOHHbuD21I8yus8SQ2M4oXxsapr5XXELw==
X-Received: by 2002:a05:620a:25c9:b0:79f:b72:fb30 with SMTP id
 af79cd13be357-7a8a3dc7929mr1157600185a.59.1725376312177; 
 Tue, 03 Sep 2024 08:11:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806c2418csm538508285a.29.2024.09.03.08.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 08:11:51 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:11:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20240902
Message-ID: <20240903151148.GH2479150@bill-the-cat>
References: <024f632a-8139-4673-bbcf-0b8e5b633624@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z9vlMYg9tWOShXo5"
Content-Disposition: inline
In-Reply-To: <024f632a-8139-4673-bbcf-0b8e5b633624@linaro.org>
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


--z9vlMYg9tWOShXo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 06:26:20PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> A simple set of changes to allow using the bootrom NAND pages, ported fro=
m Linux.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit ee2af844ba1b27b2e959c4e649e4b769fbeb40=
74:
>=20
>   Merge tag 'efi-2024-10-rc4' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-08-24 14:03:28 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-next-20240902
>=20
> for you to fetch changes up to 35ff967a99e97b523732096628bdbc78758922f6:
>=20
>   mtd: rawnand: meson: read/write access for boot ROM pages (2024-08-28 1=
6:05:45 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--z9vlMYg9tWOShXo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXJzEACgkQFHw5/5Y0
tywzngv/XRAluRlzkXAghrf+m3idRDnHEK+JMxz8xb1sFFZbcrdtSRE3OpC4bid+
wmkTHWihBa8pXlQJHG2sLX5fuWRDSi4tWZ5Ugu2mWJ6KMedQRM9TdYswi0C+XI0U
Zaf0WO15+ZmK8iLYPbH8VWEow1FQBQ5Ritm/P9EHEo1QeKBKmE4vROSsTtCIYEH0
MAJFIgS7S7aiRrg1GxG0V85xLHzKYdfNJpTLiKpWSarZHC7jSxwSYdyMoJK2T8UH
xkE3uDaWlyPlLa499uEYuiHuOJvFJi8wB3Q7Iy9i0Lij+3slUCOuI0GXYU6/vVI5
tTPlxPb8vtll+NrMxhDsMskzgpFxaDWITb2F0FjmqIBL78GiOkqUuVHFnXPwDWHX
teeQPcqq3941UaksVoS6TZuhsPRYI1oTOT1qGKmYINIRNr2v7+hsO6vR8VigGoCn
UiAKKRhnU9yge9YfNL6CgkcUYWz04t0aER3R9Sgd9mBDUKA6OluJO/n/VVD1g1w0
NYvNBrWi
=R7zy
-----END PGP SIGNATURE-----

--z9vlMYg9tWOShXo5--
