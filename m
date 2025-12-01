Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA60D116E2
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 07:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92944839B7;
	Mon,  1 Dec 2025 08:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="pd6eUDnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3777B83979; Mon,  1 Dec 2025 08:32:54 +0100 (CET)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09B48394E
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 08:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20251201073249eb71de648b000207a3 for <u-boot@lists.denx.de>;
 Mon, 01 Dec 2025 08:32:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vh6eVrdXPrzeHxjURAyMNgxNjR66E5Qoh74C7+Zb2fQ=;
 b=pd6eUDntYAkBUUoHDqizpCnYZXsEY5tMVDmBuR9GhhSZNbohAh/cfP98Plmep0/AMX5qlw
 eMu1zL7ObgZDqLuC8AR9I8wnyArxKTTNZQINYGTzIR3T56/eXkb96+Fpkq04JWNW1MV9zlb3
 U9u0Ur4a1c9jmJBsvMtXxINynXAOBW/OceRHNJKQXdZy+/f/3I8ECa40S3Y0mopGiPJT8kTq
 bWTLs3spvpLo+t6JDnvoiUD9dMU3/u+TvaLBK0l0r/Adxz7qPSIN0hq7zmbmK2JbeqVqC83Q
 c3Kqn1EtQGaY1n/EmmsBmZDbLOYxAn+LQcHnzwlngW8fqePlVzBaKR1w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>
Subject: [PATCH v2 0/5] Fixes for
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION* and for SOCFPGA
Date: Mon,  1 Dec 2025 08:32:44 +0100
Message-ID: <cover.1764574369.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

Changes in v2:
 - split off "select SPL_LOAD_BLOCK" change
 - address build breakage with CONFIG_SPL_SYS_MMCSD_RAW_MODE off
 - fix build condition and add comment to mach-socfpga/board.c patch

Several fixes needed after the mmc raw-mode was consolidated a while
ago. Not all the fallouts can be blamed to that refactoring. It also
looks to me like booting from mmc just worked by chance before.

This series now permits U-Boot proper loading from SPL via partition
type, at least on the DE0-Nano-SoC (other boards not available for
testing).

Note that even if the socfpga specific changes should not be accepted
due to switching to fat mode booting, the first two patches are
generic fixes, affecting all RAW_MODE_U_BOOT_USE_PARTITION_TYPE user -
of which we have none in-tree, though.

Jan

Jan Kiszka (5):
  spl: Kconfig: Add missing SPL_LOAD_BLOCK for
    SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
  spl: mmc: Account for SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
    being a choice
  spl: mmc: Respect sector value passed to mmc_load_image_raw_partition
  arch: arm: mach-socfpga: Adjust a raw sectors for MMC loading of
    U-Boot from SPL
  configs: socfpga: Fix de0_nano_soc boot

 arch/arm/mach-socfpga/board.c          | 11 +++++++++++
 common/spl/Kconfig                     |  1 +
 common/spl/spl_mmc.c                   | 21 +++++++++------------
 configs/socfpga_de0_nano_soc_defconfig |  1 +
 include/part.h                         |  3 ++-
 5 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.51.0

