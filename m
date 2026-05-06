Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589D4CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659A8848A1;
	Wed,  6 May 2026 14:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UKYdrJJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251B7848A1; Wed,  6 May 2026 14:36:02 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB57C848BC
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FEF960103;
 Wed,  6 May 2026 12:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7B7C2BCC4;
 Wed,  6 May 2026 12:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070958;
 bh=4V28DwE44FdMXc76T54UDs5c47xAvux45jGfM+/Tpl4=;
 h=From:To:Cc:Subject:Date:From;
 b=UKYdrJJf7TdvEpVdWMu/VPadDH7WZRcnCu/FHApSKdYcw5iJ7/Ez4xnaH88AEYxD2
 gt/H1EWMmMI9ccEUBb1MKmVp69lqHNtzOqDMPZ8h98/KoXUsiXYAnrcu/lpVltXDZC
 egc8WHvx5vR7sXCI6AQr474iQLQsN/tfy+UAwG0lB7jdnKwWNnGTLh3k3U1wA5ExpK
 j0rr/avfYMnohyNWPmwd7ybm3WWj+RDVuNTqbW6071oECQg3lwfp6fDvAyuauTELH7
 unTJso2Py5WeMLpbrO9jm3kzGeIHf9k4vLrS+x/s6LAJIXz/zOCbwkxxXjWK/ej0z0
 /eNUGePXTNyAw==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 00/11] Generic powerpc fixes and NXP board cleanup
Date: Wed,  6 May 2026 14:34:09 +0200
Message-ID: <20260506123507.2081751-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
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

While working on an ancient P2041 based board, I've encountered
several issues.

cpu_init_r wasn't called anymore, but u-boot was still somehow
working. CAAM was reading/writing on address 0 because pamu_init()
is never called if secure boot isn't enabled.

Since legacy ethernet was removed, board_eth_init() and
fdt_fixup_board_enet() won't be called anymore, but the functions
are still defined. I've just removed the ones for the NXP boards,
though I think the code there did something useful. But given that
it wasn't called for two years now and nobody complained, it can't
be that important.

Lastly, because I have a p2041rdb, move that to a upstream DTS.
Keep in mind, that the uboot dts doesn't define an UART, so any
output was broken since the move to DM provided serial support.

v2:
 - new patch
   p2041rdb: convert README to rst
 - fix build errors, tested all commits with buildman

Michael Walle (11):
  powerpc: fix call to cpu_init_r
  caam: don't write memory at 0 on PPC
  spi: fsl_espi: fix read transactions
  boards: remove dead fman code
  boards/nxp: remove board_eth_init()
  boards/nxp: remove empty fdt_fixup_board_enet()
  p2041rdb: use the upstream device tree
  p2041rdb: support SDcard boot
  p2041rdb: update README and fix typos
  p2041rdb: remove NAND defconfig
  p2041rdb: convert README to rst

 arch/powerpc/cpu/mpc85xx/cpu_init.c           |   6 +-
 arch/powerpc/dts/Makefile                     |   1 -
 arch/powerpc/dts/p2041.dtsi                   | 138 ----
 arch/powerpc/dts/p2041rdb-u-boot.dtsi         |  19 +
 arch/powerpc/dts/p2041rdb.dts                 | 127 ---
 arch/powerpc/dts/p2041si-post.dtsi            |  43 --
 board/nxp/ls1012afrdm/eth.c                   |  10 -
 board/nxp/ls1012ardb/eth.c                    |  12 -
 board/nxp/ls1021atsn/ls1021atsn.c             |   5 -
 board/nxp/ls1021atwr/ls1021atwr.c             |   5 -
 board/nxp/ls1028a/ls1028a.c                   |   5 -
 board/nxp/ls1043aqds/Makefile                 |   3 -
 board/nxp/ls1043aqds/eth.c                    | 501 ------------
 board/nxp/ls1043aqds/ls1043aqds.c             |   4 -
 board/nxp/ls1043ardb/Makefile                 |   1 -
 board/nxp/ls1043ardb/eth.c                    |  77 --
 board/nxp/ls1046afrwy/eth.c                   |  57 --
 board/nxp/ls1046aqds/Makefile                 |   3 -
 board/nxp/ls1046aqds/eth.c                    | 431 -----------
 board/nxp/ls1046aqds/ls1046aqds.c             |   4 -
 board/nxp/ls1046ardb/eth.c                    |  71 --
 board/nxp/ls2080ardb/eth_ls2080rdb.c          |  19 -
 board/nxp/lx2160a/eth_lx2160aqds.c            |  18 -
 board/nxp/lx2160a/eth_lx2160ardb.c            |  17 -
 board/nxp/lx2160a/eth_lx2162aqds.c            |  18 -
 board/nxp/m5253demo/m5253demo.c               |   7 -
 board/nxp/mx6sxsabreauto/mx6sxsabreauto.c     |  52 --
 board/nxp/mx6sxsabresd/mx6sxsabresd.c         |  78 --
 board/nxp/p2041rdb/Makefile                   |   1 -
 board/nxp/p2041rdb/README                     | 138 ----
 board/nxp/p2041rdb/README.rst                 | 147 ++++
 board/nxp/p2041rdb/eth.c                      | 210 -----
 board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg        |  11 +
 ...{rcw_p2041rdb.cfg => p2041rdb_rcw_spi.cfg} |   0
 board/nxp/t102xrdb/Makefile                   |   1 -
 board/nxp/t102xrdb/eth_t102xrdb.c             | 149 ----
 board/nxp/t102xrdb/t102xrdb.c                 |   1 -
 board/nxp/t102xrdb/t102xrdb.h                 |   1 -
 board/nxp/t104xrdb/Makefile                   |   1 -
 board/nxp/t104xrdb/eth.c                      |  91 ---
 board/nxp/t104xrdb/t104xrdb.h                 |   1 -
 board/nxp/t208xqds/Makefile                   |   2 +-
 board/nxp/t208xqds/eth_t208xqds.c             | 723 ------------------
 board/nxp/t208xqds/t208xqds.c                 |   1 -
 board/nxp/t208xqds/t208xqds.h                 |   1 -
 board/nxp/t208xrdb/eth_t208xrdb.c             |   5 -
 board/nxp/t208xrdb/t208xrdb.c                 |   1 -
 board/nxp/t208xrdb/t208xrdb.h                 |   1 -
 board/nxp/t4rdb/Makefile                      |   1 -
 board/nxp/t4rdb/eth.c                         | 152 ----
 board/nxp/t4rdb/t4240rdb.c                    |   1 -
 board/nxp/t4rdb/t4rdb.h                       |   1 -
 common/board_r.c                              |   2 +-
 configs/P2041RDB_NAND_defconfig               | 117 ---
 configs/P2041RDB_SDCARD_defconfig             |   6 +-
 configs/P2041RDB_SPIFLASH_defconfig           |   6 +-
 configs/P2041RDB_defconfig                    |   4 +-
 drivers/spi/fsl_espi.c                        |   6 +-
 include/configs/P2041RDB.h                    |   2 +
 59 files changed, 200 insertions(+), 3316 deletions(-)
 delete mode 100644 arch/powerpc/dts/p2041.dtsi
 create mode 100644 arch/powerpc/dts/p2041rdb-u-boot.dtsi
 delete mode 100644 arch/powerpc/dts/p2041rdb.dts
 delete mode 100644 arch/powerpc/dts/p2041si-post.dtsi
 delete mode 100644 board/nxp/ls1043aqds/eth.c
 delete mode 100644 board/nxp/ls1043ardb/eth.c
 delete mode 100644 board/nxp/ls1046aqds/eth.c
 delete mode 100644 board/nxp/p2041rdb/README
 create mode 100644 board/nxp/p2041rdb/README.rst
 delete mode 100644 board/nxp/p2041rdb/eth.c
 create mode 100644 board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg
 rename board/nxp/p2041rdb/{rcw_p2041rdb.cfg => p2041rdb_rcw_spi.cfg} (100%)
 delete mode 100644 board/nxp/t102xrdb/eth_t102xrdb.c
 delete mode 100644 board/nxp/t104xrdb/eth.c
 delete mode 100644 board/nxp/t208xqds/eth_t208xqds.c
 delete mode 100644 board/nxp/t4rdb/eth.c
 delete mode 100644 configs/P2041RDB_NAND_defconfig

-- 
2.47.3

