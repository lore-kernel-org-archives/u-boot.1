Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A946ECCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47F583826;
	Sun, 26 Oct 2025 16:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Wlr1jKo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FD3837E4; Sun, 26 Oct 2025 16:40:51 +0100 (CET)
Received: from mail-m49211.qiye.163.com (mail-m49211.qiye.163.com
 [45.254.49.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496E5837E4
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748f08;
 Sun, 26 Oct 2025 23:40:46 +0800 (GMT+08:00)
Message-ID: <ca7cd911-8bed-4ac2-bf08-72e9bf579127@rock-chips.com>
Date: Sun, 26 Oct 2025 23:40:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] rockchip: rk3528: Implement
 read_brom_bootsource_id()
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20251019154728.846096-1-jonas@kwiboo.se>
 <20251019154728.846096-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019154728.846096-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a212de14003afkunm8924eea24d2209
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSk9NVk5LGBlKH0tKHUkYT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Wlr1jKo/jbfXH27KPE0hPDo22lfGOKjJPt/4LSGBJ0HjeUlIZjGuFW158wE+K4JGp8PdnysGyLxxS4TZjOdWRK+gn3v8TLxMPCbwAnVgaOPA0vfYCj4Fc068Zu4ypDFvGy1QA7Kxp1E7OYKVWu9EkXfWEqdreMEnYyQJh4k8kio=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=5Ecx0qVyAAavNHunInR450zgtGk82G8RmNfWlSKmqjM=;
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
> The bootsource ids reported by BootROM of RK3528 for e.g. USB differs
> compared to prior SoCs:
>
> - Booting from USB report a new bootsource id 0x81.
>
> Add a RK3528 specific read_brom_bootsource_id() function to help decode
> this new bootsource id value to help support booting from USB on RK3528.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v4: No change
> v3: New patch to map USB bootsource id on RK3528
> ---
>   arch/arm/mach-rockchip/rk3528/rk3528.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
> index f9bfc445b857..57ead0006f1f 100644
> --- a/arch/arm/mach-rockchip/rk3528/rk3528.c
> +++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
> @@ -49,6 +49,21 @@ void board_debug_uart_init(void)
>   {
>   }
>   
> +u32 read_brom_bootsource_id(void)
> +{
> +	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +
> +	/* Re-map the raw value read from reg to an existing BROM_BOOTSOURCE
> +	 * enum value to avoid having to create a larger boot_devices table.
> +	 */
> +	if (bootsource_id == 0x81)
> +		return BROM_BOOTSOURCE_USB;
> +	else if (bootsource_id > BROM_LAST_BOOTSOURCE)
> +		log_debug("Unknown bootsource %x\n", bootsource_id);
> +
> +	return bootsource_id;
> +}
> +
>   int arch_cpu_init(void)
>   {
>   	u32 val;

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

