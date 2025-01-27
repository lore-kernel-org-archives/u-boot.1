Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946B1C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 21:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C8E81877;
	Mon, 27 Jan 2025 22:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738015119;
	bh=UxMLCc5RLQv2UBnTtGOlP0o23bL143mDObva94Y0Nbs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HGzo37OrVtW1nRMXPaIjfUoV46UkedRvi8+9GkbFnWNcPqLk1TzeV65cwpoGPr03C
	 yQBkKpbuGKFEBWPp1hdzMs3nOTpd9QTGv6MuYcHyiY3z59l6AAkSV4y/zFgVBcOb93
	 Glh7kDavhND/DQja9t2hGdgjAwI64dgn/n0tOIhcdhITkZ2bEbbY4kszya+gdaRbUm
	 JV8Y8hGkAwiagpZzuMtwHvS/nfowdzUpHNwDXoF8CK4M6ugg62tf+1zw/URy5qDBUp
	 SNzLFhQ+l0iJAqeP5cx2CZfhg8WybIn7LFRqK55ceDtK0C42cvIxmw/VTP7Orbl1C/
	 yNBsPH39ycYjA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EA8812BB; Mon, 27 Jan 2025 22:58:38 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E40812BB
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 22:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="N3JqmH2y"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E01C103802C1; Mon, 27 Jan 2025 22:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738015115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxMLCc5RLQv2UBnTtGOlP0o23bL143mDObva94Y0Nbs=;
 b=N3JqmH2yKgdtCIi5077T2a4RcYKVmAKm1BcFyRAyt+xKLgWL95LmiQ3MwXpcWpPXsMyGIL
 ZfaccNm6STwXoB+ivrp1hkvY2EnEn55e1msVxl54QS/acxJR5vdJarHd9g1A7rs9oeXtNT
 nsCezlLcbhuQl7iARpLj9dUMytWwrBju5eyQw/KQmby6y37yED9f9KtQSwq/uW94BGS0mo
 oIH+epduheLdJveeS23TYzlmNOP4jCIafTXoEAnexI5RD+xODIg46/a+VufDpL+aDYsitX
 D8KpXL+G19OKTvlfkuX9cethhKmZDKz7nGUqhG64Ms+5nTXmeBsYpsKYY6/6qA==
Message-ID: <c0f1fb8b-6948-4a9a-814a-2b864fe56f7b@denx.de>
Date: Mon, 27 Jan 2025 22:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] usb: cdns: starfive: Add cdns USB driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
 <20250123010112.78924-6-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250123010112.78924-6-minda.chen@starfivetech.com>
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

On 1/23/25 2:01 AM, Minda Chen wrote:
> Add Starfive cdns USB3 wrapper driver.

Please replace 'cdns' with Cadence .

[...]

> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/usb/otg.h>
> +#include <reset.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <malloc.h>

Please keep the list sorted.

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
