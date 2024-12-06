Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB278E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 16:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF4689622;
	Fri,  6 Dec 2024 17:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gaEOYUI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE7B89616; Fri,  6 Dec 2024 17:45:23 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB2689622
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 17:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46686a258f7so28460141cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 08:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733503520; x=1734108320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=guq8yUIqHleUOiRGyHV4ThvLD/c6RF+c5INLI3aCNk4=;
 b=gaEOYUI9EXoHPevK3c1keYDafGBEQlDK6yoGfDujJKo7dZuVP7/66ZkTqDbHQHgqNu
 lZ0rU5P1a+HhwflHrUVh42xujgNN85Ri8KVqcHLDPwm/6LQi3PaflhfgRb1t6XPJi+Pk
 PSlynsXucMJFJxZorIa8hJVJCiQUqms1YH7tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733503520; x=1734108320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guq8yUIqHleUOiRGyHV4ThvLD/c6RF+c5INLI3aCNk4=;
 b=XTJTZxbmgcymwrIZxVJyUySJ8cp/s6rLxCrFydhTXBeU5TMYQWeefUyHv0R7+3eZDk
 wQ5VLW20b90tvCc++5Prrjh8l1AGv7bZgJJTF5GJ75owoZWiIAVLcX2BA2ZsJB8OOXYL
 0pzV/uI0fuQ1/pDF/DdKogIFRIoURdkB0OSlO3sifOdj6kSuTHC8gVFTqDLlSP42vRK4
 TkihCeo2IgCq5wpiZT982pODn1coyAniBmq2aljxaogNX/oPC0RI7CpkkguDuo1hDRI2
 QMmTcWjRPuMXzw9j6wLEkY5ePeI8of64UyIOZLPRoRUTAgEl3cXDI3Rcrx3LsTLOa+eS
 eyng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3U1vJm8n6rADu+SBtfSvGpUifZnFF7LthQB7U1llsH5PHd4J3qate1tYVr8YQoTtmuwzyPTw=@lists.denx.de
X-Gm-Message-State: AOJu0YyQdeknnUjLJuuc5rW03QIcYppwbU6GnCpOv31f4QZMoSJqHn/6
 7okjW02QVy6+87/zmYz3ZMitfQPOihzNLDMNzYR0yWkE7FoLJqXCdmMhDE6LVps=
X-Gm-Gg: ASbGncsdEDQzvUJThcN79tJiBJfp55E2FGdrGA+Z0TCprzT3IMWjc+wwjDTwaMkAWBf
 eGKxHj50IPDK0T34WMJ/1gL/T/mSZxTSsKuM9mQwYFA7UPxEp9s916sqWDDQitbL1LEpSxt972N
 VeipKzkiHijYeYVfugZDB/KPFxShEM3Sz3LN8fGvkU1Q/LvE7Zm3v7hn0vZXqBDmB2kN1+4Hi4Z
 w3pOMaxtu4idZSVNUuBloPUe0BOfYDpymHBd0hxJz5qXtDlTg==
X-Google-Smtp-Source: AGHT+IFVTwzeoYPOM2KfM5Vx9l9D16Lk3hiGsS7/p0LVZCXv0tKMPy7GWtRf8n+046hX0qHFc5b8EQ==
X-Received: by 2002:a05:622a:191a:b0:466:9e24:1a5f with SMTP id
 d75a77b69052e-46734f87dfemr64913791cf.42.1733503519693; 
 Fri, 06 Dec 2024 08:45:19 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297c94edsm22641361cf.76.2024.12.06.08.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 08:45:18 -0800 (PST)
Date: Fri, 6 Dec 2024 10:45:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>,
 Michal Simek <michal.simek@amd.com>,
 Sumit Garg <sumit.garg@linaro.org>, Ye Li <ye.li@nxp.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/2] gpio: add PMIC_GPIO Kconfig option
Message-ID: <20241206164514.GT2457179@bill-the-cat>
References: <20241206154050.48353-1-clamor95@gmail.com>
 <20241206154050.48353-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gSfK2grivXnaxtwk"
Content-Disposition: inline
In-Reply-To: <20241206154050.48353-2-clamor95@gmail.com>
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


--gSfK2grivXnaxtwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 05:40:49PM +0200, Svyatoslav Ryhel wrote:

> Add more generic Kconfig option to be enabled by the PMIC drivers
> which do not have dedicated GPIO node and use same phandle to refer
> to both core driver and GPIO child.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpio/Kconfig       | 8 ++++++++
>  drivers/gpio/gpio-uclass.c | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 92a8597420a..b7a3dd7b221 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -255,6 +255,7 @@ config MAX7320_GPIO
>  config MAX77663_GPIO
>  	bool "MAX77663 GPIO cell of PMIC driver"
>  	depends on DM_GPIO && DM_PMIC_MAX77663
> +	select PMIC_GPIO
>  	help
>  	  GPIO driver for MAX77663 PMIC from Maxim Semiconductor.
>  	  MAX77663 PMIC has 8 pins that can be configured as GPIOs
> @@ -474,6 +475,13 @@ config PIC32_GPIO
>  	help
>  	  Say yes here to support Microchip PIC32 GPIOs.
> =20
> +config PMIC_GPIO
> +	bool "PMIC without exposed GPIO node"
> +	depends on DM_GPIO
> +	help
> +	  Choose this option if your PMIC does not have dedicated GPIO node
> +	  and phandle of the PMIC itself is used as a GPIO phandle.

We shouldn't prompt for this, and instead select it (like you do above)
when required. So please drop the prompt text and change the help to
star with "Select this option ..." thanks!

--=20
Tom

--gSfK2grivXnaxtwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTKhoACgkQFHw5/5Y0
tywVIwv7BdFZNDZUoeorNB6ERsZuAA6M8DE1ZtWRJetWopj7kcOxkrGQxcJHW7rz
fIpg1MDrMpmZVvX1hEr3PiNE59lb0RTQmr8F2wzquPWAu5bvuzUKuU/cJoG9IaQ7
TmKjSo1Vr+pkFXPG6z+x2Kmf4nOASgpm4NVNs/OMIHPByi2NlNqGd9eiwVW4Lpo4
alRvtj99un6QCDRuibqsD/THlHknO326o6CwJVMVFp/g8h/cYdveLh3QRqslE6BX
HrTXLKrxfIeiER8ox3DdgmPnY+Umpml7/kKPgVSIBtFXISEGW5YvN/Pu5S8s+okK
BKxPlmGqdYWzcY7A/n+i/9ULte4X/8cXSicR0+r3bznSDVfBoO2i4wjqRdtAPRty
/yI6DsdLrJ9bqZCgQEN6PUVsVaQS7VX733n+L+ugsnY1HI7gr1yt78fle0mmbCLi
cXUBcD77EZjs2xHXfSUrNd3MY+gh1DiCjged8sBIB48iWSSdyY5Erry5dV4QR72+
v93gRNVO
=w9CN
-----END PGP SIGNATURE-----

--gSfK2grivXnaxtwk--
