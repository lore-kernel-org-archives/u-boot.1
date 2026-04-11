Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66705E99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44461842E0;
	Sat, 11 Apr 2026 09:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="JS3iRMln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A8483DC9; Sat, 11 Apr 2026 02:04:21 +0200 (CEST)
Received: from mxd-2-a16.seznam.cz (mxd-2-a16.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86943841D2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 02:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-sbn6w
 (smtpc-mxd-7644845457-sbn6w [2a02:598:64:8a00::1000:a16])
 id 51f99ef30af7ca9a505052ad; Sat, 11 Apr 2026 02:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775865820; bh=tSY56a7zX0EiLT/25+hztoWXFPDCa7/Vqv9iylCfhl0=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=JS3iRMlnx9EEYEh2SdOVOPRMTDTpezVqUujZBxtKng++iRA++ILgkgP5nW4CZoJTG
 A5rR/s68u1G7qmD78WYFqkdlecy5MKrNAHQ3l/Cu6IXzYuqrTWNnpNZJYLC130RXTe
 w4iUxhuPJVMb4YT/vdbiNyGUKWKN3sFd1MlO+yxt6zRfwGklhgDfp2YCP8lTzpUv9L
 xfy4ukFQxqqrDAsy4xbwCEuTJsvTtGAW7zPKrt7DAvf9Se38ctre3xU8coWUzp6fb9
 lNw5a3nay1Xs5/hxijLnqhyuHctTyUw5tC14Wwe2ZQKucLruskMC1AnvANZUXD9bS0
 YIOr/+77W42Ww==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-xddnz (szn-email-smtpd/2.0.72) with ESMTPA
 id 8a9b21bc-dd25-4eee-8cde-c65378413105;
 Sat, 11 Apr 2026 02:03:00 +0200
From: michael.srba@seznam.cz
Date: Sat, 11 Apr 2026 02:00:06 +0200
Subject: [PATCH v2 01/10] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-qcom_spl-v2-1-9609557cf562@seznam.cz>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
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
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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
 Makefile           | 28 ++++++++++++++++++++++++++++
 common/spl/Kconfig |  9 +++++++++
 2 files changed, 37 insertions(+)

diff --git a/Makefile b/Makefile
index 8af18668b0f..754ca4d67e2 100644
--- a/Makefile
+++ b/Makefile
@@ -1232,6 +1232,9 @@ INPUTS-$(CONFIG_SPL) += $(CONFIG_SPL_TARGET:"%"=%)
 endif
 INPUTS-$(CONFIG_REMAKE_ELF) += u-boot.elf
 INPUTS-$(CONFIG_SPL_REMAKE_ELF) += spl/u-boot-spl.elf
+ifneq ($(CONFIG_SPL_REMAKE_ELF_LDSCRIPT),)
+INPUTS-y += spl/u-boot-spl.elf
+endif
 INPUTS-$(CONFIG_EFI_APP) += u-boot-app.efi
 INPUTS-$(CONFIG_EFI_STUB) += u-boot-payload.efi
 
@@ -2001,6 +2004,8 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
 	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< u-boot-elf.o
 	$(call if_changed,u-boot-elf)
 
+ifeq ($(CONFIG_SPL_REMAKE_ELF_LDSCRIPT),)
+
 quiet_cmd_u-boot-spl-elf ?= LD      $@
 	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
 	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
@@ -2010,10 +2015,33 @@ spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
 	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
 	$(call if_changed,u-boot-spl-elf)
 
+endif
+
 u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
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
+	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
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
index d1a85f50209..f8981cb4fe5 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -247,6 +247,15 @@ config SPL_HANDOFF
 	  proper. Also SPL can receive information from TPL in the same place
 	  if that is enabled.
 
+config SPL_REMAKE_ELF_LDSCRIPT
+	string "Linker script to run with u-boot-spl.bin as input"
+	depends on !SPL_REMAKE_ELF
+	help
+	  This allows specifying a linker script that will act on u-boot-spl.bin.
+	  Some platforms (e.g Qualcomm) use the ELF format in creative ways,
+	  including in the bootrom. Unlike SPL_REMAKE_ELF which uses a standard
+	  linker script, this allows specifying a platorm-specific one.
+
 config SPL_LDSCRIPT
 	string "Linker script for the SPL stage"
 	default "arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds" if MACH_SUNIV

-- 
2.53.0

