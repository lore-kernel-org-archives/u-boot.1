Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1D0C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 09:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D7181F45;
	Wed, 16 Apr 2025 11:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744794531;
	bh=X5XB7D4qyefmFSGTLcodqblk32NWlenewZ+g3XEC61c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=JXvsRiP+27zvuKa92NSw0hno62UnVFAyTCVIpA2Hq3ygCpqmrTKEFXr0E2/lZpiQd
	 gYQ4plCZm7tlCdf5bOPWb6PUQl2HJb12Uooime2WK0ogjdSu25ouvZZwSE+y4+HwKz
	 Hue+k3tQYk3/X18vPIUjIfyMkb/AEW3Cm7QCy2GOAK5UE+8TTLmIQfst6RMKrki+Ia
	 eADBtpsr1eTLGziAdTsoABfXfX+KlKrkUXMitXqQKR1mAU/O1UD2dSkUQgqvfvYc1O
	 gob2EmbG/a0TaFIpHAep/HJxaQ5kQZW5rzx0/zc6hZ4zsooeriWBIQ5sLZwqjnl4MV
	 d8IsL/PgV4IcQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D948082A; Wed, 16 Apr 2025 11:08:50 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF3282C49
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iVIC5Nk3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D1F4B1039EF29; 
 Wed, 16 Apr 2025 11:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744794528;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=X5XB7D4qyefmFSGTLcodqblk32NWlenewZ+g3XEC61c=;
 b=iVIC5Nk36cgJN3vQsdxetO4RBI/8m7emKSvuQ6UJmnI8edaKmvzW7Sy7ygPvc3kcjhMhFf
 5fFXNM09uS2ZGy5SKz21IVybbwbHyLnRDpK/FBJxVzs4Sw4TlFFffUIcasVFes0wzZcwn9
 qDPPM1RidZjwTPQb1x2YcQzQ98wjIgIJHl2ndSbTNXcomgUypOudSnnurPYA57gdkx0Z0+
 wacz0PAg8yPk6Mro79G+6ozHffwG09PM78POya8rKCX2nPQ5GA+8PyQUoW9+JBlFwt/8ri
 hcE9QEFKgjLgAR9EZfcyPO6p84Hlbz5r8gJ12tMTGi/49GI83FijQM9qlXZkPQ==
Message-ID: <f10b19c8-098d-3f12-a4bd-99221b43c54b@denx.de>
Date: Wed, 16 Apr 2025 11:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] i2c: mediatek: add missing empty entry at end of
 mkt_i2c_ids[]
Content-Language: en-US
To: Martin Schiller <ms@dev.tdt.de>, u-boot@lists.denx.de
Cc: ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, GSS_MTK_Uboot_upstream@mediatek.com,
 trini@konsulko.com, ansuelsmth@gmail.com
References: <20250416062919.1355568-1-ms@dev.tdt.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250416062919.1355568-1-ms@dev.tdt.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Martin,

On 16.04.25 08:29, Martin Schiller wrote:
> This adds the missing empty entry at the end of mtk_i2c_ids[].
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>   drivers/i2c/mtk_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
> index 3450177741a..6edf3f44eca 100644
> --- a/drivers/i2c/mtk_i2c.c
> +++ b/drivers/i2c/mtk_i2c.c
> @@ -879,7 +879,7 @@ static const struct udevice_id mtk_i2c_ids[] = {
>   	}, {
>   		.compatible = "mediatek,mt8518-i2c",
>   		.data = (ulong)&mt8518_soc_data,
> -	}
> +	}, {}
>   };
>   
>   U_BOOT_DRIVER(mtk_i2c) = {
> 

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
