Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D88CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0668056B;
	Fri, 12 Jun 2026 14:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DWofL5Xo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61BE1847B0; Fri, 12 Jun 2026 07:41:28 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB399839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 07:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+takahiro.kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B31342BAC;
 Fri, 12 Jun 2026 05:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECED6C2BCC7;
 Fri, 12 Jun 2026 05:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781242884;
 bh=nPeaQ/w4gli8eyPGqdr8Q7Io5FfTru8yYfswKb9bkI8=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=DWofL5XoLLUiRdvltha7gg3lTzIj4v8u1H3HnI/TALRE4VdURD5/tT9c237MXbgDY
 lNCWdvmJyaWriWK368FnG9+Uapfmdzm3YcJD30BaluWrpqoXNrB+oyJaClpWA/wnHv
 dkYKg7X8y/++N4NkB6XITagKuFpclVAWoxzitRw3r6azZlxmBIvIjAp/OBrTeYUpWp
 W/MpCmvAi0TaxoHoHWOsxZhiUTyfpGWD4f/yUN0N41sQ+/Qsu0c1o8oTrKro0dsv1s
 ORiGK+dFmh72lwLstMCvh+GYcYGvF93fDek2Tfjjnvsl1Y83AntI41u6whF0TDVG9I
 uqFOrjCnd1fmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D4CC5CD8C9D;
 Fri, 12 Jun 2026 05:41:23 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Subject: [PATCH 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Date: Fri, 12 Jun 2026 14:40:48 +0900
Message-Id: <20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOGbK2oC/yWNQQqDMBBFryKzdiCNNEKvUlzEOGlHQiKZVAri3
 Tttl+99eP8AocokcOsOqLSzcMkKl76D8PT5QciLMlhjnXHGomyJm0psfk665lZwp7yUipETCY7
 RDeYawkDWg2a2SpHfv4v79Gd5zSuF9u3CeX4A/RcXJIQAAAA=
X-Change-ID: 20260602-split-id-table-into-vendor-files-7f6305cc3e2a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Michael Walle <mwalle@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@nabladev.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781242882; l=2794;
 i=takahiro.kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=nPeaQ/w4gli8eyPGqdr8Q7Io5FfTru8yYfswKb9bkI8=;
 b=1fwfYRdmO07ZO34V/z5ZfMitcV3Ur7XNgId1xRmDNddd8eC264PK+TIHtN+fGLqWiOCOsa8o/
 wLgPy51HPICDL6KedBlglfqrgLn0XkoP3j7aUX8pepUTV6OoCmSyCFW
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for takahiro.kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:35:35 +0200
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
Reply-To: takahiro.kuwano@infineon.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The spi-nor-core.c contains optional logics like SFDP and manufcaturer
specific fixups. The spi-nor-ids.c has single large ID database. There
are many #ifdef directives in those files and that negatively affects
readability and maintainability.

This series, as the first step of cleanup, move SFDP logic, IDs, and
fixups to newly source files. Reworking, renaming, and reformating
existing code is not a scope of this series and further cleanup will be
taken place in follow-up patches.

Here is the code size impact when applying this series.
Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
manufcaturers are enabled.

SPI-NOR:
            text    data     bss     dec     hex filename
BEFORE    726289   14084       0  740373   b4c15 u-boot
AFTER     727465   14084       0  741549   b50ad u-boot
DELTA      +1176       0       0

TINY:
            text    data     bss     dec     hex filename
BEFORE     77286    3160     248   80694   13b36 spl/u-boot-spl
AFTER      77542    3160     248   81086   13cbe spl/u-boot-spl
DELTA       +256

Signed-off-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
---
Takahiro Kuwano (4):
      mtd: spi-nor: move SFDP logic out of the core
      mtd: spi-nor: import manufacturer driver concept from Linux
      mtd: spi-nor: move flash info entries to manufacturer drivers
      mtd: spi-nor: move fixups to manufacturer drivers

 drivers/mtd/spi/Makefile        |   19 +
 drivers/mtd/spi/atmel.c         |   28 +
 drivers/mtd/spi/dosilicon.c     |   25 +
 drivers/mtd/spi/eon.c           |   23 +
 drivers/mtd/spi/fujitsu.c       |   27 +
 drivers/mtd/spi/gigadevice.c    |  136 ++
 drivers/mtd/spi/issi.c          |   84 ++
 drivers/mtd/spi/macronix.c      |  154 +++
 drivers/mtd/spi/micron-st.c     |  169 +++
 drivers/mtd/spi/puya.c          |   56 +
 drivers/mtd/spi/sf_internal.h   |  135 +-
 drivers/mtd/spi/sfdp.c          |  720 ++++++++++
 drivers/mtd/spi/sfdp.h          |  152 +++
 drivers/mtd/spi/siliconkaiser.c |   18 +
 drivers/mtd/spi/spansion.c      |  700 ++++++++++
 drivers/mtd/spi/spi-nor-core.c  | 2751 +++++++--------------------------------
 drivers/mtd/spi/spi-nor-ids.c   |  747 +----------
 drivers/mtd/spi/spi-nor-tiny.c  |   11 +-
 drivers/mtd/spi/sst.c           |   34 +
 drivers/mtd/spi/winbond.c       |  250 ++++
 drivers/mtd/spi/xmc.c           |   26 +
 drivers/mtd/spi/xtx.c           |   54 +
 drivers/mtd/spi/zbit.c          |   19 +
 include/linux/mtd/spi-nor.h     |    2 +
 24 files changed, 3374 insertions(+), 2966 deletions(-)
---
base-commit: 2d64a16d2558276fc8095ef2fae131829892d0f3
change-id: 20260602-split-id-table-into-vendor-files-7f6305cc3e2a

Best regards,
--  
Takahiro Kuwano <takahiro.kuwano@infineon.com>


