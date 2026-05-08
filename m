Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF828CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCFE84D1B;
	Fri,  8 May 2026 20:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YzwFNWB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F142084D66; Fri,  8 May 2026 20:48:01 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BCE84D02
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bc188a20e0aso314337966b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778266078; cv=none;
 d=google.com; s=arc-20240605;
 b=Xh4rX/75RkkP1phYY0WVgh7ekU+d4P5LneTfS8mc+SpPWJ+f20JsTFJ+qD3LoDHZ1Z
 KVzoAIv/9JYeWfjQqNKZd5CIlTORgjUSk3cn47VIDPMow6GydLQTAqz0cn0IMn/o9yds
 yYLzTviVlQwg60cHTxduVfMIf7D/NhOOZJo8u5VWsTRxfBpbPUhMJ4kOEy35fdHcm4//
 itW/OPJ5bnawKrSb3R5rB0pLi6yQJL8OgLq6mkI+401IIqitlCkzeWFwEE+hBORDgIZB
 z+GehR16mGZPJpa6GcrUi+TY+IskaC/u2xRGVKoorgTtrqlw97/BmogJArCbs/wlIWS9
 EmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NWt7CMpqgnYS9aFrs3xRPUlTxn/R5SRTEVpvctnyP2Q=;
 fh=TNREppFnaUt349E011p6QoBCIjxURDk7Rp2oTxLMc2Y=;
 b=NIhov8Y6fMLxTv0tVmuMYy9jKjXwjT6Siqq77PeaQx7CAxcnv/NW0xT621Vzc4PUKX
 1BV5HibFr6pgae8puVeKV7T4D8xvNStCsLqR9K4ocXDvqthd8ZkoHEX0jdlB11Y+MXgH
 SW0Lu3dzA9o7ObVbz9bLqPxyu8Zk+IAtlj2RO10KOR9JVUCSaT773GC5gDuYtnLom1Tj
 Zu1cskfViKkqeuK0k666odC9IsP9huZ0BKzvUbUoO8VGsc1b9Pte+S99tECZsNgMZjHy
 KvPp7lIiDFZuRHFrxf286AJ2SScwz8V9uVed5AX1T4FOf+ov7tdhCRHUIYAWu7YofOz5
 Rrew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778266078; x=1778870878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NWt7CMpqgnYS9aFrs3xRPUlTxn/R5SRTEVpvctnyP2Q=;
 b=YzwFNWB3Y9scqrUcnrVPMgOlMAb5eMT6Rm6dTVutzdJ7B7cD4ypAgvEc5caSLTFT0G
 +AZj0W3ZoOPHKlyfbRD2VUchdPclkuvcXFs/1pZW7Rd+hNT1xo/IDyvITd+X/rKxdvSi
 ERt7L98ifBZPYssdUpMG9DE7KVWmQ3vYlKRWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778266078; x=1778870878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWt7CMpqgnYS9aFrs3xRPUlTxn/R5SRTEVpvctnyP2Q=;
 b=q2aZglTNSaGKpuahSNixI9CvgKwMEc2yNIivUWo5tRQQBiLOXdvQyhBc0+3cVU3rIB
 E0549/qiLQhhtwKDyQtbPQsellN0T9ZcLqLA8AnvHJ9FA0pWQLwRXOqzfpgDqqnDo/yp
 yQ9wz55QOIz9TgkJUgX5iN4LMzalpZZzA8AJqr+VpYrXqGWJXPMdvmVsZrtynHWmlGsu
 nP+zgxszyBMiQB8E/QAwI8MPPQSTMpQjh8aze8n96EXY57tV1Vou4JW3HPJ7kttb+U9X
 UWOt5B76gWXsJRA8s18OcOZOeGdYLiK96juhCddO7T2iZbWFQT1WhhtVLby8ihty1yCa
 oaSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aKtbgjnekAcWUVPWzp3Xc05rdB17D2tM3jFjDDHWObcyyJwJopU6dLOMX8w6DHVK3+vBeZmw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywk9l+xUcM1vtxkRQha4yiT60CcmO++LnzFx2EZnmvzyAOqIUL0
 eOitt3s53YupgEjsKXfphhCxIEzUarvhhn8LIaqXqRHyESLcLa9LGa7Xa0vUmr96CMJphsacO0k
 mcabjXHnxm8I6MeKVFNZvLTm5rgcYTwWCDhEGQgwK
X-Gm-Gg: AeBDievGMFw4y1JtW4mWx/FL3sdWsv4raHi/YmC9COZj+idoIU58FUnFocD9RmTSyfk
 OGPkvXWZVZXO8OMTpUfnjQDpXHYb+pHDiB5Kv5iDTGJ2a3FjXaPeiBLFbMcJdcwlb+Ytux60uJw
 bbFJ5XlyD/WK6NotU/VGoD5n+kiwS0EiEElcEKo/CVX5c2kVZbK96JT30u2kF2aT1i27LZfcCat
 VdlGVVhu0tmADereVAdum0apxnyi3urVVTTfEN/rks8yC701dQcetft+EyYdSzOLiUjYyOHfDFn
 8EZpyQ==
X-Received: by 2002:a17:907:3e8a:b0:baf:e47:1b6a with SMTP id
 a640c23a62f3a-bc56cd3a9ccmr889019366b.24.1778266077888; Fri, 08 May 2026
 11:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154239.1E16368BFE@verein.lst.de>
In-Reply-To: <20260508154239.1E16368BFE@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 12:47:45 -0600
X-Gm-Features: AVHnY4LHjO64f65-nsrEYvxN3fFRJxzNSDoS_sfcRGmXHG5rK8V61-6NfiCo3nA
Message-ID: <CAFLszTgaG8RV=kWgr7Gu3tkVniq5pNVQ7RSUEv2EMyyQ4ALO6Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] core: Skip parent device nodes without a DT reference
 when looking for dma-ranges
To: Torsten Duwe <duwe@lst.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Andrea della Porta <andrea.porta@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Torsten,

On Fri, 8 May 2026 at 09:42, Torsten Duwe <duwe@lst.de> wrote:
>
> From: Torsten Duwe <duwe@suse.de>
>
> If a device node got created dynamically, there is no guarantee that the
> parent node has an associated device tree node which could specify dma
> constraints. Especially PCI(e) enumeration adds intermediate "bus nodes",
> also dynamically.
>
> Try harder to find the correct configuration by walking up the tree until
> a DT association is found.
>
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
>
> ---
>  drivers/core/device.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/core/device.c b/drivers/core/device.c
> index 779f371b9d5..9de64dbb3c5 100644
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -459,7 +459,19 @@ static int device_get_dma_constraints(struct udevice *dev)
>         u64 size = 0;
>         int ret;
>
> -       if (!CONFIG_IS_ENABLED(DM_DMA) || !parent || !dev_has_ofnode(parent))
> +       if (!CONFIG_IS_ENABLED(DM_DMA) || !parent)
> +               return 0;
> +
> +       /* Look for the first node in the parent chain */
> +       while (parent) {
> +               if (dev_has_ofnode(parent))
> +                       break;
> +
> +               parent = dev_get_parent(parent);
> +       }
> +
> +       /* No parents have a node, bail out */
> +       if (!parent)
>                 return 0;
>
>         /*
> --
> 2.54.0
>

There's already a unit test for device_get_dma_constraints() in
test/dm/read.c (dm_test_dma_ranges). Since you are extending it to
walk past nodes without an ofnode, please can you add a case
exercising the new path - a sandbox device whose immediate parent has
no DT reference should do it.

Regards,
Simon
