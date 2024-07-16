Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E852C3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 01:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDBBE8892F;
	Tue, 16 Jul 2024 03:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GZl4xSEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC8188925; Tue, 16 Jul 2024 03:57:14 +0200 (CEST)
Received: from mail-m25479.xmail.ntesmail.com (mail-m25479.xmail.ntesmail.com
 [103.129.254.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399368887A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 03:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GZl4xSEVlgZWMhdl2op9GbpfYLP6ygb6adF+jOY74c+8bDNTLSHtS9aFTh0fL4rJ3KgZvLFWC6EyFuoQA8lisrHZoLTfgBTUhr6nqz/N6qnkuYTUgTnVIjNnQNv9sn8IqXjBDmKXz++S4JqOHxy4iy516wCfLPvlncH1jl2D+8g=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=PgkLllHvqT5uVwJrEAAPQ8u5WLWAPXEGOaoeOc99j/M=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 40270900390;
 Tue, 16 Jul 2024 09:56:56 +0800 (CST)
Message-ID: <0517a8f3-80f1-4089-b739-9f1b828aa024@rock-chips.com>
Date: Tue, 16 Jul 2024 09:56:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/3] rockchip: px30: bind sub-nodes for GRF (syscon)
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240614-px30-io-domain-v1-0-9552966d3911@cherry.de>
 <20240614-px30-io-domain-v1-1-9552966d3911@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240614-px30-io-domain-v1-1-9552966d3911@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkoeGlZOGR9IQxlIGRhPGkpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b941d0d503a9kunm40270900390
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Lyo5QjIzCBgDGjUVOhke
 KxxPCyhVSlVKTElKS0JOS0pMS09LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUxDNwY+
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


On 2024/6/15 00:54, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> There are some sub-nodes under the grf DT nodes, so add bind callback
> function in syscon_px30 driver to scan them recursively.
>
> Fixes: e9ccb2f526ed ("rockchip: add px30 architecture core")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/px30/syscon_px30.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/px30/syscon_px30.c b/arch/arm/mach-rockchip/px30/syscon_px30.c
> index c9de57493d8..893a5234baa 100644
> --- a/arch/arm/mach-rockchip/px30/syscon_px30.c
> +++ b/arch/arm/mach-rockchip/px30/syscon_px30.c
> @@ -18,6 +18,9 @@ static const struct udevice_id px30_syscon_ids[] = {
>   U_BOOT_DRIVER(syscon_px30) = {
>   	.id = UCLASS_SYSCON,
>   	.name = "px30_syscon",
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +	.bind = dm_scan_fdt_dev,
> +#endif
>   	.of_match = px30_syscon_ids,
>   };
>   
>
