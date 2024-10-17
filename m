Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8ACD2127C
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C01B88FA4;
	Thu, 17 Oct 2024 13:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QP2cmAMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF878889EB; Thu, 17 Oct 2024 13:43:38 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C8788EE0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315baec681so5620625e9.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729165414; x=1729770214;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LWxILAH51/hr4Bd3wiqzoyqgNuq6HGgVx7DXpURG2dY=;
 b=QP2cmAMyicEIaZO1ugqbhGJHT3nZAgDILmBM3oyExEanMbPqtvviRMda11l3ngFyo8
 DKrVyruqiwuMYN1xpTk2IPVDcMtDE5j3lM0fFS9jvp3uSNMBvAGZhxlOr9oDEcyjTLWh
 1AOVqfwaM075n50hWC2lz1vi04i9zah/jfjPsDOJy9tOnR8mcvSn6EcQdeM/16xSywPg
 L1Q56MXtVsNQyLm9WdSiIIJES+EfuZxn84gAMBZ4vP/Cxh0anLcmm7Ig+lYWPMKqIAZ2
 Xd+hHPilBz1dkeZNXaR8h23JZYJx9uyFj44U46cOyqkEBYJLkAFxMkXQHhHx/3EH1e1J
 lhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729165414; x=1729770214;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWxILAH51/hr4Bd3wiqzoyqgNuq6HGgVx7DXpURG2dY=;
 b=pu3VmXyKqIPp1kppFU+4xQ8xl9XSEXUgMHU8sTxYUrbhb+AzhlLKhe4mG9K4vbsHxk
 Rx273pTjJdubb1B/pjwKRw1BpcndTkn+vu7SXX0At9ZHsQWpK3MIXPP2c0/FrgC5MoVd
 frsGw8ZKU51jFnN5CL7wc8in3Mm4vV3LCbUfN5zBmXqOK6H8zAT1weiVC+E4qBP4Q7CL
 xntsEfrg1zZshC8gOAVcRzJe7veCnmB+NalSM3LqgWk8RfIKY9VOYS/zu2bbyXS6Ryqm
 89jvUUzxnTWpLsmS06L6OTrYFaADk+8n5K7YTSnKi/UZVo9jrRa770g8eL0bG89VUk0l
 CwxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnxTDLE2km8ssla1bm5n3CnO8wNx7YnEC36mw5i0wLL0DqXy9VEXYqwKzzBUXwpLSPR0g8488=@lists.denx.de
X-Gm-Message-State: AOJu0YwG9X6ezZMlTxPWU8kq7AwUb2TYxQOSOPCbm6aWjJIP8ad0KwR2
 qFpEC9NZ7EcDoCuB3XxtKI3WQySDx6d9kv9nElZ4B6YNyevP4z3BrzWKacb4roI=
X-Google-Smtp-Source: AGHT+IF8gpGKNU9yeLZBU4xTnZZuPDG5z8OleqTeTDOIN8jJTSJ6QysvOPirH4z7/ThBi/+9LZa/NA==
X-Received: by 2002:a05:600c:4e93:b0:431:5bae:c600 with SMTP id
 5b1f17b1804b1-4315baec7eemr13049515e9.34.1729165413997; 
 Thu, 17 Oct 2024 04:43:33 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c4dd28sm23676705e9.37.2024.10.17.04.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 04:43:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Simon Glass
 <sjg@chromium.org>
Cc: u-boot-amlogic@groups.io, Igor Opaniuk <igor.opaniuk@gmail.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
In-Reply-To: <20241016154832.nqlyspranlrsl6l7@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
 <17FD691FA1477948.8140@groups.io> <87ed4mhgaw.fsf@baylibre.com>
 <20241011180031.cgvuhks7zo772wl6@CAB-WSD-L081021>
 <87frp1r9iz.fsf@baylibre.com>
 <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
 <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
 <87ikttzhwd.fsf@baylibre.com>
 <20241015144245.e4zzhuuqguwnxafg@CAB-WSD-L081021>
 <CAFLszTjYYa_LO2eOj_5fFjGAMivq298g8n_U=-L20pKk6Tkw1Q@mail.gmail.com>
 <20241016154832.nqlyspranlrsl6l7@CAB-WSD-L081021>
Date: Thu, 17 Oct 2024 13:43:31 +0200
Message-ID: <874j5b2bvg.fsf@baylibre.com>
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

Hi Dmitry,

On mer., oct. 16, 2024 at 18:48, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

[...]

>> > ```
>> 
>> Long help should use U_BOOT_LONGHELP, we normally handle this with
>> #ifdef - see cmd/bootflow.c for example
>
> Thank you for pointing me to U_BOOT_LONGHELP. I have redesigned
> cmd/bcb.c to utilize the U_BOOT_LONGHELP(), U_BOOT_CMD_WITH_SUBCMDS(),
> and U_BOOT_SUBCMD_MKENT() functions. As a result, a significant amount
> of command management code has been removed from cmd/bcb.c, making it
> look much more compact.
>
> To be honest, I think I missed the minargs parameter in
> U_BOOT_CMD_WITH_SUBCMDS(). Including minargs would enable us to avoid
> checking argc for a minimum value in the each subcmd callback and
> returning CMD_RET_USAGE in case of any errors.
>
> Anyway, I will prepare v5 version with refactored cmd/bcb.c to
> U_BOOT_LONGHELP usage.

Thank you for your patience with all the back and forth on this. Looking
forward to v5 !

Cheers
Mattijs

>
> -- 
> Thank you,
> Dmitry
