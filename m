Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747E2D2127F
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B170C88FA4;
	Thu, 17 Oct 2024 13:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T7svPaOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9C488FD2; Thu, 17 Oct 2024 13:41:43 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5415488F57
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso732757f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729165299; x=1729770099;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aROGsa4qf+z9vHN3EbDPXJFucg6RZQKdlYgqfKaO0ts=;
 b=T7svPaOqE7KwxkdkskFayQVc9MW0o2bd7x0v3mQF/+gZtdADJ/L8Crm+t9pZHNv60l
 n1nTRKJExyvBLps/MuzU91zTvh9dGxPAsOvrwprCffxmQWz8IZIUObiKFOdk0p1kRlTb
 uR9CwXnep8uQHVtexXjlxkaTWqBULWHDai67xMQMx3SdmJTlc3HCRA8Q5ulx2UxCHV/n
 axmNNdzYha3oRXqO8gBfx06jsNkwiZJ1weNQEgJUAn8AzO/YD9/bSrKe7+hJC5ZY5BeI
 3KXsRxbjjeUR08tdiZYTePcdy1btagQ1DNlJ5VTftShN2y6UarV1HzJ46MNph3JBAmBa
 dJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729165299; x=1729770099;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aROGsa4qf+z9vHN3EbDPXJFucg6RZQKdlYgqfKaO0ts=;
 b=bmYB15tZf4b9Ycq59qYkKArHkjSA2kaa7lWvCvB0aCP2sLxziRNutc945rnHR1QVxR
 B2c4Lpa3se9Lped5YBzvv+iWv/j0NkizatmU9pDqu/XfpAxSgr1tmDjVSQK5pZBGtgQA
 bRB2d9s10hPg4UKpjmX36nklCdTfmKoROK/LbTJHJLdBfvRpq9CkEauKP+1X/xpnBj3K
 nbQ9lXf9oGfKs/Gi8vcNPzAyBRzdPiCCsPvQrxhZANZBGBeYXnmmukYjRa6yXDXidXf1
 BLTVaDWJv6HYJ+E60KL3NykjU9xy5Bn1VQ5ByunEDjdPscLQjTLOiJaT0/yqPIMHoDTa
 ZDDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGpXwSpDbTkPKx0pMrNL+DdX+POYR4tR7IA9hvSaMldln7mqvu6KoPgvnkGxmY6/jIRWNUfSQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxZSR2pmUk0In/TUEhKueHw8O3597DmgDZFWIaB32gKarc/Yvl4
 wz/dv2ZqWsahlnWPPMZOp2jmDHj9m08Xxm/krHeF/QTi8s+pQ6nkeaRCviSc2No=
X-Google-Smtp-Source: AGHT+IHGpRZE68/LINUIX56UATrxqK4rqGNHoSmJB0LcMGKT4WBkNVXkqnit23ePNlIHnSGyrVxVCg==
X-Received: by 2002:a05:6000:e85:b0:37d:3f5f:9191 with SMTP id
 ffacd0b85a97d-37d5ffb3301mr16395883f8f.33.1729165298723; 
 Thu, 17 Oct 2024 04:41:38 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a584sm7006756f8f.20.2024.10.17.04.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 04:41:38 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
In-Reply-To: <20241016140654.mxms6m4g2rr3vncz@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
 <17FD691FA1477948.8140@groups.io> <87ed4mhgaw.fsf@baylibre.com>
 <20241011180031.cgvuhks7zo772wl6@CAB-WSD-L081021>
 <87frp1r9iz.fsf@baylibre.com>
 <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
 <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
 <87ikttzhwd.fsf@baylibre.com>
 <20241015132631.qnnbrmnuwp6zr7r5@CAB-WSD-L081021>
 <87cyk1z8sy.fsf@baylibre.com>
 <20241016140654.mxms6m4g2rr3vncz@CAB-WSD-L081021>
Date: Thu, 17 Oct 2024 13:41:35 +0200
Message-ID: <878qun2byo.fsf@baylibre.com>
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

On mer., oct. 16, 2024 at 17:06, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

[...]

>> >
>> > I just run build on the my x86 Ubuntu machine.
>> >
>> > $ cd uboot
>> > $ make mproper
>> > $ make sandbox_defconfig
>> > $ make -j$(nproc)
>> 
>> I tried these commands:
>> Here is the successfull build output:
>> 
>> https://paste.debian.net/1332378/
>> 
>> I use:
>> $ ~/work/upstream/u-boot-dfu/ dmitry/ab-dump-v3* gcc --version
>> gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
>> Copyright (C) 2024 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> 
>> $ ~/work/upstream/u-boot-dfu/ dmitry/ab-dump-v3* ld --version
>> GNU ld version 2.41-37.fc40
>> Copyright (C) 2023 Free Software Foundation, Inc.
>> This program is free software; you may redistribute it under the terms of
>> the GNU General Public License version 3 or (at your option) a later version.
>> This program has absolutely no warranty.
>> 
>> What toolchains do you use?
>> 
>
> By default, my machine, which I typically use for cross-compilation, has
> an outdated toolchain version:
>
> $ gcc --version
> gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> Copyright (C) 2017 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> $ ld --version
> GNU ld (GNU Binutils for Ubuntu) 2.30
> Copyright (C) 2018 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or (at your option) a later version.
> This program has absolutely no warranty.
>

Thank you for sharing. that looks indeed very old and would explain why
we see different results when building sandbox.

According to this commit [1], you should use gcc 13.0.2 at least
Would it be possible to update?

[1] https://source.denx.de/u-boot/u-boot/-/commit/11934281526bda3be51783380b55c332804d043d

>> >
>> > That's all.
>> >
>> > I've already sent the v4 patch with #ifdef. I can prepare the v5 patch
>> > using the IS_ENABLED() macro and will aim to send it today.
>> >
>> > But I have one question:
>> >
>> > Do we really want to display the ab_select and ab_dump subcommands to
>> > users if these commands are just stubs? Perhaps we should consider
>> > adding #ifdef directives to the subcommand arrays.
>> 
>> That's a valid concern. I don't think we should display
>> the ab_select and ab_dump commands to the users but I still want to have
>> IS_ENABLED wherever possible to keep the code simple.
>
> -- 
> Thank you,
> Dmitry
