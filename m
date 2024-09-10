Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25AFEB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 11:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349FA88F86;
	Tue, 10 Sep 2024 13:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="nzkcPV0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338C089031; Tue, 10 Sep 2024 13:09:05 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3205888F35
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 13:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joel.stan@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so89169066b.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1725966541; x=1726571341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yf7kI9BAwGneadGoKmVrPjCeY+wkh/gAWCwtENPhMIM=;
 b=nzkcPV0+qs236zGzn9IJBjTUOa/6anSdx0IgY0lE5mrkTHUGuJpYtfTMjl+ofy45Q/
 G2mHhIe67EDLsTtNcYovFwycYRFYz9JkVU331/r3RXpQ7lQ3enN2jTmp3wpfFY3QGMuI
 C3VST0kxoHpKnH1CQGaZCNLqlwgevV0gR8Irs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725966541; x=1726571341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yf7kI9BAwGneadGoKmVrPjCeY+wkh/gAWCwtENPhMIM=;
 b=wFVZKcxAiL+jbVHK/y0Bvtt/VWQ8mNt2y3xhwjXbyvi/fcSMKjw3xwKwaGVLfCM364
 WFTwJu09esX+3cGvr4aezDvlyOBaMJuwhwC+v3komztHLwE8MuFJrS1nij/J0QCOrILx
 CvWVkz2he+yivAexNnLXhjx4pen9t9KT1an2M+Xk9o4LdZ5vUCzaTHfB/jXji1f+dxKf
 1lDIvB1WsF8SihkfM7EsvjihA9ePJQwkKW2V/81fP0TseMT3ytcLwhmNdVEV5gQL5SJl
 knDR1cFq4l3dXjenTN65R4V5bN1RQp00SR8SxMhgR4UqqJwCuZ0ufymGaf3m3wX61hTL
 pbXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSiNrxtWcJKUDGyL1z4IO7/HmrYzjUKqGky+J0vte2YTfmiTZC40PrKIqEXOZTEkAbNm7fbWc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5PLkoGJmXUsc+GMmIQouvATCtzntvOMEUqRCRWggXMCgHKAn5
 FCxbBdj9PvJ59EKST8/qK9TTuA6c6vdwWKE7fFGyF/wvNt18mCwE2CYD0oThrtFCuWKDsDDaUF/
 To8+9l8QTkE2IeMLYb+ypN3cuWKM=
X-Google-Smtp-Source: AGHT+IFeGmxdqyqaFSrY3jRWOtVTkZg/7Zdc3H+EuWW56DzIQSJvjnwlZ7LvP5EZDzpYdQ7Q5VqasMT05P7zuGD0t8o=
X-Received: by 2002:a17:907:3f98:b0:a8d:4b02:3351 with SMTP id
 a640c23a62f3a-a8ffadf9053mr32807366b.50.1725966540906; Tue, 10 Sep 2024
 04:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240708060718.186075-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20240708060718.186075-1-jacky_chou@aspeedtech.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 10 Sep 2024 20:38:47 +0930
Message-ID: <CACPK8XdVr8G7hBQ3QA2tXqbMwMiRjo2u0tZSa_2YjJEh4a8Cig@mail.gmail.com>
Subject: Re: [PATCH] net: ftgmac100: Add Aspeed AST2700 support
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, 
 BMC-SW@aspeedtech.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 trini@konsulko.com, sjg@chromium.org, kobedylan@gmail.com, 
 u-boot@lists.denx.de, Andrew Jeffery <andrew@aj.id.au>
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

Hi Jacky,

On Mon, 8 Jul 2024 at 15:37, Jacky Chou <jacky_chou@aspeedtech.com> wrote:
>
> Add support of Aspeed AST2700 SoC.  AST2700 is based on ARM64 so modify
> the DMA address related code to fit both ARM and ARM64.  Besides, the
> RMII/RGMII mode control register is moved from SCU500 to MAC50 so
> initialize the register in ftgmac100_start correspondingly.

It looks like these changes will affect the older platforms. Have you
tested on an ast2600?

Is it okay to be writing to the new memory locations on the old
platforms? If this is the case, please mention it in the commit
message.

> diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
> index 9fb8c12838..a909a0b309 100644
> --- a/drivers/net/ftgmac100.c
> +++ b/drivers/net/ftgmac100.c

> @@ -321,6 +333,7 @@ static int ftgmac100_start(struct udevice *dev)
>         struct eth_pdata *plat = dev_get_plat(dev);
>         struct ftgmac100_data *priv = dev_get_priv(dev);
>         struct ftgmac100 *ftgmac100 = priv->iobase;
> +       union ftgmac100_dma_addr dma_addr = {.hi = 0, .lo = 0};

You always set dma_addr before using it, so this zero-init is unnecessary.

> @@ -352,7 +366,14 @@ static int ftgmac100_start(struct udevice *dev)
>         flush_dcache_range(start, end);
>
>         for (i = 0; i < PKTBUFSRX; i++) {
> -               priv->rxdes[i].rxdes3 = (unsigned int)net_rx_packets[i];
> +               unsigned int ip_align = 0;
> +
> +               dma_addr.addr = (dma_addr_t)net_rx_packets[i];
> +               priv->rxdes[i].rxdes2 = FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI, dma_addr.hi);
> +               /* For IP alignment */
> +               if ((dma_addr.lo & (PKTALIGN - 1)) == 0)
> +                       ip_align = 2;
> +               priv->rxdes[i].rxdes3 = dma_addr.lo + ip_align;

Please explain why the old code didn't need alignment added, and the
new version does.

> @@ -394,6 +419,10 @@ static int ftgmac100_start(struct udevice *dev)
>                 FTGMAC100_MACCR_RX_RUNT |
>                 FTGMAC100_MACCR_RX_BROADPKT;
>
> +       if (priv->is_ast2700 && (priv->phydev->interface == PHY_INTERFACE_MODE_RMII ||
> +                                priv->phydev->interface == PHY_INTERFACE_MODE_NCSI))

Use device_is_compatible(dev, "aspeed,ast2700-mac") instead of adding
is_ast2700.

> +               maccr |= FTGMAC100_MACCR_RMII_ENABLE;
> +
>         writel(maccr, &ftgmac100->maccr);
>
>         ret = phy_startup(phydev);
> @@ -443,9 +472,11 @@ static int ftgmac100_recv(struct udevice *dev, int flags, uchar **packetp)
>         ulong des_start = ((ulong)curr_des) & ~(ARCH_DMA_MINALIGN - 1);
>         ulong des_end = des_start +
>                 roundup(sizeof(*curr_des), ARCH_DMA_MINALIGN);
> -       ulong data_start = curr_des->rxdes3;
> +       union ftgmac100_dma_addr data_start = { .lo = 0, .hi = 0 };

Same here.

>         ulong data_end;
>
> +       data_start.hi = FIELD_GET(FTGMAC100_RXDES2_RXBUF_BADR_HI, curr_des->rxdes2);
> +       data_start.lo = curr_des->rxdes3;
>         invalidate_dcache_range(des_start, des_end);
