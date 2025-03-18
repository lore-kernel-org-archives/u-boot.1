Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C53C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F26481101;
	Wed, 19 Mar 2025 04:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gD3LCv1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BAA810F4; Tue, 18 Mar 2025 17:36:03 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EEC3800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 17:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso3940487f8f.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742315760; x=1742920560;
 darn=lists.denx.de; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jqzMq/F9ZArdTvI9qm1htkIw5h/t8ipIjSKw20I0ydM=;
 b=gD3LCv1xdNpzEN1UkLLgy/8MFPfGaDqAvilQlvWPyFlCAbHVpLavUZgbjoPUxh5wYf
 lEsKluzQaWu0ssJDHoQMYne0JSF/P2yD3zH/kFldEjFzqHj54OorIk5VNHd1KpjXYH68
 tYC+Nh1UYAFavUk2flelLO07/xiKkSZIl1i/gAqpBDlvTQhQjsdwKsxC1zlaFluqub3L
 /Idm0Ib3N848Om9ZL678itkHvv3HMiukdF25OecsExnFSml7ZrHLpLhRkjSUfp+aH4mq
 Yrgx9go2ipkn/8Cjkgx+QIcyUGtcNvRb2inzm4Aw6DEF99wvosLyUchPrA/66/XSED77
 t1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742315760; x=1742920560;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jqzMq/F9ZArdTvI9qm1htkIw5h/t8ipIjSKw20I0ydM=;
 b=M0Cr1OiYELoE8gWPwB8KusDTIYEbcn+zrIEsbhIbRJsttEtENlYsTbB8CDDmJUKNFF
 G7VeYxWnnW+MdpEZqNkXjqIdaJkbYTUlkGHgDZjMYO4rMwkeGiX7wegHPgKrRxFWxKZj
 kNeqv9DSNmnW/Zt+N+2+dpcT8zuqXUlw8ZHtn/sKfhCp5UHPHdE8eV28AhmfdOZd1Hsr
 1CtXeCyNbUi7ZR41Dsaf/r51a6mNE0E9Xt1HPDZkx7pAteENd0TO56VKfUXF3oGj2VCO
 xYhqODSFPDoR7GoNV3Qq8KezNL/kCrXqD6Wl1mrtURf7dcs1ZwMKLtqlJpaOJ7SeSnCh
 exgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjvw8PCYvdejvfrMNk0rRR9of/ybb0bEO3LfGPTkmayEGpBegghBrG9aJBhjt6ekyQiefLwl4=@lists.denx.de
X-Gm-Message-State: AOJu0YxNz2R/OeB9+DlCy2v3zWcTChc9tUQwMSqBxyJ+aBMmo5wf40W4
 WVkD2OLNsQqYNPHyKsCqwqKDoNNZ1TG099oRburmcJs57YJhvyDdFrza9SAthpY=
X-Gm-Gg: ASbGncv+l/rek3+SlmV3A7d5O1imRg7k1Noo18SFsqF8gLzYzfZ9BzgUoUexo3NraWp
 FA+9+b7WSc9bfAtWKAxTkMlYofdscYJ/u19AsO6C8yFIf4eIAhs5r/oVZ1x7cjzAxdW2tp0IrQd
 sQa5jzx6CuLjifs36ZbIRCYLAaPTVfcR7AlZILsOAaaW87f/nxvnfJk65mbfiYTlV/QCngWHLpQ
 SAa3GEu6VDSSpCOyac389KGRKK15u+5kLTH1AIa1GOF709R8D3nhWamNOyslr5w0Weyk1366Dyh
 99Rxbrydb8cXy852buRVclLXdIOHBRhJ7e8TpE8M
X-Google-Smtp-Source: AGHT+IF3Z/YBmLNHhTv9njDU2yLALLraVHcRN2JARfL4xV+tIlvNVGYd/gfOlCgu6509CO83H+opiQ==
X-Received: by 2002:a5d:47a3:0:b0:391:32b1:9458 with SMTP id
 ffacd0b85a97d-3971d1348abmr16692122f8f.3.1742315760446; 
 Tue, 18 Mar 2025 09:36:00 -0700 (PDT)
Received: from localhost ([2001:4091:a247:8016:e858:454a:c0c9:731c])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-395cb7eb92csm19036097f8f.91.2025.03.18.09.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 09:35:59 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4617e0b235e8f72fca8d0771db5c5aa133b4dcd2deb4f21a3ad6c72ea608;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 18 Mar 2025 17:35:54 +0100
Message-Id: <D8JJDZQ010F7.4Y0FI46J6FVS@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>
Cc: "Sumit Garg" <sumit.garg@linaro.org>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Bryan Brattlof" <bb@ti.com>, <u-boot@lists.denx.de>,
 "Vishal Mahaveer" <vishalm@ti.com>, "Kevin Hilman" <khilman@baylibre.com>,
 "Dhruva Gole" <d-gole@ti.com>, "Sebin Francis" <sebin.francis@ti.com>,
 "Kendall Willis" <k-willis@ti.com>, "Akashdeep Kaur" <a-kaur@ti.com>
Subject: Re: [PATCH 02/19] arm: mach-k3: Kconfig: Add symbols for IO+DDR Low
 Power Mode
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.20.1
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
 <20250311-topic-am62-ioddr-v2025-04-rc1-v1-2-666de9c105cb@baylibre.com>
 <20250313160403.GD2640854@bill-the-cat>
In-Reply-To: <20250313160403.GD2640854@bill-the-cat>
X-Mailman-Approved-At: Wed, 19 Mar 2025 04:16:48 +0100
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

--4617e0b235e8f72fca8d0771db5c5aa133b4dcd2deb4f21a3ad6c72ea608
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Mar 13, 2025 at 5:04 PM CET, Tom Rini wrote:
> On Tue, Mar 11, 2025 at 11:30:41AM +0100, Markus Schneider-Pargmann wrote=
:
>> There is one new symbol to enable support to resume from IO+DDR where
>> the SoC is turned off and DDR is in self-refresh.
>>=20
>> The other symbol is the address of a memory region to be used to store
>> meta data. This has to be the same address as is used by the firmware.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>  arch/arm/mach-k3/Kconfig | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index a3ac490f677429b851b4b4b3d6753ef6997884c9..1e6deb3b9cf1c5a8091a88d8=
c825ebdbb681424a 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -150,6 +150,15 @@ config K3_DM_FW
>>  	  bootloader, it makes RM and PM services not being available
>>  	  during R5 SPL execution time.
>> =20
>> +config K3_IODDR
>> +	bool "Enable IO+DDR Low Power Mode support"
>> +	depends on SPL && (SOC_K3_AM62A7 || SOC_K3_AM62P5)
>> +	default n
>
> n is already the default, this can be dropped.

Thank you! Fixed for the next version.

--4617e0b235e8f72fca8d0771db5c5aa133b4dcd2deb4f21a3ad6c72ea608
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZ9mg6hEcbXNwQGJheWxp
YnJlLmNvbQAKCRAkjLTi1BWuPwfTAP41ETYJB/YqysZLgC7TSMXl+Cqykb4uu0ZV
x+Lw0Ro0ygEAnn1ffLHc4lCUCG25ZE8GCpAzSBk+FrG2ig2fcvm8DAw=
=k15H
-----END PGP SIGNATURE-----

--4617e0b235e8f72fca8d0771db5c5aa133b4dcd2deb4f21a3ad6c72ea608--
