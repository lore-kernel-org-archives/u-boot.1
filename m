Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1613C02197
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 09:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A66800CF;
	Tue,  4 Feb 2025 10:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AnNXAHdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0555801DE; Tue,  4 Feb 2025 10:37:05 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC18800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 10:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso5733313276.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738661821; x=1739266621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wA0HHGUrehZ0Nu8nUnbpf6ZNfQnToLvBIFhuX/nt+Fw=;
 b=AnNXAHdWyg+ViambszXDWFkp3VhITXD2ktricEa90rUPromm5zM2jDg4ZolDZcmP0B
 3tF+6XIHxnXmc8jXaGVUVPdljdkRzfw7RXV+tXPNJ3YAws+pvNMkMqXhpT0Ds7/8M2/8
 xAZ5Wu9g1wgwlCO++EkGr8FC7sfmwCTsp0ItZ5XNczk35sTR2BSHUGkFISlJ4tSXeWGX
 BwEUn9FIlmpVQ3L4oWdyzBtwsxPG3nVqwKuZ1kNZsU2JbnxmQJJvcJsfL2nVD67QWQ3I
 nonGt7U7zRRnR4snWbxXFeudfvtsXzlFSPrD9U57v+11VKex+y57cW1uX+XwJijx9Vzn
 zNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738661821; x=1739266621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wA0HHGUrehZ0Nu8nUnbpf6ZNfQnToLvBIFhuX/nt+Fw=;
 b=Sc6IT2333MDkXMwCScGa8+PZ3VgnXMoMIhJn75pSnwoJJQITDqDiA7IMADUD60MzKE
 vKDyKFU5ex8hnrL6ZgR2jQPOPu3Rs1NMTejWPchvGzb77NG42B9XQjbI5//RLcvDRDVV
 4oKWoI2czZzB2SUtm8qT33vRoRzS8BB/DBcUNyfZ2pf7AVmeg6IJ2aT7HMiBYYdR2glM
 QzP3mWivOwWXnBeBXhP/+WjFIC4tvUaVlid/wqKf6i0lXLFAcVpVPYAjZuSC+TWdjuI8
 28xf/GG3J6DmtyCXILTy18QQrnilKaI/Dz5hF3M/zMJ3CopyDDoL6yLC82hO3GYMSLnQ
 IMkw==
X-Gm-Message-State: AOJu0Yx0V1L3gOkvta29C/AQHk8/XvUMuejocWLaBxzWkrZRIrm2otjE
 nBKrK+lW2Khq0NgFHHef/3WgZvKaJ+E7s9V9FxC+qV8k5diHF/hZ8e0yMyk5qsn44RRLO1Ij6tX
 KrQW/1HHYao0G27k819L5Cudmj/uLS3Rv71NUTg==
X-Gm-Gg: ASbGncsUDgcH96LqbMr68SfsdiGL12p6RHAIvFt9ckBp+ukuSKCVGUH7RgBm008zJt8
 /FtnfwTNdKMrs7zm0IS7vjJoe1kXETrfo0LX/6i2r+4K9A7CZSckgM12WbB5rQ9DeeC52thwE
X-Google-Smtp-Source: AGHT+IGnBWZyQgLMF9sVfKGgyVOVEG2imIP+XDNMFC2RwK5bcA4Dgj65eC4uW8/kGji6/RfGio2EjFBSLdqysPL1Fn0=
X-Received: by 2002:a05:6902:124e:b0:e39:7269:372e with SMTP id
 3f1490d57ef6-e58a4b16e98mr17127517276.26.1738661820822; Tue, 04 Feb 2025
 01:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
In-Reply-To: <20250122170858.961359-1-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 11:36:25 +0200
X-Gm-Features: AWEUYZkCgocIHfmGEdIsH_x54kp5OBbM1CrEy-vuSUlJK97UmGrP8W5h0RMt51I
Message-ID: <CAC_iWjKFQ5PBzrqf13VSna3596Ry4MoxQr9+Zam9yrMm=8FVmA@mail.gmail.com>
Subject: Re: [PATCH 00/21] EFI driver to support multiple network interfaces
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
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

Hi Adriano,


On Wed, 22 Jan 2025 at 19:09, Adriano Cordova <adrianox@gmail.com> wrote:
>
> This series introduces an EFI driver to manage EFI net objects. The main
> functionalities implemented here are the following:
>         - Support multiple efi_net_obj
>         - Manage efi_net_obj with EFI driver
>         - Support calling [dis]connect_controller with a handle having
>           a snp protocol installed.
>
> The patches can be found at
> https://github.com/0n41rd4/u-boot/tree/efi-net-driver
> on top of upstream/next.
>
> Best regards,
> Adriano

This is all useful and I'd like to move this forward. But the amount
of patches and lines in each patch is a bit too much to review
properly.
Can you try to split them a bit? I had a look in the first few patches
and sent some comments.
Perhaps you can send the PXE ones first even with the limitations of a
single device? And then send the multiple device support? Or the other
way around?

Thanks
/Ilias
>
> Adriano Cordova (21):
>   legacy-net: wget: fix wget_info handling after new tcp legacy stack
>   efi_loader: expose symbols to be used by the EFI network stack
>   efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
>   efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
>   efi_loader: efi_device_path: Let network device paths receive the net
>     udevice as an argument
>   efi_loader: efi_net: Add support for multiple efi_net_obj
>   efi_driver: efi_net: Add EFI network device driver
>   efi_loader: efi_net: Reuse efi_net_obj's
>   efi_loader: efi_net: Let efi_net_obj store pointers to
>     efi_simple_network, efi_simple_network_mode, and the efi handle
>   efi_net: efi_loader: Add efi_netobj_alloc to allocate an efi_net_obj
>   efi_loader: efi_net: Manage EFI net objects with
>     efi_[dis]connect_controller
>   eth_uclass: Add eth_create_device to create a net udevice
>   efi_driver: efi_net: UCLASS_ETH "efi_netdev" U-Boot driver
>   efi_driver: efi_uclass: Add unbind method to efi_driver_ops
>   efi_driver: efi_net: Add efi_net_unbind_drv method to efi_net driver
>   efi_loader: efi_net: Add functions to [un]register http and
>     ip4_config2 protocols, and add pxe protocol on demand
>   efi_loader: efi_net: add snp_owner field to efi_net_obj struct
>   efi_selftest: Add selftest for counting EFI netdevices
>   py/tests: test_efi_selftest: Add test for counting EFI netdevices
>   py/tests: test_efi_selftest: Add test for removing EFI netdevices
>   efi_selftest: Add test for efi_netdev driver
>
>  include/efi_driver.h                       |    4 +
>  include/efi_loader.h                       |   80 +-
>  include/net-common.h                       |    3 +
>  lib/efi_driver/Makefile                    |    1 +
>  lib/efi_driver/efi_net_device.c            |  289 ++++++
>  lib/efi_driver/efi_uclass.c                |    6 +-
>  lib/efi_loader/efi_bootbin.c               |    3 +-
>  lib/efi_loader/efi_boottime.c              |   23 +-
>  lib/efi_loader/efi_device_path.c           |   23 +-
>  lib/efi_loader/efi_http.c                  |   36 +-
>  lib/efi_loader/efi_ipconfig.c              |   41 +-
>  lib/efi_loader/efi_net.c                   | 1063 ++++++++++++++++----
>  lib/efi_loader/efi_setup.c                 |   27 +-
>  lib/efi_selftest/Makefile                  |    2 +-
>  lib/efi_selftest/efi_selftest_net_device.c |   65 ++
>  lib/efi_selftest/efi_selftest_net_driver.c |  310 ++++++
>  lib/efi_selftest/efi_selftest_snp.c        |    1 -
>  net/eth-uclass.c                           |   32 +
>  net/wget.c                                 |   18 +-
>  test/py/tests/test_efi_selftest.py         |   45 +
>  20 files changed, 1810 insertions(+), 262 deletions(-)
>  create mode 100644 lib/efi_driver/efi_net_device.c
>  create mode 100644 lib/efi_selftest/efi_selftest_net_device.c
>  create mode 100644 lib/efi_selftest/efi_selftest_net_driver.c
>
> --
> 2.43.0
>
