Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCA7CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 15:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA1588365;
	Mon,  2 Sep 2024 17:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UpvnRAEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D4A88C30; Mon,  2 Sep 2024 17:52:55 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F57788365
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6bf8a662467so22245356d6.3
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725292372; x=1725897172; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P8qhYO5BReHayXV8f0IL74Sqi/E/pvevFkZMQopn8NE=;
 b=UpvnRAEWr1/X3MWJMer4uSaawWCnl+xhxNf0cqIhMegj0us+a4uJDwnnsC6OU9dl0l
 rxkVZgj8sHhnshSlqsbL1ebKxrJHJadaNHLgNEb49LCi8jGRp/QbMtL2tGqL2pguQ3fR
 j1hiaImoX1MTQXFbFqR3zTCgk6oGZILE7fNEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725292372; x=1725897172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8qhYO5BReHayXV8f0IL74Sqi/E/pvevFkZMQopn8NE=;
 b=AXEBOaiUaplsID6gAcxtnnuCYfF8BoBvrTJ3VnPlfFZRSb5HLm194SPL05YzQx4tgo
 0avPARdxi2rVXdrf9cNeguUMXqgb9bFZLR9EpLU1kUL8zuZALA+Dt0zF/JdVS8i3Xlq9
 7TYsLJbPBFxHxZMo3RWAAnsbb7a/TRtwViD5ld5AhYRO8x3+csmwxcySO6/sdhTc1bTT
 xmpOcSWNtzWxmsXMTaNB0FDIRf+Rr1K6eqUuy8J9ta9S6gh695VrJqH4BwUd2cCpstU/
 +JkPerakiig25kUx1C4yYWq58a5m6lhVYanlVcQwtk9V425h6x54KbaNC7Bf5efnLqzX
 opfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTgbdF7aIkO3AOls9jTAK6Bt2DBMX5Mn+0aNie45PomNUZGfAFDnTrLkPum0tfzuIH/aXyuAo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyv1QdpQBIR8Rou/t/ULOBz/ypisGDhL4k8YYgqj+oi3O0vXNL/
 Sk5DJ+wycUedRoEKWdFROg2RUbFyYhVGuHxUC/BW+H8us6cPybJ1mo0UaqJkX0k=
X-Google-Smtp-Source: AGHT+IGdUxELX0cEVOEh31EcAKuadZn0GD4ZMm1rD0AvrrpfXilT9exo4QuaLIC9ZllHtXlh+eoG2w==
X-Received: by 2002:a05:6214:4382:b0:6c3:5bfb:9788 with SMTP id
 6a1803df08f44-6c35bfba2cbmr61066846d6.30.1725292371771; 
 Mon, 02 Sep 2024 08:52:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682cd347asm40910941cf.45.2024.09.02.08.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 08:52:51 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:52:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>, egnite GmbH <info@egnite.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] configs/ethernut5.h: define CFG_SYS_I2C_RTC_ADDR
 unconditionally
Message-ID: <20240902155248.GB2479150@bill-the-cat>
References: <20240902131246.127897-1-jerome.forissier@linaro.org>
 <CALeDE9M2uNVouXb_2zjp7KYjz=wrrC2pN7Hn921mdszmATJbbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OVFLYXoDvbk9Kq5J"
Content-Disposition: inline
In-Reply-To: <CALeDE9M2uNVouXb_2zjp7KYjz=wrrC2pN7Hn921mdszmATJbbA@mail.gmail.com>
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


--OVFLYXoDvbk9Kq5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 02:19:04PM +0100, Peter Robinson wrote:
> Tom,
>=20
> I wonder if it makes sense just to drop this board altogether? I
> looked at it for some other unloved feature at the beginning of the
> year and I never heard from the maintainers.

That doesn't sound unreasonable, unless the maintainers chime in?

>=20
> Peter
>=20
> On Mon, 2 Sept 2024 at 14:13, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > The PCF6563 RTC driver needs the I2C address of the chip on the board
> > to be defined as CFG_SYS_I2C_RTC_ADDR. ethernut5 selects this driver
> > but defines CFG_SYS_I2C_RTC_ADDR only when CMD_DATE or CMD_SNTP is
> > enabled which is clearly wrong. The condition should be on the driver's
> > Kconfig instead (#ifdef CONFIG_RTC_PCF8563), but there is no harm in
> > defining the symbol even when the driver is not selected, as all other
> > boards do. So just remove the condition.
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  include/configs/ethernut5.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/configs/ethernut5.h b/include/configs/ethernut5.h
> > index c327bbbe07d..338306dfe08 100644
> > --- a/include/configs/ethernut5.h
> > +++ b/include/configs/ethernut5.h
> > @@ -55,9 +55,7 @@
> >  #endif
> >
> >  /* RTC */
> > -#if defined(CONFIG_CMD_DATE) || defined(CONFIG_CMD_SNTP)
> >  #define CFG_SYS_I2C_RTC_ADDR           0x51
> > -#endif
> >
> >  #define I2C_SOFT_DECLARATIONS
> >
> > --
> > 2.40.1
> >

--=20
Tom

--OVFLYXoDvbk9Kq5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbV30wACgkQFHw5/5Y0
tyz0OQv9Gmb1IS26+hF21mH9i5jh+hEjLd5XVmDFhDw8gCiedRIfICuAQS2L7Cec
WvmcbmfVunbkH20GobobKIB6Ax+5uL5yoM9k/9jH5YXsliDHbQ7S8eaGVOMnH1EF
FZrPpLeSZ5+bdBRxcOdM3Jlhs2fuvUO4ovaz4RfNdUxM78PihWbXLrVLOWWJOMyF
zSJLdHehIuvl9SiNNpFfNtEy2B+GykTk+mjcoYQnMNDRuVXszySZzYd7RDdpWyAO
c2VZMsysaVZcrFqIIYj1XBUacTnbXh0XjNAiPL2lGEtefT0Uk13rtYJ2DcIKSpTy
pcb83jpuXscz8LPOYAOTtP183XcEgCH/vn4Bl+ad2zpv7H/jwBa7vbMcgRtdpHLT
PQ7Fu6wBEgYy5sB4FMG3XYfF7cBn+P1A9AvNone/0QFmzbbpOt3gkTj7oXjhDRc5
4PZeWsBg9Su6KbqgSX6zYS2o5CBSj+5rqLZsWf85aU3Pd6KtlGSsUD8xyof+98kR
bh8j7ac9
=iIl1
-----END PGP SIGNATURE-----

--OVFLYXoDvbk9Kq5J--
