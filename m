Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F0AD5E120
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 03:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1006588C66;
	Fri,  8 Nov 2024 04:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZFpnKKRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5D788C75; Fri,  8 Nov 2024 04:19:18 +0100 (CET)
Received: from mail-m12743.qiye.163.com (mail-m12743.qiye.163.com
 [115.236.127.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB4F88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2270e36c;
 Fri, 8 Nov 2024 11:19:09 +0800 (GMT+08:00)
Message-ID: <59e455f8-234d-4c5e-9cdb-d808e0f3cb45@rock-chips.com>
Date: Fri, 8 Nov 2024 11:19:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next RFC 5/5] ram: rk3399: fail DRAM init when pctl
 channel init fails instead of hanging
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
 <20241105-rk3399-dram-init-v1-5-1e29acdf0966@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105-rk3399-dram-init-v1-5-1e29acdf0966@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgZTVZNQxpISExCGRpCH0xWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9309c86b0703afkunm2270e36c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06Pgw5ETIsFitDFj8hAx0*
 FhQaCUlVSlVKTEhKS0hOQk5LTElNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKT01PNwY+
DKIM-Signature: a=rsa-sha256;
 b=ZFpnKKRwmZFIa081QM0NzeDLa9crRkMPXGg6oLi6zfwnfRwr62tqvh4vZt7weCYBgSm/lDtZeTVqu7zTzzTG/rYrC28jrrlA0+RssRrL96RtH/Bu+7PEyKuqV7HXCIxniFxTT9rTV2FcqOTyvnVAGCUL3ERocE4jFTmeZtUoWOU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=UaVKU6AkOIhBkz3rKmmFlkSJ37rjvipklxFSFJNMiwQ=;
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

Hi Quentin,

On 2024/11/6 01:21, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Instead of hanging via an infinite while loop, propagate the fail to the
> caller and let it handle the fail. For RK3399, this means that panic()
> will be called, (by default) resetting the CPU and giving another chance
> at doing a DRAM init.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   drivers/ram/rockchip/sdram_rk3399.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index d953dda13cd3daa689fa362dc511c372db454064..591e1469afb25ba606d8f7e44f63e50905b4ab31 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -817,8 +817,7 @@ static int pctl_start(struct dram_info *dram,
>   			if (count > 1000) {

Could you try with increase the timeout count from 1000 to 1000000?

Thanks,

- Kever

>   				printf("%s: Failed to init pctl channel 0\n",
>   				       __func__);
> -				while (1)
> -					;
> +				return -1;
>   			}
>   			udelay(1);
>   			count++;
> @@ -853,8 +852,7 @@ static int pctl_start(struct dram_info *dram,
>   			if (count > 1000) {
>   				printf("%s: Failed to init pctl channel 1\n",
>   				       __func__);
> -				while (1)
> -					;
> +				return -2;
>   			}
>   			udelay(1);
>   			count++;
>
