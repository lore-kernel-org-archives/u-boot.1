Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D3CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C2583214;
	Tue,  2 Sep 2025 10:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Wpjk7+C9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179EC83253; Tue,  2 Sep 2025 10:19:50 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA0983145
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 821A021B02;
 Tue,  2 Sep 2025 10:19:47 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qSE6J-NgfRDV; Tue,  2 Sep 2025 10:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1756801186; bh=fLaWXeHptqR7IqxCNOfXlBy0Xt6V5O7atR7YvtpT8Y0=;
 h=From:To:Cc:Subject:Date;
 b=Wpjk7+C9Vbv7cyv049UkN0CtgLo9XOCD5KsVgXqzImGvKu/L1PazdrVI4fMbAvDPu
 lFpBo0AdO0AFIJCyH51GqHHnSgnhgLsMgv0ScnyBK4BGCEDWWlhvsoPrZBnxpG4ewp
 dyO5XwTPohQRKosTSUyHTRXoN/ubDBVYWdBWTpnwSWcRjlH8TKTDT/oMqmtyHDDxk1
 /cNDp4aGPOJOmHeB8SCnJ+M/Rwxn5LqlI7K9lFy3uNiTQ4o7xzFGIS+WWxYBNN9eDq
 HYHcSii7ucZIvyDUtuCjYG4A/6L+GYIsMNiz1vIz05tnXcoaXfF0AUWxo/trgWRfAl
 h/dUbOK2eZt8g==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 0/3] Support SMP on RISC-V cores with Zalrsc only
Date: Tue,  2 Sep 2025 08:19:29 +0000
Message-ID: <20250902081932.21103-1-ziyao@disroot.org>
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

Previously, we use AMO instructions to synchronize cores at start when
SMP is used, which requires Zaamo extension to present. This series
implements an alternative implementation of synchronization with LR/SC
instructions and add Kconfig options to use them, make it possible to
enable SMP on cores without Zaamo extension.

This is tested on both TH1520 Lichee Pi 4A board and QEMU. With QEMU,
building and testing looks lile,

	$ make qemu-riscv64_defconfig
	$ ./scripts/config -d CONFIG_RISCV_ISA_ZAAMO
	$ make
	$ qemu-system-riscv64 -M virt \
		-cpu rv64,a=off,zaamo=off,zawrs=off,zalrsc=on   \
		-nographic -bios u-boot-nodtb.bin -smp 8

	U-Boot 2025.07-rc4-00456-g2a74e084d720-dirty (Sep 02 2025 - 08:07:58 +0000)

	CPU:   riscv
	Model: riscv-virtio,qemu
	DRAM:  128 MiB
	using memory 0x86ea1000-0x876c1000 for malloc()
	Core:  34 devices, 13 uclasses, devicetree: board
	Flash: 32 MiB
	Loading Environment from nowhere... OK
	In:    serial,usbkbd
	Out:   serial,vidconsole
	Err:   serial,vidconsole
	No USB controllers found
	Net:   No ethernet found.

Changed from v1
- Split changes to ibex-ast2700_defconfig into a separate patch
- Fix several typos
- Improve help text of CONFIG_RISCV_ISA_{ZAAMO,ZALRSC}
- Improve commit message for PATCH 3
- Link to v1: https://lore.kernel.org/all/20250802092155.40915-1-ziyao@disroot.org/

Yao Zi (3):
  riscv: Add Kconfig options to distinguish Zaamo and Zalrsc
  configs: ibex-ast2700: Explicitly disable Zaamo and Zalrsc extension
  riscv: Add a Zalrsc-only alternative for synchronization in start.S

 arch/riscv/Kconfig             | 17 +++++++++++++++++
 arch/riscv/Makefile            |  7 ++++++-
 arch/riscv/cpu/start.S         | 26 +++++++++++++++++++++++++-
 configs/ibex-ast2700_defconfig |  3 ++-
 4 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.50.1

