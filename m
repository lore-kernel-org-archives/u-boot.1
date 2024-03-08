Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1396DC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 10:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D376287EEB;
	Fri,  8 Mar 2024 11:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eD13Sn79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEBF888043; Fri,  8 Mar 2024 11:06:54 +0100 (CET)
Received: from mail-m12776.qiye.163.com (mail-m12776.qiye.163.com
 [115.236.127.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642EF86564
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 11:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eD13Sn79/x/OB2IWDDz0XnTowCFR5AHtnmJWnOSQX3vqNbVxdY96OUM3u6+7dGRH74O8rLKsDQePaVwizxIvL4l+SAtRjsbJfi5Mp0/fintwYtPhWWhbElKjPTLKZKlXGHqrukVMeEMNpN5L8XxrxTUQjKns78t8V22HwhLPLik=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=BiKHqsO0ThVdfAkFRAVhRbAPuXfENRWk9sa6GuoNZw0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 53A4C90034E;
 Fri,  8 Mar 2024 18:06:39 +0800 (CST)
Message-ID: <ae65970a-1298-4a4c-ada2-5b340938c70b@rock-chips.com>
Date: Fri, 8 Mar 2024 18:06:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/20] rockchip: rk3588: bind MMC controllers in U-Boot
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
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240221-jaguar-v3-0-1f256a82201b@theobroma-systems.com>
 <20240221-jaguar-v3-15-1f256a82201b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240221-jaguar-v3-15-1f256a82201b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgYGlYYHh5LTxkYSBhKQkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e1d87754f03a9kunm53a4c90034e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NS46Ahw5NTMOND41HxANSgEQ
 HFYaCi1VSlVKTEtCQ0JJT0tLQ09IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTE9CNwY+
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


On 2024/2/21 18:37, Quentin Schulz wrote:
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
>
> This allows something in the env_init() call stack to be able to use
> uclasses for SD and eMMC controller on RK3588S/RK3588. This aligns the
> behavior with what seems to be all SoCs except RK356x family.
>
> Additionally, if any other env function (e.g. env_load) were to be used
> before relocation, this is also required as otherwise it wouldn't be
> able to find the MMC device(s).
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588s-u-boot.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index bf3b1ea8a3c..ac67c777ade 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -188,11 +188,13 @@
>   
>   &sdmmc {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   	u-boot,spl-fifo-mode;
>   };
>   
>   &sdhci {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   	u-boot,spl-fifo-mode;
>   };
>   
>
