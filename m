Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B475CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA0184BBD;
	Fri,  8 May 2026 13:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q6Trd1C/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C85C484BD1; Fri,  8 May 2026 13:49:34 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40B384A5A
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBnTl1FCsz9t9P;
 Fri,  8 May 2026 13:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778240971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZY4MY+Z4JHfba2dzRnk3PRJrpf1VRZvsic43olzL+w=;
 b=q6Trd1C/pHPgGkbGOHf1w+bJHXKf9yFNQstk9owgmSCjEBUGJ2k5lfr65dTDYnUBUvrV1+
 50kKlN+O4QTkVCP1sA4pU+GwZaGtXfALPM5rpnpqScYnMXk42CEYDXBuHVGHsSbce6YOxQ
 k/fFeIjTAPFvQKXTljudzWwS/qGYlk0880CK0CUOkWYtOqX1MvjxqSjH/SdSvmj5UnQWVU
 XgBuJRNBlRWbNaiU2C49pl2yxvebY/IfmBX8KX/5BUJVxSYapaBYlAG1ocuDwVG3kaUuYB
 Pjg5Zw4Db22jK8j2WAQm7jhdpup0hPXtLAYu6djuaRjRkjzO6e3KBZ4m1kk5WA==
Message-ID: <6cf43fb7-f39a-437e-bcdb-23a4d20d2b10@mailbox.org>
Date: Fri, 8 May 2026 13:49:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] watchdog: sbsa_gwdt: clamp WOR value to hw max
To: Juuso Rinta <juuso.rinta@nokia.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>
References: <20260504-fix-sbsa-timeout-overflow-v1-1-87de9b44112f@nokia.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260504-fix-sbsa-timeout-overflow-v1-1-87de9b44112f@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 172e935dc0778df76ca
X-MBO-RS-META: yigzn94myf4os4udaaig5qmm3c87cw74
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

On 5/4/26 11:34, Juuso Rinta wrote:
> The WOR register is 32 bits, so any tick count exceeding U32_MAX is
> truncated by writel(). A large requested timeout can wrap to a small
> value causing the watchdog to fire sooner than requested.
> 
> Clamp the calculated value to U32_MAX prior to writing the register so
> over-large requests will be set to the maximum timeout value.
> 
> Found by code review.
> 
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan


> ---
>   drivers/watchdog/sbsa_gwdt.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 807884c5bc7..3a924cb2b9a 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -50,6 +50,7 @@ static int sbsa_gwdt_start(struct udevice *dev, u64 timeout, ulong flags)
>   {
>   	struct sbsa_gwdt_priv *priv = dev_get_priv(dev);
>   	u32 clk;
> +	u64 tout_wdog;
>   
>   	/*
>   	 * it work in the single stage mode in u-boot,
> @@ -58,8 +59,13 @@ static int sbsa_gwdt_start(struct udevice *dev, u64 timeout, ulong flags)
>   	 * to half value of timeout.
>   	 */
>   	clk = get_tbclk();
> -	writel(clk / (2 * 1000) * timeout,
> -	       priv->reg_control + SBSA_GWDT_WOR);
> +
> +	/* if requested timeout overflows, clamp it to u32_max */
> +	tout_wdog = ((u64)clk * timeout) / (2 * 1000);
> +	if (tout_wdog > U32_MAX)
> +		tout_wdog = U32_MAX;
> +
> +	writel(tout_wdog, priv->reg_control + SBSA_GWDT_WOR);
>   
>   	/* writing WCS will cause an explicit watchdog refresh */
>   	writel(SBSA_GWDT_WCS_EN, priv->reg_control + SBSA_GWDT_WCS);
> 
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260428-fix-sbsa-timeout-overflow-20cf84fa8a6b
> 
> Best regards,
> --
> Juuso Rinta <juuso.rinta@nokia.com>

