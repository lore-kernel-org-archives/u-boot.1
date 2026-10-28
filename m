Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=um69awfO;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=VWBcVZ3C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A62180E7F;
	Wed, 28 Oct 2026 06:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccJl0RiXHYwq; Wed, 28 Oct 2026 06:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8360480E79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793168043;
	b=bZYxeSVITo8i+q0M1f6bJ30PZI42nVBFT1fiyBRSbD+j/Y2tdOZ0hlW5jEasUI1Te3Lc
	 GQ30NQUsqmpfi4WCBTPBrEWlRjlRYR3bvilKerna7Uoc/gKWgwXERanlaTv+WnkLGBJ1G
	 aNfV9zb8BwoAM2SyMzU/DxXegngcbr1ziwiSYBJLxYRqgBl+qo6xJg/KNjxiSPaVkmwFg
	 UHJXvO8O/FbZxOpau3B3jHGNbtmOgQkyuGHZhnSf0P8zsIC3Uio5eY0pVlOS/qPesA8HK
	 MiWLr9R5TqsRj7hYjZ8PlDNvslINhVAxsYwsnkUQc6Gq2P5l/kDcZFOL/pRvA255CTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793168043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0pHOcIIPuoXgddGXsUTU6UqmiuiYIBleeTnS7b+Efb4=;
	b=lPQbo7j7NPH+lrRN9bl2HUq6MkrVhN5JdjVfoetZmcbKQsDX0mREJvJ116l/Aiu6m3iS
	 UZDoWBy/jKYlwbzyHAu/ulG2KvkZmZsjQMS00Ee7yrTZmM5tX7yHLgHhzFIHgA0+rS1CU
	 GQqF71PwZlLZ1ncJ7sX59w8GMRdwHxyUOVoW7NVaYZN/tOuP84qCVpcJpA9dXM0lDbk7h
	 Yuv249dY39OT6QCdKqK+ivikUKZfXKonkQjmDSJKljDwEhP7twQxesZ634tOGW59537D4
	 bX72dAOTBeH00Kt969/p7rvKSbKfmQwuysqePPAtHeuwvNQkE0kKFeTxVISbjrYe2Uw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793168043;
	bh=0pHOcIIPuoXgddGXsUTU6UqmiuiYIBleeTnS7b+Efb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=um69awfOVZCsQCBg1sAHUAl1oepsK7bKJ5s/2v0I3zmMmfKB1pb+hSDBYHsAoE/OX
	 u0438qupNEindDEyk+fqYyRaIgeip02zA8TUdzyFmJZDARLAkurEKtNv+Chh78jThe
	 4zLTJbnBpsEgFvBv0k1QX8vSzZbZBCc8ydE6bDoMBVaVX/lLDArd5uE9A3Ro3nEQFB
	 bWGv33tfqYkaxrQea0azOf74GvZimWYKIo2bm38aSXFuq1fDGp+ro59T4WKVJPALP2
	 Gtc69wQN6xsNDer5pcfCZFbDCXAMqw40lbB3CSe8qR8NZaxFE9tolzp1KyNGGBeSyx
	 LAJkD5k4QdHRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8360480E79;
	Wed, 28 Oct 2026 06:14:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52A36D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 449BC606DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ct_6X7L_RSVI for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:14:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 26BA3605AF
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793168040;
 b=VIuau5qZ2I3Q/e4ah0Nq3SWDidtCLBpAH2o5PAKYQSUIgwb6Peoza9//vcgyxHX8XWTM
 wtOzz9/MStaloT2pqgjTMekNQK0hxHPYrpLGysPUH2iRq6F8Z2tedjtQtgtdU4Wmyg0wJ
 Q4eSOPgUYdANnUvmDopzF+8M+3PNwzdn82aV3Pd8eG7aJACnQ06SOPRoJf7flOOZmtXj4
 wstmlKGjAbKTCo3Xnt7QCHnmoB0T8l2O3rRgoSTNtP/T/8aMDsaogsPQmBHl6LDC2T7Gg
 eimV6Y2MQVpX3lO9P0QHDzv9GwGJonjBYOBP0HI3UuBnr/CUSXV9h6ZwEs1fNTl880A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793168040;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=0pHOcIIPuoXgddGXsUTU6UqmiuiYIBleeTnS7b+Efb4=;
 b=U0OeIF9bqViXHBqVYxDCmfGDe2I8ycV90kHh5zOqNdYo5B7gUuHPRI4plSVSXBAP9TTV
 f3JOKQk6XCb3L0xsPieY3Q/fzFMgRY1Rl20vXcOddwOJAHUEZEha9XgrHTymNr41hjT5O
 SA3YyFB2jNAtO5O9EB+3Es06U7uD27j0nMm9vc7QvU9ShLJ3O8jmor284BExlW0SMywas
 ro+P427JCKbh8I/OvJlkow+kdylNzFdGN0VHX25SHrsA6qTRD0NznMfpxeAOYpFJACFo+
 d7QwdMUB6pKabxEJMbpNa1gCwJvlzl1u/DjRxx7lxhtXNv0jMFMQxty8sOnGjN8iSdg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VWBcVZ3C; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=VWBcVZ3C
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26BA3605AF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7DEBB10BB08; Wed, 28 Oct 2026 07:13:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793168031; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=0pHOcIIPuoXgddGXsUTU6UqmiuiYIBleeTnS7b+Efb4=;
 b=VWBcVZ3CPcsvyCalsYCzVh5gpqWbUqP7DiEeS/8DBpEuqnftzEe5mAx3nKwKJD6tZKM40k
 G2eEIJcG6gU12esusG8kfx8AarAANfdCxQnmSzIwn/900BKDVTQ3/gdToIWU/CMgQeAAZT
 o5m44qzUriJoLDeJdmBW0JU+afkHjlanU6U7NomQMoy6aoYkK5evplvYIpfT/im+vhXYHe
 GPYrdWdb8EUR03G8HKbcQVKj8TZlcge9wal7YAYncADJbZzYKZmgUqnKWoIA4HBEk5VC6I
 1MSBi8jpL9UAun08JFuDL92TB4lSoeMu7Tpo2EWSWTszwcVjtd4QYwV+ea5M/g==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 7/7] mtd: mchp23k256: move the transfers to spi-mem
Date: Wed, 28 Oct 2026 07:11:41 +0100
Message-ID: <20261028061231.39152-8-hs@nabladev.com>
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

A read or a write of the whole array goes out as one transfer, which
fails on a controller that limits the transfer size or only offers
spi-mem operations. spi-mem answers both, as spi_mem_adjust_op_size()
cuts an operation to what the controller takes and spi_mem_exec_op()
claims the bus per operation, so the driver needs no explicit bus
claim.

The test sets a transfer size smaller than the data length, forcing
the loop to process multiple chunks.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
checkpatch asks for a blank line after the test function, before the
DM_TEST() that registers it. But in test/dm/ all over is without a
blank line, so ignore this warning.

Changes in v3:
- New patch. Simon pointed out that a single spi_xfer() over the whole
  array fails where the SPI NAND driver would work

 drivers/mtd/devices/Kconfig      |  1 +
 drivers/mtd/devices/mchp23k256.c | 88 ++++++++++++++++++++------------
 test/dm/mchp23k256.c             | 44 ++++++++++++++++
 3 files changed, 99 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 0ba17618f1b..3f0ee428712 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -3,6 +3,7 @@
 config MTD_MCHP23K256
 	bool "Microchip 23K256 and 23LCV1024 SPI SRAM"
 	depends on DM_SPI && DM_MTD
+	select SPI_MEM
 	help
 	  Enable support for the Microchip 23K256 and 23LCV1024 serial SRAMs,
 	  a 32 KiB and a 128 KiB SRAM on an SPI bus, the latter with battery
diff --git a/drivers/mtd/devices/mchp23k256.c b/drivers/mtd/devices/mchp23k256.c
index 624fb9e65e1..06c422dfe58 100644
--- a/drivers/mtd/devices/mchp23k256.c
+++ b/drivers/mtd/devices/mchp23k256.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <spi.h>
+#include <spi-mem.h>
 #include <vsprintf.h>
 #include <linux/bitops.h>
 #include <linux/mtd/mtd.h>
@@ -23,9 +24,6 @@
 /* MODE register, bits 7:6 select byte, page or sequential operation */
 #define MCHP23K256_MODE_SEQ		BIT(6)
 
-/* The widest address of the supported parts, in bytes */
-#define MCHP23K256_ADDR_MAX		3
-
 /**
  * struct mchp23_caps - what one supported device looks like
  *
@@ -50,8 +48,10 @@ struct mchp23k256_priv {
 /**
  * mchp23k256_command() - run one read or write command over the whole length
  *
- * Sequential operation was selected during probe, so the device serves a
- * transfer of any length from a single command and the bus is claimed once.
+ * Sequential operation was selected during probe, so the device serves
+ * a transfer of any length from a single command. spi_mem_exec_op()
+ * claims the bus for each operation, so the driver never calls
+ * spi_claim_bus() itself.
  *
  * @dev:	the SRAM device
  * @opcode:	MCHP23K256_CMD_READ or MCHP23K256_CMD_WRITE
@@ -67,26 +67,52 @@ static int mchp23k256_command(struct udevice *dev, u8 opcode, u32 offset,
 	const struct mchp23_caps *caps =
 		(const struct mchp23_caps *)dev_get_driver_data(dev);
 	struct spi_slave *spi = dev_get_parent_priv(dev);
-	u8 cmd[1 + MCHP23K256_ADDR_MAX];
-	uint i;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
+					  SPI_MEM_OP_ADDR(caps->addr_width,
+							  offset, 1),
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(0, NULL, 1));
+	const u8 *out = data_out;
+	u8 *in = data_in;
 	int ret;
 
-	cmd[0] = opcode;
-	for (i = 0; i < caps->addr_width; i++)
-		cmd[1 + i] = offset >> (8 * (caps->addr_width - i - 1));
-
-	ret = spi_claim_bus(spi);
-	if (ret) {
-		dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
-		return ret;
+	if (!in)
+		op.data.dir = SPI_MEM_DATA_OUT;
+
+	while (len) {
+		op.data.nbytes = len;
+		if (in)
+			op.data.buf.in = in;
+		else
+			op.data.buf.out = out;
+
+		/*
+		 * A controller may move less than asked for in one operation,
+		 * which is what the loop is for. The device takes the address
+		 * of every operation, so the pieces need no order.
+		 */
+		ret = spi_mem_adjust_op_size(spi, &op);
+		if (ret) {
+			dev_dbg(dev, "cannot size the operation: %d\n", ret);
+			return ret;
+		}
+
+		ret = spi_mem_exec_op(spi, &op);
+		if (ret) {
+			dev_dbg(dev, "operation at 0x%llx failed: %d\n",
+				op.addr.val, ret);
+			return ret;
+		}
+
+		op.addr.val += op.data.nbytes;
+		len -= op.data.nbytes;
+		if (in)
+			in += op.data.nbytes;
+		else
+			out += op.data.nbytes;
 	}
 
-	ret = spi_write_then_read(spi, cmd, 1 + caps->addr_width, data_out,
-				  data_in, len);
-
-	spi_release_bus(spi);
-
-	return ret;
+	return 0;
 }
 
 static int mchp23k256_read(struct mtd_info *mtd, loff_t from, size_t len,
@@ -126,21 +152,15 @@ static int mchp23k256_probe(struct udevice *dev)
 	struct mtd_info *mtd = dev_get_uclass_priv(dev);
 	struct mchp23k256_priv *priv = dev_get_priv(dev);
 	struct spi_slave *spi = dev_get_parent_priv(dev);
-	u8 cmd[2];
+	u8 mode = MCHP23K256_MODE_SEQ;
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(MCHP23K256_CMD_WRITE_STATUS, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(sizeof(mode), &mode, 1));
 	int ret;
 
-	ret = spi_claim_bus(spi);
-	if (ret) {
-		dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
-		return ret;
-	}
-
-	cmd[0] = MCHP23K256_CMD_WRITE_STATUS;
-	cmd[1] = MCHP23K256_MODE_SEQ;
-	ret = spi_write_then_read(spi, cmd, sizeof(cmd), NULL, NULL, 0);
-
-	spi_release_bus(spi);
-
+	ret = spi_mem_exec_op(spi, &op);
 	if (ret) {
 		dev_dbg(dev, "failed to select sequential operation: %d\n",
 			ret);
diff --git a/test/dm/mchp23k256.c b/test/dm/mchp23k256.c
index cab8dbee547..a359deaca2f 100644
--- a/test/dm/mchp23k256.c
+++ b/test/dm/mchp23k256.c
@@ -35,6 +35,9 @@
 #define MCHP23_ONE_ADDR		0x100
 #define MCHP23_ONE_DATA_LEN	4
 
+/* What a controller with a limited transfer size would move in one go */
+#define MCHP23_CHUNK		16
+
 /*
  * The second partition in the test device tree. Its offset is not aligned
  * to any erase block size, which does not matter for a device without
@@ -178,6 +181,47 @@ static int dm_test_mchp23k256_small(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_mchp23k256_small, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/*
+ * A controller that transfers less data than requested must not cause
+ * data loss, which is why the driver loops until all data is transferred.
+ */
+static int dm_test_mchp23k256_chunks(struct unit_test_state *uts)
+{
+	u8 src[MCHP23_LEN], dst[MCHP23_LEN];
+	struct spi_slave *slave;
+	struct udevice *dev;
+	struct mtd_info *mtd;
+	size_t retlen;
+	int i;
+
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_MTD,
+						ofnode_path(MCHP23_PATH),
+						&dev));
+	mtd = dev_get_uclass_priv(dev);
+
+	/* Stand in for a controller that cannot do the whole transfer */
+	slave = dev_get_parent_priv(dev);
+	slave->max_write_size = MCHP23_CHUNK;
+	slave->max_read_size = MCHP23_CHUNK;
+
+	for (i = 0; i < MCHP23_LEN; i++)
+		src[i] = 0xc0 + i;
+
+	ut_assertok(mtd_write(mtd, MCHP23_OFFSET, MCHP23_LEN, &retlen, src));
+	ut_asserteq(MCHP23_LEN, retlen);
+
+	memset(dst, 0, MCHP23_LEN);
+	ut_assertok(mtd_read(mtd, MCHP23_OFFSET, MCHP23_LEN, &retlen, dst));
+	ut_asserteq(MCHP23_LEN, retlen);
+	ut_asserteq_mem(src, dst, MCHP23_LEN);
+
+	slave->max_write_size = 0;
+	slave->max_read_size = 0;
+
+	return 0;
+}
+DM_TEST(dm_test_mchp23k256_chunks, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 static int dm_test_mchp23k256_part(struct unit_test_state *uts)
 {
 	struct mtd_info *mtd, *part;
-- 
2.55.0

