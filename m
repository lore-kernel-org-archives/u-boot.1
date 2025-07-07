Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5171AC83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 12:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F7182F6D;
	Mon,  7 Jul 2025 14:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UMMu+bwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDF4830E4; Mon,  7 Jul 2025 14:51:48 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39747826AA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 14:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4A424A53F78;
 Mon,  7 Jul 2025 12:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1818C4CEF4;
 Mon,  7 Jul 2025 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751892705;
 bh=/eD+otp8HmuJxDOHsV2WAdfB+cqUPiSm06gm7A8MnZE=;
 h=From:To:Cc:Subject:Date:From;
 b=UMMu+bwk4BSv3q4NzUm8P10Bfx5M2hUnhX+A2bUufy0HBN+QwsuUcY7+jDAf5n/t8
 Py30RGa5c3yVF8APtTQL8qON/iYVMtzKsTzLCBzaN5BwtUPZEz4UymYqn9Hh8KgQ7o
 gmG96ejGxf/54xr7bF3iLTt4BulYr7NU30SKjZNCeZvuRK+De3devOAGWgTs/nfPAm
 5tJb0bK5nirgC4GJrBUyJm/ymWHwmo1FJ3MYOeW17SeqQacp1ZuzY158wCzM952cpP
 0+U1NgAF0yuoZ4M9643KFQA4uAJq+AnSCED3Epswoifh+UTPMIQp7A8OV1N4zr08gK
 HH0ayfV6DtolA==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH v1] configs: microchip_mpfs_icicle: disable DEBUG_UART
Date: Mon,  7 Jul 2025 13:51:39 +0100
Message-ID: <20250707125140.935234-1-conor@kernel.org>
X-Mailer: git-send-email 2.45.2
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

From: Conor Dooley <conor.dooley@microchip.com>

By default DEBUG_UART uses the SBI DBCN extension on S-Mode RISC-V
platforms, but the Icicle Kit's firmware doesn't support it. Since
DEBUG_UART is getting turned on automagically and this is somewhat
misleading, disable it in the Icicle kit's defconfig.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Tom Rini <trini@konsulko.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>
CC: u-boot@lists.denx.de
---
 configs/microchip_mpfs_icicle_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/microchip_mpfs_icicle_defconfig b/configs/microchip_mpfs_icicle_defconfig
index bb110225488..6937aa224a1 100644
--- a/configs/microchip_mpfs_icicle_defconfig
+++ b/configs/microchip_mpfs_icicle_defconfig
@@ -7,6 +7,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-icicle-kit"
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SYS_MEM_TOP_HIDE=0x400000
+# CONFIG_DEBUG_UART is not set
 CONFIG_TARGET_MICROCHIP_ICICLE=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
-- 
2.45.2

