Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2413AC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 11:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E648843B6;
	Wed,  8 Jul 2026 13:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Pfc8MF2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89E1584979; Wed,  8 Jul 2026 13:22:43 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C5084118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 13:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493bab44440so3356595e9.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783509761; x=1784114561; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cdWE60ZpwHu7jMQOnXHkC7WQJPOUa09aEIow3hlgHyY=;
 b=Pfc8MF2GMlGHA2p4/GkNMZ37MWd6z6ax4+uUy6mWcfhlvxP/ZcJpDKO9OwzaOTWN4j
 isDIcD0fFYzPfFEQQV95fafYrC+pR7ZLJW+xmHrR63SOZTxNJXumuf2WBrvqJtL2mWF2
 MFpg9izDxOB8YxSt/AeH4uLeHLTDUV99YIzxclgzcOhxpBy/d9j8lvVqZQJ8QtD3Uc5I
 BJaSTkbeK5TCo8a3a09jX/jYpDyOhUMcaZLeUiB7QFi8o+Lxv+LxOcHoE1LoYQF32+hW
 0UvEG+k9MYdliESoL8UpHTFO/nN0v6OaySb1nKMG+f8wwdBTbtxE164wjYG9QCAg57M2
 KgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783509761; x=1784114561;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cdWE60ZpwHu7jMQOnXHkC7WQJPOUa09aEIow3hlgHyY=;
 b=RVS9d396vTY40A9GWYHULkqdpFfGBris+a1o2JxfKH/fP220NBTTG1IBBncpA9EvW8
 MVUOclGo3ykFxV+05w8qlN5X/M7L7qsdFsEg09OLnaa9koaND+JF0BWERCFgGHnR2sEi
 rrh7oLvd1SDxxxwicUPKHC2Ja998Q8XB3NTw1uynM4dmW8HjGWrk/KxPMVee9N5X0JNs
 RJ3PyZWaZw69gyKOBM4dZdIWs+aFfsD09/6V+GvvHxh7jrCMKL8UptN82l5ibThri02h
 29yZZdL1vhhCWshcMFtYjqZTH3zmKkAZZzAItibUyzyT61ggQxAqcTRNS8qrkvSi/p+o
 H1bg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQl7ccAVj0T7L3T3FjUWuPif///HCpIBpOT6hByFFpWi++Vk1jCRVzkJPb+KE6Bv5ImXuwgnk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8mhiWGNzrCH/2FrjJY1TieJDDJNiJSpREVdY7jX1GAQJiqRZ2
 9Yy0xZV9WBJIv72K2IhiA90BK9HYh3kjFylJ1dFUhqEIAD7Y5fo+hiWNoljDbM+vFsE=
X-Gm-Gg: AfdE7cniMcL5PKphwnxke3gSZcOtlDrID/h/VuRHCRdVOacGtabY8EMGuOP8PcZud9k
 2Lo7/pChkRUP5NzW3WNkLUeHQDSaq0vAyYHXKoXtlzAy354s9KV9PN6aNrqMD2aqKDacbJnOp0P
 rLhkHrXYsolBtq2e6I+gYFG8rUQyj07e+zq2dJk9trJYmx3h3yojcFdu0ClUJXdskdfTsDaSZB0
 rMckB4LgkQHE10BbpnDyL4yGNwyUoc9cRMOk8c+6m9FOj71XMzdgVZUOTsy+R/wsMy0ybIFDhGm
 6w3aTvHzzSS/spd1noFAdDJ/0DjfRAWSB9xnjSrxhKd7bheIsm4Z31TMQFgXkfKUmU7dEYDHHOf
 vl/YlSVtD2oAq7uf6UeDk5gwrnKnBK2xWt72wPWRiSimAIFvKv2qxnzTQLuaWU4CG7Ut7jXe/we
 BRdGvy/JpxL/InGjUzZciUDk6+Y7A8ZWcZYjz18hjU/TiFXBiUIuhSjFK43xzk
X-Received: by 2002:a05:600c:4e93:b0:492:714d:8c4 with SMTP id
 5b1f17b1804b1-493e6393522mr20565565e9.11.1783509760946; 
 Wed, 08 Jul 2026 04:22:40 -0700 (PDT)
Received: from [192.168.0.25] (static-163-111-87-188.ipcom.comunitel.net.
 [188.87.111.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f40d50sm153309115e9.5.2026.07.08.04.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 04:22:40 -0700 (PDT)
Message-ID: <edaab48a-0584-4b1f-8724-f60e360bb653@suse.com>
Date: Wed, 8 Jul 2026 13:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] core: Skip parent device nodes without a DT
 reference when looking for dma-ranges
To: Torsten Duwe <duwe@lst.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Prashant Kamble <prashant.kamble223@gmail.com>,
 Denis Mukhin <dmukhin@ford.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 u-boot@lists.denx.de
References: <20260706172028.C148E68BEB@verein.lst.de>
 <20260706172147.C934268B05@verein.lst.de>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260706172147.C934268B05@verein.lst.de>
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



On 06/07/2026 19:21, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> If a device node got created dynamically, there is no guarantee that the
> parent node has an associated device tree node which could specify dma
> constraints. Especially PCI(e) enumeration adds intermediate "bus nodes",
> also dynamically.
> 
> Try harder to find the correct configuration by walking up the tree until
> a DT association is found.
> 
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/core/device.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/core/device.c b/drivers/core/device.c
> index d365204ba11..b6d00cf4714 100644
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -459,7 +459,19 @@ static int device_get_dma_constraints(struct udevice *dev)
>   	u64 size = 0;
>   	int ret;
>   
> -	if (!CONFIG_IS_ENABLED(DM_DMA) || !parent || !dev_has_ofnode(parent))
> +	if (!CONFIG_IS_ENABLED(DM_DMA) || !parent)
> +		return 0;
> +
> +	/* Look for the first node in the parent chain */
> +	while (parent) {
> +		if (dev_has_ofnode(parent))
> +			break;
> +
> +		parent = dev_get_parent(parent);
> +	}
> +
> +	/* No parents have a node, bail out */
> +	if (!parent)
>   		return 0;
>   
>   	/*

