Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC14C79FA9
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A4283990;
	Mon,  5 Jan 2026 17:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="blbJKU5W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D95883E2B; Mon,  5 Jan 2026 16:44:13 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B4683D6C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso364125e9.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767627851; x=1768232651;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NrSLZcyyfGH6MxvEKLXBxDrIH5t1eSZucWOx4roNi8g=;
 b=blbJKU5W6Np2g7SkJ3qfdArF+WTOFUTdGkynl50mawxlbVl4x0T7WNzFfzZI55G+N3
 ho4KNsZUdSoOVkjVjiWRhg8hZ43OfPfBP6rlf3bMYCSrW8n/L5+u61EfqBEtBcJRgM4D
 UfvQQSEXCYkFqoEwLZoV+8mNpagIVQSPiFq+VWMAULD0XiMxm31Ye+gD2T53SK2Z6nAa
 X+xGdOely4IO8zDLAPg2d/rP+lOTsoMaero5jIybJe452TOehO+YCkVlUGgWjFAgCFNY
 C4lHrpH2rx1qObFYZiarW4rRkJTwm8hbeDlgaEzqNmQrkF8MfsvT1lPP+8t+755gpgED
 mbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767627851; x=1768232651;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrSLZcyyfGH6MxvEKLXBxDrIH5t1eSZucWOx4roNi8g=;
 b=FMM7ulEx3YN5i2qS/IK5y2ZiaSDDGP4PBa5NACUaKHBomFJ8/K8biubtTQATe9YCU4
 PkX4wd0/Pv2wlrvks4GZIhsh1O26CPocrUoFFrziICiyeleehip2TGUw5XTzLJIp1qe0
 uhMocaNIMczSwXTbt9PM0vvjvklONp5qVkn6d5dVKQFkpbfppF+EZlZRBXyhYwa6fsG9
 soeSv5nnN/6vld4IjDj3KbMDDll+3qgPcW1qIQkJlPilI/s/VI2M3IJdo9fiEJaGi+Um
 VFOc18sExmanida6f9XRLjawHw4CoIQb0Q1MbJxp7bSiop9MWuZ90QyX2+SGykKZ0sBn
 kpWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJhFggqKus//solMSDdTKWd06Dv4dlxQXnUZcFD00c/FD86fcy/iMwjUtMV10sMCk6YWCi69w=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/6U18qQFUC0C4GUUpLzaDPxxSObk98H9t7yg2crVJ3BL32KfX
 f7vu2UDL/Da8SJxiaFDF11Mq9BYDm2Q5KI0ld8A+J0Vax0DcWnbUGPiiL8Jbs3uqA7o=
X-Gm-Gg: AY/fxX4K1kTo2G/WBIW8JH7kZCYlg/B8gR80y7ebcWc0bb38bfuiojccqV9kuhGxD4U
 9fyq8xWWU+hjZw00CAM9DMMrBR27A2VZM/fygMNa7GpSOM2x4aB4YaMCMTPYyL5CN6P092bj9xF
 7Ncqpuq06UTCbwCa0lTWkGgls8nUk7qo/JgRUA8oMs5J2xJ5fBlPx8F1gqYPN5O6RL4xGiz4h1M
 dRkMt6Uvsb31HoxC+gtOy2TldDx5m+87Dsnd+X23vEfbl6ZvTwiTAebCOtYnbIMpgHi2XvqepS0
 dmND+HGKp3Qk49w/Ao1aTu1U8cQiKXOCKt0a2EwGGw2SXMbtat0D/qfvFnImLXLREhNmom/pwPW
 YZHZUP4+U36xoz+KxO3UAMALjdGIHSQaQZd3CA2BOLJpKSI4wfvL2oXMdOMxSRbfiqxLqFtvoYn
 1oFDvf
X-Google-Smtp-Source: AGHT+IFl9RZn4Bf4/Y68tY5NGSlyQNvSWhE/R0ovq0nTMaaJIN2o7mYDHr2HA0bcgE0+30AGiZ7O6w==
X-Received: by 2002:a05:600c:858e:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-47d1c629902mr486035155e9.4.1767627850988; 
 Mon, 05 Jan 2026 07:44:10 -0800 (PST)
Received: from localhost ([195.52.160.197]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca5a132sm132000f8f.39.2026.01.05.07.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 07:44:10 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b5a035c087770d340ae973a64daaa9a6d3f8a2e92857123483851049004b;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 05 Jan 2026 16:44:02 +0100
Message-Id: <DFGRRWEVBH0U.Z1093DOR6RQ9@baylibre.com>
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
 "Prasanth Babu Mantena" <p-mantena@ti.com>, "Beleswar Padhi"
 <b-padhi@ti.com>, "Manorit Chawdhry" <m-chawdhry@ti.com>, "Andrew Davis"
 <afd@ti.com>, "Wadim Egorov" <w.egorov@phytec.de>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "E Shattow" <e@freeshell.de>, "Devarsh
 Thakkar" <devarsht@ti.com>, "Peng Fan" <peng.fan@nxp.com>, "Jerome
 Forissier" <jerome.forissier@linaro.org>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Andre Przywara"
 <andre.przywara@arm.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v8 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, "Tom Rini" <trini@konsulko.com>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Robert Nelson"
 <robertcnelson@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Bryan
 Brattlof" <bb@ti.com>
X-Mailer: aerc 0.21.0
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
 <20251222-topic-am62-ioddr-v2025-04-rc1-v8-8-e70fed16b166@baylibre.com>
 <094bbc1c-8a97-4f75-992f-c53615f22d46@ti.com>
In-Reply-To: <094bbc1c-8a97-4f75-992f-c53615f22d46@ti.com>
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:35 +0100
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

--b5a035c087770d340ae973a64daaa9a6d3f8a2e92857123483851049004b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Udit,

On Tue Dec 23, 2025 at 9:10 AM CET, Udit Kumar wrote:
> Hi Markus
>
> On 12/23/2025 1:31 AM, Markus Schneider-Pargmann (TI.com) wrote:
>> When exiting a low power mode with DDR self-refresh, we can directly
>> resume after DDR setup is done. Call the common function to resume.
>>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am=
62ax/am62a7_init.c
>> index c1c7d669a45f53b7528c80d44bf9b914fed1cc10..51b0386853b065d62cd0ecac=
589e316de5ab4038 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
>> @@ -198,6 +198,15 @@ void board_init_f(ulong dummy)
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
>> +	}
>
> Could you help, how qos will be set after s2r

Yes, you are right, a misunderstanding on my side. I swapped
spl_enable_cache() and setup_qos() for the next version and only do
setup_qos() before lpm resume.

Thanks for all your reviews.

Best
Markus

--b5a035c087770d340ae973a64daaa9a6d3f8a2e92857123483851049004b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaVvcQhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNn
ZgD/bJk0AHgZ5t7Oxlo7Bnsk/kCWk0zQ8luYZ8wcfutj+6YBAL9Vf5JMBnIEp5yS
tQhcnHN1katIcnhxTVwURckrOm4H
=Q7S6
-----END PGP SIGNATURE-----

--b5a035c087770d340ae973a64daaa9a6d3f8a2e92857123483851049004b--
