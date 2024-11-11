Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870D7D2E9E4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DAFE88FAF;
	Mon, 11 Nov 2024 13:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZWEG30MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F61889365; Mon, 11 Nov 2024 13:49:43 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F080A88C4C
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2b9480617so3617458a91.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 04:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731329379; x=1731934179; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sYm6f4z2FVF9UP+Yzv7Kb+ohb8CPl0RUN8Gzh8am4Mw=;
 b=ZWEG30MK7QR/E86zUp/wlUID8WwW/YDQV0OmZrkE+UWjW16NYXb2oYUHQNiVew/OW+
 oWlPjyJfBygE6eMbL+0+8M+ywazBTxXgQ6RAHfjVytP94SsGIh6ILH4SpbAV5C5DrCPT
 /o+kb/wMzvAbQPdnw9ytVbrE1OUax8gtFpeTMALbRkiLKaQP6OaLE6IZj67XSq/Bs3mS
 QlSpoHwMgKj79HUj6yob8kwAoRkw9yiq983hjqCOSSzbBi829WVU3m5ogAl4dOlF2tUK
 EvIyYKsRVN3qOxaA8j3tvH9GSc0ljmMHAYYhyooMMcYX9N6uzjV4sgLSfzQ/E0RBZ9/Y
 2nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731329379; x=1731934179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYm6f4z2FVF9UP+Yzv7Kb+ohb8CPl0RUN8Gzh8am4Mw=;
 b=WJcvOjO9mMs85QD6haSZr5FqK3s0PrnLo8Z+3AwGHW1vI+jIJeiOQ/5+YN5FoTkxnj
 Dhbkc3IRtI3COYdZnh8+nFhdnuWCnuCEHVlQW6wsnFQeWoDKAr33auxDKEmxiq5RGMGr
 DkWEZseWifbmr6ljO+u4Y9b9knDMwjuuuukkRjBTJPERkSMDRRRqGRBivlLHPKwC2LaC
 xy+AnT3pdSMXWZ2fondcmnDUVzmRcJcTJQ1WUL+p8GJSxNtJ2xtKnWfhF4w2PQKlDujG
 okZvdjQUN2orIs1VQY4xvu9yqxY23VoN5AR/t8kML9Oqc7yy4PAKTsiwCoDePx+7XjBO
 SbcA==
X-Gm-Message-State: AOJu0Yyuljtplv8v/vJ55yvhHlSNKfh3WJyAg1zBWl/FZAaFJWgdQCMy
 42Y+kHT8LGS03lctD5RiuCJk/UotZMtVLrpz7ERibj1PmOCu2dsdy7J5OB2wgdPNa5ZAFNN5VJP
 MN4w1jYHqV17PGwVmbszX0pK76AwyHhitBjsDbg==
X-Google-Smtp-Source: AGHT+IECyAlpLSPOlUMfzmEbC1vt8FH1eLbxZq2BvYKKmyJp6b5qmVj3Y/m6UtSyC73obdJExKxIVxbc6th1gbJP+yI=
X-Received: by 2002:a17:90b:4b87:b0:2e2:cc47:ce1a with SMTP id
 98e67ed59e1d1-2e9b1655632mr18188523a91.1.1731329379433; Mon, 11 Nov 2024
 04:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20241105102455.10141-1-jerome.forissier@linaro.org>
In-Reply-To: <20241105102455.10141-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 14:49:03 +0200
Message-ID: <CAC_iWj+f+kOSZjbJZ25qCHq3+y99a7TwyvoRjf736VUZOFFsbw@mail.gmail.com>
Subject: Re: [PATCH] sandbox: net: lwip: use EOPNOTSUPP not ENOTSUPP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 5 Nov 2024 at 12:25, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> EOPNOTSUPP is the recommended SUSV4 error code that should be used
> instead of ENOTSUPP.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/sandbox-lwip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/sandbox-lwip.c b/drivers/net/sandbox-lwip.c
> index 3721033c310..5c9a0cb1b9f 100644
> --- a/drivers/net/sandbox-lwip.c
> +++ b/drivers/net/sandbox-lwip.c
> @@ -27,7 +27,7 @@ static int sb_lwip_eth_send(struct udevice *dev, void *packet, int length)
>  {
>         debug("eth_sandbox_lwip: Send packet %d\n", length);
>
> -       return -ENOTSUPP;
> +       return -EOPNOTSUPP;

I think we are fine without this. Isn't EOPNOTSUPP for socket use only?

Thanks
/Ilias
>  }
>
>  static int sb_lwip_eth_recv(struct udevice *dev, int flags, uchar **packetp)
> --
> 2.40.1
>
