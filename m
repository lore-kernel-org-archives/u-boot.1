Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A789FEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C73C86D30;
	Sun, 10 Sep 2023 21:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M9X8dKYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A683686D28; Sun, 10 Sep 2023 21:14:53 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696C086CFE
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5920efd91c7so38073377b3.2
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=73hTRKjOM91xgZ+RKqXq3jrYOU8D7BQqFToL1zKWAIw=;
 b=M9X8dKYw0jhw8Hd/n2fnj3IaSNkrL9zU/9RKasfuYdbRMjl5PsRPgVN1116Xk1A29P
 Do9s9nYEB72Oi58QP5kUnq67mF7lsDUvhYmQyIyzbqTWuf0r5DatWmSm7wqKhITcP/XX
 96RvPXP6qysbI6jSR7XekDVeLgwmTjbhHrVaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73hTRKjOM91xgZ+RKqXq3jrYOU8D7BQqFToL1zKWAIw=;
 b=skxCRfKc/jw+YFXx3mJ2upi3mqakt9u4O14i8/eTN0gToWP4s8ip5ZlPRo0y9nJf3M
 Fk2PWb2Ro+KaiQCa6kcaVCm5+CzwDSmXar2uhk+cGq0LJ783i5Vgrow6UGwz5XsGUoL4
 eCoDq/prIzAX9i59B2anvoiwm4M1Vqn3yAUz11whiBt66kc/RJ4yxbiuOsQb8UzNGcdi
 P8RaGeV+j5WHBvbc2RI1JqAPbtwfCPlBXSF+26zMYZ2HWjBlAquwmG1FcNM6qhZQBL5r
 Lk3OEqpRqouvNmRRvAyHWgTzImolhlm1mUP7eyTL3lpnUkOmwnmvb7HC2VP+TOnXO1vB
 G0IA==
X-Gm-Message-State: AOJu0YzqMtkt4EJf//x30WXAdPob7GX29GcV9mSS2GnKGBwErENV6PED
 qcRmZZyjaEf2RO4I8z7hiOb+c366mjnl0uUKY+jslw==
X-Google-Smtp-Source: AGHT+IG7Jw6wYxeLp+Zm2FXg4OICDT1sG90USogu2sUqUxek98HiBf8hxrsTit4yNv7V4ctz2GbsGxjmQrDvE81phj0=
X-Received: by 2002:a25:b11c:0:b0:d78:1f87:d6f1 with SMTP id
 g28-20020a25b11c000000b00d781f87d6f1mr6851591ybj.33.1694373286984; Sun, 10
 Sep 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-2-takahiro.akashi@linaro.org>
In-Reply-To: <20230906024011.17488-2-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:26 -0600
Message-ID: <CAPnjgZ0kxE3NXD_pLTm5Oc3Sb9HRUz5pbWETCqrvr4XwSUzKcA@mail.gmail.com>
Subject: Re: [RFC 1/6] firmware: scmi: fix protocol enumeration logic
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
> The original logic in enumerating all the protocols accidentally
> modifies a *loop* variable, node, at Voltage domain protocol.
> So subsequent protocol nodes in a device tree won't be detected.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/firmware/scmi/scmi_agent-uclass.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> index 46a2933d51a4..79584c00a066 100644
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> @@ -422,8 +422,11 @@ static int scmi_bind_protocols(struct udevice *dev)
>                 case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
>                         if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
>                             scmi_protocol_is_supported(dev, protocol_id)) {
> -                               node = ofnode_find_subnode(node, "regulators");
> -                               if (!ofnode_valid(node)) {
> +                               ofnode sub_node;
> +
> +                               sub_node = ofnode_find_subnode(node,
> +                                                              "regulators");
> +                               if (!ofnode_valid(sub_node)) {
>                                         dev_err(dev, "no regulators node\n");
>                                         return -ENXIO;
>                                 }
> --
> 2.34.1
>

This function is very ugly...could we instead rely on driver model to
bind the devices? It seems unfortunate to have to write code for
something which could be done with no extra code.

Regards,
Simon
