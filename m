Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D43C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC142807E1;
	Tue, 11 Feb 2025 15:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rIbWQTzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB5B80824; Tue, 11 Feb 2025 15:49:30 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C55803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dd0dc21b2so2218027f8f.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739285367; x=1739890167;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o40w2PTKsqmCoq9ZJyjmYvOCuLM7QQVTrvPeY03zAGA=;
 b=rIbWQTzds9/fhEb6yurmxPLotRcUoLB84d5H6Mxv/zkCQRIw4x3kpQ20LqwAuIzexD
 FRNzkvtOMmZyGRuXkbnOvpsc1PF4UjiHEqx1SRqh/AaayMSO/j4AolJd+k6eXVUWCUOi
 fDkClYTlB1UnbqRnNB/cn3bgs0ivUy0ODEEMaovyOvnOjAHgj3eUnABj/9ckko30LEil
 ffWwC07gUzxc0XBuG7qz8lZjGxMi97LPI4Z+zxsnCBfl868v9cOhfukrK2/z6LHbkFJJ
 tR/MGXcxrXZl0ZsEH1fQ4/oAB4I88RTq4IGOq4MTKPn0gTo7R+DwIzq0fHklslBGorC2
 +D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739285367; x=1739890167;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o40w2PTKsqmCoq9ZJyjmYvOCuLM7QQVTrvPeY03zAGA=;
 b=bncVqf4rH/IM87yx3rglgJI6si/DBqXoSHC9+sfoYNfdP5CuG2CUQ7LbAVaovPq4EX
 rWEqYWJQampzCckXmJbWsjkCBWmm2x0yOl515bF3nVilbvAjpPpFkXwDhGE6dT3EhSJk
 z9PRsx9C3/UiiJ79PMCnq5RlzLLkwUiDd6l0dtQP5loBuM6+/oO6figb+gUQrjemtHyp
 LYfEhV68e2bi0Ua+rGMVtM7tO3YFkdZFUQIRNvvbXXKEk0PKt8AxDRGQ1nKwXH4hhbFV
 +qsBvhpZ/3Ozxb38BNiFXPpesbAr2rEpA3pdAtU2XvSwVNBFi2n/apXKXfTelI8W9lAX
 9wcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZdmkzJm7pXGXgeFgt0JGX4lvB24hWqndsQha61E04+apem2SIr6FDv8kur4S5+Zglb693k8Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwKeQ9RogHJIRuezfCGUYjDys4tlCXQ23apkApFPI9i0P4IL97f
 HMiQGbS06cU+LgFUoD8CJ/eO2tWjmtK5ObdjoVU03GQUOUlwy5Mj8/6XlqP1Io4=
X-Gm-Gg: ASbGnctGQSfkDUQb5q0fr5Ycok50+xNWJ2wDBhdTUU6V50v+srojMsgj3tOqPz/gvw4
 eIn5Ad2XBVOn5yegkOeORJX3zxJUN6N8QnqPVlAyH8BmFBhfTbUuH8GKfLiE/T3gPCj0nnPV+d7
 UjUM9UZZvfLvVHymo7wFlx0bKfmGMkmjOjC1KHxdMiBmuUlSThZN28GnqoDUO7kKBzTe1q80Q2a
 4oISQIS2Y4SfCkjNoNoW0kd7b4Ly8pXWO4vMCU/QVdOkUaHaOzZbfgsHr1/gkFKzIRiiCLVveQR
 DtMYFhQrx38DPSYQ98FYDRWy
X-Google-Smtp-Source: AGHT+IHa7dYFHwgYeiB6APwym9mrB8+Pij18tP4XzHBNb8k6HxExbt9fa4s/PJSYilzsqQDWHHx1ig==
X-Received: by 2002:a5d:5f86:0:b0:38d:d43c:31ab with SMTP id
 ffacd0b85a97d-38dd43c33f9mr9706004f8f.7.1739285367182; 
 Tue, 11 Feb 2025 06:49:27 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf3c70sm213409105e9.26.2025.02.11.06.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:49:26 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Sam Day
 <me@samcday.com>, Michael Ferolito <michaelsunn101@gmail.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20250211
Date: Tue, 11 Feb 2025 15:49:25 +0100
Message-ID: <87v7tg8rka.fsf@baylibre.com>
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

Please find the following fixes for master:

Android:
- Handle boot images with missing DTB

Usb gadget:
- Fix nullptr in g_dnl when serial# is unset
- Add missing schedule() in f_mass_storage gadget
- Add support for STih407 in dwc3-generic
- Fix usb clocks on STih407
- Migrate STih407 to DM_USB_GADGET

Note that this also includes some small developments to enable
DM_USB_GADGET on the ST STih407 platforms.
These were pending for some time.
I missed those because the patches were assigned to Marek (instead of
me) on patchwork.

If it's too late (because it's past rc2) then please let me know.
In any case, my apologies for missing the patches.

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/24556

Thanks,
Mattijs

The following changes since commit b3c09eb36529fbb277bec17b35e638f42cb33683:

  arm64: configs: Remove SYS_BOOTM_LEN for TI devices (2025-02-05 12:45:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20250211

for you to fetch changes up to 4096d28ec80f982454ef0dc7d42a4d4eaead5d56:

  configs: stih410-b2260: Enable CMD_USB_MASS_STORAGE flag (2025-02-11 09:01:08 +0100)

----------------------------------------------------------------
u-boot-dfu-20250211

Android:
- Handle boot images with missing DTB

Usb gadget:
- Fix nullptr in g_dnl when serial# is unset
- Add missing schedule() in f_mass_storage gadget
- Add support for STih407 in dwc3-generic
- Fix usb clocks on STih407
- Migrate STih407 to DM_USB_GADGET

----------------------------------------------------------------
Michael Ferolito (1):
      usb: gadget: g_dnl: Fix NULLPTR dereference when serial# is unset

Patrice Chotard (10):
      usb: gadget: f_mass_storage: Add schedule() in sleep_thread()
      ARM: dts: sti: Add fixed clock for ehci and ohci nodes in stih410-b2260.dtsi
      configs: stih410-b2260: Enable DM_REGULATOR flag
      usb: dwc3: Remove dwc3 glue driver support for STi
      usb: dwc3-generic: Reorder include
      usb: dwc3-generic: Add STih407 support
      configs: stih410-b2260: Enable USB_DWC3_GENERIC and USB_DWC3_STI flags
      configs: stih410-b2260: Enable DM_USB_GADGET flag
      board: stih410-b2260: Remove board_usb_init/cleanup()
      configs: stih410-b2260: Enable CMD_USB_MASS_STORAGE flag

Sam Day (1):
      boot: android: handle boot images with missing DTB

 MAINTAINERS                            |   3 +-
 arch/arm/dts/stih410-b2260-u-boot.dtsi |  10 ++
 board/st/stih410-b2260/board.c         |  30 ----
 boot/image-android.c                   |   5 +-
 configs/stih410-b2260_defconfig        |   5 +
 drivers/usb/dwc3/Kconfig               |   8 ++
 drivers/usb/dwc3/Makefile              |   1 +
 drivers/usb/dwc3/dwc3-generic-sti.c    | 134 +++++++++++++++++
 drivers/usb/dwc3/dwc3-generic.c        |  20 +--
 drivers/usb/gadget/f_mass_storage.c    |   1 +
 drivers/usb/gadget/g_dnl.c             |   3 +-
 drivers/usb/host/Kconfig               |   9 --
 drivers/usb/host/Makefile              |   1 -
 drivers/usb/host/dwc3-sti-glue.c       | 253 ---------------------------------
 include/dwc3-sti-glue.h                |  41 ------
 15 files changed, 170 insertions(+), 354 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-generic-sti.c
 delete mode 100644 drivers/usb/host/dwc3-sti-glue.c
 delete mode 100644 include/dwc3-sti-glue.h
