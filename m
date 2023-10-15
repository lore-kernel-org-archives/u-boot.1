Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96453CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 10:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0EEA86BCD;
	Sun, 15 Oct 2023 12:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aYKuiuX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F0A86BCF; Sun, 15 Oct 2023 12:30:46 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D2F86B73
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 12:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-405417465aaso34947675e9.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697365842; x=1697970642; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZJ8+lB8xjkrKXuhw6KX+exudZ5+xHXE/3ru6Cc9nRT8=;
 b=aYKuiuX8Wp6S6Lyi0Tq2YlZBJFFQa/UFpVpInhqCorWLPWuxBzrvt/mwqNDjIjiZTQ
 mz+fIxdtl5xSdLFm8BhsrXAe+upCrIPpaP2E2SjkowapIK6JzJXyLYzokbxHOQjKEehQ
 oA11UZASsVxvewuIfNBpGJsxmLgzLruyEqWEdtYoG3x0XTPa2PwcGt+1CVV3HU5tFMgf
 /8U3aUPiLYw+RjsReujj8v8h9PCIvfIRPdA3u9oPOgqeTFvA1RSuDYiq8AaXp5ISQv6R
 545ZdLvd2Bm4Rrl65zFVfLPVcoLvvAl/wR6SVy0wgCQYubmNG2JhBRAQSt9SeYwhg+NW
 45gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697365842; x=1697970642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJ8+lB8xjkrKXuhw6KX+exudZ5+xHXE/3ru6Cc9nRT8=;
 b=cyi+nV7YXmiPffCWryx1bUWcUb/4WwtBfDO4hqCRZ9A7KdthLXUDSEpNsOD9fvfwxX
 R58uxjM6bNvj/5f475X4t5NQai8Eu4xbZcUjeAAEToiezeNt+TXWGGDKt4MpgvZlvXeJ
 hDjsCQ87lukNqkG2r8VGTKoLz2TMOwn2wflexdDE/dQoNRaDCn++58KnGGuHlTeRIdNn
 XwztmsIzdA5TYHa5ErmhsszScjEpzte44K0E3bVvdJta+7ITg0Sw5pwPVE3sVBVZ6a1w
 JPeZPDB8lFax2QkaAuh1Yscn/nT6miaxvn0ADvM0ybj0WubOxjF7pCZx25wTEbOPZIw9
 q+7Q==
X-Gm-Message-State: AOJu0Yxkjui+q5asyvPA5p4lw/mptraOxtIN/TIZMxhWBu1aqcv2cOL6
 5t5/w3g3OWKASIFJmADDoXEBwQ==
X-Google-Smtp-Source: AGHT+IEtwWzqQSbk98K0SnnEqvAngBwDd8fdPRIDIWuY6E049qTIrPboZQ2Yl1NZA5cnm6al7/TaEg==
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id
 g11-20020a7bc4cb000000b00401cb453fb8mr27605244wmk.38.1697365841782; 
 Sun, 15 Oct 2023 03:30:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4847:ec26:6b78:66be?
 ([2a01:e0a:982:cbb0:4847:ec26:6b78:66be])
 by smtp.gmail.com with ESMTPSA id
 ay15-20020a05600c1e0f00b004063977eccesm4207607wmb.42.2023.10.15.03.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 03:30:41 -0700 (PDT)
Message-ID: <25322756-2d1a-f14d-134b-8e394f2979d3@linaro.org>
Date: Sun, 15 Oct 2023 12:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1] drivers: don't compile Secure Monitor UCLASS
 unconditionally
Content-Language: en-GB
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231013130411.46569-1-avromanov@salutedevices.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231013130411.46569-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 13/10/2023 à 15:04, Alexey Romanov a écrit :
> It makes no sense to compile Secure Monitor unconditionally.
> For example, this break the SPL build on boards with a small
> allowed SPL image size.
> 
> Fixes: 126fbbefd89e ("drivers: introduce Secure Monitor uclass")
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index b7bd3633b1..1a768fed2b 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_$(SPL_TPL_)VIRTIO) += virtio/
>   obj-$(CONFIG_$(SPL_)DM_MAILBOX) += mailbox/
>   obj-$(CONFIG_$(SPL_)REMOTEPROC) += remoteproc/
>   obj-$(CONFIG_$(SPL_)SYSINFO) += sysinfo/
> +obj-$(CONFIG_$(SPL_TPL_)SM) += sm/
>   obj-$(CONFIG_$(SPL_TPL_)TPM) += tpm/
>   obj-$(CONFIG_XEN) += xen/
>   obj-$(CONFIG_$(SPL_)FPGA) += fpga/
> @@ -124,4 +125,3 @@ obj-$(CONFIG_DM_RNG) += rng/
>   endif
>   
>   obj-y += soc/
> -obj-y += sm/

Thanks, squashed into 126fbbefd89e ("drivers: introduce Secure Monitor uclass")

Neil
