Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD64C369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 13:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9AF8298E;
	Sat, 19 Apr 2025 15:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Acz2DJrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFF982991; Sat, 19 Apr 2025 15:10:42 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1A18008A
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 15:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53JDAZcd1148282
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Apr 2025 08:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745068235;
 bh=W0hMu3KMEKGMfPzsPInOhqphVOA6bRxfxWua/rs/ZDM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Acz2DJrRPSRblgxY0Pkm5KiolPZKhBO+6MzuL7ZlJhlw5oDKK4znNc6iBMDsdF8cv
 mOIiXANMQOsr5b/j+HkZBuZ8RUVPpnKnkM3futhXdNUjM9bgkqekZG54xakZr1RGaQ
 hzahZ01Kp9wDGu1ZahB/0DQ30VPAX0mdsa/80jD4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53JDAZbG110508
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 19 Apr 2025 08:10:35 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 19
 Apr 2025 08:10:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 19 Apr 2025 08:10:34 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53JDAVG0032130;
 Sat, 19 Apr 2025 08:10:31 -0500
Message-ID: <cdf10124-cb4f-4953-b7f9-b39b91927a77@ti.com>
Date: Sat, 19 Apr 2025 18:40:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/9] beagle: beagley-ai: env: Set up the boot devices
 and boot methods
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250418193943.953952-1-nm@ti.com>
 <20250418193943.953952-4-nm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250418193943.953952-4-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 4/19/2025 1:09 AM, Nishanth Menon wrote:
> We just have a single MMC on BeagleY-AI. So drop all other boot options,
>
> In the meanwhile, we also will use efiboot and standard boot methods
> consistent with other K3 Beagle products.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes Since v1:
> - None
>
> V1: https://lore.kernel.org/r/20250411225717.3117370-4-nm@ti.com
>
>   board/beagle/beagley-ai/beagley-ai.env | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/board/beagle/beagley-ai/beagley-ai.env b/board/beagle/beagley-ai/beagley-ai.env
> index 10d62034e1af..db29d13420aa 100644
> --- a/board/beagle/beagley-ai/beagley-ai.env
> +++ b/board/beagle/beagley-ai/beagley-ai.env
> @@ -11,7 +11,8 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
>   	${mtdparts}
>   run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
>   
> -boot_targets=mmc1 mmc0 pxe dhcp
> +boot_targets=mmc1
> +bootmeths=script extlinux efi pxe

I am not too sure, if pxe boot is supported on this platform,

Please check once.


>   boot=mmc
>   mmcdev=1
>   bootpart=1:2
