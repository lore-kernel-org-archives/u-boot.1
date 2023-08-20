Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27813EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8096286FAA;
	Sun, 20 Aug 2023 23:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DaApWb66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1EE886B7E; Sun, 20 Aug 2023 23:57:35 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBB886B88
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so5663170a12.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568653; x=1693173453;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iFcVTD2oo0WbqxiKvgbu5MkamO89bIzU92yWfPS04Kk=;
 b=DaApWb666MrnAlgEZI8KUpyIqzaeGAO/YVtH24SVUWK7xo+pl6iXA27iuae9wWoCZo
 zprQ3ZxQjxjFfDdz0YINKGwU9cINDqeyEtpPJW/5qG1cX4IXi49wckobtVRI5zfOWx0o
 fxaZx09VZeD07IPBTH3X59eheQWbNpWugn1zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568653; x=1693173453;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iFcVTD2oo0WbqxiKvgbu5MkamO89bIzU92yWfPS04Kk=;
 b=Au57CQHnt3flTpdPywk3REBnJ//p2bjMRbuOjt8jSav4j0VlFORxoI+q7w4QQaQO+b
 NP5yEelbaLqiyTaz+UDTolVGZ1e2AL1W/8gtNAaUUuqwYOd7cyfvmJk+aJwJVaE8ZvvU
 l3quUgED+BX6r4Z5tiixJkdc6WleieV8eonFXKDszrmORp8DO2g92TPNms0vm4Ypwp53
 EQ7FYKG60jIlqwAsCJBwx8hVCbWEl3zmQTolOcE2ScGDLQn1xeRPSujHP5QW9zlrVn1R
 Xa0FgmIsk6QKqPsUPuVCeDiriDXZcwFLV37rOlKKCBbUmB3lcwgSI6pkgbFUKTMCRAFZ
 ZaSg==
X-Gm-Message-State: AOJu0Yyc6DjHATdgNQJk9BsKNSEJ22K1T8SwxQXVCEDn/SWMn4YyUXA5
 bu1E5PXLalnKXNLQz8fPllnVecF3ZX5TuGr4utyekg==
X-Google-Smtp-Source: AGHT+IHMI26M15LySC7fQsIFqkfpCvrr6ehv49S37zYzYwa4CLRYfNVmxyjYL/wPVN5JKr7lpkAGAhvZD1kYZNgTe1o=
X-Received: by 2002:a05:6402:430f:b0:527:1855:be59 with SMTP id
 m15-20020a056402430f00b005271855be59mr5391841edc.3.1692568652720; Sun, 20 Aug
 2023 14:57:32 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0isu_t-y3VeuEw6Sg=4P9_jVHdSK0stJukNOzzjUn0kw@mail.gmail.com>
References: <CAPnjgZ0isu_t-y3VeuEw6Sg=4P9_jVHdSK0stJukNOzzjUn0kw@mail.gmail.com>
 <20230813051506.612351-1-marek.vasut+renesas@mailbox.org>
 <20230813051506.612351-2-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:30 -0700
X-Google-Sender-Auth: FpcD-NOrM0-Jvy9-kdHAMhO6mFg
Message-ID: <CAPnjgZ3ARU-eed4M6BHYb3V40JCk1CDnn28P8_0p9diLhX69Tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] configs: sandbox64: Enable video 12x22 font support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 12 Aug 2023 at 23:15, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> 12x22 font support. This fixes ut_dm_dm_test_video_text_12x22 test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
