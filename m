Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1D6C48BF9
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666E487444;
	Wed, 15 Nov 2023 15:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nEtW7dLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B68087197; Wed, 15 Nov 2023 15:24:07 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB7F87208
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
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7F08140DB1; 
 Wed, 15 Nov 2023 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700058245;
 bh=RrsePNR0D8+qIn2bp+BPZSkBcpPLUgdSlPh0m89/Tbs=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=nEtW7dLR7s14GFLtPmcZvP417XxPL4NW00vD0itZ2jpizeOfuGksaidG40pFOIyUX
 h9RLdgO5X0x7J7CnqQZ0cfnjS2xdcYOtSVvl/yijU3hIq6/zqc/siC79Pze8Pb3tEv
 S9NVll1s3qSWPVYor1bbRflUh7WS2PqECEl/KUJbcj6XeeRavgQOjs/aLobKwLKZJr
 os78M3yiGxiOHumfjJUompIHwp3gnadMkwlx4V0H2C19D0CI+380ZzEvoobfjp203+
 RmD8JmnX8STqphtOCIXm7hNv+n7DCg7XMHeTRFgAgB60/jIaLPoIXH5dbzl1hs4xAC
 6Re+aHv9YLf9A==
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
Subject: [PATCH 1/6] acpi: do not write ACPI tables on TARGET_QEMU_VIRT
Date: Wed, 15 Nov 2023 15:23:50 +0100
Message-Id: <20231115142355.123038-2-heinrich.schuchardt@canonical.com>
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

RISC-V QEMU provides the ACPI tables. We do not need to generate them
ourselves.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/acpi/Makefile      | 2 +-
 lib/acpi/acpi_writer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/acpi/Makefile b/lib/acpi/Makefile
index c1c9675b5d..19fa6ac869 100644
--- a/lib/acpi/Makefile
+++ b/lib/acpi/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_$(SPL_)ACPIGEN) += acpi_table.o
 obj-y += acpi_writer.o
 
 # With QEMU the ACPI tables come from there, not from U-Boot
-ifndef CONFIG_QEMU
+ifeq ($(CONFIG_QEMU)$(CONFIG_TARGET_QEMU_VIRT),)
 obj-y += base.o
 obj-y += csrt.o
 obj-y += mcfg.o
diff --git a/lib/acpi/acpi_writer.c b/lib/acpi/acpi_writer.c
index 946f90e8e7..df547c945b 100644
--- a/lib/acpi/acpi_writer.c
+++ b/lib/acpi/acpi_writer.c
@@ -48,7 +48,7 @@ int acpi_write_one(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	return 0;
 }
 
-#ifndef CONFIG_QEMU
+#if !defined(CONFIG_QEMU) && !defined(CONFIG_TARGET_QEMU_VIRT)
 static int acpi_write_all(struct acpi_ctx *ctx)
 {
 	const struct acpi_writer *writer =
-- 
2.40.1

