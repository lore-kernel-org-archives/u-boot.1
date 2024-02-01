Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D126C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 08:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B0587645;
	Thu,  1 Feb 2024 09:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yfAm6UrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A65DE87776; Thu,  1 Feb 2024 09:40:54 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD5468760D
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 09:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d066b82658so8227661fa.3
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 00:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706776852; x=1707381652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nifLEZHnWsTAeG2FA6HiAJgLwLKCB1CCBjD3KzILr9Q=;
 b=yfAm6UrM34BmzdRckWwI1ZVcUYJ3EPbiOxr0FyRETQaj5YfFIyx5N0Qt4Zjbvp7XxO
 PBMh/LBLInQeQ6KFkEwGwb08E2mHY5Hm0n/omVmuipQT409E+s/c5/ZHLwrsSrhkOV69
 9erRrVzjGe/x/6zToYehTw6iDZfoD6H05ovPGkEsgGTYGHaFg6zb5sLKIa9/zPAH5HOO
 R+7W+ofcHfa+RhH24B7TdJqr5dAbZb3uzp0IS+cewIcp9Zn4P1Jk8+/jnFH2uL4gtzE+
 vxAhv9Lt4gkQXVoej9KVSI5uUbrIpuY+Tel5gZk1q1SI8cccpEZZ5rV3NVd0CCa0VNx5
 ChEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706776852; x=1707381652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nifLEZHnWsTAeG2FA6HiAJgLwLKCB1CCBjD3KzILr9Q=;
 b=b32MdSx8su+2cSJzWbXJY1ahInWRRkiaDeMKiPQDRtaGQYmgjGH0pPvrtt+M1B+H87
 NsHJwZS7CJGhZAm4IVzyOwqcX26GiOCx1r9+0G32doAFg2gPlQJhTq0/On/CoIoWL2ti
 oMqiL1/RMyhmsSN4km8DNs3R2gNPF9o7TDszzdpWY827DP3vzkf+QQ8hp5wxzZa/uWdn
 lnzq7veD0SqC2eKUXi7pCUwiqw5QuN3JXy8Vm4xVmmntDh1OnuyD/0fVfGfuBEV2QbzJ
 QQX1QMGrGGDVl6x8FI0wYvPLjCvEp8qB80xLjiMetFKL3wI0qSgk9mQeU6GY0iQ370yy
 F7Ew==
X-Gm-Message-State: AOJu0Yx3EyZOP7D5FLgzbELRmFc41h/uXiKkhRQerP5l2wFTgAHCR0mB
 Id/6yAycLaNHPf7sULR0IKvF37QU5R4lzrWoY+tbGqAWeUd0JNJ0eZ6elevEix8xLKuNzouFPUS
 RFAQ3qIgXvDBQALqTgJ/TBmU7FpeSLISd8dMLrw==
X-Google-Smtp-Source: AGHT+IGvioHaCycJomOjwpLntPmahYBd4x5mD+RjNtsPYaIyqfOkqPuy5NkFQ98/GREcuqM/DSbpeHnJSmR+hDyJ+i0=
X-Received: by 2002:a2e:9455:0:b0:2cd:7ac4:f9b5 with SMTP id
 o21-20020a2e9455000000b002cd7ac4f9b5mr2690711ljh.14.1706776851925; Thu, 01
 Feb 2024 00:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
 <20240129210453.31070-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240129210453.31070-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Feb 2024 10:40:16 +0200
Message-ID: <CAC_iWjKqfkwsOnNKHmMVW9FdetC4jpgZoaxGkymdCk97pk397g@mail.gmail.com>
Subject: Re: [PATCH 2/7] cmd: smbios: add missing colon after UUID
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

On Mon, 29 Jan 2024 at 23:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For consistent formatting add a colon ':' after the UUID label.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/smbios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> index 67f3a9f5f19..62935ecd1a2 100644
> --- a/cmd/smbios.c
> +++ b/cmd/smbios.c
> @@ -76,7 +76,7 @@ static void smbios_print_type1(struct smbios_type1 *table)
>         smbios_print_str("Version", table, table->version);
>         smbios_print_str("Serial Number", table, table->serial_number);
>         if (table->length >= 0x19) {
> -               printf("\tUUID %pUl\n", table->uuid);
> +               printf("\tUUID: %pUl\n", table->uuid);
>                 smbios_print_str("Wake Up Type", table, table->serial_number);
>         }
>         if (table->length >= 0x1b) {
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
