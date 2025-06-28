Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C4BC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 21:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E65F482B34;
	Sat, 28 Jun 2025 23:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.b="alCvk0dh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B02882DA1; Sat, 28 Jun 2025 23:48:23 +0200 (CEST)
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA66482977
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 23:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=giulio.benetti@benettiengineering.com
Received: from [192.168.50.220] ([84.33.84.190]) by Aruba SMTP with ESMTPSA
 id VdPGuP1bKqg4pVdPGueXTk; Sat, 28 Jun 2025 23:48:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
 t=1751147298; bh=uwHcclgpY1UuyX29WCh2xVmHrjc0FGqaMbSsQ7UaYSY=;
 h=Date:MIME-Version:Subject:To:From:Content-Type;
 b=alCvk0dh+Y6Hba3cID/FdpHgvwWZhH+TmNZZwBFuKWLS5bYOuFG3RSNRH1k4wr3gi
 NO9JaSVZ2vxukWXGn4kI4a8K6HdcCvZvogZH5HoM7IIHjaWtPR/M5SPBK3VJXSoye2
 bqV1Y30XY0yTF1y01wa6siK1wg25l+o2c+cj/MHSe1iAWHwl4WNZ3n6sT6U1szELcN
 wFvgUOpsJvQ8CBW68IBa455eN8/XDMkXEjRuGSp6wRt+wWYVuEmxyZ0kqISTWL9ycR
 gweTMacNZF++arAMtpFvFOXdV629QKZzSjEQCPh1F8+k+UPabsWdh+L7Rz45yxRmBy
 EwInYc9canekw==
Message-ID: <7fe3036a-602f-4ab5-8a8a-ffabd0a3ae0e@benettiengineering.com>
Date: Sat, 28 Jun 2025 23:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/arm/include/asm/arch-imxrt/gpio.h: imxrt gpio use
 commong gpio.h
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250628214656.2395915-1-giulio.benetti@benettiengineering.com>
Content-Language: en-US
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20250628214656.2395915-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDCZeHbW5hhbG9HGHNnUTZY1Ng9v2aS91Qn7opOiQDhD7lGl6sf45ADxT87NMnEB5xpFs1aG4eULmsDPjGRE+HoRRi88LmdWAcJRY+MuOaqa1NueEbpK
 qnKNCg6hjmcP37WlAuQme9gXPuCF4wjZNIxyZq4ffDLk9sRKeNTMCpYtZ0kZCFvG74sfWLEgIyiZHk3e2NwRuH55cYLfsonCm4Lz5Le/U3TXGEjFIFu8+g8h
 sR4AM0S9t4IslZZ3haQvvvoKly+XVC8jT7IY6pfiEWlQYkgqMnpwEv0OsgGLhg1+MmO4JXe/iyj/o3DhqKpndCErEWj2W21VcvBC9vhG+Js=
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

s/commong/common

can please the committer fix the subject when/if applying?

Thanks in advance
Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
https://www.linkedin.com/company/benetti-engineering-sas/
https://www.linkedin.com/in/giulio-benetti-79975951/

On 6/28/25 23:46, Giulio Benetti wrote:
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>   arch/arm/include/asm/arch-imxrt/gpio.h | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-imxrt/gpio.h b/arch/arm/include/asm/arch-imxrt/gpio.h
> index da31a7438aa..be130e00652 100644
> --- a/arch/arm/include/asm/arch-imxrt/gpio.h
> +++ b/arch/arm/include/asm/arch-imxrt/gpio.h
> @@ -7,13 +7,6 @@
>   #ifndef __ASM_ARCH_GPIO_H__
>   #define __ASM_ARCH_GPIO_H__
>   
> -#if !(defined(__KERNEL_STRICT_NAMES) || defined(__ASSEMBLY__))
> -/* GPIO registers */
> -struct gpio_regs {
> -	u32 gpio_dr;	/* data */
> -	u32 gpio_dir;	/* direction */
> -	u32 gpio_psr;	/* pad satus */
> -};
> -#endif
> +#include <asm/mach-imx/gpio.h>
>   
>   #endif /* __ASM_ARCH_GPIO_H__ */


