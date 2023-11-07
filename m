Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107BBC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 07:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3480B86FBF;
	Tue,  7 Nov 2023 08:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bH5e87g4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 714EB870C8; Tue,  7 Nov 2023 08:02:25 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FAFE867E2
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 08:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A772EGp069919;
 Tue, 7 Nov 2023 01:02:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699340535;
 bh=qzbWOU7V+r6r31XocKPxq138F5D26yfXlIbApbT4JyM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bH5e87g4dt6UpH4AJOeGOt/L5Mqwbm7iOCh1E78sYcO+a0VdQGbJIzChDuU3DH5FJ
 dg+hiijgtxxlwGRU6VUT3v5/dEBO4+9hYh9vWFBZoAzURTKMGbN3MmUIK9PglHbt4/
 U/6k+woXQwjIGpvUkaR92VdJwip6BmftzJYbxEFs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A772E4g059291
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 01:02:14 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 01:02:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 01:02:14 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A772AXt042061;
 Tue, 7 Nov 2023 01:02:11 -0600
Message-ID: <e78ef01a-3692-405d-b03e-5de6341de839@ti.com>
Date: Tue, 7 Nov 2023 12:32:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/12] board: ti: j721e: evm: Drop unused headers
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Robert Nelson <robertcnelson@gmail.com>, Jason Kridner
 <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231104072150.3339-1-nm@ti.com> <20231104072150.3339-2-nm@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231104072150.3339-2-nm@ti.com>
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

Hi Nishanth,

On 04/11/23 12:51, Nishanth Menon wrote:
> Drop headers that are no longer necessary for build
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   board/ti/j721e/evm.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index d4f7c1d9f938..aa22f1653fec 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -8,21 +8,13 @@
>    */
>   
>   #include <common.h>
> -#include <env.h>
> -#include <fdt_support.h>
>   #include <generic-phy.h>
>   #include <image.h>
> -#include <init.h>
> -#include <log.h>
>   #include <net.h>
>   #include <asm/arch/hardware.h>
> -#include <asm/global_data.h>
>   #include <asm/gpio.h>
> -#include <asm/io.h>
>   #include <spl.h>
>   #include <dm.h>
> -#include <dm/uclass-internal.h>
> -#include <linux/printk.h>
>   
>   #include "../common/board_detect.h"
>   

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
