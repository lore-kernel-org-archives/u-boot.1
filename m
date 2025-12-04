Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B23D2A520
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D768418A;
	Thu,  4 Dec 2025 21:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pY3nksjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7248413A; Thu,  4 Dec 2025 20:50:48 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71D5840FB
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640d0ec9651so2414565a12.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 11:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764877846; x=1765482646;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/3GFYi1p+TrtE4sbNiZXuHFm2Wq9vHO8BiUFFgIyRw=;
 b=pY3nksjkNuVJ1NVVQBXhu5gBsBMmgFGqkhAaH7OZRIDrykNk7C+vRpPyqNUZMMyS8K
 FruSqlg0/jVesawD64K95oFZde4YKgyLPkvDyuSGBc7gmJPofPhabyi6PTa2nQM4ayU+
 nS6WWoNK9cOXYVtmhIhopKQWHxY0qtJpXIKVTOq9aY1rJtdQp9vPJol4Pn5y8AUYtodY
 bU+rSBv07yIiP7+tfUxCEmufCiRbiAWZJT74k+J9kVPf+CgeJn1Fjv5edElRDV5IaVe3
 YPIqzK6z4peQV1Ws2ulOuoFkFbM+qMuRz5L50nixs36PYfgmdcxpmAGd9Z3+t/XhQxu3
 i7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877846; x=1765482646;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/3GFYi1p+TrtE4sbNiZXuHFm2Wq9vHO8BiUFFgIyRw=;
 b=YtoFkoxCmAgOknVQNwkIDYTF74n655kkavK+p/IxEIuivy8O+KTTHPjG9GiUodq05q
 U8a5SyYBfZILpIOBaDbOKaK4mFLdmdpoQonHXxcnidJkM+L43nb0kUzjfSTwL6XaDGSY
 +/M+fidCgeG0WH9kP1X1niEJygMOiRM/m2zOOeQklrTwhJGXAVdkoNaCGJh7T8opHVvj
 hT9ojMCeTrP3iO1zIUlyiob4vwgqGdwS5vEVF3HGFspqOlmwF0NuyTVuXSyKjgoTUelh
 PeQuhgAEr28zBgi12ma5DzGRc8JARgxgXHLfDFdfflrMucia7yfcIu9hD3/TV69b9eDO
 M1rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+f4VJYijCYGPdIbAbEOFTEncwTqtrj5k8dPRm9DyUX8tiBzdpWVmXawZ+E5YV1Gd5+bHtT3U=@lists.denx.de
X-Gm-Message-State: AOJu0YyB2hFOR/VEGepGmTh41dF593FSSVTb2zo/WYQTkg2yBFUqXmio
 03RiUgSfdKSYX0FWT8cjXIf4CbzNPTuz17o8zFAZAkhjH+W0sjXpCOCaQBB54F840s8=
X-Gm-Gg: ASbGncu/2r4JmcXqyU0X6OazxfwX2TLjB1WjhufN+491ANCFHXXI1cXy0ET+84ONUqa
 dQZeNiTNRUATvaRHEAHvJX5tzqsp8Y1mfG2mLg6Z7ogr0tveSaCH4dVL9L+qVDpXSnj5xs+delb
 B9fhsryDEZrvGqH2Hdf2LvIwbA5itF30JSXu5nhAzpLyD9vQNqE133slBNgF/wMICXDcguJlUBQ
 TbFFYsahywdvYuA9MEY9pxEJI9ttCRuW/uCIv+JEMDT57V/7/bkMsb4hiTx0ybIY+2MtKYyWEzy
 E5Cdg1vtVId2Z5oFq+L2cz+K9+8oeJEgXCqaGGmKgoKBYEtGubtEcgHgC7+CVlGNELNYxf/Ruap
 FikNhhoxCwT4dSF6rpnW+1bHvw21mbEh6gjjxBxOCgoyuUBCDrdzpDqpu6TpsvFeuRGJLouX895
 45pklO
X-Google-Smtp-Source: AGHT+IFNzdxeoQZeeK+A9Z8jJ7k/FG4PSe7wBGrdJdcY89YLdfehjOpWqqiQkskoOTaN5+uBkfas9w==
X-Received: by 2002:a05:6402:34c8:b0:640:c69b:8ecd with SMTP id
 4fb4d7f45d1cf-6479c517aa2mr6182589a12.25.1764877846093; 
 Thu, 04 Dec 2025 11:50:46 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edad10sm1935988a12.9.2025.12.04.11.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:50:45 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=453ce5a927b6dcc5bf9f12f7e28f718e1c9c6e74503da42f69472283afe1;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 04 Dec 2025 20:50:39 +0100
Message-Id: <DEPOZAHRNZER.2FY6DOCTMNOPZ@baylibre.com>
Cc: "Vishal Mahaveer" <vishalm@ti.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <u-boot@lists.denx.de>, "Anshul Dalal"
 <anshuld@ti.com>, "Moteen Shah" <m-shah@ti.com>, "Santhosh Kumar K"
 <s-k6@ti.com>, "Nathan Morrisson" <nmorrisson@phytec.com>, "Garrett
 Giordano" <ggiordano@phytec.com>, "Judith Mendez" <jm@ti.com>, "Aparna
 Patra" <a-patra@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, "Chintan
 Vankar" <c-vankar@ti.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Neha Malcom Francis" <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, "Sughosh Ganu"
 <sughosh.ganu@linaro.org>, "Beleswar Padhi" <b-padhi@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, "Andrew Davis" <afd@ti.com>, "Wadim Egorov"
 <w.egorov@phytec.de>, "Andrew Goodbody" <andrew.goodbody@linaro.org>, "E
 Shattow" <e@freeshell.de>, "Devarsh Thakkar" <devarsht@ti.com>, "Peng Fan"
 <peng.fan@nxp.com>, "Jerome Forissier" <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Andre Przywara"
 <andre.przywara@arm.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v6 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, "Tom Rini" <trini@konsulko.com>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Robert Nelson"
 <robertcnelson@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Bryan
 Brattlof" <bb@ti.com>
X-Mailer: aerc 0.21.0
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-8-6dd99a7271bb@baylibre.com>
 <9d1d0c37-67f4-40ee-9f49-23062829aa8d@ti.com>
In-Reply-To: <9d1d0c37-67f4-40ee-9f49-23062829aa8d@ti.com>
X-Mailman-Approved-At: Thu, 04 Dec 2025 21:31:27 +0100
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

--453ce5a927b6dcc5bf9f12f7e28f718e1c9c6e74503da42f69472283afe1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 24, 2025 at 5:07 AM CET, Udit Kumar wrote:
>
> On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
>> When exiting a low power mode with DDR self-refresh, we can directly
>> resume after DDR setup is done. Call the common function to resume.
>>
>> Tested-by: Anshul Dalal <anshuld@ti.com>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am=
62ax/am62a7_init.c
>> index 60645272c816023798cc5d6fa46a2c569143343b..4f0a8ed66179e7f7445f9c25=
0ffb4f53f4977546 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> @@ -195,6 +195,15 @@ void board_init_f(ulong dummy)
>>   	ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
>>   	if (ret)
>>   		panic("DRAM init failed: %d\n", ret);
>> +
>> +	if (wkup_ctrl_is_lpm_exit()) {
>> +		u64 meta_data_addr;
>> +
>> +		ret =3D wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
>> +		if (ret)
>> +			panic("Failed to get LPM meta data address %d\n", ret);
>> +		lpm_resume_from_ddr(meta_data_addr);
>
> Do be you want to protect this code with DDR_IO config ?

It is protected by K3_IODDR. wkup_ctrl_is_lpm_exit() only checks the
actual registers if K3_IODDR is set:

	bool wkup_ctrl_is_lpm_exit(void)
	{
		return IS_ENABLED(CONFIG_K3_IODDR) &&
			wkup_ctrl_canuart_wakeup_active() &&
			wkup_ctrl_canuart_magic_word_set();
	)

Best
Markus

--453ce5a927b6dcc5bf9f12f7e28f718e1c9c6e74503da42f69472283afe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaTHmDxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP3
swEArgRRsfinPSUeqXHCc0mF9h5jPyJPmi5ZNJLfpGEtKxAA/2Sh2JQeLFk7Vpk0
4L0kBTKT7VlzGGmPCBuH4R2njLwB
=lmRE
-----END PGP SIGNATURE-----

--453ce5a927b6dcc5bf9f12f7e28f718e1c9c6e74503da42f69472283afe1--
