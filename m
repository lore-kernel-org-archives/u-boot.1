Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C134CA6016
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 21:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C8F36088B;
	Thu,  8 Oct 2026 21:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iISDLwoW5i1w; Thu,  8 Oct 2026 21:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25DED6084F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493524;
	b=dXNUVe/XVs2ZhTC9kkLTo3tEkyBP6dYDqxrK2hhaQiKjPOqFaYyRZ8kqmxrm/k8hyfWf
	 +Upy++lPXq9LdRlK43W0R9Wwdf7UMB1w9Rln+8C5oDi43uyuWo6utr67jxHmAAmQ2WIDi
	 0Z5Ql1OzNkNOFjBjck/MHhZFxQEH3p3L2PMQ1BuaIhVg5Efx4rNo9wojwVnWIRr8N0Y5H
	 7+wMmX7FbtX9JQySL9dP/rcd1yAynoOj2Gd2xiUGEHxtFqrJy1EHKDjPCgtjB1WPwcQs6
	 1pvRP0ZS8Hk8rotARL+mgFfR85UmLNgT9HVoLdp/B86yKOO1Xx9M2YZvvcAluovf4ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VgH5FsZC/FEmZZKN2Gt0ebhCUHkPKCTXtKAS2AxSKaY=;
	b=Ey8KnbCWL9vHoywyej2Xa2dPegYkCpBNz0HGqnxTXolUYi6C6kZkFtnUm2aXhG2VMkXF
	 lHxYv9Qn1Rz9yN8fR8L/UKRZ5k+iCN9eZ1+S7Eh5Ip2AloOwT5O/BslaS8Oe0tCwlgMG5
	 IY4UvLYIkm34Lq9mzZ7z03wYqW744ri+/tbh36JJ8J39xi7g3EhxIKuhCMEAIilSGxvtO
	 YnaTWL/UmGv3wbl0k+2wLgzEFdSgbW56/m/fjhbAzNXFB8K+Dia5kCXY+ir/pyqHs4cg0
	 0nso2GsRuFkAkp0e/N9qtWlIdX4E7FXPLn/ICupNBwPF4figZRZaeAQWVfTrT/Xlplw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791493524;
	bh=VgH5FsZC/FEmZZKN2Gt0ebhCUHkPKCTXtKAS2AxSKaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y3HiYu3+LQYpnmprtBfUsT3G7wYMP8tgzYu7FGQ07e38gCFZiEMwM4qfHTUoFc8qS
	 M4W3ibUnOvp89HG9DYFZRfwRc0FTgj/eeGExfoHSVdoJOweURhVJS87aM8b3KYIoNO
	 nRZtKGM5Ik5vQCrPq+QrV1OLZfdpAxQbIwEr46Evwyiu9jWXYD1Vd5Vfd3mDdrLxH+
	 AVu6tLX/F/yUpT6vOVT2/LAw1f9uuc1qLigVwaCOs9XIOxHBdZUN8rYzxRVFyDX6nD
	 b7MbZo81SE5us7Ucd4OAu9BalqLsZ5KeMxxG2PP27gPTfXcw6NOUB9OLoWbhpOawQR
	 cZ5pkzT3ksL9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25DED6084F;
	Thu,  8 Oct 2026 21:05:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B2F8C2E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98E2F812FE
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g87IwmTO49aB for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 21:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 46675812FA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::bc0e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493521;
 b=VmOiqseS4aXxRVmlt35qRhoziQodYPuG1WAmlYM9a04WykSq5z/oEFEytPTgLNdrOmgx
 qqU0QJ+h2hxOWqubescipJXTRxvZyRaTAsIAuohDZguZsWs1bJEMEYdZ4cb2cq1npTnOI
 f3rcz/nlUdQTcRMMRSDwJKZQaDFt8g/msxcdTouIL9bfdhptZ3MY6nDV4b52UDGO5VMFB
 7tii1xpM4vNcwPbEoj2lxRGHX/XL59xXpGjiJeevJXzDH8xXx/BAcCIw5TDXgTNbLCtPg
 +nCWes8doJHmkOf/b2G80lG6Hhs2f3cAWBWWu2XWNDOX4AwqHFUgToA0ymC6HES0CZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493521;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Infomaniak-Routing;
 bh=VgH5FsZC/FEmZZKN2Gt0ebhCUHkPKCTXtKAS2AxSKaY=;
 b=q1b0rrULyXPNDns9XfvFhRsM1SSnVAfaldkHjxnojC0r+UYxHXDtHfqCGYuutZgI0BKm
 19M3CdzBYRar8+I+3uVdQe7jU3ghFZmIqJpa0roMs6mPvPU8ACS0IJUcC2+gkiW6Ms0FK
 K2mLRcwnuBSEg8GdGBxR6yHIijx3FWDHOxMp7sIiwt2TRmooT9oHMsiShIizKWD/8T5s3
 h1YJd+ldXknAMhMLi69L225oYUCTh39Pt8gqXFqY0TgymcyOA3UJQo0ZBfYY9iEeesSEP
 m0GKWLVsXR4SV2ROp6oGmmpzk0Jb7IcH6kKgzfAr6Gy1bcpUUz6r+tcaG6inuh+Cliw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=jiwTW4je; 
 arc=none smtp.remote-ip="2001:1600:19:7ff8::bc0e"
X-Greylist: delayed 966 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 08 Oct 2026 21:05:19 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=jiwTW4je
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::bc0e; helo=smtp-bc0e.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::bc0e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46675812FA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:05:19 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j12Cn62KZzSHq;
 Thu,  8 Oct 2026 22:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791492549;
 bh=VgH5FsZC/FEmZZKN2Gt0ebhCUHkPKCTXtKAS2AxSKaY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jiwTW4jeS2XtMn6zW30qofxvUjZdiMSjfoXKS/pLYRmEYzDjmZ2Pn5KVKBbKwcjrS
 r42oxXZMPSy2RbR2WMYdLJ30TTlKtpgITof1oKQ3Njj1IpPegopm1jLwbjbmb6OvU0
 d9I7kfD9DFKi9tfx6pTGTZeCV6PtXYUBcZ0P5mpEEoTG/Xqp3E/3jgpkNSSb0bwODI
 y2foe/RqXGjo4fTV5BSUcnX2L4gGhLU/1bdMeHxM2kcphFjPN59N9Nprii2PG4llD1
 bVYCh7dKcbLq76m2QCMe1LkV4jlL9XbTanVngoz9UBjKIw4KMOJmu3oXh/0PVqXU1F
 DQpEX+L1QsRUQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j12Cm0vXGzgFv; Thu,  8 Oct 2026 22:49:08 +0200 (CEST)
Message-ID: <0bba4247-2950-41c2-996f-d9c29043619c@0leil.net>
Date: Thu, 8 Oct 2026 13:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ram: rockchip: px30: allow multiple DDR types
 selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
 <20260829-ddr-multi-v1-2-c0c7837aed20@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260829-ddr-multi-v1-2-c0c7837aed20@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 8/29/26 7:03 PM, Massimo Pegorer wrote:
> Allow the inclusion of more than one DDR parameters set in the PX30
> SDRAM driver. The driver applies included sets in a predefined order
> (DDR4, LPDDR2, LPDDR3, DDR3), stopping at the first one that makes

What made you decide on this order?

> SDRAM initialization function to complete with success.
> 
> The default fallback behaviour is preserved: if no DDR configuration
> option is selected, DDR3 parameters set is included.

We shouldn't do that, we instead should have the DDR3 symbol default to 
y for PX30 (and other SoCs if applicable), to preserve the current 
state. I don't like hidden defaults like that because you may end up 
with RAM_ROCKCHIP_DDR3 not selected and build a DRAM driver that only 
supports DDR3, which is kinda odd to be honest.

> 
> Due to limited PX30 TPL maximum size, including support for more than
> one DDR type requires disabling some configuration options such as
> CONFIG_RAM_ROCKCHIP_DEBUG.
> 

Good to know, thanks. But i'm assuming this likely means we can only 
have up to two DRAM configurations enabled at the same time?

I think the information printed by sdram_print_dram_type() is still 
interesting. Maybe we should have some log level for the DRAM init so we 
can select the verbosity of the debug output. In any case, just a 
thought and not a blocker for this series at all.

> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   drivers/ram/rockchip/Kconfig      | 67 +++++++++++++++++++++++++++++++--------

No to those changes. Keep it simple please, no redefinition of the 
symbol based on the SoC. For the RAM_ROCKCHIP_DEBUG needing to be 
disabled, the information is quite nice for end users so i could see it 
being added to all RAM_ROCKCHIP_ symbols as a hint (or have it somewhere 
in doc/board/rockchip for example).

>   drivers/ram/rockchip/sdram_px30.c | 35 ++++++++++++--------
>   2 files changed, 74 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index 61a3193b3f5..d74980402ad 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -24,38 +24,77 @@ config RAM_ROCKCHIP_DEBUG
>   	  This is an option for developers to understand the ram drivers
>   	  initialization, configurations and etc.
>   
> +config RAM_ROCKCHIP_DDR3
> +	bool "DDR3 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30
> +	help
> +	  Enable DDR3 sdram support on Rockchip SoCs.
> +
> +	  Note that enabling support for multiple DDR/LPDDR types may cause TPL
> +	  to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
> +	  other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
> +
> +	  The driver applies selected sdram parameters sets in the following
> +	  order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
> +	  sdram_init_detect() to complete successfully.
> +
> +	  If no DDR/LPDDR option is selected, DDR3 sdram support is enabled by
> +	  default for backward compatibility with existing board configurations.
> +	  Therefore this option is only useful for multiple DDR/LPDDR types
> +	  selection.
> +
>   config RAM_ROCKCHIP_DDR4
>   	bool "DDR4 support for Rockchip SoCs"
> -	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> +	depends on ROCKCHIP_PX30
>   	help
> -	  This enables DDR4 sdram support instead of the default DDR3 support
> -	  on Rockchip SoCs.
> +	  Enable DDR4 sdram support on Rockchip SoCs.
>   
> -	  Note that even if multiple DDR/LPDDR types are selected, support is
> -	  enabled only for the selected one that comes first in the following
> -	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> +	  Note that enabling support for multiple DDR/LPDDR types may cause TPL
> +	  to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
> +	  other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
> +
> +	  The driver applies selected sdram parameters sets in the following
> +	  order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
> +	  sdram_init_detect() to complete successfully.
>   
>   config RAM_ROCKCHIP_LPDDR2
>   	bool "LPDDR2 support for Rockchip SoCs"
>   	depends on ROCKCHIP_PX30
>   	help
> -	  This enables LPDDR2 sdram support instead of the default DDR3 support
> -	  on Rockchip SoCs.
> +	  Enable LPDDR2 sdram support on Rockchip SoCs.
>   
> -	  Note that even if multiple DDR/LPDDR types are selected, support is
> -	  enabled only for the selected one that comes first in the following
> -	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> +	  Note that enabling support for multiple DDR/LPDDR types may cause TPL
> +	  to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
> +	  other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
> +
> +	  The driver applies selected sdram parameters sets in the following
> +	  order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
> +	  sdram_init_detect() to complete successfully.
>   
>   config RAM_ROCKCHIP_LPDDR3
>   	bool "LPDDR3 support for Rockchip SoCs"
>   	depends on ROCKCHIP_PX30
>   	help
> -	  This enables LPDDR3 sdram support instead of the default DDR3 support
> +	  Enable LPDDR3 sdram support on Rockchip SoCs.
> +
> +	  Note that enabling support for multiple DDR/LPDDR types may cause TPL
> +	  to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
> +	  other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
> +
> +	  The driver applies selected sdram parameters sets in the following
> +	  order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
> +	  sdram_init_detect() to complete successfully.
> +
> +config RAM_ROCKCHIP_DDR4
> +	bool "DDR4 support for Rockchip SoCs"
> +	depends on ROCKCHIP_RV1126
> +	help
> +	  This enables DDR4 sdram support instead of the default DDR3 support
>   	  on Rockchip SoCs.
>   
>   	  Note that even if multiple DDR/LPDDR types are selected, support is
>   	  enabled only for the selected one that comes first in the following
> -	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> +	  list: LPDDR4, DDR4, DDR3.
>   
>   config RAM_ROCKCHIP_LPDDR4
>   	depends on ROCKCHIP_RV1126
> @@ -66,7 +105,7 @@ config RAM_ROCKCHIP_LPDDR4
>   
>   	  Note that even if multiple DDR/LPDDR types are selected, support is
>   	  enabled only for the selected one that comes first in the following
> -	  list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> +	  list: LPDDR4, DDR4, DDR3.
>   
>   config RAM_ROCKCHIP_LPDDR4
>   	bool "LPDDR4 support for Rockchip SoCs"
> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> index 37e62120504..ac9f5827d1d 100644
> --- a/drivers/ram/rockchip/sdram_px30.c
> +++ b/drivers/ram/rockchip/sdram_px30.c
> @@ -126,11 +126,17 @@ struct dram_info dram_info;
>   struct px30_sdram_params sdram_configs[] = {
>   #if defined(CONFIG_RAM_ROCKCHIP_DDR4)
>   #include	"sdram-px30-ddr4-detect-333.inc"
> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
> +#endif
> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
>   #include	"sdram-px30-lpddr2-detect-333.inc"
> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
> +#endif
> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
>   #include	"sdram-px30-lpddr3-detect-333.inc"
> -#else
> +#endif
> +#if defined(CONFIG_RAM_ROCKCHIP_DDR3) ||         \
> +	(!defined(CONFIG_RAM_ROCKCHIP_DDR4) &&   \
> +	 !defined(CONFIG_RAM_ROCKCHIP_LPDDR2) && \
> +	 !defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
>   #include	"sdram-px30-ddr3-detect-333.inc"
>   #endif
>   };
> @@ -682,19 +688,11 @@ out:
>   	return ret;
>   }
>   
> -struct px30_sdram_params
> -		*get_default_sdram_config(void)
> -{
> -	sdram_configs[0].skew = &skew;
> -
> -	return &sdram_configs[0];
> -}
> -
>   /* return: 0 = success, other = fail */
>   int sdram_init(void)
>   {
>   	struct px30_sdram_params *sdram_params;
> -	int ret = 0;
> +	int ret, i = 0;
>   
>   	dram_info.phy = (void *)DDR_PHY_BASE_ADDR;
>   	dram_info.pctl = (void *)DDRC_BASE_ADDR;
> @@ -704,12 +702,21 @@ int sdram_init(void)
>   	dram_info.ddr_grf = (void *)DDR_GRF_BASE_ADDR;
>   	dram_info.pmugrf = (void *)PMUGRF_BASE_ADDR;
>   
> -	sdram_params = get_default_sdram_config();
> -	ret = sdram_init_detect(&dram_info, sdram_params);
> +	do {
> +		sdram_configs[i].skew = &skew;
> +		sdram_params = &sdram_configs[i];
> +		ret = sdram_init_detect(&dram_info, sdram_params);
> +	} while (ret && ++i < ARRAY_SIZE(sdram_configs));

A simple for-loop on the ARRAY_SIZE() would be easier to read. Once you 
have a match (ret = 0), break out of the loop and check ret before 
continuing in the code.

>   
>   	if (ret)
>   		goto error;
>   
> +	if (ARRAY_SIZE(sdram_configs) > 1) {
> +		printascii("Applied sdram config: ");
> +		printdec(i);
> +		printascii("\n");

This is not useful to the user as it's reflecting the index in an array 
that is not stable by design. We should instead report the DDR type (if 
we really want to). You can do this by simply calling 
sdram_print_dram_type(sdram_params->base.dramtype); Of course, this 
won't do anything right now since we need to disable RAM_ROCKCHIP_DEBUG 
to be able to compile support for more than one DRAM type.

I will only be able to test your series in November once I'm back in 
office, but I for sure will. In the meantime, you can always send a v2 
and/or discuss the feedback :)

Cheers,
Quentin
