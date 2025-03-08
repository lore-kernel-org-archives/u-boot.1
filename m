Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAFAC28B28
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 07:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599528141E;
	Sat,  8 Mar 2025 08:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LHsofl8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7317D81417; Sat,  8 Mar 2025 08:51:25 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D99780F6B
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 08:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e60b75f87aaso2040791276.2
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 23:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741420254; x=1742025054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=44/f21WR4nXCTmXyExL+le15Vn24mFAwqbrZDiLEvo0=;
 b=LHsofl8PzmWHFmUT6KHMfPvCyUBF1CG8Vq5ohfk56KoBKSrOrSfq4pwj/gG3mHDQdd
 HThpmPvAQw+I1ThyH+2AHUNYXRO+50CLnym2SwDPw33OcSCOS/oA/Ptol52Ljm51rDOU
 BmA7znglv0L+CXuXULDSF+1nms3797DiNRNYN3GosPjATpIoSjMbkSH32LDkPfkFQ3Sl
 lsnXUhoR7xUSQ6McWbHTk7QIpo6B5o8I4DMUXFI4tUkE8hTUEO3Ixo0FUn3YjPYF9awt
 EeeqIT4ldOAafBLm1FqpB7c31x+M4vW7MGC+eEfQoPGa8YPpAGWUx1z4lHHa19XpzE3K
 KuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741420254; x=1742025054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=44/f21WR4nXCTmXyExL+le15Vn24mFAwqbrZDiLEvo0=;
 b=ujr9gIuKbSnrG6iCfSMOgunrUGL4knz+qQbkOv5oAMmgvZ/V0aUKJ/xzoFWZrjWVay
 YASqCw6uknggo3PaVUtjSxpY0OvqIrEGUe5xcw+71jpyjJYZcLg11V+viVlv4UQPDCX6
 Skvp+KWI/Ak5uuJl1h5kq4gf5MLZTm3iRd6AB6f2QCKACYMPDd1WMrHn3Pz5BPdCCsQo
 lm3OaG7qTzrGkuaYVgIK8VzE82lZCVACN1wf8JPW3fwDVGFQCvoemrIKyBf9c8RqbSNF
 ZqBmdL+XuWL6ZYUGljR5W/Vhh9M3lj5I5BGVufPmHde1WRw460VZ/aqzPxooRK/jVUEo
 XY0Q==
X-Gm-Message-State: AOJu0Yy3gtoUcGXvu8YN5xNwLI96F8gH6Q9hyVB2m0WdbNqKFODNE+QA
 +DQCne6c/Cx907Z4BOCkRi1QAZQUFi8ltBzCT2e+GHIl4EDWBWaQNV1VQipVOIIdA2RlE9cVdXy
 pQuFxVD47+fpIuR2nnDc9bSRFXUhfybhjkm20+Q==
X-Gm-Gg: ASbGncumihCVyf+hsGgt5l34HeWrdWddKUBYZXyzfzmigwMWo3bB05oNhBY1vg1CZhD
 9NzqaFcT8j630HpH9dwlaFzGvzdzzx+xj5x1RI4D+XMPjMcw/rP0gNnYLlLVx77bJtcC7kATqbm
 vNo0vXzCznEthXPnx7BolhLdj3StA=
X-Google-Smtp-Source: AGHT+IGZFBScYqyJKGpjekStC6pJIGpvlAjdc+PzLn3RB+LQNpVkturwQXiWBpZ04+1OIT7fIDM0ZGSxQmuSxPo2jCM=
X-Received: by 2002:a05:6902:18d2:b0:e5d:de80:e6bd with SMTP id
 3f1490d57ef6-e635c1dbf2cmr9198118276.34.1741420254357; Fri, 07 Mar 2025
 23:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20250306143224.3080316-1-jerome.forissier@linaro.org>
 <20250306143224.3080316-3-jerome.forissier@linaro.org>
In-Reply-To: <20250306143224.3080316-3-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 8 Mar 2025 09:50:18 +0200
X-Gm-Features: AQ5f1Jr9JsunuzUR1OGPD6OmwU3lonSX9qDBcGSkIujfzvql3IZ6BHt9AXaJT1E
Message-ID: <CAC_iWjKFv_C_an18ci2p8jP9kMbzVbLwwZ4MVofqHDwSGN7z1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: lwip: add CONFIG_LWIP_DEBUG_RXTX
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On Thu, 6 Mar 2025 at 16:32, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add Kconfig symbol LWIP_DEBUG_RXTX to dump the incoming and outgoing
> packets when NET_LWIP=y.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/lwip/Kconfig    |  6 ++++++
>  net/lwip/net-lwip.c | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> index 40345ced9c9..d28a8a7df94 100644
> --- a/net/lwip/Kconfig
> +++ b/net/lwip/Kconfig
> @@ -10,6 +10,12 @@ config LWIP_DEBUG
>           Prints messages to the console regarding network packets that go in
>            and out of the lwIP library.
>
> +config LWIP_DEBUG_RXTX
> +       bool "Dump packets sent and received by lwIP"
> +       help
> +         Performs an hexadecimal & ASCII dump of the data received and sent by
> +         the lwIP network stack.
> +
>  config LWIP_ASSERT
>         bool "Enable assertions in the lwIP library"
>         help
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 5a2a86686f4..c00a7fe97cd 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -5,6 +5,7 @@
>  #include <command.h>
>  #include <dm/device.h>
>  #include <dm/uclass.h>
> +#include <hexdump.h>
>  #include <lwip/ip4_addr.h>
>  #include <lwip/err.h>
>  #include <lwip/netif.h>
> @@ -36,6 +37,12 @@ static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
>         void *pp = NULL;
>         int err;
>
> +       if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
> +               printf("net_lwip_tx: %u bytes, udev %s\n", p->len, udev->name);
> +               print_hex_dump("net_lwip_tx: ", 0, 16, 1, p->payload, p->len,
> +                              true);
> +       }
> +
>         if ((unsigned long)p->payload % PKTALIGN) {
>                 /*
>                  * Some net drivers have strict alignment requirements and may
> @@ -265,6 +272,13 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>                 flags = 0;
>
>                 if (len > 0) {
> +                       if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
> +                               printf("net_lwip_tx: %u bytes, udev %s \n", len,
> +                                      udev->name);
> +                               print_hex_dump("net_lwip_rx: ", 0, 16, 1,
> +                                              packet, len, true);
> +                       }
> +
>                         pbuf = alloc_pbuf_and_copy(packet, len);
>                         if (pbuf)
>                                 netif->input(pbuf, netif);
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
