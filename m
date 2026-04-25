Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8726FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7956844F7;
	Sat, 25 Apr 2026 20:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EFqt84x+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47EE284441; Sat, 25 Apr 2026 19:14:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31BC484413
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ehristev@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B957944085;
 Sat, 25 Apr 2026 13:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984DDC2BCB0;
 Sat, 25 Apr 2026 13:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777124105;
 bh=sfMk77PF9+i6dXXnOFoJ3UJQaJbUxD1uTczVWCiKkkQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EFqt84x+5kCBFtKgDEVkUfZ1WzzmZTJ1ucpy5hWsXl7p5zo5uYf69x77LXoAO3MJo
 EHKqzjx/J/AOuaGUGi+O+VY4n9FG7IzGKilzPkuQ56mMfdx3VSoSgY+5iuhu+jmfm1
 cAunUl212Ns/rjOtbWOUNt5tZhPhliuTm1+mCPSVcrxCKrGm1uaILTHHp1W+vsdgwQ
 4YH2+fYAOKxjM+N//IbOJ1yI/iyBQajCpayCGFfKqzGIQ2B0J1va52XQ8kiRDlHcJM
 DhM27YSj/j7SpbZE8DIX1J0MCaT/r7ZksuPJ6CScbCu7+Lr/mB1ph8mq2OAqWUnFjC
 +AYZZC8dVnhhg==
Message-ID: <3d5c0942-93a4-4a0d-a272-932ff86d2da2@kernel.org>
Date: Sat, 25 Apr 2026 16:35:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] serial: atmel-usart: allow selecting from
 ARCH_MICROCHIPSW
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr
References: <20260326112830.313874-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

On 3/26/26 13:26, Robert Marko wrote:
> USART driver is reused by a lot of Microchip platforms, in this case we
> need it for LAN969x so allow selecting it when ARCH_MICROCHIPSW is used.

Hello Robert,

I apologize for not replying to this sooner, but my old email address
was bouncing.

I did not find any information(or cover letter), about this series,
because it looks like you are sending this on top of something else,
which is not merged yet.
I am not familiar with ARCH_MICROCHIPSW which is not in Uboot.
Can you please clarify ?

Sorry again,
Eugen

> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index b84cb9ec781..3848c3ca20e 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -665,7 +665,7 @@ config ARM_DCC
>  
>  config ATMEL_USART
>  	bool "Atmel USART support"
> -	depends on ARCH_AT91
> +	depends on ARCH_AT91 || ARCH_MICROCHIPSW
>  	help
>  	  Select this to enable USART support for Atmel SoCs. It can be
>  	  configured in the device tree, and input clock frequency can

