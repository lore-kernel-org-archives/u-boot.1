Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C334E7B61B
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079738756A;
	Wed,  4 Oct 2023 15:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bVx86qmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B8B8755B; Wed,  4 Oct 2023 15:48:34 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 855DB87500
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394DmNee056451;
 Wed, 4 Oct 2023 08:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696427303;
 bh=mmxSUUqrN4vgNJYuBT6WGtXtzQT9GX4pm2Cpa4Y8vWk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bVx86qmImo8UQu80k+IetSPeQtKC/O8Rbkj7T2wC9T6GqylfAB+1CRJXTVdEsCLdq
 SaEslMVrpYVGIrwPU6UdqBr1wU6qLMJaGAp4WcSiiBVeG73YYV394St7CbKflredUL
 q7EPuRWrLA93KUaV0yZTAQXzK90zqh7+L0BBHOW0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394DmNRt017252
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 08:48:23 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 08:48:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 08:48:23 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394DmMbV024309;
 Wed, 4 Oct 2023 08:48:22 -0500
Message-ID: <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
Date: Wed, 4 Oct 2023 08:48:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
To: Roger Quadros <rogerq@kernel.org>, <trini@konsulko.com>, <nm@ti.com>
CC: <vigneshr@ti.com>, <m-chawdhry@ti.com>, <sjg@chromium.org>,
 <jonas@kwiboo.se>, <srk@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231004132324.44198-2-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 10/4/23 8:23 AM, Roger Quadros wrote:
> ti_mmc is not a valid boot_target for standard boot flow so

Is there some way to make it into a valid boot_target? Otherwise
how do we use uEnv.txt files, or boot from FIT images with overlays?

Andrew

> remove it. Prefer mmc1 (sd-card) over mmc0 (emmc).
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>   board/ti/am62x/am62x.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index 22a6c2c91b..e53a55c38f 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -8,7 +8,7 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
>   	${mtdparts}
>   run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
>   
> -boot_targets=ti_mmc mmc0 mmc1 usb pxe dhcp
> +boot_targets=mmc1 mmc0 usb pxe dhcp
>   boot=mmc
>   mmcdev=1
>   bootpart=1:2
