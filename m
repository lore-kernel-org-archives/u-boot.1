Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA6EC25B74
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 08:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F8588474;
	Thu,  9 May 2024 10:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="KMKwv24U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A460488477; Thu,  9 May 2024 10:54:46 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B966188276
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 10:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 5B0DB240028
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 10:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1715244884; bh=GN5mvffhSQeKBMsVjCq7y+oVMJhFcN5yojfjZgOd1sI=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=KMKwv24Ur4mYMCkco6MY+N3UQooMcfLW6R+h+VqQFAvtJ1Ptq5eeD7KFaQLlQ9g/s
 2NwPg1wfAtG4GCJJyOGkNM3S3KejOKbKr9LGpC3xjexulWpX5i0LwIJ/60J+6zK/nc
 VeSTDC2mC/99+1lL/UkOsFgbr/fbbahFRSpzeDL/W43LEAdJIFpehEtK7LdA8dGVeR
 Vytkkycmqz1gNUkaztq5d34xlWFJaRuHvAED8nyT0JihccvZeGS5VOwdfK0SumvKHL
 p/x6bpYKXzI/wFqTJNE5dmhfqrTtPMpCc9RVcvVehx8bn1eZJoxb6MOCQ7u7jsFTev
 zFd3nNf59YJWw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4VZm6X0SxQz6tmv;
 Thu,  9 May 2024 10:54:44 +0200 (CEST)
Message-ID: <f671f6ba-9fbb-82e4-0414-dae09a5fed72@posteo.net>
Date: Thu,  9 May 2024 08:54:15 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 04/81] arm: nexell: Add missing <linux/types.h>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-4-trini@konsulko.com>
Content-Language: en-US, de-DE
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240502013138.2383421-4-trini@konsulko.com>
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



On 02.05.24 03:30, Tom Rini wrote:
> This file has many "Linux" style types in it, add <linux/types.h>
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Stefan Bosch <stefan_b@posteo.net>

Thanks for your awesome work!

> ---
> Cc: Stefan Bosch <stefan_b@posteo.net>
> ---
>   arch/arm/mach-nexell/include/mach/mipi_display.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-nexell/include/mach/mipi_display.h b/arch/arm/mach-nexell/include/mach/mipi_display.h
> index f3fdec64647c..9183ffdd9c3d 100644
> --- a/arch/arm/mach-nexell/include/mach/mipi_display.h
> +++ b/arch/arm/mach-nexell/include/mach/mipi_display.h
> @@ -11,6 +11,8 @@
>   #ifndef MIPI_DISPLAY_H
>   #define MIPI_DISPLAY_H
>   
> +#include <linux/types.h>
> +
>   /* MIPI DSI Processor-to-Peripheral transaction types */
>   enum {
>   	MIPI_DSI_V_SYNC_START				= 0x01,
