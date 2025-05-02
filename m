Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A244FC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4393782CB9;
	Fri,  2 May 2025 16:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IL1RuZIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E4782CB9; Fri,  2 May 2025 16:50:26 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8073782CCF
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5f6222c6c4cso3160137a12.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197424; x=1746802224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wqtFzRiKIDIHoMr0nUjgKUWsCWqxOqGYVE3khY1I0V8=;
 b=IL1RuZILpJS6v5oLPVuup8heV2y7qyofGN/7DAFSYo91qGaReDIzgG3flfP0JDiOGG
 GLOHdJPdP3jy+nhbmlmrdnc4J56ovMqYYWjsMvOF+2Dgell4nTtvaZ1F3X7M3tkIflem
 9dy6lfBt/lYhrnztO+sdrXxeiumidsrNjpzEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197424; x=1746802224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wqtFzRiKIDIHoMr0nUjgKUWsCWqxOqGYVE3khY1I0V8=;
 b=ViAZpApegvu8j8b3d8fljY9roqtB4XB0loFcoVnmQDTe2RzSM2zJtqRAP1EYC2x3f1
 KFtSe6f3Qq0/Gur1yclYi+agmCrOQEJ9inxP+sxUC6ED3frdDSN6sfHuJlMCVPBsYhxH
 N+JwDa/xSwkLTKVqC47lrHZYYQnLUZjVxCDQ6MaTHl9miCkS8MxZGMdkVE02jDJHcMAW
 e7XWiaIECBsxHoSOeVnDQc6NPQedGla7xwh/LxkUzDC2JP0SrJWZTdBbP7nIB3Tnphf6
 FGVfBj8o4hRbpLBUllU5/FbzQxu6PYbgTndU5gzai55Zb2vnENCwLKZqU7aKVAwRwlyz
 Zp+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVypNnL3qbJkm5QafTxISzOw31UCt396MYPqYA7XJjfZH8Gd6NvVtH4elw8DXeZwtv6C7CSDzY=@lists.denx.de
X-Gm-Message-State: AOJu0YyBOmxLGEvTB+zptS0Q6+1oKr70WS1923hlXwMDoUnQSphv0CB6
 z9VyQn4yCyBTRp8mAdZvjeO19wxxRZCQeX7ORrPE+V+WP1ppQQ8PS8YUofOA0var+NjwAycNsbm
 qlNpPgo3JKeSlbiOuJNCnV5wZyB6t2iFZynuj
X-Gm-Gg: ASbGncsAKzjnl/j+N89KGKwz3xqoa8enEYjUR8eQsWlAQPywx3RHgpsdkXvlIzC9kPp
 EfDJ6pVq7MlI3fo/p3vryoy7Aq1yBBY4rFTQYqgIdpx3AEPMyeYANXyCk3hxSJ7LvIHe6zbe9Gg
 Um8ukAnnzfzb4zhK4iTZFTNN8=
X-Google-Smtp-Source: AGHT+IHq0D7vdzKg7EuIftYDIh/E/dWwsdX8NC3UDFzOE36wra8hBX9f07wqclRF+Pt9lIGA0SGI2ZaMTqhBkp3Uc7Y=
X-Received: by 2002:a17:907:a605:b0:acf:166:e1a3 with SMTP id
 a640c23a62f3a-ad17af2378bmr295526466b.39.1746197423945; Fri, 02 May 2025
 07:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
 <ZQ2PR01MB13077BEB7F27422FA9AF07A6E619A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CAFLszTg6sdcvB-qfbBJ23JORsxvjTgL9ozvcu_oKFkJrfL=9hQ@mail.gmail.com>
 <283D503E-D02E-4D66-8218-6857911B5B78@gmx.de>
In-Reply-To: <283D503E-D02E-4D66-8218-6857911B5B78@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 08:50:12 -0600
X-Gm-Features: ATxdqUGhjz0-iRIj0T9fcwieEOmb3lifpn3kgZaXEdgdPRq82BQK2Nb1--tqD-c
Message-ID: <CAFLszTjG3d2MeW9DiharpGwSTFucFRO56JWJiEcy7dofeG_e4g@mail.gmail.com>
Subject: Re: Lab failure on JH7110 (StarFive VisionFive 2)
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Minda Chen <minda.chen@starfivetech.com>
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

Hi Heinrich,

On Thu, 1 May 2025 at 22:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 2. Mai 2025 03:38:36 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi,
> >
> >On Tue, 14 Jan 2025 at 23:56, Hal Feng <hal.feng@starfivetech.com> wrote:
> >>
> >> > On 09.01.25 20:37, Simon Glass wrote:
> >> > Hi,
> >> >
> >> > I am seeing a lab failure on this board with the test_dm_compat test[1]:
> >> >
> >> > =================================== FAILURES
> >> > ===================================
> >> > 559________________________________ test_dm_compat
> >> > ________________________________
> >> > 560test/py/tests/test_dm.py:20: in test_dm_compat
> >> > 561 assert not bad_drivers
> >> > 562E AssertionError: assert not {'starfive_gpio'}
> >> >
> >> > Would you have time to take a look, please? A patch to fix a similar problem
> >> > on another board is [2].
> >> >
> >> > Regards,
> >> > Simon
> >> >
> >> > [1] https://ci.u-boot.org/u-boot/u-boot/-/jobs/14394
> >> > [2]
> >> > https://patchwork.ozlabs.org/project/uboot/patch/20240611200156.224552
> >> > 5-19-sjg@chromium.org/
> >>
> >> I will take a look. Thanks.
> >
> >I just wanted to check if you sent a patch and if so, if you have a
> >link to it please?
> >
> >Regards,
> >SImon
>
> Hello Simon,
>
> The error in the log [1] is
>
> "Writing U-Boot using method riscv
> cat: /sys/class/block/sdaa13/size: No such file or directory"
>
> I would expect a partition on a block device to be called sda13 not sdaa13.
>
> Could this be a bug in your lab test script?
>
> (Ubuntu uses partition 13 on the SD-card for U-Boot SPL.)

No, that's just something it prints when waiting for the device to
appear. Perhaps I should suppress it.

The real error is below:

________________________________ test_dm_compat ________________________________
560test/py/tests/test_dm.py:20: in test_dm_compat
561 assert not bad_drivers
562E AssertionError: assert not {'starfive_gpio'}

It would be *great* if someone could fix it, as it always fails in my
lab and I have to manually check it.

Regards,
Simon
