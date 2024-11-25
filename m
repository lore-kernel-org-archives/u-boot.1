Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7365BD58D65
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 16:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A67989A4A;
	Mon, 25 Nov 2024 17:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SkDzWU7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B3A89A3E; Mon, 25 Nov 2024 17:21:45 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC8389A4D
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 17:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-724e1742d0dso2643996b3a.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732551702; x=1733156502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kii04N0eLOEHl560t1sRAyr8Y23OvEEm0ju29zwcvww=;
 b=SkDzWU7Hd+EXJ/ErwmxTa16BpstGMZ78kk+ox/gKjpMdBSxcaOt1yne8XqNiw/bhJc
 SMN33n6y/wgGfYNwTX1lUKxYGTd6BCYAGkPHkGeXJXntg30Le0aXqMF4bd+gX27ckMFa
 ReDlYcABG9PnlqR4SDGbVSUORKVc5DjVDLY/0CZuaa0s3OiDD5ej3EtkPvKfsvUQjiTz
 CSwHVnZDBZcVCB/s1mpUxeVqPklyq/kHdYon+HCZ3R8LICwNEOMJM3XssWvBAA8U7s9p
 ENj4yKNxFb94+B6FSXNw2mqNtjzSD+ZzDPvAtsP73bKC/B/3JT6ndoxBklYnVcW4blS0
 Q45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732551702; x=1733156502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kii04N0eLOEHl560t1sRAyr8Y23OvEEm0ju29zwcvww=;
 b=RfePmsRDH1Ifb0x0btMib+ucC9mhskswkf3OHhXfkaakWRdPfFTDWQKjHrRKpE8JUo
 VjumUI3YP08ZuookwU7/fDyLhlKO1t+aVGKDfIbkC7MvZTRYnhlHGwDqP0K0dI2i+5u7
 RFQstOKS+KtA3ijVwGriKizhcDJHNf9csDLpe9Y8MBNS52YQMzbiu1VExjClHeDlrJiY
 YHKtStlx1Sv8Xhaw5yaGH3TEI9e8m98cyZDPrSjz3XuZeus50gyQCNa0c/2hgKjy7O3k
 7TSZTdqpE3DCs2htGiTcYX/9MmQqLCqxcmR0w/EvtDX4VlF9yh0w+u/Z6zY5dySg9I1L
 Fn2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFVgNMSLLQaKHpWMwNrIIkI0tXFY490qkeaWSCXTjvf4OG4uhiVVqOKOYj+KkW2eE/eTzMzQs=@lists.denx.de
X-Gm-Message-State: AOJu0YxjXzd53LmJf6nsIXTsRcEcQfxxV8IVM1HC2n2PHo5XJkDMdfMa
 bNpECcnE/0AOD0PwRajTD4/fN2iv53R6GL1gV/lgPemFvuG6acBgmHGfWmGXmOXAbk5tCbbkm7L
 t04WmXVVYnlxgCBw1yCofqc1r+nNfWS5i53jTPw==
X-Gm-Gg: ASbGncurg7adzDF4vzeOfTPZXWa/1Lz9sEXZCpXYB6w9TFNrMUwGmMyg/XWe1XlznSI
 peKFg6LmskjCl3i3OJeQxsO2Nri6nUg==
X-Google-Smtp-Source: AGHT+IH5vBntfO787YPKMZawRCnGzeSjHw5L/JZrM/Jwg+nb71/u1Gji67hgc6/5YXUkWqwRGPCM718h10Dm3CxH+nE=
X-Received: by 2002:a05:6a00:1bc3:b0:724:d758:f35 with SMTP id
 d2e1a72fcca58-724df3c77f4mr17940124b3a.2.1732551701797; Mon, 25 Nov 2024
 08:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20241125150834.90448-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241125150834.90448-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Nov 2024 18:21:05 +0200
Message-ID: <CAC_iWjLdhxoWQUWw6fjDJ-Za9LYBoa6M9PBKqj=WvZpM=J4FMw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: remove duplicate definition of ip_to_string()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de
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

On Mon, 25 Nov 2024 at 17:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> ip_to_string() was added to net-common.h but not removed from net-legacy.h
> in commit 9063dba2d326 ("net: net_utils: Move ip_to_string to
> lib/net_utils.c").
>
> Fixes: 9063dba2d326 ("net: net_utils: Move ip_to_string to lib/net_utils.c")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/net-legacy.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/net-legacy.h b/include/net-legacy.h
> index ca1efd17af7..5a431fc6b16 100644
> --- a/include/net-legacy.h
> +++ b/include/net-legacy.h
> @@ -502,9 +502,6 @@ static inline void net_copy_u32(void *to, void *from)
>         memcpy((void *)to, (void *)from, sizeof(u32));
>  }
>
> -/* Convert an IP address to a string */
> -void ip_to_string(struct in_addr x, char *s);
> -
>  /**
>   * string_to_ip() - Convert a string to ip address
>   *
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
