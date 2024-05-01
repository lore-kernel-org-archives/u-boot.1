Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC58C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 20:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB8288679;
	Wed,  1 May 2024 22:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="NzCptKTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738D68869A; Wed,  1 May 2024 22:23:15 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82EAB885C8
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 22:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714594992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5Pvzvj6N5xxVD1yZ3tHqOJnt0malRZou/nLIh4NlHs=;
 b=NzCptKTStZWSQRJ0BZcSFvQkgUTBD8uoeEpOvhi1vbKRHpf2wBshByDGK13Xz2LeBU/DLL
 uviQs2XZ4O54AxzqYEoiFLlPp5wLU/fMobQTAIBZ5Z3/BSmS4iZs2mTR/1CsE6yf++gXW/
 mNXu6LvFDPJ974kIGNpIF8y3cupP3Rebh9AnJULqAX7CY4TdcMHNeiYHEueRdk4LQwNOXV
 r29SYjYt6njEE03vYMZcU0m6hAeFCfiA4FmE338rcXlDVXTcvzxEgu2aQ0aATMZZjcp6pB
 /sh2R4VRdQzxa6xFpvDpLMDferUpeTl2L5UawXGMySgY7D95XsOhZRk89vrXMg==
Date: Wed, 01 May 2024 22:23:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Christopher Obbard
 <chris.obbard@collabora.com>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 22/22] rockchip: rk3399: Drop ethernet0 alias from SoC
 u-boot.dtsi
In-Reply-To: <20240501162308.875193-23-jonas@kwiboo.se>
References: <20240501162308.875193-1-jonas@kwiboo.se>
 <20240501162308.875193-23-jonas@kwiboo.se>
Message-ID: <42c2200df9e2d217f4606cafc52273f6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-05-01 18:22, Jonas Karlman wrote:
> Remove the obsolete ethernet0 alias now that all board device tree 
> files
> have been fully synced with Linux kernel v6.8.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Nice, thanks for handling the move of the ethernetX aliases around.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: New patch
> ---
>  arch/arm/dts/rk3399-u-boot.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi 
> b/arch/arm/dts/rk3399-u-boot.dtsi
> index 6af9621ac3d0..b6b43271172e 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -6,7 +6,6 @@
> 
>  / {
>  	aliases {
> -		ethernet0 = &gmac;
>  		mmc0 = &sdhci;
>  		mmc1 = &sdmmc;
>  		pci0 = &pcie0;
