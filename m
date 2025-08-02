Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326F9C87FC9
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 09:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589F283C19;
	Sat,  2 Aug 2025 11:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="YZkd439i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C12783C13; Sat,  2 Aug 2025 11:22:15 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED4383B5F
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 11:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 584CE25CBC;
 Sat,  2 Aug 2025 11:22:12 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_i2vfKPanF0; Sat,  2 Aug 2025 11:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1754126531; bh=RMFbEcBDSST4MZ6iBBz3xLY1bjJmYaeBC4ah6Gtrl+w=;
 h=From:To:Cc:Subject:Date;
 b=YZkd439il31RfRvwlhFxi1U3lYxoSBN+o6oEBFtDo5+NDz1uKJer+M29TBDsV6jD3
 iCtDwevPjFHMY4MIGZcPj25y04HstyTc4QOYmp8x5WwZB6OaKmCv1g33R6cQJEbSzq
 knmlOZB9gK7IUY7x3XIB4iWZmj9pAg1K92nFxUd2oEEwoe+2Ii/vh7SLq3fZD498Ft
 Om7qlOzpxvGxtdpbVt+CsUuiNsDkuyhzKdGQIY1o3fXSS7iOBf9dNdSIk+X5tS8KBb
 jLcDUjysCjSMeWtZL60MBLWtPR8wA/DY41ocnA3yKzTI1V/Y0e+fXghg5xc3PAdpvT
 ggtG1i26Sx1+g==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/2] Support SMP on RISC-V cores with Zalrsc only
Date: Sat,  2 Aug 2025 09:21:53 +0000
Message-ID: <20250802092155.40915-1-ziyao@disroot.org>
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
		-cpu rv64,a=off,zaamo=off,zawrs=off,zalrsc=on	\
		-nographic -bios u-boot-nodtb.bin -smp 8
	U-Boot 2025.10-rc1-00100-gc5bdc8820ee2-dirty (Aug 02 2025 - 09:16:21 +0000)

	CPU:   riscv
	Model: riscv-virtio,qemu
	DRAM:  128 MiB
	using memory 0x86eb5000-0x876d5000 for malloc()
	Core:  34 devices, 13 uclasses, devicetree: board
	Flash: 32 MiB
	Loading Environment from nowhere... OK
	In:    serial,usbkbd
	Out:   serial,vidconsole
	Err:   serial,vidconsole
	No USB controllers found
	Net:   No ethernet found.

without this series, U-Boot won't run if Zaamo is disabled with
-cpu rv64,zaamo=off.

Yao Zi (2):
  riscv: Add Kconfig options to distinguish Zaamo and Zalrsc
  riscv: Add a Zalrsc-only alternative for synchronization in start.S

 arch/riscv/Kconfig             | 17 +++++++++++++++++
 arch/riscv/Makefile            |  7 ++++++-
 arch/riscv/cpu/start.S         | 26 +++++++++++++++++++++++++-
 configs/ibex-ast2700_defconfig |  3 ++-
 4 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.50.1

