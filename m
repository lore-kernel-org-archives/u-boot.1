Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6762C54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 21:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2725E88049;
	Tue, 26 Mar 2024 22:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pmcxI2oV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE358803E; Tue, 26 Mar 2024 22:28:31 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B59E87F49
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 22:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QLSNeI107588;
 Tue, 26 Mar 2024 16:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711488503;
 bh=jdY98i7/25ixun6hDZIDNGrecJfc7R49IE6tJUAS6HY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pmcxI2oVgB2MCxHAtt+Yr6GyFXY2FZduutG8gfdWbLDSJnYINASmoKUWNg+cP7PNp
 VDS0sWICeh1KEpmDF4hFq7Vo0mlcP0dPd0ya54KhtmdOfb3StkdaQddi65ytx6LGoS
 uo0as446riDdWCXhfS1fxm9PV0b6hcWufzlCmXvM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QLSNcB048010
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Mar 2024 16:28:23 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 16:28:23 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 16:28:23 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QLSNSH031091;
 Tue, 26 Mar 2024 16:28:23 -0500
Message-ID: <aa3cf276-2e96-4bfd-8962-d4061165a259@ti.com>
Date: Tue, 26 Mar 2024 16:28:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] am625x_evm_a53: Tweak boot command to set fdt
Content-Language: en-US
To: Martyn Welch <martyn.welch@collabora.com>, Dave Gerlach
 <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>, "Menon, Nishanth"
 <nm@ti.com>
CC: <u-boot@lists.denx.de>
References: <20240326142634.2043539-1-martyn.welch@collabora.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240326142634.2043539-1-martyn.welch@collabora.com>
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

On 3/26/24 9:26 AM, Martyn Welch wrote:
> With the current config for tha SK-AM62, fdtfile isn't set in the U-Boot
> environment. When using bootflow to boot from a block device, where the
> extlinux.conf file specifies `fdtdir`, a fallback device tree is being
> constructed from the `soc` (`k3`) and `board` (`am62x`) environment
> variables, resulting in u-Boot trying to retrieve
> `/dtbs/6.8.1+/k3-am62x.dtb`. This file doesn't exist.
> 
> The environment variables `default_device_tree` and
> `default_device_tree_arch` are set in the config, the `findfdt` script
> can be called to construct `fdtfile` from the environment variables set
> by these config options, however this script currently isn't being run.
> 

I think this patch will be unneeded after this series goes in:

https://lore.kernel.org/u-boot/20240109191506.3820908-1-nm@ti.com/

Andrew

> Calling this script results in the correct device tree being retrieved:
> 
>     Retrieving file: /dtbs/6.8.1+/ti/k3-am625-sk.dtb
> 
> Many boards are calling this script as part of their boot command. The
> am62x currently isn't. Rectify this so that booting works correctly.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>   configs/am62x_evm_a53_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index 78287ec18a..e373e44a93 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -30,7 +30,7 @@ CONFIG_SPL_LOAD_FIT=y
>   CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
>   CONFIG_BOOTSTD_FULL=y
>   CONFIG_SYS_BOOTM_LEN=0x800000
> -CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
> +CONFIG_BOOTCOMMAND="run findfdt; run envboot; bootflow scan -lb"
>   CONFIG_BOARD_LATE_INIT=y
>   CONFIG_SPL_MAX_SIZE=0x58000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
