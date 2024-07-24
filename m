Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F97AC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5A98897D;
	Wed, 24 Jul 2024 17:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D+eXn+iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4B3884C5; Wed, 24 Jul 2024 17:20:55 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A73B88937
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef2cb7d562so48313451fa.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721834450; x=1722439250;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QSGUZZbbKDkpqEV+Ly4w6YAML9aM7TYeUoDFgCCc0dY=;
 b=D+eXn+iGPHlH+wAfyrlBfJduSbfm9Od6hrQiqhUqQVsPIprC2vo/Wf/cCuI/kNZuJe
 ehQuMy4Im0unUiZ284UEGQR1wXLrDEIY+oaXZutX1WbwZ4LvJ+jCjaFc2MvQGfU9nymK
 m4raCnig7zrNXQDIS4WjjJvlTLwPxwzv3/dI/wERPF7T4hCdUekZCDTZLGLie36+GPwV
 i5HUnPPfgRXGrMspYrWA9uQLxrSyvOd0tf4zP9jIjKWtXcy7A9VOSMvO5jyClj8R/Vk4
 nww80OZcstriln2RlExqj//H3izm6BIoOOGa/pUwDyI9W5ZNV0jGmBqAl3NgTbzqCTYR
 LAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721834450; x=1722439250;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QSGUZZbbKDkpqEV+Ly4w6YAML9aM7TYeUoDFgCCc0dY=;
 b=s911xoQHwePwNfTh0jKrlM15eyDIh4SPUJEdSdjBTkKS520Z2v56jKygsJejbTRVJI
 AM4sQP0P3tt27T92UQkBDp8h9VbeVo2ZJv6+TD+oCA2bj1oHSQ3s927gl6XDEv4SvTTn
 K4xxdG5IpKebufE4w/GSi16gwk1obGcl7xjNumoPSGjSxx1WRDCo/8r3DVR7W3cFN5yb
 IoOBteWYcRXV73dOXjt2Men2bAEg5Nez/34T1fNkr0I7Qk8bxTFThfGwC8f65r2uPjQz
 SFjOywa5TDJ8JOWLjybu8BfjSiKCqKAesBwEskSWax5TA+iATflX7ayaqARHoA8M3uwg
 WooQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvTQxBRk6SS+r6vUUTTFVSCzpb65qC+W0v6VBsg0Yh8wKC7w4iBXBA6aXYWY5YfxpEazm6A6qlU861+LWVvPBBtoLnlA==
X-Gm-Message-State: AOJu0Yzfsf8x90VbHTSTqS/bnQ+BDeol97XA7PWadUfxeeBY5YHTeUaS
 Rvb3bGSF2cJsvcqYDhSK6h8MmLnOJMquK7hlBbe76p9o44cWrTliaDohpxUrfNc=
X-Google-Smtp-Source: AGHT+IGSboeI3GBgOTboQs3cMG7S6/OOHmlaL0MmjOkNNMB8GWsHL8JqIaejKZ0yUD1OjOKbFDHbeQ==
X-Received: by 2002:a2e:b009:0:b0:2ec:5933:a62c with SMTP id
 38308e7fff4ca-2f039f15b62mr783501fa.22.1721834448859; 
 Wed, 24 Jul 2024 08:20:48 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f937e274sm33691545e9.14.2024.07.24.08.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:20:48 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] usb: dwc3: invalidate dcache on buffer used in
 interrupt handling
In-Reply-To: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-3-58a5f026ea8e@linaro.org>
References: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
 <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-3-58a5f026ea8e@linaro.org>
Date: Wed, 24 Jul 2024 17:20:47 +0200
Message-ID: <87le1q4y0g.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Neil,

Thank you for the patch.

On ven., juil. 19, 2024 at 15:56, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On Qualcomm systems, the setup buffer and even buffers are in
> a bad state at interrupt handling, so invalidate the dcache lines
> for the setup_buf and event buffer to make sure we read correct
> data written by the hardware.
>
> This fixes the following error:
> dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type -1
> dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type 4673109
>
> and invalid situation in dwc3_gadget_giveback() because setup_buf content
> is read at 0s and leads to fatal crash fixed by [1].
>
> [1] https://lore.kernel.org/all/20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org/
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/ep0.c    | 2 ++
>  drivers/usb/dwc3/gadget.c | 2 ++
>  drivers/usb/dwc3/io.h     | 8 ++++++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 0c7e0123368..fc1d5892106 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -743,6 +743,8 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
>  	if (!dwc->gadget_driver)
>  		goto out;
>  
> +	dwc3_invalidate_cache(ctrl, sizeof(*ctrl));
> +
>  	len = le16_to_cpu(ctrl->wLength);
>  	if (!len) {
>  		dwc->three_stage_setup = false;
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index d41b590afb8..0bc9aee4daa 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2503,6 +2503,8 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
>  	while (left > 0) {
>  		union dwc3_event event;
>  
> +		dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
> +
>  		event.raw = *(u32 *) (evt->buf + evt->lpos);
>  
>  		dwc3_process_event_entry(dwc, &event);
> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
> index 1aaf5413c6d..7cf05203b0d 100644
> --- a/drivers/usb/dwc3/io.h
> +++ b/drivers/usb/dwc3/io.h
> @@ -55,4 +55,12 @@ static inline void dwc3_flush_cache(uintptr_t addr, int length)
>  
>  	flush_dcache_range(start_addr, end_addr);
>  }
> +
> +static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
> +{
> +	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
> +
> +	invalidate_dcache_range(start_addr, end_addr);
> +}
>  #endif /* __DRIVERS_USB_DWC3_IO_H */
>
> -- 
> 2.34.1
