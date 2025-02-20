Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41C4C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 10:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5221B801BE;
	Thu, 20 Feb 2025 11:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="icKJbDup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4086A801DE; Thu, 20 Feb 2025 11:32:22 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69D088007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1076725CA1;
 Thu, 20 Feb 2025 11:32:18 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x7SItaTCqf8v; Thu, 20 Feb 2025 11:32:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740047533; bh=FYPZ/Dpo+7qp4AZRAXXD7zT7W6kRW8nV6MHgFCNSlkk=;
 h=From:To:Cc:Subject:Date;
 b=icKJbDupImuMPBZP6VlaWE9zSSOLKCh0Tir4/tn0E/MM5qpl2oW74BIjry2dKUnk+
 lLip/OoRD/uhNBvQjLXXx5pm2ZxSqpnR0Ds/kCoIthhBYiZ42bifYU2uuFFtRL/lBa
 1CAV8dZY2aNnaNCkeM+AIliPJdiVi76qzZ0a8Q84PZgflmpbbQHQz+WMPL2UXoTo4Y
 bn/L7VlE7R9IFpQSig08FBxBD67reQnN4dxL9Z2yL7cJFiJ5Z/fQmkqA2BanxR3EZF
 DcBjPPnUvj1giKM6uA3dzrhI+fclgD6RQU/KXjoj/H7cRihdan28uDR1KipdmBUCKy
 EOQXqSf0/D3gw==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH] riscv: timer: Add thead,c900-clint compatible
Date: Thu, 20 Feb 2025 10:31:53 +0000
Message-ID: <20250220103153.10768-1-ziyao@disroot.org>
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

Current implementation of riscv_timer.c only assumes readable TIMER CSRs
present (IOW, Zicntr extension is available). Core Local Interruptors
(CLINT) found on T-Head C9xx cores expose its mtime register through
TIME CSR directly instead of a MMIO register, thus is compatible with
the driver.

As running in S-Mode isn't necessary for the driver to operate, Kconfig
and comments are also adapted to avoid confusion.

Reference: https://github.com/riscv-software-src/opensbi/commit/ca7810aecdba
Signed-off-by: Yao Zi <ziyao@disroot.org>
---

This is necessary for several platforms based on T-Head C9xx to get
system ticks, e.g. TH1520, K230 and CV1800. Tested on
th1520-lichee-pi-4a in both M-mode and S-mode (with mainline OpenSBI).

 drivers/timer/Kconfig       | 4 ++--
 drivers/timer/riscv_timer.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index cb6fc0e7fda..00c4067a23b 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -241,8 +241,8 @@ config RISCV_TIMER
 	bool "RISC-V timer support"
 	depends on TIMER && RISCV
 	help
-	  Select this to enable support for a generic RISC-V S-Mode timer
-	  driver.
+	  Select this to enable support for a generic timer driver based
+	  on RISC-V TIMER CSR.
 
 config ROCKCHIP_TIMER
 	bool "Rockchip timer support"
diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
index 1f4980ceb38..3e6f0cd6d11 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -7,7 +7,7 @@
  *
  * RISC-V architecturally-defined generic timer driver
  *
- * This driver provides generic timer support for S-mode U-Boot.
+ * This driver provides generic timer support through TIME CSR for U-Boot.
  */
 
 #include <config.h>
@@ -106,6 +106,7 @@ static const struct timer_ops riscv_timer_ops = {
 
 static const struct udevice_id riscv_timer_ids[] = {
 	{ .compatible = "riscv,timer", },
+	{ .compatible = "thead,c900-clint" },
 	{ }
 };
 
-- 
2.48.1

