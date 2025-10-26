Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA30FCCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C645836D1;
	Sun, 26 Oct 2025 16:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Iv2t3DbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE02B837E4; Sun, 26 Oct 2025 16:40:43 +0100 (CET)
Received: from mail-m15571.qiye.163.com (mail-m15571.qiye.163.com
 [101.71.155.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4771782E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748efe;
 Sun, 26 Oct 2025 23:40:37 +0800 (GMT+08:00)
Message-ID: <e449465d-acd0-4162-a3ed-4dab99e17211@rock-chips.com>
Date: Sun, 26 Oct 2025 23:40:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] rockchip: spl: Add a read_brom_bootsource_id()
 helper
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20251019154728.846096-1-jonas@kwiboo.se>
 <20251019154728.846096-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019154728.846096-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a212dbfa203afkunm4f3e98cf4d2177
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEMeVh4fGUpIQhkYQ0pOSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Iv2t3DbFFNPyFGDAYYYopqV5nsalLzzZPg2EqNRLWm8fb5CQa3sYxhLu5Opxum8+HygUKVoKyNK3BTllwE7ZheWBeS0LnSbbCt2jsPXrYL/J86bJjzol51NWeI0a3ROKM+Rj8LdO1d0gOzEavEJVCxT+ZCaUZ/756vdgn4mSEr0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=/JJbjvf17S/h6xPx6N+Tt2lptTPN2bAc2FYHpdrMUNA=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/10/19 23:47, Jonas Karlman wrote:
> The bootsource ids reported by BootROM of RK3528 and RK3576 for e.g.
> SPI NOR and USB differs slightly compared to prior SoCs:
>
> - Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
> - Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
> - Booting from sfc1 M0 has not been tested (no board using this config).
> - Booting from USB report a new bootsource id 0x81 on RK3528 and RK3576.
>
> Add a helper function to read the bootsource id. This helper function
> will be used to translate the new values to the common BROM_BOOTSOURCE
> enum values on RK3528 and RK3576.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v4: No change
> v3: Mention RK3528 in commit message
> v2: No change
> ---
>   arch/arm/include/asm/arch-rockchip/bootrom.h | 2 ++
>   arch/arm/mach-rockchip/spl.c                 | 7 ++++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
> index e736772fda75..b15938c021d6 100644
> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> @@ -64,4 +64,6 @@ extern const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1];
>    */
>   #define BROM_BOOTSOURCE_ID_ADDR   (CFG_IRAM_BASE + 0x10)
>   
> +u32 read_brom_bootsource_id(void);
> +
>   #endif
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index f4d29bbdd17e..1ce3a3b05547 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -31,6 +31,11 @@ int board_return_to_bootrom(struct spl_image_info *spl_image,
>   __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   };
>   
> +__weak u32 read_brom_bootsource_id(void)
> +{
> +	return readl(BROM_BOOTSOURCE_ID_ADDR);
> +}
> +
>   const char *board_spl_was_booted_from(void)
>   {
>   	static u32 brom_bootsource_id_cache = BROM_BOOTSOURCE_UNKNOWN;
> @@ -40,7 +45,7 @@ const char *board_spl_was_booted_from(void)
>   	if (brom_bootsource_id_cache != BROM_BOOTSOURCE_UNKNOWN)
>   		bootdevice_brom_id = brom_bootsource_id_cache;
>   	else
> -		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +		bootdevice_brom_id = read_brom_bootsource_id();
>   
>   	if (bootdevice_brom_id < ARRAY_SIZE(boot_devices))
>   		bootdevice_ofpath = boot_devices[bootdevice_brom_id];

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

