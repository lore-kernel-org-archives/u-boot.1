Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ECBE7D26E
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADCE86C37;
	Tue, 26 Sep 2023 11:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695720624;
	bh=uWOti9eLl4f9l1OTxPlkTTNxcn20NXzD+8yn+icQdUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ybrfCKgMKxmKh8ICR5faxiiXakky/N3ycdSPImJaqWdhWpZOyXEidPqc6soqmlN/i
	 oZphFzsIJHnSWnoCPBbO39M/TvdqHJLYOBCIVtsJ3pzD8YsDAarNUqNwQeJKHppdJ6
	 TLPCbIWJ4qUt7MTHcEVAOJJWXtpgFHvAuMRPpTHlu62OFA+jj+Es0MRdmupS1RlU5Y
	 3w2prBwXERUm8+zFyASX+vcA+TnbadTuuOikUsgiFDLZ6JzKGg+QWHUXkS0jyyG6U1
	 lOKp7CkCcucFiQbaF8vNyIqnt6+DsDTM08kMR7aMV1aTGMrEXXz8I51SAOHZ0vW/g+
	 /P1Nwxb0y+kGw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B92B86C37; Tue, 26 Sep 2023 11:30:23 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0B086A08
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Rvvbv4Dz6z9smM;
 Tue, 26 Sep 2023 11:30:19 +0200 (CEST)
Message-ID: <79d9b3ac-2ec9-df94-312d-065fd9792f3e@denx.de>
Date: Tue, 26 Sep 2023 11:30:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] wdt: nuvoton: fix reset/expire function error and add
 dts
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20230926090407.407769-1-JJLIU0@nuvoton.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20230926090407.407769-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Jim,

On 9/26/23 11:04, Jim Liu wrote:
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Please provide a short commit summary, explaining what this patch
does. Starting with a reasoning for this change and a short dscription
of what was changed.

More comments below...

> ---
>   arch/arm/dts/nuvoton-common-npcm8xx.dtsi | 24 ++++++++++++++++++++++++
>   drivers/watchdog/npcm_wdt.c              | 12 ++++++++----
>   2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
> index fabe5925b7..87c77dcb2c 100644
> --- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
> +++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
> @@ -154,6 +154,30 @@
>   				clock-names = "refclk";
>   			};
>   
> +			watchdog0: watchdog@801c {
> +				compatible = "nuvoton,npcm750-wdt";
> +				reg = <0x801c 0x4>;
> +				clocks = <&clk NPCM8XX_CLK_REFCLK>;
> +				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			watchdog1: watchdog@901c {
> +				compatible = "nuvoton,npcm750-wdt";
> +				reg = <0x901c 0x4>;
> +				clocks = <&clk NPCM8XX_CLK_REFCLK>;
> +				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			watchdog2: watchdog@a01c {
> +				compatible = "nuvoton,npcm750-wdt";
> +				reg = <0xa01c 0x4>;
> +				clocks = <&clk NPCM8XX_CLK_REFCLK>;
> +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
>   			serial0: serial@0 {
>   				compatible = "nuvoton,npcm845-uart", "nuvoton,npcm750-uart";
>   				reg = <0x0 0x1000>;
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index e56aa0ebe1..d6792bab35 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -69,17 +69,21 @@ static int npcm_wdt_stop(struct udevice *dev)
>   static int npcm_wdt_reset(struct udevice *dev)
>   {
>   	struct npcm_wdt_priv *priv = dev_get_priv(dev);
> +	u32 val;
>   
> -	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
> +	val = readl(priv->regs);
> +	writel(val | NPCM_WTR, priv->regs);
>   
>   	return 0;
>   }
> -
>   static int npcm_wdt_expire_now(struct udevice *dev, ulong flags)
>   {
> -	return npcm_wdt_reset(dev);
> -}
> +	struct npcm_wdt_priv *priv = dev_get_priv(dev);
>   
> +	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
> +
> +	return 0;
> +}
>   static int npcm_wdt_of_to_plat(struct udevice *dev)

Hmmm. This will result in npcm_wdt_of_to_plat() not having an empty line
before its declaration. Please fix.

Thanks,
Stefan
