Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF03BE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B7D894DD;
	Thu,  5 Dec 2024 14:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ro3qowOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19BF894E0; Thu,  5 Dec 2024 14:09:31 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D211894D6
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3001490ba93so10246411fa.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 05:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733404169; x=1734008969; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lCwZiujVi97BirlLXt6icMYZuz2quHASOyPNeaAVQzA=;
 b=Ro3qowOktXCRs8ud/5f21MET9RS+9xPCwq53SHTaKKQnm0HFx4bCau9Qj4B/gkTivX
 dnKMARHMlNqpTlz5puifcY1FPCv/1iWkK0kiTluBFvwNOmljugCBpoz4S+EuPkK9HR0q
 3DICCL00dYAoOXxcSOfEvUrMyXEKHRfIIVJG8F7rbD4u+91DN/g/lIxBQtphZv8hSaLK
 exBeAPQ111O9F1jPM/YZwu5qkOMGBminDhfv5uQxUBIqQhcerckn+3HEvVfJu9kUlJu/
 BQiF1ULIq8fXuqZhmMBOe7tIHDqzOFufvDqGWNCjPWM9sxFcrhon9lidz9F/KdwpP0eS
 1eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733404169; x=1734008969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lCwZiujVi97BirlLXt6icMYZuz2quHASOyPNeaAVQzA=;
 b=nTvV/TwNUTGae8Cd8NE4HxrgCwtxLGcw3CuCAr7/Zjv9fo+7y3Ynoj0F/0nUtxD8Ln
 rqV4IZPAGgi6Ug7FIlBvty5MjFop8Z/PRiwSx1IOiCWCt3paqNQogSGiBpr3N+g5IN9G
 wNTTyVB7ndyGwwTy/uOP0Sr3mNm4mJPevqmGSYLJJeNv5Z3eodFEAzqCssp90S5I7Ka1
 DNAOkCEUx6JDuV5HvVdcyU+Y2Kc0XdIJJuSf9fb3dEBTdA3q2FxPMzjklKQpRJu5ZJjI
 lJSMkAqqsxtzyWfY4c7zPuqIoqgUAOgf3jdnOh1jeDO6hnTyR5wE9GYwl5yvex1fptpn
 3DCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9T53gXoY/+kVNKQ+GckTxMUcAmTj/acKmjsPAwZWyva1RHumikb+kQebFwYKfFDYRgmrH77E=@lists.denx.de
X-Gm-Message-State: AOJu0YzFVB31mXo1Me6we5GNghDJ4VFJpWsbl6xQLy4bE7DbcUmfra8T
 oWgXarJXjUGybKX7xNnOOSZ8balchuHtiM2Cti1+37bov6taUJReTJ7R8hQVvTk=
X-Gm-Gg: ASbGncsYa/PhKLgmyBVWUTY0OeEHkqAZN4u/V+rWfFtlnG0sk7BA/sRa/Jj8TWrYgms
 vol6MDMUMC69t9AIaltHDv+y0H09fQKJFyZkipQZAN7J2rHYHPZA+efCCdIlNCyi51p5Z6fbKo8
 Kk0umdMk352uUvSWFUatMLCNk01sDMMPIOIhb5WD2MIQzBSpAifSQm2C7asovUrA4X5G+0jSqKt
 buUJB2PM6ogVX4Te/qSC9CzM8790sozmnlCoGKDt0wRB6wO967Z35iVsEbgoqFX7T0OUkwqy++c
 VDmmJESrBL8tbb/bPbY2XNRo+m/sgrWa
X-Google-Smtp-Source: AGHT+IGw7lrQUY6fuqZE2uY85HhN13acWKb1D50zI+Mt95hqfWhTG+9Tz6URfxS9m0hawA1XeN7XRA==
X-Received: by 2002:a2e:b8c6:0:b0:2fb:8774:4412 with SMTP id
 38308e7fff4ca-30009cb820bmr55910051fa.24.1733404168937; 
 Thu, 05 Dec 2024 05:09:28 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d14c74c3casm766347a12.53.2024.12.05.05.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 05:09:27 -0800 (PST)
Message-ID: <f9a77a33-7b0c-432c-a30c-82ec7d2ff802@linaro.org>
Date: Thu, 5 Dec 2024 14:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Check for a valid fw_name before auto
 generating GUIDs
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de
Cc: Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241203161338.1814537-1-ilias.apalodimas@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241203161338.1814537-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 03/12/2024 17:13, Ilias Apalodimas wrote:
> The gen_v5_guid() is a void and does no error checking with pointers
> being available etc. Instead it expects all things to be in place to
> generate GUIDs. If a board capsule definition is buggy and does not
> define the firmware names when enabling capsule updates, the board will
> crash trying to bring up the EFI subsystem.
> 
> Check for a valid firmware name before generating GUIDs.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  lib/efi_loader/efi_firmware.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 6650c2b8071d..112775daf4c3 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -281,6 +281,10 @@ static efi_status_t efi_gen_capsule_guids(void)
>  	}
> 
>  	for (i = 0; i < update_info.num_images; i++) {
> +		if (!fw_array[i].fw_name) {
> +			log_err("fw_name is not defined. Not generating capsule GUIDs\n");
> +			return EFI_INVALID_PARAMETER;
> +		}
>  		gen_v5_guid(&namespace,
>  			    &fw_array[i].image_type_id,
>  			    compatible, strlen(compatible),
> -
> 2.45.2
> 

-- 
// Caleb (they/them)

