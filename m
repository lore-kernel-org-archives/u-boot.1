Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D46C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 09:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36DB6875A5;
	Thu,  2 Nov 2023 10:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="goWwVLkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C20F87719; Thu,  2 Nov 2023 10:15:21 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C8E7875A5
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 10:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso375345f8f.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698916516; x=1699521316;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XWoPrFglO5KjhNaCBpsJ5/W9cx2ugwb2e+GXIcXU5SU=;
 b=goWwVLkr64E5vVD0ZB4LFfpVR2w+T7UzfETwdHs+4DYeqlORPdVT+zlSn6+g1hxvrC
 3MJ0rZ9biI8xF9IpUy+p5Y99CV2ua9LGFASH2OcW2dw2N+7uXbN+AXnP04e1ElIofSQW
 qkHEOwkvvwKics1RaQSS1XMzDH5q5QQ5W1TLWRMmge9CmgYYX0htZqV5AZ6KdJ50zBTZ
 LjYz0Li6gBfAAfaiQea/w7s2xk0DhJvKZDGVfX51TL3tauj+gtqqJU3pI9WuUonvueLA
 LEZrds/rXsgHQCaDE81tAE2M1WWsAIktGrcA5jYjrApsCrpsOdZQvo1M99w14xuvQRth
 D7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698916516; x=1699521316;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XWoPrFglO5KjhNaCBpsJ5/W9cx2ugwb2e+GXIcXU5SU=;
 b=XuiDJRfsgL9dKv1ezm3AWxH6J4sujplqEGBY9870/mNU4T8M9tfqcGWiHrYBOuEEPS
 dF5x+NKYN/WP9GQ3xb9L2wR9NVzH2of4xHavjq8v9pk6AhIGhhDXKGtIoYj0O8qKWRWp
 oWUCrhsa5yS4lu05dggoWArEdiSpLR8NKdEXwEykUvGuhyfWf5C6d/EIzWPLih3JteO5
 aMc/n1PCGX9ySFZCTayWq+01saYKR1k+rrKsxdDpT0cRSgAt+eKtB+DtaYOcoyKYUSsr
 xhzimQ9cy8J6CXG+vd7sspoKnZLHZeVa3VaqqOnEfxzDhC3rulCWTWN3kJIuqb7Mnnf5
 QLSQ==
X-Gm-Message-State: AOJu0YyL6zPiqOe6MASktDb0qtrp8T8GEQVDWGRG9PvKaIrZ8t9d3EM3
 xHFhEaP22KBy/g9ZkP4imJDFIw==
X-Google-Smtp-Source: AGHT+IF3K3MjmuauBU28pOcvq1S0ItB/ITqeA4AcogyZ2VWSjZ45uVtqyONU127yAzAH0lMClsQ0bQ==
X-Received: by 2002:a5d:4fc9:0:b0:31f:9b4f:1910 with SMTP id
 h9-20020a5d4fc9000000b0031f9b4f1910mr12623883wrw.63.1698916515849; 
 Thu, 02 Nov 2023 02:15:15 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 g8-20020a5d5548000000b0031ad5fb5a0fsm1883143wrw.58.2023.11.02.02.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 02:15:15 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: lukma@denx.de, u-boot@lists.denx.de
Subject: Re: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
In-Reply-To: <169876380794.37728.2863914527348419844.b4-ty@baylibre.com>
References: <CGME20220620111357epcas1p103474818319b5dc45260e043b4ffe3cc@epcas1p1.samsung.com>
 <20220620111354.448512-1-jh80.chung@samsung.com>
 <169876380794.37728.2863914527348419844.b4-ty@baylibre.com>
Date: Thu, 02 Nov 2023 10:15:14 +0100
Message-ID: <87h6m4zfbx.fsf@baylibre.com>
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

Hi Jaehoon,

On mar., oct. 31, 2023 at 15:50, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi,
>
> On Mon, 20 Jun 2022 20:13:54 +0900, Jaehoon Chung wrote:
>> Add CONFIG_DFU_NAME_MAX_SIZE to change the proper size.
>> If name is longer than default size, it can do wrong behavior during updating
>> image. So it need to change the proper maximum size.
>> 
>> This patch is proviced the solution to change value with configuration.
>> 
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>
> [1/1] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/de9b2e10f10996050a10998a0836abe2f9e425e3


This patch breaks CI for both arm32 and arm64 platforms:

* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/725163
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/725164

It breaks because multiple boards which include dfu.h without having
CONFIG_DFU being set.

Tom attempted to fix this with:
https://patchwork.ozlabs.org/project/uboot/list/?series=369275

But that had some different issues, see:
https://libera.irclog.whitequark.org/u-boot/2023-10-31#35154532;

I've fixed it up with the following diff:

diff --git a/include/dfu.h b/include/dfu.h
index 4573f753c565..2c3ffa3f9297 100644
--- a/include/dfu.h
+++ b/include/dfu.h
@@ -99,7 +99,12 @@ struct virt_internal_data {
        int dev_num;
 };
 
+
+#if defined(CONFIG_DFU_NAME_MAX_SIZE)
 #define DFU_NAME_SIZE                  CONFIG_DFU_NAME_MAX_SIZE
+#else
+#define DFU_NAME_SIZE                  32
+#endif
 #ifndef DFU_DEFAULT_POLL_TIMEOUT
 #define DFU_DEFAULT_POLL_TIMEOUT 0
 #endif

If you have a better idea to fix this, can you please let me know?
Otherwise, I will squash this to keep CI green.

Thank you

>
> --
> Mattijs
