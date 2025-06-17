Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFF2C7114A
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 05:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC39E82BF6;
	Tue, 17 Jun 2025 07:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n9bX2VeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3140C82C2F; Tue, 17 Jun 2025 07:55:22 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1599580C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 07:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71173646662so33710007b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750139719; x=1750744519; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gmKha4GluADH/W8edXv5ujF3rB03XFhAa6tu+UOUb7E=;
 b=n9bX2VeDQ1Lp8j63DODLg50T6SH+PbMfMsIIflPDMdSZBwJDHl6j/S3S+MTGRpGAJf
 zpmVYcBGNqiSf8drZ/pPtLt6kpl/IXZSim+QDUTK60qGSm5L/WHlyujPysNJbo51pFlz
 eZg3Q1SAcT51ssWPvvyPX491IvluMAeszKmi/PW3sTmkWIvqtM2HjLsOH3txhJ3i1ZCK
 zh+eHSqmnm8tKOqMOCEEZPjlmVTHBPtsGYv4KcBlLJy9INxO6As5/XxYCrMiZAA/zl1e
 ZtIpWIrb9AhEaDin+P8GOKKrh31tP/socnvOfB5nltQGrhJ129WYnZHj0gcfrJ7/lYgN
 b+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750139719; x=1750744519;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gmKha4GluADH/W8edXv5ujF3rB03XFhAa6tu+UOUb7E=;
 b=OhlXvQh9UPIiChx+X3BxOCAhyUu37e+BMXjt2q3tniOcJ9VGLd3V/sJ4BE0lAEQkKS
 FQtNmKzhK6Rc4PMJBP7kWIWaFNdmvNJJ+C0gTpWpE7DzFxRFi4Kklbltl+a6ruwhS7wb
 PRIUSTWchfX9i0PHxxUT3MujwW0qlffTBYGr3KmIH84AcezAlmVExqFFaOTqzpXUMLpR
 iXUB8ALFJ9Dh5hhpt8aQWUmIyLfu+hLfu38u145j8W796WRiRWwoS9lFM/kpQzGsSWvr
 3Dio+sky18RjsU8dJE3iSmfdb6hrLTZ1xAVbQOd419N0R5BXz39jqwYlaVwyRD/wly3h
 PhXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2cwzLKU2sNcEFi6S6JEXkV4tThfCHnxcXnWqMkg1UQ9qc2+j0/hLanIyuKk9tZ2z8Mva5LcI=@lists.denx.de
X-Gm-Message-State: AOJu0YxpnHnvSYbUtb0zhNshuuVt0JthAPA8zfy1WJaBBcTGiHcgW5DP
 Sw9Ou2thbOU5eb4r+Ej8Ri2G7GltGxBnFetjmofW1OnM09IbXkpoRzX5whVqY3xzZLfh5l4VTGz
 K6q1k+mkgsdBMzWrWGPVRaA3NqUXSjhW9zIQGB4Ozfw==
X-Gm-Gg: ASbGncvLNsvqoY3ei11YqB8lpyKLtEzyo6ADaVfazrrJf4zwAcMQ70QXUoCmUfP/tPE
 Z5v3ZB+M1UbzQCLhPpFQGK4lHMHNcpgCWaIJ9pg8a4LhOKK3isuAj94WQJ/K3xbYKJn8GYZkp99
 tnd4t6RlyViwrpxOhsEV2rs3+eWc9YYjsQUOVayRaF2vZg
X-Google-Smtp-Source: AGHT+IH/X2wm2zDL1cwSd5sxDQ4X0a+Q5nIaCThHMepdbfQzHpoyl+EmX76bew5xtFB29XZFwvIe0XKLBuojfuqncyw=
X-Received: by 2002:a05:690c:c01:b0:70a:2675:70b3 with SMTP id
 00721157ae682-71175508e34mr154692227b3.17.1750139718816; Mon, 16 Jun 2025
 22:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
 <20250616220917.34189-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250616220917.34189-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Jun 2025 08:54:43 +0300
X-Gm-Features: AX0GCFtwM-VvOpBUPvqBxLYe3x7fCcBsMjlG0nLj_S5fnCpxIkeBPXxaYWITkrs
Message-ID: <CAC_iWjKV+14=Kh=hv7+DLJ4yZ2TQ1gjXCaLrKRqkY6i6qNkX8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
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

On Tue, 17 Jun 2025 at 01:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The sandbox is used for a lot of generic development, we should run the
> UEFI tests there, too.
>
> Reported-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ea33d07c086..7b1c334d3fc 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -213,6 +213,7 @@ config SANDBOX
>         imply BITREVERSE
>         select BLOBLIST
>         imply LTO
> +       imply CMD_BOOTEFI_SELFTEST
>         imply CMD_DM
>         imply CMD_EXCEPTION
>         imply CMD_GETTIME
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
