Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789D5C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 08:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B1587D02;
	Tue, 13 Feb 2024 09:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M9ClkQTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 250A187D10; Tue, 13 Feb 2024 09:13:52 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C0587B05
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 09:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5114c05806eso6495579e87.1
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 00:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707812017; x=1708416817;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o8KZfShJ1qyc5Mc0Yd+LhUrsW2D5WKmZkN93MxaxWUc=;
 b=M9ClkQTqtkW+iZ93xfkcLRD1QFpKpqzsktQBBKTowhZDWlDv02+GiPcf3FxD4vnGU/
 a1/5xAXzHVxQTOsi++j9BFYCL05rKY4sJTGgAi9A41gwcdXcvIIQ/EKtrYPi58qBJLdv
 XpfDTeqo+dHia9LmeTVXyWYbm2tHIGQoR3yD9I69aNDzar5Pg1YVatw8ZuUwtsyqRy80
 TgedtigslPg8lsy9/tlxWy39qVgC07CbZKRX9VDP1gNRhx6shS5CFnDvJyQWPk7V8zer
 cRwieTTaNDKM9qENX6lXR0S9w66fHPnDNOAfAaryX+3c9mtth8Ggm3oaeukm1QN6gVyx
 v3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707812017; x=1708416817;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8KZfShJ1qyc5Mc0Yd+LhUrsW2D5WKmZkN93MxaxWUc=;
 b=w3AoPESrv7VkpP8QvXb6r6ot9qjfawL1OyNE7m5FXM8g43TnO3/5vqOEz4P7u+wDq1
 izq7XWey0tc/fVAKXivwM8xEA4/3RQ0NIyb7Mi2SfJ49NSRGnr980t9ibskN8xgX9BBe
 gn+WUPlO+0HeI3MZhqied3M1lItLOSnXg7yW4XQXPKkDRNPfxMP9HcrmzVrVq8HzIeR3
 bKv15vGXxzPKWrdWZju62bBl6LXldIyk0O6Qr1Aha1crn2/ECY4AtLp16hw1F9mBSFk2
 VcN6IOJ4NKJGqaD+33t2y0zFScjeksVF3YbOLlWgAegCLJNhi+Bncs76ZEGIKkqCb+nm
 1MEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCUB53/S3cfZqKT0r3Oty1hM013Vzvx8/uFj29ssnNS7YvJ0seo9RS4Eatn4Nxv/sw5rksGd1Q0Mp5fC4sbdKLUnwSlQ==
X-Gm-Message-State: AOJu0YxH4Plu78dLgnpEjxTvkn77BkWwKLGq/IcYoTi00WvYVQfORx+l
 wGTK++zp2amnidxdalYrfaed5vhws0mrKQryhI1oT2oBls7fWI+8l3uJEeWwXu8=
X-Google-Smtp-Source: AGHT+IEnNHRwWgswzd3r1KHyrEsidPiC8b4K1qfQi23zsCVbtzZ4XOKshD1onQD8cy7z9ZvBjKuKNA==
X-Received: by 2002:ac2:58e2:0:b0:511:47e1:aa58 with SMTP id
 v2-20020ac258e2000000b0051147e1aa58mr5275753lfo.28.1707812016819; 
 Tue, 13 Feb 2024 00:13:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNwkDB8b04sYnG9GaJJhyVFSMYhNAI3x5/DKCtpgDleLkAXet7lbga0wCOvsjfge7pPaFjdGVAE1r6i2CwZhvK1OSS48RTxLIMUK4oZKwQdNl8yroXsJtuAY3xkOk1S472EKbkFlFc5Mbvr5PlAGQZvEJFgT6Jx/5ZOxgYfalorshFMjHEAGtR88WrXOERh6y33EzIG/rnZ8P42yIvoFlIomKUdlwUUDw=
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c378c00b00410c95ea9b3sm5911118wmr.1.2024.02.13.00.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 00:13:36 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de, Ivan
 Khoronzhuk <ivan.khoronzhuk@gmail.com>, Jens Wiklander
 <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/7] common: avb_verify: don't call mmc_switch_part
 for SD
In-Reply-To: <CAByghJYSy86JjsC2cvGA0-5RupogR-vkADwQ6f9vSRnW4LtcFA@mail.gmail.com>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
 <20240209192045.3961832-2-igor.opaniuk@foundries.io>
 <b457cb25-ea09-4e27-85aa-0e97a5aa7fe0@moroto.mountain>
 <CAByghJYSy86JjsC2cvGA0-5RupogR-vkADwQ6f9vSRnW4LtcFA@mail.gmail.com>
Date: Tue, 13 Feb 2024 09:13:35 +0100
Message-ID: <87h6icg4sw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Igor,

On lun., f=C3=A9vr. 12, 2024 at 09:05, Igor Opaniuk <igor.opaniuk@gmail.com=
> wrote:

> Hi Dan,
>
> On Mon, Feb 12, 2024 at 8:05=E2=80=AFAM Dan Carpenter <dan.carpenter@lina=
ro.org> wrote:
>>
>> On Fri, Feb 09, 2024 at 08:20:39PM +0100, Igor Opaniuk wrote:
>> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
>> >
>> > mmc_switch_part() is used for switching between hw partitions
>> > on eMMC (boot0, boot1, user, rpmb).
>> > There is no need to do that for SD card.
>> >
>>
>> Is this a clean up or a bugfix?  What are the visible effects for the
>> user?
> avb cmd fails for SD cards, as mmc_switch_part() fails after trying to ac=
cess
> EXT_CSD register, which obviously is not available.

Does this means that we only need this patch to fix AVB commands when
booting from SD cards?

If yes, I propose adding the following note to the commit message:

"This fixes the avb command usage on on SD cards."

If you agree, I can do this while applying.

If not, we can keep the message as is.

>>
>> regards,
>> dan carpenter
>>
>
>
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> http://ua.linkedin.com/in/iopaniuk
