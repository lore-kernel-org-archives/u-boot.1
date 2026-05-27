Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B5BCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 18:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A08847C4;
	Wed, 27 May 2026 20:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JSG6Ttbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C1184857; Wed, 27 May 2026 20:44:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12CD84704
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 20:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E8F73F877
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779907441;
 bh=IYKJYTTfiBZhExjbfe/LdOx6xy5R7CaX1sReYeq96OY=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=JSG6Ttbv83SWCCKDo37WREFBuD0hSgcYVJRGx9jNZNbPyjHokK5LcVYL/8cZg6UpS
 pxi6+ye1u+H1oJvB5Ky+ndZ4My7iu8FOxeXFbVC5yQpFyIINrCsLpxCEtbc59AbrO7
 5uTMgOhGKLwoKh6NrH4WaLDHK0KyS2Sids3tJjS7Wq3pAYEQKMebYvtN2okYcKSDb5
 sTh8e17smUVLXAFfh/G9pPBFrlZnhWT67ZibuF6FrLafRr2onyOxNKFz5oS327TenV
 zQZjOZSH7s1HKWl/TcJbFY7EdVlfS+8nxVF4P/Hst+/lum7HeSz504ElgOmh2LNCuK
 rBlZ7OX7K/gsU+wYuxSu2XsXppM/fPLp4AHSBuPgr1qJUUolxVWetaJX8cllmGq0vw
 VjmMj0hAP30y3DauUEa0UMJJiFG6EuFoTMB2TJ15tfeU6hO6op7LO5dwcWOzVepF9P
 dMVMX50gnH65m6S4v6fQZedZmbDapMb1/VJuDLoxpaDXzgPcPACkkv6ZjBMZCnrWGt
 M5CErG7paXY3hsuG+jaidhBs1xub3OLm3sXYon+qY2iAoj3k1ScAmT9zdI0vhuFlrU
 LmRR5qo9GboSZB24t6JIHiB5pUt00QffMi0kMQUQZqwCCVaBOSgSFSkzvjdcRJA82v
 PPamosivDuUFiaRua1nsHAkU=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44696b11265so14643545f8f.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779907441; x=1780512241;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IYKJYTTfiBZhExjbfe/LdOx6xy5R7CaX1sReYeq96OY=;
 b=GP9AE4Wkv2e+2tQhvFOsEi7LNsWW22Rm9qiiLMrAg9q4mT15Hx7Jja9u7Lrm1eykKs
 3PilmBukP6X/aJCRSSG7sNIbFuOFjFil7qte8x1Xyi+Ldm5jKCNCdmAHFV+x++a1h2qs
 vRrTRI5T/T78qz+eUvNElRFmovVRLlQeD4X8QEtTxQ9CiFfXvypG9xFFCYO4DsIcJnAz
 8+m8NBBIcLO8bHOELOKDkhLtdrpARXAY9JAw2V8vuZmdEwDp8eOfosb+1sxxv7nbt4vY
 dIgjwOAJdELVinA8zVRbE7ZvBU0n2I6WLqHGPlSszqMNpzeS69iYnoKQwtwEazyS3ig4
 JUxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OxxP0zkbz3GXY8SOpSfunEss3nPTjZTbfhbHeVKPX7e9aND8qmmvlZMAUm1bqQEcRNppZtlw=@lists.denx.de
X-Gm-Message-State: AOJu0YzY4en7zECWD4K5eMMZPojAyQveikuMcloQi56QZSn6z5hKW5S5
 nQitajXA/QvslzrlME0n0mKSxX/6aPHShmZoMHZn4PDdZcbzPZ2Kr5IVM128JmVGp4GlwPki4NH
 2Yw/c4gF9iFsGQrgtESX/a98WTS6gqCIqvJUq/fQjf/6ZNNJSdLPJE8OT/j1sL9gLHdJCXxA=
X-Gm-Gg: Acq92OG4w3htkuE0yCOUN4Nid992XSAc8tJhhRySKcJKn3unQAV1FU0uOC+1Cme/bR1
 2j6NZY/MhhJfGE665nmCL1hrA+1P8gXBVg7PTecRvhEcz5/4eZmgNsJ8ScngR7uFr3TBVcFdy6Z
 yxQ2ICgB+qVmNvcwYPbzT6L8EQwIIXZXdcXVj0onmiqspIJCTAZ8qaqJOf3S9asRIFqu5yqAM4x
 wh3/heI1wZQgtEZDUN/VcH/SFU9p/o8dC8Ln7hqKrA8PDCBJZaXZL0UK/jql7HGuRCzh1cBnjm7
 Dndlg+PUFmJKIFZKt5MlO3wcHJ8iRb+t4+dYAr48VGGC17A5P9f9hTd7lUOrROjmTCcLlHBPpiW
 bfBRiymwtL1sG2hpK9n1/fWGWfAJyDkoF/81BpqMXjcvb33BSYjnyUjZXsGVMhPoyR6A8WNqGbd
 eme1qLtb0ByrWFLnpWgFHmp6BIJmtbTIkbtIDS8lSnVTmnT+N6SQ==
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id
 5b1f17b1804b1-49060cb57b1mr279233105e9.28.1779907440765; 
 Wed, 27 May 2026 11:44:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id
 5b1f17b1804b1-49060cb57b1mr279232715e9.28.1779907440339; 
 Wed, 27 May 2026 11:44:00 -0700 (PDT)
Received: from [192.168.103.110]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454b7d57sm420860785e9.15.2026.05.27.11.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 11:43:59 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <11494d67-cda8-4ae4-9c31-4250166c0a43@gmx.de>
Date: Wed, 27 May 2026 20:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] virtio: Set the log-category for all drivers
To: Simon Glass <sjg@chromium.org>
Cc: Angelo Dureghello <angelo@kernel-space.org>, Bin Meng
 <bmeng.cn@gmail.com>, Christian Speich <c.speich@avm.de>,
 Daniel Palmer <daniel@thingy.jp>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-11-sjg@chromium.org>
Content-Language: en-US
In-Reply-To: <20260527161033.3273795-11-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/27/26 18:10, Simon Glass wrote:
> Most drivers have the log-category set but not all. Fill this in for
> the rest.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

I can't find any use of logging functions in the changed drivers.
So why change them?

Better remove unused #include <log.h>.

Best regards

Heinrich

> ---
> 
>   drivers/virtio/virtio_mmio.c       | 2 ++
>   drivers/virtio/virtio_net.c        | 2 ++
>   drivers/virtio/virtio_pci_legacy.c | 2 ++
>   drivers/virtio/virtio_pci_modern.c | 2 ++
>   drivers/virtio/virtio_ring.c       | 2 ++
>   drivers/virtio/virtio_sandbox.c    | 2 ++
>   6 files changed, 12 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e66b8d244fb..496d26b4dd4 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -7,6 +7,8 @@
>    * Ported from Linux drivers/virtio/virtio_mmio.c
>    */
>   
> +#define LOG_CATEGORY	UCLASS_VIRTIO
> +
>   #include <dm.h>
>   #include <log.h>
>   #include <virtio_types.h>
> diff --git a/drivers/virtio/virtio_net.c b/drivers/virtio/virtio_net.c
> index 71e4d251396..7a94c8a528f 100644
> --- a/drivers/virtio/virtio_net.c
> +++ b/drivers/virtio/virtio_net.c
> @@ -4,6 +4,8 @@
>    * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
>    */
>   
> +#define LOG_CATEGORY	UCLASS_VIRTIO
> +
>   #include <dm.h>
>   #include <net.h>
>   #include <virtio_types.h>
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index fe3e3b475ea..4713c12e7ac 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -6,6 +6,8 @@
>    * Ported from Linux drivers/virtio/virtio_pci*.c
>    */
>   
> +#define LOG_CATEGORY	UCLASS_VIRTIO
> +
>   #include <dm.h>
>   #include <log.h>
>   #include <virtio_types.h>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5850e0c18c6..4ce68920c6d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -6,6 +6,8 @@
>    * Ported from Linux drivers/virtio/virtio_pci*.c
>    */
>   
> +#define LOG_CATEGORY	UCLASS_VIRTIO
> +
>   #include <dm.h>
>   #include <log.h>
>   #include <virtio_types.h>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 3a40b12f6e5..17e351ca2be 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -6,6 +6,8 @@
>    * virtio ring implementation
>    */
>   
> +#define LOG_CATEGORY	UCLASS_VIRTIO
> +
>   #include <bouncebuf.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/virtio/virtio_sandbox.c b/drivers/virtio/virtio_sandbox.c
> index 0f1ebef22e5..6767e5bd5fe 100644
> --- a/drivers/virtio/virtio_sandbox.c
> +++ b/drivers/virtio/virtio_sandbox.c
> @@ -5,6 +5,8 @@
>    * VirtIO Sandbox transport driver, for testing purpose only
>    */
>   
> +#define LOG_CATEGORY	UCLASS_VIRTIO
> +
>   #include <dm.h>
>   #include <virtio_types.h>
>   #include <virtio.h>

