Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1B6C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 22:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CB2808B6;
	Sat, 22 Feb 2025 23:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="RgLPTxoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9064A80EC0; Sat, 22 Feb 2025 23:05:41 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4F880540
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 23:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.26.251])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 79A94B4C0500;
 Sat, 22 Feb 2025 23:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=mail; t=1740261939;
 bh=dWr8PmtGbb3HayWoOJ/iRRF+RoROplYijfhXW0EpyR4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RgLPTxoLqw98TdlGzCZxektESgb5GUy+MpcdHpJrdJrSBiQnUpJ19+f/LFJIQwop1
 L/qoKsuQMTIKy3Xr6CpO627Tu9lJCGF6Pcg2xwLOKAyDgumGl0MRaWqD8KOnJOP6lr
 kqdypFkprNTeuRoVBDC8rmc8oNvahGu949EVUjgM=
Message-ID: <462cec31-bf1d-472e-bc5d-13bdac8f5ccd@freeshell.de>
Date: Sat, 22 Feb 2025 14:05:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] riscv: dts: add OF_LIST handling to binman.dtsi
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, Sumit Garg
 <sumit.garg@linaro.org>, "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
 <20250221095856.36530-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250221095856.36530-2-heinrich.schuchardt@canonical.com>
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
> Binman can automatically generate device-tree and configuration entries in
> the FIT image based on CONFIG_MULTI_DTB_FIT if the binman node includes the
> right sub-nodes.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
> 	Use CONFIG_MULTI_DTB_FIT instead of CONFIG_OF_LIST to avoid
> 	build failure for QEMU defconfigs.
> v2:
> 	no change
> ---
>  arch/riscv/dts/binman.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> index 0405faca574..782ef037f7a 100644
> --- a/arch/riscv/dts/binman.dtsi
> +++ b/arch/riscv/dts/binman.dtsi
> @@ -82,8 +82,9 @@
>  					};
>  				};
>  
> -#ifndef CONFIG_OF_BOARD
> +#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
>  				@fdt-SEQ {
> +					fit,operation = "gen-fdt-nodes";
>  					description = "NAME";
>  					type = "flat_dt";
>  					compression = "none";
> @@ -94,7 +95,7 @@
>  			configurations {
>  				default = "conf-1";
>  
> -#ifndef CONFIG_OF_BOARD
> +#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
>  				@conf-SEQ {
>  #else
>  				conf-1 {
> @@ -115,7 +116,7 @@
>  #endif
>  #endif /* CONFIG_OPTEE */
>  
> -#ifndef CONFIG_OF_BOARD
> +#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
>  					fdt = "fdt-SEQ";
>  #endif
>  				};

Reviewed-by: E Shattow <e@freeshell.de>
