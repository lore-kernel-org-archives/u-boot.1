Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F138C54ED0
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 18:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F8A82B37;
	Sun, 25 May 2025 20:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="U0tWpgR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA2B82B48; Sun, 25 May 2025 20:43:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D25A82B34
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 20:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=671e=YK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1748198615;
 bh=hKGk05zBAOwOeqg6LyIoZW143+RjYpXnToUbnUUw5e8=;
 b=U0tWpgR9y6LJ/SxW/fDDl1QKjz6b2v4FXwMp7MWBRQh+FzoxkbstuhiQJWERmFRJpY5qVrvim
 0vZwx+nkI6n6Z1vjsZyTWiY8RC5yai4d/C7Xk9eIuZ4UsWAD+qi6wld7vHuJrKV72+jGS2NvcC2
 3TmFYNKz4lsgzhkfSIxK2FrzFysql0XQeVXbY7sOue9/MJ7yaNu9hT8Q5BsRo2kHtQ1IdHEy3zn
 IW6Zl7f57eoRvD6pq63QBSOkTPlQCxQ76ZjpsQCrEmmHDXcC8BuQY1H5wU3loWi22tRpMeSFRX3
 AfWfWMRX+eF0dE9jHzzfN48F2EYtPSTk1N1vSgIBlN5g==
X-Forward-Email-ID: 683364d2a0e3f2dd0ce22949
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b1ae479c-e5c6-49c3-b94b-3315df9076f2@kwiboo.se>
Date: Sun, 25 May 2025 20:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/25] rockchip: dts: Add an fdtmap
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250525104801.1440260-1-sjg@chromium.org>
 <20250525104801.1440260-6-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250525104801.1440260-6-sjg@chromium.org>
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

On 2025-05-25 12:47, Simon Glass wrote:
> Add an fdtmap so it is possible to look at the image with 'binman ls'.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add blank lines before the node
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index cc2feed6464..8a37a9d8e7f 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -192,6 +192,10 @@
>  #endif
>  			offset = <CONFIG_SPL_PAD_TO>;
>  		};
> +#endif

This should not be added here as it breaks the build. It is reverted in
a later patch in this series so your CI has not noticed the build error.

Regards,
Jonas

> +
> +		fdtmap {
> +		};
>  	};
>  
>  #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> @@ -224,6 +228,9 @@
>  			/* Sync with u-boot,spl-payload-offset if present */
>  			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>  		};
> +
> +		fdtmap {
> +		};
>  	};
>  #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
>  };

