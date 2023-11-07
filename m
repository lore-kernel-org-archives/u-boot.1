Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719D8C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756D787658;
	Wed,  8 Nov 2023 00:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BdZ3xqTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EFA887658; Wed,  8 Nov 2023 00:31:00 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC4C875FC
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-66cfd874520so39108666d6.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 15:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699399856; x=1700004656; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=keaenAoUliaVQQrqgvH+blnkd3FwnkHDV0hRrl1JLDc=;
 b=BdZ3xqTnHcvYdHGkDkRQOuOaUhSQcb1yiE3oyRACc5SGKQlZbHusXWkS4s0vWbAoVs
 L8VtJ6egbyk6lcYkgwJjpiADmER1L/YgN5e5HlNqeLfX7c60UCyLU7hnXBXuQL1G4Ehb
 kwLn6czYtQ8dUW8DL1dawopbYhEH8MuyUopCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699399856; x=1700004656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keaenAoUliaVQQrqgvH+blnkd3FwnkHDV0hRrl1JLDc=;
 b=kPZuyaO14honuSKp/0lOvJ1QgmAJ8aG4PLGi7CuYYW7KEPfJ7N32MBSqqEyjkQUiBh
 GEZgE7As7VQUhzQjNuGUGgK3OVLpFcnIcVxa/exJCkzu14MIIcffo8DlYYKAfIazQnlc
 hG4qwaBbSFrkw0P0UfNqq6i2aqR64Idy0CchmpFNj8kQdLtQD5ysnDeO64+TvdR/ePVn
 chRGG8vw2F6AkngXygbtATMOblUwo/85gONBSXEt9VX7fJPcWzRQAIoUH/IanYtcxfI/
 dbaHqXi2MngBrXnO5393E3lZU+WtLGuDkMh2lvVWHqA85hjTNgjEjsE57v451B+PpsHd
 mfBQ==
X-Gm-Message-State: AOJu0YxEh5JgeocZ7Efgw19VbcF0JAl4irexcEjswOqAE89yY/3ng/MN
 KOuQ1mvI0RYwePsTGVbkL7zuVQ==
X-Google-Smtp-Source: AGHT+IEFFIEyNYqIsPU9mPGDzqH/34A7YtXcAM8rRkxYqyzKMwD5HQA4DE8cqTXT9hCNhsoHE1t4Aw==
X-Received: by 2002:a05:6214:301e:b0:66d:f91:fa33 with SMTP id
 ke30-20020a056214301e00b0066d0f91fa33mr289094qvb.29.1699399856354; 
 Tue, 07 Nov 2023 15:30:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 j8-20020ad453a8000000b0064c1b27bf2dsm396627qvv.140.2023.11.07.15.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 15:30:55 -0800 (PST)
Date: Tue, 7 Nov 2023 18:30:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Andrew Davis <afd@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] board: ti: common: add rtc setup to common folder
Message-ID: <20231107233052.GX6601@bill-the-cat>
References: <20231107232139.2839534-5-bb@ti.com>
 <20231107232139.2839534-6-bb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sw7gtM3+dxHSJ1sr"
Content-Disposition: inline
In-Reply-To: <20231107232139.2839534-6-bb@ti.com>
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


--Sw7gtM3+dxHSJ1sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:21:41PM -0600, Bryan Brattlof wrote:

> All of the starter kit boards for the am62xxx extended family utilize
> the same 32k crystal oscillator for a more accurate clock for the RTC
> instance. Add the setup the clock mux and debounce configuration to the
> common board directory so the entire am62xxx extended family can utilize
> it.
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>
[snip]
> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> index 49edd98014ab7..56a65c0a402bb 100644
> --- a/board/ti/common/Kconfig
> +++ b/board/ti/common/Kconfig
> @@ -1,3 +1,11 @@
> +config BOARD_HAS_32K_RTC_CRYSTAL
> +	bool "Enable the 32k crystial for RTC"
> +	help
> +	   Some of Texas Instrument's Starter-Kit boards have
> +	   an onboard 32k crystal. Select this option if you wish Uboot
> +	   to enable this crystal for Linux
> +	default n

No "default n" as that is the default. And we (a) need some depends on
for what families this is found on and then (b) how, if at all, does
this match up with the 32k crystal used on other TI reference platforms
over the years? If this is specific to the K3 families of reference
platforms, the help needs re-phrasing and the filename is too generic.
It's also not a "RTC" in terms of something we can talk to via
drivers/rtc/rtc-uclass.c and drivers/rtc/davinci.c, or in this case
porting the kernel's drivers/rtc/rtc-ti-k3.c over, yes?

Oh, and "U-Boot" not "Uboot". Should see if the checkpatch typo list
can be easily expanded by us, one of these days.

--=20
Tom

--Sw7gtM3+dxHSJ1sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKyKwACgkQFHw5/5Y0
tyyqbQwArAQjF7cxehTw+3O0yH8uiBOW7PNE84wbeOO+lHG7wfHg4jLyzxUzTcGA
V8iD8GVecCp8SFWOdhI4M+ie3hcUbsi4bxbua3NJwCao//Q084wq0WcMkIyLdCYw
COU9BoE+aFZh4mBauObkMQN6KhsNmjYoTkNlvMjebub80YJ7EuNSRwYh15a+HjIL
gyMcv/7Wxwlz1XMUSD5W5DK0FrcsTuWogVSO8szbdVhgGbe4J3/sHgFoIbYBksIS
7O5AnaX+NSYjEENnTZqBm3hEsR5TY4LFPdFzZPgl5m0ARmgXlFKwW/MTVs5eaLxO
YVW51S0KPg9d/Svsm8CKUKz/FWBeQFIl1PRtfvRrWl7/QhdL2dXm4U4fX9v7TXvL
mxDuFvsNf/Ol7bVjpWY7UZJfqUcmrVE3jss9CV8h5SlOnQgQ8tbsFWEH5RSwYtEP
UB15aJLlKzKiBFxJqCoR/2Abc4LnlYbNifKHHYKjVm9efBSLIDEl/YhDZKOPRRJr
XxSfArQn
=ooNr
-----END PGP SIGNATURE-----

--Sw7gtM3+dxHSJ1sr--
