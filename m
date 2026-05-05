Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3569AFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 02:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1286B84869;
	Tue,  5 May 2026 04:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="bqt2SPeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80198846FA; Tue,  5 May 2026 02:49:24 +0200 (CEST)
Received: from mxd-1-a0f.seznam.cz (mxd-1-a0f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C21D846BE
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 02:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-lmwqj
 (smtpc-mxd-5f4d8d5f6f-lmwqj [2a02:598:128:8a00::1000:a0f])
 id 57edc4950ce390fc564408cb; Tue, 05 May 2026 02:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777942131; bh=yzcC1/EMYJLHSZCcyhpmV9uif5fkCbhs1ngJCjIk66k=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:To:Cc;
 b=bqt2SPeDt5dtU+7oIld/h7lOgZKQ6kPDSLYS/qsDNbp8XZ3JHp8NkfowNCBlXZXOx
 DsiWaVR/+U+CgtQyl2eBGmpY3piqKsYf317XIXPzAXX/zrm4FAuYKcxCQahTnTETsK
 36b8Ftmuh9/jjuzl3yYer+kbVr2GYDM0DbdnAeubFN8fNrNSiViHic5U5f3vY2hjxo
 XGRheFKWSauqKzY+Utxmp3ZSr7mu8wM7qbim7kEY+rFjJ0pQLqMc2ouJzoD6goW8e5
 5hGXUZicaBg8a+J+LbWI6l0euU3BaUfB9a4rsusURIJ9dCNlKVGd/g9UtOAlHSeegr
 iis4q6rtkje2g==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-7c7c659656-rb5ts (szn-email-smtpd/2.0.72) with ESMTPA
 id fdd256b4-214d-4bd3-be57-b7ff9cee806e;
 Tue, 05 May 2026 02:48:11 +0200
From: michael.srba@seznam.cz
Subject: [PATCH v5 00/11] Add SPL support for Qualcomm platforms, starting
 with sdm845
Date: Tue, 05 May 2026 02:47:46 +0200
Message-Id: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADI++WkC/13N3Q4BMRQE4FeRXqv092y58h4iso5TKuyyZeMn+
 +5aIhqXk8w382SRukCRzUZP1lEfYmibFOx4xHBXN1viYZMyU0KBMELzM7bHVTwduHAKnNHr2kh
 kqX7qyIfbe2qx/OR4Xe8JL9nnxi7ES9vd31+9zL3vrPnN9pILPiVAVSOAddU80qOpjxN8sDzbq
 wJKWUCVIYiptRV6C+of6gKqEuoEyRNpX0FlzeYfmhJCAU2CDr2RWnvvnC7hMAwvhYq/FF0BAAA
 =
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
X-Mailman-Approved-At: Tue, 05 May 2026 04:20:34 +0200
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
 arch/arm/Kconfig                                   |  34 +-
 arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi      |   2 +
 arch/arm/dts/sdm845-u-boot.dtsi                    |  16 +
 arch/arm/mach-snapdragon/Kconfig                   |  35 +-
 arch/arm/mach-snapdragon/Makefile                  |   8 +
 arch/arm/mach-snapdragon/board.c                   | 358 +--------------------
 arch/arm/mach-snapdragon/board_common.c            |  56 ++++
 arch/arm/mach-snapdragon/board_spl.c               |  35 ++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  62 +---
 .../mach-snapdragon/include/mach/msm8916_boot0.h   |  54 ++++
 .../include/mach/sdm845_spl_boot0.h                | 121 +++++++
 arch/arm/mach-snapdragon/mem_map.c                 | 318 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h               |   4 +-
 arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds |  44 +++
 board/qualcomm/sdm845_spl.env                      |   2 +
 common/spl/Kconfig                                 |  11 +
 common/spl/spl.c                                   |   9 +
 configs/dragonboard410c_defconfig                  |   1 +
 configs/sdm845_spl_defconfig                       | 137 ++++++++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/spl.rst                         |  91 ++++++
 drivers/Makefile                                   |   2 +-
 drivers/clk/Kconfig                                |   7 +
 drivers/spmi/Kconfig                               |  13 +
 drivers/spmi/Makefile                              |   4 +-
 dts/Kconfig                                        |   8 +
 lib/Makefile                                       |   2 +-
 29 files changed, 1033 insertions(+), 412 deletions(-)
---
base-commit: ba1209d7a756552677f07c207cdf7fac400a8b7c
change-id: 20260403-qcom_spl-0826843ba41c

Best regards,
--  
Michael Srba <Michael.Srba@seznam.cz>

