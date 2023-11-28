Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B6EC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 08:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E42C870D2;
	Tue, 28 Nov 2023 09:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lmHu2pRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C70F8757B; Tue, 28 Nov 2023 09:32:54 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76734864C3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 09:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS8Wknf123975;
 Tue, 28 Nov 2023 02:32:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701160366;
 bh=xsa2yfyZhoifKooyIJbp9bjC7AIpCBxsxvQtEIUNQJU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lmHu2pRJyWfkPAdYt8UIeqkU7AqH0k1j0JEIA2c0lrExn/RfGHqmC4FgkVN0g1TnF
 rdlmYlCZAiuY18qjWnGZi7rV/5YcCl8yUwNjlYK04akEZRc3UTiPHbUa0JC7LAa5c1
 8sh1qh8u/NodK1abv8ytAPZS2Z6d0DIbem1Jc9sg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS8Wkxo038581
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Nov 2023 02:32:46 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 02:32:45 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 02:32:45 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS8WjhC005973;
 Tue, 28 Nov 2023 02:32:45 -0600
Date: Tue, 28 Nov 2023 14:02:44 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <nm@ti.com>, <u-boot@lists.denx.de>,
 <rogerq@kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH 2/2] configs: j721e_evm_a72_defconfig: Switch to bootstd
Message-ID: <20231128083244.rqi2grrjytbyfqyw@uda0497581>
References: <20231128072013.440465-1-n-francis@ti.com>
 <20231128072013.440465-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231128072013.440465-3-n-francis@ti.com>
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

Hi Neha,

$sub: s/j721e/j721s2/

On 12:50-20231128, Neha Malcom Francis wrote:
> Switch to using bootstd. Note that with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
> 
> Also config_distro_bootcmd.h header file that is no longer needed in
> j721s2_evm.h.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  configs/j721s2_evm_a72_defconfig | 5 +++--
>  include/configs/j721s2_evm.h     | 1 -
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
> index a7adb9282b..04bc6a4449 100644
> --- a/configs/j721s2_evm_a72_defconfig
> +++ b/configs/j721s2_evm_a72_defconfig
> @@ -29,9 +29,10 @@ CONFIG_SPL_SPI=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> -CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_OF_SYSTEM_SETUP=y
> -CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"

Since we haven't yet figured out how to run remoteprocs with stdboot [0]
can we keep `run boot_rprocs` also in this till that remoteproc stuff is
figured out? Don't want to break existing compatibility that we have
with this.

[0]: https://lore.kernel.org/u-boot/20231106152205.GG496310@bill-the-cat/

Regards,
Manorit

>  CONFIG_LOGLEVEL=7
>  CONFIG_SPL_MAX_SIZE=0xc0000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/include/configs/j721s2_evm.h b/include/configs/j721s2_evm.h
> index 692c6bb5e4..02673ae798 100644
> --- a/include/configs/j721s2_evm.h
> +++ b/include/configs/j721s2_evm.h
> @@ -10,7 +10,6 @@
>  #define __CONFIG_J721S2_EVM_H
>  
>  #include <linux/sizes.h>
> -#include <config_distro_bootcmd.h>
>  
>  /* DDR Configuration */
>  #define CFG_SYS_SDRAM_BASE1		0x880000000
> -- 
> 2.34.1
> 
