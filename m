Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF08CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 16:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3D883020;
	Mon, 25 Aug 2025 18:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="SAL54ne9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA7083071; Mon, 25 Aug 2025 18:00:42 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 393C782FC7
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 18:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-afcb732eee6so794633266b.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1756137640; x=1756742440;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KfZDlcw7fqn4+vZi9qfxOrs7CGk+7O9RrNzdR9Bx3Y=;
 b=SAL54ne9UwiUcrunfdarGRZoDHhzipgZc9J5pCyzu0BjC689llJjn1b5vcYGE4+eq+
 MYkq4GoAWEipzyFh3coNgE8+h5JDrWUPeS4Wq66KeAy6hmYiKnKGwoRzARC/jqsIcdhq
 DhaAQm8JnfHJhrWApbPYu+wudTZv/qXCpohpAQ1Tu8iO06XUOXYDMjIbrcnopsH5Smfi
 2nNPLUlhieUkX9bS9vcYhRQ0PPVf/p/nqHebc9zkDjYfU3eJett1W+8IfrRCgkv4mbDf
 0X51Z5GGDZ7lkb8Sn1WXYgT7kB24eb9dBdKT+7TXxxYv89Q0GLBgrDDIJIOVYsEHtlvm
 Rf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756137640; x=1756742440;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7KfZDlcw7fqn4+vZi9qfxOrs7CGk+7O9RrNzdR9Bx3Y=;
 b=lMJVcfM5aPE3n7RrarxT4msQE4kajlhjAx8TS2ZlcrsWs6qHmLji+IsJSAQklGIP/x
 xnSnTM3X4uYftwvJq89EaaBnrt7A7xXKNcQgrQr7IJPBT40/rbkultQdBp4bdpTIju0V
 XLCgEwpKMuKXHcHdeIvf5MBBSCSl36Q7ZsfjbQfo3sUvDOFqhtO9XUGqbZSFMcYP+qyK
 cKxiLw5VdK5a6m3ciB36TxysBjBXj/HHS/6WQsSg0c1trACUjAQK3Plyr5WAFlBrZbU6
 A9SwwXovXYwGXzMu92y7jrZ9Yb/ovc1jIaA1IHrq2zBYejAdln1AMKwl1thK1hxO5yO9
 oY4A==
X-Gm-Message-State: AOJu0YwH7shHnJZB+Kjs6kXI0YXp1opzzv8zARyrEI9asFv2Ww7qRoID
 4Yqf88f0xBsT41cxogw2hgi+Fr90rs9GjZwkYVQFMWYp65gRZfQ9h/A6EKUPRLoda38Efy6yjU+
 DHPe1iNhE
X-Gm-Gg: ASbGncu/2omtuYNdDA1mkWzMdAzT3NE1phspQ9LKk+t+qlpw+9bJvtkb+YJ9Y5uECZl
 imV15Vwzs+fnzX6AL5DkWgu2bw6CUraAKsBLOdQm/aVBnFmch6YPaXe7XRRlwk+UQLYPILdEia4
 ax+NKCUGY3VceEpjrfdr+41X4g4910SAH8gvtTTlID5zwpjHPCPQtfS3VjGtvVM5Ycwc5OnN5Jh
 ToU9XlFmHpJ4xAuDknO06nHPvei7Qg2MenujaT8/uW+5R2B0WAcFVnkbS7T2mCFUgaXYLgcx5s9
 YfmhAeFzhTbEg+oA0/9+DZ5GtAKX8YohvrLqlrWCbNoAmLsCX4iGU7ll0SV94C/MYcDthfPMl3W
 RsRryxfvPbNR5xC8Z437vTlR6eGvcRuKTK2SpVPvC1JU2Xl1/NpA=
X-Google-Smtp-Source: AGHT+IHj7K2pMRfSee//JSf7vVBkWmi+olOJZKWrGcGShCTyapo+VRV6BCLLNEXia65/3qpvfANCsA==
X-Received: by 2002:a17:907:3d0b:b0:afe:6648:a250 with SMTP id
 a640c23a62f3a-afe6648c396mr656899466b.17.1756137639485; 
 Mon, 25 Aug 2025 09:00:39 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afe7b335575sm270038966b.14.2025.08.25.09.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 09:00:39 -0700 (PDT)
Message-ID: <5fc42e68-9fb1-40d0-8765-afe3f5c8f652@monstr.eu>
Date: Mon, 25 Aug 2025 18:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] AMD/Xilinx changes for 2025-10-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Tom,

I have collected couple of patches for current release which are fixing issues 
and would be good to get them to current release. It include issues reported by 
Coverity and Smatch and also fixing small issues.

Gitlab CI is not reporting any issue.

Thanks,
Michal


The following changes since commit 7d879baa6f7ca201bcecff74f2a7545560289280:

   Merge branch 'u-boot-nand-23082025' of 
https://source.denx.de/u-boot/custodians/u-boot-nand-flash (2025-08-24 08:01:29 
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.10-rc3

for you to fetch changes up to 37aee09d83863cf7fecb67f0f0eeea18e03a43ea:

   configs: versal2: Add usb_pgood_delay for versal2 boards (2025-08-25 16:20:48 
+0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2025.10-rc3

Fix smatch issues in zynqmp ipi and pinctrl drivers

zynqmp:
- Add missing zu1cg device
- Add missing ethernet alias for kr260-revB
- Define empty BOOTENV_DEV_SHARED_XSPI macro

fpga:
- Address reported coverity issues

net:
- axi_emac: Fix timeout test

versal2:
- Define usb_pgood_delay for fix device detection

----------------------------------------------------------------
Alexander Dahl (1):
       fpga: cyclon2: Remove message never printed

Andrew Goodbody (4):
       mailbox: zynqmp: Fix off by 1 errors
       pinctrl: zynqmp: Ensure ret is initialised
       pinctrl: zynqmp: Avoid using uninitialised variable
       net: axi_emac: Fix timeout test

Frank Böwingloh (1):
       soc: xilinx: zynqmp: Fix zu1cg device detection

Michal Simek (5):
       fpga: xilinx: Check valid desc structure
       fpga: Remove ancient ACEX1K support
       fpga: lattice: Remove unused support
       arm64: zynqmp: Add missing ethernet alias for kr260-revB
       arm64: versal2: Define BOOTENV_DEV_SHARED_XSPI when distro is disabled

Venkatesh Yadav Abbarapu (1):
       configs: versal2: Add usb_pgood_delay for versal2 boards

  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |    5 +
  configs/sandbox_defconfig              |    2 -
  drivers/fpga/ACEX1K.c                  |  245 --
  drivers/fpga/Kconfig                   |   12 -
  drivers/fpga/Makefile                  |    2 -
  drivers/fpga/altera.c                  |    5 +-
  drivers/fpga/cyclon2.c                 |    5 +-
  drivers/fpga/fpga.c                    |   23 -
  drivers/fpga/ivm_core.c                | 3149 --------------------
  drivers/fpga/lattice.c                 |  379 ---
  drivers/fpga/xilinx.c                  |    3 +
  drivers/mailbox/zynqmp-ipi.c           |    8 +-
  drivers/net/xilinx_axi_emac.c          |    8 +-
  drivers/pinctrl/pinctrl-zynqmp.c       |    6 +-
  drivers/soc/soc_xilinx_zynqmp.c        |    2 +-
  include/ACEX1K.h                       |   32 -
  include/configs/amd_versal2.h          |    2 +
  include/fpga.h                         |    1 -
  include/lattice.h                      |  298 --
  19 files changed, 24 insertions(+), 4163 deletions(-)
  delete mode 100644 drivers/fpga/ACEX1K.c
  delete mode 100644 drivers/fpga/ivm_core.c
  delete mode 100644 drivers/fpga/lattice.c
  delete mode 100644 include/lattice.h

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
