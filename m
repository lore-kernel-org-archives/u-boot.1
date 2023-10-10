Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ABACD8C9C
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7FDA86C53;
	Tue, 10 Oct 2023 16:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CTIXHF7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA10682BBF; Tue, 10 Oct 2023 16:57:54 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7845F86BC8
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53808d5b774so10327463a12.3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696949869; x=1697554669; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sIU3luLFmYVWZy+Nk41KCRJ2jgUd0i3H6NopASuE5GI=;
 b=CTIXHF7S9n+UwZdIaelOIzuOiObCdqzy1pYTopAHAP3aAD2y92X5TW49Y7hz+SN4x5
 CuFRtNx1/B8updwf2oadxtFDpYAeLBYev1B9QpalyNpcbK/CiXZLaJzd9VI/+UBU5uvf
 bG4KQHXIw/5MH0EQ0YYyHQaOkypfCUZvth4FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949869; x=1697554669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sIU3luLFmYVWZy+Nk41KCRJ2jgUd0i3H6NopASuE5GI=;
 b=HH0sUSzLEgMgNbQ1PWDtQS9yEzn4/HesqA/drRcuc74NdAGKOkjGN0Lncu9h2EVsQr
 ElD2kZx9qxGnS57B8HUqbZpeIP5eAIB+p2/rDjXllxeHscN0x0lAKOXPbCR0dUgj/MrH
 /pbfL73FD2S7WCQXh8OlC53ULGi/+f1zlWnLQODabPp9PbDNnD6UGl8wgxihCSCrwVtX
 HKZgE+aWTlcpLHBreXzpWrqvrkfTtgDS0+gAlzxM8xkolTg3ih+Og+Rjkjx2oV+GHIa/
 1GsbUPeKjf6TDvTPdA2pxWhSyGK5FLgJc1dvS++WLxZM77tAM4q1rJvbfFZiPL5IN7Ii
 WIQg==
X-Gm-Message-State: AOJu0Yw9XMSrkX2/wmf83F/TnBDbKXkMY8g0VYpNz2K6wo94EIr5tKL/
 Uc9DSNW8XEUPe34SJf5xVCeZ4FZYxYCSmpJu5faS9f+IySe3EomXe6c=
X-Google-Smtp-Source: AGHT+IEae3ypVXQ387hEnI1OoA5SOpWbmBcAwlBtbNs0/Dh7dg30eGviCoXp89Pk6k6cTTseL/bET42EsKidsu4Id5g=
X-Received: by 2002:a17:906:1017:b0:99b:627b:e96d with SMTP id
 23-20020a170906101700b0099b627be96dmr14138151ejm.44.1696949868547; Tue, 10
 Oct 2023 07:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231008020156.1990125-1-seanga2@gmail.com>
In-Reply-To: <20231008020156.1990125-1-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Oct 2023 08:57:37 -0600
Message-ID: <CAPnjgZ0_zAQxozOpEKrr1oHKuJy1rBVQA1H1E1n2s4jXa3QS_g@mail.gmail.com>
Subject: Re: [PATCH] malloc: Enable assertions if UNIT_TEST is enabled
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sat, 7 Oct 2023 at 20:02, Sean Anderson <seanga2@gmail.com> wrote:
>
> dlmalloc has some sanity checks it performs on free() which can help
detect
> memory corruption. However, they are only enabled if DEBUG is defined
before
> including common.h. Define DEBUG earlier if UNIT_TEST is enabled so that
> assertions are enabled in sandbox.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  common/dlmalloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
