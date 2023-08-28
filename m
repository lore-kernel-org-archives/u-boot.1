Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB3AC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87925864C4;
	Mon, 28 Aug 2023 17:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="Cypj/IHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CA3864EC; Mon, 28 Aug 2023 17:32:14 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2CF5846B8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso32163315e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236731; x=1693841531; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kIq8XlXJBIPiiKM3yVe7yqrL9Ow4sfgMbJq1CMDRC9k=;
 b=Cypj/IHCyu5SGAZk79WbFrUO5f+Z7fbWbabB96JN4d+Dtz+q4dgflLDwVrCwtNLDGP
 TE4MYx+H7+QAICtAR1MFiFyhkVt9YQeskfGYVKIV7KaRU47eAfljSm2srQaLOqTVl01R
 ZlQH0PtmKT1hnAn5PfnuBsi5Pif+PJ2dmtGyZzZAiGo38cjJQ+DGft4Y+aKSa68Iqgg3
 O5GWDetLmmrXWAw//trDQhu1xMveZzzxST3b10VpuZHGeqJ+HH+h1GDy66qaxwL3zEB6
 SUNLuUF9sf5XwMyEMj67Bsf1muiE4M49qcB0J8mfqW7bXIyLZbvG8MV2o/HKozXfR4Ae
 GaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236731; x=1693841531;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kIq8XlXJBIPiiKM3yVe7yqrL9Ow4sfgMbJq1CMDRC9k=;
 b=B7cpgj5x9JxkalHyPhygxgk+pczlG3W4HUoJ/bHoAtEyZyLubRiV33YDEC+lBSSA+y
 TfqAye7T2RjY7bNn0LbVgmQMtOXmrvjs1A9t1Ix/9ZEboJ9edS5JGh/ZBtNwwn1Fsci7
 XUgpUA+zQ5cxH5cgKuDDk7habqSDDTCRbqHmjWZ3byp3pdic8I6RiSnzAvsSIfJt4GrZ
 +j3gkzDwNhSeabX3cYNv6QQRxwxL62ZXsvfkEkDRKfyHPDC5GyAg3Iy57s7KnJgZrbry
 H2UgNq+OxWnPbrEwfdoSa/a19/lD/zpwadpm/YiCr4WWH4Ki1l0F++Cb/uEsIrY8gZr3
 y7xw==
X-Gm-Message-State: AOJu0YxqPS5pwjAWIvtPz0Yu8GjhBHa21vmmXOKXModf6FsRqYknNotK
 Wb/g3wnJmfKdbdsihFOLL1CDRg==
X-Google-Smtp-Source: AGHT+IFzmdleqPHqA6RkrcSUotY4wHi9Us4T8BTDvoLg79iC4k8wKFNS0eqwqdbp7bMwRSuphNqa/g==
X-Received: by 2002:a7b:c047:0:b0:401:1b58:72f7 with SMTP id
 u7-20020a7bc047000000b004011b5872f7mr10075941wmc.38.1693236731206; 
 Mon, 28 Aug 2023 08:32:11 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 p25-20020a1c7419000000b003fe195cecb3sm14249433wmc.38.2023.08.28.08.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:32:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 10/20] include: env: ti: Add a generic
 default_findfdt.env
In-Reply-To: <20230825180305.69515-11-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-11-nm@ti.com>
Date: Mon, 28 Aug 2023 17:32:10 +0200
Message-ID: <871qfnw5c5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On ven., ao=C3=BBt 25, 2023 at 13:02, Nishanth Menon <nm@ti.com> wrote:

> ti_mmc bootmethod uses a findfdt routine that is expected to be
> implemented by all platforms.
>
> Define a default findfdt based on configured DEFAULT_DEVICE_TREE option
> for u-boot. This saves duplication across multiple boards and handles
> architecture folder location changes centrally.
>
> TI ARMV7 platforms will need to override default_device_tree_subarch
> in the env file to point to the appropriate platform. Note: default
> "omap" is used to cater to "most common" default.
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes:
> * Made it as default_findfdt as discussed in review.
>
> V5: https://lore.kernel.org/r/20230824031101.3460411-9-nm@ti.com
>  include/env/ti/default_findfdt.env | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 include/env/ti/default_findfdt.env
>
> diff --git a/include/env/ti/default_findfdt.env b/include/env/ti/default_=
findfdt.env
> new file mode 100644
> index 000000000000..a2b51dd923bb
> --- /dev/null
> +++ b/include/env/ti/default_findfdt.env
> @@ -0,0 +1,12 @@
> +default_device_tree=3DCONFIG_DEFAULT_DEVICE_TREE
> +default_device_tree_arch=3Dti
> +#ifdef CONFIG_ARM64
> +findfdt=3D
> +	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
> +	setenv fdtfile ${name_fdt}
> +#else
> +default_device_tree_subarch=3Domap
> +findfdt=3D
> +	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subar=
ch}/${default_device_tree}.dtb;
> +	setenv fdtfile ${name_fdt}
> +#endif
> --=20
> 2.40.0
