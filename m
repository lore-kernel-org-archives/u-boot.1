Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171D3D5E124
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 03:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA85588EEA;
	Fri,  8 Nov 2024 04:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="T/87xh1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B898588E26; Fri,  8 Nov 2024 04:29:09 +0100 (CET)
Received: from ec2-44-216-146-141.compute-1.amazonaws.com
 (ec2-44-216-146-141.compute-1.amazonaws.com [44.216.146.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1219C88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2276182d;
 Fri, 8 Nov 2024 11:29:02 +0800 (GMT+08:00)
Message-ID: <32dd9c3b-0dd3-41ee-a47a-00096d42b56f@rock-chips.com>
Date: Fri, 8 Nov 2024 11:29:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 3/4] rockchip: tpl: allow to call
 board/SoC-specific code before DRAM init
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
 <20241106-rk3399-sysreset-gpio-tpl-v2-3-22aa82189eb6@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241106-rk3399-sysreset-gpio-tpl-v2-3-22aa82189eb6@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01DH1ZNSkodSEsZGksZH0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9309d1753b03afkunm2276182d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N0k6Cgw4GjIaEispFk8iNwJD
 SB8KCQpVSlVKTEhKS0hNTk9ITk1KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSU1CNwY+
DKIM-Signature: a=rsa-sha256;
 b=T/87xh1Jczp7pHxgMZ8jVMSpYrvpJuTNXX8s5VwX2Ohzr+ihKs6MDA/cUCnEV6ekLtP4BdlRbtILP/30TkdYGMJJSlR525E69YXYQ9DNJdv/CiWQQ2MepUqO7oPjRl+6x+vqekoRQhaaM4pgBo6aP1vTO8FvIrPsdaynAXXy6P0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=GbuxTkrEo/aO3kCdEUYDkPJoKE1OZ4Lr9FuYapfnhIo=;
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


On 2024/11/6 19:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This defines a weak tpl_board_init function that can be used for running
> board/SoC-specific code before the DRAM init happens, similarly to
> spl_board_init() for SPL.
>
> Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/tpl.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> index bbb9329e725af79ea4c4049aa7890a4a143e7df5..6b880f19f84e57e7bc0c93b16b188bc56267827e 100644
> --- a/arch/arm/mach-rockchip/tpl.c
> +++ b/arch/arm/mach-rockchip/tpl.c
> @@ -21,6 +21,10 @@
>   #include <timestamp.h>
>   #endif
>   
> +__weak void tpl_board_init(void)
> +{
> +}
> +
>   void board_init_f(ulong dummy)
>   {
>   	struct udevice *dev;
> @@ -54,6 +58,8 @@ void board_init_f(ulong dummy)
>   	if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
>   		timer_init();
>   
> +	tpl_board_init();
> +
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>   	if (ret) {
>   		printf("DRAM init failed: %d\n", ret);
>
