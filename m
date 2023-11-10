Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AB8C4167B
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 18:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B327874B7;
	Fri, 10 Nov 2023 19:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2BI1LHOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C2A877BF; Fri, 10 Nov 2023 19:16:18 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CEF8721A
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 19:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbrunet@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40859c464daso17568485e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699640176; x=1700244976;
 darn=lists.denx.de; 
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
 bh=BvjXQlUY6/PP7bOwN11QvjkURrxXgeIa9hol/Db3KYM=;
 b=2BI1LHOwTJXWfKXXFYEni0ULSrfpfNPaVaSaBrhOmFKn+bYpSO6pDQlDheKQDq9IHE
 qhGAhIrKzT89fAVjM65ZKn1kWcDnk6mQ+yFnwTo4ymDkExJ+h+J3Vn0FP5LNuKZ59Uq5
 Rnwj2xNcF4ZoxW0YH7j1RR9WVtQOaQm9OhsB2tuzvUjAybM4BU7tRt8N7Ptw8kKoOKLC
 zXg1oHHreowEUhUOR5DmStmzkLMKVrblSx0nOcO79Qso3O8HFm/u3W57YAel+oKEV6hI
 S3cs0rpgTeOrPZ9IBt6W9zVTSS32BlXeuQGO24hpc6wJXPtghpQKUamlekeNxF3tHmX3
 cisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699640176; x=1700244976;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvjXQlUY6/PP7bOwN11QvjkURrxXgeIa9hol/Db3KYM=;
 b=sJFpiaR3PQAZd9egm2Ec26yzLbEWk+0GqbwKMCbOl/DEiDKR0gFRaOQSgyXkD/nHZL
 Rb6xcqSLHld4EcsG5KEN3UxtyhIH6En6mC9QHXwg0fWHk0dmSjYsg+edAnJJfPygMy89
 W7PInrhdF/UEfCjIfAdJ3n8dR2zY5vtIT7iTjx9qzHfNyxxkFc+jylYyM5VCJOBLOVE9
 FQYgcjoPyv43D2W9QW8VkZYLQNqZTipjhEJUedeuo+A847jLd0IMKSmSS8gKqxRul25g
 WNKcvBJ4xPgCyHMpzJ0+SkEJTXOVz3EzlUvDvGaH0BBAKE4I3xO4Vzl8WEENp600ofeT
 Uhbg==
X-Gm-Message-State: AOJu0Yzup0aO4P+Qp4XXVWdrMvO/j0rghO3IFTdOHhQ7fPtufJKUbvTb
 04wKSaDHQkN30Vh5ME9zMtYBuQ==
X-Google-Smtp-Source: AGHT+IHpAM92a5dRWGtidgqRmsC55wVaaK0ocnwNfY87HD3xHLyjMxZNbgKlgxrhSiSwll1ne2s/ww==
X-Received: by 2002:a05:600c:4fd2:b0:3fe:d71a:d84e with SMTP id
 o18-20020a05600c4fd200b003fed71ad84emr127537wmq.1.1699640175973; 
 Fri, 10 Nov 2023 10:16:15 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:2169:e902:f0d0:1845])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a05600c311000b0040a4751efaasm76526wmo.17.2023.11.10.10.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 10:16:15 -0800 (PST)
References: <20230915160130.352099-1-jbrunet@baylibre.com>
 <20230915160130.352099-3-jbrunet@baylibre.com>
 <c89408dd98f78aace3f04c3fdba5702b3045a743.camel@lexina.in>
User-agent: mu4e 1.8.13; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Viacheslav <adeep@lexina.in>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [RFT PATCH 2/2] mmc: meson-gx: set 270 core phase during the
 identification
Date: Fri, 10 Nov 2023 19:10:46 +0100
In-reply-to: <c89408dd98f78aace3f04c3fdba5702b3045a743.camel@lexina.in>
Message-ID: <1jy1f5bhjl.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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


On Thu 09 Nov 2023 at 16:49, Viacheslav <adeep@lexina.in> wrote:

> After running some tests, I've noticed inconsistent behavior with the eMMC:
>  On a cold boot (following a shutdown), the eMMC operates as expected within U-Boot.
>  On a hot reboot (via the kernel's reboot command), the eMMC sometimes (not always, but if
> fit in error, next need to do poweroff) does not work:

No sure I understand.
MMC appears to work (passes the ID phases - which was the problem
before) but fitImage (or dtb) you get is not correct out of eMMC read,
is not correct ?

Have you checked the content ? some checksum maybe ?

What does 'mmc info' reports on boot and reboot (when it fails or not) ?

>     U-Boot is able to read the dtb file but won't boot kernel completely, or
>     U-Boot might fail to read from the eMMC altogether.
>
> This behavior had not occurred before (when the phase was set to 270 on axg).
>
> On Fri, 2023-09-15 at 18:01 +0200, Jerome Brunet wrote:
>> It has been reported that some devices have problems with a 180 degree
>> core phase. Setting 270 helped some of these devices. Other continue to
>> struggle (while it works fine with 180 in Linux ... :sigh:)
>> 
>> Poking around the HW, it seems that setting a 270 core phase during the
>> identification, then using 180 for the rest of the operations, helps the
>> device operate correctly.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/mmc/meson_gx_mmc.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>> index c6168792cbae..284be2b9dca4 100644
>> --- a/drivers/mmc/meson_gx_mmc.c
>> +++ b/drivers/mmc/meson_gx_mmc.c
>> @@ -54,9 +54,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>  
>>  	/* Clk always on */
>>  	meson_mmc_clk |= pdata->version->clk_always_on;
>> -	meson_mmc_clk |= CLK_CO_PHASE_180;
>>  	meson_mmc_clk |= CLK_TX_PHASE_000;
>>  
>> +	/* Core phase according to mode */
>> +	if (mmc->selected_mode == MMC_LEGACY)
>> +		meson_mmc_clk |= CLK_CO_PHASE_270;
>> +	else
>> +		meson_mmc_clk |= CLK_CO_PHASE_180;
>> +
>>  	/* 1GHz / CLK_MAX_DIV = 15,9 MHz */
>>  	if (mmc->clock > 16000000) {
>>  		clk = SD_EMMC_CLKSRC_DIV2;

