Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63490E67801
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 16:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF1083B99;
	Mon, 22 Dec 2025 17:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e1FAwwQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5F983C28; Mon, 22 Dec 2025 17:06:23 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D0683B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 17:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64b4b35c812so5578098a12.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 08:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766419579; x=1767024379;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fu91PANJrExnx4W8OoUXjbqOJIg20QTTnT+bGZ0D6vY=;
 b=e1FAwwQjq4bD7G7ziPzIzsP1zlQh1XjvhsJSE+UMxe+T0aswLQaMpDwC6a2/owb8HP
 0C71KSGw/0zYMRH7ZTnpGT5jndD7fHjFXLjirBe6gt7LCXkLLoaRQ1JV8jn1YLo+s49a
 wtmwgHW+lFV4dwEfjSSmlpojqFnf9I3ZfNiEJqFPFe9XUUJXbfWMX7L+Rg8d/d3VvtGi
 AoBqxNXQrUdDEa1Vz8wPUEAqkTeC0Y2dANQlDVV9tdLzjcN8j0z2Mp8MDVeoR/naa3QI
 8hgFcySfuFYZc4YfGHQcubrB56SDswBqc75zUJkKQPHUS8tGXdsSA+ixi4YEkm/Ml58+
 lzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766419579; x=1767024379;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fu91PANJrExnx4W8OoUXjbqOJIg20QTTnT+bGZ0D6vY=;
 b=GJrNQPlFcxzimdtaXV8pvrtsoOKN1G4UzMW7TivxAu2PWZnhC6JBFdW3a9s09JN2L2
 vU04O94WnVc2hI+tnwDMyMt4/D8lDbBWi9z+axH9sPtG9D/n/rX6YZF+DkeNqFQcUS0W
 R5svj8QXFNdByDcJUT6WCiJFIoQFiwzRssn7MOocKyYCFEBD692LWsqIsZquLkfITflg
 AVbWdOHLmJOLGaBP3u/rCnlbCCxOx7Kd7o7zGlpADQ/sSQf6hSTQnMqxmnXKGv7MQ9R5
 mkpR861GTQ+/SC26aGNkZ20INQULb8a8HRZSnUGeDOXRWUSHwybYhGNiIseHOM6xXeuX
 ltCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6NpgTIpV6P4opVvbH8RYjvnieqIzNMxFqf+XzJWDXZueHrB0huLjctFUtj8xjKqJIQjZLVdk=@lists.denx.de
X-Gm-Message-State: AOJu0YwkNSKbnAY6mEvcBWK2pKfAPPkm5fnfRyC9/KuWlOZq6RzBp+b3
 CAXaeSSGGI8Zc0sGoxe5kj4GZ1plaMO9EXcLR8vSMW1FpFlOVPGPcRa1XfROTk0yFJ8=
X-Gm-Gg: AY/fxX4PPVGHLxUO73EoRhNMjF43ZgyZaVn4DEzkp6mH3ukTLTL/YlGgnugYzLZfV16
 4gUJIWhkREGjWeqxAPQsvdJVsQsJOA3JGB7tDA7ph/Lbis/4MvXHxvIyasLc/xHkDNN24ZPVmH8
 /rq/FyW4e8T95l8xWV0AMtXXG49DFZ4EIEYZH9VEJ7ITJL/1Tvyx514mJV+k5mJNhOE6DG/ufjS
 etLZ9bX3rXL7I3KcrUK02XqEFYMGEGTq6/q1fMsxcr1ZTC0f50cHeB0adqZu1ym5pkmXTonfSqK
 WIAy0sS+cRWhTsuMfM7F0yE9+XYx1il77tXxpUrkSEUfurU9hVydRvKi/e6JA5F2jRBN5CtOIiI
 yJ5jlYNhKqaQN1n8QrPvw8Coeqo7a95OHsFDOgagbxTK9x93lnJ+wm393BE8jjF0JTt+fBcdApV
 SJ9NBd
X-Google-Smtp-Source: AGHT+IH9634n+dDLkX3jnCmRlsSl1z8irYo6WAgme6lUWWRHilQVClFwpLHoNWnaiM0LQJAc3iPX7g==
X-Received: by 2002:a17:907:7703:b0:b80:3fc0:834 with SMTP id
 a640c23a62f3a-b803fc0088dmr803440066b.10.1766419579066; 
 Mon, 22 Dec 2025 08:06:19 -0800 (PST)
Received: from localhost ([195.52.160.197]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3ffbasm1135411166b.61.2025.12.22.08.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 08:06:18 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6b3a34bc2183ae0612edf7f3f1b86c9227acc9681cb7a72b6eaf8be375cf;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 22 Dec 2025 17:06:07 +0100
Message-Id: <DF4VH6TD31UZ.ITG8JJL63AE7@baylibre.com>
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
Subject: Re: [PATCH v7 06/13] arm: mach-k3: common: Add lpm_resume_from_ddr
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, "Tom Rini" <trini@konsulko.com>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Robert Nelson"
 <robertcnelson@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Bryan
 Brattlof" <bb@ti.com>
X-Mailer: aerc 0.21.0
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-6-f113b156f83f@baylibre.com>
 <c82bed01-8e24-48b7-bd30-d378f12940a1@ti.com>
In-Reply-To: <c82bed01-8e24-48b7-bd30-d378f12940a1@ti.com>
X-Mailman-Approved-At: Mon, 22 Dec 2025 17:56:25 +0100
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

--6b3a34bc2183ae0612edf7f3f1b86c9227acc9681cb7a72b6eaf8be375cf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Dec 13, 2025 at 7:47 AM CET, Udit Kumar wrote:
>
> On 12/10/2025 7:39 PM, Markus Schneider-Pargmann (TI.com) wrote:
>> This is a common function that helps to resume from DDR. There are two
>> pointers which are fetched from DDR to resume, the TIFS context pointer
>> which points to the context in DDR. There is another pointer to the DM
>> loadaddr to jump back into DM.
>>
>> Tested-by: Anshul Dalal <anshuld@ti.com>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   arch/arm/mach-k3/common.c | 49 +++++++++++++++++++++++++++++++++++++++=
++++++++
>>   arch/arm/mach-k3/common.h |  1 +
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index 81e180c8706445c270cfecb0500015eee7547f98..ee56f0b86ce303e319cfcd2b=
0db3bade1540635b 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -193,6 +193,55 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolatio=
n_if_set(void)
>>   	return 0;
>>   }
>>  =20
>> +#if IS_ENABLED(CONFIG_K3_IODDR)
>> +static int lpm_restore_context(u64 ctx_addr)
>> +{
>> +	struct ti_sci_handle *ti_sci =3D get_ti_sci_handle();
>> +	int ret;
>> +
>> +	ret =3D ti_sci->ops.lpm_ops.min_context_restore(ti_sci, ctx_addr);
>> +	if (ret)
>> +		printf("Failed to restore context from DDR %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +struct lpm_meta_data {
>> +	u64 dm_jump_address;
>> +	u64 tifs_context_save_address;
>> +	u64 reserved[30];
>> +} __packed__;
>> +
>> +void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
>> +{
>> +	struct lpm_meta_data lpm_data =3D *(struct lpm_meta_data *)(uintptr_t)=
meta_data_addr;
>> +	typedef void __noreturn (*image_entry_noargs_t)(void);
>> +	image_entry_noargs_t image_entry;
>> +	int ret;
>> +
>> +	ret =3D lpm_restore_context(lpm_data.tifs_context_save_address);
>> +	if (ret)
>> +		panic("Failed to restore context from 0x%x%08x\n",
>> +		      (u32)(lpm_data.tifs_context_save_address >> 32),
>> +		      (u32)lpm_data.tifs_context_save_address);
>> +
>> +	image_entry =3D (image_entry_noargs_t)(uintptr_t)lpm_data.dm_jump_addr=
ess;
>> +	printf("Resuming from DDR, jumping to stored DM loadaddr 0x%x%08x, TIF=
S context restored from 0x%x%08x\n",
>> +	       (u32)(lpm_data.dm_jump_address >> 32),
>> +	       (u32)lpm_data.dm_jump_address,
>> +	       (u32)(lpm_data.tifs_context_save_address >> 32),
>> +	       (u32)lpm_data.tifs_context_save_address);
>
> you want printf, here or could be debug info ?

I think it would be good to have this as printf instead of debug info in
case something goes wrong at some point.

Best
Markus


--6b3a34bc2183ae0612edf7f3f1b86c9227acc9681cb7a72b6eaf8be375cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaUlscBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlN3
EgD9GUJP16vaksu+ZXuA9UbTUmTfsZDs9CrLXIN/dH6xOkABAKxwiGyXu04h3IbO
qAL5O/A5CeH9/ZjUGdvXmUhDlzEA
=L28S
-----END PGP SIGNATURE-----

--6b3a34bc2183ae0612edf7f3f1b86c9227acc9681cb7a72b6eaf8be375cf--
