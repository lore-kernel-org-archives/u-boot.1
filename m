Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA12C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 17:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1FD882D2B;
	Mon, 23 Jun 2025 19:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aHfiYHSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D6782D34; Mon, 23 Jun 2025 19:40:23 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D458006D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 19:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b2c4476d381so3425604a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750700420; x=1751305220; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nplzfKCbDu2bKu7f40GYWfXUNACYYQJXnVf/s1ULPcE=;
 b=aHfiYHSy/u/lahRJ3oFVTDI+zrtzu/19qaYbHyqIkNu6qwZOfcuvnweKufyXEjzjOy
 hDeIxcWRb7h0Inb81fateTneI0AAnd3V0eDv+kyFPgR57kczi2urKwPugXHDeow6WyeH
 vmvjxW4RL5+mZYaizubFi98nPNMmAzP2+84j7hKeN4Nr2fzbD01k2jtqXeKrZMGGMbFg
 By8RoMxrAQHhiEubTTwD/3fwJWXUDhrOtPv13ROy+Vnmd+OJfclSKkb2US757Y+Dp15H
 XFngoo9DX9Qc6XfKmn0kTtYLAS0YaXjhZxnRnOMX0KHkoN5WVkrIHNrZpaVZrXU1Sl/l
 ekLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700420; x=1751305220;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nplzfKCbDu2bKu7f40GYWfXUNACYYQJXnVf/s1ULPcE=;
 b=oQsEJLLuKT2fV4YvBi38Ub6fnb46Zvqo/POphm9xqBDtaNTfQYfdVGiw4KWUWaUqJe
 8o8KMh+/SvIVGEikD4niHjyIkWkeXwV3CA+fAT+cgAydtHyv6Rq2J1gAI29jrAmBaITW
 3M4Upxjx0nHa2KWH0W9VN6dHBYOG85b/cWodr8mMkeJjg9WlLlnpNvrqlZHZdo0uJKrJ
 Fd177JaGrUNMIPtaHZKf9vW4dbQim2zr/YiurddOJqXZ1xs0f+65c31qHFdywoCKck0I
 RProChAH4kVtyHFvYsBBh1RYS37r723DBfZpXFVfY0zUj5AKbf7RyyLj0aP1f33OQaQQ
 HHmw==
X-Gm-Message-State: AOJu0YxAyxeRr2sfr01lpv1SkP/dFlCdY5wPKJJtgcnzaEe644d+MpWf
 JMbjTV+Xp3FhKWNXEpze1bWPWA728Q4njYSNBTKVp3zketVe9QA7rXWa
X-Gm-Gg: ASbGnct83lSDY6jLIKeGaZvzp6/whpLB6Z5N/8quxGHr6y5DBMB77ejd831wi+NOyo9
 96IejYVROtyDrsSbEo97Wzi0hxUt7pnEYESPSbJ9bp1CIIc0gMStTssBZDXKMpAAedzn1+n+0Ku
 VRLS7IEDWvZYBzeGk4o9OvIXgE8mEQb4IdJ79TAnp6/rlXq6GT/5rfbzrimd0n4ZKziiRfy45fc
 XQJUP3+HNix0kEOGMuXgJmj4bnjt4Zclwuhh1kD0aMHxnN7e7KRlN/6JDlNZm0NTzShxiuphpfY
 qa+BYjlp2lvVODmEsOvwvgL/9b28frEVQ8DJjJ3JWBNWFuHvIpt5nb7YoBv1Pxi7qLQkCZrnvzV
 dSlNXPFEmMc/kPKk=
X-Google-Smtp-Source: AGHT+IG5lIpZaFzJSditQCtBlvhSMsPcd+9OTto1NIUZXsIcOpTeQQtwE3/1/tQMi5lna0WUIlbtXw==
X-Received: by 2002:a17:90b:3851:b0:313:d342:448c with SMTP id
 98e67ed59e1d1-315ccd1cf32mr554700a91.17.1750700419558; 
 Mon, 23 Jun 2025 10:40:19 -0700 (PDT)
Received: from [10.22.1.180] ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df8354bsm9465088a91.18.2025.06.23.10.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:40:19 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Subject: [PATCH 0/4] Improve Verdin AM62P thermal setup by generalizing
 ft_board_setup_ex()
Date: Mon, 23 Jun 2025 14:39:53 -0300
Message-Id: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGmRWWgC/x2MQQrCMBAAv1L23IUkamz7FfEQzEb3YLIkqQihf
 3dxbgPDDGhUmRps04BKH25csoqdJ3i8Qn4SclQHZ9zFeHfC8PZOMMWOib+7YK8sKIVzb7gEv5I
 SzlcLepBKGv3vt/tx/ABmakTXbQAAAA==
X-Change-ID: 20250623-am62p-fdt-fixup-trip-points-8a69eeeea471
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
X-Mailer: b4 0.14.2
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

In some use cases, board-specific device tree changes must not be overwritten
by system fixups. Although U-Boot provides ft_board_setup_ex() for this
purpose, it is currently only used on TI Keystone. This series makes
ft_board_setup_ex() a generic option, allowing its use by other architectures
and boards.

Additionally, considering that Toradex Verdin-AM62P hardware lifetime
guarantees are based on a 105°C junction temperature (while TI AM62Px supports
up to 125°C), this series implements necessary changes within TI K3 AM62P and
Toradex board code. These changes include exporting common fixup device Tree
functions used in TI K3 for board-code access and also fixup for AM62P thermal
zones to correctly reflect the number of CPU nodes according to the SoC part
number.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
João Paulo Gonçalves (4):
      boot: Make ft_board_setup_ex() generic
      arm: mach-k3: Export common fdt fixups for use in board code
      arm: mach-k3: am62p: fixup thermal cooling device by cpu number
      board: toradex: verdin-am62p: Add fixup for critical trip points

 arch/arm/Kconfig                                   |  1 +
 arch/arm/mach-k3/am62ax/am62a7_fdt.c               |  3 +-
 arch/arm/mach-k3/am62px/am62p5_fdt.c               | 73 +++++++++++-----------
 arch/arm/mach-k3/am62x/am625_fdt.c                 | 41 +-----------
 arch/arm/mach-k3/am65x/am654_fdt.c                 |  3 +-
 arch/arm/mach-k3/common_fdt.c                      | 38 ++++++++++-
 .../{common_fdt.h => include/mach/k3-common-fdt.h} |  7 ++-
 arch/arm/mach-k3/j721e/j721e_fdt.c                 |  3 +-
 arch/arm/mach-k3/j721s2/j721s2_fdt.c               |  3 +-
 arch/arm/mach-k3/j722s/j722s_fdt.c                 |  2 +-
 arch/arm/mach-k3/j784s4/j784s4_fdt.c               |  3 +-
 board/toradex/verdin-am62p/verdin-am62p.c          |  8 +++
 boot/Kconfig                                       | 10 +++
 boot/image-fdt.c                                   | 27 ++++----
 cmd/fdt.c                                          |  6 +-
 configs/verdin-am62p_a53_defconfig                 |  1 +
 include/fdt_support.h                              | 15 +++--
 17 files changed, 132 insertions(+), 112 deletions(-)
---
base-commit: dbf7fd557a73ded3141db3c2cf5c572989378825
change-id: 20250623-am62p-fdt-fixup-trip-points-8a69eeeea471

Best regards,
-- 
João Paulo Gonçalves <joao.goncalves@toradex.com>

