Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8798CC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 10:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA4A587752;
	Wed, 24 Jan 2024 11:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SZJUdGH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F79687BEF; Wed, 24 Jan 2024 11:36:10 +0100 (CET)
Received: from mail-m12762.qiye.163.com (mail-m12762.qiye.163.com
 [115.236.127.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B5587707
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 11:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=SZJUdGH1pxuOApDAITV1r7bkYbDJ7RFfMzJ7RDLNGabvB1tTaH6MvBjRx/gCcFqq9SbSh7f3A2KCfwrBa4KMBQ8o/o5fH2MjLJZ1IEvHY2KuXCsG2mpXoNcDaJaa+g3qbr3WaqDmeEwImZf7BtyvQpXyFad2xbpbdX13Z031Ns0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=ml9WCU+tCa1CHa/d/UGalRTH82gkfwQAQ2ZINzL3ZTQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 5A593400417;
 Wed, 24 Jan 2024 18:35:50 +0800 (CST)
Message-ID: <062d9519-f129-422c-89ed-3b009e222150@rock-chips.com>
Date: Wed, 24 Jan 2024 18:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] rockchip: rk3588: bind MMC controllers in U-Boot
 proper pre-reloc
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-17-1eec1c34953c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240123-jaguar-v1-17-1eec1c34953c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1DHVZOTklNSEkaSEhKGkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d3b0a5abe2eb3kusn5a593400417
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6URw4OjwjTQE0GBgoER4y
 FD0KCj5VSlVKTEtNS0JJTk5KSE5DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTE9JNwY+
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

On 2024/1/23 22:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as
> pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot proper
> bind the device before relocation.
>
> While this is usually not much of an issue, it is when there's a lookup
> for devices by code running before the relocation. Such is the case of
> env_init() which calls env_driver_lookup() which calls
> env_get_location() which is a weak symbol and may call
> arch_env_get_location() also a weak symbol. Those are two functions that
> may traverse UCLASS to find some devices (e.g.
> board/theobroma-systems/common/common.c:arch_env_get_location()).

This sounds like we need to update arch_env_get_location() instead of 
enable mmc driver

before relocate, because you we don't really need the mmc driver works 
here, there is no

access requirement to mmc at this point, right?


Thanks,

- Kever

>
> This allows something in the env_init() call stack to be able to use
> uclasses for SD and eMMC controller on RK3588S/RK3588. This aligns the
> behavior with what seems to be all SoCs except RK356x family.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   arch/arm/dts/rk3588s-u-boot.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 960ac4abda3..bdfe13836b2 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -187,12 +187,12 @@
>   };
>   
>   &sdmmc {
> -	bootph-pre-ram;
> +	bootph-all;
>   	u-boot,spl-fifo-mode;
>   };
>   
>   &sdhci {
> -	bootph-pre-ram;
> +	bootph-all;
>   	u-boot,spl-fifo-mode;
>   };
>   
>
