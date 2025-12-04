Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CADD2A532
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A6FE8415D;
	Thu,  4 Dec 2025 21:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JqkJShXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C8B8413A; Thu,  4 Dec 2025 20:59:27 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB1E840FB
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b79d6a70fc8so213744766b.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764878365; x=1765483165;
 darn=lists.denx.de; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K+F5WH/BhXMFus/e2i3lcagvz4bLw5egLHoyyIDx8fc=;
 b=JqkJShXKOsixqGoCEzwh3RTGf0N2mKMFWVagDWcs2qp5PyxbPqsavYngU3yP/MRFZm
 FiqHTMxV8b6nbZWln3rvArFt/JEwhdp+ZfYqphBkI8eO0bVsAxfBUB4i/4lBW1i4alp1
 KCJjG+x73BKNXRLvLGPprj8btWAauTxG6tf6ew8MsXo8v9SlDGn2A/bCyhgX9LCC6HQ0
 as4Exb96FBQTaHZh4GjmDazifdp4ttBuCY1eBBgR4GMng4HZkRCQZ6WJbGdEiU0NI8ql
 yvXdbKK/WxSFHAmtQ/M2Un6S4mPChefe7bsXBq4snqpQ615LmoRfEoaBzSb1c1ClCC/G
 4hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764878365; x=1765483165;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+F5WH/BhXMFus/e2i3lcagvz4bLw5egLHoyyIDx8fc=;
 b=jO83EIDpJ77rM0hgK74erHO0BwtHH+zsOQqA5yrdMPkM2PR+D8xqVPvcrCInrz2Gxc
 xQhoNhvzH0K33UR41pY9vtA9HYOmApH717VrS4WlCdQ0yElJoW+gbBc5j9U4p2F8iP/S
 I4yoMcpC0XLMo6SnwgQejzQp4xSup+jXnuxcj/AEdnKyrt44UkDczxqiN+ueAamcn4U0
 T1+NtjfbMENO7M0u0CP66DbDt8aI7A0VFEcj/bf5padmEH1Il2aqSKpu1eXn08AzPLWX
 aWjqyPn90pR/WiZbpae4Y8WjqWDk8EEGc1HdDdXQCCvE09/dXUJ6viEyB1dj36BuIoB8
 swng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHBusBDRTbzj094dOO4jNA9b5/CfP72KCEMdkQOO3erLV4UWSDwhSG3Sqpi7R8kSd1oxDXecs=@lists.denx.de
X-Gm-Message-State: AOJu0YxulFGRbeeB9VC19S3PG+5JFCRCZHeH6wZZOJB4l8vu6N3iP5Xy
 VH24s1GP8m/gShi8OlFb7E2kkD6kG9ztegChsgaQ4ipej27u+FUaWi5jeImXyCltQ1o=
X-Gm-Gg: ASbGncuTBs1BVR2yMJHel//FCbYZiiDQCMWcd2mgxGOhD9gYDWMCOPV1UrqDxwcY6Ft
 i8Ie5sdJwUJS31k0dLdR4l+dwXD7DGH6iYPrOheMr/oNzHVyvlc07YWyn6VmK4KyYisxK+Sf2kD
 ppFI58sHq4XK2SncCGF97PYFXfB9avTjTiWZyzuoHdhQmSfSmxgx0t53fPIcgEhMzT9rLEe0vy/
 4Kjg1Wr2eGheGjnJhsrqL7BRNe/fu/wPhLIa9Rk7CRIe5ftbt0kp7UZ/kqU+Q1Up6fCYPK1thhZ
 grFC7TepK2zyzgfGNr0KIvv4Vyv9wXgwCB8gvtLXDwXXQalU/AVXRlhD3UsYNE/63m1EkwJzMLC
 PJzZrHflpbQT8+tUHhiIXdx1R9DtLPT+avMoc7RQqm5D23aSAPz6ZOZ53YqkgMhaM4JhsbXT86/
 SXs8Sk
X-Google-Smtp-Source: AGHT+IFYWeV8+n+Uzxxn6nHNSurY3ue1bRiwx2PlXBYr89EqPdWsGpZik6UOI7qYxl2KqzhUHxLg8w==
X-Received: by 2002:a17:907:9813:b0:b72:70e7:5b62 with SMTP id
 a640c23a62f3a-b79dbe85759mr729791666b.23.1764878364987; 
 Thu, 04 Dec 2025 11:59:24 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4975c56sm195910666b.33.2025.12.04.11.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:59:24 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b1325d3a54459e2ff5441d51799bdb45d8cad8ede7e945f8b41e04be2410;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 04 Dec 2025 20:59:18 +0100
Message-Id: <DEPP5X3J3HME.192SREW5B7XEP@baylibre.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, "Tom Rini" <trini@konsulko.com>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Robert Nelson"
 <robertcnelson@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Bryan
 Brattlof" <bb@ti.com>
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
Subject: Re: [PATCH v6 10/13] arm: dts: k3-am62a: Add r5 device nodes
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-10-6dd99a7271bb@baylibre.com>
 <a2fe0e50-3db7-4764-9591-c482af41b8f0@ti.com>
In-Reply-To: <a2fe0e50-3db7-4764-9591-c482af41b8f0@ti.com>
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

--b1325d3a54459e2ff5441d51799bdb45d8cad8ede7e945f8b41e04be2410
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 24, 2025 at 5:09 AM CET, Udit Kumar wrote:
>
> On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
>> These are needed in SPL to be able to resume from DDR immediately after
>> booting from IO+DDR.
>>
>> Tested-by: Anshul Dalal <anshuld@ti.com>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am6=
2a7-sk-u-boot.dtsi
>> index a70fc88317e04de032e4da1428e25eb78ecc30cf..7e6a76f72b2a63bf706c3839=
189b6213aee4497d 100644
>> --- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
>> @@ -14,6 +14,14 @@
>>   	memory@80000000 {
>>   		bootph-all;
>>   	};
>> +
>> +	reserved-memory {
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
>> +&wkup_r5fss0_core0_memory_region {
>> +	bootph-pre-ram;
>>   };
>>  =20
>>   &cbass_main {
>> @@ -68,6 +76,14 @@
>>   	bootph-all;
>>   };
>>  =20
>> +&wkup_r5fss0 {
>> +	bootph-pre-ram;
>> +};
>> +
>> +&wkup_r5fss0_core0 {
>> +	bootph-pre-ram;
>> +};
>> +
>
> Above bootph-pre-ram can be pushed to kernel device tree

Thanks, indeed, same as the other ones here. I think this can be done in
the next step.

Best
Markus

--b1325d3a54459e2ff5441d51799bdb45d8cad8ede7e945f8b41e04be2410
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaTHoFhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOx
5wEA16gYipevPUG702a9tmn+WfWWhBhnoRvG/LHRp8Nb/mIA/2xaYkCsu/yehpO+
2gc0qn/PREuk2WpzqnFWAdlvbyYB
=paMG
-----END PGP SIGNATURE-----

--b1325d3a54459e2ff5441d51799bdb45d8cad8ede7e945f8b41e04be2410--
