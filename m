Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AE3C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C006788B41;
	Tue,  6 Aug 2024 23:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nHphVdUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40E388B2F; Tue,  6 Aug 2024 23:51:39 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA1088B4B
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7a10b293432so972761a12.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981096; x=1723585896; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GCKHdoqMthtNY7Z+uSD3nVEK5Wzmmcj/M07UPHGHI64=;
 b=nHphVdUKV1MCkyfHQNVFhLNz1q32Z5og4gcn5AGsXthxWzjVMnGF0V2oXVfsEFS5Tp
 cG79CxOqim72vnnTqiPoVztasNxIc0jwJR5bMFXM8+hOsnzDMMb6Fyj/h8KQ5RPAld9P
 gEFucQJISaC8cLWimKdxLNmdsNetccvUpUHzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981096; x=1723585896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GCKHdoqMthtNY7Z+uSD3nVEK5Wzmmcj/M07UPHGHI64=;
 b=WCrsTQhAQs7rD0dVhi3Mdr7sOYTpjxLuNi/bLU6LdF3hV9eIlhbkHQKgrkFo0SZxvk
 udg4CuFUFmm4JterkqRRXFztNvTtPoyXofdM0IjqcAHWM0+Mew7mbP4cWxjP2argiTuB
 uLC6DCDhPThPgbOTguC26u4TRxwhpHOcuQ4gxUxf/fIEGJJityjYckazbL2wqdAsdSLN
 +QMlBH8Q2txCl6Xq5RJJrgZo7jmwh76g9QJQ9SQInGcUrwh9cHtuywB/2lN3DcioUt6m
 Q8rkHzXNJhxMHohkAQw2a6nRofxDS8acoWOKBig4oUUTxwWKYWfOU73u2ut1wIazddKN
 o7Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKo/WqMXYi5UzD3WZ7AHieFQt4qkW7b5BwmgQkQAg4RML3ZQPLE/9yX7KKoyxy66n3wz7d+69FJ0ffFMYZdA6xl0drFQ==
X-Gm-Message-State: AOJu0YwH5pF5lZOkXCvmFYtVXnPeXLuKwQgVRIBBBWDE0UtusQxhfjvN
 VJGHIRGlNCjYQqLgmnRmJGMyOzAgYZ/UvZx2Dj1Wr8sjxdPbOQ/ddvdSsSOvEEdUEHYpU9qA6o7
 Xzonol68z7H1eFAKy+Jhz+cT+buF2bzpEhs9INvMigPF96NQ=
X-Google-Smtp-Source: AGHT+IFcU64KPC252rvLcndn9HNU8CYG12hKI071XVwOqPdaHJQUpU8M0o9d5JaFyVxpTHSYhRI51jfRZhX4KhqKDjU=
X-Received: by 2002:a17:90b:46d3:b0:2cd:3445:f87f with SMTP id
 98e67ed59e1d1-2cff93c49edmr16112238a91.4.1722981095972; Tue, 06 Aug 2024
 14:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240804150556.3519995-1-jonas@kwiboo.se>
 <20240804150556.3519995-3-jonas@kwiboo.se>
In-Reply-To: <20240804150556.3519995-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:58 -0600
Message-ID: <CAFLszThRKDinso0M5HT5cgGVfptBQZ6nLRLQcwpkB+EaPKJuSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dm: core: ofnode: Avoid multiple calls to
 ofnode_get_parent()
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sun, 4 Aug 2024 at 09:06, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Until a live tree is used in U-Boot proper after relocation, use of
> ofnode_get_parent() will trigger a call to the very expensive
> fdt_parent_offset() as detailed by the function documentation:
>
>   NOTE: This function is expensive, as it must scan the device tree
>   structure from the start to nodeoffset, *twice*.
>
> Re-use the returned value from a single call instead of having to make
> multiple calls for same node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/core/ofnode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
