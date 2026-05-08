Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B106ACD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A4D84E6B;
	Sat,  9 May 2026 02:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="tkx2dlaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221DE84CE5; Fri,  8 May 2026 23:46:20 +0200 (CEST)
Received: from mxd-1-a0f.seznam.cz (mxd-1-a0f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3CAF84CF3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-lmwqj
 (smtpc-mxd-5f4d8d5f6f-lmwqj [2a02:598:128:8a00::1000:a0f])
 id 65037f213e0d2b4864aab37f; Fri, 08 May 2026 23:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778276742; bh=vyfIOH5H3Ly30yKGMVdIMlHUo0Q5z7yVOcyXZHU88JA=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:To:Cc;
 b=tkx2dlaQ2rkInQMiG53Yk0KVPrOPQPxvEINfgVudacUYkMnVI17yGr2pxLAoE1eHK
 ksvXEsDyHWqmA4mlrrpiumWDUw9htjUL0odIpFsRinYoLhn4pW6bAXyGp4OWAR/+f5
 I1Q8cWfN5PI9yeUPs+nYhqudkg0O8xUS1LyJnQsZc8ttcHSS/xjzeWc2j+RFeM1huy
 QJt/03Hvu0kGRT/VuEKloj/eWXnhvpjyiBWYfXR3wM5kidyDYM9+3YZAq+B7XPD3ua
 qbP/Mz+Gl1I9cOoFOJTBlDMIiOsWHllwGqzyYi6Pl6Vp1jewxwDLwCiGHyf7jbbyY1
 kgcJRGZ4L1u9A==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-jn5pf (szn-email-smtpd/2.0.72) with ESMTPA
 id 490e5217-5e72-40e4-81f4-1e19e2898080;
 Fri, 08 May 2026 23:45:38 +0200
From: michael.srba@seznam.cz
Subject: [PATCH v7 00/11] Add SPL support for Qualcomm platforms, starting
 with sdm845
Date: Fri, 08 May 2026 23:45:24 +0200
Message-Id: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRZ/mkC/13NwU7DMBAE0F+pfCbIa3vXbk/8R1Uhx1lTI5qUu
 ETQKv+OU4Rq5TjSvJmbyDwmzmK3uYmRp5TT0JdgnzYiHH3/xk3qShZKKpJG6uYzDKfXfP5opFP
 kjG69gSBK/TxyTN/3qf3hL+ev9p3DZfFL45jyZRh/7l8TLL3/WfOYnaCRzZYpKB+I0NmXzNfen
 57DVSyzk6ogQAXVAkluEW2ISGoNdQVVDXWBHJl1tGTRdGtoakgVNAW6EA1oHaNzeg3xAVFiBbF
 AAAfWAHZEZg2phq6CVKD3PoBvwbYoazjP8y9R8rBnzwEAAA==
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
Changes in v7:
- add CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND=y to hmibsc_defconfig too
- add R-Bs
- Link to v6: https://patch.msgid.link/20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz

Changes in v6:
- fix copypaste error in SPL_REMAKE_ELF_LDSCRIPT default path
- add newline in the help text
- add missed `b reset` in boot0.h
- expand on kconfig changes commit message
- remove SPL_OF_REAL since it's implied
- Link to v5: https://patch.msgid.link/20260505-qcom_spl-v5-0-11817415d664@seznam.cz

Changes in v5:
- put back `prepare` in lds preprocessing, touch up commit message
- fix incorrect path to arch/u-boot-spl-elf.lds, reword kconfig help
- rework boot0.h Kconfig setup according to Sumit's suggestions
  (kept the selection menu to make the options exclusive, also moved
   it to correct patches)
- only select DM_EVENT if u-boot proper wants dwc3
- remove R-B on `mach-snapdragon: boot0.h: split out msm8916_boot0.h`
  since it changed in a non-trivial way according to Sumit's suggestions
- rebase on latest u-boot master (thought this would expose [1] but it seems
that board.c compiles just fine locally so I didn't do the rename the CI
error suggets)
- Link to v4: https://patch.msgid.link/20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz

[1] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13147&view=logs&j=552351cf-1013-58e8-359b-7fe3c1855624&t=7ff3dd5e-bc96-5d26-5370-e240ad4c566e

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
 Makefile                                           |   9 +-
 arch/arm/Kconfig                                   |  33 +-
 arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi      |   2 +
 arch/arm/dts/sdm845-u-boot.dtsi                    |  16 +
 arch/arm/mach-snapdragon/Kconfig                   |  35 +-
 arch/arm/mach-snapdragon/Makefile                  |   8 +
 arch/arm/mach-snapdragon/board.c                   | 358 +--------------------
 arch/arm/mach-snapdragon/board_common.c            |  56 ++++
 arch/arm/mach-snapdragon/board_spl.c               |  35 ++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  64 +---
 .../mach-snapdragon/include/mach/msm8916_boot0.h   |  54 ++++
 .../include/mach/sdm845_spl_boot0.h                | 121 +++++++
 arch/arm/mach-snapdragon/mem_map.c                 | 318 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h               |   4 +-
 arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds |  44 +++
 board/qualcomm/sdm845_spl.env                      |   2 +
 common/spl/Kconfig                                 |  12 +
 common/spl/spl.c                                   |   9 +
 configs/dragonboard410c_defconfig                  |   1 +
 configs/hmibsc_defconfig                           |   1 +
 configs/sdm845_spl_defconfig                       | 137 ++++++++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/spl.rst                         |  91 ++++++
 drivers/Makefile                                   |   2 +-
 drivers/clk/Kconfig                                |   7 +
 drivers/spmi/Kconfig                               |  13 +
 drivers/spmi/Makefile                              |   4 +-
 dts/Kconfig                                        |   8 +
 lib/Makefile                                       |   2 +-
 30 files changed, 1036 insertions(+), 412 deletions(-)
---
base-commit: ba1209d7a756552677f07c207cdf7fac400a8b7c
change-id: 20260403-qcom_spl-0826843ba41c

Best regards,
--  
Michael Srba <Michael.Srba@seznam.cz>

