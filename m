Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98423CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 18:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7845B8466E;
	Sun,  7 Jun 2026 20:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cO6/UO2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2B7846C3; Sun,  7 Jun 2026 20:19:27 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5C9840ED
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 20:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68c76fb8009so4388905a12.0
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 11:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780856365; cv=none;
 d=google.com; s=arc-20240605;
 b=c2vlNgRQs7TVbwQn0mBdkxyYrq9PU5p7Yn17BPpV+ow9bR+/Uch11vlhdHgFbZVCaS
 MVpfkNf75mATlOKesjo+jvqWZPMIpO4mIRiSs59sXh6MKeG+CJ8cRi/f7H4z7B0ku+jV
 wrbmVPO5aXWx00kE7kRRKj8w4OPWywTowCpmbSQYoJdE8NH8T/eDocJ/T6pVx0V8Xz3B
 0ayOp8XB0Fl8VI1tbXn9sNMwFSQSr1+PccFuH41Ct/DbZQ2dUHoPHLwuThvmVPtu3Nyi
 gxQeixUAAwK+rJoULhh1IPe4dhJrdGiUypu4LVwAgGMc+JWpCphNi2rAtC7LHy0VjKZT
 Hlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EhHfAHknjAUWkv/Nyb4IzcIErHnSYLzGAZkzk1uVGmg=;
 fh=THJ/RYamQGZmI2KzTOqRxrDr2f75emXK24xzMlqWK8s=;
 b=WGXXJkjjbOVAwQ3HYwsdVSeNVvYr6k4NoaE5P8WF/t8BiO0g/dbxNMeLjTpt2j52wO
 ggzCClxv3MMDKM0QP9u+IymYdktQeGUYWLINar7LCrvzclvqIeKKjpEWQ186Gx4C7TNF
 K2DzJgrJS0QTaQDWBuAeBwilgHVr9FkdbPfV8W7b/RR+NMke5x2wLue73xesHXVApivx
 m0CnfCq53Sg8h57d2+xByrWuCKugGZ8xwzwewrCZHsbjpwOUn3Y3T61LHgEmSulIGdwe
 vH4fLjGeWMI4qAR1T+xz01lqlYCtRbXtskdP+BOFDGKlm/+QLr6jAB1pw7pZnHQ4wauL
 bEzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780856365; x=1781461165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EhHfAHknjAUWkv/Nyb4IzcIErHnSYLzGAZkzk1uVGmg=;
 b=cO6/UO2WKThRcTRWka5SzJYgcDfIC/dRvr7M0u435Qfzz6kaSWsLqZuWNabb3LOI7H
 PqZBCxeGv25B8DQBBUneCLucrSCDXddmVKx4f3XujQtVufaBKJziPmJfrEZws43ThaEN
 XmjHKk/P/7TjR8ryuAURtLdzFsQfDjRLSr/qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780856365; x=1781461165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhHfAHknjAUWkv/Nyb4IzcIErHnSYLzGAZkzk1uVGmg=;
 b=J0HqmSaZ6+utRpIITfXm9GBm/wHDXSv4ylPMUfrQ/iwgEXIE5+py/KWj0LAhOfkI8L
 JUE18nmjp6nyf8xQok1tyBsC7QaMH6OnRm0VgjEIGwNObzjMPKwQrVaEbXrlymgi2fHQ
 tyk7hprEH94URWuuHFOndnOqHDNWhYPN6G/pBjPnUdbu4eL7QDuUE9Xu0Nz/vzQ14QAw
 /v2EwKpcuvRBK9F7PMJu91uGsK3t35pJVWvIW259ApEKO3AXuwFJUElJYrMJH7MbH9Hr
 t4UrkTgdDnNQT9+egv1Cms6cjxznw++RX/5mnbrbUd2iLzg4Fd0FNRFdL+spKaVVj5lP
 3eYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iRFwn9hP6gu5QnZ9rJtZLWUr2D5lzi389LPxiTg3NNGTTWSQK/Qo4aDl4AM/qTDmEWyk6jCU=@lists.denx.de
X-Gm-Message-State: AOJu0YzituFCpVZaz6fntVqw1iqBleapuLR7LnJYGXmlvKgEglmrg1mL
 UwsNzPtd1f74Tkt1LRorJQvpvk93vKRKLjANpekif31cwfKZ9uZaAT6U/UpI24s4BlIss0yvlm7
 aooTfy0PZ7pCOGqCA+S59i/K2XxSBa95yfeFiKMQo
X-Gm-Gg: Acq92OHHuW5+K9zR1s0YQhE+JQSdHfjCTqnGdbXOlf+dSqyKF+y+p92JmQbhMzL4D9q
 S0pwO9zcY0b4WP4PG5zqvNrVfoh33nlZ/wjaq9k/63TpCZLHMActDddo+hO2JL8gUWXkkQQfR+s
 ilyVmt8oIwVFlJnureCXj9ks1iRywHm7X7L3MjqOJDF0WBJdMKoEuo21N7HUySEs4p6YFQa1D1j
 2ciKmFBIedwZfZM3qFkoTip+a7pv1IiFY+bIfoU3udyOVij8m7p5Da/l4PiI6zc+Bml0w4keFnO
 I8NggMsZ6nO/Z8jU
X-Received: by 2002:a05:6402:35cd:b0:68c:388a:ea57 with SMTP id
 4fb4d7f45d1cf-68fa4c085e6mr5353809a12.1.1780856365115; Sun, 07 Jun 2026
 11:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20260604073719.48723-5-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 7 Jun 2026 12:19:07 -0600
X-Gm-Features: AVVi8CfXkfdSq9EAC9WzJXbIGMkw6BbxMC9bX8BWPp_U1GB5-svMWX_3jyyBYBE
Message-ID: <CAFLszTgAX+JU38acxpYrjfP-MGC-A8bg3-=z2cB7x5tsYUUwUA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] rpi: Add a local get_effective_memsize()
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Ilias,

On 2026-06-04T07:37:05, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> rpi: Add a local get_effective_memsize()
>
> We are about to change the place we call dram_init_banksize().
> The goal is to have all the information we need to pick a proper
> relocation address in gd->dram[].
>
> However, the RPI boards, and specifically the tested rpi4, seems
> to hang if we relocate anywhere above the address returned from
> bcm2835_mbox_call_prop().
> So store that address and return it on get_effective_memsize()
> which is used to calculate ram_top.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> board/raspberrypi/rpi/rpi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>   # rpi, rpi4

Regards,
Simon
