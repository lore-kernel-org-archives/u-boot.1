Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42834CE8D5F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D4B841E7;
	Fri, 14 Nov 2025 18:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="BQTaVQjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9A2842C9; Fri, 14 Nov 2025 18:13:46 +0100 (CET)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D0184277
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20251114171343fb2305394100020773 for <u-boot@lists.denx.de>;
 Fri, 14 Nov 2025 18:13:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=h02BlDQ5cMNRPuZdnzhVwIoO5RavaBsBKNWHkvODayw=;
 b=BQTaVQjnZ8cPKyqIkawlAUabKkzCW0O00DZwdCzC9MgdVWhZqtaWY3Itoqak4urB4EhpfK
 4y3pvKA6ThLOCOai8K7NZleusXaTXhIcL6kTHZ/Zb5rB9RHMT2zQjyn+g9k7YghKiEvoQhKy
 ut+5/vvDD90NgnJT/mseu8Y7x5nvfVE0Xvs4P9Zizmlx37qebjzF/etaTU7rlBKkhygrm07F
 /PDpHHvWZbzxhFz/EdTRdbbbLNUIe4FQVA7sg8EVp2XCD/W+tcZzi//5AGfsEuLanjLPgGHd
 cSUzpbe9Qb/50yaLbNeYg5dzkOkj6EcJbaJqIqLLKyXDSo5KFvaqyw6A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/4] configs: socfpga: Fix de0_nano_soc boot
Date: Fri, 14 Nov 2025 18:13:41 +0100
Message-ID: <83005ee01e6a9f7ec5a1bb261912bd7d49d4d6b6.1763140421.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763140421.git.jan.kiszka@siemens.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

By default, the de0_nano_soc used raw sectors, but the address became
invalid due the raw-mode refactorings. With loading via partition type
fixed, we can switch to that mode which is in line with what the ROM
loader does.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configs/socfpga_de0_nano_soc_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
index 32cdf6d3a6c..6564cbd03c6 100644
--- a/configs/socfpga_de0_nano_soc_defconfig
+++ b/configs/socfpga_de0_nano_soc_defconfig
@@ -28,6 +28,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_MAXARGS=32
-- 
2.51.0

