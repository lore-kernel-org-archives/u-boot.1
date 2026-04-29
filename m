Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23874FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6B48482E;
	Wed, 29 Apr 2026 08:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="d7leZm3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C40C847B0; Wed, 29 Apr 2026 08:10:38 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F20A584706
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8E8B91147AF; Wed, 29 Apr 2026 08:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777443033;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=mqWq3SMe8UaX5YCkgA0c1v7n4IYEU1eDL0xHcvIH1+s=;
 b=d7leZm3V+Prn87yPuY0dQRjrEkjR0LDpq7BHRex0P2AFo4Lk/ZANoSvvDMdSLzEddIL588
 ujeOoSTY/Up3w+kSlWIGUKbOEuqEgUE1cdkZ9oX2LhKDvoCN//uBzxDXBBt6ZxzAKEiB53
 DyO6stOPicjbGRTxk/s/qlveHfcddlcrkBxkOjcIDU9A+QspLDxuGqcmpW8VwbmfcnuDNo
 taDA94l4yuSKL6Cc8YM45FIdXd+SacKXiB9CrYBsDCfXs/Omm/9R61R6oyNC5vVTQFUtlM
 lgUjwlY16ASY0KgPyQy4Jn2vZGrsC0yfBXXitXGwNYIY4s9z9a5Fs3dDTieJOw==
Message-ID: <df8f5a31-8ea8-b1cb-6807-4b1bb78cdf03@nabladev.com>
Date: Wed, 29 Apr 2026 08:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] i2c: designware_i2c: Remove clk disabled codes
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Wojciech Szamocki
 <wojciech.szamocki@nokia.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>
References: <cover.1777439293.git.dinesh.maniyam@altera.com>
 <2e5bd18743849a8be91ad4690075a545fa56177c.1777439293.git.dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <2e5bd18743849a8be91ad4690075a545fa56177c.1777439293.git.dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Dinesh,

On 29.04.26 07:11, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> l4_sp_clk is disabled when i2c device is removed, this would
> causing unexpected failing behavior for other peripherals which
> are still running with l4_sp_clk. The patch removes the codes
> implementation for disabling the lp_spl_clk.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/i2c/designware_i2c.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
> index 8ad716f410e..40153c72545 100644
> --- a/drivers/i2c/designware_i2c.c
> +++ b/drivers/i2c/designware_i2c.c
> @@ -807,10 +807,6 @@ int designware_i2c_remove(struct udevice *dev)
>   {
>   	struct dw_i2c *priv = dev_get_priv(dev);
>   
> -#if CONFIG_IS_ENABLED(CLK)
> -	clk_disable(&priv->clk);
> -#endif

Hmm... clock framework should have a counter how many times clock
is enabled... with your patch, clock never gets disabled...

bye,
Heiko
> -
>   	return reset_release_bulk(&priv->resets);
>   }
>   
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
