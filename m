Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3024BFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA252845CE;
	Tue, 28 Apr 2026 17:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="N082F+G5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AEDC845D0; Tue, 28 Apr 2026 17:54:47 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF00843D4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so1080904266b.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777391684; cv=none;
 d=google.com; s=arc-20240605;
 b=gJSKAWuYXC6uOqjNxK2mOP1xETKpZ8kG3sw0DM+QaJZXsO9+SUvdU4YSZbMtrf5Npy
 tPY3EYh4OGHhz+52Tqiumh4KZCrNDvJF45tj8azyRO570MeCo0lPlSWYqetecVPjXUBe
 PIb5BCrygsyKfvlUeyXuYi/iJeg7Pbpr1Crbb8srQRPLT805r7ibCxMur7aQfQSm8vos
 Gb7dXjn2ljh40sLcpwT/LxSCiDVokhQoEAGLD9j+BudbUyfbK/CuMPyVfwodW5DYTUyj
 W0qDwT2QbdJ1FTYbOmuG3cU8Wbb6chl3WvYwfYgl2ZST0Vz2jt7KPtTj0migLQ6Mldin
 +CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8K+Hc0awZr+cNu8bSvq843Da76UkhTjbLUSVzMIygYc=;
 fh=QWtOvaSB67uDq/43mmxYDdb7Xf1X8DBG9Ym1wbIURTA=;
 b=a3wHYrGFrVU48KuYbWWdIjIunfhh9XwpRXt2pGzu11f2Affzzm53O1WXx+dpni2wKK
 5wtxY2UOOXYMojmfujLaWjyjIVt4SBD4T5ZYZ5RMv8TatAtI3aJEcQEuLsTAQM0ttUlR
 oIb3dkQ1Z5IfqZ8q1uH4RyPmukUKrI8Kv/QqmXMq6kHaoVja0kaR4XXoICvRjY6Ec1uM
 XkDs9KkNIcM+XffEDVFnhWZb3ACtcz4UOWnAc1MIj6UP12WGJDjrJ17/LGsr44IvGE7g
 Au/n1NFT9LB6TBPZRtmGnWI/sARNxn9blHNcOGlWP6eUR9+b3qdfj5jNUHoFf7bpYGdc
 KSfA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777391684; x=1777996484;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8K+Hc0awZr+cNu8bSvq843Da76UkhTjbLUSVzMIygYc=;
 b=N082F+G5MC1+uxcHQgXZdK71moqd/b0g0J6+4TUm5k+4mtkRwlRRSmZPTMdOlq20HY
 ySGxxmq8Tbh/KySyxiohHOuYOX68wn86SXY8q4OcIcy8rGOjQbibzVRSATfqcjqzclyT
 upWkWvCd5RGAnO2TTgANgfEE56cZNFvo7BsjGKQX9E2pz/6/EMb6Es3jxLQ4LT/WdSx9
 cRN6UlVkoyuUdMQX+6QlECuIMNVnSkXzWR1fIxMPnCQVTfsMex1dxmyf6pG2JGsBk50y
 ZJBETp0CzLDSY7MRaqXD6J+OQFIantD5fN2DkJKdInp+MeAzd+L3bKcSR3OrYBgrBHO7
 5xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391684; x=1777996484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8K+Hc0awZr+cNu8bSvq843Da76UkhTjbLUSVzMIygYc=;
 b=bPUCcaYrk5Nkc4HLZc/qkaihwOkmml0/WYC8q/h1batyxnQjRemTUg8smV0zAZFazV
 i6gCLbHAezJEoNQhYygfIliMbYaViQJOEwH+fkz754+MkNFwTC3whheQ1etxIevsinrb
 hOFTSX/TR5E+H40WPcf1KWhjzxjuttAn/PKAHYDTxwT3SFaSyfZm7GwUK9XKDVA0xY8Y
 XaLNoBLLcZljEvconEceiQUgTkJuZl06xfKErrCxZlnaSRf5rkReI4INOTuYLHlo96Dp
 Ur5NS3uVxM1T27zKUT/tllSDAohMt7vOXviplYnM0E1IBukRLqoKalQvvcaey3mDaYQj
 jCMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DXCV/F6vYd1tfdlJ3dGUO+hqDdipiDvtA3SIqouRWAHyEfgyGCOXfK3ru/W1Xc4RjI0oDGPw=@lists.denx.de
X-Gm-Message-State: AOJu0YxXYkfz/Xyt8r7ax5ZHtdFaMl+GO3ZgzP6/eCXxOZS08srHHCyJ
 q8/UnLhWhrrkTrH46lh9HimoTe/0+4P8GsLyRod3gxqA4SCUN7y0rMpPzl1gxI6NQNkAWticE0i
 8+SQbnAPK0pRyrjHuvcK0yiLqX7ediKnQ2hk1A6RT2w==
X-Gm-Gg: AeBDiesWUrwHZcx2sT9V7BQ25mkR6tF1WCAWAnkKBCtZBxqoOyYEzNfzG4Aq8afWwFo
 pd+zLxhgJAJ3c/NKvUMJjUXDfeoZuoAbdTVi37U+EdTObkEUoNg+DdEcHn7lbLZFyKjYcsgHoss
 JQBrS/Cp/7Xr+nMI7GxNoW1o9CP5b+DBROI2u93TizD7bs6UZhWeCgaeG4RQJYMm9OyRgQ/RBkT
 s3feb8rjz7YlQnSC8JnyohougA3FzwyJL9SfFULz6HzjVmaetKpD8OFF7uIb3NcYLUG6mll/B6A
 /oGkPfLgDeq1BMAkvavSx3ATYzjAIyyi1MHIpgj/dbgvEXcLjlsDiqX1oMug4YaqerPJOTnVhQd
 p1TYiOkuDh07T4Dhn45b9MPXGrU5kOGP93VTf
X-Received: by 2002:a17:906:7304:b0:baa:f6c9:51b2 with SMTP id
 a640c23a62f3a-bb80443c9bcmr248114366b.23.1777391683358; Tue, 28 Apr 2026
 08:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
 <20260406-mtk-spi-nor-improvements-v1-7-66f675cbbd3e@baylibre.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-7-66f675cbbd3e@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 17:54:28 +0200
X-Gm-Features: AVHnY4JiPtI4b6uF8TSt30mpeB2WnkhIFgkDXGq-YYFHg3cNb0zUze8o6IPHjF4
Message-ID: <CAEHHSvbhrO2QuF8coX-dzXo9M9Z3z3i-9ph75daKbAkoSeTs5A@mail.gmail.com>
Subject: Re: [PATCH 7/8] spi: mtk_snor: fix zeroed data in DMA read bounce path
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Macpaul Lin <macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le lun. 6 avr. 2026 =C3=A0 22:14, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> From: Macpaul Lin <macpaul.lin@mediatek.com>
>
> Implement proper bounce buffer handling for the read path to fix zeroed
> data when using DMA. In the bounce path, map the bounce buffer with
> dma_map_single(), perform DMA using bounce_dma, then copy data from the
> bounce buffer to the user buffer, and finally unmap with
> dma_unmap_single().
>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/spi/mtk_snor.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
> index 649bca5716c..21ac115e3c3 100644
> --- a/drivers/spi/mtk_snor.c
> +++ b/drivers/spi/mtk_snor.c
> @@ -274,6 +274,7 @@ static int mtk_snor_read_bounce(struct mtk_snor_priv =
*priv,
>  {
>         unsigned int rdlen;
>         int ret;
> +       dma_addr_t bounce_dma;
>
>         if (op->data.nbytes & MTK_NOR_DMA_ALIGN_MASK)
>                 rdlen =3D (op->data.nbytes + MTK_NOR_DMA_ALIGN) &
> @@ -281,11 +282,21 @@ static int mtk_snor_read_bounce(struct mtk_snor_pri=
v *priv,
>         else
>                 rdlen =3D op->data.nbytes;
>
> -       ret =3D mtk_snor_dma_exec(priv, op->addr.val, rdlen,
> -                               (dma_addr_t)priv->buffer);
> +       /* Map bounce buffer for DMA */
> +       bounce_dma =3D dma_map_single(priv->buffer, rdlen, DMA_FROM_DEVIC=
E);
> +       if (dma_mapping_error(priv->dev, bounce_dma)) {this

nitpick: do we really need this?
In u-boot dma_mapping_error is defined as a stub always returning 0...
unless this patch is a direct port from a kernel patch?


> +               dev_err(priv->dev, "bounce buffer dma map failed\n");
> +               return -EINVAL;
> +       }
>
> -       if (!ret)
> +       ret =3D mtk_snor_dma_exec(priv, op->addr.val, rdlen, bounce_dma);
> +       /* Ensure DMA writes are visible to CPU and copy the requested by=
tes */
> +       if (!ret) {
> +               /* Synchronize cached data to CPU visible memory if neede=
d */
>                 memcpy(op->data.buf.in, priv->buffer, op->data.nbytes);
> +       }
> +       /* Unmap bounce buffer regardless of success/failure */
> +       dma_unmap_single(bounce_dma, rdlen, DMA_FROM_DEVICE);
>
>         return ret;
>  }
>
> --
> 2.43.0
>
