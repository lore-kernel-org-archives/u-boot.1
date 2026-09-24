Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3469DC98318
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 21:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C00D40B2A;
	Thu, 24 Sep 2026 21:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZYutn1T0CO2; Thu, 24 Sep 2026 21:17:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A80A740B2E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790284648;
	b=qtuiRLuWY/VQ1bzezN/F3E2sTndg6/Ejyq4a+VbyhssJN2Co5IPYXCvEumjeYn1RFL09
	 43LkXdQrHe3YozY/iuiXaYn6yj8pITY16A8Z8PDDVb4b9M4BNRIZ8kKLoowY9BQ4qFvR5
	 8niq+Sv2aMmm6LBWODxBO7+G9VwDdcyoNPCjWdI84acjWhR+94FPsXT3vJAgcdDmVw/87
	 W3mTj4VuTZaXEcbR40k6RjS/tUSIJXcWD+Gr2c/Cb7IrjaKMHq4wfAsScbaTqi2mEXt7p
	 7nyn8H2kjveJU3VHE1/o21NzLlQWFT++cMZBYIIfJlFQl66YiHfnWciyfpBLyolfRjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790284648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LJ8YMgnmvvUNCY+AtLHDQ2v84lteDXUhDzS56htYZR0=;
	b=i/5r0myG9bffKISAsiWgck4NXv2D/x5kEnvnsvGof6IUaN/FciBtz9SG3scw0SXpnnJQ
	 uXcJfALhmmyRYj2Vdkk9CyT1vaRvZL3KgPdT8aXE6CkGPcr/pM+T+k+SH/GA+2keKrbMr
	 /xAmtjD6un2SVp3+AeL67x+I+Mx+/0ZtTZvQjRxnOThQI1pZkd2GIlbhTRVEzan6/s3yW
	 1fvoAICNJDrTZjBiCw08Xoowwg//vbPUtr6FOztQ8Ha4CrEXP7jpjz9Sl/wAEX4CP998n
	 FMKfWARYoACleue9JQZPrDU8oryf7iaGV7QFIVK/rdHLxAKOlh4tdrdXd+/JZheZSNg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790284648;
	bh=LJ8YMgnmvvUNCY+AtLHDQ2v84lteDXUhDzS56htYZR0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y/3qbCrnuQHxzxcc7/QrgSthl1i3A57xBrQOFbuIHgp+B4fK30g26t98lmwc2lCbg
	 l61N8KBVSS1wnBhSyCKm8sqqwiw/i2mhe7LaMVu0H7mUbHQiT/0Htop3oe44VdBLT0
	 dcCPpZD6RDxiYBogUCmWrrutA8CJZV0nzOdtt16IJoi208WzU4wVsEplNr4FEGFv+o
	 xCpfFdkgixkRq/awy+lJvtoPxYHNGhyhIqR6o5PBTemoLrZz2X1bTVk5gA8RZodWyN
	 Q2nzeH4nQ3gKh728dhv8lFqTNB92UEAw+r6MmcvNkOQpWTI5FN2PAOOHiSgq4g5XtC
	 3D0wAZIFJK0zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A80A740B2E;
	Thu, 24 Sep 2026 21:17:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CC4C32A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 21:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 128304017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 21:17:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BaTgcJsANwXW for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 21:17:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 63AA940079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790284646;
 b=MAhPUO6ePUax2EXTLrhdY5xILyJAD7SUAwn55pso7F5XD9kMGjZPc8xo/SGxT1ayRywV
 G5hE2PuK+QueD/qFT6zydmqrwbEiu/0vUsQe8CzaXweDV+G0PSfrIzJCq5tD6qYhIunsj
 QI5qF5XWCC244eksRgLDz+WzD+DKR6DgTubo7JTmQ2yRJksslJPr9lL6DBR1SuA/pQKyE
 wsf5hclBKBDdIkbh3GQufj/8eR0sF1s8ASl217r2km/UiYIPLHaDX9qN/ulImJTsCXtl9
 rdkXSTK8JYqFXZDWGbajYlMzxv7oBLqJK5SVmSJskoQK5xai04913xSSmUgDP4VwC8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790284646;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=LJ8YMgnmvvUNCY+AtLHDQ2v84lteDXUhDzS56htYZR0=;
 b=pHfid4zkOzAFJmw5m7jAk9E76VVu2WUT8YJOl7gxVdLMwqaYcr17pmF7btPoVPCCaVuv
 xpLpEql9apuFfCLxRvjDyZnknbxm1nKLmc/sxNQqot98Yvx9Wg4M5MEVXdI+aDNsODapD
 mYg+6Z+yLD4zSvFwS/VtPY1JZf0lPokcbMBBKk28lcq44f45iKYf/THcVWUVtCeor8rt9
 YsxIMpaxM7jr1KJdJn/1hSSoDKex9nR8gUo4MvWx5zvP61ua6DgmRjqHXu9UX4G18VC0I
 Lc7brRWqEke0ODt/FL8D6M8ldrvVqjlz8/4oc8azmUvHGVrceHJ3A9g4ykt96/vSQHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Cds58aNo; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Cds58aNo
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63AA940079
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 21:17:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 52CAF10321E; Thu, 24 Sep 2026 23:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790284637; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=LJ8YMgnmvvUNCY+AtLHDQ2v84lteDXUhDzS56htYZR0=;
 b=Cds58aNoDdCZdaFOKd2ZlrMwr5dWEZwaojQDYSzEvabj4QFRCj/H52khiVd3zSQs53j3+3
 qp6fRgpyFCJLba3PLBVuy53banBfhRxr9VJga5uwynvStJF6G3odv0vanKCj0vrJWED+Q7
 uxDoueqNVZZknubiqs7z8dH+CRAF8V23dEXhR95OBE3TFjPgeRAM/p6uCbLCT+YG5dQtHJ
 Ms7F46/C6BC3IkMLpRf789U71lvCTRBXyAGelmrfeX2Fqb0KURup29xCZuaLYtvBib/2uh
 QZRFNfWgKddq7LZRKon+NnwZNZ95GwgJdLBXGid6lfjtTcK440xzzuPRXUu65Q==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>, Johan Jonker <jbx6244@gmail.com>,
 Jungseung Lee <js07.lee@samsung.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] cmd: sf: Add rdreg and wrreg subcommands for SPI NOR register
 access
Date: Thu, 24 Sep 2026 23:16:12 +0200
Message-ID: <20260924211708.108526-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add two subcommands, rdreg and wrreg, to read and write SPI NOR
registers respectively. The registers are always accessed using
register specific access opcode and arbitrary amount of data are
read from SPI NOR register and stored to memory or loaded from
memory and written to SPI NOR register. This is useful in case
the SPI NOR non-volatile registers have to be configured in some
non-standard way, or when debugging the SPI NOR configuration.

Example usage:

Read 6 Bytes of SPI NOR ID (Read ID opcode is 0x9e):
"
=> sf rdreg 0x9e $loadaddr 6
=> md.b $loadaddr 6
00000000: 20 ba 20 10 44 00
"

Read Micron Nonvolatile Configuration Register (opcode 0xb5):
"
=> sf rdreg 0xb5 $loadaddr 2
=> md.b $loadaddr 2
00000000: ff ff
"

Write 0xfffe (LSByte first) into Micron Nonvolatile Configuration
Register (opcode 0xb1):
"
=> mw.b 0x00000000 0xfe
=> mw.b 0x00000001 0xff
=> sf wrreg 0xb1 $loadaddr 2
"

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Jungseung Lee <js07.lee@samsung.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.u-boot-project.org
---
 cmd/Kconfig                    |  7 ++++
 cmd/sf.c                       | 63 ++++++++++++++++++++++++++++++++++
 drivers/mtd/spi/spi-nor-core.c |  8 ++---
 drivers/mtd/spi/spi-nor-tiny.c |  8 ++---
 include/spi_flash.h            |  5 +++
 5 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ff90a87024c..562f85bead0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1783,6 +1783,13 @@ config CMD_SF
 	help
 	  SPI Flash support
 
+config CMD_SF_REG
+	bool "sf reg - SPI NOR register access"
+	depends on CMD_SF
+	help
+	  Provides a way to access SPI flash registers using register access
+	  specific opcodes.
+
 config CMD_SF_TEST
 	bool "sf test - Allow testing of SPI flash"
 	depends on CMD_SF
diff --git a/cmd/sf.c b/cmd/sf.c
index b5b7f671fb9..4426440045d 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -541,6 +541,59 @@ static int spi_flash_test(struct spi_flash *flash, uint8_t *buf, ulong len,
 	return 0;
 }
 
+static int do_spi_flash_reg(int argc, char *const argv[], bool rdreg)
+{
+	unsigned long opcode, addr, len;
+	struct spi_nor *nor = flash;
+	uint8_t *buf;
+	char *endp;
+	int ret;
+
+	if (argc < 4)
+		return -1;
+	opcode = hextoul(argv[1], &endp);
+	if (*argv[1] == 0 || *endp != 0)
+		return -1;
+	addr = hextoul(argv[2], &endp);
+	if (*argv[2] == 0 || *endp != 0)
+		return -1;
+	len = hextoul(argv[3], &endp);
+	if (*argv[3] == 0 || *endp != 0)
+		return -1;
+
+	buf = map_sysmem(addr, 0);
+	if (rdreg) {
+		ret = spi_nor_read_reg(nor, opcode, buf, len);
+		if (ret) {
+			printf("Read command 0x%02lx failed (%d)\n", opcode, ret);
+			goto exit;
+		}
+	} else {
+		ret = write_enable(nor);
+		if (ret) {
+			printf("Write enable for command 0x%02lx failed (%d)\n", opcode, ret);
+			goto exit;
+		}
+
+		ret = spi_nor_write_reg(nor, opcode, buf, len);
+		if (ret) {
+			printf("Write command 0x%02lx failed (%d)\n", opcode, ret);
+			goto exit;
+		}
+
+		ret = write_disable(nor);
+		if (ret) {
+			printf("Write disable for command 0x%02lx failed (%d)\n", opcode, ret);
+			goto exit;
+		}
+	}
+
+exit:
+	unmap_sysmem(buf);
+
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
 static int do_spi_flash_test(int argc, char *const argv[])
 {
 	unsigned long offset;
@@ -614,6 +667,10 @@ static int do_spi_flash(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = do_spi_flash_erase(argc, argv);
 	else if (IS_ENABLED(CONFIG_SPI_FLASH_LOCK) && strcmp(cmd, "protect") == 0)
 		ret = do_spi_protect(argc, argv);
+	else if (IS_ENABLED(CONFIG_CMD_SF_REG) && !strcmp(cmd, "rdreg"))
+		ret = do_spi_flash_reg(argc, argv, true);
+	else if (IS_ENABLED(CONFIG_CMD_SF_REG) && !strcmp(cmd, "wrreg"))
+		ret = do_spi_flash_reg(argc, argv, false);
 	else if (IS_ENABLED(CONFIG_CMD_SF_TEST) && !strcmp(cmd, "test"))
 		ret = do_spi_flash_test(argc, argv);
 	else
@@ -641,6 +698,12 @@ U_BOOT_LONGHELP(sf,
 	"sf protect lock/unlock sector len	- protect/unprotect 'len' bytes starting\n"
 	"					  at address 'sector'"
 #endif
+#ifdef CONFIG_CMD_SF_REG
+	"\nsf rdreg cmd addr len			- read SPI NOR register using 'cmd' opcode\n"
+	"						  and store 'len' read data at 'addr'\n"
+	"sf wrreg cmd addr len			- write SPI NOR register using 'cmd' opcode\n"
+	"						  and load 'len' write data from 'addr'"
+#endif
 #ifdef CONFIG_CMD_SF_TEST
 	"\nsf test offset len		- run a very basic destructive test"
 #endif
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index c73f2c7c3f8..eb022e577a2 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -298,7 +298,7 @@ static int spi_nor_read_write_reg(struct spi_nor *nor, struct spi_mem_op
 	return spi_mem_exec_op(nor->spi, op);
 }
 
-static int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
+int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
 {
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(code, 0),
 					  SPI_MEM_OP_NO_ADDR,
@@ -315,7 +315,7 @@ static int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
 	return ret;
 }
 
-static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
+int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 {
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),
 					  SPI_MEM_OP_NO_ADDR,
@@ -637,7 +637,7 @@ static int write_sr3(struct spi_nor *nor, u8 val)
  * Set write enable latch with Write Enable command.
  * Returns negative if error occurred.
  */
-static int write_enable(struct spi_nor *nor)
+int write_enable(struct spi_nor *nor)
 {
 	return nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
 }
@@ -645,7 +645,7 @@ static int write_enable(struct spi_nor *nor)
 /*
  * Send write disable instruction to the chip.
  */
-static int write_disable(struct spi_nor *nor)
+int write_disable(struct spi_nor *nor)
 {
 	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 }
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index cf00473ee83..7b6b7432af8 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -46,7 +46,7 @@ static int spi_nor_read_write_reg(struct spi_nor *nor, struct spi_mem_op
 	return spi_mem_exec_op(nor->spi, op);
 }
 
-static int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
+int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
 {
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(code, 1),
 					  SPI_MEM_OP_NO_ADDR,
@@ -72,7 +72,7 @@ static int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
 	return ret;
 }
 
-static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
+int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 {
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
 					  SPI_MEM_OP_NO_ADDR,
@@ -155,7 +155,7 @@ static inline int write_sr(struct spi_nor *nor, u8 val)
  * Set write enable latch with Write Enable command.
  * Returns negative if error occurred.
  */
-static inline int write_enable(struct spi_nor *nor)
+int write_enable(struct spi_nor *nor)
 {
 	return spi_nor_write_reg(nor, SPINOR_OP_WREN, NULL, 0);
 }
@@ -163,7 +163,7 @@ static inline int write_enable(struct spi_nor *nor)
 /*
  * Send write disable instruction to the chip.
  */
-static inline int write_disable(struct spi_nor *nor)
+int write_disable(struct spi_nor *nor)
 {
 	return spi_nor_write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 }
diff --git a/include/spi_flash.h b/include/spi_flash.h
index 2e703e85250..b7622bce48c 100644
--- a/include/spi_flash.h
+++ b/include/spi_flash.h
@@ -236,4 +236,9 @@ static inline int spi_flash_protect(struct spi_flash *flash, u32 ofs, u32 len,
 		return flash->flash_unlock(flash, ofs, len);
 }
 
+int write_enable(struct spi_nor *nor);
+int write_disable(struct spi_nor *nor);
+int spi_nor_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len);
+int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
+
 #endif /* _SPI_FLASH_H_ */
-- 
2.53.0

