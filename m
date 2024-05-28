Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3E0C25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 267738842A;
	Tue, 28 May 2024 10:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WiuWWDQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F4A88440; Tue, 28 May 2024 10:30:00 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0378842A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f47db642c2so4464605ad.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716884996; x=1717489796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F03MdJr3GgGoCoyMtifjVfNiiQ8xPjhkeHNdukuiJO0=;
 b=WiuWWDQbdXLdUxrqhWcWf8LTzrvU8obHBRJRQ9w+gykkQqhPz/iYrCvX1NNHlMIKdn
 kAVo2u3+qbrG355XpEjtdyCsY9k490ZnV4C9ODqLxfRafgWZ0HPdZdv1VW9mdU6+Ru5V
 EfWyOQJEbfWqOXdyUAFl653CPN94yrkJrxnZO5wK69PRx/Q4W6roi19W5Rq9qcMgs6RQ
 epXp3kv53mAfJr/mTyjdy30UAPzXD6GRs4rPCNtkMCGysfGUKfHi14wC8Zztfb06r7tr
 r8f3ZKseami2D/yjTw/3nrLJJR3FaJ63utzzeVr/BM0qpZRY7pJyZehu62ZHpsMJMSEe
 QANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716884996; x=1717489796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F03MdJr3GgGoCoyMtifjVfNiiQ8xPjhkeHNdukuiJO0=;
 b=k7MWXxxmJUD+K3oIFccgh/5vXZ5ss0Y8/lCox1MzW5Sq5kIzKb/g0SzO+TNjyLiY5p
 pijMAlM9RpV4TB468fKpZ6gzKoDRAeEBAcQRzIDkBRO7vbE+tOuOegswxaNQm3PgTKAY
 zsoWJegdmkiVTaPH+iG6AV2OusDkIjp9IRr3MjhR89sf0KWdQKYULM96MXtjVF6wp3q9
 oMPg6ckAq3F/0Y8mi9SN6pZ1yNKWsnEIt1fxCh5FGJg5I142qXFwNjQehkQ5mWCjF/Y6
 ffSeNgOdfR3JO+Wy7ElY1mpP8RApyzuxUSmeDRYsFrpTmcT+CVAoOTY19UqYMYDrVrCF
 UHZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlGJb8ygCzkcY5KPi8I4qb8Qs9nimsFs8JByBl13c/6mWwLqwQazk5BTgivv2JjJZzN9k5pC4BXIqwkQn6HSASQ6Jr9g==
X-Gm-Message-State: AOJu0YyPOa7eAZYsBsNIx6uYE301KoVqiiqX3zlfulnp2wLCXtiMGOnd
 7e2AbwZNrkppg/8MaOfR8DrIl5bS6g2D5kk6iIxUApRllWIekh5pRnwWD17MN4CPR6drUqpNiLK
 Ino1z/tw9bOzAUQdnVm418UMvYTSeJHg9U4EKcg==
X-Google-Smtp-Source: AGHT+IGN2IbG1eQzu7IUzOoMDbSi3U95vjSJoOHPMQTkKUcfrrYFEc+MctzgRmMpLb0iYUHyU0b3QpaL/E1hKokqb4A=
X-Received: by 2002:a17:903:2451:b0:1f0:82b8:145a with SMTP id
 d9443c01a7336-1f4497e556emr118505645ad.43.1716884996576; Tue, 28 May 2024
 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-7-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-7-47583d7ad428@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 11:29:20 +0300
Message-ID: <CAC_iWjLZODrFREArqaomZd9TBt0zK+Zi39CFWPJy2vkz-s0zKA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] mach-snapdragon: bump up heap size
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Mon, 27 May 2024 at 20:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> For capsule updates we need more heap space for the DFU buffer. Give
> ourselves a whole 8MiB!
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 536960b83c3b..5023c906bed8 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -10,8 +10,11 @@ config SYS_VENDOR
>           Allows to specify vendor for the Snapdragon SoCs based boards.
>           Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
>           will be used as the custom board directory.
>
> +config SYS_MALLOC_LEN
> +       default 0x800000
> +
>  config SYS_MALLOC_F_LEN
>         default 0x2000
>
>  config SPL_SYS_MALLOC_F
>
> --
> 2.45.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
