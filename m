Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2A4CF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7F9891FE;
	Thu, 19 Sep 2024 16:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iPxi2gyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F168C8919B; Thu, 19 Sep 2024 16:10:38 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA858919B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71971d2099cso696738b3a.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755033; x=1727359833; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ERaQOfgg2MvdDNSK/uRdQUdqBpnjPR4L1y4bt60XdTI=;
 b=iPxi2gyDVzIpCnkhlJ5IwBA9c+dp+tH/Fz5tks0blFurM0Fa0Nkv0A2jWkU0AjrllX
 IRxR0QX8TtMl+fe95qySrUdoAGL/Lk/G+UoE2bevDY/E1Swq2KpjpCuAdG926r1u+Vkq
 Ca6ANb+RYej6YCGoSwYnUXaLVzMB7PgcqwRYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755033; x=1727359833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ERaQOfgg2MvdDNSK/uRdQUdqBpnjPR4L1y4bt60XdTI=;
 b=UdqTLVXzwLw9Tamdb3x+mQwHZ/unNMgxzwXx0j9XX6gIaXe/uuoGj8ZuK4m3P2vY2u
 GR64aLfknsUxMWnq/EwyTSfB//0ccXmHVot2Lzd6djTVFZrx/XE+OcXokKBi8CuE0CCu
 iSbZDpqgxrbX8JWRfLMlBQOPQwZohEu8IKtxdNNc/QhT1eBV3YOGIsOodgNJD1aCv7A/
 z3ZHBivHX7SrAPrYP6iUGNEo1iCZTiO+pl2Pdmq8XJSqofL/a5VovqvGBzD4GGc9gsQE
 0MMB1xa7STDqjeBZzgw2h4IYVwJ/IcFcoNOUyvCoPuHWNaxd1qjstkAVkc6uihY9zXXe
 Vleg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/RZf9lcVCEp3Dbomj/5c4PmAYyVo+UDMQJ/MrGZpKUoTTfPdeWi6b/x1SlC7jGvJkLVC29Bw=@lists.denx.de
X-Gm-Message-State: AOJu0YzI1jdhnZiOvC5XXUjP1oL+lK8wL6q5M4Bx4so33T3t//j+tSCP
 J3fxkIg5RPHqlOMRn6qDH2aZuZcOyYGDCrs+vOrsOh+d3rDyngXogGnopieuLFUmrYCHnWruJQS
 w4b3KybXoduGooD/PdJ8u9P9XLcUwWUrDQhpAaWzN1xHWIalS08WwJkM=
X-Google-Smtp-Source: AGHT+IHn4E1/QTvAVgOlokgX6uu9cEh7T3Y3fyFhGekOjXcDDUXFwveYLzGtWvhCQSinw7c4kG4eURPPOedEBSm6254=
X-Received: by 2002:a05:6a00:1906:b0:717:8cef:4053 with SMTP id
 d2e1a72fcca58-71936a5dd71mr33616515b3a.14.1726755032590; Thu, 19 Sep 2024
 07:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240918220113.22247-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918220113.22247-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:18 +0200
Message-ID: <CAFLszThoMmbDaxMWREqDwOG7=w3=0yp=ELZ72Aq-x-w4OH6sTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] events: correct event_uninit() description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Thu, 19 Sept 2024 at 00:01, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The function name in the description must match the function.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I suppose you are really fixing the one for event_init(), but it doesn't matter.


> diff --git a/include/event.h b/include/event.h
> index fb353ad623e..75141a192a4 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -385,7 +385,7 @@ static inline int event_notify_null(enum event_t type)
>  int event_uninit(void);
>
>  /**
> - * event_uninit() - Set up dynamic events
> + * event_init() - Set up dynamic events
>   *
>   * Init a list of dynamic event handlers, so that these can be added as
>   * needed
> --
> 2.45.2
>
