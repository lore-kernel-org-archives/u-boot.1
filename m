Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DCAC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0EA7809D4;
	Wed, 22 Jan 2025 18:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ous+NVml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CF9809D2; Wed, 22 Jan 2025 18:09:15 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66EBF80977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so162528825ad.0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565751; x=1738170551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C9sdDSiMw2KFF+PJEo1L4NVkLzcpWthIRncdK5bcGcI=;
 b=Ous+NVmlrvMO3yclXbrDYWztCgTHihdrxAU07LzHXwnMr/6jPXfRT3N/CX2VRvA43S
 i37YykSqvpejZtSbDE3WjW7vUvfhBIMU9hMMpwIe34TLau6OV48LcNpXH0fOcBJxalfn
 lVIC1RNh2cj5h4/MqiDgziSkNYxI6cp4H98ISVS+9MA/R9VV+xqhLk4IaNOarb+HXS4Z
 3GtcdPu56k2ux0pP/Kl3oR3XR9jhtO0dVut2kEL8kfb7hMCzYDDuarS2RBWBCDIWJ1LZ
 ind65ulyhzuh2NROIp1ffIjoLTOlZWHez9vqOoJwb8D42bc94V8e5/C3G0bpkQ/QraeF
 st2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565751; x=1738170551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9sdDSiMw2KFF+PJEo1L4NVkLzcpWthIRncdK5bcGcI=;
 b=ISWarlJMTojRklfFcq1gl4P4eMP8dtYRklERKpD65zgnyXIiuztA8iung3wpqjbY8K
 c04OyynoDfNQQso3onlmbdIWYEnA56NHoytgLN56FTUjdwd0Ij+deM8FYwihI8UV5Nfs
 MKtLM76NrpgU//aESOv44Yy3NdqPh5iN4/d2Ux6nSDjJfeDeATdFupHWCndTDKzxQ1eY
 5D6BZ2EQiYMN6JjLrg/1c7tURH5CDrCWMP8DWi7gCkqjXBkq8S1/T6PXe63A3BQdwi0N
 S0Ct7P1Af2OzgAlxUu0XcNirH+a0+BYBEvOayaD8akfZv/KZO5GcEGFv9qDKfN0xqZ9B
 aBAA==
X-Gm-Message-State: AOJu0YwIjWZ8wqStMZKQf8qZUKp881NbJa7YYkGNUvmrDHpVCBFLnNl4
 3jtQbfCS3XkYYxOTEBqXN8rP3eFZzZ5gEitV7vNRAjZatoaUHSMWuETcZRll
X-Gm-Gg: ASbGncuPwv4B7FmhROCNuR6MmRGJR0FCT1Yusse7LGjOei/VVVgX/y8btE/PtNn5KNe
 fyz6fQsbOfZF++Fr+zSds126vC6/nu6zZVYzPvU58QSIKD+C7OWQOYaOpTqySBdOymlUSB4M3ZU
 yOK7v+p13IdPGnaH3w2gIPKacn7eedCMl3c3JZkVTv61eXvlve0eCBQsokmNogJ5ELzPRiB7AMl
 3z2rMm31TbnNnHQmG5ytcY08/cJQJcaI0IQbPWAh/jbztbjpU1NRD1kK0Dzm4jhBk3BI4MBpiZ2
 EQ==
X-Google-Smtp-Source: AGHT+IEG3+2wx3aque4nal38MpcrFub3rDXR3G52N8TLXniD52/EDG6HSFVxgnQ7jplAH4Svmb6LcQ==
X-Received: by 2002:a17:903:1cf:b0:216:4853:4c0b with SMTP id
 d9443c01a7336-21c355eeb65mr355731005ad.33.1737565750774; 
 Wed, 22 Jan 2025 09:09:10 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:10 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 00/21] EFI driver to support multiple network interfaces
Date: Wed, 22 Jan 2025 14:08:37 -0300
Message-ID: <20250122170858.961359-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
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

This series introduces an EFI driver to manage EFI net objects. The main
functionalities implemented here are the following:
	- Support multiple efi_net_obj
	- Manage efi_net_obj with EFI driver
	- Support calling [dis]connect_controller with a handle having
	  a snp protocol installed.
	  
The patches can be found at
https://github.com/0n41rd4/u-boot/tree/efi-net-driver
on top of upstream/next.

Best regards,
Adriano

Adriano Cordova (21):
  legacy-net: wget: fix wget_info handling after new tcp legacy stack
  efi_loader: expose symbols to be used by the EFI network stack
  efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
  efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
  efi_loader: efi_device_path: Let network device paths receive the net
    udevice as an argument
  efi_loader: efi_net: Add support for multiple efi_net_obj
  efi_driver: efi_net: Add EFI network device driver
  efi_loader: efi_net: Reuse efi_net_obj's
  efi_loader: efi_net: Let efi_net_obj store pointers to
    efi_simple_network, efi_simple_network_mode, and the efi handle
  efi_net: efi_loader: Add efi_netobj_alloc to allocate an efi_net_obj
  efi_loader: efi_net: Manage EFI net objects with
    efi_[dis]connect_controller
  eth_uclass: Add eth_create_device to create a net udevice
  efi_driver: efi_net: UCLASS_ETH "efi_netdev" U-Boot driver
  efi_driver: efi_uclass: Add unbind method to efi_driver_ops
  efi_driver: efi_net: Add efi_net_unbind_drv method to efi_net driver
  efi_loader: efi_net: Add functions to [un]register http and
    ip4_config2 protocols, and add pxe protocol on demand
  efi_loader: efi_net: add snp_owner field to efi_net_obj struct
  efi_selftest: Add selftest for counting EFI netdevices
  py/tests: test_efi_selftest: Add test for counting EFI netdevices
  py/tests: test_efi_selftest: Add test for removing EFI netdevices
  efi_selftest: Add test for efi_netdev driver

 include/efi_driver.h                       |    4 +
 include/efi_loader.h                       |   80 +-
 include/net-common.h                       |    3 +
 lib/efi_driver/Makefile                    |    1 +
 lib/efi_driver/efi_net_device.c            |  289 ++++++
 lib/efi_driver/efi_uclass.c                |    6 +-
 lib/efi_loader/efi_bootbin.c               |    3 +-
 lib/efi_loader/efi_boottime.c              |   23 +-
 lib/efi_loader/efi_device_path.c           |   23 +-
 lib/efi_loader/efi_http.c                  |   36 +-
 lib/efi_loader/efi_ipconfig.c              |   41 +-
 lib/efi_loader/efi_net.c                   | 1063 ++++++++++++++++----
 lib/efi_loader/efi_setup.c                 |   27 +-
 lib/efi_selftest/Makefile                  |    2 +-
 lib/efi_selftest/efi_selftest_net_device.c |   65 ++
 lib/efi_selftest/efi_selftest_net_driver.c |  310 ++++++
 lib/efi_selftest/efi_selftest_snp.c        |    1 -
 net/eth-uclass.c                           |   32 +
 net/wget.c                                 |   18 +-
 test/py/tests/test_efi_selftest.py         |   45 +
 20 files changed, 1810 insertions(+), 262 deletions(-)
 create mode 100644 lib/efi_driver/efi_net_device.c
 create mode 100644 lib/efi_selftest/efi_selftest_net_device.c
 create mode 100644 lib/efi_selftest/efi_selftest_net_driver.c

-- 
2.43.0

