Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64F6C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6838719E;
	Mon, 13 Nov 2023 19:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d8oyaast";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87DCD8719E; Mon, 13 Nov 2023 19:02:02 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6129987162
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-daec4e4c5eeso4774841276.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699898519; x=1700503319; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8rChjkNsK0RBXKjNKkfCssbFep2XZ5JCc1hi7AHtMHE=;
 b=d8oyaastj9eROZ6DidQ9dTDZQcHptWAIgekOLdEa5roIPcMmBOuOvX3gXkfau9Jte4
 I6E8tQAwV0u2ekQGaKuvMkmSzfZhLubI2i6ba5IErc2dmC9hNEbZnQtSs648xT3SkCaN
 HhlstdJb7TAdIvdVrizoAduwQ1vFwIo8OhKwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699898519; x=1700503319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rChjkNsK0RBXKjNKkfCssbFep2XZ5JCc1hi7AHtMHE=;
 b=uldV7LWFw9loLoVxpyfx7osko02dx2M9WwjWyHCaPnvWGOxiPIQJcGkpq/gyU32fw8
 6TpUd4O4e6vbqoYGu7TgnVnKJD+hf3JvKf07xTlO6DscYsIY7/EJzhX3XdYAkjP31wWm
 L4bHJsRoK+JU0TiVJMWUwJ5KrTKjpWweRTqwl+MUeI1qCAwn9K9T+Y+Cvq6NTB7XyDK+
 +zpvGHpoj5GWXNpFjgnAMpWmJ2Dt7vzXWJn8wEqb9o1vLFwZ6ZJU5tGhQEjAGfGp19QP
 WQIdqb7ZYqDKdd7yXAmHTLaW5sECXB0U80M6FJFNTcvj8yNxfhCEkdnjzMEDMX+pJUk4
 13fA==
X-Gm-Message-State: AOJu0YyST6rhy0Vf0aFK8FK0gKZFYee+BLS9NcRFYfdTD9bPmTDLLGoo
 MZGPmCie5HyT2wN6GFzivVDb5I7qyqQnVrlOmITz1A==
X-Google-Smtp-Source: AGHT+IFWpqkV1Z/JwVhGkip+iVVg9ukED/4v4LpI+hcxGBtANvc+Gn9myGIfqyIK19CUqJRp1Gbg7/7DMyYF5WhpcKY=
X-Received: by 2002:a25:4641:0:b0:d9b:9f55:b62d with SMTP id
 t62-20020a254641000000b00d9b9f55b62dmr5991495yba.61.1699898518736; Mon, 13
 Nov 2023 10:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
 <20231113014911.3308990-3-takahiro.akashi@linaro.org>
In-Reply-To: <20231113014911.3308990-3-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 11:01:20 -0700
Message-ID: <CAPnjgZ0dnRJxorwAyp1M=aHtaxWOEcwErrWex8ur38iK5+GYNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] firmware: scmi: support protocols on sandbox only
 if enabled
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, michal.simek@amd.com, 
 u-boot@lists.denx.de
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

Hi AKASHI,

On Sun, 12 Nov 2023 at 18:49, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This change will be useful when we manually test SCMI on sandbox
> by enabling/disabling a specific SCMI protocol.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/firmware/scmi/sandbox-scmi_agent.c   | 27 ++++++-
>  drivers/firmware/scmi/sandbox-scmi_devices.c | 78 ++++++++++++--------
>  2 files changed, 72 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
> index d13180962662..1fc9a0f4ea7e 100644
> --- a/drivers/firmware/scmi/sandbox-scmi_agent.c
> +++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
> @@ -66,10 +66,18 @@ struct scmi_channel {
>  };
>
>  static u8 protocols[] = {
> +#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)
>         SCMI_PROTOCOL_ID_POWER_DOMAIN,

Is this better? Perhaps not!

CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN, (SCMI_PROTOCOL_ID_POWER_DOMAIN,))

> +#endif
> +#if IS_ENABLED(CONFIG_CLK_SCMI)
>         SCMI_PROTOCOL_ID_CLOCK,
> +#endif
> +#if IS_ENABLED(CONFIG_RESET_SCMI)
>         SCMI_PROTOCOL_ID_RESET_DOMAIN,
> +#endif
> +#if IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
>         SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
> +#endif
>  };
>
>  #define NUM_PROTOCOLS ARRAY_SIZE(protocols)
> @@ -1160,6 +1168,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
>                 }
>                 break;
>         case SCMI_PROTOCOL_ID_POWER_DOMAIN:
> +               if (!IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
> +                       goto not_supported;
> +
>                 switch (msg->message_id) {
>                 case SCMI_PROTOCOL_VERSION:
>                         return sandbox_scmi_pwd_protocol_version(dev, msg);
> @@ -1180,6 +1191,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
>                 }
>                 break;
>         case SCMI_PROTOCOL_ID_CLOCK:
> +               if (!IS_ENABLED(CONFIG_CLK_SCMI))
> +                       goto not_supported;

How about putting this all in a function and avoiding the goto?

> +
>                 switch (msg->message_id) {
>                 case SCMI_PROTOCOL_ATTRIBUTES:
>                         return sandbox_scmi_clock_protocol_attribs(dev, msg);
> @@ -1196,6 +1210,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
>                 }
>                 break;
>         case SCMI_PROTOCOL_ID_RESET_DOMAIN:
> +               if (!IS_ENABLED(CONFIG_RESET_SCMI))
> +                       goto not_supported;
> +
>                 switch (msg->message_id) {
>                 case SCMI_RESET_DOMAIN_ATTRIBUTES:
>                         return sandbox_scmi_rd_attribs(dev, msg);
> @@ -1206,6 +1223,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
>                 }
>                 break;
>         case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
> +               if (!IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
> +                       goto not_supported;
> +
>                 switch (msg->message_id) {
>                 case SCMI_VOLTAGE_DOMAIN_ATTRIBUTES:
>                         return sandbox_scmi_voltd_attribs(dev, msg);
> @@ -1224,8 +1244,7 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
>         case SCMI_PROTOCOL_ID_SYSTEM:
>         case SCMI_PROTOCOL_ID_PERF:
>         case SCMI_PROTOCOL_ID_SENSOR:
> -               *(u32 *)msg->out_msg = SCMI_NOT_SUPPORTED;
> -               return 0;
> +               goto not_supported;
>         default:
>                 break;
>         }
> @@ -1239,6 +1258,10 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
>         /* Intentionnaly report unhandled IDs through the SCMI return code */
>         *(u32 *)msg->out_msg = SCMI_PROTOCOL_ERROR;
>         return 0;
> +
> +not_supported:
> +       *(u32 *)msg->out_msg = SCMI_NOT_SUPPORTED;
> +       return 0;
>  }
>
>  static int sandbox_scmi_test_remove(struct udevice *dev)
> diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
> index facb5b06ffb5..0519cf889aa9 100644
> --- a/drivers/firmware/scmi/sandbox-scmi_devices.c
> +++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
> @@ -62,12 +62,13 @@ static int sandbox_scmi_devices_remove(struct udevice *dev)
>         if (!devices)
>                 return 0;
>
> -       for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
> -               int ret2 = reset_free(devices->reset + n);
> +       if (IS_ENABLED(CONFIG_RESET_SCMI))
> +               for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
> +                       int ret2 = reset_free(devices->reset + n);
>
> -               if (ret2 && !ret)
> -                       ret = ret2;
> -       }
> +                       if (ret2 && !ret)
> +                               ret = ret2;
> +               }
>
>         return ret;
>  }
> @@ -89,39 +90,53 @@ static int sandbox_scmi_devices_probe(struct udevice *dev)
>                 .regul_count = SCMI_TEST_DEVICES_VOLTD_COUNT,
>         };
>
> -       ret = power_domain_get_by_index(dev, priv->devices.pwdom, 0);
> -       if (ret) {
> -               dev_err(dev, "%s: Failed on power domain\n", __func__);
> -               return ret;
> -       }
> -
> -       for (n = 0; n < SCMI_TEST_DEVICES_CLK_COUNT; n++) {
> -               ret = clk_get_by_index(dev, n, priv->devices.clk + n);
> +       if (IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)) {
> +               ret = power_domain_get_by_index(dev, priv->devices.pwdom, 0);
>                 if (ret) {
> -                       dev_err(dev, "%s: Failed on clk %zu\n", __func__, n);
> +                       dev_err(dev, "%s: Failed on power domain\n", __func__);
>                         return ret;
>                 }
>         }
>
> -       for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
> -               ret = reset_get_by_index(dev, n, priv->devices.reset + n);
> -               if (ret) {
> -                       dev_err(dev, "%s: Failed on reset %zu\n", __func__, n);
> -                       goto err_reset;
> +       if (IS_ENABLED(CONFIG_CLK_SCMI)) {
> +               for (n = 0; n < SCMI_TEST_DEVICES_CLK_COUNT; n++) {
> +                       ret = clk_get_by_index(dev, n, priv->devices.clk + n);
> +                       if (ret) {
> +                               dev_err(dev, "%s: Failed on clk %zu\n",
> +                                       __func__, n);
> +                               return ret;
> +                       }
>                 }
>         }
>
> -       for (n = 0; n < SCMI_TEST_DEVICES_VOLTD_COUNT; n++) {
> -               char name[32];
> -
> -               ret = snprintf(name, sizeof(name), "regul%zu-supply", n);
> -               assert(ret >= 0 && ret < sizeof(name));
> +       if (IS_ENABLED(CONFIG_RESET_SCMI)) {
> +               for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
> +                       ret = reset_get_by_index(dev, n,
> +                                                priv->devices.reset + n);
> +                       if (ret) {
> +                               dev_err(dev, "%s: Failed on reset %zu\n",
> +                                       __func__, n);
> +                               goto err_reset;
> +                       }
> +               }
> +       }
>
> -               ret = device_get_supply_regulator(dev, name,
> -                                                 priv->devices.regul + n);
> -               if (ret) {
> -                       dev_err(dev, "%s: Failed on voltd %zu\n", __func__, n);
> -                       goto err_regul;
> +       if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)) {
> +               for (n = 0; n < SCMI_TEST_DEVICES_VOLTD_COUNT; n++) {
> +                       char name[32];
> +
> +                       ret = snprintf(name, sizeof(name), "regul%zu-supply",
> +                                      n);
> +                       assert(ret >= 0 && ret < sizeof(name));
> +
> +                       ret = device_get_supply_regulator(dev, name,
> +                                                         priv->devices.regul
> +                                                               + n);
> +                       if (ret) {
> +                               dev_err(dev, "%s: Failed on voltd %zu\n",
> +                                       __func__, n);
> +                               goto err_regul;
> +                       }
>                 }
>         }
>
> @@ -130,8 +145,9 @@ static int sandbox_scmi_devices_probe(struct udevice *dev)
>  err_regul:
>         n = SCMI_TEST_DEVICES_RD_COUNT;
>  err_reset:
> -       for (; n > 0; n--)
> -               reset_free(priv->devices.reset + n - 1);
> +       if (IS_ENABLED(CONFIG_RESET_SCMI))
> +               for (; n > 0; n--)
> +                       reset_free(priv->devices.reset + n - 1);
>
>         return ret;
>  }
> --
> 2.34.1
>

Regards,
Simon
