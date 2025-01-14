Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EC0C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC40806B7;
	Tue, 14 Jan 2025 18:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736876510;
	bh=Gm8imiLKYxS89ddqh2LOxpsLKvJpEH5VWMKmCXP8gi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VcH3Xnm0GLEdNHc1SKfWEc0jt3qD0olmFzsfEJmU+JgykWjRJEVYxhHfR+z6BUGzf
	 aZm15zssF7D7Twh17P3ksxQumKJnT0+h0RNz5kWwrwG5AAtkbR2H3QnnkAtQxTLcRF
	 dOmD/APKSV0dzLGK+Ai/IwMLOq2mahRts0mIW6PgNsNjJbHEhcYX/RleKKOdUYQTl3
	 EH59Dj/ffYbK86jiDkjZo8T+2DftLOZyG8MTj5aln/iR3dLnSg9QXqS2Ozv09rfF4g
	 dCaEPfBNTIPWaedf5AY1cjra9bxKSSgvEM3ITB6454asHwQIG5PX6QEbpxrgna8B3Z
	 c1jhCvtUlDYOg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F856806D4; Tue, 14 Jan 2025 18:41:49 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE668022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 18:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZWqNTPvA"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7DE3D104802BE; Tue, 14 Jan 2025 18:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736876506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gm8imiLKYxS89ddqh2LOxpsLKvJpEH5VWMKmCXP8gi4=;
 b=ZWqNTPvAI/ZlGfLpZJUGl9q2i8+6IFW8/M9vrTdPEDW839aikElqsQXU85fLLJ0ICMZTWw
 y3DMU+T54YGuDGrxEXgnRux+a2VQqi1eFVbTfjqq0I2jaRknOWG9SwrDkxnQTMQCtsv2sP
 SclT//nSe/dCNfq7l0YIPwECdMPoFge3jsgu/Y71UhGlZfnOook61v9ZM+w7RTXT4QMQyx
 Am9HnlKaYtArB5gOsSBjA599yuJm/xyWdr/1oMV09TyKIzMMbN2MNhGx8rFNEH/YIOTzP9
 i0RbSB2fExJw0tkTdG8IXv1KDOgcEugGQ20qahiVpv06B5Ent5elZUzsvo6M5A==
Message-ID: <912f42f2-9358-4295-8382-8a5aa82c7804@denx.de>
Date: Tue, 14 Jan 2025 15:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] usb: dwc3-generic: Reorder include
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
 <20250114144528.1612168-4-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250114144528.1612168-4-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/14/25 3:45 PM, Patrice Chotard wrote:
> Reorder include following rules available here :
> https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
> 
>   drivers/usb/dwc3/dwc3-generic.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2ab41cbae45..cb96e1f344f 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -7,29 +7,28 @@
>    * Based on dwc3-omap.c.
>    */
>   
> +#include <clk.h>
>   #include <cpu_func.h>
> -#include <log.h>
>   #include <dm.h>
> -#include <dm/device-internal.h>
> -#include <dm/lists.h>
>   #include <dwc3-uboot.h>
>   #include <generic-phy.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <reset.h>
> +#include <usb.h>
> +#include <asm/gpio.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/printk.h>
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
> -#include <malloc.h>
>   #include <power/regulator.h>
> -#include <usb.h>
> -#include "core.h"
> -#include "gadget.h"
> -#include <reset.h>
> -#include <clk.h>
>   #include <usb/xhci.h>
> -#include <asm/gpio.h>
Can you remove some of them too ?
