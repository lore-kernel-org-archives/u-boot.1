Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ADCD41D64
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334E483A79;
	Thu, 11 Dec 2025 17:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZXsuYyyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD3EB8334F; Thu, 11 Dec 2025 17:35:11 +0100 (CET)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92EB830E4
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202512111634592b39723b0600020770 for <u-boot@lists.denx.de>;
 Thu, 11 Dec 2025 17:35:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vaqfEyHhPFWrczaDxQ2siaq8P+e3nGetzgAfbveMN3c=;
 b=ZXsuYyyLSXhLbTL/Om0TQ7MEalmhP0Y6zSO4CndiYEI8XiYy8Maa0kPm/VEVn8iuiAMxiP
 Mwt/pem1WNaV/6t7btBav4A0FE87bTi/6j1GkyCF7oaKfdKr5zLju7L2Q4GYcLbgA+wBBpsB
 Zh4QQ/wPcl03c2Sp4YbCBQ/MJ8oj0ZjIKESChD+AYC4CRKn6XT11OR57ff3RkZ+wvFqWzryP
 zi7s0MM4zQAXAMUvSNM2IiM8lzktxq8uFwZU6LS0IobI8baT7SgdfogxhWsmrUURrGBRGvw0
 58sRv/AeyIZxp/fHsmT1tMQBM05iu7aQAFtpErgp35a6Nsh7/DPP5CRA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v3 0/5] Fixes for
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION* and for SOCFPGA
Date: Thu, 11 Dec 2025 17:34:54 +0100
Message-ID: <cover.1765470899.git.jan.kiszka@siemens.com>
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

Changes in v3:
 - improve commit message of patch 2
 - fix #ifdef condition in patch 4

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

