Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594B3CE9D78
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA67283FBC;
	Tue,  6 Jan 2026 17:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DdFnggVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2BD83FCF; Tue,  6 Jan 2026 17:24:34 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F73D83F9B
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c708702dfso1090897a91.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716671; x=1768321471; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dgPwQP6k4rccKSoek4CALkNhI9b8rgWE24Vqwj2hVHE=;
 b=DdFnggVuZXffxz+7wVZ66NG7o3snu4cyQaPhRM1/M4cyazuM/vAHpPADucQTDOP+mr
 elCvEpsn//ChxG6zh7ziYoSBzAtc65prIa6O4yLI5XSu4X39yxuOLAt1v66PIFoUWN4X
 UncTt6yDj++CqRcSJBEGGucw3twk15pQRTq2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716671; x=1768321471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgPwQP6k4rccKSoek4CALkNhI9b8rgWE24Vqwj2hVHE=;
 b=pjpjDGi4bwj/IOQDkyBi1rLlnYUBB4nEtpT86B7JtUA3d+VYexl7NyoTO25trb8/Bg
 7/Dp76HFQf9avYRfrtSARaYKAgORtCLRWve+BbIRJWV6/wAo+0iL5ljjTBN2XM/rG5er
 NNTItsrGGSogRdeb6K3D4sSQ2hY55bFxnXOulARe8Do+CZjELq2azJbtrUFAzN3VD8Eq
 7xBBbDR7+A2GstREcQ2GEoL9SHLZysY70lB5CwQLGKOHeg3SKF1z0RHuLdzvbRvQwjHM
 cO0TXF5aaVTlUXd7S9i81CzeHBhc27je1wBGfv5XNVAF00LOLPTuU67fmqMB42k0ZreS
 349w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWiWSuSvitwUOZlWgl48z8+ZPeId4U7lJWln78N16qfYVa/u98Cy+PVnqz3P7L4b4z1z2Sl34=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/basblHu8E79R0TEn86JSaj2oImf8TonRXkR1dm0P1BhUOGrz
 IyDwxVzDbErGBNS9jzaX4nnLP8YcxUlaYvQmU+OokFHQXSpJDh2H0OH6CHrmJsHYJhhI3iVIoT+
 RYH39562HHy4lPGW0h9WtB+QIk6Ss9w04lmtJgyar
X-Gm-Gg: AY/fxX5fRpVE/SLlZuXsFLpzNm1ZkG0v9eEkrVVvtn/Dk6VAwfQWDZj7GXfErZwOJjE
 z9BfCpKB2cTpT9Wwbu+4jEZ1wZe++UtbFJ8My2yvH5J5JDTTi5975WNiAU4OaYbLUZQvN0Tz602
 4JN+jWRMqXtaaeegOdgPylH+3/Jq49AN1DxumojdiF3yXf9Ydb79Utjymd9u+/tuP0L3yRTR/UH
 9ao4NfA67LYu0MyZ3m6kjTZL0Es61xRpkVlBsgAZdSNh1xfsQDENHW6Wv5EBol2i723Kg==
X-Google-Smtp-Source: AGHT+IGXoZlY2qn0TVQQWzeQ8GA4vixFJ3geTBohPQT3AoLqUCM/jWEGgxagDMBkz2G6JqnlzFbn592FIHKBPejYr6c=
X-Received: by 2002:a17:90b:48c8:b0:34c:27ad:71e7 with SMTP id
 98e67ed59e1d1-34f5f34384emr2756024a91.35.1767716670739; Tue, 06 Jan 2026
 08:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
 <20260101-clk-reparent-v2-5-3eb42b78c7f1@outlook.com>
In-Reply-To: <20260101-clk-reparent-v2-5-3eb42b78c7f1@outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:23:52 -0700
X-Gm-Features: AQt7F2qEhvtVdYSLD53-eUe3cR3hjmU_FB-ddrO_8g0KUJXxYLQp4CYt_yQ60Lw
Message-ID: <CAFLszTgGFgUoqPMffSgM4XsgQL0rOjeknhxhh+QK-XN3VKYNxA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] test: clk: add test for CLK_LAZY_REPARENT
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

Hi,

On Wed, 31 Dec 2025 at 12:52, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Add a test for the newly introduced CLK_LAZY_PARENT feature.
>
> Modify clk_sandbox_ccf driver to register two clocks(i2s and i2s_root)
> in reversed order.
>
> The test function then try to acquire the clocks and asserts that their
> internal states are maintained correctly.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/clk/clk_sandbox_ccf.c | 10 ++++++++++
>  include/sandbox-clk.h         |  2 ++
>  test/dm/clk_ccf.c             | 29 +++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/clk_sandbox_ccf.c
> index f96a15c30b3a..3a11b361cd2b 100644
> --- a/drivers/clk/clk_sandbox_ccf.c
> +++ b/drivers/clk/clk_sandbox_ccf.c
> @@ -229,6 +229,7 @@ static const struct udevice_id sandbox_clk_ccf_test_ids[] = {
>
>  static const char *const usdhc_sels[] = { "pll3_60m", "pll3_80m", };
>  static const char *const i2c_sels[] = { "pll3_60m", "pll3_80m", };
> +static const char *const i2s_sels[] = { "pll3_60m", "pll3_80m", };
>
>  static int sandbox_clk_ccf_probe(struct udevice *dev)
>  {
> @@ -277,6 +278,15 @@ static int sandbox_clk_ccf_probe(struct udevice *dev)
>         clk_dm(SANDBOX_CLK_I2C_ROOT,
>                sandbox_clk_gate2("i2c_root", "i2c", base + 0x7c, 0));
>
> +       /* Register i2s_root(child) and i2s(parent) in reverse order to test CLK_LAZY_REPARENT */
> +       clk_dm(SANDBOX_CLK_I2S_ROOT,
> +              sandbox_clk_gate2("i2s_root", "i2s", base + 0x80, 0));
> +
> +       reg = BIT(29) | BIT(25) | BIT(17);
> +       clk_dm(SANDBOX_CLK_I2S,
> +              sandbox_clk_composite("i2s", i2s_sels, ARRAY_SIZE(i2s_sels),
> +                                    &reg, CLK_SET_RATE_UNGATE));
> +
>         return 0;
>  }
>
> diff --git a/include/sandbox-clk.h b/include/sandbox-clk.h
> index c2616c27a44a..0cd735e3ad5f 100644
> --- a/include/sandbox-clk.h
> +++ b/include/sandbox-clk.h
> @@ -21,6 +21,8 @@ enum {
>         SANDBOX_CLK_USDHC2_SEL,
>         SANDBOX_CLK_I2C,
>         SANDBOX_CLK_I2C_ROOT,
> +       SANDBOX_CLK_I2S,
> +       SANDBOX_CLK_I2S_ROOT,
>  };
>
>  enum sandbox_pllv3_type {
> diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
> index ac56f17b775d..c4c1b6ba758a 100644
> --- a/test/dm/clk_ccf.c
> +++ b/test/dm/clk_ccf.c
> @@ -209,3 +209,32 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
>         return 1;
>  }
>  DM_TEST(dm_test_clk_ccf, UTF_SCAN_FDT);
> +
> +#if CONFIG_IS_ENABLED(CLK_LAZY_REPARENT)
> +/* Test CLK_LAZY_REPARENT feature */
> +static int dm_test_clk_lazy_reparent(struct unit_test_state *uts)
> +{
> +       struct udevice *dev;
> +       struct clk *clk_i2s, *clk_i2s_root;
> +       int ret;
> +
> +       /* Get the device using the clk device */
> +       ut_assertok(uclass_get_device_by_name(UCLASS_CLK, "clk-ccf", &dev));
> +
> +       ret = clk_get_by_id(SANDBOX_CLK_I2S_ROOT, &clk_i2s_root);
> +       ret |= clk_get_by_id(SANDBOX_CLK_I2S, &clk_i2s);
> +       ut_assertok(ret);

Perhaps two separate ut_assertok() calls?

> +
> +       ut_asserteq_str(clk_i2s_root->parent_name, "i2s");
> +       ut_assertnull(clk_i2s_root->dev->parent);
> +
> +       ret = clk_enable(clk_i2s_root);
> +       ut_assertok(ret);

join those two lines up?

> +
> +       ut_assertnull(clk_i2s_root->parent_name);
> +       ut_asserteq_ptr(clk_i2s_root->dev->parent, clk_i2s->dev);
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_clk_lazy_reparent, UTF_SCAN_FDT);
> +#endif
>
> --
> 2.43.0
>
>

Could you look at tests to cover some of the other changes you made in
this series? This is a critical subsystem so it feels strange to set a
patch that changes existing behaviour but doesn't change any existing
test.

Regards,
Simon
