Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1878CC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 15:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E54E805E7;
	Wed,  5 Feb 2025 16:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gd6TtMWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0218080711; Wed,  5 Feb 2025 16:44:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6CA80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738770245;
 bh=bNnK68k5IKSmGz5kJ3TJ1LUL3FdKk0S0e3lXmuOtfHE=;
 b=gd6TtMWOwu/QSAxINWt0F9vDI6Mci/NHELAheDtSP9TIEV7rShnSskBNHi9XQkgkkgMJfzrZW
 BUpX6FfSzu5FLsUgQ21GD9HlD731jFy9yBcRN0nDGHuizyWil4Shy8JQa1JmUBHNKJggodsRSm8
 cEdp3TiwS5Ivu0VCWujX7n5blZdj1k1OvW1zyljVzku4AhyCQ19bJnEzI5YRPe+QzpyG1QOjnZM
 sJiSOgXY6LUjzCMW0Mo9eX7XSOqbzx9iGMlrDvtTr6EnmfjVmOmsQ6ulO6/AaBmXhspo5SBS2EB
 WfCF8OrvZbc+01zxDAfMWBBp7pC/qyyCOcd0qw+6d0wg==
X-Forward-Email-ID: 67a38742fb44099d0e59465b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3fe5d802-442e-4269-b628-26ba288db61e@kwiboo.se>
Date: Wed, 5 Feb 2025 16:43:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/29] rockchip: Update rk3399 bootph-tags for VPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-21-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-21-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 2025-02-05 02:55, Simon Glass wrote:
> When VPL is in use, memory init happens in SPL, so there is no need to
> include the DMC device before that. Adjust the tags to save space.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/dts/rk3399-u-boot.dtsi | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 2bec139d833..76efd703902 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -71,7 +71,12 @@
>  	       0x0 0xffa88800 0x0 0x1800
>  	       0x0 0xffa8a000 0x0 0x2000
>  	       0x0 0xffa8c000 0x0 0x1000>;
> -	bootph-all;
> +#ifdef CONFIG_VPL
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +#else
> +		bootph-all;
> +#endif
>  	status = "okay";
>  };
>  
> @@ -118,8 +123,10 @@
>  };
>  
>  &sdmmc {
> +	bootph-pre-sram;
>  	bootph-pre-ram;
>  	bootph-some-ram;
> +	bootph-verify;

The addition to include sdmmc in TPL and VPL should also be limited to
VPL=y. All Rockchip AArch64 targets are now using BootROM to load SPL
after DRAM is initialized in TPL, so there is no need for sdmmc node.

The sdmmc node was changed from bootph-all in commit 100f489f58a6
("rockchip: rk3399: Fix loading FIT from SD-card when booting from
eMMC") for similar reason as this patch, remove unneeded/unused nodes
to save space.

Regards,
Jonas

>  
>  	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
>  	u-boot,spl-fifo-mode;

