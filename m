Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910CFC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 15:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE72E82FAB;
	Tue,  1 Jul 2025 17:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uJ96UIn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F3783018; Tue,  1 Jul 2025 16:48:51 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2204A82FAB
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 16:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 561EmiRU2940808;
 Tue, 1 Jul 2025 09:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751381324;
 bh=VgIVDS5so43AKYBMPZeOIpWZMGwdfvE5y97xWa7X8iU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=uJ96UIn6Kh1iKCWaUC33cMxQBChC+vzdt+vAyx9wkKhS+egFJPCG4ZtlmdsT7n8hH
 VwfULBmZHP4PvzgLFtm1KT2K+2RA94riP0IPHK0b25+HxS76KHZbqhV61+EHkLzINN
 HIrRbtM3yQcKuxeZQz7NWZvOwU4W6ZwaPbbzqD/Y=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 561EmiuL316424
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 1 Jul 2025 09:48:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 1
 Jul 2025 09:48:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 1 Jul 2025 09:48:43 -0500
Received: from [172.24.227.249]
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 561EmdJB1466063;
 Tue, 1 Jul 2025 09:48:40 -0500
Message-ID: <5fabf5c6-004a-49aa-ab98-df5b9ecd51e3@ti.com>
Date: Tue, 1 Jul 2025 20:18:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/22] arm: mach-k3: common: Add lpm_resume_from_ddr
To: Markus Schneider-Pargmann <msp@baylibre.com>, Sumit Garg
 <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, Bryan Brattlof
 <bb@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>,
 <u-boot@lists.denx.de>, Kevin Hilman <khilman@baylibre.com>,
 Vishal Mahaveer <vishalm@ti.com>, Kendall Willis <k-willis@ti.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
 <20250623-topic-am62-ioddr-v2025-04-rc1-v3-6-a4da322c16af@baylibre.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-6-a4da322c16af@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 01 Jul 2025 17:06:58 +0200
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

Hi Markus,

On 23/06/25 17:38, Markus Schneider-Pargmann wrote:
> This is a common function that helps to resume from DDR. There are two
> pointers which are fetched from DDR to resume, the TIFS context pointer
> which points to the context in DDR. There is another pointer to the DM
> loadaddr to jump back into DM.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/common.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-k3/common.h |  1 +
>   2 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 7c3f42e35b0f3a5aa7ed0bf01a1479b29d947540..1ef560e2fb936c4245323bbebc5af3ec277b8792 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c

> +struct lpm_meta_data {
> +	u64 dm_jump_address;
> +	u64 tifs_context_save_address;
> +	u64 reserved[30];
> +} __packed__;
> +
> +void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
> +{
> +	struct lpm_meta_data *lpm_data = (struct lpm_meta_data *)meta_data_addr;
> +	typedef void __noreturn (*image_entry_noargs_t)(void);
> +	image_entry_noargs_t image_entry;
> +	int ret;
> +
> +	ret = lpm_restore_context(lpm_data->tifs_context_save_address);
> +	if (ret)
> +		panic("Failed to restore context from 0x%p\n",
> +		      (void *)lpm_data->tifs_context_save_address);

The above code is reading the value of 
lpm_data->tifs_context_save_address two times from DDR memory,
1. While requesting TIFS to restore the context
2. When printing the address sent to TIFS to restore the context in case 
of failure

It is better to read the address once from DDR memory and store in local 
variable as we need to print the exact address that was sent to TIFS for 
restoring context. (In case the DDR memory is instable, this read can 
have different values and can be misleading)

> +
> +	image_entry = (image_entry_noargs_t)(u64 *)lpm_data->dm_jump_address;
> +	printf("Resuming from DDR, jumping to stored DM loadaddr 0x%p, TIFS context restored from 0x%p\n",
> +	       image_entry, (void *)lpm_data->tifs_context_save_address);
> +
> +	image_entry();
> +}
> +#else
> +

Regards,
Akashdeep Kaur

