Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ACDE66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8158908D;
	Sat, 23 Nov 2024 22:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 716B0893D3; Sat, 23 Nov 2024 20:56:33 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk
 [IPv6:2a00:1098:84:22e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C972893A5
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id 523DB407EE;
 Sat, 23 Nov 2024 19:56:25 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Hanyuan Zhao <hanyuan-z@qq.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Sam Edwards <CFSworks@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 00/10] Improve UEFI app support
Date: Sat, 23 Nov 2024 11:54:59 -0800
Message-ID: <20241123195616.305687-1-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
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

We run a mixed environment including traditional embedded Linux and 
UEFI. For consistency it's valuable to use U-Boot in both cases, but on 
UEFI systems we want to run the full Linux kernel UEFI boot stub. This 
patchset adds support for that, along with various other quality-of-life 
improvements such as automatically finding partitions based on their 
GUID, automatic identification of load addresses where the firmware has 
given us constraints, support for EFI variable access in the EFI app, 
drivers for EFI network adapters and TPMs, support for embedding DTBs in 
the EFI app, and a couple of bug fixes.


Janis Danisevskis (1):
  Fix efi_bind_block.

Matthew Garrett (9):
  Add EFI handover support to bootm
  Add part_find command
  Add a command to find a load address
  Hook up EFI env variable support in the EFI app
  Add EFI network driver
  Add UEFI TPM2 driver
  Support separate DTB files with the UEFI app
  Use the correct ramdisk address
  Add command to set an environment variable to an EFI variable

 Makefile                        |   7 +-
 arch/x86/config.mk              |   2 +-
 arch/x86/lib/bootm.c            |  60 ++++++++----
 arch/x86/lib/elf_x86_64_efi.lds |   4 +
 boot/bootm.c                    |   5 +
 cmd/Kconfig                     |  23 ++++-
 cmd/Makefile                    |   3 +
 cmd/addr_find.c                 |  87 +++++++++++++++++
 cmd/efigetenv.c                 | 133 ++++++++++++++++++++++++++
 cmd/part_find.c                 | 156 ++++++++++++++++++++++++++++++
 drivers/net/Kconfig             |   7 ++
 drivers/net/Makefile            |   1 +
 drivers/net/efi_net.c           | 110 +++++++++++++++++++++
 drivers/tpm/Kconfig             |   7 ++
 drivers/tpm/Makefile            |   1 +
 drivers/tpm/tpm2_efi.c          |  97 +++++++++++++++++++
 include/asm-generic/sections.h  |   1 +
 include/bootm.h                 |   6 ++
 include/efi.h                   |  24 +++++
 include/efi_tcg2.h              |   1 +
 lib/efi/Makefile                |   2 +-
 lib/efi/efi.c                   |   1 +
 lib/efi/efi_app.c               |  41 ++++++++
 lib/efi/efi_app_init.c          | 163 ++++++++++++++++++++++++++++++--
 lib/efi/efi_dtb.S               |   6 ++
 lib/efi/efi_vars.c              |  44 +++++++++
 lib/fdtdec.c                    |   3 +
 27 files changed, 967 insertions(+), 28 deletions(-)
 create mode 100644 cmd/addr_find.c
 create mode 100644 cmd/efigetenv.c
 create mode 100644 cmd/part_find.c
 create mode 100644 drivers/net/efi_net.c
 create mode 100644 drivers/tpm/tpm2_efi.c
 create mode 100644 lib/efi/efi_dtb.S
 create mode 100644 lib/efi/efi_vars.c

-- 
2.47.0

