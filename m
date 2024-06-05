Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0528FC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B258831D;
	Wed,  5 Jun 2024 17:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hYtCKBOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA0E8836C; Wed,  5 Jun 2024 17:10:18 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6668A87AD2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c1b9152848so1192a91.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717600215; x=1718205015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lpVmv792UJKTj4OAB3TVV3knAZHf9FkJwEcqXqHfOwM=;
 b=hYtCKBOuK748HeaeCo5I2tp/Dpj5AS2AnPPc8byWpGkbHcgwwdd7KbWvNXqz3EJ45Z
 EhKYJVTQ3wcJ6jbCi1LM0pxaQPFMJ27TxrGP9jVpaif7EIh38u5/ULyWE16+ZU+nReNc
 6iGeIkZjwpjOz7VykHGOkbU7nbY9I+CfQGeOvqdpp3Eger9neSy2E/aoNwypBsD0FQ46
 BRkngfberM1f7xwUr/XkklJLkDZfG4gVJpURk3jiDJvf8p/AIYJ4l1Z/Q/ExONbKCkTP
 S22FhBnsRt0iKB2RuStuJqIBbVP5hUCsbmOpMUgxx4pS/8wFBMySZDVlQ1GSDCiAd3Tm
 0omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717600215; x=1718205015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpVmv792UJKTj4OAB3TVV3knAZHf9FkJwEcqXqHfOwM=;
 b=kyM+k7nXnZgi7Js8I2yWFF9oCLiN+e5Yg7UDfUEW1u4Kfc4uAsRMSN+YBkW/cxmSZp
 nF6TI6BAjx6frSHIfL4qdXGNFnzEwArp1srZNWzM2L3Osmhzd8mF11o8x/UDP8JJi21f
 0HmJ6uY3dJAH3YZhwmzMqdUZwO5Oeg0rJPRIkqL/sUrY8WZNjwn6Zli8V3QdVeRoQ2YF
 FAberL9oOKgXveFN0QsAHO6bAlThRmK6DNtytU1UDa4xAsLO+Zraa/kxV3TiQAqtxn4E
 45HCdqBVZC6aAqy7HWskQ6uFQkDA7xXeAVDICMYoP/DfA5nWsaMpfKCn1gXCa8/lKUsQ
 s/3g==
X-Gm-Message-State: AOJu0Yw+/InxUzqju8Olo16rIffg7xQokO89vJoqyeOcTbF7EXGU5+WH
 3OLG+MVnH9HOXOmjhE6M87ZBKq9jjC284Z9mJxa77Z5jZRuS13ATuHsx+0ln/HWpLQ25Dj+Zt+p
 g1XKjGSsIQstYP9GVP/Ew2OrY8H6bh0wZyQv7va/Prk3EX7PBsOw=
X-Google-Smtp-Source: AGHT+IEV8X96dAIQvd52EEPNF60A/vldeowtx7A7wis7V1b0AxyDb2AoZxurBroSYHU15JJuuCabuFuTQp2124S/clI=
X-Received: by 2002:a17:90a:6fa5:b0:2ae:6cc7:23d8 with SMTP id
 98e67ed59e1d1-2c27db6596cmr2826557a91.41.1717600214846; Wed, 05 Jun 2024
 08:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <0513d382abefaa0cab02bd85e120f544d1ef8e6d.1717599504.git.michal.simek@amd.com>
In-Reply-To: <0513d382abefaa0cab02bd85e120f544d1ef8e6d.1717599504.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 18:09:37 +0300
Message-ID: <CAC_iWjJc5gO1W8GeNRG3Oo24hVzPope3cisz0R=7_pUTjJLWVA@mail.gmail.com>
Subject: Re: [PATCH] cmd: fwu: Also print information about size
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Etienne Carriere <etienne.carriere@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 5 Jun 2024 at 17:58, Michal Simek <michal.simek@amd.com> wrote:
>
> It is useful when structure is also used for saving vendor data covered
> by CRC32.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  cmd/fwu_mdata.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> index 3c8be576ac7a..9c048d69a131 100644
> --- a/cmd/fwu_mdata.c
> +++ b/cmd/fwu_mdata.c
> @@ -22,6 +22,7 @@ static void print_mdata(struct fwu_data *data)
>         printf("\tFWU Metadata\n");
>         printf("crc32: %#x\n", data->crc32);
>         printf("version: %#x\n", data->version);
> +       printf("size: %#x\n", data->metadata_size);

That's only available in v2
IS_ENABLED(CONFIG_FWU_MDATA_V1) etc?


>         printf("active_index: %#x\n", data->active_index);
>         printf("previous_active_index: %#x\n", data->previous_active_index);
>
> --
> 2.40.1
>

Cheers
/Ilias
