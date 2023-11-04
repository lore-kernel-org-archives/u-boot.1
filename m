Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994A9C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 22:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5078703A;
	Sat,  4 Nov 2023 23:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ekrdBjJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F3F87053; Sat,  4 Nov 2023 23:58:06 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3B698703A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 23:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so5383983a12.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699138680; x=1699743480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=emGqk505QqSUd5Ec9XkYC4aTNmPUAQEStw5uwspfYzo=;
 b=ekrdBjJXmcB/y/RnadkSktCR/yc5OOfn/U6YqGOrujqkaYYezbN46zoFKC7FGxwKif
 zhWFfGhWr9DmDyfhyhMywqk3vMZYx5ULVxx+KLbJB87ZxG+zM547F4pPoN8wKAXdKicY
 1obVFq7CIe3almH0y/kS6+MqwmOQ3j8wApL44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699138680; x=1699743480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=emGqk505QqSUd5Ec9XkYC4aTNmPUAQEStw5uwspfYzo=;
 b=CTzs8FMblwiHKJFT5rk3YBUqpkvU3jGgQalus/stBGo4ebEP6Gc8CjuWNMrEnYzSqE
 krdKBWdXxaiP1yRM+X6tIsgfnFt1AmlmTQzQfKraj+mc3qQIaeTIAX+QsU65FW1jL1hC
 OUUkKqyie5lz9MB4j7Waa0uR5fzTxyQO8WNmnUxHCsPu4ggj1O5KaWXbfnN5cAFwbSZE
 fu9wg3UBbooUkw+/O+VzEfWiHXwf8z8LDXP4u3EF+gEXlngqmWT9pkZNlfFQbjyokwza
 9dbLgNPmlpM7dsJ6v3rNplXmqRCFZ/JGYrM8QHVDXk6G86g8HdxRUIvquVupEUM5tZTz
 YUpw==
X-Gm-Message-State: AOJu0YyPto4vTwnGE/ExkbPbv7ZrieBBKmayeAdwVdfCGxmfmjQ7AFjC
 iKRn6OercbuKMjrXk/gGStHDA8vA9VNwwL3pJREGeW8KkvXMbjiPJKk=
X-Google-Smtp-Source: AGHT+IHtN/WuDc78vguMQnxQREdrOXVrfhXTnWUkZOybZaLjkAprgKAraHbDv8ErNILkTNcDhWCQPwnoQtZGCHaZM6o=
X-Received: by 2002:a50:a690:0:b0:53d:b52a:5f4b with SMTP id
 e16-20020a50a690000000b0053db52a5f4bmr18352468edc.41.1699138679681; Sat, 04
 Nov 2023 15:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231104195733.1576679-1-seanga2@gmail.com>
In-Reply-To: <20231104195733.1576679-1-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 22:57:43 +0000
Message-ID: <CAPnjgZ0iuuaVEmZNGNUFwxSE5xqvbVix+kVnm=68j9mO16inFQ@mail.gmail.com>
Subject: Re: [PATCH] sandbox: Close file after mmaping it
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
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

On Sat, 4 Nov 2023 at 19:57, Sean Anderson <seanga2@gmail.com> wrote:
>
> After opening pathname, we must close ifd once we are done with it.
>
> Fixes: b9274095c2c ("sandbox: Add a way to map a file into memory")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  arch/sandbox/cpu/os.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
