Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C09BCAC5BB
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 00:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACF48394A;
	Thu,  9 Oct 2025 02:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UVFaqwc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494E183987; Thu,  9 Oct 2025 02:25:22 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94D783948
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 02:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6394b4ff908so650802a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 17:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759969519; x=1760574319; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F3QMSwFsGIfVykKdbgBuRARnsu/rbOV0R5FL0vAbWrA=;
 b=UVFaqwc8YxgjWHIx0RUPBQdo4FkcvKfTwM0Pd1r8WWjphwsKy7mWJn6QwCLh8W6jr9
 uy7L9YOK/1KaTs3RwKPMxCk6op5qFFgiCnVG0oEmoUTvHYk4LIIFpS50TFYi2h4TDeN4
 XxDmtdtYyoA7xI0NdlFjs4+8yhZTo5RIsB7gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759969519; x=1760574319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3QMSwFsGIfVykKdbgBuRARnsu/rbOV0R5FL0vAbWrA=;
 b=PSVPT4V8A2gBFeai21EYbwyWbEX1axH0zmE6SzoxYlGkWkRzWce3iZC7Oo4aXX6taj
 NFpcbom5WrU59NsVvfRgIWFWFlnx5PmhrWlB9GEbt4Nzqml9z5CTW6x/rHA10x1CZL3+
 b7PzXgyZTbbJQ/kc1uidyKrYbBpDY4wK6YTBbFjavBR4Iv7F7rBVAE2Z8EqwHcYXJW3a
 bKmfLwqXG3QJWXFpzLfOUZNtnuR2eNkMMGOwQBsxDPoJz22iHEodO5hvl+Kh6WLsYbVf
 0UzCupeJ8ycKmiUyoEhQSEwdWhc+fH2BbrXkotWL9tiAtIO7r8+m9KXfn+q1i/pS0D42
 Ctcw==
X-Gm-Message-State: AOJu0Yw7g+rdU2tv32lV/Xk1wdyT2pa+vah/5rcb58TB2gzIMSPC34Vc
 LQLUfhkqbEUV4VKDlvB10pPPn35FhxTmk6lukvfw+m5oBnCg32s9mN+9WZ9rABsisuDMcW1YM7b
 Vw3IbU7cl8buZkvT6vGHArTFxqZt7LDNSZPfn5mtm
X-Gm-Gg: ASbGnctwKmOr7zmCedEmP0G7LSm3kDQuy8rLIiRR+d+Yr2SCzpBMQa7q3qBOlYxs334
 QwjS7OnihtnsMYd11wrg6wAZdJLAzd21VxJV1PrQlsvmhbQfhZmyfHrIiTg9Z2vixSpvtDGANib
 tFK85c9lddeXYVuJyjEy+GpkXoyL91Oe6uuU/KXMsJiOK9YRsoPuzDF+DuMDKG/rhWqKDdYcq+1
 kQV2PGswj9CCAX/M7QZv9Q+p7JpRM3v
X-Google-Smtp-Source: AGHT+IE3pn/HFPSQSOXCVTM/eGC3Pwh4HNXVYzSavlCk0rjdSbRQERDPLIleyC9DBjemRTJWnagXm2Gd3FB1DZBd+VM=
X-Received: by 2002:a05:6402:848:b0:637:8faa:9e0a with SMTP id
 4fb4d7f45d1cf-639d5c5a3d4mr4781026a12.30.1759969519109; Wed, 08 Oct 2025
 17:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
 <20251008-topic-interconnect-next-v2-1-c46e94dd328e@linaro.org>
In-Reply-To: <20251008-topic-interconnect-next-v2-1-c46e94dd328e@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 18:25:05 -0600
X-Gm-Features: AS18NWARD3XuapXVwTCk8VBnYEz7_VSkXeTq2jj1V5uDC00vkWGELu6-sz1uA1k
Message-ID: <CAFLszTi3cNihLKOvJhrm1GLYdxQKvkv-66Fdr6m90+vvdUtMMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Introduce the Interconnect Subsystem
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Mario Six <mario.six@gdsys.cc>, u-boot-qcom@groups.io
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

Hi Neil,

On Wed, 8 Oct 2025 at 09:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Let's introduce the Interconnect subsystem based on the Linux framework
> which is used to vote for bandwidth across multiple SoC busses.
>
> Each bus endpoints are materialised as "nodes" which are linked together,
> and the DT will specify a pair of nodes to enable and set a bandwidth
> on the route between those endpoints.
>
> The hardware resources that provide those nodes and provides the way
> to vote for the bandwidth are called "providers".
>
> The Interconnect uclass code is heavily based on the Linux one, with
> some small differences:
> - nodes are allocated as udevices instead of Linux idr_alloc()
> - tag management is minimal, only normal xlate is supported
> - dynamic IDs is not implemented
> - getting nodes states at probe is not implemented
> - providers are probed on demand while the nodes links are traversed
> - nodes are populated on bind
>
> Fully tested with associated DM test suite.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/Kconfig                            |   2 +
>  drivers/Makefile                           |   1 +
>  drivers/interconnect/Kconfig               |  10 +
>  drivers/interconnect/Makefile              |   6 +
>  drivers/interconnect/interconnect-uclass.c | 548 +++++++++++++++++++++++++++++
>  include/dm/uclass-id.h                     |   2 +
>  include/interconnect-uclass.h              |  74 ++++
>  include/interconnect.h                     |  81 +++++
>  8 files changed, 724 insertions(+)

'interconnect' is such a long and vague word :-)

There seems to be a piece missing here. The uclass should have
operations, so that it makes sense for different drivers to implement
the methods. I see some there, but also a lot of direct calls from the
test to sandbox. I see quite a few functions which lack a struct
udevice * - I suspect I am missing something?

We normally have a ..._get_ops() macro in the uclass header. Also we
normally have stub functions which get the ops and call the function.

I see code to remove children, but driver model does this
automatically[1]. Same with bind(). If there is a bug in this, can you
give a few details, or ideally a test case?

Also, please can you add:

- comments to the header file, at least
- something in doc/
- a command to list things / provide information

Great to see the automated tests!

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/driver-model/design.html#removal-stage
