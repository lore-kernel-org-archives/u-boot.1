Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8DFE88D86
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 06:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB3B84154;
	Sat,  4 Apr 2026 08:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="sKW/Nq7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F878407E; Sat,  4 Apr 2026 01:19:38 +0200 (CEST)
Received: from mxd-3-715.seznam.cz (mxd-3-715.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA2984106
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 01:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-lgzgl
 (smtpc-mxd-7644845457-lgzgl [2a02:598:96:8a00::1200:715])
 id 4f5cc2c2145296ab4ef50e9c; Sat, 04 Apr 2026 01:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775258329; bh=p1cSHdBsnlMgeKcwxyPOFzchwk4SqNmAI+8sHa9bFEo=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=sKW/Nq7eeRzFHJTGsWU0XG+FJvQPw2f8LsYdGTzq/5I7R8cdeQfPjJfav+rvopEn7
 iBRPWfrPAY9NdXhZf5J0RQMab905RFTcWtJDpIEHzK/SCs3OTYN8P80OXUbEQEjUiD
 LF+2O7QGTe53RTuG1HA/EvZNZWtMJT1KpkrpPszJFGRkUHYCw3SLy33++voOu0KOh8
 RHXgYhrqwD+O8XcJBxoHLsuJJZLX5cww/I8Jjqzq+sIKTINuXiOUTFc3QOul02Tux3
 3KBdix1595oaIJFKF2POwXXE8G3VH2qfPsdg6/JzqTzD/fs5Gh3H2OzSq8FXDkCTzq
 snQ2RWv2lIVWw==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-789d8dfb5c-z7n27 (szn-email-smtpd/2.0.71) with ESMTPA
 id b73469ef-8094-408d-8a67-5cd8883c475c;
 Sat, 04 Apr 2026 01:18:29 +0200
From: michael.srba@seznam.cz
Date: Sat, 04 Apr 2026 01:18:16 +0200
Subject: [PATCH 1/5] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260404-qcom_spl-v1-1-9e6c2ac66587@seznam.cz>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sat, 04 Apr 2026 08:31:19 +0200
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

From: Michael Srba <Michael.Srba@seznam.cz>

On some platforms (at least Qualcomm), the bootrom expects an ELF file.
Since the contents of the ELF file are platform specific, add a config
option that allows specifying a linker script to use to produce the
ELF file.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
 Makefile           | 23 +++++++++++++++++++++++
 common/spl/Kconfig |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/Makefile b/Makefile
index f232d8b4ea2..85cd6137bca 100644
--- a/Makefile
+++ b/Makefile
@@ -1231,6 +1231,9 @@ ifneq ($(CONFIG_SPL_TARGET),)
 INPUTS-$(CONFIG_SPL) += $(CONFIG_SPL_TARGET:"%"=%)
 endif
 INPUTS-$(CONFIG_REMAKE_ELF) += u-boot.elf
+ifneq ($(CONFIG_SPL_REMAKE_ELF_LDSCRIPT),)
+INPUTS-y += spl/u-boot-spl.elf
+endif
 INPUTS-$(CONFIG_EFI_APP) += u-boot-app.efi
 INPUTS-$(CONFIG_EFI_STUB) += u-boot-payload.efi
 
@@ -2005,6 +2008,26 @@ u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
 	$(call if_changed_dep,cpp_lds)
 
 PHONY += prepare0
+
+ifeq ($(CONFIG_SPL),y)
+ifneq ($(CONFIG_SPL_REMAKE_ELF_LDSCRIPT),)
+
+SPL_REMAKE_ELF_LDSCRIPT := $(addprefix $(srctree)/,$(CONFIG_SPL_REMAKE_ELF_LDSCRIPT:"%"=%))
+
+spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) FORCE
+	$(call if_changed_dep,cpp_lds)
+
+quiet_cmd_u-boot-spl-elf ?= LD      $@
+	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
+	-T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
+	-Ttext=$(CONFIG_SPL_TEXT_BASE) -z max-page-size=0x1000
+spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds
+	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
+	$(call if_changed,u-boot-spl-elf)
+
+endif
+endif
+
 # MediaTek's ARM-based u-boot needs a header to contains its load address
 # which is parsed by the BootROM.
 # If the SPL build is enabled, the header will be added to the spl binary,
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 2998b7acb75..9eeb56cb68b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -247,6 +247,12 @@ config SPL_HANDOFF
 	  proper. Also SPL can receive information from TPL in the same place
 	  if that is enabled.
 
+config SPL_REMAKE_ELF_LDSCRIPT
+	string "Linker script to run with u-boot-spl.bin as input"
+	help
+	  This allows specifying a linker script that will act on u-boot-spl.bin
+	  (see also REMAKE_ELF)
+
 config SPL_LDSCRIPT
 	string "Linker script for the SPL stage"
 	default "arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds" if MACH_SUNIV

-- 
2.53.0

