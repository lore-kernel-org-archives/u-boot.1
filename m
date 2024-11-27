Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97C5D609A8
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 07:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C637189776;
	Wed, 27 Nov 2024 08:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LLXuQWAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E948978B; Wed, 27 Nov 2024 08:06:45 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53C389768
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 08:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E00004093E; 
 Wed, 27 Nov 2024 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732691200;
 bh=vW44iktlWPdRzxaMCP/RWnYSsFYSVwgWRXavKTxXPUU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LLXuQWAZgMWdVq77sr8R4hw4kYn7uapygkjy2KNb2u2YU+xrdPT3s8epgWGxukkBq
 heHBqc1BO6OPHEELM1izcmlU54X5etAIlz+5/G5n721HQi15gG6o8+IxfZqszuERIb
 OYARZJyvWzy9+2yRQDpTTrKvJDE4tqsormqyhLG4kjLmFuGRAqm1nOEpVNHB/0mcha
 mzQCglsIzV4jT30iWolfsyAocIwAJFW6J+4YM7XVzoBFlYgfd4K/tD2aa7Ded4KDQi
 8cMpLGvztezSbH02BCzBTAzj+BUxYwueV4R9JiP9FaEuFjffJVzPPmLrsP7JyMAvGv
 JPp6h3/9NWrrA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/6] efi_loader: run bootdev_hunt() to find ESP
Date: Wed, 27 Nov 2024 08:06:25 +0100
Message-ID: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
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

When initializing the EFI sub-system we need all block devices and the
NIC to be probed. Extensions should have been applied to the device-tree.

Our current implementation only guarantees that bound block devices are
probed. But this misses out devices where binding requires specific
routines to be executed, e.g. NVMe (nvme scan), SCSI (scsi start).

Invoking bootdev_hunt() allows to find all block devices, probe the
network nic, and enable extensions.

Reviewers complained that PXE boot was executed unexpectedly with a patch
that only added the bootdev_hunt() call to the EFI sub-system
initialization.

The EFI sub-system does not require the IP address to be set up. We can
reduce the boottime by not executing dchp_run() in eth_bootdev_hunt().

Furthermore on the legacy network stack with autostart=yes dhcp_run()
tries to download the boot file via TFTP and execute it which seems
to be a problem with non-observance of autoload=no.

To fix Gitlab CI issues the following changes are necessary:

In test_extension.py do not assume that extensions have not been loaded
by bootdev hunter in a previous test.

Remove CONFIG_AMIGA_PARTITION from sandbox_deconfig to avoid a timeout.

Remove CONFIG_USB_DWC3 on the CI from xilinx_versal_virt_defconfig to
avoid a boot failure.

Add a parameter '-e' to select if UEFI boot options shall be shown by
the bootmenu command.

v2:
	disable USB_DWC3 only in CI
	update commit message for eth_bootdev_hunt() change

Heinrich Schuchardt (6):
  test: fix test_extension.py
  configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
  CI: xilinx_versal_virt: disable USB_DWC3
  net: eth_bootdev_hunt() must not try to boot
  cmd: bootmenu: add parameter -e for UEFI boot options
  efi_loader: run bootdev_hunt() to find ESP

 .azure-pipelines.yml            |  1 +
 .gitlab-ci.yml                  |  1 +
 cmd/bootmenu.c                  | 39 +++++++++++++++++++++++++--------
 configs/sandbox_defconfig       |  1 -
 doc/usage/cmd/bootmenu.rst      | 13 ++++++++---
 lib/efi_loader/efi_setup.c      |  8 +++++++
 net/eth_bootdev.c               | 30 +++++++++++++++----------
 test/py/tests/test_extension.py |  4 +++-
 8 files changed, 71 insertions(+), 26 deletions(-)

-- 
2.45.2

