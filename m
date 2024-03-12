Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142ABC54E49
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 03:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902A587F01;
	Tue, 12 Mar 2024 04:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="G4FTJk6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F6BF87F1C; Tue, 12 Mar 2024 04:51:50 +0100 (CET)
Received: from mail-m12766.qiye.163.com (mail-m12766.qiye.163.com
 [115.236.127.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E18879E2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 04:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=G4FTJk6b9469aF/2A9kZFxqe6PHTxthtwxXA/DfmL5yK2qOrhml7XVjPSysNDuX4bJlkuGq/HDakO6e5tZwHD004UuNFM9E0myxw1Z2AF/HCvI5Ew+GYfeAlwTLz44VCoUYueIhG/sLVYUugZuOl0DYGH7ay4ZckS1deSvWr/Yw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Bkc8fMnHG0Z47PUizoOz8sjdLAkI6kI5cYALayJTetQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A25729002DD;
 Tue, 12 Mar 2024 11:51:36 +0800 (CST)
Message-ID: <cb4505f2-8a7f-408d-ba98-bb4dd304fa92@rock-chips.com>
Date: Tue, 12 Mar 2024 11:51:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] rockchip: boot_mode: fix
 rockchip_dnl_key_pressed requiring ADC support
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-16-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-16-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09PHVYeGEhJSUpDTEpDGU5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e30c985e703a9kunma25729002dd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgg6KQw4DTMUFjYOFCk3SwoC
 SytPFDpVSlVKTEpLSUpOT0JMTU9PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0lDNwY+
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


On 2024/3/4 19:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> ADC support is implied by the Rockchip arch Kconfig but that means it
> should be possible to disable ADC support and still be able to build.
>
> However the weak implementation of rockchip_dnl_key_pressed() currently
> blindly use functions from the ADC subsystem which do not exist when ADC
> is not enabled, failing the build.
>
> Therefore, let's encapsulate this logic with a check on the ADC symbol
> being selected.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/boot_mode.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
> index eb8f65ae4e9..f9be396aa55 100644
> --- a/arch/arm/mach-rockchip/boot_mode.c
> +++ b/arch/arm/mach-rockchip/boot_mode.c
> @@ -40,6 +40,7 @@ void set_back_to_bootrom_dnl_flag(void)
>   
>   __weak int rockchip_dnl_key_pressed(void)
>   {
> +#if CONFIG_IS_ENABLED(ADC)
>   	unsigned int val;
>   	struct udevice *dev;
>   	struct uclass *uc;
> @@ -69,6 +70,9 @@ __weak int rockchip_dnl_key_pressed(void)
>   		return true;
>   	else
>   		return false;
> +#else
> +	return false;
> +#endif
>   }
>   
>   void rockchip_dnl_mode_check(void)
>
