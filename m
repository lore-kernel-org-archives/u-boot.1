Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3C2C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE4D96066E;
	Sat,  8 Aug 2026 17:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFFqfLTqnQkn; Sat,  8 Aug 2026 17:57:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4843C6063E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786211873;
	bh=eDSJVWSLnEUCOW7rhDzgezGKicNZBjQzFyKEUUCxaZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h6NbWDHOfUyF1RJfMS9H89oV1o+hJlnQ+lgi2BG9WfWXMKLpyesBFkxgFchZIw+7r
	 tZv/FldqTJtH3Xz5sTmKiD7Fm2dApsENndrOmnSDkmObYfbgOgsvVRxPQu/f9HcbOu
	 gtSyfHQ1PCXJm1RAlDT+0dPhz59Yde8XD1Ta7kcX/b8V7RkMI/vxiuELeCES5uP/9v
	 7BY6O69M5f0u+N4DcN/tfs+HfQ0zE8bdNbfs9V1l8LqXGDNoavEltxbnXZTAnc6iqw
	 gg9IVKbnjpO8Q0Rarvc5xu6NQPaSs1JUOeSeTvFtmLj9zdLGhLuoDhfjPiyRUBGwPt
	 oPF60aQyLIN0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4843C6063E;
	Sat,  8 Aug 2026 17:57:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 010C010E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBC9C40497
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rwsV2p_HfYeZ for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:57:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F049A4048D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F049A4048D
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F049A4048D
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:57:50 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so54469266b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786211869; cv=none;
 d=google.com; s=arc-20260327;
 b=ghaZd2H3horbA4O6Q6dyEV/NvRh+hORilbfea3y+y2bqKQMVHoORRYRemAcGeuhU7G
 FMaXpGNvkxNlSMWysCEM2gekyjcNHdTyIPGC/5MbOwphKqL/79b8+jkZx0Cd+oVxQnNg
 moFYh3JckQ8F9kynwtHfwXSYIYjDh70tQmzk8EeqquA9sjI8AzTN4sIFiK2l3U2waCts
 vm4TJm/KatWBtB0UsXYdeH6REWEW0cF/qYQY/thxVLmIYmwTd14HW8y0TwrRTx8pZ5aJ
 q3djktP/4+1AfKOewrB4/TUu2Zklb1hytMOlBAZKNwW6rOQcPGFhbspHBFJ/t/JOdsLs
 q1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eDSJVWSLnEUCOW7rhDzgezGKicNZBjQzFyKEUUCxaZk=;
 fh=8TbiD9fEG91wSNsvqqOput+PpnqsIRDXX+RXlsylxJ4=;
 b=iTo8q83rnrNzdpJw9PTOCCATsVKwnDeoS+iTP6g9i3wPgI7KVkSxc+UqKBExTX06NC
 TuTF/pReqJcVIJBkFpk097KHgUvy63caIM8aZzTyG0Zwb9jwwuAJN884kpEQu9n/GniQ
 uf8R9zZ237sjXNMW7L69ocI/wGJJSsm6jdv+8xeBAUQGQebl6zVynFj9nXHbFdc+3gki
 N9Qm3HOiQ5WJ6VT9e/A760KsosZPIOzUh9U7jS48p04XB4YkzfHu1I/L/0gXvOnflbCS
 8U6UE7++M+vOkT6kjrQ1DA40M2aU8V1kF9ZAieTsZqyAhS9qzuyoktFiyR8MmE1MQRfi
 z8bQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786211869; x=1786816669;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eDSJVWSLnEUCOW7rhDzgezGKicNZBjQzFyKEUUCxaZk=;
 b=FHjM73miPvYLngD9e6T25iXbz1SASuUVJHnK9mDcCznHRSjNyHMTf39gq5xMhkWyN3
 kXu2/SEV+Lk76+M1FosMZfPbTlCo3M7mImSyaQ9zBznCLh5S50W57J2W76Xca18DDfXR
 yYRqnuxWP0BADYvkxog44koXauwqY9c7Wzc6XcdixVSwd/AEa+gBloOP2wXO41UQkAEH
 NC9Kz6Ic3kGvEcwHc43J+EXeM0aunhUr7zOqeCfWrQ/CSEwy9+mShjCGyNtQqCPOP5TL
 2GeT5if728OfIJ0mS6ohtjM6vnEjxX7LSsqUMR87hhtWXYU9mbl+DwKTImCHW1qNBzrK
 sKww==
X-Gm-Message-State: AOJu0Yys8P5Q9Bl97orNoldPsD1v0ml8TtZzDFh12wZ/09j07c9aD7zt
 SZbmVvBU6wwumrW4Vp4pPo9yxrTJibp1jh8lfCGhWkr1yQ/CbmVZqS2FdJ2tPMn+g2t/oLuGJlT
 1fkwqAHJAcA6477+AuAfMDvJi1oukxAs3R5IR5Tgx6TsaDTWkdak=
X-Gm-Gg: AR+sD114+TniuqkhQXg1cqvXxjCCQ1AhcuE66F5JRMBN+utgr4raY/5aeUQcLt9awpz
 FxBCJPdAWCIMsYG2UYfM6ADSSh/OxbkwnyrcFU+vB/VYt1NuL1tiiaQYJBV3mhTBFkIIJ590yBU
 sqhxZC0Se3wN9hI1kMNcVx0h3jDMyTY9edmsXOUH5+1w2NIeRF4naYlBFT0sUScQ85URFhr7LjS
 tcjwruQ6lk2XREQlBUcA1CLy1q+9H7iwuGOWhbywbfsRn4nJu0fspliEe6NZi0OU1gqHFBUzirR
 bIve02wg5xVCw3qq68tCWTlWdC9BcdwoeYWFgIt1D6M=
X-Received: by 2002:a17:906:9fd1:b0:c20:7557:d986 with SMTP id
 a640c23a62f3a-c20873bf22emr478192366b.13.1786211868825; Sat, 08 Aug 2026
 10:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
 <20260729081218.550465-6-pranav.sanwal@amd.com>
In-Reply-To: <20260729081218.550465-6-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:57:35 -0600
X-Gm-Features: AUfX_mzXxAXhMSzcjZ3X6I-SbwTHhEhFGJcxYOpR4snrMDgWKC46jW6-NtHgtT4
Message-ID: <CAFLszTgehLY9oWT-joZpjRBhoosszUu-G9YhnYQZsRCwxxD1qQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] gpio: delay: free wrapped real GPIOs on remove
To: pranav.sanwal@amd.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786211869; x=1786816669;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eDSJVWSLnEUCOW7rhDzgezGKicNZBjQzFyKEUUCxaZk=;
 b=mGFQjPcP6r9EtEooP3N7fG1dU1wROJfLzvDBSf3W4kebN/yaq9GzWI2jdDwOm7Ejxx
 W2WrojDtXAzYq0wroTnym/uNPzq6G03r69HxUXkKJ4JFj7pgzZ9/Xsnb/Um5ElBOhzRl
 nyb3Yx/RL82CLiioiG4v+ngLzc3HVWWuCKi8s=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=mGFQjPcP
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Pranav,

On 2026-07-29T08:12:14, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> gpio: delay: free wrapped real GPIOs on remove
>
> gpio_delay_probe() requests the real GPIOs it wraps via
> gpio_request_by_name_nodev(), which strdup()s a label into the real
> GPIO device's own uc_priv->name[] array. The driver had no .remove
> hook, so those requests, and their strdup'd labels, were never
> released when the gpio-delay device was torn down.
>
> Add gpio_delay_remove() to free each wrapped real GPIO. Guard each
> free with device_active() on the real GPIO's device: generic DM
> teardown (e.g. dm_leak_check_end()'s uclass-by-uclass destroy) does
> not guarantee a consumer is removed before the provider it wraps, so
> the real GPIO device may already be inactive with its uclass_priv
> freed by the time this runs.
>
> Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> drivers/gpio/gpio-delay.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

> diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
> @@ -90,6 +90,20 @@ static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
> +static int gpio_delay_remove(struct udevice *dev)
> +{
> +     struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +     struct gpio_delay_priv *priv = dev_get_priv(dev);
> +     int i;
> +
> +     for (i = 0; i < uc_priv->gpio_count; i++) {
> +             if (device_active(priv->descs[i].real_gpio.dev))
> +                     dm_gpio_free(dev, &priv->descs[i].real_gpio);
> +     }
> +
> +     return 0;
> +}

Please can you add a short in-code comment explaining why the
device_active() guard is needed - a future reader touching this loop
won't have the commit message to hand and the guard otherwise looks
superfluous.

One related question: gpio_delay_probe() bails out on the first failed
gpio_request_by_name_nodev() without freeing the descs it has already
populated, so any partial-probe leak is not covered by this .remove
hook. That's pre-existing rather than something to fix here, but if
you're respinning anyway it would be worth cleaning up in probe by
calling the same free path on error.

Reviewed-by: Simon Glass <sjg@chromium.org>
