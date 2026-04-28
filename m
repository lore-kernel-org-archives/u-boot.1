Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DBBFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A95E84605;
	Tue, 28 Apr 2026 18:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="fAlKeUaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24C784605; Tue, 28 Apr 2026 18:04:38 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D06842D7
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-691de293326so6254831eaf.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777392273; x=1777997073;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lot1L3eYNUfMk2irmQDBWkhtggYoB6vVujd56/oBqyw=;
 b=fAlKeUaZQraTAtNr2yLtGQwo1PxLZFvHLywOT1GT9RTuYJ5y88p84IOsT/xDPD6mHd
 gyGVrZt33GhVjLKDZFocrjj9ehhSrIMbCGg3zGRAeOuhA5RvFY8NpKNd1bT+IfnbGTFC
 /QJSW3lt4neQFrzMdHmtvoVwqV6lTIIlWbCtnG1a/IOm1ZS02TN9ckOMu3gq+BQJsCYB
 OQN7sHVgPYmsUFBjEe9AAnQanU1b6eTq2swzFbIZnYym9+/e5GQOXL8TvYXIaIibVRjM
 O4K1xrvmQsXVm2qmDjQ2+HzlgTtEqSfq6G+PRNY/MBiwR6EvpKNcdC8UQf0jhnxCfvsI
 D05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777392273; x=1777997073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lot1L3eYNUfMk2irmQDBWkhtggYoB6vVujd56/oBqyw=;
 b=VpLeQcZcHcuOfdQEu2JWoShEGplO46xe27erlv+67xK9Q4aQ7uCLzyCssCuHsIHwuQ
 jCg8AmC6mXLsFmU2PHOhlfvEv4jPi7RJXZ79rU1OIpCFCL7VE7Mx46JQ9SIlW9r/6IgL
 zQjz7QL8c3cmIJWU/MAGHvKrmus6qMv1Sfa+KCirD8jSKFgT420WgnSIa2Oi3gGpOb6W
 yR835uJ6HoT1nDByQa12pzBXfJ4N+o8TxiIBjpbhM26GTDWXWaL9dQeh/wjoXhoXDIsF
 nUhxBpanvQuqvk5aSr4RbWlPHBs7cWMh4JfS9M2Uf76ijrts51ZMm9MSn+C4LoFkGCB2
 USRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BW4CHUzRpukC44UOHQKeXzgpzzM7Ab/r9N6f309tpchlW4LJGyrF30LXRlpJYfPhQ0gUWGuk=@lists.denx.de
X-Gm-Message-State: AOJu0YwzkKPjiGcey/22v3Kk0RjQwoVEUJWIVxDOWbJExK4K2kIvYWr1
 qE/Q2xGHg2LGzazdXpbEHVaIVDPP6cZvmsv8PDshodwr0N/VF7wxO4Dzx3b3s8JNStE=
X-Gm-Gg: AeBDievv3MmXjldnf9YgUKJlyvS4GyuM4zYgLfq+iW53Y0gliYPqDzWE2bzGZwdA2X2
 XAThx6IE1s1c/Kum1RYqeMdke1naiJ9NyE73NQHRb5cl28SOLdOXqjYdjfq115PhfqjvecanwX9
 egXaB08cBHVVxWYP1QFcZahGXBrNJVTRoUGPBm/BWMu07r4YHGVJAQPiI0GpthReie2glzOZHjX
 xkb0zc+sHZkCCs+72vzCHEEIPL4PokAzsjsCUU5CN6MPaLkeA0tLoUWawjVWsMM1x1icHa+X2tV
 UUBkkwlAA9Ww9ekwx8O4tmBIWCClPf4SevLdJZXidStbCCqb1LN+WbwYuc1kiY29ovmhsp64ktZ
 U835jbjv6EAMrLAoSdr7Pa8dDY5jpCO0nfS94nOznh5VPh0BuhgtcBRc8ykUkbhW2lGWybJ8sCq
 +aqCmdZHWB6QVO3zj3icPDXZsrCbvughX205b7QOphByLk/Uqct7W+gXyAxsjOhpbAwCqpAZIBx
 7vvTRCLl6o7
X-Received: by 2002:a4a:ee12:0:b0:696:1432:eca2 with SMTP id
 006d021491bc7-6965cbbe29amr2011310eaf.52.1777392273144; 
 Tue, 28 Apr 2026 09:04:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:efba:bc47:a81b:dd0f?
 ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6965b914f8fsm1731472eaf.3.2026.04.28.09.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 09:04:32 -0700 (PDT)
Message-ID: <b183a5fe-932e-4368-b120-19bd56318999@baylibre.com>
Date: Tue, 28 Apr 2026 11:04:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] spi: mtk_snor: fix zeroed data in DMA read bounce path
To: Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Macpaul Lin <macpaul.lin@mediatek.com>
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
 <20260406-mtk-spi-nor-improvements-v1-7-66f675cbbd3e@baylibre.com>
 <CAEHHSvbhrO2QuF8coX-dzXo9M9Z3z3i-9ph75daKbAkoSeTs5A@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvbhrO2QuF8coX-dzXo9M9Z3z3i-9ph75daKbAkoSeTs5A@mail.gmail.com>
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

On 4/28/26 10:54 AM, Julien Stephan wrote:
> Le lun. 6 avr. 2026 à 22:14, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> From: Macpaul Lin <macpaul.lin@mediatek.com>
>>
>> Implement proper bounce buffer handling for the read path to fix zeroed
>> data when using DMA. In the bounce path, map the bounce buffer with
>> dma_map_single(), perform DMA using bounce_dma, then copy data from the
>> bounce buffer to the user buffer, and finally unmap with
>> dma_unmap_single().
>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/spi/mtk_snor.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
>> index 649bca5716c..21ac115e3c3 100644
>> --- a/drivers/spi/mtk_snor.c
>> +++ b/drivers/spi/mtk_snor.c
>> @@ -274,6 +274,7 @@ static int mtk_snor_read_bounce(struct mtk_snor_priv *priv,
>>  {
>>         unsigned int rdlen;
>>         int ret;
>> +       dma_addr_t bounce_dma;
>>
>>         if (op->data.nbytes & MTK_NOR_DMA_ALIGN_MASK)
>>                 rdlen = (op->data.nbytes + MTK_NOR_DMA_ALIGN) &
>> @@ -281,11 +282,21 @@ static int mtk_snor_read_bounce(struct mtk_snor_priv *priv,
>>         else
>>                 rdlen = op->data.nbytes;
>>
>> -       ret = mtk_snor_dma_exec(priv, op->addr.val, rdlen,
>> -                               (dma_addr_t)priv->buffer);
>> +       /* Map bounce buffer for DMA */
>> +       bounce_dma = dma_map_single(priv->buffer, rdlen, DMA_FROM_DEVICE);
>> +       if (dma_mapping_error(priv->dev, bounce_dma)) {this
> 
> nitpick: do we really need this?
> In u-boot dma_mapping_error is defined as a stub always returning 0...
> unless this patch is a direct port from a kernel patch?

It looks like all other callers of dma_mapping_error() in U-Boot are checking
the return value, so I think I will keep it in case the implementation ever
changes where it can return an error.

> 
> 
>> +               dev_err(priv->dev, "bounce buffer dma map failed\n");
>> +               return -EINVAL;
>> +       }
>>
>> -       if (!ret)
>> +       ret = mtk_snor_dma_exec(priv, op->addr.val, rdlen, bounce_dma);
>> +       /* Ensure DMA writes are visible to CPU and copy the requested bytes */
>> +       if (!ret) {
>> +               /* Synchronize cached data to CPU visible memory if needed */
>>                 memcpy(op->data.buf.in, priv->buffer, op->data.nbytes);
>> +       }
>> +       /* Unmap bounce buffer regardless of success/failure */
>> +       dma_unmap_single(bounce_dma, rdlen, DMA_FROM_DEVICE);
>>
>>         return ret;
>>  }
>>
>> --
>> 2.43.0
>>

