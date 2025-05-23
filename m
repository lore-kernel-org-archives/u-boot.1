Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16362C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1BA83285;
	Fri, 23 May 2025 15:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QakQi6MB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12CC831FE; Fri, 23 May 2025 15:07:04 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84F283108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so4921284f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005622; x=1748610422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eXkKnd2AtBuRk3k/wNR9SBh0vkP9tAPvNFHXY6XvK2Q=;
 b=QakQi6MByVnfPFF/yBUD1nSmbR6ibx5yOWpmsGjGTEMAifqKfj72RgRdCIr9B+d3RY
 ikTQ6Kr+v1emAapiLWqslYFb+lV2IaI2JnfioAyTEPlQVK96VLj37xqaO1qPKuWa4x0D
 F6k7C6kh+xYmvBktBslDsV9I60ZvkHLBg8FXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005622; x=1748610422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eXkKnd2AtBuRk3k/wNR9SBh0vkP9tAPvNFHXY6XvK2Q=;
 b=V4PFlGjOE14hCo/QMn8Jyim8/poO+aT4y9hSoai6GX5XZTqdjW0W4LTWxrQQ3Qkv6a
 cS1qytNDyu9ksS9pBk83vJuVeeMRTZXXKOIoNnP/s2GjwaS+p51HDugp1PAaYbd9dqeb
 gRIyEwot9CJjOmlT9A5hkxAAvCrf4euQtshF5e+kRCCD9Chx2qWBZ/T33fjyiQeYX/rW
 CYq4WydrNi236vPkMsiUF6TOj0+ZZm+RisE+kuqav9VRzzTDSQ23bOhFMBCVlUz/uJ9M
 JLxyxGaCf9n8Km/q+aD2VheVc8ZhHAUyuSAAI+bi/9yZoSQIOIw+tKqnvZglAoleZqcD
 K0MA==
X-Gm-Message-State: AOJu0YwPUBg+ANOLtYq/PkiNipO82xfNker+k5oOzrUboNXlXcqVxpdF
 ouolmOWHySkIwdy4dZov43NYlqN1TPomItD4t6MUdWNzrWyI2Bez2v9GGXjFxQbgF9aiNRZYItq
 ThoovdYqx
X-Gm-Gg: ASbGnctDoHXcGnKVflhLgXjMK0jSuVZs39UBsx6oIBz3WzegOvyBwboL5aDsywtVQiw
 wElU2JDkgz6gCCuSPHEr3VjxiHZr6/ovxQYPHggNhbVJ6yh6mloC6YWYJWUCj43l7n/66lOeUPX
 h0spEB4Yic/Zw781M2V0+7c5dMPBvl3yQnYMsAy4h8tYUA7J8uqj1Qv6gM6rkAQka/hmTVHNHuo
 qOyPxbBue2OcVTmDjWUeztFKb4d0LiqK6TxGm+g9LRm+PFQEge3vo/scaRQKt9B7xNQxqImPB1I
 AcAjkSvT5mZAUkNs+ogUcgrTxPOpSVXaO211/68vr9WPDzJ738wm5XNWgq6yi+MsfrtN+DI=
X-Google-Smtp-Source: AGHT+IFMdJ8bJabuywRmeeOozPsRDVGEbu7DP3XrN2bhIlVWuoiVEgMJxIER0JjkSZvhcnQE/rPYOw==
X-Received: by 2002:a05:6000:4308:b0:3a3:7435:9a32 with SMTP id
 ffacd0b85a97d-3a374359cc1mr16759879f8f.40.1748005621618; 
 Fri, 23 May 2025 06:07:01 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
Date: Fri, 23 May 2025 14:06:35 +0100
Message-ID: <20250523130651.1329593-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 May 2025 15:43:51 +0200
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

Some functions provided in lib/efi_loader are actually useful for the
app as well. This series refactors the Kconfig and directories a little
so that code is easier to share.

As a starting point, it moves some filename and device-path functions to
the new directory.

The next step would be to move device-path code over, but this will need
some discussion.


Simon Glass (10):
  efi_loader: Separate device path into its own header
  efi: Include device-path functions in the EFI API docs
  efi: Rename END to EFI_DP_END
  efi: Rename the lib/efi directory
  efi: Rename CONFIG_EFI to CONFIG_EFI_CLIENT
  efi: Create a new CONFIG_EFI
  efi: Update maintainers for EFI_CLIENT
  efi: Move the base name and PXE info into lib/efi
  efi: Adjust copyright and mention constant source
  efi: Move FDT-filename discovery into lib/efi

 MAINTAINERS                                |   5 +-
 Makefile                                   |   4 +-
 arch/arm/include/asm/global_data.h         |   2 +-
 arch/x86/Kconfig                           |   6 +-
 arch/x86/cpu/Makefile                      |   2 +-
 arch/x86/cpu/efi/Kconfig                   |   2 +-
 arch/x86/cpu/x86_64/Makefile               |   2 +-
 cmd/Makefile                               |   2 +-
 cmd/bootefi.c                              |   1 +
 cmd/eficonfig.c                            |   5 +-
 cmd/efidebug.c                             |   7 +-
 cmd/part_find.c                            |  10 +-
 configs/efi-arm_app64_defconfig            |   2 +-
 configs/efi-x86_app32_defconfig            |   2 +-
 configs/efi-x86_app64_defconfig            |   2 +-
 configs/efi-x86_payload32_defconfig        |   2 +-
 configs/efi-x86_payload64_defconfig        |   2 +-
 doc/api/efi.rst                            |   6 +
 doc/develop/uefi/u-boot_on_efi.rst         |  18 +-
 drivers/block/Kconfig                      |   2 +-
 include/efi_device_path.h                  | 420 +++++++++++++++++++++
 include/efi_loader.h                       |  57 +--
 include/init.h                             |   2 +-
 lib/Kconfig                                |   2 +-
 lib/Makefile                               |   1 +
 lib/efi/Kconfig                            |  86 +----
 lib/efi/Makefile                           |  28 +-
 lib/efi/basename.c                         | 153 ++++++++
 lib/efi_client/Kconfig                     |  83 ++++
 lib/efi_client/Makefile                    |  28 ++
 lib/{efi => efi_client}/efi.c              |   0
 lib/{efi => efi_client}/efi_app.c          |   0
 lib/{efi => efi_client}/efi_app_init.c     |   0
 lib/{efi => efi_client}/efi_dtb.S          |   0
 lib/{efi => efi_client}/efi_info.c         |   0
 lib/{efi => efi_client}/efi_stub_arm64.c   |   0
 lib/{efi => efi_client}/efi_stub_x86.c     |   0
 lib/{efi => efi_client}/efi_vars.c         |   0
 lib/{efi => efi_client}/sdram.c            |   0
 lib/efi_driver/efi_uclass.c                |   1 +
 lib/efi_loader/Kconfig                     |   3 +
 lib/efi_loader/efi_bootbin.c               |   1 +
 lib/efi_loader/efi_bootmgr.c               |   4 +-
 lib/efi_loader/efi_boottime.c              |   1 +
 lib/efi_loader/efi_capsule.c               |   1 +
 lib/efi_loader/efi_console.c               |   1 +
 lib/efi_loader/efi_device_path.c           | 175 +++------
 lib/efi_loader/efi_device_path_utilities.c |   3 +-
 lib/efi_loader/efi_disk.c                  |   1 +
 lib/efi_loader/efi_fdt.c                   |  64 +---
 lib/efi_loader/efi_helper.c                |  81 +---
 lib/efi_loader/efi_net.c                   |   1 +
 lib/efi_loader/efi_tcg2.c                  |   1 +
 lib/uuid.c                                 |   4 +-
 test/lib/efi_device_path.c                 |   1 +
 55 files changed, 814 insertions(+), 473 deletions(-)
 create mode 100644 include/efi_device_path.h
 create mode 100644 lib/efi/basename.c
 create mode 100644 lib/efi_client/Kconfig
 create mode 100644 lib/efi_client/Makefile
 rename lib/{efi => efi_client}/efi.c (100%)
 rename lib/{efi => efi_client}/efi_app.c (100%)
 rename lib/{efi => efi_client}/efi_app_init.c (100%)
 rename lib/{efi => efi_client}/efi_dtb.S (100%)
 rename lib/{efi => efi_client}/efi_info.c (100%)
 rename lib/{efi => efi_client}/efi_stub_arm64.c (100%)
 rename lib/{efi => efi_client}/efi_stub_x86.c (100%)
 rename lib/{efi => efi_client}/efi_vars.c (100%)
 rename lib/{efi => efi_client}/sdram.c (100%)

-- 
2.43.0

base-commit: 3599a58a5114224a01557d18371036a5823233cc
branch: app
