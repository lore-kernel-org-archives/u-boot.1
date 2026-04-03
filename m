Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C25E88D87
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 06:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8294384180;
	Sat,  4 Apr 2026 08:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="SUNnaknF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B94984132; Sat,  4 Apr 2026 01:19:38 +0200 (CEST)
Received: from mxd-1-a04.seznam.cz (mxd-1-a04.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a04])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6B9807C0
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 01:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-4tx79
 (smtpc-mxd-7644845457-4tx79 [2a02:598:128:8a00::1000:a04])
 id 241991237f17c54a25b05d7d; Sat, 04 Apr 2026 01:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775258322; bh=XLKn1i+bNOWsMbz4XTfkf0NDUc7kl447vME44vPNpVA=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:To:Cc;
 b=SUNnaknFnsiU/90hNGUyXolUhvnPmSvggaqODVT42FlxxhlOCE/RtDimBNpSKsoyQ
 C9hHOL0hFi3D018UTW5oH3EkZyw8fTU14KEa1SvwB10u9hLnKUrTeAyw8tgzxX453L
 zJZYUhW4I/YVSTtvNwlz8qYz2aUjyEdz0GJAOO9BJqoXkzNAGK5vAJaaVhhaJA+bGh
 +l8SjkhHTGY1rMOwBX5bRqS5+Mu3o4yeyfsq4AOHKIn4FRSwSqZDO6VZRp1cy0W/KE
 smROJjsC3dAmtZbbVX+HZTvuMCFhxJlWL7P2wkp0NDFaNgEXdOhYy/w7xXxf7SstDP
 Qtq6TVQ7py2lA==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-789d8dfb5c-z7n27 (szn-email-smtpd/2.0.71) with ESMTPA
 id 1b7959c0-ce5b-4dbe-bf39-113a3a0e2253;
 Sat, 04 Apr 2026 01:18:28 +0200
From: michael.srba@seznam.cz
Subject: [PATCH 0/5] Add SPL support for Qualcomm platforms, starting with
 sdm845
Date: Sat, 04 Apr 2026 01:18:15 +0200
Message-Id: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALdK0GkC/yXM7QpAQBCF4VvR/La11ia5FUlrDUY+d5CSe7f4+
 dR7zgWMjpAhCy5weBDTPHlEYQC2M1OLgmpvUFIlUstYrHYeS14GIVOVpDqujI4s+Hxx2ND5XeX
 Fb96rHu327uG+H9jU73FsAAAA
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
Michael Srba (5):
      Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
      of_live: support in SPL
      drivers: allow clk_stub and spmi in SPL
      mach-snapdragon: support building SPL
      dts: add empty .dtsi for shift-axolotl

 Makefile                                           |  23 ++++
 arch/arm/Kconfig                                   |   6 +-
 arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi      |   4 +
 arch/arm/dts/sdm845-u-boot.dtsi                    |  16 +++
 arch/arm/mach-snapdragon/Kconfig                   |  98 +++++++++++++++-
 arch/arm/mach-snapdragon/board.c                   |  26 +++++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  61 ++--------
 .../mach-snapdragon/include/mach/msm8916_boot0.h   |  54 +++++++++
 .../include/mach/sdm845_spl_boot0.h                | 120 +++++++++++++++++++
 arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds |  25 ++++
 board/qualcomm/sdm845_spl.env                      |   1 +
 common/spl/Kconfig                                 |   6 +
 common/spl/spl.c                                   |  10 ++
 configs/sdm845_spl_defconfig                       | 130 +++++++++++++++++++++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/spl.rst                         |  70 +++++++++++
 drivers/Makefile                                   |   2 +-
 drivers/clk/Kconfig                                |   6 +
 drivers/spmi/Kconfig                               |   6 +
 dts/Kconfig                                        |   5 +
 lib/Makefile                                       |   2 +-
 21 files changed, 616 insertions(+), 56 deletions(-)
---
base-commit: 4dc4080805fac1b1ed7606ce3bc8fb44a6d59d5e
change-id: 20260403-qcom_spl-0826843ba41c

Best regards,
--  
Michael Srba <Michael.Srba@seznam.cz>

