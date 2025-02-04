Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C9AC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 16:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11059800B3;
	Tue,  4 Feb 2025 17:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QjpYqxQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A33801DE; Tue,  4 Feb 2025 17:52:31 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2CF80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 17:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f768e9be1aso40909317b3.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 08:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738687947; x=1739292747; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaDgxV9C5FjDIwOjVcou/giYcFQMFlU3N00p+I1NJ50=;
 b=QjpYqxQeSAqRJgrcac9RAgVcar5JciiQLY1XNsjsmdqbbD/wchHz9aumtgVPYDzbGZ
 rFpCONXnOfWHqSVFgM2f9k1HONQYOnT9xfZs9KTPatjqU4XTZogasZMSbfoym9LZRP63
 48gtqZyNTmaX7w2wch1XXUgWb+Pg6/27KTXj/iyiGMqTcSCNhBDOkMTStN5avm+yii4o
 5rsebdV4Ao8qnrT3tbOkqy2jbtf/yHvYoSSTKfnyp6/IONSqp+18CIzmfxODGte1AzKY
 0Nrsw9VsFZZN90HE/VnPte/W1iI5Kc2WuTC7rzoEnPbvkSkRa+XAiYUSjVl0fjWtAnT0
 5XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738687947; x=1739292747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaDgxV9C5FjDIwOjVcou/giYcFQMFlU3N00p+I1NJ50=;
 b=uPGa0+dqB5fQnlGQ3K5WRbS0j5bSSWOZYW17erm9ETSQp3vUo+HZOxCLsFqVeYHTSK
 3X6LSQYNx4VGu6uOxSnkgMaHWbj6LLf336oCsi2G3QviziGkYkzgeHdt7rQI9i+12ucx
 M6iJZ4HGeUcE+f8lA5KQbw0aP9lkTwTZ4bSr0BJFIWSsSlvXmUSV9jq9yQLM+tTWqA8e
 Oso5LNh6UajRrO4kqDgFTTjakpTStI68x0mOoJye6zYzbvH8eaUeAC8bkHKEI2IyhF/s
 DjfjpjUBicJFVlNNVqknKCPrhj3y6cs53y8UUvMEkIxcLMjIxk7t5Zp7aiIvbPgZmK78
 NIEg==
X-Gm-Message-State: AOJu0Yxbnm4qe70mv6Rakoo/Ehf2ZL3dDkZvqO5Bit1f01j3d52Xv/m6
 PviXGDTVCMlfy2lAF5yIWJR25MidUaWy3yXPLnlxDfgQPmamCkT6vn4lm62Sl7x4F3/ilxQu0VF
 9pWEQw5YZhglzxWX2RQV+yf9/3Tl6oPnLE3Xdpi/JR/Vel3hl
X-Gm-Gg: ASbGncszQB6qQrX81Z1yUx8Ui5XN2wSzg+F4qSMboPOZCNUhmcKubGmAsQXcTprjOyB
 UEqf7NzRT3CWBK6OEr45Bmd6+CgTsOjR1fsgvVmdyKH4AlBwLu+ggrBcVHXw2sbYx4ZmhVd50
X-Google-Smtp-Source: AGHT+IE0ANXuwtoG7pbxiQ7cPxU+GwobM/v9ElY5JyaxWQnriZGMimVpprvLWCM+syb+rMCtLK5YAFUiLrCPHbXS0uE=
X-Received: by 2002:a05:6902:1793:b0:e48:a3d7:89db with SMTP id
 3f1490d57ef6-e5b135962f1mr3902751276.13.1738687946817; Tue, 04 Feb 2025
 08:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <CAC_iWjKFQ5PBzrqf13VSna3596Ry4MoxQr9+Zam9yrMm=8FVmA@mail.gmail.com>
 <CAMGU2hUunnJX5k2OJgnX9SLJKiO0JLHCCXGEMfjkP1W_RnB6_w@mail.gmail.com>
In-Reply-To: <CAMGU2hUunnJX5k2OJgnX9SLJKiO0JLHCCXGEMfjkP1W_RnB6_w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 18:51:51 +0200
X-Gm-Features: AWEUYZktkBzqW6lm2BDQlVkNBnX6DcfLmeJvLwz01cFVtOpcKGXQDJ3zaFO8NM8
Message-ID: <CAC_iWj+3ydXqinXxGa7q9tE84iMoMz63EjGsdswzDxWt5ZncOw@mail.gmail.com>
Subject: Re: [PATCH 00/21] EFI driver to support multiple network interfaces
To: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 4 Feb 2025 at 15:28, Adriano C=C3=B3rdova <adrianox@gmail.com> wrot=
e:
>
>
>
> El mar, 4 feb 2025 a las 6:37, Ilias Apalodimas (<ilias.apalodimas@linaro=
.org>) escribi=C3=B3:
>>
>> Hi Adriano,
>>
>>
>> On Wed, 22 Jan 2025 at 19:09, Adriano Cordova <adrianox@gmail.com> wrote=
:
>> >
>> > This series introduces an EFI driver to manage EFI net objects. The ma=
in
>> > functionalities implemented here are the following:
>> >         - Support multiple efi_net_obj
>> >         - Manage efi_net_obj with EFI driver
>> >         - Support calling [dis]connect_controller with a handle having
>> >           a snp protocol installed.
>> >
>> > The patches can be found at
>> > https://github.com/0n41rd4/u-boot/tree/efi-net-driver
>> > on top of upstream/next.
>> >
>> > Best regards,
>> > Adriano
>>
>> This is all useful and I'd like to move this forward. But the amount
>> of patches and lines in each patch is a bit too much to review
>> properly.
>> Can you try to split them a bit? I had a look in the first few patches
>> and sent some comments.
>> Perhaps you can send the PXE ones first even with the limitations of a
>> single device? And then send the multiple device support? Or the other
>> way around?
>>
>> Thanks
>> /Ilias
>> >
>> > Adriano Cordova (21):
>> >   legacy-net: wget: fix wget_info handling after new tcp legacy stack
>> >   efi_loader: expose symbols to be used by the EFI network stack
>> >   efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
>> >   efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
>> >   efi_loader: efi_device_path: Let network device paths receive the ne=
t
>> >     udevice as an argument
>> >   efi_loader: efi_net: Add support for multiple efi_net_obj
>> >   efi_driver: efi_net: Add EFI network device driver
>> >   efi_loader: efi_net: Reuse efi_net_obj's
>> >   efi_loader: efi_net: Let efi_net_obj store pointers to
>> >     efi_simple_network, efi_simple_network_mode, and the efi handle
>> >   efi_net: efi_loader: Add efi_netobj_alloc to allocate an efi_net_obj
>> >   efi_loader: efi_net: Manage EFI net objects with
>> >     efi_[dis]connect_controller
>> >   eth_uclass: Add eth_create_device to create a net udevice
>> >   efi_driver: efi_net: UCLASS_ETH "efi_netdev" U-Boot driver
>> >   efi_driver: efi_uclass: Add unbind method to efi_driver_ops
>> >   efi_driver: efi_net: Add efi_net_unbind_drv method to efi_net driver
>> >   efi_loader: efi_net: Add functions to [un]register http and
>> >     ip4_config2 protocols, and add pxe protocol on demand
>> >   efi_loader: efi_net: add snp_owner field to efi_net_obj struct
>> >   efi_selftest: Add selftest for counting EFI netdevices
>> >   py/tests: test_efi_selftest: Add test for counting EFI netdevices
>> >   py/tests: test_efi_selftest: Add test for removing EFI netdevices
>> >   efi_selftest: Add test for efi_netdev driver
>> >
>> >  include/efi_driver.h                       |    4 +
>> >  include/efi_loader.h                       |   80 +-
>> >  include/net-common.h                       |    3 +
>> >  lib/efi_driver/Makefile                    |    1 +
>> >  lib/efi_driver/efi_net_device.c            |  289 ++++++
>> >  lib/efi_driver/efi_uclass.c                |    6 +-
>> >  lib/efi_loader/efi_bootbin.c               |    3 +-
>> >  lib/efi_loader/efi_boottime.c              |   23 +-
>> >  lib/efi_loader/efi_device_path.c           |   23 +-
>> >  lib/efi_loader/efi_http.c                  |   36 +-
>> >  lib/efi_loader/efi_ipconfig.c              |   41 +-
>> >  lib/efi_loader/efi_net.c                   | 1063 ++++++++++++++++---=
-
>> >  lib/efi_loader/efi_setup.c                 |   27 +-
>> >  lib/efi_selftest/Makefile                  |    2 +-
>> >  lib/efi_selftest/efi_selftest_net_device.c |   65 ++
>> >  lib/efi_selftest/efi_selftest_net_driver.c |  310 ++++++
>> >  lib/efi_selftest/efi_selftest_snp.c        |    1 -
>> >  net/eth-uclass.c                           |   32 +
>> >  net/wget.c                                 |   18 +-
>> >  test/py/tests/test_efi_selftest.py         |   45 +
>> >  20 files changed, 1810 insertions(+), 262 deletions(-)
>> >  create mode 100644 lib/efi_driver/efi_net_device.c
>> >  create mode 100644 lib/efi_selftest/efi_selftest_net_device.c
>> >  create mode 100644 lib/efi_selftest/efi_selftest_net_driver.c
>> >
>> > --
>> > 2.43.0
>> >
>
>
> Hi Ilias,
>
> Yes, what about sending first the patches about multiple device support a=
nd then the patches about EFI and U-Boot drivers?
> Do you prefer two series, or one is fine?

I really don't mind as long as it gets down to sizes we can review in
less than a few weeks. Whatever is easier for you

Cheers
/Ilias
