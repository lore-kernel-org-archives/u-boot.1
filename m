Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEACE81DE0
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 11:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D365986EE9;
	Fri,  6 Oct 2023 13:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE93586EDF; Fri,  6 Oct 2023 13:26:36 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9FB86844
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 13:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 396BQQQj058284;
 Fri, 6 Oct 2023 19:26:26 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Fri, 6 Oct 2023 19:26:22 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH RESEND 4/7] riscv: dts: introduce SPL_LOAD_FIT_OPENSBI_OS_BOOT
 symbol
Date: Fri, 6 Oct 2023 19:23:48 +0800
Message-ID: <20231006112351.2275090-5-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006112351.2275090-1-randolph@andestech.com>
References: <20231006112351.2275090-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 396BQQQj058284
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

When SPL_OPENSBI_OS_BOOT is enabled, it will change the default FIT
configure file "binman.dtsi" to "binman_linux.dtsi"
Default is not enabled.

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ec1cfcaaa7..4f104789a7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -422,8 +422,17 @@ config TPL_USE_ARCH_MEMSET
 
 endmenu
 
+config SPL_LOAD_FIT_OPENSBI_OS_BOOT
+	bool "Enable SPL (OpenSBI OS boot mode) applying linux from FIT"
+	depends on SPL_LOAD_FIT
+	help
+	  Use fw_dynamic from the FIT image, and u-boot SPL will invoke it directly.
+	  This is a shortcut boot flow, from u-boot SPL -> OpenSBI -> u-boot proper
+	  -> linux to u-boot SPL -> OpenSBI -> linux.
+
 config SPL_LOAD_FIT_CONFIG
 	string "Default FIT configuration for SPL"
+	default "binman_linux.dtsi" if SPL_LOAD_FIT_OPENSBI_OS_BOOT
 	default "binman.dtsi"
 	depends on SPL_LOAD_FIT
 	help
-- 
2.34.1

