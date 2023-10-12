Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0286CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B441986CE8;
	Thu, 12 Oct 2023 08:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092FB86E39; Thu, 12 Oct 2023 08:38:11 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5ED686D21
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39C6buEl019899;
 Thu, 12 Oct 2023 14:37:56 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 12 Oct 2023 14:37:52 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH V2 2/7] riscv: kconfig: introduce SPL_LOAD_FIT_OPENSBI_OS_BOOT
 symbol
Date: Thu, 12 Oct 2023 14:35:04 +0800
Message-ID: <20231012063509.2963258-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012063509.2963258-1-randolph@andestech.com>
References: <20231012063509.2963258-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39C6buEl019899
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

Introduce common Kconfig symbol for riscv architecture.
This symbol SPL_LOAD_FIT_OPENSBI_OS_BOOT is like falcon mode on ARM,
the Falcon boot is a shortcut boot method for SD/eMMC targets. It
skips the loading the RAM version U-Boot. Instead, it will loads
the FIT image and boots directly to Linux.

When SPL_OPENSBI_OS_BOOT is enabled, linux.itb is created after
compilation instead of the default u-boot.itb. It initialises memory
with the U-Boot SPL at the first stage, just as a normal boot process
does at the beginning. Instead of jumping to the U-Boot proper from
OpenSBI before booting the Linux kernel, the RISC-V falcon mode
process jumps directly to the Linux kernel to gain shorter booting time.

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 183885ebe7..49b6e1a4d6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -424,4 +424,12 @@ config TPL_USE_ARCH_MEMSET
 
 endmenu
 
+config SPL_LOAD_FIT_OPENSBI_OS_BOOT
+	bool "Enable SPL (OpenSBI OS boot mode) applying linux from FIT"
+	depends on SPL_LOAD_FIT
+	help
+	  Use fw_dynamic from the FIT image, and u-boot SPL will invoke it directly.
+	  This is a shortcut boot flow, from u-boot SPL -> OpenSBI -> u-boot proper
+	  -> linux to u-boot SPL -> OpenSBI -> linux.
+
 endmenu
-- 
2.34.1

