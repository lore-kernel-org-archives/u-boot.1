Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C86C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FCEB88BCB;
	Fri,  2 Aug 2024 21:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cfq2DsOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A88088BE0; Fri,  2 Aug 2024 21:23:17 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCAF788BBB
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ff496707beso3391645ad.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722626593; x=1723231393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xTqy6OauXQdGMglBGcKBaggf/2SkWeRzHkNJ9UWHzHY=;
 b=Cfq2DsOxafA1e8UN6qM6fhKxFPg7uR1yZ8MkkJ47yLcDqV10MEn2tVNTm67uFFrF1G
 rhJe95DZ3w0ols1djAclCZdNwLY93/R52+Hl2LjQAc/tJi/DWsy9FMmijJoaGq2n2N7E
 PZA9U+Jc6WjsafjibIrwMvHspL/nlyCKJ/ovUKaZt1aNNlUEQ5aXEAfuI++ZA1FOAUJI
 Sb3k4+TXBa97UOQ7fok2/ai2AM1lv6V3N1qaXIFLxgfPUca91qUV5kdXCTBE4ctrSAgX
 KGT87ZUwN8HxwqE/9SvUvWzL5mx+FwQNpAQvOsbB8ah3N4u7Jl5nuxLVPjYXAOmY0vo5
 1KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722626593; x=1723231393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xTqy6OauXQdGMglBGcKBaggf/2SkWeRzHkNJ9UWHzHY=;
 b=oZBs73D/QDFCtkAnnIgMwEBNT+nv0pyKdD1ebM9gqSqB3KmW1xSBt2G+g7j1shdqSX
 xRvTx1asO3kHDeXWO6VVBnAqvp260Xfiay7BhVcm4IQ3Oq5/Ekl6mnfGyfUhb8yEVoBm
 +a/MkHMOlJQZh7P93D8P/1pj0o0kWEdmvVccBvfDVnmD36hOeXnvXznqEIp1YOL4XmXd
 dM9JiM4guDBBnKoiKBQwgBbugUfU07FbuhPiSXqcqhTixWmYZlOsrYuyQVxCChW4Enn1
 igw7OrVG0LMSSJ8wZKunxxi7gNwCK/lcrm5DUQLyN0JSvOaYPUe8IBp01lMVjNZXTp2M
 cCRQ==
X-Gm-Message-State: AOJu0YzDtgLgZy2kQstgKSo33InlZXHRJId5Ya5B+NEjqONc1BB6ufAm
 w5s7fnAP2KnL/OglswZEp5YOIfSHbTsoaZSufSO9z0NxUvFHkG3QC8ru0Q==
X-Google-Smtp-Source: AGHT+IFLZRKBLr3BEgXGtErc2C7DnS5UgJcQ/eWBVQX963pproHU7PW0Ra7k3NIGRlyFt7HhVL6NSw==
X-Received: by 2002:a17:903:245:b0:1fd:aac9:a722 with SMTP id
 d9443c01a7336-1ff5728b2d0mr31347885ad.4.1722626593144; 
 Fri, 02 Aug 2024 12:23:13 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c701:7231:d178:3f24])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929ac42sm20852125ad.267.2024.08.02.12.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:23:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240802
Date: Fri,  2 Aug 2024 16:23:09 -0300
Message-Id: <20240802192309.1777601-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit a70d991212c9684e09ed80ece69ce1ff7bfd9f08:

  clk: clk-uclass: Print clk name in clk_enable/clk_disable (2024-08-01 15:35:28 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240802

for you to fetch changes up to 0ee02e1c252da85a6ac75865ca33accde69072b7:

  config: Adjust Phytec imx8mm module config to support NVME disk (2024-08-02 15:16:54 -0300)

u-boot-imx-master-20240802
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/21846

- Convert warp7 to OF_UPSTREAM.
- Add 'cpu' command to imx8m and imx93.
- Enable CMD_ERASEENV for imx8mm/mp Phytec boards.
----------------------------------------------------------------
Fabio Estevam (1):
      warp7: Convert to OF_UPSTREAM

Hou Zhiqiang (14):
      clk: imx8m: register ARM A53 core clock
      cpu: add release_core callback
      cpu: sandbox: implement release_core callback
      test: cpu: add test for release CPU core.
      cpu: imx: fix the CPU frequency in cpu_imx_get_info()
      cpu: imx: fix the CPU type field width
      cpu: imx: removed the tail '\n' of the CPU description
      cpu: imx: Add i.MX 8M series SoCs
      cpu: imx: implement release_core callback
      cmd: cpu: add release subcommand
      doc: cmd: add documentation for cpu command
      MAINTAINERS: add entry for cpu command
      configs: imx8m: enable the 'cpu' command
      configs: imx93: enable the 'cpu' command

Lukasz Majewski (1):
      config: Adjust Phytec imx8mm module config to support NVME disk

Yannic Moog (3):
      configs: imx8mm-phygate-tauri-l_defconfig: enable CMD_ERASEENV
      configs: phycore-imx8mm_defconfig: enable CMD_ERASEENV
      configs: phycore-imx8mp_defconfig: enable CMD_ERASEENV

 MAINTAINERS                              |   7 +
 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx7s-warp.dts              | 500 -------------------------------
 arch/arm/mach-imx/mx7/Kconfig            |   1 +
 cmd/cpu.c                                |  44 ++-
 configs/imx8mm-phygate-tauri-l_defconfig |   1 +
 configs/imx8mm_evk_defconfig             |   3 +
 configs/imx8mn_evk_defconfig             |   3 +
 configs/imx8mp_evk_defconfig             |   3 +
 configs/imx93_11x11_evk_defconfig        |   1 +
 configs/phycore-imx8mm_defconfig         |  11 +-
 configs/phycore-imx8mp_defconfig         |   1 +
 configs/warp7_bl33_defconfig             |   2 +-
 configs/warp7_defconfig                  |   2 +-
 doc/usage/cmd/cpu.rst                    | 101 +++++++
 doc/usage/index.rst                      |   1 +
 drivers/clk/imx/clk-imx8mm.c             |   8 +
 drivers/clk/imx/clk-imx8mn.c             |   8 +
 drivers/clk/imx/clk-imx8mp.c             |   8 +
 drivers/cpu/cpu-uclass.c                 |  10 +
 drivers/cpu/cpu_sandbox.c                |   6 +
 drivers/cpu/imx8_cpu.c                   |  38 ++-
 include/cpu.h                            |  15 +
 test/dm/cpu.c                            |   2 +
 24 files changed, 266 insertions(+), 511 deletions(-)
 delete mode 100644 arch/arm/dts/imx7s-warp.dts
 create mode 100644 doc/usage/cmd/cpu.rst
