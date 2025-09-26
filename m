Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDF5CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F8D8386F;
	Fri, 26 Sep 2025 18:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WA58smmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D7583868; Fri, 26 Sep 2025 18:02:35 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD9C83824
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 18:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-427e5121313so2900935ab.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758902550; x=1759507350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0HxDM6gr2rONdbcVcfHGkRLLA8LBLdhnjkcdN2NnHMU=;
 b=WA58smmvK3Sxfxy5NoJuN7RXFTRqfCJarcE4ka+ZDJ3AxSywbAeOHVKs2JMuuhcsJF
 5LNTm4S0mTIY4XOk13rOt+2lm/mGfyF55C8pbt3H0MxwYbmkxwl9F+UhrdB3RZupqzEb
 R/00flA4St5sjtcaaISiywukwsop62m8/NlXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902550; x=1759507350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0HxDM6gr2rONdbcVcfHGkRLLA8LBLdhnjkcdN2NnHMU=;
 b=BlQx9sn/cjI1FHqfYWjoNzR+hGZu1H5jvfH48ktUl6s9v+PEq9gAzXJ7PLTGkJoozT
 kSuaNHNMwBufdymAmRsoxWuTDSZ+kvuZU4JGx15t9xvGGLMEWkKhTfI9lHliya4qpn4M
 OoTbxEb+O7Q0G30otV7FW3O8t99Y6iE2Po+4MKXCzuwToh6IUvWfpR0pChCNk4zW4Jky
 YuAO+3FkXdco32woED07C/wlJ/2FLWacLmsm9qxOHrvDMBggVCMtioBvmYBBZIXZk67C
 fmSmmL+3yaici8omi34GBVyOeLYaTvQXJM4RD3aTgcCF0YmJV4g0t5wbKa1EeTUcU9uC
 /5vA==
X-Gm-Message-State: AOJu0YykoN9z6fS4Pxp+PXXh10/i8KmCmwbqDv7x+VzOyq/x1EfkGgrK
 qWjjf0zZJgq0RnFbsqLsTvi6cK8ShHYOG2UgTWoK4AhHe4+iKnx6D0HmuNKAq8BBB1tVrIC6vYs
 FH3Ubug==
X-Gm-Gg: ASbGncsy+9t8JBfQoDdzSaOmvd3a85DYzMNaN5h5yTVSvde7u1+xTkTUW3ekePyNjHY
 GFYKnVYQXku+3IhtiNPjDsWbjXediyepaH+1XybfjVYKPC3F56jc6thO6Y1gO7UaeyhkwlaJ3DT
 GqIUc4tuqEpYk4vbX3TQQ457i2D2/HHKufDYAZ2le/49rr4SOapYi6r3iEZjHZTetR2eC7s1j/y
 v0xD4tIqoOb0BniDgEw4X4uhWJyn+EVznPFKm0Bn8dv0UlwEzwPAK6QHlRth1eQnDvWThIkmsdW
 kXi+aEe5JveB0hmNPPhGWYYeIWdua2jDaI6XeAFQXBVvFQRrQKkNhTcS8AQyGVXO7l57R+0DzDG
 uHdnWv/Pd+98RW6lBpkc7CYs++Vg=
X-Google-Smtp-Source: AGHT+IEoG4aUSr+9GAGh8ZIkkIDSTHcRRwjdd0ctscoq0KCMBtKYj7UsPr3NfQnMRkHj9rhLLafYDw==
X-Received: by 2002:a05:6e02:1949:b0:424:8151:6e20 with SMTP id
 e9e14a558f8ab-4259566d09cmr133123315ab.29.1758902550022; 
 Fri, 26 Sep 2025 09:02:30 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a6a5ae382sm1997134173.64.2025.09.26.09.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:02:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Hans de Goede <hdegoede@redhat.com>, Liya Huang <1425075683@qq.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
Subject: [PATCH v8 0/4] bootstd: sunxi: Migrate to standard boot
Date: Fri, 26 Sep 2025 10:02:08 -0600
Message-ID: <20250926160216.2157348-1-sjg@chromium.org>
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

This series attempts to migrate all sunxi boards to use standard boot,
along with a text environment.

According to Heinrich this should not affect bootmgr, since it is a
global bootmeth. FEL should be OK since it is also a global bootmeth and
is ordered before bootmgr.

Heinrich has a pending series which moves the ordering of bootmgr to
speed up the boot and we will talk that through in the coming days.

Changes in v8:
- Drop 'select' for USB

Changes in v7:
- Drop bootmgr-disable patch

Changes in v6:
- Drop patch to revert make efi_mgr bootmeth work for non-sandbox setups

Changes in v4:
- Reword Kconfig
- Add a name for the bootflow
- Drop UUID_GPT_SYSTEM and UUID_GPT_ESP definitions
- Drop special case for ARM64's devicetree subdir
- Drop unwanted quotations and indentation in KERNEL_COMPAT path

Changes in v2:
- Put the FEL bootmeth before all other global bootmeths
- Convert the other DISTRO_DEFAULTS in the Kconfig too
- Keep BOOTCMD_SUNXI_COMPAT
- Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled

Simon Glass (4):
  sunxi: Add a bootmeth for FEL
  sunxi: Move to bootstd
  sunxi: Drop old distro boot variables
  sunxi: Move to text environment

 arch/arm/Kconfig               |   6 +-
 board/sunxi/sunxi.env          | 140 +++++++++++++++++++
 boot/Kconfig                   |  14 ++
 boot/Makefile                  |   1 +
 boot/bootmeth_fel.c            |  85 ++++++++++++
 include/configs/sunxi-common.h | 238 ---------------------------------
 6 files changed, 244 insertions(+), 240 deletions(-)
 create mode 100644 board/sunxi/sunxi.env
 create mode 100644 boot/bootmeth_fel.c

-- 
2.43.0

base-commit: 44c4919e9dd6c162b237633ba689441eca9a149c
branch: std8
