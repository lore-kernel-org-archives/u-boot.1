Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730C4D75E35
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 12:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033228981C;
	Fri, 22 Nov 2024 13:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="olQvGKCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF328981C; Fri, 22 Nov 2024 13:37:48 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCEE89339
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ed91d2a245so68361a91.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732279064; x=1732883864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z0I/jA8ywQPllrufucrQQlD4/0ryz4APriBBlzykFQo=;
 b=olQvGKCBZoVtqZUMYz7avzC8uLO+ey62eShTKfoiKTv8VWwP+LjZO16pgDViEPiVPP
 oVSJ4lqvr7TRpTE2NcdBkO2OWy2oFXDyYC5DBKEqHt6XTaZA18hTqz1tKAsX6FW0EHB4
 IlsLX9WXeGT4uvAL3yZVXZAg5+qoGnefjrkqJ6IbFmvOit5dw+iJ9MbBXGFwJsTTXXLg
 WS3YMUk5+Ug9CON7jhoh+zDSYdE+UhpwuhX3ADSP5RVmboQfRt9/8Et0mZs/CX1Ub/Pe
 FsqHuzEVuw1/h7Kt4KJrQvQ8h53O3k+zYu9MRZvJ4EMQSOtb5rUZtVALI5Jsal3UNvsy
 uPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732279064; x=1732883864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0I/jA8ywQPllrufucrQQlD4/0ryz4APriBBlzykFQo=;
 b=VCJg9KvelK2+du2itUWVUFZMFBoZaK7svpAMwaVzUQNIjeNVD66yaqdF8xSeoM6CiX
 fb9yys1SqZro4nuxlrO5l3jzms3ibOnElmay+1jwaajZA1In/VJEYYf5FF4WYYJF4ide
 Ee+x5f9BYJjOV3NLAn4WmN0HTs6Jh8P8XJ/V6mHfJyTe0cOhc83k5uWD7hI9QSbV3OS4
 IRyegWrsz7Axe0e5ebWzIXHmF6D80769z1eTxk4G2EGlnp3cl4QwFIxq6vGeSbH+g5Jo
 yGqyO78X6zC1EYP+veUTHEEcGZvywjsCfT/cS3y9ecGDzasTPWveA8WY1vUyVuhaWrYP
 L0Rg==
X-Gm-Message-State: AOJu0YwjipJog9zEgf58HNKCTiVMhRyAyQYSl9zHp3liMljxTHWob/Ka
 2NYIDirl6AzPY/3qPMQPAOX1JwcVpBPXS4D/E0D6crYUgXpTBvGPBbPwLuxoZKgQWOcusliEQO4
 bsPK68+5nL3DrAe2qLNQwen9nTaraatdLHADAUg==
X-Gm-Gg: ASbGncsRT3iR7tEXl42gYRI9kAnwVbNDarv9PRHjMXdgfJgui2PuxTqS6VXkMfqmBi8
 gBjmjR5tekEgI9TjwYaseTCk5v+BQnQ==
X-Google-Smtp-Source: AGHT+IHAf0wzkK1Fn+z9uV1kEGyzOlsyxXoMS8+rFehcPFnW6jFtkC/vwYXa4tPVuVVaZj+UROP1S6R2YizEwja23/g=
X-Received: by 2002:a17:90b:33cb:b0:2ea:5823:c141 with SMTP id
 98e67ed59e1d1-2eb0e22ce72mr3191717a91.16.1732279064255; Fri, 22 Nov 2024
 04:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20241122123558.74702-1-jerome.forissier@linaro.org>
In-Reply-To: <20241122123558.74702-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Nov 2024 14:37:08 +0200
Message-ID: <CAC_iWjKvaai-kraH=NXrzDAtZYJSrr1GV3520KbKGy+3zxx7HA@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: fix dhcp_loop()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Fri, 22 Nov 2024 at 14:36, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The local variables ipstr, maskstr and gwstr in static function
> dhcp_loop() cannot be pointers to read-only data, since they may be
> written to in case the device index is > 0. Therefore make them char
> arrays allocated on the stack.
>
> Reported-by: Ilias Apalodimas <ilias.apalodimas at linaro.org>

@
But I guess we can fix that up during merging

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/lwip/dhcp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 23b56226921..bfc72ca6c57 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -27,9 +27,9 @@ static void call_lwip_dhcp_fine_tmr(void *ctx)
>
>  static int dhcp_loop(struct udevice *udev)
>  {
> -       char *ipstr = "ipaddr\0\0";
> -       char *maskstr = "netmask\0\0";
> -       char *gwstr = "gatewayip\0\0";
> +       char ipstr[] = "ipaddr\0\0";
> +       char maskstr[] = "netmask\0\0";
> +       char gwstr[] = "gatewayip\0\0";
>         unsigned long start;
>         struct netif *netif;
>         struct dhcp *dhcp;
> --
> 2.43.0
>
