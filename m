Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8485C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 09:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1220188A7A;
	Wed,  7 Aug 2024 11:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723022896;
	bh=bbOWFj5VDpqv/w6Fdy6zNc48CW4cipXA7ZEh0L1hbCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qDC1F/qQi9I7RCh57z/6xi3/xDrhSOEiDyOKPQAAZ3zAASryUckc2rj/CRzO2djx5
	 9CJ4uUraGDCBntTIMxtdiIsEzKm3S/2V2JOir2HcAkiNfuyQxd9bPm8/RByIFWtJHo
	 J6UsLtfYH6Ho/yCwzjEGyA5Uo6RYco11osyXW3S6T4/evRT04GdQZijORjzUkSg8um
	 7vKEUaMK8MLXkA0A19sBH7f/dXpE2GYZ4G7yJuUlp50CVsBjP3Hu2GBQjGXXkiA1EF
	 1M4fXkRhFGy8LtQ4fsHwyUcIEfV+iY0CnHKMEvxDYLY41A7MNyCaCoFpWwtWzU/MYZ
	 1siPiMnKt4qZQ==
Received: from crub (p508b6395.dip0.t-ipconnect.de [80.139.99.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0264F88A66;
 Wed,  7 Aug 2024 11:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723022894;
 bh=bbOWFj5VDpqv/w6Fdy6zNc48CW4cipXA7ZEh0L1hbCQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=q+xXf/LxkAcQEz+3efJE1a3ZcSiQMiyjThjRM1+QXu7ZaRAFM4n3NkxXlyNlPUovd
 cmwN0FN0aWl4lwIpBcNpsMbkguURjIpVJN+ReNbm0ozVkP2oatCrKFideEfaUgpad1
 33CGWTGbB2mu4dS3SlMkSC3+pFjwep+gNxR/+DQ/K1XelFyknzHqkc+45Prw3iaRGC
 ehi+gWcqNmMjKKVcF6XowicmHOb2wuTjeJKUDWW2AcGOYEi1d3YQnG6ttF5RPuBXHL
 bxy2IeQI06UYBeJbo0tByn869R2py7y4zIznPw1lD6jMPdB4EkRkm6WEuLxNTehm+M
 +5lU7D34+x1ew==
Date: Wed, 7 Aug 2024 11:28:09 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Tommaso Merciai
 <tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH] driver: pwm: pwm-imx: fix probing on imx6
Message-ID: <20240807112809.04ec0809@crub>
In-Reply-To: <20240807085811.115732-1-hs@denx.de>
References: <20240807085811.115732-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Heiko,

On Wed,  7 Aug 2024 10:58:11 +0200
Heiko Schocher hs@denx.de wrote:

> U-Boot 2024.07 drops on aristainetos2 board the following
> warning:
> 
> 	Failed to enable per_clk
> 
> and bootlogo is not seen on LVDS display.
> 
> This patch uses old behaviour for systems without clock framework
> if CONFIG_CLK is not enabled.
> 
> Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg clock using dm")
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
>  drivers/pwm/pwm-imx.c | 56 ++++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 8fbb40cc276..0237ee70977 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -160,7 +160,11 @@ int pwm_dm_imx_get_parms(struct imx_pwm_priv *priv, int period_ns,
>  {
>  	unsigned long long c;
>  
> -	c = clk_get_rate(&priv->per_clk);
> +	if (IS_ENABLED(CONFIG_CLK))

Can we please use if (CONFIG_IS_ENABLED(CLK)) ? So it will also
work with SPL. Thanks!

--
Anatolij
