Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C62BD16816
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67DF8430F;
	Fri,  9 Jan 2026 12:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RTaBMHCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF2A84315; Fri,  9 Jan 2026 12:35:55 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9502A84166
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64d4d8b3ad7so6649609a12.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958548; x=1768563348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IsAAwGCJcgkq5m/uYLuoIQQfb4n5eT9IpY/RVapn5Io=;
 b=RTaBMHCkaIdDYNQEnWxD7B6KPiJhex9WL/IVLX3P42s31X1QmbBNcIo8VLjJjXK84G
 zwI98ecM89CZzAQ7yAtQzRTyR53+XQ0NKGSPmZQlL1DKJORo5wPqxnL+GAMKcAk3U6wo
 pe33avyBb3W1zbe8wcA7HyZmPIvePQw1AT/Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958548; x=1768563348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsAAwGCJcgkq5m/uYLuoIQQfb4n5eT9IpY/RVapn5Io=;
 b=Gr92+FwJTzB4gm5kKvY0CTY1DDkduH5TyiKSf5c+DDsyN37gZPQP/b0QarfzHK5Hbm
 yVX6wJVzo2Q0ErfOCG4EIyuRC8gj4Y9V41DdEzOBRZTjV+Uy1qDdWpMuPOV2nsnlQUdd
 vDUc3O3+/nJ7QPAmM+scmym+xcuwzF7EjICgDJBUKhap8Xbw36CenkSXISTCgv/k64LX
 c1Cuz+FcnlDrVBf2R3ISapcu6WymyUhdWmzcrzZ6aIQO0ZpEABgi1BvD+FB7St71B+zE
 Y82Iq23qDoaCn1qWJ14geO9n73x9g7oNdqW48ofVq26LMSpN9qp1s0nyoWdgA/Vs/VJs
 TIJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSSsqydWKR6KUGA5FS8E2zW42xTF65KWt9ibXoPyGjw4jhf1wWvfkSqlZZ83kSmdc+wk/KSe4=@lists.denx.de
X-Gm-Message-State: AOJu0YzBnah40ZzNzK4e4XAtdpyX9dBQpHb4OweAta1uh0frsr2+6xXN
 Yc/YvAF4p4IC+1UKet8tYFQwRqByy5D6NzeZVMOCmYpV8pT48FMuhpJ77nF3IQrT04dVT9UkgIe
 NuJd5HAB1TC6z17lj2X4Zz+tmq8uhozCSvRAyJvhr
X-Gm-Gg: AY/fxX7N8wkXEXFft/j1gLd2xWlO3gK8bs934RqDXl0Kf2YSURSp7Ek2ey77jpCqwYI
 KFkTUxXPSfo0S2HtIecxW2SYN9KNWO+fre8CZPZHVo3UEje+vpKuqF4aaWI7e1nazrvyN1E7KhX
 iL1mkC+GhO5+1nNsLtM5/FC0ujRqoKlaVfzM/Ken7/ces7YFNaeKAoBp3kIwimF/lA+3+P5fi0c
 i8Ii6BdRStzmZeS0iUWYMchRJ/X4HU/M/4yKUY7SBsnVpTBhBY900gTH7VzTFD/mxXYOQ==
X-Google-Smtp-Source: AGHT+IESciKk8Gyq8nBEHuq0TSFSTmebjQCnEKcQruirX9y2NdAa+JF1/rkQT8ijsutlqcWxGujLRICV+kkhEvB9/NM=
X-Received: by 2002:a17:907:86a6:b0:b80:40fe:92c with SMTP id
 a640c23a62f3a-b8445209ea4mr926160166b.24.1767958548036; Fri, 09 Jan 2026
 03:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
 <20251203-fit-compat-v2-4-0fea56f23809@cherry.de>
In-Reply-To: <20251203-fit-compat-v2-4-0fea56f23809@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:35:36 -0700
X-Gm-Features: AZwV_QicY5NluVTGQIaaCeuzwtikM4WAKO2uqKuacNhplhKmAqrnRA3oeB8Pqm4
Message-ID: <CAFLszTjqZhQVP0m8QUUKsJbJLZo4VZmH3+3sdVYn267EthAKzg@mail.gmail.com>
Subject: Re: [PATCH next v2 4/4] boot/fit: print all configuration node
 compatibles
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 3 Dec 2025 at 09:19, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Fit conf node may have a compatible property[1] which stores the
> compatible of the first blob in the fdt property of the node. This can
> be used to automatically select the proper conf node based on the
> compatible from the running U-Boot (matching the former's compatible
> with the latter)[2].
>
> This brings the ability to mkimage/dumpimage to print the compatibles of
> the configuration node(s). U-Boot CLI commands such as iminfo also see
> this addition to their output.
>
> [1] https://fitspec.osfw.foundation/#optional-properties compatible paragraph
> [2] https://fitspec.osfw.foundation/#select-a-configuration-to-boot
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  boot/image-fit.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index c42b22ab02b..cc7a4bb44dc 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -323,6 +323,17 @@ static void fit_conf_print(const void *fit, int noffset, const char *p)
>                 printf("%s\n", uname);
>         }
>
> +       for (fdt_index = 0;
> +            uname = fdt_stringlist_get(fit, noffset, FIT_COMPAT_PROP,
> +                                       fdt_index, NULL), uname;
> +            fdt_index++) {
> +               if (fdt_index == 0)
> +                       printf("%s  Compatible:   ", p);
> +               else
> +                       printf("%s                ", p);
> +               printf("%s\n", uname);
> +       }
> +
>         uname = fdt_getprop(fit, noffset, FIT_FPGA_PROP, NULL);
>         if (uname)
>                 printf("%s  FPGA:         %s\n", p, uname);
>
> --
> 2.52.0
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Concept has:

40fd6b04b9f boot: Show compatible strings with FIT information
