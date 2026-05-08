Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35735CD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CA584E78;
	Sat,  9 May 2026 02:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="uGPWAGli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0518484CF2; Fri,  8 May 2026 23:46:25 +0200 (CEST)
Received: from mxd-3-701.seznam.cz (mxd-3-701.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B060484CF3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-gj4cr
 (smtpc-mxd-5f4d8d5f6f-gj4cr [2a02:598:96:8a00::1200:701])
 id 0d1e3a3f56106e560cb7f661; Fri, 08 May 2026 23:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778276750; bh=2hcVMBb/votXPvYlM+WsyTziruFXMO8uiwMwrzloXRk=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=uGPWAGlien4vq1oQqfhjhYJ4NxACfA+1jO6lQTjensLWJDO1xUZI796XjcLQb2DgX
 p1CjrEcGtfSk8m6vVM+DuXtZx8eD0fdLxPWVujshahUPmAIxcMjh+pBYfyfhIrXx24
 kxV+3AIxMcOGj2wrazF+jmg/VYM+C7SXXvvH3SrZ+X81cqaYwIGOjVqrgPz53KvtGy
 O9oAOCeZC7dizgguyPBIWZcxVEMML75gdWfioOvjsPfF9/X9oADHScUvSUsSvLqfuf
 5bkeapPG9CrL7rZWjeiJpfvKiKFkqstCHHHs4B8Ve8GZV7d9I5HGFZE4Yzvs2LhwCT
 nw2LtwmHbI+6g==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-jn5pf (szn-email-smtpd/2.0.72) with ESMTPA
 id f2a4e67a-7daa-4039-9c36-a5c504d023bd;
 Fri, 08 May 2026 23:45:38 +0200
From: michael.srba@seznam.cz
Date: Fri, 08 May 2026 23:45:25 +0200
Subject: [PATCH v7 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-qcom_spl-v7-1-7d0e22aaaa8f@seznam.cz>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
In-Reply-To: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
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
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:31 +0200
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

Some platforms (e.g. at least Qualcomm) use the ELF format in creative
ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
as the default).

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 Makefile           |  9 +++++++--
 common/spl/Kconfig | 12 ++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 49d9740327e..8fe722f6c0d 100644
--- a/Makefile
+++ b/Makefile
@@ -2008,12 +2008,17 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
 quiet_cmd_u-boot-spl-elf ?= LD      $@
 	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
 	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
-	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
+	-T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
 	-Ttext=$(CONFIG_SPL_TEXT_BASE)
-spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
+spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds
 	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
 	$(call if_changed,u-boot-spl-elf)
 
+SPL_REMAKE_ELF_LDSCRIPT := $(addprefix $(srctree)/,$(CONFIG_SPL_REMAKE_ELF_LDSCRIPT:"%"=%))
+
+spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) prepare FORCE
+	$(call if_changed_dep,cpp_lds)
+
 u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
 	$(call if_changed_dep,cpp_lds)
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e49..5c7b094e6b6 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -238,6 +238,18 @@ config SPL_HANDOFF
 	  proper. Also SPL can receive information from TPL in the same place
 	  if that is enabled.
 
+config SPL_REMAKE_ELF_LDSCRIPT
+	string "Linker script for SPL ELF"
+	depends on SPL_REMAKE_ELF
+	default "arch/u-boot-elf.lds"
+	help
+	  This allows specifying a linker script that will be used to re-wrap
+	  the SPL binary into an ELF.
+
+	  Some platforms (e.g. at least Qualcomm) use the ELF format in creative
+	  ways, including in the bootrom. For such platforms, you can change
+	  the default linker script to a platform-specific one.
+
 config SPL_LDSCRIPT
 	string "Linker script for the SPL stage"
 	default "arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds" if MACH_SUNIV

-- 
2.53.0

