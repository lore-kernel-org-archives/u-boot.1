Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F5EC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 15:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A22B3800D6;
	Tue, 28 Jan 2025 16:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D16E81DFA; Tue, 28 Jan 2025 16:55:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3E9E7800B3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 16:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7F60153B;
 Tue, 28 Jan 2025 07:56:13 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 818AA3F77D;
 Tue, 28 Jan 2025 07:55:45 -0800 (PST)
Date: Tue, 28 Jan 2025 15:55:42 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: 1425075683@qq.com
Cc: Chris Morgan <macromorgan@hotmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>, Sumit
 Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm: The CHIP DIP SCAN option should not be displayed
 in other mach
Message-ID: <20250128155542.426d3d8a@donnerap.manchester.arm.com>
In-Reply-To: <tencent_1A2035CCAD490A9F919EF0412BB6E3E02407@qq.com>
References: <tencent_1A2035CCAD490A9F919EF0412BB6E3E02407@qq.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 28 Jan 2025 21:37:37 +0800
1425075683@qq.com wrote:

Hi,

> From: Liya Huang <1425075683@qq.com>
> 
> When I use mach STM32,
> menuconfig sees this option; It bothers me.
> I observed that the root cause was that the
> option was not included in the endif,
> but when I tried to fix it, an error occurred.

Can you say what the error is, exactly?
Because you are right, it should be before the endif.
I moved that, and compiled it for all Allwinner boards, which worked.
So what is the problem there, exactly?

Cheers,
Andre

> I didn't find a solution. Only deponds can be used for hiding.
> 
> Signed-off-by: Liya Huang <1425075683@qq.com>
> ---
> 
>  arch/arm/mach-sunxi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index ba1b1541437..48dd1e68363 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1137,6 +1137,7 @@ endif
>  
>  config CHIP_DIP_SCAN
>  	bool "Enable DIPs detection for CHIP board"
> +	depends on ARCH_SUNXI
>  	select SUPPORT_EXTENSION_SCAN
>  	select W1
>  	select W1_GPIO

