Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1EED2A532
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B2F84179;
	Thu,  4 Dec 2025 21:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IIvuq6Zz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E498413A; Thu,  4 Dec 2025 20:48:16 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77358840FB
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b73545723ebso206220766b.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764877694; x=1765482494;
 darn=lists.denx.de; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EqmxrYTv0FZPnG+V9C1Pd215fqZlK8wuTGSX1k9kM8Y=;
 b=IIvuq6ZzNDQFrt+WIMyJZl+J/KIjURP4Q5fQR97VdKmBOdwQKBjfjC2xgBrIKfGXnM
 RWOid09fOZ9Ap6xq5q5PGwT42UD9IkqdWTq0YShqjOVMbY5jDIpOmEmjsI2DGrGgTPPU
 9vUPk6bpO1Y1tVvzSSX+436DyeJKwlFEUtkQL867+K1KKhdTSZ9YY9mCybJOZnwnMod7
 D282AicFXK/qudigu6B06paoM4l5b559Bu3ipxwwP7fN4LPsX6RY+o3bSBIebamFRz0E
 vwsXc7wUHggwzLQRdmDC7Pe8pg964QzImumr8QSIeZmA6CUZlGPFNN2iKPmBIftV+PaJ
 Zqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877694; x=1765482494;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqmxrYTv0FZPnG+V9C1Pd215fqZlK8wuTGSX1k9kM8Y=;
 b=dzpB28NJAvS4mBfclSsinfex4VGjJx8AdMlkjpZoDuWZWMYO4fo/56evzYPF/Y7jzQ
 HHzOXTodj+eMwdVJEaaKAwgBG3rLeRo0eueN2Pw/oSwYOqDbrhHw3d6UjinKbZ5/NBIm
 ETwbdsunHjZbD5vjuCGMsBJQIRKzip5w/N13XWH8MZSATRMOXLlvcY++5v77nypShE6z
 GAHliVMkSNqYpA7Lc0Xt98LpyidgeE0YYK+oBueumB0xm9l8qmBL9V1+CE5AwJDmiSoA
 vEPxj0kozy5LwrkZsLjFMyEhATUuDLLG58bZKUqwsBRV6dfAAQCh5qEd2awYEXfNCY8I
 l60g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFf3uMpB6aVZwIu1RkyfWICXsRlnF0Gp93mTbkRNoyb2XqsRR72AkJ6nfKM/3sww4LOnh2650=@lists.denx.de
X-Gm-Message-State: AOJu0YxVGo5eyHFt9sGajbM/G8s3B2h+WJ0FgRPAddUhORtXZakOsWF1
 l+8bGVTGTA+/JZy4IseVs/QYB+x/Ki4vRGWH0xhoC5GG5UQCrGKsWAkbfpRZpa9WGEg=
X-Gm-Gg: ASbGnctOC4yg38j8VjXBOrSOZbgHQZB9y3Kk5Pc8hpi3SG4vyJav2oZkxrXnqTVVquU
 tTEUgcS1vlYl3+uGSRvLH4aB3t18mUe9d+m18uUpL+HiHXGrjs8EJzhr093BGc2BAo+lGoMhXu1
 Xjf+hUECAGDqIcwDTYfnY3HSk9n6Cg6ZrGh6QWc8phtIp8SOeZkfxg9jNd0hH/zT1IgLHcQMakJ
 ObtJzUoWMHbJv2Z8E6gCyYju6mtA3Bb8qNSR2I+mtjBwv8bchheuA9kk2R0enYpwaZq/JKmh2+n
 KeRyJ1JPdSTwcRQJ5yylfN1X1RdGoiCUAutqI5ZTmifwLDHBG/qRvhbm0rOWUXsIJQ33UzNAQ+6
 sI2f/dipOUo7jA6jEkthxzAhrUiTi7ED+Ian4uXFtMKVCOoTOi1M+KfJHQQfJcfamkYgSI5C/Vx
 P46m5f
X-Google-Smtp-Source: AGHT+IELh2xYHA0VfGv2LTwZ1InCBLXDj6+Nd/iT+v9Ct86oCp5ulDmx1Z/LvF2M9bJgvs5HpANg2Q==
X-Received: by 2002:a17:906:6a17:b0:b6d:9bab:a7ba with SMTP id
 a640c23a62f3a-b79dc7586a4mr787731566b.42.1764877693600; 
 Thu, 04 Dec 2025 11:48:13 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f49a7951sm206031966b.49.2025.12.04.11.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:48:12 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=670fd56d81396f5ce24af06f69f98744ec2454987a84cd2bff6db88ff5b3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 04 Dec 2025 20:48:07 +0100
Message-Id: <DEPOXCMTQ7M4.2INWB9COZMHWS@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
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
Subject: Re: [PATCH v6 07/13] arm: mach-k3: common: Helper for LPM meta data
 address from DT
X-Mailer: aerc 0.21.0
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-7-6dd99a7271bb@baylibre.com>
 <b3e0d56c-a02f-408c-b6e8-966956b548c1@ti.com>
In-Reply-To: <b3e0d56c-a02f-408c-b6e8-966956b548c1@ti.com>
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

--670fd56d81396f5ce24af06f69f98744ec2454987a84cd2bff6db88ff5b3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 24, 2025 at 5:06 AM CET, Udit Kumar wrote:
>
> On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
>> Add a small helper that uses memory regions referenced by the R5
>> devicetree node to calculate the LPM meta data address.
>>
>> Tested-by: Anshul Dalal <anshuld@ti.com>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   arch/arm/mach-k3/common.c | 43 +++++++++++++++++++++++++++++++++++++++=
++++
>>   arch/arm/mach-k3/common.h |  1 +
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index b28c2cd5776f29d75d54da9078e5fb17768d69c9..191254b391af68cb6c277f98=
6069ed87211f2fc1 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -16,6 +16,8 @@
>>   #include <linux/printk.h>
>>   #include "common.h"
>>   #include <dm.h>
>> +#include <dm/of_access.h>
>> +#include <dm/ofnode.h>
>>   #include <remoteproc.h>
>>   #include <asm/cache.h>
>>   #include <linux/soc/ti/ti_sci_protocol.h>
>> @@ -36,6 +38,7 @@
>>   #include <wait_bit.h>
>>  =20
>>   #define CLKSTOP_TRANSITION_TIMEOUT_MS	10
>> +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET	0x108000
>>  =20
>>   #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
>>   #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
>> @@ -191,6 +194,42 @@ bool wkup_ctrl_is_lpm_exit(void)
>>   }
>>  =20
>>   #if IS_ENABLED(CONFIG_K3_IODDR)
>> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
>
> device specific function in common file ?
>

Thanks, it is common between am62a7 and am62p5.

Also thanks for the other reviews, I am addressing most of it in my next
version.

Best
Markus

--670fd56d81396f5ce24af06f69f98744ec2454987a84cd2bff6db88ff5b3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaTHldxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOy
FgEAmeKKQKGO87c+Qk7vPMh8u057DLJkei9/7CS3ziG5mckA/2iBQUtRSROeFESQ
0X9Y9rVcFLdNUUNoQZhls3X8uUgA
=fj5i
-----END PGP SIGNATURE-----

--670fd56d81396f5ce24af06f69f98744ec2454987a84cd2bff6db88ff5b3--
