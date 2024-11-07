Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B647D4335E
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140E98928C;
	Thu,  7 Nov 2024 14:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CBRY+wuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2DE389282; Thu,  7 Nov 2024 14:45:35 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7982788581
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 14:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2ad9825a7so746624a91.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 05:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730987132; x=1731591932; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O7jfOXoiIee98LOY6kzGqI2XVrpLnrcdDb7EeEZ6h3I=;
 b=CBRY+wuGQpZJU7HCdwRRqHgXi8njwCZs3PFUwTJPK+NFrNsSF6WsGb24FGnwkiN5x/
 K9lcHRsV4+kuEiIBAWnwItoMb3vRbvLRlgiUOUhuduQl18BSk1SGmmJsW5Vdf2KWq5l2
 cjr4ILVZFhsG59lUYSlxixHm47kv/gqh3BcP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987132; x=1731591932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O7jfOXoiIee98LOY6kzGqI2XVrpLnrcdDb7EeEZ6h3I=;
 b=JFpy4gy5qS7dR1z1upwOeN/Xgx6L78rVDwjjp4cSEGpq3WRDNtBwR81jGmNiAKns19
 3ZSpL+2tBuFGKUfcG8zLxXmZuGKOSBke2/OD8mCw4tX7XAitIt5YFJzsELidaAhI07jf
 5atRwLGdz7edhCP+z3GGBFxDdRLGQuAQCrXV1OTWoeBunVuMfD8zmjRYjkHN1Ftvi4Vi
 CIarO5lkK9tZNiY2Ce+QGUhZO7f8X+WvQlvj359UlXnIzEhn/gl0dErHKZmGlLyInNa5
 hXdwk6JJCYr7miMXqSSBabrBQPrr0a6E71lLcqxWhRyvo4IcVv6Zxeh948qt+R5Zcf9I
 pZRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnoNVxafymzMX3HNG8XRL7R7IXrCsVOlMQfxQBE8Aeu7RbEZe0YrH0vnL3pviEn7fHrhgdBNI=@lists.denx.de
X-Gm-Message-State: AOJu0YxCE1zJf4J/Kdvq6+U85xCaT4eOIrVAuW8MVO0c14hoAgs7asYI
 Dl03NTrb3F7YO+WYxZTpK4MgwwLfApD7exZAPXf07HYx/CZSF0AFJurFSjcC3ZGRMwKtThtf5Qi
 WbcXJB6VQ6D3er0Ip75bnNmsdntUXjpEmy0d8kAEUsg1WAgA=
X-Google-Smtp-Source: AGHT+IFg9SQdrhnKjgSm31sMyr+GydEDEvLASKjjnkRL5gDQ8o4Deb0WRhcO87Ghso2d+97IzMFvtn8eqmBfcof1gWQ=
X-Received: by 2002:a17:90a:cb85:b0:2e2:e5d0:dabc with SMTP id
 98e67ed59e1d1-2e8f10719e2mr49196457a91.11.1730987132029; Thu, 07 Nov 2024
 05:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20241107103922.46907-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241107103922.46907-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Nov 2024 06:44:35 -0700
Message-ID: <CAFLszThByD9kLhQBAy7ON0hqwh7qat9JYpHU2xM0ZHrPZxNdVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: fix regular expression in test_spi_negative()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Padmarao Begari <padmarao.begari@amd.com>,
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

On Thu, 7 Nov 2024 at 03:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Escape sequence \s is only allowable in raw strings.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_spi.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks, just did the same patch locally yesterday.


>
> diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
> index caca9303271..44e54738dd0 100644
> --- a/test/py/tests/test_spi.py
> +++ b/test/py/tests/test_spi.py
> @@ -695,7 +695,7 @@ def test_spi_negative(u_boot_console):
>
>          # Read to relocation address
>          output = u_boot_console.run_command('bdinfo')
> -        m = re.search('relocaddr\s*= (.+)', output)
> +        m = re.search(r'relocaddr\s*= (.+)', output)
>          res_area = int(m.group(1), 16)
>
>          start = 0
> --
> 2.45.2
>
