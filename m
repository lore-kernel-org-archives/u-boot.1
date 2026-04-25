Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7ABFF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 23:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F192C84309;
	Sun, 26 Apr 2026 01:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="UT1mCT0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7AC84099; Sun, 26 Apr 2026 01:27:54 +0200 (CEST)
Received: from mxd-2-a06.seznam.cz (mxd-2-a06.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a06])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4641183FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 01:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-68df9c878f-wmttj
 (smtpc-mxd-68df9c878f-wmttj [2a02:598:64:8a00::1000:a06])
 id 00f7491a5bf91d73015e8544; Sun, 26 Apr 2026 01:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777159645; bh=WywnshUb3X1sgo4xeptkpF66WcPyyI625jOmKPdxTOI=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:To:Cc;
 b=UT1mCT0ng/wUWJ1iCvDr3u0ZbmRVD17TjfEZUSDb8ksBJkiaodBuAvLkiCia7yX4Z
 lnGgrCrKyVnLkEvO6GahF6ciRr+us+YBykh2mW5B6sHHX8+O0QHXg9qfs4Io2pxLVL
 lWYfCp/JNyl0hzT+yvrwzCDITqrAlsElRW324AXg4yN6VXQCaOfWjt8SAY9bIqPqcZ
 i9+tatNH5a/1V5UbnGq9+AZZ7Igle9ubxjxK34y+7LTJblcRGU00fPc6PBoETTNLgt
 7nKI95WjvY2LkKoj5z5vduPjPfo8gFX1HVWyZjlV8JTF6Z227Jzt0P90uv0qPh93KB
 f54OB+zeBCBoA==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-7c7c659656-cskk5 (szn-email-smtpd/2.0.72) with ESMTPA
 id 6e93fd2f-03fc-4818-a506-04572df62fac;
 Sun, 26 Apr 2026 01:26:53 +0200
From: michael.srba@seznam.cz
Subject: [PATCH v4 00/11] Add SPL support for Qualcomm platforms, starting
 with sdm845
Date: Sun, 26 Apr 2026 01:26:02 +0200
Message-Id: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAItN7WkC/13NSw6CMBgE4KuYrq3pG3DlPYwxpfxIjTyk2CiEu
 0sxxsblJPPNTMhBb8Gh/WZCPXjrbNssQWw3yFS6uQC2xZIRI0wRQTi+m7Y+u+6GScpUKniuBTV
 oqXc9lPa5Th1Pn+we+RXMEHxoVNYNbf9avzwNve+s+M16ignOQBmmjVIyTQ4OxkbXOzOiMOtZB
 CmNIAtQkUzKxJRSsX/II8hiyBcIJQAvE5VIUcRwnuc30owWEiQBAAA=
X-Change-ID: 20260403-qcom_spl-0826843ba41c
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
X-Mailman-Approved-At: Sun, 26 Apr 2026 01:47:27 +0200
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

[ context ]

Different generations of Qualcomm SoCs have differences in the boot
process. msm8916 (and similar) are quite straightforward:
[EL3]bootrom->sbl1->tz->[EL2]hyp->[EL1]aboot->linux (omitting non-AP
cores). msm8998, sdm845, kodiak and simiar are a bit more involved:
[EL3]bootrom->xbl_sec->[EL1]xbl_loader->[EL3]tz->[EL2]hyp->[EL1]uefi
->ABL->linux. Newer platforms like hamoa are even more involved.

Currently, u-boot proper can run in place of Linux, in place
of aboot, or in place of hyp. The option to run in place
of Linux is necessary because >99% of OEMs do not consider
the sale of a device to an end user a transfer of ownership,
that is, they sell the device with a hash of their public key
pre-burnt in the fuses.

[ end of context ]

U-Boot SPL, as it will be built using the defconfig added in this series,
replaces xbl_loader. If support for msm8916 or a similar platform
is added, it would replace sbl1. This will obviously only work on
the <1% of devices whose manufacturers consider the sale a transfer
of ownership, and of course most SBCs.

Unfortunately, starting with (iirc) msm8998, and getting progressively
worse, Qualcomm no longer consider a sale of their SoC a transfer
of ownership either. While it's possible to execute your code
in EL3 using either jtag or a patched devcfg, the former is impractical
while the latter is irrelevant for the purposes of running u-boot SPL
since the devcfg is parsed by trustzone. (this of course only applies
to the <1% of the devices where the OEM didn't lock the device down
prior to sale)

Given the above, this series uses an unintended feature in old builds
of xbl_sec which allows us to elevate to EL3. We also check if we
happen to already be running in EL3, in which case we proceed normally.
This can be the case e.g if JTAG was used to jump to u-boot SPL in EL3,
which may be the only option on e.g. kodiak. (Running in EL1 is not
really viable, because xbl_sec+xbl_loader are effectively sbl1 split
in half and replacing only one doesn't make much sense)

For now, only usb dfu is supported to load the next stage. Since we
don't support ram initialization, the next stage will need to run from
SRAM too, which is currently not supported. Additional patches will
be needed to make that work, at which point it will be possible
to use u-boot as a ufs/emmc programmer with zero proprietary code
in the boot chain (sans bootrom and part of xbl_sec, but the latter and
technically even the former could be skipped with JTAG)

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
Changes in v4:
- select SPL_SPMI if SPL in ARCH_SNAPDRAGON
- fix typo in mach-snapdragon/Kconfig
- fix capitalization of Qualcomm
- fix commit message that should've been updated in v3
- assign maintainership of the defconfig to Snapdragon maintainers
- add R-Bs
- Link to v3: https://patch.msgid.link/20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz

Changes in v3:
- redo CONFIG_SPL_REMAKE_ELF_LDSCRIPT to use the existing SPL_REMAKE_ELF code
- clean up KConfig, move stuff to defconfig, change around some imply/selects
  after better understanding how they work, change TARGET handling and remove
  SPL_ prefix
- split out malloc size bugfix
- fix space indents in assembly code, fix missing isb
- unmagicify the linker script
- fix copy paste error with ret declaration
- slightly reword the rst, and hopefully fix all formatting issues
- improve help text for SPL_CLK_STUB
- add SPL_SPMI_MSM and use $(PHASE_) when deciding whether to compile spmi
  support
- improve help text for SPL_OF_LIVE
- add R-Bs for patches that received them and didn't see massive changes
  (hopefully my judgement is correct)
- Link to v2: https://patch.msgid.link/20260411-qcom_spl-v2-0-9609557cf562@seznam.cz

Changes in v2:
- fix spmi and of_live patches (missing help text, remove --, wording
  issues, drivers/spmi/Makefile), add bootstage_start()/bootstage_accum()
- fix conflict with upstream-added cmd_u-boot-spl-elf (and copy endianness
  handling), improve help text for SPL_REMAKE_ELF_LDSCRIPT
- split "mach-snapdragon: support building SPL" into smaller patches
- fix three SYS_MALLOC_LEN definitions; remove the conditional one, it was
  a leftover from related-but-separate effort to make u-boot proper work
  without dram
- s/#if CONFIG_SPL_TARGET_SDM845/#if defined(CONFIG_SPL_TARGET_SDM845)/
- fix "&rpmhcc: clock-controller" (probably accidental ctrl+z)
- change el3_ret_point to (el3_ret_point - _start); I'd swear when I was
  writing this I had to do it that way because for some bizzare reason
  el3_ret_point was relative and _start was absolute, but now I tested
  it again and they're both relative to the start of .text. (making _start
  0, but it's still cleaner this way)
- fix empty comment in el3_payload
- fix documentation style errors
- change KConfig as options as suggested (hardcode computed values, remove
  macro variables, move QCOM_SPL options under ARCH_SNAPDRAGON with
  SPL_BUILD conditionals; IMEM_START/END were dropped since they were
  a leftover from related-but-separate effort to make u-boot proper work
  without dram
- don't mess with SYS_SOC, it's clearly a bad idea; make the board .dtsi
  include sdm845-u-boot.dtsi
- split board.c and don't compile spl parts into u-boot proper and
  vice versa
- properly test clean build
- Link to v1: https://patch.msgid.link/20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz

---
Michael Srba (11):
      Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
      of_live: support in SPL
      drivers: allow clk_stub and spmi in SPL
      mach-snapdragon: boot0.h: split out msm8916_boot0.h
      mach-snapdragon: add u-boot-spl-elf-sdm845.lds
      mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN
      mach-snapdragon: Kconfig: changes / additions to support SPL
      mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
      mach-snapdragon: add board_spl.c and split out common code
      qualcomm: add defconfig, env and docs for SPL on sdm845
      dts: add u-boot specific sdm845 .dtsi and a .dtsi for shift-axolotl

 MAINTAINERS                                        |   1 +
 Makefile                                           |  10 +-
 arch/arm/Kconfig                                   |  34 +-
 arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi      |   2 +
 arch/arm/dts/sdm845-u-boot.dtsi                    |  16 +
 arch/arm/mach-snapdragon/Kconfig                   |  34 +-
 arch/arm/mach-snapdragon/Makefile                  |   8 +
 arch/arm/mach-snapdragon/board.c                   | 358 +--------------------
 arch/arm/mach-snapdragon/board_common.c            |  56 ++++
 arch/arm/mach-snapdragon/board_spl.c               |  35 ++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  61 +---
 .../mach-snapdragon/include/mach/msm8916_boot0.h   |  54 ++++
 .../include/mach/sdm845_spl_boot0.h                | 121 +++++++
 arch/arm/mach-snapdragon/mem_map.c                 | 318 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h               |   4 +-
 arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds |  44 +++
 board/qualcomm/sdm845_spl.env                      |   2 +
 common/spl/Kconfig                                 |  10 +
 common/spl/spl.c                                   |   9 +
 configs/sdm845_spl_defconfig                       | 138 ++++++++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/spl.rst                         |  91 ++++++
 drivers/Makefile                                   |   2 +-
 drivers/clk/Kconfig                                |   7 +
 drivers/spmi/Kconfig                               |  13 +
 drivers/spmi/Makefile                              |   4 +-
 dts/Kconfig                                        |   8 +
 lib/Makefile                                       |   2 +-
 28 files changed, 1028 insertions(+), 415 deletions(-)
---
base-commit: 93f84ee022a8401421cdaab84fe7d106d83fdb4a
change-id: 20260403-qcom_spl-0826843ba41c

Best regards,
--  
Michael Srba <Michael.Srba@seznam.cz>

