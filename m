Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B9EC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 09:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29131885D7;
	Thu,  4 Jul 2024 11:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kHPV21eL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B896885EE; Thu,  4 Jul 2024 11:10:00 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F9C885D4
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 11:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ee8911b451so4241511fa.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720084197; x=1720688997;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=l3PMEVw1zSFk5fvtJHDlexI4eoNHJD3whZdZONMAjF4=;
 b=kHPV21eL5sI42r7OsqlrZP/OcLbkafB8UxiH1REBzpo9UR+2s+LR1wVHkBapxdyFQa
 9BizBRYexSPA9gl7ClDcL3x+G74bHBGMgcH6Dztf7le9yVK03HzEHevbiu4BHJAtYH5a
 VCUIJVlDhajXrSAHNy2NGUrOEXvEn0wjY4S7wQ+7SUoRzyIaZWcvTqduZepsmQvK6qwp
 MhfApH4hQlTdioVW2a1ou3nSokzD0cKWkxmozFY59e3LjjSPSncRDtu0Nb49u6gUJTyD
 kuNL/7i+wZ/T6mACYDzwS0XIw5ozp4UP7fDNeoXjEEsZIfd1D/1+uEBMbbp1rB0AF+2Y
 rWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720084197; x=1720688997;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l3PMEVw1zSFk5fvtJHDlexI4eoNHJD3whZdZONMAjF4=;
 b=f/n6diePfshv5EAkVJZFMVcZY5BnwJKwPx6va89DUOIZSb3qO9xsQmP8eE1557C5CM
 w3qLGjNHGQoNnZF89xplow2YR+/Nh2DZfc9PYEWEwvjasa4fnyzHvE5cRrtOmSnAiigJ
 pJUxeULCxOk4syRlwH4bnlkaUMPHJEtfHEWFX1R+2tW/Ko5ImIohHrx1N1csNY4FR+cv
 MGuIYmksjkvLSqTzXGe3tQxrjQ92wg2+MRD1/S0vJc/7xxYEJEoXXg0ODgxDm3ZwqA57
 IGrF+qrMsd7KfYRrptmGdpw8GTMMxNmqbQzVFxJf0KbbRDG6RgDkl18NQRaXpIGqQOCX
 hDYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5sqDa4PV9cT3tVGUJiBaUk4XcioBSPm3VO+yu6D7h064ID4GWJTZWo1V8AzJRD+kW9o+bvjNDb4GeE4za6+wphbHoEQ==
X-Gm-Message-State: AOJu0YzBbsWdvfx6YLXP/JBMTs+gwnuHJnBoNwPXgSYkZjRHKpAu4xrl
 AnIL4zdIM/H+DGaGQIYiCmcEPADFj+qvxB1/LAOOn1ggVVaqGvVXb6Wf2fnG8aI=
X-Google-Smtp-Source: AGHT+IFNEDAuqorQxm+lWYKlzZVaSBZNhYGQUqccOm+I8TJ+GrDByxCPQjgL22JepeCffMwLf2Wf4Q==
X-Received: by 2002:a05:651c:105c:b0:2ee:871c:bcb3 with SMTP id
 38308e7fff4ca-2ee8ed87a48mr5674981fa.13.1720084196293; 
 Thu, 04 Jul 2024 02:09:56 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d16b0sm15518485e9.7.2024.07.04.02.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:09:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Roman Stratiienko <r.stratiienko@gmail.com>, Igor
 Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/5] bootstd: Add Android support
In-Reply-To: <20240620142337.GA3542727@bill-the-cat>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <20240620142337.GA3542727@bill-the-cat>
Date: Thu, 04 Jul 2024 11:09:54 +0200
Message-ID: <87le2hmskd.fsf@baylibre.com>
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

Hi Tom,

On jeu., juin 20, 2024 at 08:23, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Jun 13, 2024 at 12:13:07PM +0200, Mattijs Korpershoek wrote:
>
>> Android boot flow is a bit different than a regular Linux distro.
>> Android relies on multiple partitions in order to boot.
>> 
>> A typical boot flow would be:
>> 1. Parse the Bootloader Control Block (BCB, misc partition)
>> 2. If BCB requested bootonce-bootloader, start fastboot and wait.
>> 3. If BCB requested recovery or normal android, run the following:
>>    a. Get slot (A/B) from BCB
>>    b. Run AVB (Android Verified Boot) on boot partitions
>>    c. Load boot and vendor_boot partitions
>>    d. Load device-tree, ramdisk and boot
>> 
>> The AOSP documentation has more details at [1], [2], [3]
>> 
>> This has been implemented via complex boot scripts such as [4].
>> However, these boot script are neither very maintainable nor generic.
>> Moreover, DISTRO_DEFAULTS is being deprecated [5].
>> 
>> Add a generic Android bootflow implementation for bootstd.
>> 
>> For this initial version, only boot image v4 is supported.
>> 
>> This has been tested on sandbox using:
>> $ ./test/py/test.py --bd sandbox --build -k test_ut
>> 
>> This has also been tested on the AM62X SK EVM using TI's Android SDK[6]
>> To test on TI board, the following (WIP) patch is needed as well:
>> https://gitlab.baylibre.com/baylibre/ti/ti-u-boot/-/commit/84cceb912bccd7cdd7f9dd69bca0e5d987a1fd04
>> 
>> [1] https://source.android.com/docs/core/architecture/bootloader
>> [2] https://source.android.com/docs/core/architecture/partitions
>> [3] https://source.android.com/docs/core/architecture/partitions/generic-boot
>> [4] https://source.denx.de/u-boot/u-boot/-/blob/master/include/configs/meson64_android.h
>> [5] https://lore.kernel.org/r/all/20230914165615.1058529-17-sjg@chromium.org/
>> [6] https://software-dl.ti.com/processor-sdk-android/esd/AM62X/09_02_00/docs/android/Overview.html
>
> This leads to failures in CI such as:
> =================================== FAILURES ===================================
> ___________________________ test_ut_dm_init_bootstd ____________________________
> test/py/tests/test_ut.py:555: in test_ut_dm_init_bootstd
>     setup_android_image(u_boot_console)
> test/py/tests/test_ut.py:488: in setup_android_image
>     with open(boot_img, 'rb') as inf:
> E   FileNotFoundError: [Errno 2] No such file or directory: '/tmp/malta64el/bootv4.img'
> ----------------------------- Captured stdout call -----------------------------

Thank you for reporting, and sorry about the CI failure.
I think I need to somehow declare a dependency on the bootv4.img file.

I will send a v3 to fix this.

>
> -- 
> Tom
