Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098E3C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 14:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CC787D8E;
	Sun, 28 Jan 2024 15:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JbrXaar9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CBB88071; Sun, 28 Jan 2024 08:06:35 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFC188092
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 08:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d7858a469aso9687765ad.2
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 23:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706425591; x=1707030391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cs34DCk8BUCiRbxVXatc65zp05pJnObGeefdRegaPIE=;
 b=JbrXaar9fHsCnEp9/DIwjSnEcbKfagrtxg9pRKzhKPjK1fNrdvmie9ZqT9YVDUkYsd
 hlR7MaPpkfAAq3RhNx8rK+hSfOvNQRjtDCa+wHCscZnXOgqC6F4e49q/J30v2NmeoktS
 v0Fx1FtmG0sixkQMsPZRpPyhOfGRV3eXG995W0b5O8XcFh0HdPIAErIOkt9UYcy75AVi
 UKal1tBaYWvekRfTgS5vvjPqYA7s3ZLbf6V2XFDSrrczUfGTfPJPVZnfb92muFucaCMc
 JdWsnuj4/cLqXM/OH9cga/u2l44pzLnrB2/2L3MCAFjtm7DealOy6yxTUN5831ziPbVh
 enjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706425591; x=1707030391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cs34DCk8BUCiRbxVXatc65zp05pJnObGeefdRegaPIE=;
 b=iBW2VsE4zbkySPHPFhhuta+ICq2M1nstZh9kfOIsZvTll2b7MvmbHsHxoKD5SkbEAz
 2zwqzT6xreiilM/RDxCxslEtu393hqOSNqpxO/7Q+UdAybJl/9t6aNlzEa3hi+F3kqJB
 EfZ1JPzk16A12xdECQPLEE4qAmEEefkiGenMgaTKUPnjrdmuO6VhF8o3bWG68BD8Z1hm
 liiaiThp9aq8d9GGPQakIgoq/+9b/HABHF6TLlrBHFYgKNTo0T/k5oHH7FveTEKjTpWd
 arQz+8gVRYGloIa2mhkR6lkxz+5Yw32nGp6lujwG0Q6gGHxUWIb73WQ1YCxnBElCXFLF
 HMSA==
X-Gm-Message-State: AOJu0YwWV13mpbi0eE96cdh8BHoY/5MycVT6Z+XdffjThA5d8YCQIsnf
 U5I+7Z/PJKkGIgpO7H6xx5TBjARSNMusHZGLnYYf7RTUwIm678W6wbWkk4HPTUaRajGH
X-Google-Smtp-Source: AGHT+IF4KHlJlCro3CcVtpTxpbnf6Ry+2Qat5qakxkxVXU+feNakeGOsURmcIHA/u4czdHKcrtR+Dw==
X-Received: by 2002:a17:902:d312:b0:1d7:1213:e8b0 with SMTP id
 b18-20020a170902d31200b001d71213e8b0mr991494plc.116.1706425590537; 
 Sat, 27 Jan 2024 23:06:30 -0800 (PST)
Received: from localhost.localdomain ([115.216.236.184])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001d88b4b87f9sm3287297plb.192.2024.01.27.23.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 23:06:30 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Fabio Estevam <festevam@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v4 0/3] riscv: sophgo: milkv_duo: add support for Milk-V Duo
 board
Date: Sun, 28 Jan 2024 15:05:23 +0800
Message-ID: <20240128070614.7702-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jan 2024 15:10:42 +0100
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

The Milk-V Duo board is built upon Sophgo's CV1800B SoC, featuring two
XuanTie C906 CPUs running at 1.0GHz and 700MHz, respectively.

This series introduces fundamental support for the Milk-V Duo board,
encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
operate in serial console mode.

Changes in v4:
- Sync dts files with Linux kernel

Changes in v3:
- Swap patch 1 and 2 duo to dependency of defconfig and device tree
- Enable EFI loader
- Add brief description of the procedure to run u-boot-dtb.bin

Changes in v2:
- Fold the defconfig patch to first patch
- Remove unnecessary environment settings of consoledev and baudrate in
  config

Kongyang Liu (3):
  riscv: dts: sophgo: add basic device tree for Milk-V Duo board
  riscv: sophgo: milkv_duo: initial support added
  doc: sophgo: milkv_duo: document Milk-V Duo board

 arch/riscv/Kconfig                   |   4 +
 arch/riscv/dts/Makefile              |   1 +
 arch/riscv/dts/cv1800b-milkv-duo.dts |  38 ++++++
 arch/riscv/dts/cv1800b.dtsi          |  18 +++
 arch/riscv/dts/cv18xx.dtsi           | 192 +++++++++++++++++++++++++++
 board/sophgo/milkv_duo/Kconfig       |  28 ++++
 board/sophgo/milkv_duo/MAINTAINERS   |   6 +
 board/sophgo/milkv_duo/Makefile      |   5 +
 board/sophgo/milkv_duo/board.c       |   9 ++
 configs/milkv_duo_defconfig          |  23 ++++
 doc/board/index.rst                  |   1 +
 doc/board/sophgo/index.rst           |   8 ++
 doc/board/sophgo/milkv_duo.rst       |  64 +++++++++
 include/configs/milkv_duo.h          |  12 ++
 14 files changed, 409 insertions(+)
 create mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
 create mode 100644 arch/riscv/dts/cv1800b.dtsi
 create mode 100644 arch/riscv/dts/cv18xx.dtsi
 create mode 100644 board/sophgo/milkv_duo/Kconfig
 create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
 create mode 100644 board/sophgo/milkv_duo/Makefile
 create mode 100644 board/sophgo/milkv_duo/board.c
 create mode 100644 configs/milkv_duo_defconfig
 create mode 100644 doc/board/sophgo/index.rst
 create mode 100644 doc/board/sophgo/milkv_duo.rst
 create mode 100644 include/configs/milkv_duo.h

-- 
2.41.0

