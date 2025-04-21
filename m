Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E32C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234BB815D1;
	Mon, 21 Apr 2025 18:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d/ls+j4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1570B8197F; Mon, 21 Apr 2025 18:26:18 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F044C810E8
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4914141A04
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252775;
 bh=yxLq44wxPtd/ML0wQnze9zkZLbz3Tc1B6pd5AzJDYPA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=d/ls+j4fIILwAVAWltqRZLpZs7o/t19c672gHYr0lEIh6xEj1zj1RcxH7pipcUOuI
 D+Oce2v2rvmD+DJey5FIGGKhBKb9lL3/cxaLV8v3blSOx4i+ps6Rmo5GrenWiq1g9q
 ddY3BPUdovcwy4C3KS2u/2eCdG3UIhrH/cSFgX9t1SxdKLbcXwX/ckxKFZDMwx4K1R
 rYFipO76lbVm02NIHwwfkZ4e72BG8KcFg9by3qcit8maxb5HdcnH1cL6DhRxXR9UwO
 ekFYw05AhL/ldvn3AKnU4rnkNZiyVeOAY3OOBwXH8AYp085qhP4AHNpPsgnuoqR5+o
 xyxlUkS01J9vA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so1627401f8f.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252774; x=1745857574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxLq44wxPtd/ML0wQnze9zkZLbz3Tc1B6pd5AzJDYPA=;
 b=B4eNy9k7HFVnQfrRsPXSOLndENdkUYuBAjunFL3BJPQ2VFNw8msXlBCVoCiKlG+186
 Z152aTnuRza+ZFEzCnKmWNVAbY2ljOy8jXmpOzGu+Yf3ofvi4VzWbM/P1nA9IWmHsgDW
 maIc2JlI12vOagQ2REIkB8KLjRLs1AubLBIqp8xV7ecNJGQZgRBYZdAArnjvVm11+iXF
 QsICUwyk+BLDncb8+42hD4IdDyaxPwYHVLWA+DjlkGccoJLeAiD3h1ROtaOZ1gyfQbS8
 L7N2h4D0FjIiq9AfblTLoSy4sIaaZeLcrVY8clRCZFUP1MO5XhvwEoF1YitUjtZwCgyB
 uFyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPQapUXiQauLzHM+ruj9xx1LVYEv8KabHp+v30Z7TSv5l3DyxM4jnVmJLnEfxfvdPck5XzZ1E=@lists.denx.de
X-Gm-Message-State: AOJu0YzMSzkFgQyJYIv3qSnOyK/kjzurY8wL9VYxWZBiN3hRV93RZZah
 rt9eptYmdWWelLAiIHHbEVnHn9XGxODSXxM/kG6R37bHCJPqMVRm14L62PBq82hZvkH6Q6dCAnS
 lGgdts9thk+qB6fe2UYnoE2wtMXqJ/q2Y6TgenjAz+pNC7WpdQTxGyUqin81SIKcU0HI=
X-Gm-Gg: ASbGncuJC5xeAJUBAu3a2c8uSx+7sFpfPeB3aCuLRu0oFhPmUP1XU+SztZKrIA1TGSO
 nqaw2bguE58uz0jUEQ3aTsVFc+l30pxjO6nV6hzeN79l5B0DEzhhJl8V64xJKWAjOEQ6ax8f7he
 ppaNo/mP/+m1kzdNw41PhBlZZnrKK/8B5xIlb4WNpeC20rcDI8oQyDH8viHhY+q+vOTPcU1Q8e1
 l2jPUeWwjPEugzIwH0e/eGtASNzSmi6Z/+iOfKXfbQXIqLhiWb/o4lrkmboYIJ2fVXqejUFGA64
 EWU+//X54UIMZE+OrNxCcl2SoejIxiwaWLemI9P2+/AAHd6qyDVqMfTkgyGmLLiUgMRt1Zpiomw
 2LO47KWAXpXsfzQ==
X-Received: by 2002:a05:6000:4211:b0:39c:2673:4f10 with SMTP id
 ffacd0b85a97d-39ef9091616mr12327728f8f.23.1745252774563; 
 Mon, 21 Apr 2025 09:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHILMdsdFN0nymgnyj6SdA5vMjLz94gz8IkHsuBi5vRXGGr2Y2rJoYSLtQ0iOmqr5RdH9xD4Q==
X-Received: by 2002:a05:6000:4211:b0:39c:2673:4f10 with SMTP id
 ffacd0b85a97d-39ef9091616mr12327706f8f.23.1745252774218; 
 Mon, 21 Apr 2025 09:26:14 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:13 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 0/8] boot: run EFI boot manager after block devices
Date: Mon, 21 Apr 2025 18:25:47 +0200
Message-ID: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

Up to now the EFI boot manager is running as a global boot method before
scanning block devices. This leads to failures to boot from unprobed
devices. Scanning all devices before running the EFI boot manager is
not wanted by some board maintainers.

Introduce a dummy bootdev with a priority between block devices and
network devices.

Add the dummy bootdeb to the QEMU ARM environment.

Do not run the EFI bootdev as we must not run EFI\BOOT\BOOTARCH.EFI
before the boot manager.

Heinrich Schuchardt (8):
  boot: EFI boot manager does not depend on BootOrder
  boot: BOOTMETH_DISTRO should select BOOTMETH_EFI_BOOTMGR
  boot: make BOOTMETH_EFILOADER default=n
  boot: introduce BOOTDEVP_6_EFI
  boot: prevent recursion in bootdev_hunt_drv()
  boot: make EFI boot manager bootmeth non-global
  efi_loader: create EFI BOOTDEV
  board/emulation/qemu-arm: enable EFI boot manager

 board/emulation/qemu-arm/qemu-arm.env   |   2 +-
 board/emulation/qemu-sbsa/qemu-sbsa.env |   2 +-
 boot/Kconfig                            |   6 +-
 boot/bootdev-uclass.c                   |   2 +-
 boot/bootmeth_efi_mgr.c                 |  24 +-----
 include/bootdev.h                       |  10 ++-
 include/dm/uclass-id.h                  |   1 +
 lib/efi_loader/Makefile                 |   1 +
 lib/efi_loader/efi_bootdev.c            | 102 ++++++++++++++++++++++++
 net/eth_bootdev.c                       |   4 +-
 test/boot/bootflow.c                    |   2 +-
 11 files changed, 124 insertions(+), 32 deletions(-)
 create mode 100644 lib/efi_loader/efi_bootdev.c

-- 
2.48.1

