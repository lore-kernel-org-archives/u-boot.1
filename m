Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29A2E94114
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BDB586E45;
	Fri,  6 Oct 2023 22:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YNVwZtsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2699586E45; Fri,  6 Oct 2023 22:33:13 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B2C786ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57b706f604aso1464812eaf.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624388; x=1697229188; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZELUnDcAVSEvo/0JCHqDS54H0pQZLaWlp91Y98Nz14=;
 b=YNVwZtsdkdTCB6hsI8e4nuF4fw53kkGbaR/3nBshDtytVKvT5sbr75vpAEoxpMoNYJ
 54MaL/ewsMQeAWCDribM0eHB5K/qUvdi2/8O+X6oE4w2XDVfwVZTtnE0VXsqydDBhb3T
 CDs6xSdPRVQem5XjSRarzlVlkWj98IFOBfLK9akl3hkXCaMW0o03tzJB8jaT44IIE0vb
 DgrRgSFhSytvUlwGWC1HFc87fIS3Gm0/Bls2ni2a7JdszsjlQOTSH2VtR0raWJjS/ZRE
 UwblolR3muakciR+AeIbnc/AhuEAocrfCGj43NPqToVl8lqM2qbtB4HR7I3uZHOuzNBD
 OIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624388; x=1697229188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZELUnDcAVSEvo/0JCHqDS54H0pQZLaWlp91Y98Nz14=;
 b=L7SY1BVK65IxW0txmvJOvvtIQB+E3dmUzJwuN9sfRP+MHqSPKC/hFOoaIpUckP1i+k
 c5cN3tt8meRxptTFe4uXGr14pCs9eOD3p7ABwS+MVHOQlGTy9ExKxtoNUEs7XyyWPt50
 PzTRsIjvivoCWfT7uunlmCuEXqNzQXt5K2tPd5dQkrcqXuMDly2WuxEAkMD7R6bXKOpK
 Tss4ZSgA9HQW9O/j1ZqHTZmkCrCs9EAuj8og4xOaOx+aJ6L5D6zekV60FYlEOHLfbS7l
 GbdRD8imTD+354iNS9RckkHx0NFfcRIoEBPggnv9O1OUhZrjfgI8LAnXBRywfni5A1KR
 VEVg==
X-Gm-Message-State: AOJu0YwVOC/WjgQXYf1LwsCuVhHf7LwkO+Caay8BTd8WR2N/eOe2VaL/
 Vld59sZVJTkWLCUNfzmrqsGtfpEk/FLCRFztXGM=
X-Google-Smtp-Source: AGHT+IEOO1nCa/wPX+HhvRcnUy3CpXhiVQ9kZRjN2OWzVw89Mk/3j04MDMpueoL/y1iNjW/z/PUmdskMlQfePCthJoI=
X-Received: by 2002:a4a:9c5c:0:b0:573:f620:ec7e with SMTP id
 c28-20020a4a9c5c000000b00573f620ec7emr8368376ook.0.1696624388106; Fri, 06 Oct
 2023 13:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-4-jonas@kwiboo.se>
In-Reply-To: <20231001191730.4167035-4-jonas@kwiboo.se>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:32:57 +0300
Message-ID: <CAGi-RUKQf4ioTVogCVTRvGMMgPNU8Pvui+xL1p98k_SzJrqB6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] net: dwc_eth_qos: Stop spam of RX packet not
 available message
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
> Remove spam of RX packet not available debug messages when waiting to
> receive a packet.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> v2:
> - Collect r-b tag
>
>  drivers/net/dwc_eth_qos.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 7565e716823a..24fb3fac1f12 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1193,14 +1193,12 @@ static int eqos_recv(struct udevice *dev, int fla=
gs, uchar **packetp)
>         struct eqos_desc *rx_desc;
>         int length;
>
> -       debug("%s(dev=3D%p, flags=3D%x):\n", __func__, dev, flags);
> -
>         rx_desc =3D eqos_get_desc(eqos, eqos->rx_desc_idx, true);
>         eqos->config->ops->eqos_inval_desc(rx_desc);
> -       if (rx_desc->des3 & EQOS_DESC3_OWN) {
> -               debug("%s: RX packet not available\n", __func__);
> +       if (rx_desc->des3 & EQOS_DESC3_OWN)
>                 return -EAGAIN;
> -       }
> +
> +       debug("%s(dev=3D%p, flags=3D%x):\n", __func__, dev, flags);
>
>         *packetp =3D eqos->rx_dma_buf +
>                 (eqos->rx_desc_idx * EQOS_MAX_PACKET_SIZE);
> --
> 2.42.0
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
