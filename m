Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91B5D16816
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AED684166;
	Fri,  9 Jan 2026 12:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VdYmImyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA6984166; Fri,  9 Jan 2026 12:33:29 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92BD983F56
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c026e074373so2133452a12.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958406; x=1768563206; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PS3sAAgdKhrKKnd6BZzky0GYORmDq4zNYbEYodqMEBA=;
 b=VdYmImyCessrJ+P++PbtfUYv0lG20202oh/4dZ9l4jBIwshmNa+Ij4nvR/5m9hnRjt
 yPDotZxjvM0AtQXGK46v+g6NfcpXrTdVg8TaXDPxoV8gxKDjErUI+7V0nm4io0V2eASu
 L6Wd7svcuEe9TOXWFutrpqo8/+9X+W2ZFF00s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958406; x=1768563206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PS3sAAgdKhrKKnd6BZzky0GYORmDq4zNYbEYodqMEBA=;
 b=IaeE21EChewfvhnqjmMgaaAFQ3dgh8EMY/QAyf/d5qNd4M6tbBD17tQ7pUZDbpIEZT
 Zymh0HolsEpp9kFfrUAaMu2iOT9gmZuH6GjPNQengCdBy/4X1Eh30r7EAnQLkxlpTNcV
 BBs+oFHX06G9+YEKEZB0hVUK57pB9zu1h6Jtf8KL84kAiofmbWZPDWSBWD7o+kKjLMFQ
 z3xIrV3qW3qLYSVtf2fhgBrcgw9XhnOZYgBb2HjIyFcsNXkXzlXDibWZ/7l3yj8mfyRS
 NqYpHWzh/Pl6d0v7mo1xboDSRlsEim+nM+FHSrWD/j/ihhVVUTrKFt9G7pxuPeR0Yvlc
 USNA==
X-Gm-Message-State: AOJu0YyH0Ch0nJm5mLGc1wYIEa48sCkVPiM+/MvhMXHrlG+MFh/EVSYr
 UeheSBRqC4u9uIvtJxr0YfIkA3ZDuuvmsEy3QGzWWAMjGWPOYV56EIEISTpMzIlts9ZQI8aYW+b
 +01ubKrs/AvhMxy18bOC6BBWmGihqT6X0d7ZdhWuw
X-Gm-Gg: AY/fxX4A5muOv+VwK/1CjXadX1H/ovjPzYpAVdGnKh5YN5NyxS6ZAVNBpS1uRmeUG7g
 ShLzneaMVi6G5NVZjexJoSx/i52dImO5XIITr2etHczFjueKSv2/d8rl6aw5CjFo67mfN+E2feU
 Fy5VETZMaaQ8yLYiSVjefUUJSBVdoRGkpcU/H++wOF0oWFEbs/ffYkzp1pWCQI9R2B6CUOrUANF
 jErv3sWTxLWfqYdlRcZb5btquFvMTgf8xwc9gdDwDjzgEVukm1ohiKpTs3JHztLY5TVMw==
X-Google-Smtp-Source: AGHT+IFhFXpu8UF7V/+2wSwQ+BIEbDLee3hZultMosYCG8t4WYqpkvb1uZ9+9VBPVsVXGnnvTyOFZOFbu9Ho5XZkxgI=
X-Received: by 2002:a17:90b:17cf:b0:32d:e780:e9d5 with SMTP id
 98e67ed59e1d1-34f68c001afmr7717404a91.22.1767958405897; Fri, 09 Jan 2026
 03:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
 <20260108-topic-musb-probing-v2026-01-v2-4-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-4-2a47c6e0e73a@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:32:36 -0700
X-Gm-Features: AQt7F2pbiQ5rtWRRYtsE-70DfAXXbaU5AvGqljkZX787wbtkizoQn9Hg0D4zBMI
Message-ID: <CAFLszTjav_oJwQom-J7m_hoJ4HU-U0DDodpSF08R+Fwfi9Bchg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] test: dm: Add compatible multimatch test
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>
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

Hi Markus,

On Thu, 8 Jan 2026 at 04:17, Markus Schneider-Pargmann (TI.com)
<msp@baylibre.com> wrote:
>
> Add a test for binding of multiple drivers with the same compatible. If
> one of the drivers returns -ENODEV the other one needs to be bound.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  arch/sandbox/dts/test.dts |  4 ++++
>  test/dm/core.c            | 15 +++++++++++++++
>  test/dm/test-driver.c     | 25 +++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

nit below

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index a2c739a2044c728a96b5f4acbf439a42d7e12fb5..9cc854ffe80e994e34010e299029a7f1756697e0 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -457,6 +457,10 @@
>                 mux-control-names = "mux0";
>         };
>
> +       multimatch-test {
> +               compatible = "sandbox,multimatch-test";
> +       };
> +
>         phy_provider0: gen_phy@0 {
>                 compatible = "sandbox,phy";
>                 #phy-cells = <1>;
> diff --git a/test/dm/core.c b/test/dm/core.c
> index 53693f4f7ed7c7265218e4154ebf81a044a3a431..78ee14af228ab20a6639bb076260296adaea2c92 100644
> --- a/test/dm/core.c
> +++ b/test/dm/core.c
> @@ -1410,3 +1410,18 @@ static int dm_test_try_first_device(struct unit_test_state *uts)
>         return 0;
>  }
>  DM_TEST(dm_test_try_first_device, 0);
> +
> +/* Test that all drivers are iterated when bind returns -ENODEV */
> +static int dm_test_multimatch(struct unit_test_state *uts)
> +{
> +       struct udevice *dev;
> +
> +       ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "multimatch-test",
> +                                              &dev));
> +       ut_assertnonnull(dev);
> +       ut_asserteq_str("test_multimatch_second", dev->driver->name);
> +       ut_asserteq(2, dm_testdrv_op_count[DM_TEST_OP_BIND]);
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_multimatch, UTF_SCAN_FDT);
> diff --git a/test/dm/test-driver.c b/test/dm/test-driver.c
> index 759de3a5f77f4b64ea577a293586a737e4623f60..bf953d7814df6a0e6efd6c2a3960a925a3fbe5a7 100644
> --- a/test/dm/test-driver.c
> +++ b/test/dm/test-driver.c
> @@ -197,3 +197,28 @@ U_BOOT_DRIVER(test_act_dma_vital_clk_drv) = {
>         .unbind = test_manual_unbind,
>         .flags  = DM_FLAG_VITAL | DM_FLAG_ACTIVE_DMA,
>  };
> +
> +static int test_multimatch_first_bind(struct udevice *dev)
> +{
> +       dm_testdrv_op_count[DM_TEST_OP_BIND]++;

<blank line here>

> +       return -ENODEV;
> +}
> +
> +static const struct udevice_id test_multimatch_ids[] = {
> +       { .compatible = "sandbox,multimatch-test" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(test_multimatch_first) = {
> +       .name   = "test_multimatch_first",
> +       .id     = UCLASS_TEST,
> +       .of_match = test_multimatch_ids,
> +       .bind   = test_multimatch_first_bind,
> +};
> +
> +U_BOOT_DRIVER(test_multimatch_second) = {
> +       .name   = "test_multimatch_second",
> +       .id     = UCLASS_TEST,
> +       .of_match = test_multimatch_ids,
> +       .bind   = test_manual_bind,
> +};
>
> --
> 2.51.0
>

Regards,
Simon
