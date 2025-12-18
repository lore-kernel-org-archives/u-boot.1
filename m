Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83093D6E2CA
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1456F80325;
	Thu, 18 Dec 2025 20:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="at53onjL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5CA4800AB; Thu, 18 Dec 2025 19:53:19 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8714F8003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 19:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-bcfd82f55ebso842875a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 10:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766083991; x=1766688791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=anjqbXS8zPBr6KTW5Fqmzr73+F6fgsXcViqDLfxHOY0=;
 b=at53onjLQW09H0U3cbYOPeNBd4F/1096fMJcvmQJvtFJCnMLPJ7d1UgvT40l/dKiO7
 JlvCXLRBBw9eOohrzC/15KlX1YPn8K2HqpJ8+K3kJiyeaxj346d6HkD/N8fwAgCU86Mu
 fLN6v8+jL687nZUS8rTUHVSCy3gUUUqlMgVF2FPxolVqZY0ZVP/dG6oN1TbFKzHCTA/a
 eaOG6QagUex5lQk2orCtJRwAzV4IraLMRnSxu19NUpPi+XEDmTcdGZIjlgc3d9t+0DkL
 oPJiJeR6TrRigo0mlDjlfkE7fZS0ku8e16hQAcryAfYob7fNQuuUw2jBd0ehaP7g0q0v
 YBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766083991; x=1766688791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anjqbXS8zPBr6KTW5Fqmzr73+F6fgsXcViqDLfxHOY0=;
 b=J3i0hmQ+AIk6Gdi+Mx8vyikLf4KDuUkDOPPpXQjF/kbIYvjO6wXqC5h06ysqoohlwC
 UywUO0nRHUXfmfGNLKrd//o4KT5LqeKck6dtmcGHSImYWUL6MLxxC1EFijdpQOFCwAun
 wl/1HQeG2acCCM2wyrQNsJ/O8CqwIuyC6LHrsyHW2M4byEh9mbc6KjAdlOdJWupyk9FP
 IcQi99ZekKzhwwmDz/1hpSyHkQAv7ByYWrEJuiS32NxojYCb0DiP5VstxdzJIK2s+4Mw
 3aPMw9B+jOPs4g0RFWQOxAfR4kIaVIudYrvsF/t5haHcvPYNHBH9hp0yjzIlUUS8zfRT
 Tkrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFTW6Qqc+Nb6PkUhfE//zXWmur1Qir8DrAkN0Wv34VVCKHHaI2+2SXGteydEaQZnhux90Ywe8=@lists.denx.de
X-Gm-Message-State: AOJu0YwPLc79M5Yx+0O6M85mVADR6h0eFO+v0QDBya5w2AbZoT3wiyg3
 ZdcV2hZ65QtJsBJJYdqOdndK7aez9nwwRn74QaF7dFu3QlIZpM6gC35s
X-Gm-Gg: AY/fxX54Jn7JtjGtz2wYYDkwV1J8YJu/XFpmQ6IBEZHllUFuRkI6PDdjwuZggcIH0M/
 7c+JHUrMMgDc4V2xvXAeTdggPtoejaKHCoBI0GdP6byHvyUTb13RP8Bbyz4PAMYfgUbBkztD7s1
 9mTNLJANP0M+yj3aPWwj5mukNOid1Vf+08l0AlLPPrb2lXFjacsSBjkuY9CKcTVqWQ4tttYnEW7
 /0fYzzMiJuFRyviTAsqbTIZ8js8OSBzb6uro2/Rlt1uMxEfC5m/izYTgaUQYKX+O0rVY7OTAWOw
 IEbZEiQceOVFpmvDxOaNS4GGM7yoj7jURGumeyw8MHHFYqLBM9y6Qwm1MNyg+SvcqYftZ+c9IHg
 b2WOd/NUvz8xzasFsXU8PQWgqVEm05VDzJ6yLE6MNewWX5zV2SdDq1Ue6/2uxkQP3bMZ/2AHfvD
 stxDF7MHjTHaser0pau9coLrBNb5s7mKU8WtBTGpn7Mzeb+4yLeOy4Cy9tBOp2ZWUYug1LhtJph
 OCFCGdRk41f9otwfPqzzg==
X-Google-Smtp-Source: AGHT+IFDd1dwci2+EYfsovgJ0DCogGa6ZvMmJYIqT7EW+cKeRdk+J5poYmrSRuZUah2H21GIUNQ+7g==
X-Received: by 2002:a17:90b:4a43:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-34e71d6961amr3205524a91.3.1766083990872; 
 Thu, 18 Dec 2025 10:53:10 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d65653sm3136275a91.5.2025.12.18.10.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:53:09 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/3] m68k: Add support for QEMU virt machine
Date: Thu, 18 Dec 2025 18:52:49 +0000
Message-ID: <20251218185252.957388-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Dec 2025 20:05:51 +0100
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

Add support for the QEMU 'virt' machine on the m68k architecture. The
QEMU virt machine models a generic system based on the Motorola 68040
CPU and utilizes Goldfish virtual peripherals.

Currently, U-Boot's m68k architecture support focuses on ColdFire
variants. Expand this to include the classic M680x0 architecture,
implementing the necessary exception vectors, startup code, and a
bootinfo parser compatible with the QEMU interface. A driver for the
Goldfish TTY is also added to enable serial console output.

The implementation has been verified on QEMU targeting the M68040 CPU,
confirming successful hardware initialization and boot to the U-Boot
command shell.

Kuan-Wei Chiu (3):
  serial: Add Goldfish TTY driver
  m68k: Add support for M68040 CPU
  board: Add QEMU m68k virt board support

 MAINTAINERS                           |   6 ++
 arch/m68k/Kconfig                     |  23 ++++++
 arch/m68k/Makefile                    |   1 +
 arch/m68k/config.mk                   |  10 ++-
 arch/m68k/cpu/m68040/Makefile         |   6 ++
 arch/m68k/cpu/m68040/cpu.c            |  77 ++++++++++++++++++
 arch/m68k/cpu/m68040/start.S          |  83 +++++++++++++++++++
 arch/m68k/cpu/m68040/u-boot.lds       |  47 +++++++++++
 arch/m68k/include/asm/bootinfo.h      |  31 +++++++
 arch/m68k/lib/Makefile                |   9 +--
 board/emulation/qemu-m68k/Kconfig     |  12 +++
 board/emulation/qemu-m68k/MAINTAINERS |  10 +++
 board/emulation/qemu-m68k/Makefile    |   5 ++
 board/emulation/qemu-m68k/qemu-m68k.c |  84 +++++++++++++++++++
 configs/qemu-m68k_defconfig           |  17 ++++
 doc/board/emulation/qemu-m68k.rst     |  38 +++++++++
 drivers/serial/Kconfig                |   8 ++
 drivers/serial/Makefile               |   1 +
 drivers/serial/serial_goldfish.c      | 112 ++++++++++++++++++++++++++
 include/configs/qemu-m68k.h           |  18 +++++
 include/goldfish_tty.h                |  18 +++++
 21 files changed, 608 insertions(+), 8 deletions(-)
 create mode 100644 arch/m68k/cpu/m68040/Makefile
 create mode 100644 arch/m68k/cpu/m68040/cpu.c
 create mode 100644 arch/m68k/cpu/m68040/start.S
 create mode 100644 arch/m68k/cpu/m68040/u-boot.lds
 create mode 100644 arch/m68k/include/asm/bootinfo.h
 create mode 100644 board/emulation/qemu-m68k/Kconfig
 create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
 create mode 100644 board/emulation/qemu-m68k/Makefile
 create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
 create mode 100644 configs/qemu-m68k_defconfig
 create mode 100644 doc/board/emulation/qemu-m68k.rst
 create mode 100644 drivers/serial/serial_goldfish.c
 create mode 100644 include/configs/qemu-m68k.h
 create mode 100644 include/goldfish_tty.h

-- 
2.52.0.322.g1dd061c0dc-goog

