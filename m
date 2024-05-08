Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D63AC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 17:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DDDA87FC1;
	Wed,  8 May 2024 19:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="PckQNVSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E9187FCC; Wed,  8 May 2024 19:38:08 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100CE87ED0
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 19:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id A0C1C240027
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 19:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1715189885; bh=cV74pzm9zVo4mEbXCdiETx7qJDLlPMnVuLenMvb+AsM=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=PckQNVSbuyh2TTcLK18OWiGBFPo7EDxR6pDTz/iSKxcVsVxNYq1zIRTFq6WwZD2Tn
 t4+ymUItWGoC6EXXYi8T2cnuxReFvValq3gn1HywSrCL/aKRM58N1YfqHWlGHD28JJ
 viuItIfCNvQFPbiBLh+cEs13jz42M5oWmYk12dzplFPWqCh0FwHKNI0yFY+Ry7gh8s
 ++J5QI5XgZnowE6n9UY5Geue7CDDgUAaJ6MvgcEF5lPLfiQWB/P0pJLHnfmlXqRlm8
 muJrTL/Yeg+PxRDJBDm6qoB4EAUxtM5BUeYvJ7pDoD+uZPwTQF1yf2C+1TDjot0mJK
 gNMF+WCg2RTPg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4VZMms14jVz9rxL;
 Wed,  8 May 2024 19:38:05 +0200 (CEST)
Message-ID: <3356c564-c60b-3da3-09ea-b1613277bb84@posteo.net>
Date: Wed,  8 May 2024 17:37:37 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 17/33] arm: nexell: Remove <common.h> and add needed
 includes
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240430133559.1836389-1-trini@konsulko.com>
 <20240430133559.1836389-17-trini@konsulko.com>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240430133559.1836389-17-trini@konsulko.com>
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



On 30.04.24 15:35, Tom Rini wrote:
> Remove <common.h> from all mach-nexell files and when needed add missing
> include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Stefan Bosch <stefan_b@posteo.net>
Tested-by: Stefan Bosch <stefan_b@posteo.net>

Looks good, tested on FriendlyElec-Board NanoPC-T2.

Thanks a lot!
> ---
> Cc: Stefan Bosch <stefan_b@posteo.net>
> ---
>   arch/arm/mach-nexell/clock.c              | 2 +-
>   arch/arm/mach-nexell/include/mach/reset.h | 2 ++
>   arch/arm/mach-nexell/reset.c              | 1 -
>   arch/arm/mach-nexell/tieoff.c             | 1 -
>   arch/arm/mach-nexell/timer.c              | 1 -
>   5 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-nexell/clock.c b/arch/arm/mach-nexell/clock.c
> index 59ffa26255f5..3082f6077b73 100644
> --- a/arch/arm/mach-nexell/clock.c
> +++ b/arch/arm/mach-nexell/clock.c
> @@ -4,8 +4,8 @@
>    * Hyunseok, Jung <hsjung@nexell.co.kr>
>    */
>   
> -#include <common.h>
>   #include <command.h>
> +#include <vsprintf.h>
>   #include <linux/err.h>
>   #include <asm/io.h>
>   #include <asm/arch/nexell.h>
> diff --git a/arch/arm/mach-nexell/include/mach/reset.h b/arch/arm/mach-nexell/include/mach/reset.h
> index e1301d4e53d3..0c6a13043f91 100644
> --- a/arch/arm/mach-nexell/include/mach/reset.h
> +++ b/arch/arm/mach-nexell/include/mach/reset.h
> @@ -7,6 +7,8 @@
>   #ifndef __NEXELL_RESET__
>   #define __NEXELL_RESET__
>   
> +#include <linux/types.h>
> +
>   #define NUMBER_OF_RESET_MODULE_PIN      69
>   
>   enum rstcon {
> diff --git a/arch/arm/mach-nexell/reset.c b/arch/arm/mach-nexell/reset.c
> index 1f732a3d3732..627f568270b6 100644
> --- a/arch/arm/mach-nexell/reset.c
> +++ b/arch/arm/mach-nexell/reset.c
> @@ -8,7 +8,6 @@
>    *FIXME : Not support device tree & reset control driver.
>    *        will remove after support device tree & reset control driver.
>    */
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/arch/nexell.h>
>   #include <asm/arch/reset.h>
> diff --git a/arch/arm/mach-nexell/tieoff.c b/arch/arm/mach-nexell/tieoff.c
> index 5a4744c296a2..51cca6744d6f 100644
> --- a/arch/arm/mach-nexell/tieoff.c
> +++ b/arch/arm/mach-nexell/tieoff.c
> @@ -4,7 +4,6 @@
>    * Youngbok, Park <park@nexell.co.kr>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/nexell.h>
>   #include <asm/arch/clk.h>
>   #include <asm/arch/reset.h>
> diff --git a/arch/arm/mach-nexell/timer.c b/arch/arm/mach-nexell/timer.c
> index 3b311fd22a56..b35c7b1bb33a 100644
> --- a/arch/arm/mach-nexell/timer.c
> +++ b/arch/arm/mach-nexell/timer.c
> @@ -4,7 +4,6 @@
>    * Hyunseok, Jung <hsjung@nexell.co.kr>
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   
>   #include <asm/io.h>
