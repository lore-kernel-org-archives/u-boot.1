Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD37C36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729DE82E66;
	Mon,  7 Apr 2025 19:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D5982F67; Mon,  7 Apr 2025 19:05:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 85A2082CF5
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A62106F;
 Mon,  7 Apr 2025 10:05:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.17.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 524953F59E;
 Mon,  7 Apr 2025 10:05:45 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] fix dfu alt buffer clearing
Date: Mon,  7 Apr 2025 19:05:24 +0200
Message-ID: <20250407170529.893307-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi,

This patch series applies the same fix in five different locations (the
detailed description of the fix is in the patches).

I did validate statically by looking at the assembly before/after for all
five cases, using the following defconfigs:

  stm32mp15_defconfig
  synquacer_developerbox_defconfig
  xilinx_versal_virt_defconfig
  xilinx_zynq_virt_defconfig
  xilinx_zynqmp_kria_defconfig

Best regards,
Vincent.


Vincent Stehlé (5):
  fwu: developerbox: fix dfu alt buffer clearing
  board: st: common: fix dfu alt buffer clearing
  arm64: versal: fix dfu alt buffer clearing
  xilinx: zynq: fix dfu alt buffer clearing
  arm64: zynqmp: fix dfu alt buffer clearing

 board/socionext/developerbox/fwu_plat.c | 2 +-
 board/st/common/stm32mp_dfu.c           | 2 +-
 board/xilinx/versal/board.c             | 2 +-
 board/xilinx/zynq/board.c               | 2 +-
 board/xilinx/zynqmp/zynqmp.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.47.2

