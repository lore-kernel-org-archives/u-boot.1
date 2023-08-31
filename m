Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A86FC83F22
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A81C86553;
	Thu, 31 Aug 2023 04:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E1Pp6Szx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C4C686561; Thu, 31 Aug 2023 04:50:09 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C03E88657D
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so344656a12.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693450206; x=1694055006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lRPHhF6y9Ke4rjXsTTkwutmxVELOLXJEnqu7yUpLpHk=;
 b=E1Pp6SzxXh4+NX5r03GoWctxLFWYdv9UlTm8Ql7iVApPtIykRcOZyiIq7PIFCuZwMa
 aqITOHHuT3CL/djx2MvXiDi7aFD8iYIEDmXsEx0mb2Ia7O9K6OpPbpMOJyP8UiJFv+51
 UkfwKAP4aQp7qsux+dGKAdLjrdo7+UTXaci3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450206; x=1694055006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lRPHhF6y9Ke4rjXsTTkwutmxVELOLXJEnqu7yUpLpHk=;
 b=Aco6Djoj1N4u6T08K0jG++Nu7ypEZ5HP5pF0Umu5a//omWL5czjqLYT0jZqZuvzzQY
 QfNM3YHsgsBub6Wi7wTtqWICns3j8ytSEuBWV/uZ95sF6oR/ZAxFMJFTcAuSPw3PuC8S
 yI2QP8Y9wszO9f80R/mnCu/tF19BrRIKaB0RRHICHkOArN4SqBzAeS7T6VmzW/4Dva9p
 6zLqlsXMeI1J4XmOOB4SuyYscTa7Y70y4zSIIXTXoDHfd3gZDsPjnUfCLju5fqBoPF1G
 BHUAAz8h24IV0StTLJ42IpO/Vif6rwYhUpNtfKygmvOWU5B2E/jV1tDflkahSrGYnZgx
 moiQ==
X-Gm-Message-State: AOJu0YwQSf4Gz+XalknkSLA6Zk+Vva7+y5Ut/MlFok5L9/RnBIV79HJz
 S5XzU1hDZxFXzODzGsxfetlP52ctO+XSauX9ax8guw==
X-Google-Smtp-Source: AGHT+IFdfVmiJGWfgtvP/F5d4lNKTgcE6rih+vjEwqR7n2Q1j6oK5Ip7y4BxYrlxr4ZYwuHiQv4B9mrYJ3T1pQAkAwQ=
X-Received: by 2002:aa7:d802:0:b0:52a:4676:1bef with SMTP id
 v2-20020aa7d802000000b0052a46761befmr3318190edq.29.1693450206200; Wed, 30 Aug
 2023 19:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230829221457.101469-1-afd@ti.com>
 <20230829221457.101469-2-afd@ti.com>
In-Reply-To: <20230829221457.101469-2-afd@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 20:49:20 -0600
Message-ID: <CAPnjgZ1j2WFOup5wM817YeMz98te6zNGK1NB-tTz+Fv7QMMMtw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Makefile: Run defconfig files through the C
 preprocessor
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, u-boot@lists.denx.de
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

Hi Andrew,

On Tue, 29 Aug 2023 at 16:15, Andrew Davis <afd@ti.com> wrote:
>
> This allows us to use some of the normal preprocessor directives inside
> defconfig files. Such as #define and #include.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  scripts/kconfig/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 12e525ee31f..16db9b7cf60 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -93,7 +93,8 @@ endif
>  endif
>
>  %_defconfig: $(obj)/conf
> -       $(Q)$< $(silent) --defconfig=arch/$(SRCARCH)/configs/$@ $(Kconfig)
> +       $(Q)$(CPP) -nostdinc -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
> +       $(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
>
>  # Added for U-Boot (backward compatibility)
>  %_config: %_defconfig
> --
> 2.39.2
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Can you please check what happens if the file has an error flagged by
CPP? Is it obvious what is wrong?

Regards,
Simon
