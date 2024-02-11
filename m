Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2571C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 21:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C2487B77;
	Sun, 11 Feb 2024 22:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="w9/bP08p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 851628786C; Sun, 11 Feb 2024 22:17:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3BD8786C
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 22:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b753=JV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707686187;
 bh=52Sl/4zDNh7JwQvotV/n8rghtUqN+V7PrnYTZQCHTIE=;
 b=w9/bP08psmEnztHhrgPWTn+ZbTeGTW/VYTPmdTx05fylB35ld+19SaV7FOKOgFOynKBLeBro4
 sJbE7FK1K9kWxcUtRXT2epCD9a9ttEiTBpSkafnqTqMJy3UTrEwpZ6VV9MQpsExFpSvmrTRSVp1
 zP96Fa4FAAfbYxSHrcJpDxDVhdpnr8C83/iW3P/BtI7w8eJj/ioxdir9XPQz3EGwMXCJCoMwip6
 Sndv92e+NKpGr+TeFmXs75ULR+8t5TIvXBI/xeLGOtJVIaeSy/66WkVO2GQNUKxk5Ag98H6wqt+
 MiNQ1JD23AhNAThJntokTppZ5ZSLmJfxNOPSDkpph8iQ==
Message-ID: <a3489e7d-7949-4e68-ab85-f569db9427a0@kwiboo.se>
Date: Sun, 11 Feb 2024 22:16:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] rockchip: rk3588: bind MMC controllers in U-Boot
 proper pre-reloc
To: Quentin Schulz <foss+uboot@0leil.net>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>,
 Andy Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-15-6c9ffe09b924@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240209-jaguar-v2-15-6c9ffe09b924@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c9392ac33d2ccc75254589
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

On 2024-02-09 10:50, Quentin Schulz wrote:
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
> ---
>  arch/arm/dts/rk3588s-u-boot.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index bf3b1ea8a3c..3f194e8ffbd 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -187,12 +187,12 @@
>  };
>  
>  &sdmmc {
> -	bootph-pre-ram;
> +	bootph-all;

I know that there is no TPL for rk3588 so this does not matter at this
time but I would suggest you instead add bootph-some-ram for both these
instead of changing them to bootph-all.

We are not expected to need the MMC devices in TPL, and I am working on
a series that changes from bootph-all to bootph-pre-ram+bootph-some-ram
combo in an upcoming rk3399 cleanup series.

Regards,
Jonas

>  	u-boot,spl-fifo-mode;
>  };
>  
>  &sdhci {
> -	bootph-pre-ram;
> +	bootph-all;
>  	u-boot,spl-fifo-mode;
>  };
>  
> 

