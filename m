Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA74CA1002
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 01:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1294183807;
	Fri,  5 Sep 2025 03:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QsI9Fs6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56AE83807; Fri,  5 Sep 2025 03:33:03 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8D4836B2
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 03:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-31d6aa3e73fso1145645fac.0
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 18:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757035979; x=1757640779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw41xImHbhSCIw+PEzPWHIo4wH8UuhXs+pO2qcMnYhQ=;
 b=QsI9Fs6lE3+m3V6DJzh5tux+Qo6vLVWBSXd1Ty+Fh6/f6rLcjaug2xQA7IYJ8JgZn5
 ijOHnNizwjVr6NQpOGKmk4UItkCCuVtCOAIEwvv7b+22Aqi3xqaI+Vi3SNSCuvpcSTkp
 drNcfLvsj7mEsvNRVBfn7JvFxMf7nlHLUA0XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757035979; x=1757640779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw41xImHbhSCIw+PEzPWHIo4wH8UuhXs+pO2qcMnYhQ=;
 b=qf2HnyGiOGiZxsyC5LfBO/n5c3w7O6aFVoyVkIt7m79QpYhi/Lz+bYFKkEiCiznvtQ
 TuDatR8uK6v/fyMF8m0U39GAMpv8oX1Qrz78FNdjX6+BTQ9GzV5uGPyMgUmiwWkOHv8/
 ceAn/Ia+CrpxhwpbB1IRCwTZ101w96h7f5WT1snTStZ0UA+2HWAQzRCn9ZMPYmtpXAob
 MUQToXhMnioJZlXvObheYC79ZQsDJJs3/zYAbTOeIMN7lJ/EsGX58ReLAqkcGlBVQ7/a
 gtsKF8+NiXQMHMYdeSPvVNPJsQTcUIY4bfU/bLRL089mBYnJncSvkZUg0OHWcEA7sfRZ
 UGJQ==
X-Gm-Message-State: AOJu0YyWxFpc+xi0GxygecmMYgn99iYqmmBUxOZuv217m+qFttbKolhB
 pcagxA9jE6v74UMY/tVZOVrHg3ZSiQaKqRQIrISaxqtdsaQEkHNVuJnXtwTWmWOtnrhqLj5VE6L
 ybpfCobI=
X-Gm-Gg: ASbGnct093GRa721H4eajRam0DrEPV+yUXCPvzPnbZbE9F6asuovMLm7sFL2qpfcnJ1
 Qvqx0kXgleGYEoiU81ukC2dwi1vIayw1NDveD7IM17HdnQHKThysWWYYEsUpfnkrrno7tRb5N2K
 pKOfclC+85lYR7Y0HNJnROYFZaQHjZK/hGabsx9aUF1l7XHYlGOxPL3eNG2kPG1ZPaaL2BoemK4
 u2bRKrmTSePuHW8VsTLT3+xKun18VQZHfiP4vM9Fou9cgb77fVDHVODk0ScWajyHB7QnzHMGlMl
 TnjJSmhQ3Z+EeF7rqel05urXK2zRr2JSB3Sx9A+mghCLPrTYLlDeDEjyL0pDQZHxNIz+DYpaM/e
 x6ujmbIvqGQFG8FzBLM6AqxG4uwIhlTurN89+CiqVmLSj7ZsFrRsa+yTaX1wtGYXFWtE=
X-Google-Smtp-Source: AGHT+IFzcB42otTSA0Jqrt+2YKvC84yTcD2MqKVNRomFxZu76/44jZepeFJ43SlyRvz+WHFJ+ba+pg==
X-Received: by 2002:a05:6871:5214:b0:30b:9a9c:72 with SMTP id
 586e51a60fabf-31f14f8b0ddmr1014175fac.0.1757035979476; 
 Thu, 04 Sep 2025 18:32:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-319b6063050sm3167482fac.25.2025.09.04.18.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 18:32:58 -0700 (PDT)
Date: Thu, 4 Sep 2025 19:32:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Message-ID: <20250905013256.GI124814@bill-the-cat>
References: <DB6PR05MB45517FBC403C54F9589F03878307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250901182549.GD124814@bill-the-cat>
 <DB6PR05MB4551C8F51246AD5EEA64F4498300A@DB6PR05MB4551.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lYABbdkwCunxSiL/"
Content-Disposition: inline
In-Reply-To: <DB6PR05MB4551C8F51246AD5EEA64F4498300A@DB6PR05MB4551.eurprd05.prod.outlook.com>
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


--lYABbdkwCunxSiL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 01:19:26PM +0000, Maarten Brock wrote:
> From: Tom Rini
>=20
> > On Mon, Sep 01, 2025 at 04:06:10PM +0000, Maarten Brock wrote:
> >=20
> > > Even when CONFIG_NO_NET is selected there is still need for a
> > > definition of ft_board_setup(). Thus move the checks for
> > > CONFIG_DM_ETH and CONFIG_DRIVER_TI_CPSW inside the function.
> > >
> > > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>
> >=20
> > Shouldn't OF_BOARD_SETUP be disabled in that case?
> >=20
> > --
> > Tom
>=20
> Had there also been non-NET-related fixups in this ft_board_setup(),
> would that also have been your answer?
> I don't see why disabling NET drivers would have to impact anything else.

Yes it would have been my answer. And because not all dependencies are
easily expressible in Kconfig.

--=20
Tom

--lYABbdkwCunxSiL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLo9xAAKCRAr4qD1Cr/k
CpzBAQC6Xrsrb9Mj32Zo57ZxgSnQMsl3OEi1CiWGVYNOMRp1VAEAngUnym3QvsZ5
Zm2r4aTZNxOIg3SzfTqoYEtWQn9yFQY=
=DJ/f
-----END PGP SIGNATURE-----

--lYABbdkwCunxSiL/--
