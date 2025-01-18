Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1F6C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC97180761;
	Sat, 18 Jan 2025 05:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wk4BZZXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F4E98070C; Sat, 18 Jan 2025 05:33:06 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F85680761
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso514729466b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 20:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737174783; x=1737779583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Veka+VmgGyS8JVUgEEE7oaoJKWP5f1nK++Ju+JshfA0=;
 b=Wk4BZZXEfMaVZ+KNBonC/9gpzVJOaSfcQYXmkM3kE17rZg1kxjLQ+E2wP6D/XkrAzf
 YLTLh0u/I4Qodd4XijrtJ/x1+G5DCDect9Lb2HI6pWaY2tVy3GT1gp2N5cVoR/YgAwKD
 1BLJ3mxiWVTAmNYP7tRnZKtVg7dXoKPszp59k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737174783; x=1737779583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Veka+VmgGyS8JVUgEEE7oaoJKWP5f1nK++Ju+JshfA0=;
 b=USwtXKWJHW1BsD/Rg0Q0HiRfwOJfWDGJ+tOrWaOYN7etafAA4vdrTiWQ1FwIlUv9UH
 H0dvV6Zp+Qvj/fWlHgLZyeNbG376DDe4ZQevBLg5a4ZQdZBcwa+3dE+iREY2GrOCuG9c
 lHzcyjE6QKn/IjDSZouGryoNuiu/DPM90AHDkF0xKdQGMUjsKWPsBJcnK+b4UTkEvBGY
 dkrI7PkeP+49qnVP+/W43vhDP4LJVzD8rahZxf4bN1rIF5BT3W8Q9GAdcZrBrud1efE5
 C4xjqrWeX0GCvfaq/j3Cfd7NzjDSBSmTKQ5BoiZ/EMIxjpd/2T0RW9iz5ugkvgYp5N57
 tufA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7DdxfC8xzzK8hetvlh6QYSEFZOjhCSjweBWzU6wiIYqBpiOjSn7OMNygOJQ9o5DeUob+v8Ik=@lists.denx.de
X-Gm-Message-State: AOJu0YwoF5mwdu7jaX3F4kQKXq8ENfjJJTMYjDPjqtvFdxIPMmfdW3cD
 3d/UbrXJYsvr6JLPi/qYlXugBuG0UJ1KS7Ell2D3VZKuIp0FWbhCigLlBOYbNNihgUGSPJX4YGE
 rT89F/zmPEmlDPnEPEWx60dCghousO6H9YpDG06PaIomI/ek=
X-Gm-Gg: ASbGncvOyeQI4AfOcSiHGBfJTIwKppB0K7ge6x9EDTs1hDE/g0R/svTIKoK54sTJka3
 VF8AtAU59m2vE942LqC0eMv6H86wgyOn33EuaBuYnptWZ20Pw9ywM8Vv/5q4WHE5txBFoZZQPBs
 0ozSGkUIi1
X-Google-Smtp-Source: AGHT+IETYP0gNtC0eOh+Z6dJU7UgPD2X6iObnTD6OvTQoEctvE73rAbxBDQ16KAAmF/F6CZkuNH1yiqS1Wul+i6NiLs=
X-Received: by 2002:a17:907:d1b:b0:aa6:6fa5:65b3 with SMTP id
 a640c23a62f3a-ab38b3c495bmr446017566b.47.1737174783658; Fri, 17 Jan 2025
 20:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
 <20250117-clarify-probe-after-bind-v1-2-273f046ce5dd@linaro.org>
In-Reply-To: <20250117-clarify-probe-after-bind-v1-2-273f046ce5dd@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jan 2025 20:32:52 -0800
X-Gm-Features: AbW1kvZZ01GVK_BYqz54CH1rk-aYEp5snN9PpgiguU32HSR9rIp3SKUYSzE08t4
Message-ID: <CAFLszTi_=S9m54DvKdjdNXf=zOhgg6tog8kcQ+dxjkjQ8BoP4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: remove bogus DM_FLAG_PROBE_AFTER_BIND flags
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, 
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 17 Jan 2025 at 00:29, Caleb Connolly <caleb.connolly@linaro.org>
wrote:
>
> Some drivers set DM_FLAG_PROBE_AFTER_BIND, this does nothing since it's
> only every applied on a per-device basis.
>
> Remove the flags.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/mailbox/zynqmp-ipi.c  | 1 -
>  drivers/watchdog/da9063-wdt.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
> index 713d93a200c4..851aa737c03e 100644
> --- a/drivers/mailbox/zynqmp-ipi.c
> +++ b/drivers/mailbox/zynqmp-ipi.c
> @@ -269,6 +269,5 @@ U_BOOT_DRIVER(zynqmp_ipi) = {
>         .name = "zynqmp_ipi",
>         .id = UCLASS_NOP,
>         .of_match = zynqmp_ipi_ids,
>         .probe = zynqmp_ipi_probe,
> -       .flags = DM_FLAG_PROBE_AFTER_BIND,
>  };
> diff --git a/drivers/watchdog/da9063-wdt.c b/drivers/watchdog/da9063-wdt.c
> index b7216b578630..ec9bc0330114 100644
> --- a/drivers/watchdog/da9063-wdt.c
> +++ b/drivers/watchdog/da9063-wdt.c
> @@ -144,6 +144,5 @@ U_BOOT_DRIVER(da9063_wdt) = {
>         .name = "da9063-wdt",
>         .id = UCLASS_WDT,
>         .of_match = da9063_wdt_ids,
>         .ops = &da9063_wdt_ops,
> -       .flags = DM_FLAG_PROBE_AFTER_BIND,
>  };
>
> --
> 2.48.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>

It is actually a bit unclear, since the comments for struct driver mention
DM_FLAG_... for the flags.
