Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49F1CFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531FE88F62;
	Fri,  4 Oct 2024 08:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CZ4y1OD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3268188FC5; Fri,  4 Oct 2024 08:06:11 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D189988D75
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a1a412638fso7170025ab.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728021967; x=1728626767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qz3JbVk04SlLQqoc2JDhm2oXFli53kldIKt9a3JtcF4=;
 b=CZ4y1OD8Zf/AmvH5SPxUEQkjTGHeOSfwZdm124c8Ma4uhwkpymaYpy1WhEx7XONRwd
 L121H6jaIbcWkXJtSm1E1CXDPd/yfTXMd9coB375E5s1dzZp0VeH8s6jDvzUz2B+dMZr
 GUe/uFxGPcPwoUe6v9bBqgDz2Pq/pFGv1pdaviBdwsGZiR/yEodObxNGIo5ctL7Q0SSZ
 oVPrFW5hS3P+ARvuCD0T5AVEfD6dDQiXZK+75E9rjfxG6PsftJsmPDauGZC4eFXRwzZ8
 pwQtjmFlVZ7Ruq7rTAecPXbM9Hz9sjABWaZAvuwxAPjktBQ7iD7fhoUBknGoU++7FVQo
 wxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728021967; x=1728626767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qz3JbVk04SlLQqoc2JDhm2oXFli53kldIKt9a3JtcF4=;
 b=q7Rukk7EN5NRV7KckRS059clLxxxsBor9PBZsQM3DD6EfQbldllJijx1iFgBBDeYVW
 tW4JCA8LmOg1LLlCn28QY5N3pDVFL3V0K1nE375gJ6iRUy5kW823JmuXh1DetsZr8W4w
 p9d8oYA/w4VJqEAdlwwE11I9ey6lrxK7iEhxC5rqPS8xO9vY+8d8VvRjkzQKU6/TMBpD
 /QHs/CLqVeKOXsLTih96BLWQzpFOrOyfNhevFLjg16qvLyitWBkmtvrpMP5QsWij370G
 WKr0JWxh9rXtbLsfOLdfBPvuCcaffCCXg8ptlaHBEWWR9mN/ZXRKAzft0SaRTFh5PUbq
 892A==
X-Gm-Message-State: AOJu0YxMjNne1ucs8d9edFJpDUa5dNJAEEXz6la3BB6a5nZXVU27s8Qw
 C/nif2VtJWsvvSd9xsBkjeCVw+vdPJZGB6sSlrf3WoS0K3G6FGCanvO1QShpVmJw/956FXAIsXS
 HgEBTqXiYdltEGRgqV653BDPPpcKsNQj6R+Ls9w==
X-Google-Smtp-Source: AGHT+IHk2G0lcxP8TUnyGM2OYU+trP2Zr99qfkqQ+1nIR6VTF7zfMBOZ3Y/WeX/Do7iDhVsqVYbrDpTTk254hmqMTGU=
X-Received: by 2002:a05:6e02:19cd:b0:3a3:445d:f711 with SMTP id
 e9e14a558f8ab-3a3757c8717mr17091335ab.0.1728021967489; Thu, 03 Oct 2024
 23:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <4326113733e2d84c4849f004b30f41021a9a525d.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <4326113733e2d84c4849f004b30f41021a9a525d.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 09:05:31 +0300
Message-ID: <CAC_iWj+2aAyWpGvxYwPssdW4Vdocw76pnpC-73ixJpfZQ1DMxg@mail.gmail.com>
Subject: Re: [PATCH v11 28/29] [TESTING] configs: set CONFIG_NET=y for
 FTGMAC100
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Maxim Sloyko <maxims@google.com>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 18:48, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> FTGMAC100 is not compatible with NET_LWIP which was enabled as the
> default stack in a previous commit. So enable NET in the defconfig.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  configs/evb-ast2500_defconfig | 1 +
>  configs/evb-ast2600_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/configs/evb-ast2500_defconfig b/configs/evb-ast2500_defconfig
> index 6685f37e3f5..d20ccf16797 100644
> --- a/configs/evb-ast2500_defconfig
> +++ b/configs/evb-ast2500_defconfig
> @@ -35,6 +35,7 @@ CONFIG_CMD_NCSI=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_REGMAP=y
>  CONFIG_CLK=y
> diff --git a/configs/evb-ast2600_defconfig b/configs/evb-ast2600_defconfig
> index e6a4e4d1b7c..47faf05a242 100644
> --- a/configs/evb-ast2600_defconfig
> +++ b/configs/evb-ast2600_defconfig
> @@ -78,6 +78,7 @@ CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_ENV_SECT_SIZE_AUTO=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SPL_DM=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
