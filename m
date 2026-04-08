Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F9E10F9972
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 19:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0063838BB;
	Wed,  8 Apr 2026 21:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MPQ93GB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAD9838BB; Wed,  8 Apr 2026 21:04:49 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B31483693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbce74e537so80370a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775675086; x=1776279886;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UskTi13hp/xyWSdcpsi4P20ku7eYkfO8ld0IxptIzfs=;
 b=MPQ93GB79A5oIqyamIPtAUNl6LFsb7J80AFiQg6Lb9n6nHUbq2i9lKXqfGvQbnamWG
 /gTYhq0FeeCowCFh0j0QCVcAHBxHaJtjreUrqDtuaxKq52+35rlvnBdic9H+9v+gGetI
 rRUHLAo9ZmJjj+oIG9eOVd17TkR4riyC3bgeA5zanRzlVJ2FoBgxu4Z+3c9OMo1Jp0c8
 qVACqSjXLsxPINLMPd+e2JBI8cxQo6dBvy8FDcJRpyzYfhSzmy+E9J9tZbdeJq+iiX8i
 zZwfPKIWJqOIU5q/DzhIkcJSIyhf3ntIm8cBkxEBEKWtlZ+rBaGu1Zo0z/ukRHB8rSQp
 RDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775675086; x=1776279886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UskTi13hp/xyWSdcpsi4P20ku7eYkfO8ld0IxptIzfs=;
 b=qqw+PBNTjEkBnFPMRT1Y8UExXzIjdlpTxu84vJnY+lFGJJjKh4ArfDav0+BqYy0bIF
 WA4PD5JSU7bLm/3kA8vPa4yIFeSR0FH+s732oQsYNWNLuA30zppNZDp4LU7P6H/iYj/S
 nOFswrAkOPkepICVBoixIDPYcMh3x1ZEWGnelE2sYiJXYoCEBdb0PThfvSoqN+4t2tB4
 O/m7x7ZANdsmf4W86AFcKx6otT/C8/A9ZSPwBATn1r43QMRIRKudeq2mS+rI839lirPF
 7AZ53R3Pq+3J48kbvz7lVie3huvHoCSg3ZjBT9fClooJ08jXAXDvSCYyfdS5X6/U3t01
 UNow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtCDHOu2FmCwtggrU+HTj1QhHaV5ivwae+tUnxOCmXXrXPohJOyNo9z0dzOlvl6b71Ms3RDSA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+ATKABdrccb88RTIU36n6y6w3ARO/t5H7bocsEZY4YUDD4Ylo
 nFcyOWBB6+t3Pd52DY5+gSAZ1tsOI97wLbwfBG8o5eqRc5NpsKotjBPTA9wMNF1G+lw=
X-Gm-Gg: AeBDieuaiNuLg/ZLG+4mAjpPRNdo7rhOx/0ycc89R4mRHMY45664zK/CAkA9ufzmySg
 6k8xfVuhkK5lcNZiL7ci+qpre3MAnNSAHqCwOx4GmUdmcsHkEQIwS3Tv+Axti/YmdQAGiNogV5b
 87ctrlLAfyuoMnIGMZLaDNYvti2UnQ6NBRub89exqQXOLKuloc45N0bKbwD+woBugLC3i3yfrOB
 xb0agBqQ8WtP807RMSVxlajk9DZhsIHRTUcgb/2WGNTpHmb3908JP1th5wHQIYK4N5AIA2c+stf
 up/MjtEc6vqAiU48eRs0FiXkUdoG5HTxhRp6tN+2OAmR+eKfddTIA/DPRsBOVajepT/QtMOilMZ
 vLORvs9FiYxAU6fLnha4XKFcXQ/1K9gD2AHN9ep4318asz779V2d+7w0IzPWKI+Lpz4NlpFoExr
 DGoChpKf2o0sh7R9tXaB2Uly1hiGoeVqXd4O0wMS3Q3b8pCjjtRkEn8D7R5kKiTD+fpwIprnD7G
 NaSdOjRqOJL
X-Received: by 2002:a05:6830:43a1:b0:7d7:ebf0:34b0 with SMTP id
 46e09a7af769-7dbb74e949fmr12584799a34.15.1775675085904; 
 Wed, 08 Apr 2026 12:04:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:21a6:1216:500b:3ea0?
 ([2600:8803:e7e4:500:21a6:1216:500b:3ea0])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbed6c3512sm5316459a34.4.2026.04.08.12.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 12:04:44 -0700 (PDT)
Message-ID: <87173dd2-7a26-4063-b943-993a6331c1de@baylibre.com>
Date: Wed, 8 Apr 2026 14:04:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] spi: mtk_snor: Remove status register write procedure
 in probe()
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Meiker Gao <ot_meiker.gao@mediatek.com>
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
 <20260406-mtk-spi-nor-improvements-v1-8-66f675cbbd3e@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-8-66f675cbbd3e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 4/6/26 3:13 PM, David Lechner wrote:
> From: Meiker Gao <ot_meiker.gao@mediatek.com>
> 
> Remove status register write procedure in probe(). This is handled in
> spi-nor-core by the SPI_NOR_HAS_LOCK flag.
> 
> Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/spi/mtk_snor.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
> index 21ac115e3c3..3b9eac383ab 100644
> --- a/drivers/spi/mtk_snor.c
> +++ b/drivers/spi/mtk_snor.c
> @@ -567,19 +567,6 @@ static int mtk_snor_probe(struct udevice *bus)
>  	mtk_snor_rmw(priv, MTK_NOR_REG_CFG3,
>  		     MTK_NOR_DISABLE_WREN | MTK_NOR_DISABLE_SR_POLL, 0);
>  
> -	/*
> -	 * Unlock all blocks using write status command.
> -	 * SPI-MEM hasn't implemented unlock procedure on MXIC devices.
> -	 * We may remove this later.
> -	 */
> -	writel(2 * BITS_PER_BYTE, priv->base + MTK_NOR_REG_PRG_CNT);
> -	writel(MTK_NOR_UNLOCK_ALL, priv->base + MTK_NOR_REG_PRGDATA(5));
> -	writel(MTK_NOR_IRQ_WRSR, priv->base + MTK_NOR_REG_IRQ_EN);
> -	writel(MTK_NOR_CMD_WRSR, priv->base + MTK_NOR_REG_CMD);
> -	ret = readl_poll_timeout(priv->base + MTK_NOR_REG_IRQ_STAT, reg,

This was the only user of reg, so we need to remove that too.

../drivers/spi/mtk_snor.c: In function ‘mtk_snor_probe’:
../drivers/spi/mtk_snor.c:530:13: warning: unused variable ‘reg’ [-Wunused-variable]
  530 |         u32 reg;
      |             ^~~

> -				 !(reg & MTK_NOR_IRQ_WRSR),
> -				 ((3 * BITS_PER_BYTE) + 1) * 200);
> -
>  	return 0;
>  }
>  
> 

