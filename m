Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54042C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 22:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA287808B6;
	Sat, 22 Feb 2025 23:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="aosY1uNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CEDC80F3F; Sat, 22 Feb 2025 23:07:08 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A76180540
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 23:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.26.251])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id D90E6B4C04D3;
 Sat, 22 Feb 2025 23:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=mail; t=1740262026;
 bh=YEuMJwqmyMhz9Hw56KXymkoz8u26R/vY0iRTJSqN3lo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aosY1uNcCspZIEPYJlv7SyR3+9WesvM+MU/LLduHZzfgVoDClV3z4piMuzhAe1PCY
 Y0mrklnwLaOSulcfzJ/qccJEdXwEQNPEotSMivjLG43FjNhMgCJmnsmJRo8Eu/nFIa
 2gvl3JVIwXsLBhqQZErrFX6Vd/iaTCNa3MwNepL0=
Message-ID: <a8ff4bf3-d4ef-478c-ac74-0fbcb984ccb1@freeshell.de>
Date: Sat, 22 Feb 2025 14:07:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] riscv: dts: no default configuration for
 MULTI_DTB_FIT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, Sumit Garg
 <sumit.garg@linaro.org>, "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
 <20250221095856.36530-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250221095856.36530-3-heinrich.schuchardt@canonical.com>
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



On 2/21/25 01:58, Heinrich Schuchardt wrote:
> JH7110 boards are currently the only use case for multi DTB FIT images
> on RISC-V.
> 
> Booting JH7110 systems with a VisionFive 2 device-tree used to kind of
> work without causing harm to the hardware. But there is no guarantee
> that this will hold true in future. So we should not rely on it.
> 
> Before the current patch series booting failed on unsupported boards due
> to the lack of a device-tree in the binman generated default configuration
> when reaching main U-Boot.
> 
> By not setting a default configuration booting will now fail on
> unsupported boards already in SPL. This allows SPL to
> continue with the next boot source for a possible recovery.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
> 	new patch
> ---
>  arch/riscv/dts/binman.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> index 782ef037f7a..ceb916b74a7 100644
> --- a/arch/riscv/dts/binman.dtsi
> +++ b/arch/riscv/dts/binman.dtsi
> @@ -93,7 +93,10 @@
>  			};
>  
>  			configurations {
> +
> +#ifndef CONFIG_MULTI_DTB_FIT
>  				default = "conf-1";
> +#endif
>  
>  #if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
>  				@conf-SEQ {

Reviewed-by: E Shattow <e@freeshell.de>
