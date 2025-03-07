Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA17C282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 13:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A99E8122F;
	Fri,  7 Mar 2025 14:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="kM4KgFde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9A08056A; Fri,  7 Mar 2025 14:14:22 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 689CC80F0B
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 14:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 229B920275;
 Fri,  7 Mar 2025 14:14:20 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPs8zvXctFmV; Fri,  7 Mar 2025 14:14:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741353253; bh=mfYPONd67saktusVF0XaSwTn+JvsfC5mFUpTM/VsIgA=;
 h=From:To:Cc:Subject:Date;
 b=kM4KgFdeZQ/IPZc32/BQCUIY7imarCDrqEFNP3uJ+wCA3qY9+xfUBlcNxrNT2xOKO
 BlPNVCc2GHmVmxGaM0BSm6JUqi/CDHWfvEyaeKQdxEo/hqFHQ+h6+OOsNIbdJxi1Dp
 cGKo+sp6TKo/ywy5ndIGp7fFp/vJnRfkKIfn5FTg25wv2Tq9ZXmtXkrupxOjuGFokv
 ZL2aC3wKAGSR/WBqMYsc1sw90P2bK7+cFLPtPInkkz0x9PThks1femKRSPFVTG4Bh1
 OsvpZeK5J6IZFBqKb3mTbK4xXOyIDabR7luIyHTIEGD6uH78js3MpbjRrZwpyPfVbC
 R0PsOC+jUvXGQ==
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
Subject: [PATCH v2 0/4] Simplify retrieving FDT from SBI in S-Mode
Date: Fri,  7 Mar 2025 13:13:40 +0000
Message-ID: <20250307131344.43762-1-ziyao@disroot.org>
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
duplication.

Tested on
 - Milk-V Duo (milkv_duo_defconfig)
 - Starfive VisionFive 2 (starfive_visionfive2_defconfig)
 - QEMU VM (qemu-riscv64_smode_defconfig, sifive_unleashed_defconfig).

Changed from v1
- make the default implementation bail out in XPL stage
- correct commit message of sifive platform chagnes
- don't enable OF_HAS_PRIOR_STAGE by default on all SBI-capable RISC-V
  platforms, as it may break the binman configuration
- Link to v1: https://lore.kernel.org/u-boot/20250227144734.61458-1-ziyao@disroot.org/

Yao Zi (4):
  riscv: lib: Add a default implementation of board_fdt_blob_setup
  board: qemu: riscv: Remove duplicated board_fdt_blob_setup
  board: starfive: Remove duplicated board_fdt_blob_setup
  board: sifive: Remove dead board_fdt_blob_setup

 arch/riscv/lib/Makefile                       |  1 +
 arch/riscv/lib/board.c                        | 19 +++++++++++++++++++
 board/emulation/qemu-riscv/qemu-riscv.c       |  8 --------
 board/sifive/unleashed/unleashed.c            | 11 -----------
 board/sifive/unmatched/unmatched.c            | 10 ----------
 .../visionfive2/starfive_visionfive2.c        | 10 ----------
 6 files changed, 20 insertions(+), 39 deletions(-)
 create mode 100644 arch/riscv/lib/board.c

-- 
2.48.1

