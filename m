Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB7BE7718B
	for <u-boot@archiver.kernel.org>; Wed, 25 Dec 2024 20:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD2080374;
	Wed, 25 Dec 2024 21:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735159815;
	bh=CaRqwEIxjuVm+apm9WOVtsOVU7y4wwW2T+jmgI+JIZc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AjsTlrkp0/fWsqFNqVqmgH6ZTcL+e8fH79ykReJ4XzYJuh/FQqglbnQnKWm8k7dU3
	 ELT1i/Df89v35GrhbawnuxruXhjlRJPbv86FlrTlJ0WinTmObtPw1MInbaZ1KSLGfN
	 YutfuaA2Keg0EiBqGwJc1IyGc0Xv8Tw8relhbQ9hKi4u7g1TTOm3fJm4yKACQFU8IW
	 PH1iCSG4zekkAx5qVnwxGzYfMMz3dkMBz/TCpEK3Ofw4DtR7vn/QWwD6drqnzcTlUE
	 dhmeNR6PcqAQSKR5MEyxs7U/8iHsGIqWghswijzTbpzXADdwVCBQu6r80l5gXFVFI5
	 Cq+Rl5Y/rqRYw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF60803CA; Wed, 25 Dec 2024 21:50:10 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E228037B
 for <u-boot@lists.denx.de>; Wed, 25 Dec 2024 21:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="goTU1uRq"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 38C7B101ECBAD; Wed, 25 Dec 2024 21:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735159807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaRqwEIxjuVm+apm9WOVtsOVU7y4wwW2T+jmgI+JIZc=;
 b=goTU1uRqYgoaBRFr34FUv1f376e6k2xYR3JN1Qau6MGdoRzf9tejWooA/G2hH1WFKxidzA
 3okqTE5v9Ykex2JIxy8Z/hD9XCGZDKDxFRtKQ3GI6f5bL8Cg/qW4sMkxb4RDraa7Eb0teP
 JTd786ZpvHrr0j6P2Z+eBx0ifFc3TErSjOgRurvh2U/m89TfzZQ8oGi0uNHlwUeAA5V+d7
 ywQ+AXIkPvB7GKoE8zS0G1S8Uf7hwWXWRekB/1B2+T8+l9eJ2BA1Xt4RDLgOZlcdrunloh
 j0T1aqq/YLAXTkRybnxbMurphBdbw2kUduhz5AYx8oRUpv1qgYhzjUZL3/f5SQ==
Message-ID: <2d8cc7c5-e389-4e18-8872-ba89783488cf@denx.de>
Date: Wed, 25 Dec 2024 21:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com
References: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
In-Reply-To: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
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

On 12/24/24 4:37 PM, Venkatesh Yadav Abbarapu wrote:

[...]

> @@ -1593,18 +1596,22 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   	}
>   
>   	while (len) {
> -		bank = (u32)from / SZ_16M;
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			bank /= 2;
> +		read_len = len;
> +		offset = from;
>   
> -		rem_bank_len = SZ_16M * (bank + 1);
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			rem_bank_len *= 2;
> -		rem_bank_len -= from;
> +		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
> +			bank = (u32)from / SZ_16M;
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				bank /= 2;
Is this code which operates on (nor->flags & SNOR_F_HAS_PARALLEL) really 
supposed to be enabled if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) is SET or 
instead if STACKED_PARALLEL symbol is SET ?
