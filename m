Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A13C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 09:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92F6987CB1;
	Mon, 18 Mar 2024 10:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="elBNNP2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A9A87D1D; Mon, 18 Mar 2024 10:13:11 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F4E879F4
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 10:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42I9D0Q7116493;
 Mon, 18 Mar 2024 04:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710753180;
 bh=4hglnJeHwLbf7w7vKUQiLN0IkBIl0WuaGqeK3BBxK9M=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=elBNNP2mJv0eOOoJ4y+3gk8B5nL3+9Yx70a59var5ZM0YGnK0XYx1c0XR1G63Vv/Y
 +10d2P2gcGKY3RnRFTZYfNlC01lRLK7lmiqiqEw6icT+WTFRNJ49wRWuwS75uLL0Ym
 WQSrP5R+VSVF5P3mmpFds6SsXjCsjRkX7xzMY5zA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42I9D0uG001895
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Mar 2024 04:13:00 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 04:13:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 04:13:00 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42I9CuIt010453;
 Mon, 18 Mar 2024 04:12:57 -0500
Message-ID: <cb640669-643d-cbde-9f55-b0ebd969669c@ti.com>
Date: Mon, 18 Mar 2024 14:42:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm: mach-k3: Fix config check for FS_LOADER
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Nishanth Menon <nm@ti.com>, Igor
 Opaniuk <igor.opaniuk@foundries.io>, Andrew Davis <afd@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>
References: <20240314143311.259568-1-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240314143311.259568-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
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



On 3/14/24 8:03 PM, MD Danish Anwar wrote:
> load_firmware() API calls fs-loader APIs and checks for CONFIG_FS_LOADER
> before calling those APIs. The if check only checks for CONFIG_FS_LOADER
> but not for CONFIG_SPL_FS_LOADER.
> 
> When CONFIG_FS_LOADER is enabled, load_firmware() API calls fs-loader APIs
> but this is done at SPL stage and at this time FS_LOADER is not built yet
> as a result we see below build error.
> 
>   AR      spl/boot/built-in.o
>   LD      spl/u-boot-spl
> arm-none-linux-gnueabihf-ld.bfd: arch/arm/mach-k3/common.o: in function
> `load_firmware':
> /home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:184: undefined
> reference to `get_fs_loader'
> arm-none-linux-gnueabihf-ld.bfd:
> /home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:185: undefined
> reference to `request_firmware_into_buf'
> make[2]: *** [/home/danish/workspace/u-boot/scripts/Makefile.spl:527:
> spl/u-boot-spl] Error 1
> make[1]: *** [/home/danish/workspace/u-boot/Makefile:2055:
> spl/u-boot-spl] Error 2
> make[1]: Leaving directory '/home/danish/uboot_images/am64x/r5'
> make: *** [Makefile:177: sub-make] Error 2
> 
> Fix this by modifying the if check to CONFIG_IS_ENABLED(FS_LOADER) instead
> of IS_ENABLED(CONFIG_FS_LOADER) as the former will check for the
> appropriate config option (CONFIG_SPL_FS_LOADER / CONFIG_FS_LOADER) based
> on the build stage.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm/mach-k3/r5/common.c      | 2 +-
>  arch/arm/mach-omap2/boot-common.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index 7309573a3f..c02f8d3309 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -70,7 +70,7 @@ int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr)
>  	char *name = NULL;
>  	int size = 0;
>  
> -	if (!IS_ENABLED(CONFIG_FS_LOADER))
> +	if (!CONFIG_IS_ENABLED(FS_LOADER))
>  		return 0;
>  
>  	*loadaddr = 0;
> diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
> index 57917da25c..aa0ab13d5f 100644
> --- a/arch/arm/mach-omap2/boot-common.c
> +++ b/arch/arm/mach-omap2/boot-common.c
> @@ -190,7 +190,7 @@ int load_firmware(char *name_fw, u32 *loadaddr)
>  	struct udevice *fsdev;
>  	int size = 0;
>  
> -	if (!IS_ENABLED(CONFIG_FS_LOADER))
> +	if (!CONFIG_IS_ENABLED(FS_LOADER))
>  		return 0;
>  
>  	if (!*loadaddr)

Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
