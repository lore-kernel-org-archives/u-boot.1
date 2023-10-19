Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADC9CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1920874B0;
	Thu, 19 Oct 2023 17:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697729749;
	bh=OKui9k6R/fdvOdwB8IE5aH+ifNJpS63yVc8U2mvfBnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OBXjbYkdy0pDceiBEFf4ku+INn+ahcgzc+kfgLCCSaOBBjxTF+nEX3X3bJ4mn2VFq
	 HhJO8CZeecWacD0Y35Z9iKsLcR7hcI4Cu6Aw0kc4SeJX/IJB8xx+9nx2VzWMt41KdT
	 7hCRVBE7HQP13Q2C+PPzgThTst/rHRDf9+tOAm923yrlLyRaPDQdghsxR/iAFqa1i1
	 M2cqCoDVw9Xu4foYpKpQ0z8PuGzArCC5tixzhIjzanPkAtXkqojcVdNOB52f2Ck2gz
	 sfqt/QAd8G5kL7bfHNgkSfXsd3fR8pksTg2sz5QeF/QOsF14oU9poygcMxS7FmIXy1
	 oh3g3I/cCOhdw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DAFA287454;
 Thu, 19 Oct 2023 17:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697729746;
 bh=OKui9k6R/fdvOdwB8IE5aH+ifNJpS63yVc8U2mvfBnQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=zxBY71zReKDoWEBvYYPXubFB2NizTIika3Wng7RQCZx2IDOdklrFXROn6naWT86fx
 VK8ggJ9LZhpLM/BcwDOO1Ogdl9/q2vzyY20c/WFtMxo4o7i9aRO1kia4uyybM1KqLe
 I/p5/WnkfC055eKMSA5158zQ54p9RqXzBJDNHH2LYiB1211WxKeAJQszMvCpkhNlO/
 3Uj1lkuhlgHYoO7NsKTIF5ZjiTT3JRR/96WbpsrUXRCpQDHOfBR4OzCozX9CleqXzH
 RENa0xjTGWe2pvmmeVsFKdkO64zByJ1pl83BPTob1wVOZxz1cLQHAnmnxs9t83NtE1
 Aj14HXEztO6Ow==
Message-ID: <88c0c718-d62f-4854-89d3-c68029c44556@denx.de>
Date: Thu, 19 Oct 2023 15:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] led: add TI LP5562 LED driver
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-7-rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231019095837.2084458-7-rasmus.villemoes@prevas.dk>
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

On 10/19/23 11:58, Rasmus Villemoes wrote:
> From: Doug Zobel <douglas.zobel@climate.com>
> 
> Driver for the TI LP5562 4 channel LED controller. Supports
> independent on/off control of all 4 channels. Supports LED_BLINK on 3
> independent channels: blue/green/red. The white channel can blink, but
> shares the blue channel blink rate.
> 
> Heavily based on patch originally from Doug Zobel [1].
> 
> I have modified it so it matches the DT bindings in the linux tree,
> and also follows the linux driver implementation more closely. This
> should address Tom's concerns, and also matches my goal of making the
> U-Boot driver work with our existing .dts which is known to work in
> linux.
> 
> As our boards only have the R,G,B outputs connected, I have not
> actually tested how the white channel behaves, but the R,G,B work
> exactly as expected.
> 
> [1] https://lore.kernel.org/u-boot/1547150757-1561-1-git-send-email-douglas.zobel@climate.com/
> 
> Cc: Doug Zobel <douglas.zobel@climate.com>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
>   drivers/led/Kconfig                           |   8 +
>   drivers/led/Makefile                          |   1 +
>   drivers/led/led_lp5562.c                      | 578 ++++++++++++++++++
>   4 files changed, 650 insertions(+)
>   create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
>   create mode 100644 drivers/led/led_lp5562.c
> 
> diff --git a/doc/device-tree-bindings/leds/leds-lp5562.txt b/doc/device-tree-bindings/leds/leds-lp5562.txt
> new file mode 100644
> index 0000000000..4e0c742959
> --- /dev/null
> +++ b/doc/device-tree-bindings/leds/leds-lp5562.txt

Why not use Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml ?

[...]

> --- /dev/null
> +++ b/drivers/led/led_lp5562.c
> @@ -0,0 +1,578 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Doug Zobel <douglas.zobel@climate.com>

Why not port Linux drivers/leds/leds-lp5562.c ?
