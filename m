Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507BDC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 11:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B3281951;
	Fri, 14 Mar 2025 12:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zOdZr5oz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 876628197F; Fri, 14 Mar 2025 12:30:24 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4891281760
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e6405b5cd9bso9249276.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741951821; x=1742556621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=egmzihnb1xnMCiQvvDcAJuO8EWE4jIozUy3Nt6A4Db4=;
 b=zOdZr5ozPk5kdVVm/hmEeY4QNPOwjzq0DzByJqNUsVb9z6At7929X0c0EoQXi3ej1i
 DDg9ExR0cSfMrdeJcOqYkhVALfleUCPvZfoSl+lAqn0L1m35cQ//bJClFSCHHeYJZr0a
 m/NUUL59dkqD0ay+peM22FC2d5f1OufD9z1f0LLRUQDFjpWSZHPeWLINNqrMcmdNMNek
 GA67F1ey2yEHGaKPyN+7evgtt13Sy3ap6ADLxv3/CcEwOhVaC64e3agfIa0wTiyixWP6
 Mk1ZiipGoQYNplhAwPjVSPdrBw6sJCkDou0xU9kOPhQMVuUfgRx9GQMdX+WqALDKRokr
 v6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741951821; x=1742556621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=egmzihnb1xnMCiQvvDcAJuO8EWE4jIozUy3Nt6A4Db4=;
 b=xNjmBxWBONFk39Sx5UJYPErVKP41X5NqNkv6Jd6wwXzrMqztsKqvjN8LoNdm1ppAI4
 NgxLp0S+NZPDm9Ba4a8PJJypOKg9aQm/ujl4t0dOnNHZKgIQnW5jzIY9Od8bV0geQJ7q
 icii02y0qLndCrgYvqPtd8DkOLIa8LEna956Yoj001qk7w1OXPjkzPwPTCJTxpJO1efI
 O91wIPLTfnCH0mOYLsjRdDWfv8v9Jh5S+MQzWjU6BUMTDz96LbX8kiZW9/tpr6KK6T2v
 KhNGAE9kgoT5IXRT4NhDInUckQh3k+vtU8w5tWNM2ArFeJlPxIEA122qm/ZZ5FWqgZV6
 J3Bw==
X-Gm-Message-State: AOJu0Yz6agQjnKOGoSnVDoMb+pdyAmVlTRVlbuQ13UYBOUvYfS3Lh0TV
 71XqIJrH/UtM439HyW93tEti9wzkLRbsG8T+ED3vAu5JBCYNCP5x8hiq3bwXbgNSaAUEcW/+RrX
 bYjfeCGkge/K0HmllZ+IPBxtm2aUJzU/Q/AYJOA==
X-Gm-Gg: ASbGncsTI9jNh4W6A49kXZRWdEemOw70i5G2C++xo4TPFrdhgT/bWD3RcKVTTv/cmy0
 Ojgb/q92uyn9deD19jqlAECB+HxHbpPcXIDb+JR56V3pSaGCb7C3JvLlSuYlNeFJOesX0YIFFFs
 nxhAkyAacWZ8Utbu3sOUjtUYMMz1E=
X-Google-Smtp-Source: AGHT+IH/3VanJ1k52yUGIoIkTUpBFY6tkJK32NkKw6TZA2gUOFgkFx3KmsecG+3all0UNHtohoAp1DX9/8yLGwsr3tQ=
X-Received: by 2002:a05:6902:2086:b0:e60:9cf6:ad89 with SMTP id
 3f1490d57ef6-e63f8926512mr2107150276.20.1741951821154; Fri, 14 Mar 2025
 04:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250314084411.4165751-1-jerome.forissier@linaro.org>
In-Reply-To: <20250314084411.4165751-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Mar 2025 13:29:45 +0200
X-Gm-Features: AQ5f1JqdhcbxZJLAFMK0wnTJnm2t561XEMJxKK1yaeXjyHqQDUZa7tzsFFifRMY
Message-ID: <CAC_iWjJZz3P3u3Fs-q-ETJ3ejB1yB3RvMfjzUandpp30wwcOjA@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: do_ping() should return CMD_RET_FAILURE when
 no device
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

On Fri, 14 Mar 2025 at 10:44, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> do_ping() expects ping_loop() to return a negative value on error, so
> that it can propagate it to the caller as CMD_RET_FAILURE. This is not
> the case when no ethernet device is found, so fix that.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/lwip/ping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/lwip/ping.c b/net/lwip/ping.c
> index 200a702bbb5..c586a96806d 100644
> --- a/net/lwip/ping.c
> +++ b/net/lwip/ping.c
> @@ -121,7 +121,7 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
>
>         netif = net_lwip_new_netif(udev);
>         if (!netif)
> -               return CMD_RET_FAILURE;
> +               return -ENODEV;
>
>         printf("Using %s device\n", udev->name);
>
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
