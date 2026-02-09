Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA79EE7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 19:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F718388D;
	Mon,  9 Feb 2026 20:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KLfgeps5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F8D83BF4; Mon,  9 Feb 2026 20:47:54 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9C0802C1
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 20:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so1041355e9.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 11:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770666471; x=1771271271; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kGWfG/SIXJvJIdRzQn4F/i8PZQFyWMggmncbHXlu5GU=;
 b=KLfgeps5BGnfw9TYeNaEchGcRHRkkmGThYMGt0qUx1vYBUNMskULbr78M9/PYN6RXx
 EOywV6G/YnoS/tawjeRpBunZTRqCfc/0jpeCDymzfxriQLA+6+sF2yRfvs+xsA1U7Ow/
 b3xbYaw3Sh9HSePVvX8F6/a4ibtLSlq3aeeaU3QEBIO4Yc3GIgvkcv/AAh6kVc0gSRhF
 fwS7MPWFKsdmSzIyQCDL+uuHpbZzMwFLL5G9Rmq9RXM5yoBQZxzAtyiw98u7O9j12d64
 tlD8KuQyXFATxc18z0xL6btPlsLBmw1NFtWC7irSstsiIcFltIzZ5e96UvBx6T8ZjOUG
 OeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666471; x=1771271271;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kGWfG/SIXJvJIdRzQn4F/i8PZQFyWMggmncbHXlu5GU=;
 b=JFneejR6IUBtpI7NAp+YPT1fM3nDaLD0IVpJBNvC4r4gg2pRrPGTQ7blhXVOgAMmvu
 tDAFnZ7XkHFqIss3Kw7VcaCIAa5QnG8rDe430WCoj3qLh+l3Wg64Wf0tzhxS2cJMgn2E
 eTCLWZ8+36AJ7yB1XEApW2q8NxyoVjr50RDOEthwbPJOI1bAPl668K5YOtxxwOpfndRx
 RGleO4/VOslofsUsYR/49rEA7EFgy5zvoB9L95cdxh2QgSE8/AnvkFYHmIu721Ic0JrY
 i1DIEWU/PSa/kV9rkXZaMb6/QYUtwdmbQyhH8SRU+j7eo5gJwsSc2xcpjfOX3zVhWp+V
 sdhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Kii1UXLfAjKSmk93dDTiW8AX2fD0JY7WOFW8umuk30U9SRDXEkC+HPtbnDuIW1uJOaEBfpw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx20ozkh//OKNJG/ELQoPEweXIWee1gBycnJD7fIfJVdxk5BOZ3
 tTjifscQJyMFwSN6RopP1u2kOaVWGtFn284+DgOdqT1qZZH1RvIL7SyEcIWptgHfZSg=
X-Gm-Gg: AZuq6aKalLxiAiCtoD59gPKTJsYr1T51KiEH8EpXVdFcx3zHBsAGVN3/cCpOXzU4WVE
 ygMPRPYSGd/UnEQl+j2VUiIeEVXYkmI1DjO7gqcxx00jsYx+fKx1kkRgUTO/OcN/nDi//MuoIec
 dxHgv9SA6+FYc3XcDlsFpD91AVV8Qxbu1d+ve8Ch1rjJuTJtSUQf6zdZZBy+8IrYiwyj2EMdoNt
 E/Dup8tAapQcmjLhHOfbYqt7/3h9/GU8Xqg5Kr2pzp6B03nPGI8x0lcuhl1HZgCguAOE39ZovET
 T0e4ad2Sx++swxIuUVwJ/XQ3ZDHytxw18DvcD4xdjEpWV6LOIqAstaU8wQRS2CG3RoH6AADajeT
 ZWtQHix7GoF2E0x42ch14yeyU40RBi9dOy5J/z2nqZ0EKR2+lTCm40fnb9yJDvTnR5s8cX+f4uy
 dU3jiGyZdr80JgccivjmNQ+fOWXpXBJDF6t9Wu52Kct21hX3CFUP3Yn3AS8fLW
X-Received: by 2002:a05:600c:8b26:b0:480:6fbc:695f with SMTP id
 5b1f17b1804b1-4832022bba4mr171977115e9.32.1770666471548; 
 Mon, 09 Feb 2026 11:47:51 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7f09e7sm9924435e9.14.2026.02.09.11.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:47:51 -0800 (PST)
Message-ID: <a239fe26-092a-4f79-9601-e9a69606678d@linaro.org>
Date: Mon, 9 Feb 2026 20:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] scsi: Replace SYNC_CACHE with FUA for scsi write
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 bmeng.cn@gmail.com, andrew.goodbody@linaro.org, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
References: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

+ marex, I'd appreicate your r-b before I consider picking these up.

On 22/01/2026 09:39, Balaji Selvanathan wrote:
> This series replaces the SYNC_CACHE approach with FUA (Force Unit
> Access) to prevent data loss during board resets while avoiding
> system hangs during large sparse image flashing operations.
> 
> The previous SYNC_CACHE implementation caused timeouts and hangs
> when flashing large sparse images because it issued cache sync
> commands after every write operation. The FUA approach achieves
> the same data integrity goal by setting the FUA bit in 
> WRITE10 commands.
> ---
> Changes in v2:
> - Reverted "scsi: sync cache on write" commit and then set the FUA bit
> - Link to v1: https://lore.kernel.org/u-boot/20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com/
> 
> Aswin Murugan (1):
>   scsi: Enable FUA bit in WRITE10 commands
> 
> Balaji Selvanathan (1):
>   Revert "scsi: sync cache on write"
> 
>  drivers/scsi/scsi.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 

-- 
// Casey (she/her)

