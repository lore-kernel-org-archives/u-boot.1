Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3686CC1B0FF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949A080FE2;
	Thu, 27 Feb 2025 15:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Yvv68o6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0607880FF0; Thu, 27 Feb 2025 15:48:08 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59B4080FE1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id F36C325A2E;
 Thu, 27 Feb 2025 15:48:03 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2xntU7MJ32U; Thu, 27 Feb 2025 15:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740667683; bh=db4m0pJPY8qSa/us4h+V5YwvWC7Q//zKpHO79NXLPpc=;
 h=From:To:Cc:Subject:Date;
 b=Yvv68o6FoZ3naemMlv3PLT8TAuiKXTZNOa7H2IfPptvLb4km/MavlupwnB6vfli+J
 PX1wpn/D6it/JN5MAGb0itm3wEVvLie4QvcCRhVKcLoUydmpTIpkukVWLxGIjEGTIF
 p6jbP1sPQDaJskA3MoVu5rSvu+DNRwFDBxk/tXvPsBtDB1UtfnA6oRouO9qSe0hqra
 jAnuXKiZTvE3twPuQxb9aLr4DfJOCvU+UJCYwPjtxE+TtQ7Mm5o6gccBHdze0ijbom
 t7Y0fZvkTs6J2hXumOZWorf805Ul/PGvpb/0iuyOGaAzm9w0FH/PjqmrrKVPo+jKc9
 GGEovzmng6GNA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/5] Simplifiy retrieving FDT from SBI in S-Mode
Date: Thu, 27 Feb 2025 14:47:28 +0000
Message-ID: <20250227144734.61458-1-ziyao@disroot.org>
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

A typical bootflow of S-Mode RISC-V U-Boot looks like,

  -------    -------    ----------
  | SPL | -> | SBI | -> | U-Boot |
  -------    -------    ----------
                |
     M-Mode     |       S-Mode
                |

Both the most popular SBI implementation, OpenSBI, and U-Boot require a
FDT to function. The common solution is to pick an appropriate
devicetree at SPL stage and pass it to OpenSBI, which is also capable of
passing its (possibly modified) devicetree to the next stage (proper
U-Boot here) program.

The problem is although we retrieve the FDT passed by SBI in RISC-V's
start.S, a custom board_fdt_blob_setup is still required to make use of
it, resulting in duplicated similar functions in board-level code.

This series provides a weak version of board_fdt_blob_setup to setup the
SBI-passed FDT, serving as fallback on RISC-V platforms to eliminate the
duplication. We also select OF_HAS_PRIOR_STAGE by default on RISC-V
platforms if SBI is enabled, which is the usual configuration.

Tested on
 - Milk-V Duo (milkv_duo_defconfig)
 - Starfive VisionFive 2 (starfive_visionfive2_defconfig)
 - QEMU VM (qemu-riscv64_smode_defconfig).

Yao Zi (5):
  riscv: lib: Add a default implementation of board_fdt_blob_setup
  board: qemu: riscv: Remove duplicated board_fdt_blob_setup
  board: starfive: Remove duplicated board_fdt_blob_setup
  board: sifive: Remove duplicated board_fdt_blob_setup
  riscv: select OF_HAS_PRIOR_STAGE by default if SBI is enabled

 arch/riscv/Kconfig                            |  1 +
 arch/riscv/lib/Makefile                       |  1 +
 arch/riscv/lib/board.c                        | 19 +++++++++++++++++++
 board/emulation/qemu-riscv/qemu-riscv.c       |  8 --------
 board/sifive/unleashed/unleashed.c            | 11 -----------
 board/sifive/unmatched/unmatched.c            | 10 ----------
 .../visionfive2/starfive_visionfive2.c        | 10 ----------
 7 files changed, 21 insertions(+), 39 deletions(-)
 create mode 100644 arch/riscv/lib/board.c

-- 
2.48.1

