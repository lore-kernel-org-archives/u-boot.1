Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058E6C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A8588279;
	Mon, 10 Jun 2024 10:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="VI+VxreT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A918843F; Mon, 10 Jun 2024 10:37:11 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4117B8822D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52bc3130ae6so2516583e87.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1718008628; x=1718613428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vn5ZPHR126rPkkRCsFkIkiFQtWLPG8ppHEfcAlk14lY=;
 b=VI+VxreT5uHieZkcxGYkxQVJ037rQc24VVEiubdRHJustlJ4VWkR0ENsfjM7rb2JfS
 wyijhAJtm7sdmq91lZ6/0LGF7EZy+Hj+CTBY6vqTnLytGJ5KE4fAKilBGEiV1cYf1VGz
 JSM0oboxkHeg2kdD3TRLzVpjuyXDZPwPQA9keRS6pK6Gw3EEUEDJ0VweDDvD7oxWTqwW
 uSQC9KO1lZdJqNMjNpa3ktgclJzxteS4brnPnTHm0aZoExO/jJvOlC8ZuJPlFy6wbf61
 HpdCmu6j4vqbNYrF48RWN8Xb5QLpvGZr9zpGptmZmyoMHmZGSr9wI/eZ7iQq+D6KK1a/
 WaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718008628; x=1718613428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vn5ZPHR126rPkkRCsFkIkiFQtWLPG8ppHEfcAlk14lY=;
 b=hFktTuy/Who0Q4a//RYAY313+WUpa5Zvim7vTmbwtjzZa6US7SEgqM0qqKxG6YsgVi
 ufvu99K9uykmtsxSLcohqsqKwm6cMslxIFeklrnWSBvBXPa2aoSwZQbyIxH7kVK3jJ52
 qBTNkgAPtXasRO+3atsM6y8/3+I6Ph6nCDMAxyVouwqUDB1CuZ5/sEovYoQLOSvt9wdw
 OFqRKTKqXSGcxnHA20voEUDrEc/TwG1DXZXVljyAp8ibt53C+V2UTkRVSm6twHhA0epT
 VSeOdqHL1IuHSOVgZAw0mf9fMGO0PZRo5crDymelujwdJmhbn+aqdBfwjN6Rc+TLmSMz
 AOmw==
X-Gm-Message-State: AOJu0YzG5hez/MRIEO4qiVszroUbKQQAKySFe7UHsFykWtdvHOhgqZ5a
 weHY3DFWgKeTF83N07irDxrlpji8E/06HIk5DMiY4Sq3gJl6nOhzEUgeFJq/Z7Bs/pTMvtJqQRf
 HZZa9upcGZXK47zogxDdwIsVOULNCsLl4ncZvwg==
X-Google-Smtp-Source: AGHT+IFKgSWg/r+n0l9DNilpf9GJADLjPK9/esge2l4fOvI38UsvaY6TK1KjclU72ahH6jYuAO+uKVA9k+lLkcUqj48=
X-Received: by 2002:a05:6512:3f10:b0:52b:59f7:7602 with SMTP id
 2adb3069b0e04-52bb9f66381mr7327433e87.8.1718008628403; Mon, 10 Jun 2024
 01:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240419220331.277574-1-marex@denx.de>
In-Reply-To: <20240419220331.277574-1-marex@denx.de>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Mon, 10 Jun 2024 10:36:56 +0200
Message-ID: <CAL6CDMHFDhcUXhz5+w92SqKa0jC1TNPEiyvRS=jZ4CBqTm7=PA@mail.gmail.com>
Subject: Re: [PATCH] ARM: stm32: Ping IWDG on exit from PSCI suspend code
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Apr 20, 2024 at 12:03=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Make sure the OS would not get any spurious IWDG pretimeout IRQ
> right after the system wakes up. This may happen in case the SoC
> got woken up by another source than the IWDG pretimeout and the
> pretimeout IRQ arrived immediately afterward, but too late to be
> handled by the suspend main loop. In case either of the IWDG is
> enabled, ping it first and then return to the OS.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/mach-stm32mp/stm32mp1/psci.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32m=
p/stm32mp1/psci.c
> index 4f2379df45f..e99103910d9 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
> @@ -808,6 +808,27 @@ void __secure psci_system_suspend(u32 __always_unuse=
d function_id,
>         writel(SYSCFG_CMPENR_MPUEN, STM32_SYSCFG_BASE + SYSCFG_CMPENSETR)=
;
>         clrbits_le32(STM32_SYSCFG_BASE + SYSCFG_CMPCR, SYSCFG_CMPCR_SW_CT=
RL);
>
> +       /*
> +        * Make sure the OS would not get any spurious IWDG pretimeout IR=
Q
> +        * right after the system wakes up. This may happen in case the S=
oC
> +        * got woken up by another source than the IWDG pretimeout and th=
e
> +        * pretimeout IRQ arrived immediately afterward, but too late to =
be
> +        * handled by the main loop above. In case either of the IWDG is
> +        * enabled, ping it first and then return to the OS.
> +        */
> +
> +       /* Ping IWDG1 and ACK pretimer IRQ */
> +       if (gic_enabled[4] & BIT(22)) {
> +               writel(IWDG_KR_RELOAD_KEY, STM32_IWDG1_BASE + IWDG_KR);
> +               writel(IWDG_EWCR_EWIC, STM32_IWDG1_BASE + IWDG_EWCR);
> +       }
> +
> +       /* Ping IWDG2 and ACK pretimer IRQ */
> +       if (gic_enabled[4] & BIT(23)) {
> +               writel(IWDG_KR_RELOAD_KEY, STM32_IWDG2_BASE + IWDG_KR);
> +               writel(IWDG_EWCR_EWIC, STM32_IWDG2_BASE + IWDG_EWCR);
> +       }
> +
>         /*
>          * The system has resumed successfully. Rewrite LR register store=
d
>          * on stack with 'ep' value, so that on return from this PSCI cal=
l,
> --
> 2.43.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
