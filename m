Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D570C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAD086940;
	Mon, 13 Nov 2023 19:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bcvw2Rbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E84987135; Mon, 13 Nov 2023 19:01:46 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6075B86940
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5c08c47c055so32894177b3.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699898503; x=1700503303; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6pem9buHzvKYCjVe25G4fY+88Rj5zvjqrgD19Ek32yE=;
 b=bcvw2Rbop/uTxM8PtR87Z0WzgfEtudoMnaW1w5i3uv9JcoL99GqMUDjSWqL9epkbU/
 vEEQcqFOxi9tpxl/MQvL2c21uqXuUuwmQwEOICiPIVjjbHvUZEORNlQRz7aDb7im1jma
 tk8Sv0PbDyFaUVaiJMyE1kElW2Xj3zlCJIIFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699898503; x=1700503303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6pem9buHzvKYCjVe25G4fY+88Rj5zvjqrgD19Ek32yE=;
 b=bv34aWtnlPLe39cSK4khq1EYd1BY288wBe8jWnwAXBuXnEnVG+pZyt6lw1aT1VIP6g
 IgjvsOMPYNrwbyeTL2X21wbYqjGjo701Ua4po9Z2L5PjvLdWAw+9A62s5213mYEmTJed
 p/EZ3jJJcsbdZBzqY50l50Kl8GjcSFrHEFioLN3q5WwFE3SZDFX3OwbhXtjUcdifGrEA
 SehYdUAzbMsevr6X7KXzctDREFxODUtLkZFyivgyenGPMmOgLToCgmvEs+gKo2QD5jd2
 S4/i3Bf8Fgalz6E+2X0/Ye998sWBP6DeViJlhNM+6Jl43GRvwirjXRUNk4FuZbQMLFpW
 d4Uw==
X-Gm-Message-State: AOJu0YwNj1VYpKUAFN6A6ew8J6Y7Yr/QX711jnq8uolYWz4L+W/cQ9TZ
 0bb/qdIO0KhXLOjlda6iExQWM7/4jcXSJlj1qDWw6RRNY7ExVtvDxBw=
X-Google-Smtp-Source: AGHT+IHPk2Pf7GAFRy1rVKcL1UOzp+gKbcpmU9m0W835J4AYjDtMmPKFJdW7McN75ZodTjrE+RPxPLf+aJJC0GVjdaU=
X-Received: by 2002:a81:840b:0:b0:5be:ae23:c002 with SMTP id
 u11-20020a81840b000000b005beae23c002mr7292928ywf.26.1699898502749; Mon, 13
 Nov 2023 10:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
 <20231113014911.3308990-2-takahiro.akashi@linaro.org>
In-Reply-To: <20231113014911.3308990-2-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 11:01:18 -0700
Message-ID: <CAPnjgZ1AQMoKVgF_tk6fhnMaTbh5=gtgy6XDPgvLs4BjYR6+Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] test: dm: skip scmi tests against disabled
 protocols
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
> This is a precautionary change to make scmi tests workable whether or not
> a specific protocol be enabled.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  test/dm/scmi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/test/dm/scmi.c b/test/dm/scmi.c
> index da45314f2e4c..2f63f2da16fb 100644
> --- a/test/dm/scmi.c
> +++ b/test/dm/scmi.c
> @@ -217,6 +217,9 @@ static int dm_test_scmi_power_domains(struct unit_test_state *uts)
>         u8 *name;
>         int ret;
>
> +       if (!IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
> +               return 0;

-EAGAIN to skip a test

Please update a comment if this needs to be documented better

> +
>         /* preparation */
>         ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
>         ut_assertnonnull(agent);
> @@ -317,6 +320,9 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
>         int ret_dev;
>         int ret;
>
> +       if (!IS_ENABLED(CONFIG_CLK_SCMI))
> +               return 0;
> +
>         ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
>         if (ret)
>                 return ret;
> @@ -382,6 +388,9 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
>         struct udevice *agent_dev, *reset_dev, *dev = NULL;
>         int ret;
>
> +       if (!IS_ENABLED(CONFIG_RESET_SCMI))
> +               return 0;
> +
>         ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
>         if (ret)
>                 return ret;
> @@ -418,6 +427,9 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
>         struct udevice *dev;
>         struct udevice *regul0_dev;
>
> +       if (!IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
> +               return 0;
> +
>         ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
>
>         scmi_devices = sandbox_scmi_devices_ctx(dev);
> --
> 2.34.1
>

Regards,
Simon
