Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87867FA1FC0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 15:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B81842CE;
	Wed, 22 Apr 2026 17:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="dMis/10v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB16842E6; Wed, 22 Apr 2026 17:39:29 +0200 (CEST)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715C683BC8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 17:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776872365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xtp7kvlsm9BGNpxOFV+O96ksCtkj/V2CiHcPiEUF7Sg=;
 b=dMis/10vgp8waOasiEhjAklkP/hJ7TJdDilhFUDMMxSWKl+6fNWPWJJgtZOkhW/LuNlmQu
 BDBZg9/C0PlmSURbeqQfgfY4LIRViZhqucCGaAXkrYxm5eKwdVXxmPoTKaKLraPK8mED8L
 Z0RF0vpMRjZyGx7H/91Lb50Jf2RaN2creoYG4uFX2UW0FSiQ0jJN1r4Tc+EZu4MPY7l7WR
 4UqS8VKJ6Zdm0k9Zs/HTcofKbY1emo74hvRRdp3fWoFytJpUNEQhFPUmrl3CwJ2ZL3iPM4
 gc1nNGtSJa7iEhEcH0ud9t2CkDnOqabGgilJOHpED1VzDI6YmUcC2IDQovNPPA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v2 0/4] Enable EFI Capsule on Disk on Libre Computer
 LePotato & LaFrite
Date: Wed, 22 Apr 2026 15:39:03 +0000
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJfr6GkC/43NQQ6CMBCF4auQWTumFGjQlfcwLApMoRFo06lEQ
 ri7lRO4/N7ifzswBUsM92yHQKtl65YEecmgG/UyENo+GaSQSpSixrZEPU9usB3yxoGYInba83s
 ixtpUNyV7Mtq0kBI+kLGfM/9skkfL0YXtfFvz3/pneM1RoDJFUStqq1yWD+84zjq8KDq+ujBAc
 xzHFxnMdRTPAAAA
X-Change-ID: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=G3j2Wt/mHR+/+cx/vQ5XlfHf4OmY8LcEUQVQGCmm8lc=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6Oulzs0R7G4Yyb9v3Ke/t4LWu77aIyqDRRfE5
 2Nozr8Ss8WJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejrpQAKCRCEr8vQ14ma
 A6C3D/0cvgzItX6O9RI+FE5sjBM4sOP6+9TSP6X+/CgSKulkT77DhAZBci4SORd+Ly7choHqe41
 YrOuBOUk7XzFaGkTYbxfCBCGX7jN2DVPZjZXRIOBJGWYETy0VxHL+sg+9n+QxXw+6+SqRQ7j8We
 57m7a3Mzx6rRgZUniFg3u5D76rFBObxIiqnbYKL/cJDOESiOHpwNxFVnszp5nLrYnVJUF7O5EeB
 jSQW+S7iS1Ql9Kl8TAbxI8c/FluOt+lVP7h4we7jXhpR/8ak/Ojuw0n3h4hkXDuBkTf6RttoqxT
 Pne3DqZWRGOsZZYgGqk6cjzoiZlfQRsC+fyQtYdeLRBSsLCkY31/39ddi7pXgpI7XpCcEwbxhqy
 1Fa2uCyc72M3qpymt9vVE/Jn9dRuxbo7JJPuzx/wzmwfIjpGgt5budymQ3ILaxchgPE/Oqilhe5
 o9KsEEiNlpF/05gJXPuqbAzKG3hmMFCDxi4oWH8NSaI5NkSf8Vmp4S7UfVru4uat1TfZ+B8/mK5
 lAHWQttgPQbIwDBe7Vzp42OlGudVdRaqkpu7IQWHZpTWQxKJT4amfoZ36GRfBdPr/xybAPVUTYK
 Y8nFlBkeamriDbqEgw+I8F3dProHSHeBF9eIB6cpRt5zSXS08AAPFCvrM08ppZvgONWqs1soMS/
 lk8Zjr1Igw2Twww==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Mostly everything is already in place to enable EFI capsules and in particular
EFI capsule on disk.

First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
functionality expects sysreset to be present. As the current reset_cpu()
function in board-common.c is basically only doing PSCI reset on U-Boot
proper, we can replace it with sysreset's PSCI support, which works just
fine for that purpose provided BL31 is running (SPL stays on an
SoC-specific reset_cpu() which does for(;;);, as the overhead for
sysreset is too high and we don't have PSCI yet at that point).

Then we can enable capsule on disk. LaFrite has Capsule updates enabled
already, so it is simply a matter of enabling CoD. LePotato does not
have Capsule updates enabled by default, however it can be easily enabled
and setup to update u-boot on eMMC/SD.

With Capsule on Disk setup, it becomes possible to update U-Boot directly
from Linux, without having to worry about manually using `flashprog`
(for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
can be handled by `fwupd` and applied upon next EFI boot.

To test:

 * build U-Boot as usual

 * in that running U-Boot, run: `efidebug capsule esrt` to get the GUID
   -OR-
   run the following in your tree:
	tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESON_MMC
	                                   (or U_BOOT_MESON_SPI on LaFrite)

 * proceed with the following guide to create a capsule file:
   https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-uefi-capsule-update-feature

 * generate a .cab file suitable for fwupd using `mkcab`:
   https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/mkcab
	mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc "LePotato" 2026.04
   (as of writing, the README.md suggests this is for Qualcomm only. It
    actually does nothing that is Qualcomm-specific, and works on any
    board that supports Capsule on Disk and fwupd)

 * on the board itself, boot to Linux via EFI, install fwupd, copy the resulting
   .cab file, and run as root:
	fwupdtool --force install u-boot-libretech-cc.cab

 * reboot, make sure you boot over EFI, else the capsule update will not
   start

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v2:
 - Keep reset_cpu in board-common.c, but guarded
 - Only imply SYSRESET_PSCI, for boards to be able to disable it if
   needed
 - Link to v1: https://lore.kernel.org/r/20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org

---
Ferass El Hafidi (4):
      arm: mach-meson: provide reset_cpu only when SYSRESET is disabled
      arm: meson: enable SYSRESET_PSCI
      configs: libretech-ac_defconfig: enable EFI Capsule on Disk
      configs: libretech-cc_defconfig: enable EFI Capsule on Disk

 arch/arm/mach-meson/Kconfig        | 2 ++
 arch/arm/mach-meson/board-common.c | 6 ++----
 configs/libretech-ac_defconfig     | 1 +
 configs/libretech-cc_defconfig     | 4 ++++
 4 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: f0000b4a57e9edf8ff8454b9056d767466dff57f
change-id: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb

Best regards,
-- 
--
Best regards,
Ferass

