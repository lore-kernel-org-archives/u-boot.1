Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9794D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F5189555;
	Wed, 20 Nov 2024 14:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dWTn5lqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39AE5893F9; Wed, 20 Nov 2024 14:47:22 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A7E895F1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21260209c68so6396375ad.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110438; x=1732715238; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d4OD/EazqY26aNpzScRzbmhyP6/8Ec3apNHB1EG6Fo8=;
 b=dWTn5lqkAc9Qbc8+uvjb4BNQl+TRFnuMTfgdcIbCb5VVRZMXp/eMlSxHt0peG8dDAI
 8sY7mRA1stiAJVkWZM0VE5NbAZCAZuBId1vpThKAbBmWjGWFQ/576tht1iYDT8qLrGe6
 mVJexg1bHA6sR3TWJ6gcBalggQ1Yk4DB3ZJ+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110438; x=1732715238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4OD/EazqY26aNpzScRzbmhyP6/8Ec3apNHB1EG6Fo8=;
 b=CmbH7tudJRELYo7PonzggWsFxe1HaF6TXyFyON5tOWTwRD8o8XCsYBixFzdN1eT3Ry
 YOdH+FdMy4Bybpf3FlsSSnviivoPB6jujq6ZL4s3UFEmkP5olX7wOGqqvM/4QSnXsjpK
 //plbFtbDCrMGoZjtecnXpG4HL4Iz00SjAalcEdmPIKBDYqUQzZBJpzbc9qzhw9QKvJ/
 fekZQgaf7grvCop8/4E2WkMpqryRv7cLerFeOKGu/VWuCE4Td1rd2xw/ygdKoJA2wgYl
 ANckIm2Epx8qbnB5wAWJPa7jQ8Sd/9UuaKOoTYuFpPiURH2nkEolkSvXrdk8LQ6gfxOq
 n8VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZw+pkBo79VDDprOZ8DR7R34Kdt9bmWolr8r+xGy9DGM+o2A4pAlMpYJCHtQw5FaQdfE84oDc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/MUGq8Y+CEIAFXCLqmjtjs9t5FxpQutJ0rNngMM6a1wH2WrFF
 uM0TOdapWbG7HTXzML6abEFWQdzoOZbQAo/W4wCmILDDS9J7ZMCShDg+r11QFfOt5zlU1XDqOg8
 HELAYUOQGNJ9oh7gunE4hwWMuORDAmKTu7z8a
X-Google-Smtp-Source: AGHT+IGt9yhOyr1u/ENMB8ekQZqeFSL1ZHIV+/xf7jt2dP1BWewhuQ0yXUMDyWWV+iolFDB5lUZYHmjn4QH5UPEVlIg=
X-Received: by 2002:a17:902:d504:b0:211:fd79:568 with SMTP id
 d9443c01a7336-2124d085619mr115056305ad.19.1732110438360; Wed, 20 Nov 2024
 05:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20241109180038.10344-1-ansuelsmth@gmail.com>
In-Reply-To: <20241109180038.10344-1-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:46:51 -0700
Message-ID: <CAFLszTiNUmogWo1Ok61uOrOtOdtqR_GaxGyEsYBFgdGfQxrUZg@mail.gmail.com>
Subject: Re: [PATCH 0/8] led: update LED boot/activity to new property
 implementation
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
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

Hi Christian,

On Sat, 9 Nov 2024 at 11:01, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> This series is split in 2 part.
>
> While adapting the LED boot and activity code to the new property
> accepted by Rob in dt-schema repository, a big BUG was discovered.
>
> The reason wasn't clear at start and took me some days to figure it
> out.
>
> This was triggered by adding a new phandle in the test.dts to
> introduce test for the new OPs.
>
> This single addition caused the sandbox CI test to fail in the
> dm_test_ofnode_phandle_ot test.
>
> This doesn't make sense as reverting the change made the CI test
> to correctly finish. Also moving the uboot node down
> after the first phandle (in test.dts the gpio one) also made
> the CI test to correctly finish.
>
> A little bit of searching and debugging made me realize the
> parse phandle OPs didn't support other.dts at all and they
> were still referencing phandle index from test.dts.
> (more info in the related commit)
>
> In short the test was broken all along and was working by
> pure luck. The first 4 patch address and fix the problem for good.
>
> The other 4 patch expand and address the property change for
> LED boot/activity.
>
> Posting in a single series as changes are trivial and just
> to speedup review process. (and also because the second
> part depends on the first)

Thank you for digging into this and figuring it out.

>
> Christian Marangi (8):
>   dm: core: implement oftree variant of parse_phandle OPs
>   test: dm: fix broken dm_test_ofnode_phandle_ot
>   dm: core: implement ofnode/tree_parse_phandle() helper
>   test: dm: Expand dm_test_ofnode_phandle(_ot) with new
>     ofnode/tree_parse_phandle
>   dm: core: implement phandle ofnode_options helper
>   test: dm: Add test for ofnode options phandle helper
>   led: update LED boot/activity to new property implementation
>   test: dm: Update test for LED activity and boot
>
>  arch/sandbox/dts/other.dts |  33 ++++++++--
>  arch/sandbox/dts/test.dts  |  16 +++--
>  drivers/core/of_access.c   |  61 +++++++++++++-----
>  drivers/core/ofnode.c      | 118 ++++++++++++++++++++++++++++++++++
>  drivers/led/led-uclass.c   |  30 ++++++---
>  include/dm/of_access.h     |  86 +++++++++++++++++++++++++
>  include/dm/ofnode.h        | 107 +++++++++++++++++++++++++++++++
>  test/dm/led.c              |  18 +++---
>  test/dm/ofnode.c           | 125 ++++++++++++++++++++++++++++++++-----
>  9 files changed, 539 insertions(+), 55 deletions(-)
>
> --
> 2.45.2
>

Regards,
Simon
