Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D8ECED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD1583C5E;
	Tue, 18 Nov 2025 15:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CFrlmdxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31DA083D07; Tue, 18 Nov 2025 14:54:52 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4AE83C5E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 14:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso45896735e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763474089; x=1764078889;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tVkFFnwnYB+CMYlNRasZ3VcuHPl+UxoVGMtHCWitp5E=;
 b=CFrlmdxjfd8W5vmH5PLmx0ORab+GZWpBhDlo9/SapFFIJY6FUp8hIL5EB4pNdeElO8
 L3wR1w89ST7/Es0F85xBLNsxDqkZ1tv+Zmz9BARUFrfsTNnFFjDKv2GEH4BAPgMV9SJt
 w9t2WMucLpet0VZGH2/Azbgu+GmcREEkChidB0QArgYe5JKp6KAYUF0KL2XppdM2GLf9
 cF2Iz1WXSyXk1dGRjC6Mfr6MmZZPzYREZopRKrFRgzStMDDGV+FDKsFTFawVJ1+ZzQKH
 AWXRJuH0zIfAqzFAFpsU8HFvXPLJ0Q7tP3vF6vxdgpIzVux5/ToDEDKA1BCvIKA1zMwW
 LKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763474089; x=1764078889;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVkFFnwnYB+CMYlNRasZ3VcuHPl+UxoVGMtHCWitp5E=;
 b=nZ7iU9CaNjXmUhwUxHWto3DeOYXUHqQ8UAJVIXPmBYbiiiZWI16SWjWmE7aeldc+JF
 2EBb66wROeTpc1xONYf1SKgGY9UAKbLW+56bk582hVtzbwu2Dl8+Mlov8D9xmKSsjvey
 gPc9P4YYIN9lDOPc//wtAoPRegs+Rjb+CA4TOnc/AKQFRlavSoW4gFL40M3MfAlQXrdU
 GTIODEEmD42Mdo6milowWGrHjkwIoofRbqJpkSwAU58n0rU/AelbWh0KXQpRA0Vtu8mT
 qjxj2FiEVoAoByeqIX89m/ECgAc8Nz2VwaLQfgYlYNB0xmAsT9LiyqAeCMwAuXnoGv+o
 lSnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhgnhp3gZrU3E0nOyf0LTTdUF+c5p7EH2G8IGkNawWpGCIiv1wzMUwcWi1s+vijXQODggGGB4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3nckeVSTgSIxNTw6z6F3+ZWdNQlA+IXwX6GcNvCvPkIqypbe+
 8GlSmx+BU7ZdDqyY/ly90xKi3BpFZTBPSNg46j0kVfAKYcPwJOIDrKI+Xpox1Cx6THM=
X-Gm-Gg: ASbGnctg4986cMTuFL3UraVzBqHtFtIVTZ6YeThG2XniEtCQqNzWIskRR4TV3GqaQBB
 CJp8/0eBh/mcWzJIjjv0AMgd0Em4pRnBVar6ai0M0pLcWB896Hl1pJpbZZV6+utyyDwsaCxyUFH
 C+MMjMwE6wXTILlZXXdVr/rCZnnaKYzN2kKYEXNM7jsD+LDLnWyAPHGH8pYJPWSVPnoWr0U6zbj
 SIiWXV6odR1wdQuAL2Iw8GbuzDR/2rHMq8HfgcB4AOE4HFLjUbAfly3aAtCsNxu7kjPAUpu8Lzb
 pMzL2TnOdDg+gf1NYyb5p0GYMUYkQuxDeiPoIV2iJBfW30MbspCWnuCWbcJcGNvYUxgs4mc1PLY
 fDUlhg6jh92SBfE5o8dgGZXTR3hQvslp4NdmonPyzR8kMLZlx3aDqhV/YLZ23vu+i5AYNjBSw2n
 L12vSD
X-Google-Smtp-Source: AGHT+IF7W9glMJzKUYjFGOUhZg08EaEGS7Gh/b9ZhpJABKKMblGOIczU8xqZWjZ9ZMZUzlSebKlnQQ==
X-Received: by 2002:a05:600c:6289:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-477a94ace2emr36507845e9.1.1763474089233; 
 Tue, 18 Nov 2025 05:54:49 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779b509a5esm189535435e9.2.2025.11.18.05.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 05:54:47 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b333e3242e33bab3912ef802a26cda373f6b7715190863d5b646204f31bc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 18 Nov 2025 14:54:38 +0100
Message-Id: <DEBVDZQNNQW8.2G5L3QAH4EJHZ@baylibre.com>
Cc: "Tom Rini" <trini@konsulko.com>, "Sumit Garg" <sumit.garg@kernel.org>,
 "Nishanth Menon" <nm@ti.com>, "Robert Nelson" <robertcnelson@gmail.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Bryan Brattlof" <bb@ti.com>,
 "Vishal Mahaveer" <vishalm@ti.com>, "Kevin Hilman" <khilman@baylibre.com>,
 "Sebin Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, <u-boot@lists.denx.de>, "Anshul Dalal"
 <anshuld@ti.com>, "Moteen Shah" <m-shah@ti.com>, "Santhosh Kumar K"
 <s-k6@ti.com>, "Nathan Morrisson" <nmorrisson@phytec.com>, "Garrett
 Giordano" <ggiordano@phytec.com>, "Judith Mendez" <jm@ti.com>, "Aparna
 Patra" <a-patra@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, "Chintan
 Vankar" <c-vankar@ti.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Neha Malcom Francis" <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, "Sughosh Ganu"
 <sughosh.ganu@linaro.org>, "Beleswar Padhi" <b-padhi@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, "Andrew Davis" <afd@ti.com>, "Wadim Egorov"
 <w.egorov@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "E Shattow" <e@freeshell.de>, "Devarsh
 Thakkar" <devarsht@ti.com>, "Peng Fan" <peng.fan@nxp.com>, "Jerome
 Forissier" <jerome.forissier@linaro.org>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Andre Przywara"
 <andre.przywara@arm.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 02/13] arm: mach-k3: Kconfig: Add symbols for IO+DDR
 Low Power Mode
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Dhruva Gole" <d-gole@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
 <20251110-topic-am62-ioddr-v2025-04-rc1-v5-2-980ee0036c26@baylibre.com>
 <20251111093521.t7akjlekm7ouff4u@lcpd911>
In-Reply-To: <20251111093521.t7akjlekm7ouff4u@lcpd911>
X-Mailman-Approved-At: Tue, 18 Nov 2025 15:20:43 +0100
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

--b333e3242e33bab3912ef802a26cda373f6b7715190863d5b646204f31bc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dhruva,

On Tue Nov 11, 2025 at 10:35 AM CET, Dhruva Gole wrote:
> On Nov 10, 2025 at 21:10:26 +0100, Markus Schneider-Pargmann (TI.com) wro=
te:
>> There is one new symbol to enable support to resume from IO+DDR where
>> the SoC is turned off and DDR is in self-refresh.
>>=20
>> The other symbol is the address of a memory region to be used to store
>> meta data. This has to be the same address as is used by the firmware.
>
> $title and here as well, sorry but I am just a bit confused, what/where i=
s the
> other symbol?

Thanks for spotting this, I had multiple config symbols in an earlier
revision. But the second config symbol is not necessary anymore.

Best
Markus

>
>>=20
>> Tested-by: Anshul Dalal <anshuld@ti.com>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  arch/arm/mach-k3/Kconfig | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 1b8c0b1eb968f0414107c0bf3142f744ce8364c8..4b7cef64935c7b403051c080=
eba7bdb48f727bf1 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -148,6 +148,14 @@ config K3_DM_FW
>>  	  bootloader, it makes RM and PM services not being available
>>  	  during R5 SPL execution time.
>> =20
>> +config K3_IODDR
>
> I see only 1 symbol - ie. this K3_IODDR throughout?
>
>> +	bool "Enable IO+DDR Low Power Mode support"
>> +	depends on SPL && (SOC_K3_AM62A7 || SOC_K3_AM62P5)
>> +	help
>> +	  Enable support for IO+DDR Low Power Mode. If this is enabled and a
>> +	  resume from IO+DDR is detected, metadata in the DDR is used to
>> +	  restore TIFS and resume DM.
>> +
>>  config K3_X509_SWRV
>>  	int "SWRV for X509 certificate used for boot images"
>>  	default 1
>>=20
>> --=20
>> 2.51.0
>>=20


--b333e3242e33bab3912ef802a26cda373f6b7715190863d5b646204f31bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaRx6nxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNI
5gD/cBFA5qnuaoHTtjdnekhhdeElcfturkL+rhCYFh3h3oMA/36DBaCjfXIm2OJn
cxOCDiheYd4QeC4FZXD9qXjcj4IF
=Bzj9
-----END PGP SIGNATURE-----

--b333e3242e33bab3912ef802a26cda373f6b7715190863d5b646204f31bc--
