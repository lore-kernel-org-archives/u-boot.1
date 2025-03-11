Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8D6C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC3968083E;
	Tue, 11 Mar 2025 17:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="npSkbpnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A81807D7; Tue, 11 Mar 2025 17:47:54 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5500080F92
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22334203781so379365ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711671; x=1742316471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GlPTRmdNsxvFOabnkGmzgpu8f89JjhDtbco149TnMJA=;
 b=npSkbpnUDU+lSCIK2h08oA9rZesI1kiWEpuDsJ85q5ZhWbvCpf22CruoO6llu97ydh
 W1sGFVTrtBFRy1VzovEhrq2iQxWQvy1xAG/LroaKJwmTAAiYC7vau+/0ooqIi8eTyAD0
 OJZp/dPN6rU7YIwyjti0BzgcTF3PC8ehsPtgBcd93FLEhvR7Ngg2WlsHSnT1p/GxB5We
 sVOJgeW08HDafUpqjnlfdpBolsdj95Kq7LbryA7cIPEBW2cV63qWUJUkn+n3MT3IPwZX
 lFnBggh5Db2YjXAAKOepfMB1hSLSA4jUwJi5NFSehLOb3dGKyK71DtOfFlcLKR4D0AoL
 inQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711671; x=1742316471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GlPTRmdNsxvFOabnkGmzgpu8f89JjhDtbco149TnMJA=;
 b=b4Y7bJ5oo21oX552+xFMfWmDsVMXy5LMOodJXKT4e4i1fKgZiu6Nl6rnq6wODhFuYD
 OQHRUniEeCXf0d4jrUUao2SXYDJIK4zs2vTT0RvuBwnZytWTm/9KZrHWiRHt2e7EPC7S
 6nRfoZ0FN7gM5CsUHqqKTZQc8DHHQcVGegBihuIX1zx0RJ6xI70Mk/CctKRRX69u3x9x
 rHeSuR6POpadboGI8fNBEq7gQkaLWm2sm0uu5HOK+dfk9sfmflzje3aINhef8PnB7/yt
 4imyK7t7fAvbrMEGxTzQogyfDE7RTi05uYakWf1zdq8utW3iDzVKPBI4FSFdzOW2l9Fo
 Clkg==
X-Gm-Message-State: AOJu0Yzk8j+xShfHGIenD3L3BFjrEW574TUqCr3YdE0kURtuqbtJjBKx
 1uStjOsDWjOwiTewYRX6gWU/lL1dATWUNMp2BCWkHrVu6Fn6SZW1me+fs9xnr70=
X-Gm-Gg: ASbGnctM2huh+4S0KrxqEKUqkc4dttvBxAEkUC2FtS84upyh9khlahO9GwQdZ15qOXa
 G/0Rge0wbS5HTVLATMM/xMhm3PpKkIJEzN9RHYcRIkMEpHM6zaMzOWs7wMXjiTQ9TGfiHY/a4my
 XBOlrKtmUlgPqVJBFFOrd9LZQ5f+ItnjevGXBRNiJQyzTH1lG6cMeUuEKcyiSCkMk+zGydD76S7
 hjBGtUfUZyu4SdUqhcVs5hdcWpuYDS9cPcoE2KWVSC/BjRhIkSHqe8dTgIcb0da70Q3HTCfSDhU
 xaQIrB/wv4Th0+8RSAW0W4AsFYQWLM2U4g/a17VITZXA9M+/29MebxA=
X-Google-Smtp-Source: AGHT+IHhHB5A8jWgNLm8ZjLGWgWILo42E+PfGuH4um3t5t8OdPfVh8gfEvyAZnR7JS3zIBQ0LYXEHw==
X-Received: by 2002:a05:6a00:4fd1:b0:736:4e14:8ec5 with SMTP id
 d2e1a72fcca58-736ec67eb47mr5445901b3a.11.1741711670652; 
 Tue, 11 Mar 2025 09:47:50 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:47:50 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 00/16] EFI net driver - series 2/2: Support multiple EFI net
 objects
Date: Tue, 11 Mar 2025 13:47:42 -0300
Message-ID: <20250311164758.421900-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series finishes adding support for multiple network interfaces
in the EFI network stack. This series relies on "EFI net driver -
 series 1/2: Support multiple EFI net objects". In this series two drivers
are introduced: first, an EFI driver that manages handles that have the
efi simple network protocol installed, second, and an ethernet driver that
implements ethernet operations using a working efi simple network protocol as
a backend. The U-Boot code will call connect_controller for each U-Boot net
udevice after creating an efi_net_obj for it, and the first driver will pick
it up. If connect_controller gets called for a handle with an already existing
efi simple network protocol on it, the first driver will create a U-Boot net
udevice managed by the second driver, and an efi_net_obj will be created too.

Adriano Cordova (16):
  efi_driver: efi_net: Add EFI network device driver
  efi_loader: efi_net: check efi_search_protocol return value
  efi_loader: efi_net: Reuse efi_net_obj's
  efi_loader: efi_net: Let efi_net_obj store pointers to
    efi_simple_network, efi_simple_network_mode, and the efi handle
  efi_net: efi_loader: Add efi_netobj_alloc to allocate an efi_net_obj
  efi_loader: efi_net: Manage EFI net objects with
    efi_[dis]connect_controller
  eth_uclass: Add eth_create_device to create a net udevice
  efi_driver: efi_net: UCLASS_ETH driver for EFI net devices
  efi_driver: efi_uclass: Add unbind method to efi_driver_ops
  efi_driver: efi_net: Add efi_net_unbind_drv method to efi_net driver
  efi_loader: efi_net: Add http, ip4_config2, and pxe on demand
  efi_loader: efi_net: add snp_owner field to efi_net_obj struct
  efi_selftest: Add selftest for counting EFI netdevices
  py/tests: test_efi_selftest: Add test for counting EFI netdevices
  py/tests: test_efi_selftest: Add test for removing EFI netdevices
  efi_selftest: Add test for efi_netdev driver

 include/efi_driver.h                       |   4 +
 include/efi_loader.h                       |  30 +-
 include/net-common.h                       |   2 +
 lib/efi_driver/Makefile                    |   1 +
 lib/efi_driver/efi_net_device.c            | 290 +++++++++
 lib/efi_driver/efi_uclass.c                |   6 +-
 lib/efi_loader/efi_http.c                  |  30 +-
 lib/efi_loader/efi_ipconfig.c              |  36 +-
 lib/efi_loader/efi_net.c                   | 665 +++++++++++++++------
 lib/efi_loader/efi_setup.c                 |   4 +-
 lib/efi_selftest/Makefile                  |   2 +-
 lib/efi_selftest/efi_selftest_net_device.c |  65 ++
 lib/efi_selftest/efi_selftest_net_driver.c | 310 ++++++++++
 net/eth-uclass.c                           |  32 +
 test/py/tests/test_efi_selftest.py         |  45 ++
 15 files changed, 1330 insertions(+), 192 deletions(-)
 create mode 100644 lib/efi_driver/efi_net_device.c
 create mode 100644 lib/efi_selftest/efi_selftest_net_device.c
 create mode 100644 lib/efi_selftest/efi_selftest_net_driver.c

-- 
2.48.1

