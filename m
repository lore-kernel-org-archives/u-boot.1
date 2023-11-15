Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922F9C48BF9
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE80187284;
	Wed, 15 Nov 2023 15:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HhSvD5O/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8310987264; Wed, 15 Nov 2023 15:24:07 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7941E87197
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 15:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 056833F66F; 
 Wed, 15 Nov 2023 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700058243;
 bh=ZznhSZNbO2xKOanQ0xWv4Jd6vx+UML5FTN1KeOCLJ/Y=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=HhSvD5O/yu6UcL7khGT/vPOfD/5L5BrFpNW9Zm+Otohjai33FZ8muB66TKHx+7L/9
 WZWQqYZfdhMssP7BN3f0nvRx//h0s1UDzmPvj/TAuPKrjhIwTNqn+kaiTWgBFAFQ35
 vOZSTcf719U047bjYS3h9ElSf3GfxUTLxxZQtzNyD5+QS7ChvDrunWR1rxCs9Q9AnH
 /tZ3EqyU6ScUJX4B98Mko+zFl57vlRgvPp3+10aZzWmHaYaXk+2ufGUWBlqCumfTl9
 ZAO5CW0hnflDEqAyjeyWW8JA6AGNtpxj4+NgDxaTuIOY/NKgQGq/cixRvJLBx5S9FG
 HITsK2Uk6/dUg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/6] risc-v: add ACPI support on QEMU
Date: Wed, 15 Nov 2023 15:23:49 +0100
Message-Id: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

QEMU 8.1.2 can create ACPI tables for the RISC-V architecture.
Allow passing them through to the operating system.
Provide a new defconfig that enables this.

Heinrich Schuchardt (6):
  acpi: do not write ACPI tables on TARGET_QEMU_VIRT
  risc-v: add ACPI fields to global data
  risc-v: add support for QEMU provided ACPI tables
  riscv: qemu: copy ACPI tables from QEMU
  riscv: allow usage of ACPI
  configs: defconfig for QEMU RISC-V with ACPI

 arch/Kconfig                              |  1 +
 arch/riscv/include/asm/global_data.h      |  4 ++++
 board/emulation/qemu-riscv/Kconfig        |  2 ++
 board/emulation/qemu-riscv/MAINTAINERS    |  1 +
 board/emulation/qemu-riscv/qemu-riscv.c   | 17 ++++++++++++++
 configs/qemu-riscv64_acpi_smode_defconfig | 27 +++++++++++++++++++++++
 lib/Kconfig                               |  2 +-
 lib/acpi/Makefile                         |  2 +-
 lib/acpi/acpi_writer.c                    |  2 +-
 9 files changed, 55 insertions(+), 3 deletions(-)
 create mode 100644 configs/qemu-riscv64_acpi_smode_defconfig

-- 
2.40.1

