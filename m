Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8E9C5473F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B088889CA;
	Wed, 28 Aug 2024 01:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724800196;
	bh=EAYiEGgtFbybZXWYMPnwWIAxtMCVqBwZnBsHfz1frgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pP2nOMS/dRINk/FaSAqpzmveHJpC8GtkmGq1lYdJbUr9/hZOnauCj5hPb0ScaMzqg
	 gOfBIXj8v/nPac2I+f0nQBzeKdNvqZuY3QOcedt82BXkmj04burlCAbYn0wjsX7/LT
	 AfoEowrYul8HuC5fCXL9900bxqklte0nMmCFzM0AjgHB+T0Vk10uExeSe2wHse1uK/
	 UvcoSX0TifhbdH9GuH1+I+YD0AyaPOF8Omnrd6vMOW/ThM6VJvOBcZ6z8o7SYVmMrd
	 yrvIMxwyvYPbQGB8EGsaYbIVHp5hUkgXCYmO6ipJsPBSGRX4mjBsyqGcmjzaTzbrlM
	 XlheLLHrmvNbw==
Received: from mail.denx.de (unknown
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: festevam@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A1DBD884DB;
 Wed, 28 Aug 2024 01:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724800194;
 bh=EAYiEGgtFbybZXWYMPnwWIAxtMCVqBwZnBsHfz1frgc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=egHpH+rAQuB4d65AQWPvg38MQVPDb8qnYUnVrOBRgHaFDUVSv4xOgrgZDHPrYhDvR
 REmq+OwoGp6RJFiCPetw1OJWATLh4bInRlUZX5mcvSFJCEgTvWbORT5IDZ4I3J+DBw
 PFX8ZQXuY2R8gofidcP6rGcaeSkAjEjWKCKzViLgNnvxVsDOHIWutmkjQR60B55t27
 fs8PP8LbI7ikghZyPGaHQtSj/WhMEIvoyG7nkqcK7V3mJLWbCw/KE1AQ4yL7nQrSla
 8pmRtaCpYpxtSidN0owXoE0MHuDyWTtkPkOJUoatAIxc+/+UoPKez3zVwcTXknPHgV
 Hro2MO2gFZmTQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Aug 2024 20:09:54 -0300
From: Fabio Estevam <festevam@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, marex@denx.de, u-boot@lists.denx.de,
 tharvey@gateworks.com, smoch@web.de
Subject: Re: [PATCH v2 4/4] imx: Remove CFG_MXC_USB_PORTSC
In-Reply-To: <20240827194307.2933299-4-festevam@gmail.com>
References: <20240827194307.2933299-1-festevam@gmail.com>
 <20240827194307.2933299-4-festevam@gmail.com>
Message-ID: <cb05c6bb25a14458a4c1121af1378f2b@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
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

On 27/08/2024 16:43, Fabio Estevam wrote:

> diff --git a/include/configs/mx51evk.h b/include/configs/mx51evk.h
> index 6c8cb78274b..16a2d860619 100644
> --- a/include/configs/mx51evk.h
> +++ b/include/configs/mx51evk.h
> @@ -33,7 +33,6 @@
>  #define CFG_SYS_FSL_ESDHC_ADDR	MMC_SDHC1_BASE_ADDR
> 
>  /* USB Configs */
> -#define CFG_MXC_USB_PORTSC	PORT_PTS_ULPI

This line should stay.

I will send a v4 after waiting for more review comments.
