Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD94CE8D5F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B3E842A1;
	Fri, 14 Nov 2025 18:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="MxFTgIbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47448429E; Fri, 14 Nov 2025 18:13:44 +0100 (CET)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85B08419A
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20251114171342b7f22352080002074c for <u-boot@lists.denx.de>;
 Fri, 14 Nov 2025 18:13:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BpQ9pXFoM4P3yzEz8UYP5oFIuiKAmt19GTEXGH4ZqSI=;
 b=MxFTgIbRV2T/9+r3KBe62jtvMP8OLekZmDrhinvTtlwGkFeNqnuAgy3zbR2Hr39aZbRVbD
 QqwT5Q5Y4bQp0BSe9+FoxjPcC6j8Af0Im68lggf//SH67i/gUmpz/JJhWEJeCVLf0FFBvG7U
 kULbKRLRr7qvNu3tMJi/H3ybYfHvTMBypPPFCXwGroP3OEWLhTsDbBERUzikXfpyIb52xzjp
 cZh2W329nBi4WrdOP7h5xZ05sHlfdI9AmRIYNysptNzT40/ArRo9M3mKfplCqAKZku/YAq9r
 1qOiPWzOsN6JhzLOEesnLJdH36rPqpv3gtxzQx2nYP9Dwwb5DnfpVhwQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/4] Fixes for CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
 and for SOCFPGA
Date: Fri, 14 Nov 2025 18:13:37 +0100
Message-ID: <cover.1763140421.git.jan.kiszka@siemens.com>
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

Several fixes needed after the mmc raw-mode was consolidated a while
ago. Not all the fallouts can be blamed to that refactoring. It also
looks to me like booting from mmc just worked by chance before.

This series now permits U-Boot proper loading from SPL via partition
type, at least on the DE0-Nano-SoC (other boards not available for
testing).

Jan

Jan Kiszka (4):
  spl: mmc: Respect sector value passed to mmc_load_image_raw_partition
  spl: mmc: Account for SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
    being a choice
  arch: arm: mach-socfpga: Adjust a raw sectors for MMC loading of
    U-Boot from SPL
  configs: socfpga: Fix de0_nano_soc boot

 arch/arm/mach-socfpga/board.c          |  9 +++++++++
 common/spl/Kconfig                     |  1 +
 common/spl/spl_mmc.c                   | 20 ++++++++------------
 configs/socfpga_de0_nano_soc_defconfig |  1 +
 include/part.h                         |  3 ++-
 5 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.51.0

