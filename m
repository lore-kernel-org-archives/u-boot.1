Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F23E77351
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 08:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0266686AE1;
	Sat, 30 Sep 2023 10:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fYbTZAQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57F786B01; Sat, 30 Sep 2023 10:41:07 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F9C86AE6
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 10:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405497850dbso129259665e9.0
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696063265; x=1696668065;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=p73pORzZamKYX0Pryh8szCG8XmNews7sa8t1+yTEPO4=;
 b=fYbTZAQid3ZBStSQ9E02qdlDqMLCRagggeP8XsdKveVz47jjTi0FGjBuOIpKNEEORj
 t7X2PDG1KpLNTOg6M9vLnA/C8Zk13IPf8ofdke3u+w0JrA7ZWIoDPiDSVruc9P1vRpvQ
 DEsGo2ZnWCYwoLGXf+it4CGzKptaoxE6HDPxnKGRv0TJYlGcAShGOuL3oq9TmmgQ6sv+
 3DR60Sclo01HMnFpsotwit/zw2m6juigv6AdM7c+/veol89teybmwgtRw38SShbpzXGz
 9Hw3d+iZ4zN2bSwUCEUnIXJCXFicSFD/SMzKn7/hJWaOcPITGgCkaIKj9/70KdfGFNeR
 ykLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696063265; x=1696668065;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p73pORzZamKYX0Pryh8szCG8XmNews7sa8t1+yTEPO4=;
 b=W2vqvn2/pyDj40Z4IhoZXmc/az1stNhOTmtedlto2TqpX8jwl2PCYe/UmRQ5ZkJE5j
 W99PU+ZIUqdz+r71N8XCc+irE2DRFlGwvphovGUpUuWq8WJLbfaWdHOPFqveYPlaBiee
 fs4YM5l6vM+dATygeKaIV8CwiEzsgykXFQ+MWINGRzOr0J2RCKaoZBIt6mAwS42MrsmG
 pkJHQnkEVAMKgz4caRXslR5iAwJJ06mUFzvwyApewjfxlVSnBN7zBQ1PW4zZeKFIj8c5
 Oc9ygZoOdclKzG0ria8t5c5uLkMktu5xc7u/3cSnLYdQedhOqFrcRxDmd4RK2jtwoEJm
 W/6Q==
X-Gm-Message-State: AOJu0YwDSptlGhQcM2kcKhASmFZuSoUA+VKZclGQjsAKj8mbOVi54uMu
 +0Mnhz+wSLnGD+gDOOsAvWZFcg==
X-Google-Smtp-Source: AGHT+IEqHFEGHMQ9svg2ufZnYn/5hExvANV1snEmQgV+k5AitYXoBn8mjVuRxaYfBd10d8g4oONI2g==
X-Received: by 2002:a5d:628a:0:b0:321:6a61:e45a with SMTP id
 k10-20020a5d628a000000b003216a61e45amr6368353wru.15.1696063265203; 
 Sat, 30 Sep 2023 01:41:05 -0700 (PDT)
Received: from localhost (2a01cb06b0237dd3c01dd287ba46c248.ipv6.abo.wanadoo.fr.
 [2a01:cb06:b023:7dd3:c01d:d287:ba46:c248])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a5d490b000000b00325aca09ad1sm2768962wrq.24.2023.09.30.01.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 01:41:04 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Evgeny Bachinin <EABachinin@sberdevices.ru>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v5 39/43] command: Include a required header in command.h
In-Reply-To: <20230927142359.2965941-40-sjg@chromium.org>
References: <20230927142359.2965941-40-sjg@chromium.org>
Date: Sat, 30 Sep 2023 10:41:03 +0200
Message-ID: <87cyy02gv4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On mer., sept. 27, 2023 at 08:22, Simon Glass <sjg@chromium.org> wrote:

> This uses ARRAY_SIZE() but does not include the header file which declares
> it. Fix this, so that command.h can be included without common.h
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v5:
> - Adjust so this builds on azure
>
>  boot/bootm.c      | 2 +-
>  include/command.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index b1c3afe0a3a..8f96a80d425 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -8,6 +8,7 @@
>  #include <common.h>
>  #include <bootstage.h>
>  #include <cli.h>
> +#include <command.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <errno.h>
> @@ -29,7 +30,6 @@
>  #include "mkimage.h"
>  #endif
>  
> -#include <command.h>
>  #include <bootm.h>
>  #include <image.h>
>  
> diff --git a/include/command.h b/include/command.h
> index ae7bb4a30b0..34ea989b39b 100644
> --- a/include/command.h
> +++ b/include/command.h
> @@ -25,6 +25,10 @@
>  #endif
>  
>  #ifndef	__ASSEMBLY__
> +
> +/* For ARRAY_SIZE() */
> +#include <linux/kernel.h>
> +
>  /*
>   * Monitor Command Table
>   */
> -- 
> 2.42.0.515.g380fc7ccd1-goog
