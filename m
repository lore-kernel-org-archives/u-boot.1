Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C109C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 01:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE688715B;
	Tue, 14 Nov 2023 02:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h0ArTV0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00974871A2; Tue, 14 Nov 2023 02:53:32 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A16668710C
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-51f64817809so477976a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 17:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699926808; x=1700531608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0huZ9jlnu5/GTlbtrNBPi7iYMqi1aaI3J/eabtxSwQk=;
 b=h0ArTV0qIm/aGrnbkLeVYsttw6x1nb7I2dXD/CRuDfqoCjGPdsJ5qd5CVSXAmu5LbF
 ttq+uCEU9wqwV7BhxUF0Kyl85vXhw+zeqBYuyEUU4++Z1zmlDhT7GIfgacozgiL9WQV5
 uCVfkCZR93lRGdnTHsaOGQYprNfvv6sjAqkfn+VRY0VD4w2wic/k9L3Jre85HZdAKN/4
 mdRYsFvikoXTjNuO4oJDkIKpc9D9EcTfbrjrhtypfoOsthixDMotGMrf7mwePhXb0aH7
 5Ubdc75HRQzuNEdyZ0MpCZoLphU5jBGOumNOKt/NKeZ3o7ylaHhjLPP1XVBu1UsHdzBC
 BlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699926808; x=1700531608;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0huZ9jlnu5/GTlbtrNBPi7iYMqi1aaI3J/eabtxSwQk=;
 b=SDdeuh5/7KFeuAgZViQw6GOZsDq3XgwvbbhIymsdnWOh98kAhZ+HPA7SJcjt4ehLSK
 mO4zG1xJ1/DbhUU4EHTIT1m1nYC9dAYakOJA3OXD1qyb7ESUgxkqwEeh50YxwPrNi0TO
 HCwOzM1qFqrW3RK4OOpqSMrzpKr2keKXAAwvkrTu5Zww/2u5xdT+vrnTmyowbofxlpo1
 hNEiXgashdyAlfB5E/QWq6wJKoXMUxZHuzZk9YykH3/WGRU0YclTc3iLbOdIRGdwOOEu
 2ciTKavN6kHLoG0uikW/OaZh13R0kUOVl6AfGFEBExQueca0ohzKZCqzIGFgL6jY/998
 qWbg==
X-Gm-Message-State: AOJu0YzgKGXpMGviH3Fd/lPW2dZLoJODu2WCaYwMtrUJwmIQHaqB1A/f
 nqja6gjNZiZza9YO37AWkK8K9g==
X-Google-Smtp-Source: AGHT+IECdCwodFyGv6TwYov7W/vVwtBuJlNyok8Y6ffcFdmJEzTmP1/31VOZcEzXdp+4eYZ/PA+gpw==
X-Received: by 2002:a05:6a20:da9b:b0:181:7d6d:c0ee with SMTP id
 iy27-20020a056a20da9b00b001817d6dc0eemr1357352pzb.0.1699926807665; 
 Mon, 13 Nov 2023 17:53:27 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:66f2:cd5c:3d82:6e6f])
 by smtp.gmail.com with ESMTPSA id
 fe14-20020a056a002f0e00b0068fcb70ccafsm224372pfb.129.2023.11.13.17.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 17:53:27 -0800 (PST)
Date: Tue, 14 Nov 2023 10:53:24 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, michal.simek@amd.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/5] firmware: scmi: support protocols on sandbox only
 if enabled
Message-ID: <ZVLTFCZJ8mUvv5UJ@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, trini@konsulko.com,
 etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de
References: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
 <20231113014911.3308990-3-takahiro.akashi@linaro.org>
 <CAPnjgZ0dnRJxorwAyp1M=aHtaxWOEcwErrWex8ur38iK5+GYNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0dnRJxorwAyp1M=aHtaxWOEcwErrWex8ur38iK5+GYNg@mail.gmail.com>
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

On Mon, Nov 13, 2023 at 11:01:20AM -0700, Simon Glass wrote:
> Hi AKASHI,
> 
> On Sun, 12 Nov 2023 at 18:49, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > This change will be useful when we manually test SCMI on sandbox
> > by enabling/disabling a specific SCMI protocol.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/firmware/scmi/sandbox-scmi_agent.c   | 27 ++++++-
> >  drivers/firmware/scmi/sandbox-scmi_devices.c | 78 ++++++++++++--------
> >  2 files changed, 72 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
> > index d13180962662..1fc9a0f4ea7e 100644
> > --- a/drivers/firmware/scmi/sandbox-scmi_agent.c
> > +++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
> > @@ -66,10 +66,18 @@ struct scmi_channel {
> >  };
> >
> >  static u8 protocols[] = {
> > +#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)
> >         SCMI_PROTOCOL_ID_POWER_DOMAIN,
> 
> Is this better? Perhaps not!
> 
> CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN, (SCMI_PROTOCOL_ID_POWER_DOMAIN,))

Ah, good notation.

> > +#endif
> > +#if IS_ENABLED(CONFIG_CLK_SCMI)
> >         SCMI_PROTOCOL_ID_CLOCK,
> > +#endif
> > +#if IS_ENABLED(CONFIG_RESET_SCMI)
> >         SCMI_PROTOCOL_ID_RESET_DOMAIN,
> > +#endif
> > +#if IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
> >         SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
> > +#endif
> >  };
> >
> >  #define NUM_PROTOCOLS ARRAY_SIZE(protocols)
> > @@ -1160,6 +1168,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
> >                 }
> >                 break;
> >         case SCMI_PROTOCOL_ID_POWER_DOMAIN:
> > +               if (!IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
> > +                       goto not_supported;
> > +
> >                 switch (msg->message_id) {
> >                 case SCMI_PROTOCOL_VERSION:
> >                         return sandbox_scmi_pwd_protocol_version(dev, msg);
> > @@ -1180,6 +1191,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
> >                 }
> >                 break;
> >         case SCMI_PROTOCOL_ID_CLOCK:
> > +               if (!IS_ENABLED(CONFIG_CLK_SCMI))
> > +                       goto not_supported;
> 
> How about putting this all in a function and avoiding the goto?

Okay, will do.

Thanks,
-Takahiro Akashi

> > +
> >                 switch (msg->message_id) {
> >                 case SCMI_PROTOCOL_ATTRIBUTES:
> >                         return sandbox_scmi_clock_protocol_attribs(dev, msg);
> > @@ -1196,6 +1210,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
> >                 }
> >                 break;
> >         case SCMI_PROTOCOL_ID_RESET_DOMAIN:
> > +               if (!IS_ENABLED(CONFIG_RESET_SCMI))
> > +                       goto not_supported;
> > +
> >                 switch (msg->message_id) {
> >                 case SCMI_RESET_DOMAIN_ATTRIBUTES:
> >                         return sandbox_scmi_rd_attribs(dev, msg);
> > @@ -1206,6 +1223,9 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
> >                 }
> >                 break;
> >         case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
> > +               if (!IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
> > +                       goto not_supported;
> > +
> >                 switch (msg->message_id) {
> >                 case SCMI_VOLTAGE_DOMAIN_ATTRIBUTES:
> >                         return sandbox_scmi_voltd_attribs(dev, msg);
> > @@ -1224,8 +1244,7 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
> >         case SCMI_PROTOCOL_ID_SYSTEM:
> >         case SCMI_PROTOCOL_ID_PERF:
> >         case SCMI_PROTOCOL_ID_SENSOR:
> > -               *(u32 *)msg->out_msg = SCMI_NOT_SUPPORTED;
> > -               return 0;
> > +               goto not_supported;
> >         default:
> >                 break;
> >         }
> > @@ -1239,6 +1258,10 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
> >         /* Intentionnaly report unhandled IDs through the SCMI return code */
> >         *(u32 *)msg->out_msg = SCMI_PROTOCOL_ERROR;
> >         return 0;
> > +
> > +not_supported:
> > +       *(u32 *)msg->out_msg = SCMI_NOT_SUPPORTED;
> > +       return 0;
> >  }
> >
> >  static int sandbox_scmi_test_remove(struct udevice *dev)
> > diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
> > index facb5b06ffb5..0519cf889aa9 100644
> > --- a/drivers/firmware/scmi/sandbox-scmi_devices.c
> > +++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
> > @@ -62,12 +62,13 @@ static int sandbox_scmi_devices_remove(struct udevice *dev)
> >         if (!devices)
> >                 return 0;
> >
> > -       for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
> > -               int ret2 = reset_free(devices->reset + n);
> > +       if (IS_ENABLED(CONFIG_RESET_SCMI))
> > +               for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
> > +                       int ret2 = reset_free(devices->reset + n);
> >
> > -               if (ret2 && !ret)
> > -                       ret = ret2;
> > -       }
> > +                       if (ret2 && !ret)
> > +                               ret = ret2;
> > +               }
> >
> >         return ret;
> >  }
> > @@ -89,39 +90,53 @@ static int sandbox_scmi_devices_probe(struct udevice *dev)
> >                 .regul_count = SCMI_TEST_DEVICES_VOLTD_COUNT,
> >         };
> >
> > -       ret = power_domain_get_by_index(dev, priv->devices.pwdom, 0);
> > -       if (ret) {
> > -               dev_err(dev, "%s: Failed on power domain\n", __func__);
> > -               return ret;
> > -       }
> > -
> > -       for (n = 0; n < SCMI_TEST_DEVICES_CLK_COUNT; n++) {
> > -               ret = clk_get_by_index(dev, n, priv->devices.clk + n);
> > +       if (IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)) {
> > +               ret = power_domain_get_by_index(dev, priv->devices.pwdom, 0);
> >                 if (ret) {
> > -                       dev_err(dev, "%s: Failed on clk %zu\n", __func__, n);
> > +                       dev_err(dev, "%s: Failed on power domain\n", __func__);
> >                         return ret;
> >                 }
> >         }
> >
> > -       for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
> > -               ret = reset_get_by_index(dev, n, priv->devices.reset + n);
> > -               if (ret) {
> > -                       dev_err(dev, "%s: Failed on reset %zu\n", __func__, n);
> > -                       goto err_reset;
> > +       if (IS_ENABLED(CONFIG_CLK_SCMI)) {
> > +               for (n = 0; n < SCMI_TEST_DEVICES_CLK_COUNT; n++) {
> > +                       ret = clk_get_by_index(dev, n, priv->devices.clk + n);
> > +                       if (ret) {
> > +                               dev_err(dev, "%s: Failed on clk %zu\n",
> > +                                       __func__, n);
> > +                               return ret;
> > +                       }
> >                 }
> >         }
> >
> > -       for (n = 0; n < SCMI_TEST_DEVICES_VOLTD_COUNT; n++) {
> > -               char name[32];
> > -
> > -               ret = snprintf(name, sizeof(name), "regul%zu-supply", n);
> > -               assert(ret >= 0 && ret < sizeof(name));
> > +       if (IS_ENABLED(CONFIG_RESET_SCMI)) {
> > +               for (n = 0; n < SCMI_TEST_DEVICES_RD_COUNT; n++) {
> > +                       ret = reset_get_by_index(dev, n,
> > +                                                priv->devices.reset + n);
> > +                       if (ret) {
> > +                               dev_err(dev, "%s: Failed on reset %zu\n",
> > +                                       __func__, n);
> > +                               goto err_reset;
> > +                       }
> > +               }
> > +       }
> >
> > -               ret = device_get_supply_regulator(dev, name,
> > -                                                 priv->devices.regul + n);
> > -               if (ret) {
> > -                       dev_err(dev, "%s: Failed on voltd %zu\n", __func__, n);
> > -                       goto err_regul;
> > +       if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)) {
> > +               for (n = 0; n < SCMI_TEST_DEVICES_VOLTD_COUNT; n++) {
> > +                       char name[32];
> > +
> > +                       ret = snprintf(name, sizeof(name), "regul%zu-supply",
> > +                                      n);
> > +                       assert(ret >= 0 && ret < sizeof(name));
> > +
> > +                       ret = device_get_supply_regulator(dev, name,
> > +                                                         priv->devices.regul
> > +                                                               + n);
> > +                       if (ret) {
> > +                               dev_err(dev, "%s: Failed on voltd %zu\n",
> > +                                       __func__, n);
> > +                               goto err_regul;
> > +                       }
> >                 }
> >         }
> >
> > @@ -130,8 +145,9 @@ static int sandbox_scmi_devices_probe(struct udevice *dev)
> >  err_regul:
> >         n = SCMI_TEST_DEVICES_RD_COUNT;
> >  err_reset:
> > -       for (; n > 0; n--)
> > -               reset_free(priv->devices.reset + n - 1);
> > +       if (IS_ENABLED(CONFIG_RESET_SCMI))
> > +               for (; n > 0; n--)
> > +                       reset_free(priv->devices.reset + n - 1);
> >
> >         return ret;
> >  }
> > --
> > 2.34.1
> >
> 
> Regards,
> Simon
