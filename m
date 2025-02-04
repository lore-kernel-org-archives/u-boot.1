Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C39C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 13:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC15800B3;
	Tue,  4 Feb 2025 14:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JSFcs5yR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE2D800CF; Tue,  4 Feb 2025 14:28:25 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0414C80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 14:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso216430a91.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738675701; x=1739280501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+47MuiqNczrLrraRstIxvW9GLtiPyopPO08KnsWJi5c=;
 b=JSFcs5yRYe7cWAfi4/HB8dqtJyG7czU/OHi/eKRv01Ne8UgnZ9neGyG5b89wQhItYw
 zV1y1ucyoDousm4jRq+DRq5iBZSRqc3aXJY9idaB5P08lGqnvYHPPMAyBmdbOYxcuHWH
 xGFZnUgWsl1iPTpa5+DE4piI7cvebGG3gM1+XFr4UsQrrxKr8axLVJJSnXHvNMXClNwb
 435nOVcwBCe+y7Jos65BnOEuU+5Mfx87frUmNKtL5fWEglI8FHtT/psjLOVpkPR72uet
 9wz4VqPfdeD7bbROz0DRerNB13nVIH4Bq7t9u9Boz4yhr6wP/0HOAsdFESDNIaXHJ5R1
 Yrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738675701; x=1739280501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+47MuiqNczrLrraRstIxvW9GLtiPyopPO08KnsWJi5c=;
 b=Gyy1gwSg2QNfk8xuZixR1obLcXf1NXwFOLxoedD4YD5/GQQuvZeafFo1QzkVUa8mh0
 bqrGKr23yPa1TFo6vSRuLNCUCI3SOg+tgLDtJPhCBY6z7b2ecmkpHWdKHjOkTEn0r7XU
 faxDng8LDyQBQhxt72nCX64KpX5Mgny2oU6AUkiF6YcF+63dsuOeOwPLfcxkW/cK6a87
 7UfoTL86t2aXoD7TPB1lFSSpDhvaIdhYLoRKn1QuX34eyiGQAiPLnczEjvWjPAPThe7D
 f3YQlvDDERiyfmwtjWdVpwGzjqWYYDQJR3yANCzTuMwJCBHJnNxPSr4OIun36f2xm4+U
 5yVA==
X-Gm-Message-State: AOJu0YwkvluO6WOQmqjtMjYLYPi4L0hkXtPk3nJUPhv9hX0qMQRmZb8O
 iToTXFBHTZmqOJH50emwKrAHRrXdqPi9TzO3MRBuK+9tSoBH9ufCkathtGMX9+UcUNkpbxyzamG
 SG3P2H5oKYFS0SyNfoSoOW+JIG+fhMTRR
X-Gm-Gg: ASbGnctW+1L/0l+fobEcmxPn2sXSOtMqpQxV4SAqFnhwTbpHD1zpqMrTwXm5zHqvYVl
 x1RaPQrHiY9ZvBU4Lmoy7ekP+cQzKM9oBRug4NWvi490LalDtzdcHeKdci1EhJerpwNktgGc=
X-Google-Smtp-Source: AGHT+IHH903TxO6JYHhtCCYYMxj0BMcWO2VDEUNQ/nliKv2O9HRicBPLQvoTbBfRz51KraP8bYyIA5r9jLxso2E0/6g=
X-Received: by 2002:a17:90b:520d:b0:2f6:f107:fae4 with SMTP id
 98e67ed59e1d1-2f83abd7cdamr37429483a91.8.1738675701159; Tue, 04 Feb 2025
 05:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <CAC_iWjKFQ5PBzrqf13VSna3596Ry4MoxQr9+Zam9yrMm=8FVmA@mail.gmail.com>
In-Reply-To: <CAC_iWjKFQ5PBzrqf13VSna3596Ry4MoxQr9+Zam9yrMm=8FVmA@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 4 Feb 2025 10:28:10 -0300
X-Gm-Features: AWEUYZkqDtg66dPlP2hq5Pnj4KAfMctJbrDoNBA5Zkp6SGB4KOJZh5xMQN4m8h0
Message-ID: <CAMGU2hUunnJX5k2OJgnX9SLJKiO0JLHCCXGEMfjkP1W_RnB6_w@mail.gmail.com>
Subject: Re: [PATCH 00/21] EFI driver to support multiple network interfaces
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

El mar, 4 feb 2025 a las 6:37, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> Hi Adriano,
>
>
> On Wed, 22 Jan 2025 at 19:09, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > This series introduces an EFI driver to manage EFI net objects. The mai=
n
> > functionalities implemented here are the following:
> >         - Support multiple efi_net_obj
> >         - Manage efi_net_obj with EFI driver
> >         - Support calling [dis]connect_controller with a handle having
> >           a snp protocol installed.
> >
> > The patches can be found at
> > https://github.com/0n41rd4/u-boot/tree/efi-net-driver
> > on top of upstream/next.
> >
> > Best regards,
> > Adriano
>
> This is all useful and I'd like to move this forward. But the amount
> of patches and lines in each patch is a bit too much to review
> properly.
> Can you try to split them a bit? I had a look in the first few patches
> and sent some comments.
> Perhaps you can send the PXE ones first even with the limitations of a
> single device? And then send the multiple device support? Or the other
> way around?
>
> Thanks
> /Ilias
> >
> > Adriano Cordova (21):
> >   legacy-net: wget: fix wget_info handling after new tcp legacy stack
> >   efi_loader: expose symbols to be used by the EFI network stack
> >   efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
> >   efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
> >   efi_loader: efi_device_path: Let network device paths receive the net
> >     udevice as an argument
> >   efi_loader: efi_net: Add support for multiple efi_net_obj
> >   efi_driver: efi_net: Add EFI network device driver
> >   efi_loader: efi_net: Reuse efi_net_obj's
> >   efi_loader: efi_net: Let efi_net_obj store pointers to
> >     efi_simple_network, efi_simple_network_mode, and the efi handle
> >   efi_net: efi_loader: Add efi_netobj_alloc to allocate an efi_net_obj
> >   efi_loader: efi_net: Manage EFI net objects with
> >     efi_[dis]connect_controller
> >   eth_uclass: Add eth_create_device to create a net udevice
> >   efi_driver: efi_net: UCLASS_ETH "efi_netdev" U-Boot driver
> >   efi_driver: efi_uclass: Add unbind method to efi_driver_ops
> >   efi_driver: efi_net: Add efi_net_unbind_drv method to efi_net driver
> >   efi_loader: efi_net: Add functions to [un]register http and
> >     ip4_config2 protocols, and add pxe protocol on demand
> >   efi_loader: efi_net: add snp_owner field to efi_net_obj struct
> >   efi_selftest: Add selftest for counting EFI netdevices
> >   py/tests: test_efi_selftest: Add test for counting EFI netdevices
> >   py/tests: test_efi_selftest: Add test for removing EFI netdevices
> >   efi_selftest: Add test for efi_netdev driver
> >
> >  include/efi_driver.h                       |    4 +
> >  include/efi_loader.h                       |   80 +-
> >  include/net-common.h                       |    3 +
> >  lib/efi_driver/Makefile                    |    1 +
> >  lib/efi_driver/efi_net_device.c            |  289 ++++++
> >  lib/efi_driver/efi_uclass.c                |    6 +-
> >  lib/efi_loader/efi_bootbin.c               |    3 +-
> >  lib/efi_loader/efi_boottime.c              |   23 +-
> >  lib/efi_loader/efi_device_path.c           |   23 +-
> >  lib/efi_loader/efi_http.c                  |   36 +-
> >  lib/efi_loader/efi_ipconfig.c              |   41 +-
> >  lib/efi_loader/efi_net.c                   | 1063 ++++++++++++++++----
> >  lib/efi_loader/efi_setup.c                 |   27 +-
> >  lib/efi_selftest/Makefile                  |    2 +-
> >  lib/efi_selftest/efi_selftest_net_device.c |   65 ++
> >  lib/efi_selftest/efi_selftest_net_driver.c |  310 ++++++
> >  lib/efi_selftest/efi_selftest_snp.c        |    1 -
> >  net/eth-uclass.c                           |   32 +
> >  net/wget.c                                 |   18 +-
> >  test/py/tests/test_efi_selftest.py         |   45 +
> >  20 files changed, 1810 insertions(+), 262 deletions(-)
> >  create mode 100644 lib/efi_driver/efi_net_device.c
> >  create mode 100644 lib/efi_selftest/efi_selftest_net_device.c
> >  create mode 100644 lib/efi_selftest/efi_selftest_net_driver.c
> >
> > --
> > 2.43.0
> >
>

Hi Ilias,

Yes, what about sending first the patches about multiple device support and
then the patches about EFI and U-Boot drivers?
Do you prefer two series, or one is fine?
