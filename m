Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A53EC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 07:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CA28212A;
	Tue, 15 Apr 2025 09:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CnLYGaYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA368294C; Tue, 15 Apr 2025 09:40:43 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666A081F0D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 09:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e7040987879so4747576276.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744702840; x=1745307640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jo7PpOPZWyEFsH7UZciirN31NNJRB/QiwvVZMHdlGNE=;
 b=CnLYGaYMUMQ/Zk2OcAPrc0v3k484cujnNSobGHXlHZ5kA+CTjHzSK/hQPgjnkiIytk
 e4DFlPvu6Uja/UWnGXZbqcjkmNV68cofYhglMYC0etYHqnCx7Mc1y+mQew3Pv7nuXA8v
 ZVpqXvnBRHS+iS2riagE6R5+JUAONsupqiIIo+1uJy192lLIkkTaB6vI7cCMIsVzlZYP
 zO6AHY7atAkwuD3gEdJgQE+1hRM8jZ5QECeCSTjX9q/i/FxoIcdLuC2ej5ocD/yWU1tC
 OGGzS2TCUyRDI8EDzgXApknAuf38xB1AW27zZu2t3UeoLTg9uB6WgHyiX0R0YgDq69dg
 zUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744702840; x=1745307640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jo7PpOPZWyEFsH7UZciirN31NNJRB/QiwvVZMHdlGNE=;
 b=JJwccwkXjumKHJtFMtbOZgWBVKi+KUAkQ7PI8eX1o4ACPw+R9SDZE1/Uwba1d+gFYF
 cdeZZFX57FilS6LOWd1v2XjDlFwjhaSh9dlQHjZvegGwsn3ipjl7fDCTkuEsLIHUhNij
 zNiWHCql4WzuFS5GVtef5pwkrHze2KRkNveIY5nlzEJ4F7svkaD/WjKf2HYk5P4vSANY
 au7D1s/eWgxeps3MroNzKnNzsV8KLBmUD1Kd9Xdqh+F2vvUY09ILlBFLkFEVczTBlrto
 qJ0v3tjtUvHMMuIeGiNHUvSMeFNHSFLLRxezmartFOlx/CUmQxUsBXmaiUo7dKAptNFI
 qMwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYxVvu+jJY/xH5+WmJYa+fFsLIqRcF8D7ftQWwo43Imcnr8Off9kNsG2KaC0wOecYWfY4KQms=@lists.denx.de
X-Gm-Message-State: AOJu0YyXU65vhONYLAhc/TL9meJ3hAyxrW+ySEargj1JuKMU1MvDlLz8
 foDp1TWHaqNdSdDNk/PFX74FhpUkriX+pO846E3Cz6+f1Fc71tkJCKmGPWbNGNXC+vG5CE04FlV
 ZUll8oYHjPPlpN81EkvL8IzC/3N9LQpYGeJdEWg==
X-Gm-Gg: ASbGncuZQG78XcFo5uzC/i8UVzNw4amgr3VuNUHC0qc1ypB7NjEoAxxoMB9KWQta7ss
 Eu8MvbSMZeAmygsoYZqKi1sPivnzoHOuw/c9+U65XwpXsoqGLCwujDWTmD0m3g3Jw1EjxH3hvF5
 y5OW+3Jkr+D94eGRXH0VtrMvI=
X-Google-Smtp-Source: AGHT+IEMNxXQToCnyKh8+9U0C6uLRNq8e6ayPMDmGNYxxi30ARxZ+21Qvrf42+C07U/lqOvF+tnV5eq9OierEEwAbq0=
X-Received: by 2002:a05:6902:4802:b0:e6e:5ef:a090 with SMTP id
 3f1490d57ef6-e704df62aa9mr22951569276.34.1744702840193; Tue, 15 Apr 2025
 00:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250414135506.87892-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250414135506.87892-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Apr 2025 10:40:03 +0300
X-Gm-Features: ATxdqUFvOQdB-uTl4yYzz2PaLoO6VhBsQiBhj-PAfJsen96GJs8CWYd3QZkOycQ
Message-ID: <CAC_iWjK+uRwWxgv0ZQjR-DYihvt-kPRPAEc8asneoXDBOv-6DQ@mail.gmail.com>
Subject: Re: [PATCH] net: make initr_net() invocation command line agnostic
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

On Mon, 14 Apr 2025 at 16:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> initr_net() initalizes the network devices by calling eth_initalize().
> There is no good reason to disable this if no command line interface is
> present.
>
> Let initr_net() depend on CONFIG_NET || CONFIG_NET_LWIP.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/board_r.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 62228a723e1..0b1dbd4196d 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -482,7 +482,7 @@ static int initr_boot_led_on(void)
>         return 0;
>  }
>
> -#if defined(CONFIG_CMD_NET)
> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
>  static int initr_net(void)
>  {
>         puts("Net:   ");
> @@ -747,7 +747,7 @@ static init_fnc_t init_sequence_r[] = {
>  #ifdef CONFIG_PCI_ENDPOINT
>         pci_ep_init,
>  #endif
> -#if defined(CONFIG_CMD_NET)
> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
>         INIT_FUNC_WATCHDOG_RESET
>         initr_net,
>  #endif
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
