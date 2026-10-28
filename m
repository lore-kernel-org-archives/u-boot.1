Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06911606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FmsEe8mU;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gc7MvEvC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA9F180DC4;
	Wed, 28 Oct 2026 06:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZzuPTmOz8FI; Wed, 28 Oct 2026 06:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D722080815
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793168036;
	b=nY9hB1Wz8T1cJutkG3/qwq+iiwZh0sXdcOAbfECXGtpTuAczfbskypWHCh4Rka/E13Tx
	 r2ehW+UlwiYJ7KC4i16lHl03VYOHf5zo/DdYdWEd/rzH7JAxFf6JA07dQxXfjvDWwdkZW
	 S2LroU33GtQgiwSvuF5YnJaUK3iJt21A+3KoxJGSsLtLahNN8BOPmXKb5M0Kbnn0EXuXE
	 Tx1fdw9SW4tDmVauMo882U27NnpRUebjHBjtVZjgnqqOrgKAnkW1SQwJ8TCu3TTVBIOrA
	 0J/7Y9CkgH9kSF/1mdDK69HuW8Q+lPcnb2U1m8Ar38T7S2XHzKHCpALwr0AKKkRIUEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793168036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Cn93WHUJgLQrVqzf3QhBJLSPKxNqJ1kspitS8Ty+PmM=;
	b=s7PwDxAkZq75NBfHY4fDSLVR6NZCDEu+UZ+lA3MSRem1286hynsQBCjKMxtYEXWRIpwP
	 DS+Kr7KyfQjfdppsETBMMrwhA+gmi3aMrOzFkMGY1UALAefvceOyeZRcKrjeIgmay4loD
	 QlxiCZPhh7rfC+OxlA1YYQK1fGrX5YomnNsHw43lfJUlTWFowFuuJMK9pBjRzq+0jiOIX
	 qrqldsXMEgZa7b2qB7n5VCjygsecPeh/3njjIBfe7vJ9L4130l9bAy3Sn1OWNYYj9JXpk
	 7gkQdnJOASh1yMqCtnX957/XaMPQvoPbyB+lZYfkLXbMzy6H9Adlu3g4SDevs1dNXQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gc7MvEvC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793168036;
	bh=Cn93WHUJgLQrVqzf3QhBJLSPKxNqJ1kspitS8Ty+PmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FmsEe8mUa++BuIk+rLF8uvsIQj+uqQ4ykerwGlE7aanReq4QokH3KRYtgOmR2HHdh
	 IYlvyv/+2UFkhrXW+yPG00EMtviA2yf4TEEYmzDN1WHoDOBYVSmQHHz8vqZS2EyVM+
	 tVNMdn1PrKWiGzXe1kQw8ra5QpcpmwKB/Kdoa8ThJzT1XG7CgTDtgB2g/cTbrUwYHk
	 u7TKF+NkPixuvyr+FMaL8BEElIbLsh9aJxjnVJR1LRr6Z/OpHY3/66SUlwo4LVOKU3
	 ywhKyE/Fi2kNownstsN+MMHa475pfNGCujWaq5HQP7QacECNesQ8rmg6TpOUSRHB2o
	 kK/xqVqEFSyUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D722080815;
	Wed, 28 Oct 2026 06:13:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E915B2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D978080815
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ug2PzgNFBUZ2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:13:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC6AE80760
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793168033;
 b=USlrHqnr/K1QMnqTHEEfSfdMi2WbRpUAsrD+CTlrYQU9cNHEknNuyPnFWvmOBIyWVSbU
 DOsWXkpEnLhNvj8eupd9V4Lwct6PLTEeEkFMcqbuzfip+jlTP2CRZuVQIV3+qg2wd46eV
 ukocRlvJzk6CCRaxxUTwFX/1QHyU2fOFqGOB3K5nUp+8k2B+YsRR+oiwYefEWfE4RwrfH
 ywAiKvVQuvEaVXsdQWnQG/tosTCnC/GrKd4jA1fHJz3MMinIqSgsSYnTTuS04KGSMIXkJ
 JO/Qp68G2vYdd1r0nIKvZP7Vg+IDVFI0ZCmbW8TBs/wjCAT79v/+cH6pDQsoqy6bQXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793168033;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Cn93WHUJgLQrVqzf3QhBJLSPKxNqJ1kspitS8Ty+PmM=;
 b=dpl8HlPT2wzb78ufOAM83Ve7Tq6s+4MLtYa1DpfEWwR8OOsMs2nc/G7XulqX59B0KdSP
 07KU43dWTucimeF3OX1/RArCchjmacCPiaxVNj0pNliqRPeAwhEzMEQmAu0Ocix22AbQ0
 x6JqQJeHYNMBw+CEIW4y1B3PFj0VLYErASgpGxVN2LbeJ8d5QeF99p6Yz+kZmXMMsLDJz
 y6NKWVij15SURwd/XChet1o2+G4jOypWi8nY6QZmzyNpCmQWAQJuslHh1EVKR0B94oIIk
 WV2zGPNVf3RRcbkDF7C0Vfqj/MJbRgGsg8hfGUyZ679+Ii4DOdIoPdE9OSgf7bh/Hcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=gc7MvEvC; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=gc7MvEvC
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC6AE80760
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 86F7910BA4D; Wed, 28 Oct 2026 07:13:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793168027; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Cn93WHUJgLQrVqzf3QhBJLSPKxNqJ1kspitS8Ty+PmM=;
 b=gc7MvEvC5LDQNHfFNNK8ZCPLdmOZ0I5jGymZvJ/Q1DxZldU0WyNTGpzhsmvX/Xqj84b7/A
 Mnk+3Ab6jLzycwPuG/kK8SFG6KQ2lIa24aehEz19/wUamdKbLf612h1TaOZy+SrlsNwMHf
 O9w1f/Ow3+xBAO3uWNp9PTkHhgZC4viywZMfPvlkOFgkifKD40Lv45stczVYqqrGENBM44
 r6JPDIwuJhAsGAgP00gV2SB5V4NMNMoZNSg08xWDpUZEZiLh1vC/VaAyP5NDmhgzht/H4U
 gMKRe5fbXx3uMZj7I1QWmEXBcFbTen8i1y5+0E0lgmz3jFtEgNqy6kHwhfBLNQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marex@nabladev.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Romain Caritey <romain.caritey@microchip.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 6/7] cmd: mtd: get through a device that has no erase size
Date: Wed, 28 Oct 2026 07:11:40 +0100
Message-ID: <20261028061231.39152-7-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028061231.39152-1-hs@nabladev.com>
References: <20261028061231.39152-1-hs@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mtd_is_aligned_with_block_size() divides by mtd->erasesize, which a
device of type MTD_RAM does not have, so "mtd read", "mtd write",
"mtd dump" and "mtd erase" all end in a division by zero.

Take a missing erase size as "nothing to align to", and refuse an erase
on the condition mtd_erase() refuses on, before the line announcing it
divides through mtd_div_by_eb().

The test sits in test/cmd/ as the mtd command walks a global list that
outlives the device tree a driver model test replaces.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
checkpatch asks for a blank line after the test function, before the
CMD_TEST() that registers it. But in test/cmd/ all over is without a
blank line, so ignore this warning.

Changes in v3:
- New patch. Patch 1 only covers mtd_erase(), the mtd command divides by
  the erase size before it ever gets there.

 MAINTAINERS       |  1 +
 cmd/mtd.c         | 14 +++++++++
 test/cmd/Makefile |  3 ++
 test/cmd/mtd.c    | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 test/cmd/mtd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f3fe3597d6e..83d040b3e75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1668,6 +1668,7 @@ M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	drivers/mtd/devices/mchp23k256.c
 F:	drivers/mtd/devices/mchp23k256_sandbox.c
+F:	test/cmd/mtd.c
 F:	test/dm/mchp23k256.c
 
 SPI-NOR
diff --git a/cmd/mtd.c b/cmd/mtd.c
index ed827accfb5..1f3a9ad0779 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -53,6 +53,10 @@ static bool mtd_is_aligned_with_min_io_size(struct mtd_info *mtd, u64 size)
 
 static bool mtd_is_aligned_with_block_size(struct mtd_info *mtd, u64 size)
 {
+	/* A device with no erase blocks, a RAM say, has nothing to align to */
+	if (!mtd->erasesize)
+		return true;
+
 	return !do_div(size, mtd->erasesize);
 }
 
@@ -642,6 +646,16 @@ static int do_mtd_erase(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (IS_ERR_OR_NULL(mtd))
 		return CMD_RET_FAILURE;
 
+	/*
+	 * The same condition mtd_erase() refuses on. Every step below works
+	 * in units of the erase size, so there is nothing to do here either.
+	 */
+	if (!mtd->erasesize || !mtd->_erase) {
+		printf("%s cannot erase\n", mtd->name);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
 	scrub = strstr(argv[0], ".dontskipbad");
 
 	argc -= 2;
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index e734933d5f7..4afd83d836f 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -28,6 +28,9 @@ obj-$(CONFIG_CMD_LOADM) += loadm.o
 obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
 obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
 obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
+ifdef CONFIG_CMD_MTD
+obj-$(CONFIG_MTD_MCHP23K256_SANDBOX) += mtd.o
+endif
 obj-$(CONFIG_CMD_PART) += part.o
 ifdef CONFIG_CMD_PCI
 obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
diff --git a/test/cmd/mtd.c b/test/cmd/mtd.c
new file mode 100644
index 00000000000..a17377bc570
--- /dev/null
+++ b/test/cmd/mtd.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for the mtd command on a device without an erase size
+ *
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <mapmem.h>
+#include <mtd.h>
+#include <dm/test.h>
+#include <linux/mtd/mtd.h>
+#include <test/cmd.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* The SPI SRAM of the test device tree, an MTD device of type MTD_RAM */
+#define MTD_RAM_PATH	"/spi@1/sram@0"
+
+#define MTD_RAM_SRC	0x0
+#define MTD_RAM_DST	0x100
+
+/* Neither offset nor length is a multiple of any usual erase block */
+#define MTD_RAM_OFFSET	0x1f
+#define MTD_RAM_LEN	0x64
+
+static int cmd_test_mtd_ram(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	struct mtd_info *mtd;
+	u8 *out, *in;
+	int i;
+
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_MTD,
+						ofnode_path(MTD_RAM_PATH),
+						&dev));
+	mtd = dev_get_uclass_priv(dev);
+	ut_asserteq(0, mtd->erasesize);
+
+	/*
+	 * The first MTD command probes all devices, so output from other
+	 * drivers during probing is irrelevant to this test.
+	 */
+	ut_assertok(run_command("mtd list", 0));
+	console_record_reset();
+
+	out = map_sysmem(MTD_RAM_SRC, MTD_RAM_LEN);
+	in = map_sysmem(MTD_RAM_DST, MTD_RAM_LEN);
+	for (i = 0; i < MTD_RAM_LEN; i++)
+		out[i] = 0x5a + i;
+	memset(in, 0, MTD_RAM_LEN);
+
+	ut_assertok(run_commandf("mtd write %s 0x%x 0x%x 0x%x", mtd->name,
+				 MTD_RAM_SRC, MTD_RAM_OFFSET, MTD_RAM_LEN));
+	ut_assert_nextline("Writing %d byte(s) at offset 0x%08x", MTD_RAM_LEN,
+			   MTD_RAM_OFFSET);
+	ut_assert_console_end();
+
+	ut_assertok(run_commandf("mtd read %s 0x%x 0x%x 0x%x", mtd->name,
+				 MTD_RAM_DST, MTD_RAM_OFFSET, MTD_RAM_LEN));
+	ut_assert_nextline("Reading %d byte(s) at offset 0x%08x", MTD_RAM_LEN,
+			   MTD_RAM_OFFSET);
+	ut_assert_console_end();
+	ut_asserteq_mem(out, in, MTD_RAM_LEN);
+
+	/* The erase has to be refused, not divided by the missing block size */
+	ut_asserteq(1, run_commandf("mtd erase %s 0x%x 0x%x", mtd->name,
+				    MTD_RAM_OFFSET, MTD_RAM_LEN));
+	ut_assert_nextline("%s cannot erase", mtd->name);
+	ut_assert_console_end();
+
+	unmap_sysmem(in);
+	unmap_sysmem(out);
+
+	return 0;
+}
+CMD_TEST(cmd_test_mtd_ram, UTF_CONSOLE);
-- 
2.55.0

