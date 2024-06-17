Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929ACC2BA1A
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A6188254;
	Mon, 17 Jun 2024 19:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DKGXNEO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6CBB883B6; Mon, 17 Jun 2024 19:48:48 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC3A8811A
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d21f7cc6c0so2314352b6e.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718646525; x=1719251325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lnQ7UNuByfIiAjPdytxRxCOaujQZcIyEf5x3rEehtCY=;
 b=DKGXNEO5NpZkQHpZ2PGnRBvAm5l2Pw238favSa2nonZMHtSFhDkeo6o5Rx1r8dVk3S
 mNd/DKkGkXORguFaBveBZUruOpEmN9loW6hAT/qfVNCE00TbSRMr9D9IEYrKkXTdm/OM
 j4r3AzERmWBGvlceEsPs8ftrIO8Y/aaE7QSgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718646525; x=1719251325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnQ7UNuByfIiAjPdytxRxCOaujQZcIyEf5x3rEehtCY=;
 b=mj8wLoQuDouHcDFtWwgoj65YkFG+JoibXz4HOKVSoo4ChdY8EBV0dovHrfOSzyo+AE
 TTmMt5wntbWOPiABvhAr7lkvlfPElg/WOplOWlgvHTjG+b7aaNhkPnLUOTmHLrxCSVb5
 LM2PHnz4N7Df+H8cFt1Jr3efYJ4rViUtI7rBGwhTPIetI+jn2kjyUNIcFuALilE16Hbf
 Bte/+hoiI3G+Qku85Rjp/4un32Kehg8CaMyS7MJDc3i1118plAwXSkCtHUFHJexGSRSb
 ymlVbKjbEOKOvAT1hqzUXCOYIRe33de5p+MrCuAzjS8aMsh7p86PMJs3nMtqgNPV3C0m
 mhNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNR5Dig7wo2csUosnQIgzQ9A/Mb4DVl2EZE2mzHMVd3+B2+DAEirDT1eE0hU3dfuKIYd1tj2K7TQXgtCOnM9tq6H3Mrw==
X-Gm-Message-State: AOJu0YzyFkcXKubg8QHUqZA+Y79O0ymBbeKsSTxDGOh8HGQmphKeIrbo
 468qKeBdzQ4/1KMDFARgaMAfJ695Syx+zxfA6BghNXds1NDosOcN+ucJLeIVa70=
X-Google-Smtp-Source: AGHT+IHc/KBRWF0AHLYGDvkRdld5O1G9zy2rfgTNpjTnB5IEgFTLO5QHyT66M+nRurLchG+Q7FyV/g==
X-Received: by 2002:a05:6808:f14:b0:3d2:288c:b8d5 with SMTP id
 5614622812f47-3d24e9dba47mr14398736b6e.36.1718646525349; 
 Mon, 17 Jun 2024 10:48:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d247630071sm1557749b6e.32.2024.06.17.10.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 10:48:44 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:48:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/4] board: wexler: qc750: add WEXLER Tab 7t support
Message-ID: <20240617174842.GE68077@bill-the-cat>
References: <20240615091950.239610-1-clamor95@gmail.com>
 <20240615091950.239610-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8gE2DvQZwNRYohmc"
Content-Disposition: inline
In-Reply-To: <20240615091950.239610-3-clamor95@gmail.com>
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


--8gE2DvQZwNRYohmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 12:19:44PM +0300, Svyatoslav Ryhel wrote:

> WEXLER Tab 7t is a mini tablet computer developed by WEXLER that
> runs the Android operating system. The device features a 7.0-inch
> (180 mm) HD display, an Nvidia Tegra 3 quad-core chip, 1 GB of RAM,
> 8, 16 or 32 GB of storage that can be supplemented with a microSDXC
> card giving up to 64 GB of additional storage and a full size USB
> port.
[snip]
> +#define QC750_FLASH_UBOOT \
> +	"flash_uboot=3Decho Preparing RAM;" \
> +		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
> +		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
> +		"echo Reading BCT;" \
> +		"mmc dev 0 1;" \
> +		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
> +		"echo Reading bootloader;" \
> +		"if load mmc 1:1 ${ramdisk_addr_r} ${bootloader_file};" \
> +		"then echo Calculating bootloader size;" \
> +			"size mmc 1:1 ${bootloader_file};" \
> +			"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
> +			"echo Writing bootloader to eMMC;" \
> +			"mmc dev 0 1;" \
> +			"mmc write ${kernel_addr_r} 0 ${boot_block_size};" \
> +			"mmc dev 0 2;" \
> +			"mmc write ${ramdisk_addr_r} 0 ${boot_block_size};" \
> +			"echo Bootloader written successfully;" \
> +			"pause 'Press ANY key to reboot device...'; reset;" \
> +		"else echo Reading bootloader failed;" \
> +			"pause 'Press ANY key to return to bootmenu...'; bootmenu; fi\0"

Is a more wide move of Tegra platforms to plain text environment what
prevents it from being used here?

--=20
Tom

--8gE2DvQZwNRYohmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwdvoACgkQFHw5/5Y0
tyxfrwv+K/GqrbKjCIduXMZg+q5I5f1oV53PFwcs07iucAgScFbAVdjg+nTDVmvF
jGxEAfB8vtYP7R63k2QghsEwV/iU+HGfvje1syGscTdPHapla0x9GaUB+W5sZe0v
xIgbxhRzwOJ0HU8AWiGzHHd+9Y6+X9aS2PuXiouQc6KYR6LJ54T/Lweim6bNPYpZ
fLsOmyBw7Rn/OXXj/3Kl3S1QzTPM1lk3KiMI2UJGPxvTOycPBE+sRyG7dT1e04kz
sOUUL6mq8SfR/GaVzTDbyt3tx5Y/RmeoQNpvpDLQ0NCa2oNWEs+jIt0l3qvU2lXp
/xVOZaeKwbshBREhCLwYnjtCnnEPLNu7vunJoHltLiZ1Gcm86idzdN1PlSKrtN0F
W6icy51+KzftVFnY4rPgyguYSRScxjG3oCHiizzd/5SFjLYeCgxiDIOXqDaRdMAP
FyUey5q2fLShN6d9+RxMzA5wYSdkC6+c/8VnjXqk9KiEy8sR8cUEhuNZZno9f1+p
2APmxes2
=9/N1
-----END PGP SIGNATURE-----

--8gE2DvQZwNRYohmc--
