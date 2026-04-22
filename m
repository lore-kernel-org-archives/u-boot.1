Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86062F94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 00:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD23B8412A;
	Wed, 22 Apr 2026 02:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PIo8ILuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BA184198; Wed, 22 Apr 2026 02:12:18 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8888352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 02:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so657332966b.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816736; cv=none;
 d=google.com; s=arc-20240605;
 b=I+Af/F+Pl1wgAnB33jcf8loQk03An+EDRPxQlBD3bxDCKRhe6m1CNOEvW5VvD720mP
 U20k9wEPcTDoGzmueaoe8hlspWoTScTDEBx0pxzJ3ophMcn0T9iRz2iPCJ36iW4BaF9i
 oqPGYCPzTc8tq2YTAJ3zEWc5bEy2cyz1HLhqBaWfq/uVsdlSKm0acbALrouU2IP7Qadp
 5TN0CIw74lpxyQ1lEoJoQuKjLB5/qeerSxKnam8/ytzrm8iWL9ny0c16/Xu2TtTbQtUD
 zJUADqoMaBSBnG71xPK9scTWqDB20udrviPIxzsDlshUHfnBWvdvCbyYGHg33cKI1AsC
 ANOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d0fn4JTiBcL/Or/JqFPUv5LhQmQpXkuYxJ/udobwL+Y=;
 fh=I6CTiDPzeA+BW8DYWutm03yjh1GNqU0SVuKgjx4bg08=;
 b=euhP7nlFR/rzZf2emFhrqL1YFSDDZWXsrwWRR1RCgxs5NXGr2Kc/uvJFePRnT1cvLb
 uOVB37GlxmxwEnEX6bu08b9aZ8qWSK8DW+a9oIMmcQZNGDd8/tKnWltsq82Pvmdo2lz9
 gxvjK3SlR+2kN17Eplual24LTL8NrOkXVU5bhKCdo5PyrEybJkAXEOil1g3452NKYm84
 YHz4GYUAzQv+qhJ6WpM1H4dvLUztJaVCyeTHHgV6irm0hTHHwxlykF/eY1fJX7eplONa
 jiLZ5OpnqrNdEDFGLqe35+1o3uMmZkKv+m+xh3Zh3cyeXktJFbGbAsmCWc3aSSdlErG7
 /s3Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776816736; x=1777421536; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d0fn4JTiBcL/Or/JqFPUv5LhQmQpXkuYxJ/udobwL+Y=;
 b=PIo8ILuD4u45qBgJPdtNuQ+HlXGHMbwRXR2vjehwoh6oTmYSzfjtKcfpsn069YHHII
 RBtTh+JLB//dIlT8qJ5EgPiYDg3Wb3AJlEqlDx6Og+dBW8f9oxqxitVPmskoqZ/1edwS
 LoG6B1qNY16HTJASw9DzoZLOlFmLEWiQ0SwTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816736; x=1777421536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0fn4JTiBcL/Or/JqFPUv5LhQmQpXkuYxJ/udobwL+Y=;
 b=hQM4Oz3B2x79rz+Klit4EUtQxbgwdJszl1a0zYJXtUccVxafkEkRgW/utvDTw+ioRp
 EMawUiSOvcCrg6UIrExfYIMdtrjM7HiRkox9dTU05YVlEwp6JRmqIlFliFA7x05kV7DX
 DSXjir6sigziPWkEo9QZwxOLU1GhFtSpOCizY5f41ZT37sqFpe0hzTPqCPD4jl1tiFpm
 /O9bGgsL5HOuWZPLLvNRcHrNayfZThD6y8T0P+uuSpclMXteVksqM6n2GF+5d8JJVkRS
 dgufvkjm3GFBLOaKPQuiUD1AStlYBfRx7nWzpFq8QFO12EagexqOto05wDICGV0PD/RX
 RuHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9b5IXNmYjr1NJOuLkJv56WWVAuxQnDj8srx7eccM6mCSmUOhKDLw1G86POqYYnIJyAgdUjZ1Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzilD6oFvS0xJ0qQo0ara7V6sAsU4g5Pj9svtNDgSsx6vYJFXXz
 0Y61BrwB6wRpCITU2WtlIY9MyE1AAOztKLC03zTwSOu2c6F0pUC6DNTWMw2LM/nbYSvS2m7frAZ
 2nQw0YPwV3VpDaYbziedNPPdYuDQ0C+qtuIWBp9pi
X-Gm-Gg: AeBDiesUH45wRqYMY1+tkqe9Gar3E5xXDVtNjh8geEulO9+lzwDARBSg5iHTdyqjf6H
 2qmRo0kCAoeSWDyF9uUEOfY3ByVqMSZY18/XV1LqiOmX2+pxCa1mPlsxG2/PLGXbvyQbZ1iMZab
 ejZ6RJApCtFOH+dETdAoPKXvuAv4MY0HtJ7/qfCJ2Z5JbdwgW6ewF2sydeua06/W0nKCllG+9/W
 JuO2QZzZHXmxwBfq2valPGUiO0AVLS+MqMzjlEMqDnW10AIyuMRnJ8nwgOnbMeJgnGnE9sKsqOi
 yq9L5B9TEqqc5pn8bBjk
X-Received: by 2002:a17:907:980e:b0:ba8:30a6:c35a with SMTP id
 a640c23a62f3a-ba830a6c3acmr483601866b.6.1776816736165; Tue, 21 Apr 2026
 17:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-6-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-6-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 12:12:03 +1200
X-Gm-Features: AQROBzDguFxO3A5q22yNc24y752FWW1iVVhtC9uvg3gKzqc2K2Kf-dhv9UHqYtg
Message-ID: <CAFLszTiAH2fqYyzhDz8LQMtN6Y5d2jXZzpzKXD_kMhCSP0=LtQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/15] drivers: crypto: add software ecdsa support
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

On 2026-04-21T21:09:51, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> drivers: crypto: add software ecdsa support
>
> Add a software ecdsa driver so it is
> now possible to use ecdsa signature on
> board without ecdsa hardware support.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> drivers/crypto/Makefile         |  1 +
>  drivers/crypto/ecdsa/Makefile   |  6 ++++++
>  drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)

> diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
> @@ -0,0 +1,33 @@
> +#include <crypto/ecdsa-uclass.h>
> +#include <crypto/internal/ecdsa.h>
> +#include <dm.h>
> +#include <linux/types.h>
> +#include <u-boot/ecdsa.h>

The include of u-boot/ecdsa.h does not appear to be needed - this file
only calls ecdsa_hash_verify() which is declared in
crypto/internal/ecdsa.h. I may be missing something though.

Reviewed-by: Simon Glass <sjg@chromium.org>
