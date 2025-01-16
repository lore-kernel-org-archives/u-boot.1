Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28CDC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66ED38022B;
	Thu, 16 Jan 2025 12:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LXKk56xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 099878033D; Thu, 16 Jan 2025 12:39:19 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB6C80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61A113F686
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737027556;
 bh=otzYu17dCQzMffdutsJBAYOHPxjJyCCxVKcIQHLrl7M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LXKk56xlXUXIrnEHoL77201PwJSMYEUnZ6M7KYnaR2EOmTHspCPi3uxPx6XS0tTCe
 ROmLEOpBKdNAOxRqICzSsU5lBg6zkae2+4xM1HA5AUEiHrqFFhebc6az+ZWUaULwiL
 zEVjq26YuSFQiW4qpKk//OHVAzmLjCUUx4UvscGEStdMc9TQukxK7e7chsflgnP0Zg
 SGhF3ur0g6rDHkzcA1n3Rz3QmG5gXlkstzU/1TfzSy1j4n/crXyuItv2C5x5tfYb6o
 MBL5kcjCpwnwPYKKofkZWtaEgH+rF5qrCOfXxW9mEVtnneX+Y+3Q1cKb1tUiMHV+dg
 pg7gRoAvqTRhg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so5117725e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 03:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737027556; x=1737632356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otzYu17dCQzMffdutsJBAYOHPxjJyCCxVKcIQHLrl7M=;
 b=ibizgA+Fr/XPtFsW9jUOpA2tQnRaEuu3bCIMchwyi/A2aaIESbmvjHZxqOa6G1Z9uG
 7ocMi62WM6RZIQR2VpEU9eNaDcf2Xfch6MKGVFhVcXABDGkxRT4krc0vu1WIYk5E47Oq
 L+eNZu6Tw9QLUkFMM0/zdiKf2lLPcsHBx9JzIKFnLl2RqhS7M7lrKTZZDXzVGXGL6022
 TZoUBP9eyUrmpIK4LxI2DdclqC/ECbUbn0HNR5BOP0YbXLk9FYnGUkjJzfmXKBgCACMB
 DX8AzaMKaaB9epks7PBU1Kdr5aEeagTuUXB7zzM4LNUq2Ueb2Qc+wDji6YVSb9fFg25t
 7Y+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvldcA8r+mBKuJcER3DEgHZSzD6cj/n0hP6EghQ+6tY2w4KERshyeiBzxV/ODnz0ai1IlnMOk=@lists.denx.de
X-Gm-Message-State: AOJu0YxDDnxwNzEJYStxpt0e0UOul5CuDwiFgfWcoyfx3djpLDRJWEEw
 oHG1Uit0cQVQHFVwKA20Xs7CROeteOOPBoajmq/D3v3ZLCJU3UUUjzQ+SbCxfRx33omkstGzAu4
 NFV9lYZ7NyNI5ULKX2sXZMiNS/N/9kCDN9yz5fmDGrSENW8dgfBG54iYw6xpl3r+Isgk=
X-Gm-Gg: ASbGnct3r78VJctdbsLNxhFmvasJ2sf6KoumQLqeQSreugMfz/PjmL5oirY+d/zYQ/g
 iqO5H++DLzNT5wof29J/xr9tOCf4b6qLxMIGqCdZQjLbIO+9I3tyGIZODYlE021Y6kuI2VrBZBd
 SY+eW5zQNRiLQ+Vm9trGHLypNelK00wau4rGfcu+Q/HkRkWwNWfcyxQ0mdkNwsMjKZ+1Hmknhyk
 1QpixVY6Mgd849F2Rrr895Lc01FuQxQhT+HyAkjImjhAqe/Ua1+sSMXO/0Hg1ZYRJ4zOy2JWucP
 /kW4SphKQaawhg==
X-Received: by 2002:a5d:648a:0:b0:386:3e87:2cd6 with SMTP id
 ffacd0b85a97d-38a8730fb57mr31488905f8f.38.1737027555899; 
 Thu, 16 Jan 2025 03:39:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUaVPlBUoH5KRZiHd3OTMx/P1j8PUdoiB1OKcqUiLnPu9FkQgjH3WVDx1mn5Qem31WzCuyrg==
X-Received: by 2002:a5d:648a:0:b0:386:3e87:2cd6 with SMTP id
 ffacd0b85a97d-38a8730fb57mr31488875f8f.38.1737027555562; 
 Thu, 16 Jan 2025 03:39:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm20606320f8f.39.2025.01.16.03.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:39:15 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/5] efi_loader: Fix section alignment on EFI binaries
Date: Thu, 16 Jan 2025 12:39:04 +0100
Message-ID: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

When creating EFI binaries, the alignment of the text section isn't
correctly factored in. As a result trying to load signed EFI binaries
throws an error with:

    efi_image_region_add() efi_image_region_add:
    new region already part of another Image
    not authenticated

Except for the fixing each linker script individually carve out a linker
script include for ARM and RISC-V.

Correct SizeOfCode and SizeOfInitializedData.

v2:
	Correct SizeOfCode and SizeOfInitializedData.

Heinrich Schuchardt (3):
  scripts/Makefile.lib: add -L option to LD command for EFI binaries
  efi_loader: use INCLUDE in EFI linker scripts
  efi_loader: use include in ARM EFI linker script


Heinrich Schuchardt (4):
  scripts/Makefile.lib: add -L option to LD command for EFI binaries
  efi_loader: use INCLUDE in EFI linker scripts
  efi_loader: correct SizeOfCode, SizeOfInitializedData
  efi_loader: use include in ARM EFI linker script

Ilias Apalodimas (1):
  efi_loader: Fix section alignment on EFI binaries

 arch/arm/lib/crt0_aarch64_efi.S    |  2 +-
 arch/arm/lib/crt0_arm_efi.S        | 13 +++---
 arch/arm/lib/elf_aarch64_efi.lds   | 68 +--------------------------
 arch/arm/lib/elf_arm_efi.lds       | 71 +---------------------------
 arch/riscv/lib/crt0_riscv_efi.S    |  4 +-
 arch/riscv/lib/elf_riscv32_efi.lds | 68 +--------------------------
 arch/riscv/lib/elf_riscv64_efi.lds | 68 +--------------------------
 lib/efi_loader/elf_efi.ldsi        | 74 ++++++++++++++++++++++++++++++
 scripts/Makefile.lib               |  4 +-
 9 files changed, 90 insertions(+), 282 deletions(-)
 create mode 100644 lib/efi_loader/elf_efi.ldsi

-- 
2.47.1

