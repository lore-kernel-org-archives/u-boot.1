Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A48C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA6C88179;
	Mon,  4 Mar 2024 16:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ihD1/rhh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C2F88093; Mon,  4 Mar 2024 16:29:27 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC9B88174
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7882cc93e73so47454885a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566164; x=1710170964; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LG3g9wZcKhNgo89oH1ofBRfJr4N2Sm6g4Itr0mRiTtA=;
 b=ihD1/rhhmC8RMBnNcK57+L0mhKPBcGSMas8oLfpZoZlf3a66LYuvyaf6SuQyWOPE2L
 F1QJRrMv7Q8rcgU1Nebq4ib5pw0GIvo68iLL505eiisebzFx/lH2P1iSpGKslviKL7eo
 VAmM2QjL1F8hkFBxvHfUjbi3FetAGgybPP1iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566164; x=1710170964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LG3g9wZcKhNgo89oH1ofBRfJr4N2Sm6g4Itr0mRiTtA=;
 b=jmKTDKGtbNO2CdukwpWxel6WTH00hnd8tyyapQKe7AY3DoqcBfKzjk3zOYCl7Mgm46
 JWtkpT4TKuJLZyTQyaMO87hF33wVUPFifIw1NeTaUu2KlbWW4WBF12YBdEXK7ELs5W/G
 OTIWEqHhD1Vqd38rivmOE4pbhrmL1FgLrKbjYHOV8BsQRptaqXlVN+rFyO6+eLRNn1um
 PM/jgV/l+bOsi7QOH0n93vHDx/su9ioTkXIM952ufKORFjL5XgWOMhIhOAxnE0vF6SwC
 n+vgG+MnpNVc1gqgG8TTJMwyt4+nAcRVxg8zFuwb/JqN90m883+4UiudFOdiFFR/0vOo
 Srvw==
X-Gm-Message-State: AOJu0Yz/R6sCve+1KR+wdc5TZmWWigyhHWvGRCdxs0J02zWLH06sQbAW
 ALPSbSZKgYx0r+I6qJR0S9LOWYAAv65pNP8YniKQLf/7CV/LEXfSJGYlp0BdZo96IJhLkIZ8rlx
 s
X-Google-Smtp-Source: AGHT+IGM+7AdH1yl0B/1JtsSB/o1aGqSK/Da0z2ttBYyKrjWLvzxA9kcKtfiDrP5YYjxISU7TXGWOQ==
X-Received: by 2002:a05:620a:838f:b0:788:1b49:9cdf with SMTP id
 pb15-20020a05620a838f00b007881b499cdfmr12276690qkn.19.1709566164175; 
 Mon, 04 Mar 2024 07:29:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 qp30-20020a05620a389e00b0078820f053b0sm1891690qkn.109.2024.03.04.07.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:29:23 -0800 (PST)
Date: Mon, 4 Mar 2024 10:29:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Ivan Orlov <ivan.orlov@codethink.co.uk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: eeprom: Fix config dependency
Message-ID: <20240304152921.GM1523872@bill-the-cat>
References: <20240223171420.9492-1-ivan.orlov@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+6uZ4cYR1F2pvNGf"
Content-Disposition: inline
In-Reply-To: <20240223171420.9492-1-ivan.orlov@codethink.co.uk>
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


--+6uZ4cYR1F2pvNGf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 05:14:20PM +0000, Ivan Orlov wrote:

> We should have CONFIG_DM_I2C or CONFIG_SYS_I2C_LEGACY enabled in
> order for `cmd/eeprom.c` to compile as it depends on the i2c functions
> which are not compiled otherwise. Update the Kconfig entry for the
> 'eeprom' command correspondingly.
>=20
> Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--+6uZ4cYR1F2pvNGf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6NEACgkQFHw5/5Y0
tyy/+Av+Jm5wSiD2r/8naFwIYuqCJ6jSJS85y2kMe+mca2R45tQRyX6E3lrlpmyX
O6cPt4hZvxZVMT3PvBUUjVgZznH5ReAqulUJfMCbCq6VJePXc0rPkdAe+LeJbdvx
imO47SuW1RDVMEknaeh7wVCBjJJV6eGS6Bd8o1YUwcgAxRr7JpOuuciWeVk5ljoE
T6j5edDgTTmnzXaTcCm8JUwc5uNY68on5WQ/8vVz+Po9yVnB6W6k3IEfCWiEEyh1
aDCL8E1tJqumnt8lAHVysjyYjDfeu+ozY1KuF7I6JkEGnxqniO5VjmdTMEvQ/UMw
2I0XWZIj+wC7fylnb/qC5qOI3Wu165lYA4n8oyjfbdVpae7pQt1TKvTtrK9RrVFr
eri014oOq464yonh5G/U/7q4GWdBgCFzupCaPS3GO1qedkr4or15uYQcRdehAIF+
RuWRMYO7dxzQpIKIIfe61OOvUQyMTPgEytducbuvOCfqi/fMJehiVTLIPW5FBjKy
1EAKLwXI
=Q/lM
-----END PGP SIGNATURE-----

--+6uZ4cYR1F2pvNGf--
