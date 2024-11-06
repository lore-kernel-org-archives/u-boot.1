Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C665BD44D42
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A3488DB6;
	Wed,  6 Nov 2024 11:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OgWzHYy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CBB88E63; Wed,  6 Nov 2024 11:19:08 +0100 (CET)
Received: from mail-m10134.netease.com (mail-m10134.netease.com
 [154.81.10.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B6B88009
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f800eff;
 Wed, 6 Nov 2024 18:19:01 +0800 (GMT+08:00)
Message-ID: <a7c57856-6203-4116-b6e0-cec91bdb4905@rock-chips.com>
Date: Wed, 6 Nov 2024 18:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] rockchip: rk3288-tinker: Include mmc nodes in
 pre-reloc for env load
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlDH1ZCTkxCTBlLTkpITBlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300fc174503afkunm1f800eff
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjY6DQw*TTIpTzFRCRgUC0M*
 Fz1PChpVSlVKTEhLQ0NDSE9JSkhDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQk1DNwY+
DKIM-Signature: a=rsa-sha256;
 b=OgWzHYy2n+ioCsubSk9GPmf0bs382QBS18dAsOO4CV2LNJUaG8khopP6i+KpMsSDND3kYecYzgZzGv89xBKEjm5c3fh/emLJOKzoD06559qS25T7m3aIjVy5ojlzLbc/ijD23FZ1Audj4QmxqxCcbSCOrL9QusDQvLCGt0k2I0k=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Fnt5Q5Gm4c3cU5uYNatpq1wtWFlBfmuy/ACSn2akzrM=;
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


On 2024/11/6 00:00, Jonas Karlman wrote:
> Include mmc related nodes in U-Boot proper pre-reloc phase to ensure
> environment can be loaded from mmc devices.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-tinker-s-u-boot.dtsi | 5 +++++
>   arch/arm/dts/rk3288-tinker-u-boot.dtsi   | 7 +++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
> index a782f2f9804a..614d47ce1801 100644
> --- a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
> @@ -15,20 +15,25 @@
>   
>   &emmc {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_bus8 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_cmd {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_pwr {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
> diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> index 4f230739f1c3..7568b1495341 100644
> --- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> @@ -33,6 +33,7 @@
>   
>   &pcfg_pull_none_drv_8ma {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pcfg_pull_up {
> @@ -41,26 +42,32 @@
>   
>   &pcfg_pull_up_drv_8ma {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_bus4 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_cd {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_cmd {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &uart2 {
