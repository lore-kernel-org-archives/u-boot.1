Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B9BCA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 18:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6011831B4;
	Wed, 27 Aug 2025 20:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fniNxcqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FEA8831D3; Wed, 27 Aug 2025 20:36:32 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F11E83106
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cce5be7d0so90215fac.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756319789; x=1756924589; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/AT4P3HW2MytULtr0m85bq3qBEqb7TqWNPFbQnsfAGY=;
 b=fniNxcqWhq0Gy5d+GBjF9Ym7mNYiFVSWdi6N2skpbNeua0qEqo+nZxhIDgweVGX0iN
 Yjq4l8S2vUHDncnH33xYewvyVeLaRIcAusDtrn1Qo7qDdCM9mgeYbmC+qQBMUk2GzNDL
 b9PCjcDNlpNVXtJx2BbDuGw1OefwLCnGxGGLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319789; x=1756924589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AT4P3HW2MytULtr0m85bq3qBEqb7TqWNPFbQnsfAGY=;
 b=C3bAsyyqJlTntjf1+MPlv6wBu5B1Tlpo4ifwCbG4/SntouDYpOGUjTxVIZ2xgGpV7g
 B1uLW71WMlZSGyt+3IG5bKG9Tm6j38KZHHJQHRHg9kJDcTxb86F3SH38/9LnNE9kEz1T
 DSvgOeOEV+sz+uPem7+C0Hii715fqdQUKGGG5wgeC1fgmEPu+sMCxW7FsiuLqDvrzkPC
 EzSJKtGwg4RLeEUqu2WQNGIYGzHqf7BS9EEKorcBkugPUAorHU3iWzuv7EvRn8opHDIW
 kGk3MbSU6USCCq/17o5JIhXBYq8L3ysrMtpGrCv8HG3xkGZUCbRJykBdsRiWZFj7XUMQ
 /DIA==
X-Gm-Message-State: AOJu0Yzf/MpST2wUvvpBHtXj5YD92mtR9gxhKuqIYX8BNtE/vN6N1IOr
 wx/+348jmtBHYONhntf2PgT7KAofyclYEUOzDKlNhwSGUHR9avlZOab1oVTe9pLKcmI=
X-Gm-Gg: ASbGncvewOZb53Gtex4m7w9ZBR6Pkt5DwKZf92IHHb6H6j/yGtzdOQ19nftrZwOQYxf
 /wlfqxUqfwXX+F5Txrlf0WTFatmlTdkPwUXwjTY6RZR+UPUa23yjchSYQnjwd3LGAv35UvACQwe
 wW66gknu9YaVGnx0pguRsBGNji7eoBRFHd3sw7eaFUwCKMSFo0So8XWS34MMOcJ3eOz28vNKUfv
 exPwbltp207IB2zXIIw6kmYbWpZ0O6hu1teWIEm0UPeVmaj2wtbzkoBb/jCzusxQpASm3WpLf5n
 Bt4s7qs+/LCTAoeZuBWsN5EQAnYMwcFESCPVo1AMr9JRg+a5bPLtj38gloFqbIalOM2ph6/kxN3
 Elpq9apVLml7fHa/uiDoEEAOC6vYBWYVD1M9S/mBrtaUyXP6lN6eEELAS
X-Google-Smtp-Source: AGHT+IEPo0ZvTODGM4ki8gfrKH9H4vfw1IRgPkHZSrrQv1DyuZaiuhUhqk/lCh2ra+MaowWIq1CDpg==
X-Received: by 2002:a05:6870:d693:b0:2d8:957a:5178 with SMTP id
 586e51a60fabf-314dcbb7fd6mr10238165fac.21.1756319788568; 
 Wed, 27 Aug 2025 11:36:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f79ab6ddsm3395016fac.6.2025.08.27.11.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:36:27 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:36:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] i2c: davinci: use mdelay() for multi-millisecond waits
Message-ID: <20250827183625.GN124814@bill-the-cat>
References: <20250827110846.39686-1-bhimeswararao.matsa@gmail.com>
 <20250827183055.GL124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0hSKRtoW50Mq0u1L"
Content-Disposition: inline
In-Reply-To: <20250827183055.GL124814@bill-the-cat>
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


--0hSKRtoW50Mq0u1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:30:55PM -0600, Tom Rini wrote:
> On Wed, Aug 27, 2025 at 04:38:46PM +0530, Bhimeswararao Matsa wrote:
>=20
> > Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
> > ---
> >  drivers/i2c/davinci_i2c.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/i2c/davinci_i2c.c b/drivers/i2c/davinci_i2c.c
> > index 9bba0600e3e..ffd0dd0b282 100644
> > --- a/drivers/i2c/davinci_i2c.c
> > +++ b/drivers/i2c/davinci_i2c.c
> > @@ -51,7 +51,7 @@ static int _wait_for_bus(struct i2c_regs *i2c_base)
> >  		}
> > =20
> >  		REG(&(i2c_base->i2c_stat)) =3D stat;
> > -		udelay(50000);
> > +		mdelay(50);
> >  	}
> > =20
> >  	REG(&(i2c_base->i2c_stat)) =3D 0xffff;
>=20
> What is the reason for this change? mdelay(x) is just an inline udelay(x =
* 1000)

Oh, I see, checkpatch.pl is complaining, but that's not relevant to us.
I'll send a patch in a moment. Thanks!

--=20
Tom

--0hSKRtoW50Mq0u1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK9QKQAKCRAr4qD1Cr/k
Cgg+AP9S86LqluO3WIHI872bWw08cky/koFvNOvH5L8FBPuV7gEAzwJFRfab+N7+
OaQQwv4To3Ps6lS60W4b8Yzy2x0ygAo=
=j+Ha
-----END PGP SIGNATURE-----

--0hSKRtoW50Mq0u1L--
