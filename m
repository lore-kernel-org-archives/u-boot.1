Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC37C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 01:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2827D807FE;
	Sun,  9 Feb 2025 02:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="evsrb1Zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF7980805; Sun,  9 Feb 2025 02:47:08 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDBB9807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 02:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660f=VA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739065624;
 bh=mjBUGyhKU96TEQQH4WHmKHL2p2XEm1mLz/jmbSGlpzU=;
 b=evsrb1ZdheLUIneDMCnB/RKqXnQ4V1EcyeLLIpFelnDywQwR2eywyHXJJ2tZ4mm5MVvtIcVbw
 JMvuWBdt1kcqI5hv19/SnXFtTERO3VKW0RCwpbJrNJzFig8vFlNWPX7Lcu9ROqo/8BDj/yVyu87
 NWyNgGVbxfl/5JyJVLD+PqD7fXxNe6XmU9fy0NfcYL/Zve9k96VTugmENsYTqpJxzGVroKnYOBn
 zYVsbFNCJdmGDSR3F/sl4KOG7uDGCoijj6HfnYSkQR3L4+qs8v383Ekh/pCrIgiIqf8Wyre4N9r
 ex5mSs9URSMbIM286Us+hrOfoE2r8cNzUfiFC+SCo0Yg==
X-Forward-Email-ID: 67a80914ae24fcf613ed6696
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c0ac5251-f590-46fc-bb73-c7b81e510f81@kwiboo.se>
Date: Sun, 9 Feb 2025 02:46:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/29] rockchip: Add TPL alternatives
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-20-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-20-sjg@chromium.org>
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
> The TPL image must be built for each board we need to support. It is the
> only part of the image which is board-specific.

Is this building for multiple targets required for A, B or recovery?,
the main topic for this series? If not it should be added later in the
series or possible in a follow-up series.

> 
> This helps to save space and reduce the size of TPL, so that it can fit
> within the internal 192K IRAM.

This should probably mention something about RK3399 here, Rockchip SoCs
have different amount of usable SRAM.

Regards,
Jonas

> 
> As with other phases, the TPL devicetree is run through fdtgrep to
> remove unwanted nodes and properties and reduce its size.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 42 +++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 0611533a310..f6348c532a4 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -254,23 +254,23 @@
>  		pad-byte = <0xff>;
>  		skip-at-start = <0x8000>;
>  
> -		mkimage {
> -			filename = "idbloader.img";
> -			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> -			multiple-data-files;
> +#ifdef CONFIG_VPL
> +		alternates-fdt {
> +			fdt-list-dir = "dts/upstream/src/arm64/rockchip";
> +			filename-pattern = "alt-NAME.bin";
> +			fdt-phase = "tpl";
>  
> -#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> -			rockchip-tpl {
> -			};
> -#elif defined(CONFIG_TPL)
> -			u-boot-tpl {
> -			};
> -#endif
> -			u-boot-spl {
> +			mkimage {
> +				filename = "idbloader.img";
> +				args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +				multiple-data-files;
> +
> +				u-boot-tpl {
> +					symbols-base = <0>;
> +				};
>  			};
>  		};
>  
> -#ifdef CONFIG_VPL
>  		vpl {
>  			type = "fit";
>  			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
> @@ -361,6 +361,22 @@
>  # endif /* VBE method */
>  #else /* !VPL */
>  
> +		mkimage {
> +			filename = "idbloader.img";
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			multiple-data-files;
> +
> +#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> +			rockchip-tpl {
> +			};
> +#elif defined(CONFIG_TPL)
> +			u-boot-tpl {
> +			};
> +#endif
> +			u-boot-spl {
> +			};
> +		};
> +
>  #ifdef HAS_FIT
>  		fit {
>  			offset = <CONFIG_SPL_PAD_TO>;

