Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCF9C48BF9
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9419E8744E;
	Wed, 15 Nov 2023 15:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="exmqk04t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA1787197; Wed, 15 Nov 2023 15:24:11 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D8B87203
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 15:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D218640DB4; 
 Wed, 15 Nov 2023 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700058246;
 bh=8+tz2IVY5WagXA61jaz8UrRDY3b2tuNsFgJ/34megCk=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=exmqk04tMSSth+xbVd7o3sFPLG/klwld3nAsnqYojTkX29Sw5IghiO94rin1u7Zoa
 XI0GjhKyQV/8q/5OR6rZwzuLGvbfdwOlgep4YX0KAUNmz3Mio65bYHbW3vcYGkvuit
 GdierkBNbOlN2S3YkomaJPHDbEX4xwhhPP2c7GRLCKPAqn2gxvihSQA/oRr9Wz6+It
 al5JAQVsuRh4qjLVB+c2LKJ73V+APVuCx5SrnS5thhFOxE55sFpRs4LRm8YljOU1/U
 ei/23z9qE3OFSchDAKOiUvaVEwqrufRKqaXTqyVHZc3SBA/XUfJDnE1YCoIecwL9Ya
 +XOzhkfQbw4FQ==
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
Subject: [PATCH 3/6] risc-v: add support for QEMU provided ACPI tables
Date: Wed, 15 Nov 2023 15:23:52 +0100
Message-Id: <20231115142355.123038-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
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

If U-Boot provides ACPI tables on RISC-V QEMU, we need to copy what QEMU
provides.

Provide the qfw command to retrieve information from the QEMU firmware.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-riscv/Kconfig | 2 ++
 lib/Kconfig                        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index d56b4b5bc1..933b035991 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -33,6 +33,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	select GENERIC_RISCV
 	select SUPPORT_SPL
+	select CMD_QFW if GENERATE_ACPI_TABLE
+	select QFW_MMIO if GENERATE_ACPI_TABLE
 	imply AHCI
 	imply SMP
 	imply BOARD_LATE_INIT
diff --git a/lib/Kconfig b/lib/Kconfig
index 19649517a3..a94adc388f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -300,7 +300,7 @@ config SPL_ACPI
 config GENERATE_ACPI_TABLE
 	bool "Generate an ACPI (Advanced Configuration and Power Interface) table"
 	depends on ACPI
-	select QFW if QEMU
+	select QFW if QEMU || TARGET_QEMU_VIRT
 	help
 	  The Advanced Configuration and Power Interface (ACPI) specification
 	  provides an open standard for device configuration and management
-- 
2.40.1

