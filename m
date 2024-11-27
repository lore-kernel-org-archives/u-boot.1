Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CFCD6ACCA
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D498E89801;
	Wed, 27 Nov 2024 14:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NlNDdp5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEBED897E8; Wed, 27 Nov 2024 14:07:53 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC56897EC
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso947966066b.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712871; x=1733317671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bc24rL8XW6bjOgpvS/Gb2w4YaFaTigb+wMDQBxnk5Zc=;
 b=NlNDdp5M5Gz3hLPy0Ftc6hg9RdN8hHIQOKo2Bjb1NOL+ev9BKcrc8CHuiCJG16WXHM
 hdFr0H/FteOFKpvSr7q8QetdLWviQwebJwbw/8fllBmMVsT94B/cYXB+1XHTnc+DCDyE
 i9MbHaamwQrYpXWxYStBc1Esqp6+T+yivfkS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712871; x=1733317671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bc24rL8XW6bjOgpvS/Gb2w4YaFaTigb+wMDQBxnk5Zc=;
 b=gt0dBbaqrOVIswYLE7DJP1KstNmM9esQW0MdnNiDKapwASEmTDHa8TSop7mfSuuKN8
 rx/IEnmprndAAcACOVjoswW5o+OEFZ+NNFESjln7H6akQf52C00Zbgjnli60MCDeKsvC
 D8KWTQBjwxiPDJ6NePTPDo++PZgLC47Bo3RmnHEIEDQSi9vhyMAG1YMpMg5aMzJHXbUp
 ZyFX+bZPBietV/4ODplS8iLhUL0624XrFksLfx9WDEalUC5mwpIfSbvQIQkPp6VpryyD
 H97VolfzAP9cW0o5YdFWcdZC/7eRkdQI7MmOOkpqiMYjSrr//lHig6H7ykDw7oEcT1HE
 9O3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU7Zg9VZrSBo8zkidi3zo0q0mlgdZbdjxjwrpaNQgtkUAWHPfolbWAo/kCj6ZxALLtrJyr0K8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9goO5I1hWQ4ZKlKcPuqUsd6EhgdbKOVDmt9SoNvlnC+Fowa4j
 x7raO80E7ToahZ0rmWReZBGtKKqnkRV/IwvXwc+MNG8EUOc5Bht6SJuQNlG0tVE6MipfMdx5RIQ
 ruO7yosLYPNRUA3YhhnpI7Hw9jjSVQlvvG09t
X-Gm-Gg: ASbGncsCXuIOi6yBE7FX2Cs9UvoZEE7VzNvlIQgzyKIMYe0xboIbWfBAy3SCU8hFBIQ
 5iznYcpYYDc7gdxPjDvC/rjGtLIrHTUU=
X-Google-Smtp-Source: AGHT+IFjqrUvR4rc7ND/b9ZV6iSnuP90u0FoBGxUUxlK3B+wKd2amtsuEbflbh+VQcs/44obqiPJmvJ6Yp4eybbymB8=
X-Received: by 2002:a17:907:254f:b0:aa5:2d9a:1528 with SMTP id
 a640c23a62f3a-aa581065a85mr170569066b.60.1732712871352; Wed, 27 Nov 2024
 05:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20241126105131.43359-1-g-praveen@ti.com>
 <20241126105131.43359-3-g-praveen@ti.com>
In-Reply-To: <20241126105131.43359-3-g-praveen@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:07:32 -0700
Message-ID: <CAFLszTiM9RsT87O4Rts9+B2iGEgoVLK6Kmdg0DQ5cJBOuT3xqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: serial: serial_omap: Fix TI OMAP UART U-Boot
 driver to support higher baudrates
To: Gokul Praveen <g-praveen@ti.com>
Cc: trini@konsulko.com, rasmus.villemoes@prevas.dk, sr@denx.de, 
 pbrobinson@gmail.com, jonas@kwiboo.se, u-boot@lists.denx.de
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

On Tue, 26 Nov 2024 at 03:51, Gokul Praveen <g-praveen@ti.com> wrote:
>
> Move to OMAP specific implementation of certain ops functions as the UART
> prints on the serial console fail for baudrates greater than 460800.
>
> The MDR1 register is responsible for determining the speed mode at which
> the UART should operate for OMAP specific devices. The baud divisor is used
> to set the UART_DLL register which is used for generation of the baud
> clock in the baud rate generator. The implementation logic is similar to
> how it is implemented in omap_8250_get_divisor function of 8250_omap UART
> linux driver.
>
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
>  drivers/serial/serial_omap.c | 56 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
