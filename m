Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59611C369C2
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 02:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B82F48291D;
	Sat, 26 Apr 2025 04:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="go9rYLMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92E1982A0A; Sat, 26 Apr 2025 04:25:57 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BB8828BC
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 04:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53Q2PmaA3065585
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 21:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745634349;
 bh=O6S9kYRV1v3vvPnBSBDhRIiVAUHj+r10EhUYe/Cvl08=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=go9rYLMus8Y2PYgokhjDwDZAgIJrCfgVXHBU3OyYlPyylAmmT3jIkvSbNR30ccDp8
 MKer9Xtm9Fpeu1KSep/fRf9m+IYMrPuu1WuqnznkbQthik5ah1M6BamQcUBuF2lQY4
 mmWuTqKzYBJ5vMUM9IsDuvrRr18z5gC5aVKic8vU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53Q2Pm2f012010
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 21:25:48 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 21:25:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 21:25:48 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53Q2PgOh039151;
 Fri, 25 Apr 2025 21:25:45 -0500
Message-ID: <9feba128-c461-4394-be1d-203cce675b63@ti.com>
Date: Sat, 26 Apr 2025 07:55:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] beagle: beagley-ai: env: Set up the boot devices and
 boot methods
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>
References: <20250425173120.141503-1-nm@ti.com>
 <20250425173120.141503-4-nm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250425173120.141503-4-nm@ti.com>
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


On 4/25/2025 11:01 PM, Nishanth Menon wrote:
> We just have a single MMC on BeagleY-AI. So drop all other boot options,
>
> In the meanwhile, we also will use efiboot and standard boot methods
> consistent with other K3 Beagle products.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes Since v2:
> - None
>
> V2: https://lore.kernel.org/r/20250418193943.953952-4-nm@ti.com
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

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   boot=mmc
>   mmcdev=1
>   bootpart=1:2
