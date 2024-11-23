Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7084E66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1FF89152;
	Sat, 23 Nov 2024 22:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UEiO7ruL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A99189248; Sat, 23 Nov 2024 22:46:42 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E3588EA8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DC6F340276; 
 Sat, 23 Nov 2024 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732398399;
 bh=y/lErFB0Me2RNyV5jPPObQy+T7FUvS6VkXyHTRyThko=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=UEiO7ruL0XfnBkuiJtLWA6qAmLkhQQ/9sreP3bLjodVRobq30dtZHCSqvD1tYYMvj
 vV1gD+9vucPELQCbz6fOmeYmrqWOoIkVwOw5maSDIwWIPNDi3WhlL3/c/SFz88e1dq
 ouhJEEMV0I5T2AOwn3HsdktS68GB+ySknFqf4Cyi6KUgspmGTYFIBNWO7y33FVC35w
 AFTf1t923XAGbrX8LnKPc3E0MdasiJgJRAXr5YAEFJ0bJa5W4pXFRZVziTMZNKM0Fa
 JeP5PrPd8wzIClcH6V9besAoKXK5YlQew3hNSTe07r7elMMr+AUbgGQC7WD5hhHeBe
 sIibq2f/sQh6w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/6] efi_loader: run bootdev_hunt() to find ESP
Date: Sat, 23 Nov 2024 22:45:48 +0100
Message-ID: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Some hard devices need specific routines to scan for block devices,
e.g. NVMe (nvme scan), SCSI (scsi start).

Invoke bootdev_hunt() to find all block devices.

Reviewers complained that PXE boot was executed unexpectedly.
eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
a file and boot it if autostart=yes. Instead just check that there is a
network device.

To fix Gitlab CI issues the following changes were necessary:

In test_extension.py do not assume that extensions have not been loaded
by bootdev hunter in a previous test.

Remove CONFIG_AMIGA_PARTITION from sandbox_deconfig to avoid a timeout.

Remove CONFIG_USB_DWC3 from xilinx_versal_virt_defconfig to avoid a boot
failure.

Add a parameter '-e' to select if UEFI boot options shall be shown by
the bootmenu command.

v2:
	Do not run dhcp_run() in eth_bootdev_hunt().
	In test_extension.py do not assume initial state.
	Remove CONFIG_AMIGA_PARTITION from sandbox_deconfig.
	Remove CONFIG_USB_DWC3 from xilinx_versal_virt_defconfig.
	Add a parameter '-e' to bootmenu command.

Heinrich Schuchardt (6):
  test: fix test_extension.py
  configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
  configs: xilinx_versal_virt: disable USB_DWC3
  net: eth_bootdev_hunt() must not try to boot
  cmd: bootmenu: add parameter -e for UEFI boot options
  efi_loader: run bootdev_hunt() to find ESP

 cmd/bootmenu.c                       | 39 +++++++++++++++++++++-------
 configs/sandbox_defconfig            |  1 -
 configs/xilinx_versal_virt_defconfig |  2 --
 doc/usage/cmd/bootmenu.rst           | 13 +++++++---
 lib/efi_loader/efi_setup.c           |  8 ++++++
 net/eth_bootdev.c                    | 30 ++++++++++++---------
 test/py/tests/test_extension.py      |  4 ++-
 7 files changed, 69 insertions(+), 28 deletions(-)

-- 
2.45.2

