Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E226CE9D78
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD7C883F9B;
	Tue,  6 Jan 2026 17:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IkRw22BX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B2C83FA3; Tue,  6 Jan 2026 17:23:16 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B2783F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34ccb7ad166so990593a91.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716588; x=1768321388; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n6EXi8mWcFFawF335V98h0H6yYMKT1UkWl3tF7UjEmk=;
 b=IkRw22BXFvA5I2z0/CCWRjDWuzKPfhz4AUE8bE4jMaV8lTcWzY5Q3BYiOrNJUPBmgW
 nmkvDg6aIZqLemxCRz6TM+mDNKfmRhlAacZZsrqZik0PWpHpJ/fGqqMcS/tbM37vY38A
 LFwvIWoDZUJqVwATVSfGvcTxGsnHWBV3W4vvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716588; x=1768321388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6EXi8mWcFFawF335V98h0H6yYMKT1UkWl3tF7UjEmk=;
 b=S512xhqeokRjjBF4zaDkwLKVR2uM7LJK8A5tGZCT03t9MOJIOgBfbiVBFutCTCIcLr
 yon/9dmFQeVD6zHIC+OHEwzTHRHvWxC3NjiH2jXYVGXHPpJfAFB3+4d6IUZHynSwpjNV
 A/ND8U40g35ahYKSHF+8wahUbkEw5N5jI2PUp1Grg42XxWhnLvRzI31rGpI+tZLtnf8p
 73Ex/20gIsFjQjNtm06P3bOe8xMLPcOKka5QyBTLXkuTTPMjEvmbQCGcCvQKktzpxBAT
 rjffCpSuZg5dTIuK8nTju1xmi7s7t8eEFbRNLShdgx9R+SKwAGEc7DcTbEE12VMvMB7Z
 Ci5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo3fqpCy1F5GjZGfm0OG5jFHC5/ZppFE9MGYCL603tZSgihvsCbkzpq6GBGQUjnUuRaGXpTxM=@lists.denx.de
X-Gm-Message-State: AOJu0YyRC1UjNWm0vLTwPUDHmFKWsOfTVLFmBOu4P1eVbPF5PY0USf1a
 htYlckJ6pQCQutyVEF5T5r6Oxn7synyi71XIAGcyjamIymPRk/SnDyTsvJ8c/vk+7EnowcazD6n
 QEQG608e2YASezcG1VKuUmMJu8Jb2oevaDMAb8htT
X-Gm-Gg: AY/fxX6uaEJ5/4WDo0NG0br6ES4qs11dxmdL4Vro5gkNvzcK0yc6GxknpoUnrflKOMv
 wALCE/2AFSl0zrCNQ2SmTsyFDQ9iFhHQkZM4EMgT0yHJyZKagpa8rHhhC1UM55PyL6kGTFbKAZe
 p0/bVQ/WbhtU9tPNG7qxOERcN5DUTN4qWkjHh8vl+CZ4woaccX/As46VNogr8ylCt3xYuMrK3Qi
 txaU1DGb+iQ/VwZbUrxd/FPvFEWBwPhAuE1m0ypIWHgARk0bAtXQ2ZzmIQRGsHhNkOkow==
X-Google-Smtp-Source: AGHT+IH9WZgunHZdRch7aiejZmx9jdkMTlEGp8HZUkrdiB6T85H21cMnZvzm5MjVfUm6H+NLihmAO+9uwwm1Pu06Vfc=
X-Received: by 2002:a17:90b:3c07:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-34f5f34020dmr3131946a91.26.1767716588071; Tue, 06 Jan 2026
 08:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
 <20260101-clk-reparent-v2-1-3eb42b78c7f1@outlook.com>
In-Reply-To: <20260101-clk-reparent-v2-1-3eb42b78c7f1@outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:22:22 -0700
X-Gm-Features: AQt7F2pp10GYvy_TzX6sb-PhN1sdcmfbVcSEhLdFCp7Y20OJt8BTMF7ugSPN3Pk
Message-ID: <CAFLszTgKiuQtrjGf0a84k5pBpeEv0U-sgEzmj2n4uQUfv803HA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] drivers: core: device: set new parent when old
 parent is NULL
To: forbidden405@outlook.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Wed, 31 Dec 2025 at 12:52, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> The current logic does not update the new parent in device_reparent() if
> old parent is NULL. The behavior is not desired. Fix it by setting the
> parent in this case.
>
> Fixes: cfecbaf4e768 ("dm: core: add support for device re-parenting")
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/core/device.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/drivers/core/device.c b/drivers/core/device.c
> index 779f371b9d5b..497c32befde7 100644
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -285,6 +285,11 @@ int device_reparent(struct udevice *dev, struct udevice *new_parent)
>         assert(dev);
>         assert(new_parent);
>
> +       if (!dev->parent) {
> +               dev->parent = new_parent;
> +               return 0;
> +       }
> +
>         device_foreach_child_safe(pos, n, dev->parent) {
>                 if (pos->driver != dev->driver)
>                         continue;
>
> --
> 2.43.0
>
>
