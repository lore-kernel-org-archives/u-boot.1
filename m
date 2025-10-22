Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376B8CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 05:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7C78323A;
	Wed, 22 Oct 2025 07:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="An9cLfkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033C1832BC; Wed, 22 Oct 2025 07:16:20 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C60982E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 07:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 55644101EC7; Wed, 22 Oct 2025 07:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761110176;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=CKrD8h1IRvlrkkKgJWepn7WlqYNI6bGkbMZgPpByCNA=;
 b=An9cLfkQyPggsNrYU6XDair1jZk/3YrwJ+gGkZIl6kKKph5990pWcIscleVaQx8zwwraQx
 W4eIu0LZTEchnszxYxJ6pbZWLbILUZO6ocxlu6CdcCabNCu1xVGIgYW4WD7LlU2tQ7uaVT
 rZBiL5pz4T0465H0a78L21RmMXJwegNVgfbGozcNPJqQy/tTGrGiQzFg9hhEyeywhnKnNf
 DNGhbWCoRAZp5CcBxXpER1uomTesfGWSuOcVgK0sGRR6ZPpFVTYekP+k7CUDZwlHrQ0OLf
 NpbU85VriFV6a8bs5lANo8pmo7SA0AIj56WNrFaPzC5v38s36ns0UqDReI0uLA==
Message-ID: <dc6a5002-c7f9-299c-470c-a7a2f6ae44cc@nabladev.com>
Date: Wed, 22 Oct 2025 07:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/6] i2c: npcm: Fix error detection
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>, Jim Liu <JJLIU0@nuvoton.com>,
 Stanley Chu <yschu@nuvoton.com>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
 <20251021-clk_funcs-v1-4-acf51a40eea7@linaro.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251021-clk_funcs-v1-4-acf51a40eea7@linaro.org>
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

Hello Andrew,

On 21.10.25 18:08, Andrew Goodbody wrote:
> Testing an unisgned member of a struct to be <= 0 will only detect the
> case when it is 0. So correct this error test to a working version that
> will behave as expected.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/i2c/npcm_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
> index bff0d04f1a5ae2c261657a5776b38e4ab6ad4d28..d57237a6df167d579ab4b8d45f3989a8cac0fc68 100644
> --- a/drivers/i2c/npcm_i2c.c
> +++ b/drivers/i2c/npcm_i2c.c
> @@ -573,7 +573,7 @@ static int npcm_i2c_probe(struct udevice *dev)
>   		return ret;
>   	}
>   	bus->apb_clk = clk_get_rate(&clk);
> -	if (bus->apb_clk <= 0) {
> +	if (!bus->apb_clk || IS_ERR_VALUE(bus->apb_clk)) {
>   		printf("%s: fail to get rate\n", __func__);
>   		return -EINVAL;
>   	}
> 

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
