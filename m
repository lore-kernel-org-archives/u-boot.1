Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C475BC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC31860ADD;
	Fri,  7 Aug 2026 19:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AvLLXJ-BKcWZ; Fri,  7 Aug 2026 19:48:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E125660860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786132085;
	bh=qCvtmVlCt9ZlEEvYpqYkHDE8YKoojJQjx9gp9has1CY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PWMgAc1LKOCxwkX9Fj0OQRFjjYde88k19q0JTJdOravaqKuAxVGVq2Yvfn78193UZ
	 MBOMvIXOBf8Ap900OMG9Yx23UQPTDQcyOuC+kNnraUsQDVcoq+z79+xhl0tYK2ZveW
	 JV1HKB8u4+zVzIcFVG9EixWc1Z9TB4lf88dUU0+RO0UNMOePUe8nNvD0YpPLU8e5ky
	 v9jduSCAsl+/KOYcLgEGWP3L/9FLioakf4RQieIi96E8zSk05Is5uM5P/Mggs1lK0w
	 TRqbKU7Moy9UA6EuzrjzV1g6imKdHyx7VFvyIS5ECdY8lHVmsIyN+B20XUqEN2uHsb
	 YkTyv+76++wwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E125660860;
	Fri,  7 Aug 2026 19:48:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E1F41AF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 401584093C
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOkrcwVLyAiH for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:48:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F06D640933
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F06D640933
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F06D640933
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:48:01 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-495b250b01cso2106635b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786132080; x=1786736880;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qCvtmVlCt9ZlEEvYpqYkHDE8YKoojJQjx9gp9has1CY=;
 b=Dd6Y0pOHthLiZut/h37gL+sCYUSgs58EUoczF/PXRj0OzQ0mcpMzI02SH2WiaMvqf/
 5alo5Hy1veJaaXfd7+4sNzaq1MTrjAbynre0dOg5WEeXdWXJiwEUYAxH9eBTqIvClk5d
 QPTdmJjUEvWNGvjGHrJlYZjhkLVysc139fCJqKBc8e0qIBGmumbCEVb4BRj8OtrDvc+D
 4r2+L1j+BazzDeKfbnFg0v3m1C59q4JPkreEg+G4pSI75Uj7Jjacmbc/fED2N0z8h04s
 HzSn7r+gs+vgQ05YS4bhrwxXiYv1eUOFuYNzU260nSC1ZteAIZWaIRh+lP68Cmp3fvQv
 MJDw==
X-Gm-Message-State: AOJu0YywvoIBLiCZdEqFdkteOMNEgn48tlYt0zwsnYQrxks/movp8Rco
 KaFndEc2KlusWhAOvYFUX626EZo3BqhnitDDO/vp3Q4oTzVdzM6zmoaDP21aw2adLNc=
X-Gm-Gg: AR+sD13TDyCUkxtRlmafR6J6jCp237Ph2gqCpAlDxojEQOWqOieCSvlXIAeq0h+uLi7
 aVFDO4ZIs+LUUoXwYGMWU2OUA0n2HVM6tCPnlbCiSkEQOrr795SkGZyBi+kzmDDp4MzWL8/Uota
 V1iu6Di8NNDGW2+JhzQ4KPVHK/yEo6LSE50giovwWbVJg4TgF2NN4G+6NEepe3Zj+6gEili0Brz
 wWUMMXhjBvOqXMP5vVDedsIM4A88ZMWXHfsZUpl1H3LR09MahAPuoEQ51f/sh4XthEEsMjdZoqY
 Xm1z4zdiyMDTgn0111dmR27cgy/SE0oqesh3O9kwBPVsIUX3myU1ODBy2L5nRPWNX1/VGqJrERs
 2jE5jUscppz5N6XpEQ7ihhAy1UArsXzAvZJtNoxrebZwN3f4seWj1SQu7MO5FmJCIGkVslRGLQF
 qnQOkCWGsRC23Wx4Xbx/7g080vCSOLMS+J4252ylMZ1STAJ7+Vb8O2Qr6EDuq8WNZnVaMvrSFwf
 7OmIy4QNSKd/hNIsCyWXMm0dmJ3LyLop16e
X-Received: by 2002:a05:6808:1313:b0:4a4:866:c39e with SMTP id
 5614622812f47-4b1ab8d941cmr1461950b6e.11.1786132080279; 
 Fri, 07 Aug 2026 12:48:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2?
 ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b1af63b441sm357959b6e.14.2026.08.07.12.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 12:47:58 -0700 (PDT)
Message-ID: <1873add4-8848-4b54-af92-df734529cb41@baylibre.com>
Date: Fri, 7 Aug 2026 14:47:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] serial: mtk: guard clk ops on clk.dev
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
References: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
 <20260807-serial-mtk-clock-fixes-v3-2-8cc94d313b57@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260807-serial-mtk-clock-fixes-v3-2-8cc94d313b57@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786132080; x=1786736880;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qCvtmVlCt9ZlEEvYpqYkHDE8YKoojJQjx9gp9has1CY=;
 b=M7n/S9uHJt3IRmrH/v9gfMTyKO5GjDVIrL+5LXLAy/xTbMR41fud+IHY+2jhpbTWDQ
 HPE80nEN0XmGYdy3UdYFYznXXt3DetsDS2yEIEe5iYfXE69Dj5v11EC5A+/foJXaAOs1
 DZaAp7SrP9hrfRU60DywTqBAcoAXeba0Gqhq+FH9GeBjcJ+WJQTw90qrmC6izCM3fv6n
 XlGjRjOm1NCYRE8d4G5PfOwQjzEmu4O7fyCjtTZ2Mqyo+ACpEoWWnUHCRjU9pFdXECtH
 CmO9uYMaQR/HcE6uMORb5EkY+7uegiElkg3zGOdmyPhITYs8vf32g8TyG6gDVUwuBqNG
 qF9w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M7n/S9uH
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/7/26 1:59 PM, David Lechner wrote:
> From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
> 
> Check that priv->clk has been populated before trying to use it in the
> MediaTek serial driver.
> 
> The clock is optional and may not be populated in all cases (in which
> case it is expected that there was a fixed clock rate provided.)
> 
> Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clock souce")
> Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/serial/serial_mtk.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
> index 28e87f485a2..0f1d3b63f23 100644
> --- a/drivers/serial/serial_mtk.c
> +++ b/drivers/serial/serial_mtk.c
> @@ -215,9 +215,13 @@ static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
>  	struct mtk_serial_priv *priv = dev_get_priv(dev);
>  	ulong clk_rate;
>  
> -	clk_rate = clk_get_rate(&priv->clk);
> -	if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
> +	if (clk_is_valid(&priv->clk)) {

Bah, I got moving too fast and didn't test properly. This is supposed
to be clk_valid().

> +		clk_rate = clk_get_rate(&priv->clk);
> +		if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
> +			return -EINVAL;
> +	} else {
>  		clk_rate = priv->fixed_clk_rate;
> +	}
>  
>  	_mtk_serial_setbrg(priv, baudrate, clk_rate);
>  
> 

