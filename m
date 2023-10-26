Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3D6C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1858D87649;
	Thu, 26 Oct 2023 20:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m3ZglO54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8560687B8B; Thu, 26 Oct 2023 20:59:24 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6AE86FC8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50816562320so1701641e87.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698346761; x=1698951561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dsu75dIWnIum6mYIKrW8Vk/qOUQUXZoisVxlZoJ75y8=;
 b=m3ZglO54DAOUskU15IcJJnhenBy4wYlBm7/3DKmFpwey6+y3JwBADbrDmwNh0XAFs/
 b5HLlfsK4ld39ravwVND1bd0NrBQmfCbZzwEeuZ4ANJ/N/pN5LdOIN3Ky4utVS1uNk5d
 XIUWWXg1FvD4su1cche8WpRWqC+tFyfO4gOkngOCLYiM1or1vbqJuROkNov6e3XgsEux
 TuFahb0UFDsU2NOQGJp/8ThqlzdBlDltJfPNH+ECUVTEVPS7c/9EPwMoxIz1y9PCpUCc
 AVJZfAp5JZ32tQBfI5Id2JTHbtjXlWlZH1CBQCHlLwQota3su4JCeYdx66zxpTmZ+TOG
 OMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698346761; x=1698951561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dsu75dIWnIum6mYIKrW8Vk/qOUQUXZoisVxlZoJ75y8=;
 b=m4SyQQbNuk+px2L3wtKQwemi71LnUn3r3/Thn/ilWv+4RXFCksglA+CZuKRFWE0qDs
 fkMDNdEDvYB3kICueTg7EJM4JnrTRookXtG9u82skPeEyhKpXFZAfH5zavIDBhdCzBSv
 o/Rgp90UwMvGEYkCSjbbHALUZR+3YYnB0DJmu95bkSWOIr9Amkyfnief9B1dG++1aaX4
 9OiRhIvfZCmhb+8UCTdQr5jIXyxH/HMPwJ40eEX2+irtq5bJXBDrnxGL4xLFPPeUFbOZ
 teCZ58HIti6Q2qqX/KzXVYb4aiyvJflSiIZT50mCOxjQx4kufVhIABLNEzn3hgdtM7xe
 iaTQ==
X-Gm-Message-State: AOJu0YwZ2JHnorKrw76nsE4VEMN91/+dJ/Aqub3JXv/3WeJGisu/II9p
 0T+07UFZV8zGC8KEpIZ3DkPHPPImTLURRrxKkfR4WA==
X-Google-Smtp-Source: AGHT+IGFuiFA2Czvp2KHmdu+Q+KjObeY9U8/v6DzBoGqFIToXpZBVEeG1pKaqREgb/Z7ihz8+Kh5thLoRX4gVFGnZhY=
X-Received: by 2002:ac2:4a67:0:b0:507:a58f:622d with SMTP id
 q7-20020ac24a67000000b00507a58f622dmr163796lfp.50.1698346761748; Thu, 26 Oct
 2023 11:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
 <20231025065103.3101666-4-masahisa.kojima@linaro.org>
In-Reply-To: <20231025065103.3101666-4-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Oct 2023 21:58:45 +0300
Message-ID: <CAC_iWjK38SYray3tS52zXc=SLdsrhh2O0f5JhLsbsE+cGcRq+g@mail.gmail.com>
Subject: Re: [PATCH 3/3] board: developerbox: update flash rawwrite binary size
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com
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

On Wed, 25 Oct 2023 at 09:52, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Current documentation limits the firmware size to 1.5MB.
> When the fTPM and StandaloneMM-based RPMB secure storage is
> enabled, firmware size is bigger than that size.
> Let's specify the A/B update bank size(4MB) for flash
> rawwrite parameter.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  doc/board/socionext/developerbox.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/board/socionext/developerbox.rst b/doc/board/socionext/developerbox.rst
> index 596cf9f908..46712c379b 100644
> --- a/doc/board/socionext/developerbox.rst
> +++ b/doc/board/socionext/developerbox.rst
> @@ -212,8 +212,8 @@ can be installed via NOR flash writer.
>  Once the flasher tool is running we are ready to flash the images.::
>  Write the FIP image to the Bank-0 & 1 at 6MB and 10MB offset.::
>
> -  flash rawwrite 600000 180000
> -  flash rawwrite a00000 180000
> +  flash rawwrite 600000 400000
> +  flash rawwrite a00000 400000
>    >> Send SPI_NOR_NEWFIP.fd via XMODEM (Control-A S in minicom) <<
>
>    flash rawwrite 500000 1000
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
