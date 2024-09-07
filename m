Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3018EE71080
	for <u-boot@archiver.kernel.org>; Sat,  7 Sep 2024 13:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D9188A5F;
	Sat,  7 Sep 2024 15:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lz5PqPVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB7D88908; Sat,  7 Sep 2024 07:42:15 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B575888DD
 for <u-boot@lists.denx.de>; Sat,  7 Sep 2024 07:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4875gAgc119345;
 Sat, 7 Sep 2024 00:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725687730;
 bh=3vQ78284Bddsbk2c5a11OMrQgETcwY43K6tvXYK1UTg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lz5PqPVDaA4LLoqKpf0qTZaagfdC5K7964IfD/4cD57IV2rlPE4RkkP0WzQuMjSfm
 fj2BSy321IeELrLZ07Vk20IHqkPM8XcFUpFaA9vQFP+i6j7N4tDz84yYZV9aHVINsC
 g/+nrtvRX09cGYiwjfi8DA63b0DKG+p30jCEo+qc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4875gAqI110129
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 7 Sep 2024 00:42:10 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 7
 Sep 2024 00:42:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 7 Sep 2024 00:42:09 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4875g6HK062059;
 Sat, 7 Sep 2024 00:42:07 -0500
Message-ID: <2fdfcb29-f6d1-4e30-960d-f1d500fb1cf6@ti.com>
Date: Sat, 7 Sep 2024 11:12:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 2/3] board: ti: j784s4: Initialize the ESM & PMIC
 ESM
To: Andrew Halaney <ahalaney@redhat.com>, Apurva Nandan <a-nandan@ti.com>,
 "Tom Rini" <trini@konsulko.com>
CC: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Eric
 Chanudet" <echanude@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>, <u-boot@lists.denx.de>
References: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
 <20240906-j784s4-esm-enable-v1-2-b83b17d5a744@redhat.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240906-j784s4-esm-enable-v1-2-b83b17d5a744@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Sat, 07 Sep 2024 15:02:36 +0200
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

Hi Andrew,

On 9/7/2024 2:54 AM, Andrew Halaney wrote:
> From: Keerthy <j-keerthy@ti.com>
>
> Initialize the ESM & PMIC ESM. This allows things like
> the watchdog to reset the board when tripped.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Link: https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/board/ti/j784s4/evm.c?h=ti-u-boot-2024.04&id=9d8b40958ce792808bc571d828197dbc2e7978d6
> [halaney: add a line to the commit message, include header]
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   board/ti/j784s4/evm.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> index 548dbd5925d..a0ef3a44536 100644
> --- a/board/ti/j784s4/evm.c
> +++ b/board/ti/j784s4/evm.c
> @@ -7,6 +7,7 @@
>    *
>    */
>   
> +#include <dm.h>
>   #include <efi_loader.h>
>   #include <init.h>
>   #include <spl.h>
> @@ -72,4 +73,31 @@ int board_late_init(void)
>   
>   void spl_board_init(void)
>   {
> +	struct udevice *dev;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_ESM_K3)) {
> +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000",
> +						&dev);
> +		if (ret)
> +			printf("MISC init for esm@700000 failed: %d\n", ret);
> +
> +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000",
> +						&dev);
> +		if (ret)
> +			printf("MISC init for esm@40800000 failed: %d\n", ret);
> +
> +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@42080000",
> +						&dev);
> +		if (ret)
> +			printf("MISC init for esm@42080000 failed: %d\n", ret);
> +	}

Thanks for patch ,

IMO, if one of esm is failing then we can skip other esm probe,

> +
> +	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
> +						  DM_DRIVER_GET(pmic_esm),
> +						  &dev);

Same here if esm probe is successful then only we should probe pmic_esm.

Reason is , if any of probe is failing functionality will not work and

there is no point to probe devices, if function is not working.

> +		if (ret)
> +			printf("ESM PMIC init failed: %d\n", ret);
> +	}
>   }
>
