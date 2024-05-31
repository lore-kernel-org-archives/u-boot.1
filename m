Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D18C27C44
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322E4866E7;
	Fri, 31 May 2024 08:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HehnHLAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00693866EB; Fri, 31 May 2024 08:37:31 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07381866E5
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a5cec2c2981so81596066b.1
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717137448; x=1717742248; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bFtAg1kfcJwwrw7FIO05Rfsm/XuYnZKRrOgBGiFqduo=;
 b=HehnHLAayf/C9OU0hbPc5a4Wv1IVfWbjPbkFl9jFgCtfJ4qwFRIi8Tf+jJBiN3IwFl
 iSzh7CD6DeMhMISFPGKgbelzJrremR0v9BgL0YHmib74exr04+OSNQsWD6aPVU/NLI1Y
 AL/Tj6BcdUuNDxoc8sJAfL/IEmonxnsAu0rQoovVy1/rEhPKwvVRX/CVtAyDc2ajmFsA
 BqPec1SJIeQJtcJUq/JEF2GTmHnwn+mB86qwlvY0N/iyoXu7w5zabZ9XHUCTjYIEbWlv
 gXlbiOjjyHqQgC/yrhHUrf8NszgyiIfKSn4dV2OUpLtGOEhnGEirf9soNi6bL6Okb1d5
 /LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717137448; x=1717742248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFtAg1kfcJwwrw7FIO05Rfsm/XuYnZKRrOgBGiFqduo=;
 b=BSoeDfwxG4xzRkTm5Lev6mtW4Ewc6t9RPGwKOBNiuDx7MrRcbLGBAMcqtiTAXs+JnS
 i/pmzm1xuCEO06PaL5S++6qbfRKeNi7jz1N7mJwY51pOKR6bU5goqonDGDrjjaUQ4B9I
 HOUVECamWGCEC5kKwUPN1tgJrz7d4tKy/x+ow8eO+AJydNKddBZGcr7UvR52zXJiI8S4
 QkfuleD1lxggbguKFEEtpISAe0Vu6fM8nfRC3hTlnhe5e28nI9VUSSDRdsV7giQSb0EH
 XVQI8TTSwz+hxhLQZz1yu2eKgFugok4eSbLLeNU+mPGvwZpyLjzXFZdbtlhOdcq935IY
 3Mvg==
X-Gm-Message-State: AOJu0YzdMxV/dWxCu6qLiQ7BEF1MOvVvOVC01j8rkUzzgcyTlnqnzaaI
 45QLTS/obX7NDgRW4Ln6dD2cAti0F4SvPvjmgrkWNr0AxN5MC5wY8VFZNxXfltA=
X-Google-Smtp-Source: AGHT+IF1rZYJ3HVsF8Q9ydbNRD6Q2p72WWh9RRQtAK0LXA+KJcqiN0KSgfGwlUwO+k0XLx3+/LEV4w==
X-Received: by 2002:a50:ab45:0:b0:575:a0c:4b8c with SMTP id
 4fb4d7f45d1cf-57a3644584bmr830523a12.38.1717137448318; 
 Thu, 30 May 2024 23:37:28 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c9d584sm628885a12.96.2024.05.30.23.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 23:37:27 -0700 (PDT)
Date: Fri, 31 May 2024 09:37:18 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
Message-ID: <ZllwHifUsIf8XhS6@hera>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528140955.1960172-4-raymond.mao@linaro.org>
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


[...]

> diff --git a/lib/mbedtls/port/limits.h b/lib/mbedtls/port/limits.h
> new file mode 100644
> index 00000000000..9bfbeb22e1b
> --- /dev/null
> +++ b/lib/mbedtls/port/limits.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Dummy file to allow mbedtls linked with U-Boot to include limits.h
> + *
> + * Copyright (c) 2023 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#ifndef _MBEDTLS_LIMITS_H
> +#define _MBEDTLS_LIMITS_H
> +
> +#undef INT_MAX
> +#define INT_MAX         0x7fffffff
> +
> +#undef UINT_MAX
> +#define UINT_MAX	0xffffffffUL
> +
> +#undef CHAR_BIT
> +#define CHAR_BIT        8
> +
> +#undef UINT32_MAX
> +#define UINT32_MAX      0xffffffffUL
> +
> +#undef UINTPTR_MAX
> +#define UINTPTR_MAX     0xffffffffffffffffUL
> +
> +#undef SIZE_MAX
> +#define SIZE_MAX        UINTPTR_MAX
> +
> +#undef UINT64_MAX
> +#define UINT64_MAX      UINTPTR_MAX
> +
> +#endif /* _MBEDTLS_LIMITS_H */

instead of just adding those twice, can you include them from
include/linux/kernel.h?
If not at least remove them from that file as well and pull them back by
including limits.h. My whole point, is these have to be defined once.

Thanks
/Ilias
> --
> 2.25.1
>
