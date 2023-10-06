Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C14E94115
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E9E86E45;
	Fri,  6 Oct 2023 22:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nJRzXLOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD3A86EB1; Fri,  6 Oct 2023 22:32:33 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F9B886ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57b5f0d658dso1418484eaf.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624350; x=1697229150; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dO+76Y1Q9n/rPbqM4HQYNBNzeVlLD5O2X7EAg3jqZnk=;
 b=nJRzXLOwD8f35HKwliDjTNhdXFf2fSlkBm6xAVebCDcuomBm6CDdOTlvjYrUQ/ZmRP
 +KsKnnWJNzUhBUud54ZbOUNaEIllalNKL2P7Qgidmw4rSuZdrokP6+23fKSTM+NqY/i6
 kx3hj/D9Eyu0NbaMEmPKWBfPLLOS5xtNzT0PvNwyh+28POYGnUkXtaWVfQCTl2phaL1r
 BvEfqTWDx17UJOFcpWhfVvUmy7JLTw4tDAJrhquTvS5lY06SUULRMMpSMmDs6uIgv80o
 vN7W6+lXGAQFNDkNVsyUwJtyV0n+7Dx/lIIoMnYA4So6wE/aTLjRokwD/Hm1UNfsC+jC
 ubNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624350; x=1697229150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dO+76Y1Q9n/rPbqM4HQYNBNzeVlLD5O2X7EAg3jqZnk=;
 b=a0y64yq+BLVa2AaQnxOiCyg0jzTRdfT+0J+Rq2k93C3B7vjJczpRKzHVcF0yUsic5J
 Qln+Ct8cfBMM7Z7NioOL4RedUHETarnCROvTjPGxqqHZ367TdkDW6NimHnWhrHmRTd8E
 f0ToPNgx9g1lSEFU3wWsjaznJ52d8zlQQunEgpQCureW3cfcKEXrTBPRelSLZw8zaERd
 /mf/R+dpJHQvgxWh2G0cNaFSyGRNwmSxugn8JjJg/vOo4+fVG3qyZlLdhwCAu91obI5G
 B+LZvWoyqIo7xiIi1NTjA1mxhQWsLzUY0UFoT5jWirOFC6Z4PvQeO1JI31NKcwqfBmgt
 EtNA==
X-Gm-Message-State: AOJu0YzFbZmZOWyg/aVj336C8KjwxKnuoYpPFSBiKHjVMYnE7/1flks2
 jG/M27C1x4JoQEQwPXXjTpcR7IPtsw6g7+DpOKI=
X-Google-Smtp-Source: AGHT+IEPCeNFmiR6xpN6GBWr/V6g8qaAnXAwMNa/10tLYVjvFe/MHpxOJcBASLKEeWUy3VZrI0YPsRzk4iNRrNvlxac=
X-Received: by 2002:a4a:e5d2:0:b0:57d:e5e7:6d00 with SMTP id
 r18-20020a4ae5d2000000b0057de5e76d00mr7937834oov.6.1696624349946; Fri, 06 Oct
 2023 13:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-2-jonas@kwiboo.se>
In-Reply-To: <20231001191730.4167035-2-jonas@kwiboo.se>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:32:19 +0300
Message-ID: <CAGi-RUJuy7bXXGWMJYD1UehdNtbT1b0hqgfCSXPBJ0RR-ftaDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] net: dwc_eth_qos: Drop unused rx_pkt from eqos_priv
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 David Wu <david.wu@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de
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

On Sun, Oct 1, 2023 at 10:17=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> rx_pkt is allocated and not used for anything, remove it.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> v2:
> - Collect r-b tag
>
>  drivers/net/dwc_eth_qos.c | 11 -----------
>  drivers/net/dwc_eth_qos.h |  1 -
>  2 files changed, 12 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 1e92bd9ca9c0..555eaee3bbc3 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1314,22 +1314,12 @@ static int eqos_probe_resources_core(struct udevi=
ce *dev)
>         }
>         debug("%s: rx_dma_buf=3D%p\n", __func__, eqos->rx_dma_buf);
>
> -       eqos->rx_pkt =3D malloc(EQOS_MAX_PACKET_SIZE);
> -       if (!eqos->rx_pkt) {
> -               debug("%s: malloc(rx_pkt) failed\n", __func__);
> -               ret =3D -ENOMEM;
> -               goto err_free_rx_dma_buf;
> -       }
> -       debug("%s: rx_pkt=3D%p\n", __func__, eqos->rx_pkt);
> -
>         eqos->config->ops->eqos_inval_buffer(eqos->rx_dma_buf,
>                         EQOS_MAX_PACKET_SIZE * EQOS_DESCRIPTORS_RX);
>
>         debug("%s: OK\n", __func__);
>         return 0;
>
> -err_free_rx_dma_buf:
> -       free(eqos->rx_dma_buf);
>  err_free_tx_dma_buf:
>         free(eqos->tx_dma_buf);
>  err_free_descs:
> @@ -1348,7 +1338,6 @@ static int eqos_remove_resources_core(struct udevic=
e *dev)
>
>         debug("%s(dev=3D%p):\n", __func__, dev);
>
> -       free(eqos->rx_pkt);
>         free(eqos->rx_dma_buf);
>         free(eqos->tx_dma_buf);
>         eqos_free_descs(eqos->rx_descs);
> diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
> index a6b719af809f..06a082da72ef 100644
> --- a/drivers/net/dwc_eth_qos.h
> +++ b/drivers/net/dwc_eth_qos.h
> @@ -273,7 +273,6 @@ struct eqos_priv {
>         unsigned int desc_per_cacheline;
>         void *tx_dma_buf;
>         void *rx_dma_buf;
> -       void *rx_pkt;
>         bool started;
>         bool reg_access_ok;
>         bool clk_ck_enabled;
> --
> 2.42.0
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
