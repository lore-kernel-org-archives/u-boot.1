Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A3CEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6732A86D17;
	Sun, 10 Sep 2023 21:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="awJ7V9dp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9517486D25; Sun, 10 Sep 2023 21:14:53 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6880886CF6
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58d31f142eeso36642647b3.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wile7dxFn83S31Es9mdT4j8ihcfgHWh+onY+LFYeFNM=;
 b=awJ7V9dpOyF08KdTsCFET0IVF83l+8q9HtEhxv0+ncXHZHRwgcD9JzkeSUeQNWmikN
 IEO5Ys1JM+K2gRhGnY3gIlyYA9aPgdGjxDd4XV1rmCX+pf/Z7TPiaE+3yI+ONFpt1e7R
 StxXeBu2iTIXT0G1DaArXKxYSwZUOF/27GNyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wile7dxFn83S31Es9mdT4j8ihcfgHWh+onY+LFYeFNM=;
 b=u+yXZoaNZCdfOu5H0T/qp35ExOX3lWkKCxfzmdZzdYJwMMXrUv0ObFaqtqxErRc7uV
 fObrUgtBYIq4r+6mwFYjcmFgnmxMRdwL0W8btUT7rDK8lhmaivG2WZFH2SEbZXAXqRfI
 l2++Ae9HDX9yamG2TTGg3yOZGp7dTp4XaPKoQQfa3Fwb+XUCt1bCn4X6uYDXZXT8sAer
 vRltckxHtzOc307i4mr1uguh0G7HLn1oO58ZEgGBuhEgvJdo2zmpDzV6wmqZIaXV1Pd3
 cwJbFc+bRT9VnKQ3onu1YWHk/y64PpWj3aADlDfUniQzwPeRptKF9CtsixIBkvZL1kNH
 qGuA==
X-Gm-Message-State: AOJu0YyJMUkOla5pI3PE3lqbIHBwV75BZpRCOlo9AedC+kdY/eALSQ6V
 0VcetsJzNwfl9O4MZD9EEBm5l092OzQgWpiHYrRF/w==
X-Google-Smtp-Source: AGHT+IHObuUH7xfCd29xoQ8TJAkkeCYIWDFSpfhdrO5CFc4iy6HczsGkEpE7YurNgyAXmACW7T3RZJBw5yxDITQqGH4=
X-Received: by 2002:a25:2648:0:b0:d7b:9a4b:5a72 with SMTP id
 m69-20020a252648000000b00d7b9a4b5a72mr7735112ybm.31.1694373286973; Sun, 10
 Sep 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-6-takahiro.akashi@linaro.org>
In-Reply-To: <20230906024011.17488-6-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:28 -0600
Message-ID: <CAPnjgZ2GwRi4TyNVzcm9UZOtvmhj+2ZwH77Z62VvNNH56D6spQ@mail.gmail.com>
Subject: Re: [RFC 5/6] firmware: scmi: add pseudo pinctrl protocol support on
 sandbox
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com, 
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
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

On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> With this patch, sandbox SCMI agent can handle pinctrl protocol.
> This feature is used in an unit test for SCMI pinctrl.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/sandbox/dts/test.dts                  | 115 ++++
>  drivers/firmware/scmi/sandbox-scmi_agent.c | 722 +++++++++++++++++++++
>  2 files changed, 837 insertions(+)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index dc0bfdfb6e4b..d2ddea801995 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -723,9 +723,124 @@
>                                         };
>                                 };
>                         };
> +
> +                       pinctrl_scmi: protocol@19 {
> +                               reg = <0x19>;
> +
> +                               pinctrl-names = "default","alternate";
> +                               pinctrl-0 = <&scmi_pinctrl_gpios>, <&scmi_pinctrl_i2s>;
> +                               pinctrl-1 = <&scmi_pinctrl_spi>, <&scmi_pinctrl_i2c>;
> +
> +#if 0

Are these alternatives that you are testing?

The bindings  look OK to me - is this how it is done in Linux?

Regards,
Simon
