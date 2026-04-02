Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94796D39422
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 13:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E958408D;
	Thu,  2 Apr 2026 15:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AXQshvrx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F212C8408D; Thu,  2 Apr 2026 15:37:36 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2FDF839DF
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 15:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9a0762ed5fso140647666b.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 06:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775137054; cv=none;
 d=google.com; s=arc-20240605;
 b=DraXNoblGjoYTY0GmjjPUkJy3z3nfXALd7yBrnTrUVDK1DqXTFJMGtMz3ruuuP2/VL
 N8BcLtYALUtSIaRNmrqZoq730+mYg/PUiJmysYmajhH7mxYZ8wT2f1jNPNjszbgluZdL
 a6IkjYbLakJzpiTrA5MyNVVpzhOd5qKe2eCpuAK1tqKACMFYnpx3mcvPu8cmjg+0YDNz
 BmsdBUAyYPnn0FvtaOGjoMrwn7FXiXaV5Q0aL7+q0F0Sl2s4RJOBbyG3V75HhEp5gl+g
 WtbSNT/gzshsiqJvQYw9cdnxds6ujlyw+UwnRtjcPXp/t0mwMpHdQD/jtoEbFXuIn+yf
 330Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Dbo7sFyDXejGGCog0CY7NW2PuCXT7AGvqCe7WGU3sXM=;
 fh=TMhL9ER88JxMwD5Aj81QfGRuuSvL8Z9mvNybV8GT7fU=;
 b=cPFkKMkH0ZgsamGhwvlVxSiXiSDtZmfPIf8SGqynOLAp83FR16QmBhp4Zaq3y8yvIu
 Ks3CYHXfsH0uh19X95IEmRWjAtPgsu0B2WBF25FfoMJ7rCErpN3uEij5u2/7nWnKRTtY
 ysawRcfioSx/kM7x5qMycjQa/SNAcv8SjWq56oC2XsyA3N2ODI/FUwQqdwasof/7I20S
 ogYZN6LYB9+F0Wgya7GdzMfna/HT6GGanfYdBfQS3FO8M755E+7WS638/3cSFyKtqJnl
 3XulPAhBp8PAJrlmo90K02NYt2iji+Zo5UZab6RSOmxyc42xU+RAomfD3NgeIKz6W0V3
 TSkA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775137054; x=1775741854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dbo7sFyDXejGGCog0CY7NW2PuCXT7AGvqCe7WGU3sXM=;
 b=AXQshvrxE23NImX8nygrS/VbJ+GYSbhgs/pHPJDCf3nWZKCPyoPE2eG84D9I3p2jBJ
 x9I0PhYlbajtNh4z+Br4nDUCtPa7A68yiNrPIDi4xe1QYb3CFmTmGWzNWlT4jadTvprX
 mz8rzCHegspRp2+veeJihpjnmkZxCoKbvR/nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775137054; x=1775741854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dbo7sFyDXejGGCog0CY7NW2PuCXT7AGvqCe7WGU3sXM=;
 b=VKPpu7+hkt7wJjJyzB442fqL7I9YByd02nvQ07l9nOZL6fRVST3EFcTs27KNgHKimS
 UPPic2Eb1tYSeFQKgsmfjyQUVcAvpxd3VWiTP+6wg9Uolf1x658vwMPdi7COnYn50xao
 BfUWFlOE4DdiYHOvTldcRbD91bixOg2StzsQMYU6bOxrk7IlFZuJdmrDQ9ULbT7VCpSC
 Ox1zO6+HjhzzLdxXKOqdLA0VuMcWUqvkPkCstDOIZx3uw2l28QNz/eRkJBPO/jXpRUwP
 8O06gMlYNXrqIzURkBEprq1HcClRsGZSQUF6sx1REUQMasXhS9ppfkoszUCpCL+FJhzR
 pBiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkAWd8gyhonv6TGjpYaYbHhn0OIJnlErrStahbFjlRPQ9sOUypnDMqQSTXhMLj3Vapi6h2Gj4=@lists.denx.de
X-Gm-Message-State: AOJu0YxBl8/2F/5EJqBcnJ1kzyvXYjqBjZlVGq+AoyHuTiLDW0a5DJxG
 6S8VEl5wZa3k8Ev7sGIVW1VtbsOptDD4QknLySkiaaCeBQwRp3ptEHB1ZGcow7EkUcsOxulcZTC
 lo97hklmHJj4Eqxt3sbOZ1gAiSiFvA3fKVtslXn+K
X-Gm-Gg: ATEYQzxqNJ0Bg9ijcTqDINGDD4o0XDrckLgPPiPeiQleZZj2iX4hXWYzWRrERK+2OyF
 8KWLc1M7MlORHEBEqHyZyiRK83Z37x7wNnxE+ySLs+Xg7VRodoE46yKKR0C4MArT0y0M/6Y5sD2
 XkNkP5A4h95G7vun7A91RrSCzcE2m+HIIqgNZHr6iAIzNblMqlZ1g0f8jmOHbpvBSQHYWbWmDUE
 WVIlZUg9hLXQulzF7eePdLXHTfbzOsBVvZTWjY+pk6ylvtEXip2rMyjQ61T44LBf3C3nYe1AOcd
 V+iwtQ==
X-Received: by 2002:a17:907:3c88:b0:b9b:9e51:ec9a with SMTP id
 a640c23a62f3a-b9c46de6617mr105663366b.7.1775137054361; Thu, 02 Apr 2026
 06:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-5-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-5-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 07:37:22 -0600
X-Gm-Features: AQROBzBwpGnwM3xqQcuplvVHHglYgfC2RWJbFwmWmKLdQPI4Te1FRf-1BXi5J4k
Message-ID: <CAFLszTibji9gQMXi93byZynAZXr_7Y5pAX3Zhg1kSV_o0TD9=w@mail.gmail.com>
Subject: Re: [v3,04/15] drivers: crypto: add software ecdsa support
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/drivers/crypto/ecdsa/Kconfig b/drivers/crypto/ecdsa/Kconfig
> +config ECDSA_SW
> +     bool "Enable driver for ECDSA in software"
> +     depends on ECDSA_MBEDTLS
> +     depends on ECDSA_VERIFY

Raymond has already pointed out on the cover letter that ECDSA_SW may
be unnecessary given this is a MbedTLS-only solution. If a future
non-MbedTLS software implementation is anticipated, this separation
makes sense, but please consider his suggestion to simplify and use
ECDSA_MBEDTLS directly.

> diff --git a/drivers/crypto/ecdsa/Kconfig b/drivers/crypto/ecdsa/Kconfig
> +     help
> +       Enable driver for ECDSA operations in software. Currently
> +       it supports multiple ECDSA algorithm.

\ No newline at end of file

Please add a trailing newline to the Kconfig file. Also "multiple
ECDSA algorithm" should be "multiple ECDSA algorithms" (plural).

> diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
> +U_BOOT_DRVINFO(sw_ecdsa) = {
> +     .name = "sw_ecdsa",
> +};

This file also needs a trailing newline.

> diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
> +#include <dm/device.h>
> +#include <linux/types.h>
> +#include <u-boot/ecdsa.h>
> +#include <crypto/ecdsa-uclass.h>
> +#include <dm/platdata.h>
> +#include <crypto/internal/ecdsa.h>

Please sort the includes alphabetically as per U-Boot convention. Also
<dm.h> is the standard include for driver model, rather than the
individual <dm/device.h> and <dm/platdata.h> headers.

>     drivers: crypto: add software ecdsa support
>
>     Add an software ecdsa driver so it is

Add a software

Regards,
Simon
