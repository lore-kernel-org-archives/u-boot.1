Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD05EE77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F99080326;
	Fri, 20 Dec 2024 01:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KOsymdOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32918033A; Fri, 20 Dec 2024 01:38:03 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93F780312
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-157.46.114.pool.telefonica.de
 [46.114.111.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4F89E3F788; 
 Fri, 20 Dec 2024 00:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734655081;
 bh=ps2rsCg5PKmvyaYVpUyvo35QehLtGw/Zc+bYPSP1zEI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KOsymdOhIoQ4a6bhxqUXcRyyNcYnSGeCAi8ex4MNFalTrGDYobXDaaK/kXvuZg3fU
 2bGnN6swKBnC9FZQeOHwsEX+zxS4sYbF4AFkN+WgAZerS6ehCrFBcI8P4QL07LO1aj
 L9tlN9cLhGBxySP5+kgnEnfnncoYNeNzw/6q5R/L1Wn3eTkSjJ46MsNAHx0wZZ92jk
 5ehrmxYx7HirymhSn0si9eLX1PQX4qOQ3m78V4F6tdIHqCnQjIpLkuEP//eQ7+czek
 wi3mF2zn2SnoMf9JFEW28OE0ZLVqoMXhrIBb8r9/9900DPQe+XI06eJS5kVL3/sgT3
 wnITlduzlNdHg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: don't fill FADT, MADT if CONFIG_QFW_ACPI=y
Date: Fri, 20 Dec 2024 01:37:59 +0100
Message-ID: <20241220003759.89252-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

When using the ACPI tables supplied by QEMU, we don't need to build the
FADT and MADT tables in U-Boot.

This patch avoids a build failure

    make qemu-riscv64_smode_defconfig acpi.config

    riscv64-linux-gnu-ld.bfd: lib/acpi/acpi_table.o:
    in function `acpi_write_fadt':
    lib/acpi/acpi_table.c:265:(.text.acpi_write_fadt+0x15c):
    undefined reference to `acpi_fill_fadt'

    riscv64-linux-gnu-ld.bfd: lib/acpi/acpi_table.o:
    in function `acpi_write_madt':
    lib/acpi/acpi_table.c:294:(.text.acpi_write_madt+0x52):
    undefined reference to `acpi_fill_madt'

Fixes: f5f7962091e4 ("acpi: x86: Write FADT in common code")
Fixes: 4a3fc0f525da ("acpi: x86: Move MADT to common code")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/acpi/acpi_table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 150f75027a5..c0ed24984af 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -273,7 +273,9 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	return acpi_add_fadt(ctx, fadt);
 }
 
+#ifndef CONFIG_QFW_ACPI
 ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
+#endif
 
 int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
@@ -308,7 +310,9 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	return 0;
 }
 
+#ifndef CONFIG_QFW_ACPI
 ACPI_WRITER(5madt, "MADT", acpi_write_madt, 0);
+#endif
 
 void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 		      int port_type, int port_subtype,
-- 
2.47.1

