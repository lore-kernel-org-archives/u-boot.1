Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D230C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06F0260793;
	Tue, 25 Aug 2026 22:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WOK5Sb5IEkUT; Tue, 25 Aug 2026 22:50:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698230;
	bh=Ud83XH6execc7oNGMt50sYaPXG5iNWlOlcJu+KwjOYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zJGT3YKFMcSFwpFQ56dNxA85cqdWtTn0NUWnmJJ2tt/gCXgxtP8JA6Go4XBlIFtzv
	 W7wsFfnUrytUNQjYWZeGFn9Jj1bLLjVZ9plZOtXBSzhWKIF3+RCtfMXWFlDmf6375t
	 vA1liF/W8IRFKZVUlkZae8qCdSMXKwg9Nt2u/0o/V/K1Y3ph3WnQQ2RYghh2/SMfmP
	 cl2YNQwv7/rcVJ24Cu75ln8AWM5IAqK3rBA097HrNGc0YfcKGNWTYYUj1713Ck1sSM
	 6piPOlnqfDJJkeUn46MXlahvx0Vi5wxV/Da8u02JqD2N6+p/TpWjGnsaiNctVYH9fy
	 AXZ1l5pZgzlTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1863860787;
	Tue, 25 Aug 2026 22:50:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6000334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C810440606
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7AshjQx9DS43 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=Irdezy7B
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp4.osuosl.org (Postfix) with ESMTPS id 5DFA840612
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697852; bh=Ud83XH6execc7oNGMt50sYaPXG5iNWlOlcJu+KwjOYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Irdezy7BLxzVZ1EkaEHX43txJl7oHqSt+1YB7Mt1BUfk8aHYrlbTMHCx/0Bhgyat8EVLFopG0V+eKgcKc3J71i/CdmtrItFHTCyLujcI4s2P0eabcMdvXtZDq0cuFgcwfnuTyE235+BlpBoDRIFHfc/P1nRzu6IT0l+ToW3hIDw14faV2NOTmK6wp4kcUrYbz0pzQK0IbRaVBdRz5N2d2lpGC6kjwKMPHFLlHkqkcJkTCY/xaUuqP2W5vdeyGbyXigklelmyBzk9OTFgTAptS+jYQJFuEuty7BIfXmkUAx028NjlR9CGth+3+SVM0aQokWjpIuEPLr6vbJX1sfoxZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697852; bh=H0SzeqNwMwk/UI9u8pB5JnB65QZgZbuZ5kZduzuyatB=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=VJ534bqivIAAibiAdl3/QW15Q4YWDtvJKob4NWgrZK5rEiDK7D3sdNVhA+nTPcJqbr7uHQn193msk0XpcwLtzWs+/UCFvNYThCghhMSn/vtXrlP2kjUi6BOgO72O3VfbHmphWtMG1HvGAmXEA4eNUPNUR8+SAdd5s6ahFZTCkY8ichRM0QAEBTrXh/ls5OJkEkjZc3LpBj6k/zjdvmbFSEeTOKK5F6Q6aPzHl/Gj6MhLgZ3dzzVdZqnyIL8E7iojpPkEhCanrWpbImkMbb8Y2f/yZucAcV6jG8vM9zFC80Cub7/8LG5RVUlJDL9HJ5f24yQEB8g6xPux49uYQqqmSw==
X-YMail-OSG: Dwgu7loVM1ny530cmEOhVRCMr3av5uznJ7lEz6NbGM_f7lPdngC8s2FcUFZ2mzI
 6C8ErSbWDZT5hDeFKQ4kKADNt.Nj8rYkjlKNbREZYBtjl_A3xrT3OqjYP_aYLJ_.9ZH871jCFmh_
 X1U1xhatVnbUkMHBy.osq3Z6X5AFwls9qp8T_ZoJdoWbq7mr7UTkSeeJrR.cJkPdzlY.hEVUYWxw
 1CMR2CQNSbuFvpTr7jK8BbOcceY.aB25.NuT4je8EC777pSLOyt6ldZTvRM0nKoGOBB9Lpwtk6HR
 WuvAqdQzsx.7QQi_PlstxXNwjJZx.kOTN3r6llVFFDndVZiBfx6B1Z46Fw3sC1n5Tcm.xnXl169w
 aF8IuBt8Lem7PaBC5Kt..SqvPUqZ2TsS35OM2Wf4mh6YHS_glJnNS7AJsROKMK29Q6E2Y41n7ryG
 xiK9EPPo_AqFd2e4fR_Lymn1zvVGXbkD1nGl.sKM6lm4ft5ue297nTKcsz5MiJz_wL4DeJ6NcV1c
 kwJtayk_TQ5uFWJq5hp8zUW0BpR3jGQfLz971EBH8HGGEq08Qokv.GxrueubBTkgqj9rOSg3gkNN
 GDCVSYhI.otM.Zjd4uOCzuS6avD7HUfQdREW_ZqT5eRVF7JUA_Rdv.GlK.dhwrZ7etkAKUb7Uh4B
 IcQDByWWzDtGgpqDAVkgkeUR8jo0vOok4c_4NnV6X9GEcZu.3rj9g12fg5z7w6npdk2TS5nbVoQb
 rm56uUMOl3MZNMqd09CmPS4709ckQinTpPMAaPqPpM8iuDtZATuiDUAqXd9QiR7YttACQQ5zlzFE
 rMvNLJU7VnGxImakBeto6MBa1XBQx1TP.BoTxtfsjiZdLgE8AVasxvrpLVFW1Np3LVZsz8_kkza9
 gOtC7bFCCAeu95Yp0TQwdxa.xINgzOnExxnz0HJvwkMZwoTl3C2fQHiY.guy1BBZD.Bt2_zNEgGz
 vIda7bTXzl8pzkp20Dud6nvuDN05KvKvZz0HxZQYhbOBMwDcYQNCCsVaJ5nztiyScxO5SKaRW9c8
 ZEAAJlKxVSnz5FRddgGY73EOct2UsmjLMSJ1_q6VaiCkPbtybEBEu8mCM6kqgCqRQEl2P6EzHkea
 vx4Sd0mx6LfQLHoVtoGTDjbwLIaShU1KyV3ZYcri77_NybtRbghfSgcSKv77j72TgNIOoQ11RWHy
 eRa6BbYM_tgASJwOZ.IEB_osZg6pbZeOuEgdW10OIr4Sor93rDk05lBwSH66AUJ15pR2QNcEyhvp
 DA_KACKQilsk9CUFBZUCi0e5EzYu.0PAshX_0UNN4T1v7ELwPP6Ifulp4ooFgijwRmOJYGZffNtM
 ra0N.Xxti43MXHQEBGKuBZmBwf9D0xBEiJNb6Y4iOI2Z3iv_mfB4YLtixk6Sj_A2p_zXy6rNbFSX
 PLJSr_G5AP7g5BKCLZMjaQ0TP0qrjTxGYieQ.ecz5NV22x44V2sPe9X_jYU3_43nRyfxxz1MEz4K
 JY1YuyQKVkkb8srM0JHRhurfDpLyQfM4C816zRp7cJL8v0Mhr6vycI938sxSFMUPpbo7X0lbspRh
 iUo4BsSeX207lYfN.9f2yFCfyrk6i9ITiRtfqNfCsiFdPI95z81oFp8zjsIIgpFVaBzC5R0j4zOF
 BCbHV1.tThrUxfWeLje6fY82OFbPu2eOiHTgjKIW8b47Mf0Q81COuOm.G4ALpSps_AoK.dummduJ
 kAyUgsXmn6.Cvz6ISYCVbbu0GBLev8ZuD3DmYa4emDSFuiKC77FU2ca3b1ziVdKQGZwvmtONbKTF
 tfOVsSOv1gh..UIG46VwWyjGftBpApIynVz_O.0wCjdBB34zrzf_PMJU2y4vvxFWEivsooDqHTuY
 yBUcizgU0AI49dd8tOygVpK.Zg.JaJp1cS.g3G20YFt7LJCYahOBPSqzPjDCKHEboSpi_z0U2sB3
 xSaFiTMUNFb6LYtOBLPIIb7Egjh7WH8_6L1CDWMpfsXLCtDMWV_EqsRJ1xGxCDWYFTRUYS6xN3Ou
 2jkBVYlE5C61LfS7duLQS1Jz9Om03iew4uGmzpB5l65JlQGhhK5SMk1tA.Sh6F2jMDni.TE1_eys
 kT3wQ_m4-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: d352affa-1aa5-49cf-904e-79ac9f08bf23
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 25 Aug 2026 22:44:12 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:44:08 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 07/12] mtd: env, cmd: add EN75 NAND remap handling
Date: Wed, 26 Aug 2026 04:12:02 +0530
Message-ID: <20260825224330.713151-8-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
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

Honour the EcoNet/Airoha NAND "remap" region attribute when reading and
writing MTD partitions from the env and the mtd command, matching the
vendor block layout.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 cmd/mtd.c   | 30 ++++++++++++++--
 env/Kconfig |  2 +-
 env/mtd.c   | 98 +++++++++++++++++++++++++++++++++--------------------
 3 files changed, 89 insertions(+), 41 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 7f251440..d7b8fa3b 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -519,6 +519,13 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		goto out_put_mtd;
 	}
 
+	if (start_off >= mtd->size) {
+		printf("Offset 0x%llx is past the end of %s (size 0x%llx)\n",
+		       start_off, mtd->name, mtd->size);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
 	default_len = dump ? mtd->writesize : mtd->size;
 	len = argc > 1 ? hextoul(argv[1], NULL) : default_len;
 	if (!mtd_is_aligned_with_min_io_size(mtd, len)) {
@@ -557,11 +564,21 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	io_op.datbuf = buf;
 	io_op.oobbuf = woob ? &buf[len] : NULL;
 
-	/* Search for the first good block after the given offset */
+	/*
+	 * Search for the first good block after the given offset.
+	 * Bounded: mtd_block_isbad() returns a negative errno past the end of
+	 * the device, which is nonzero and would otherwise spin forever.
+	 */
 	off = start_off;
-	while (mtd_block_isbad(mtd, off))
+	while (off < mtd->size && mtd_block_isbad(mtd, off) > 0)
 		off += mtd->erasesize;
 
+	if (off >= mtd->size) {
+		printf("No good block found after offset 0x%llx\n", start_off);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
 	led_activity_blink();
 
 	if (benchmark)
@@ -569,9 +586,16 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Loop over the pages to do the actual read/write */
 	while (remaining) {
+		if (off >= mtd->size) {
+			printf("Reached the end of %s before completing\n",
+			       mtd->name);
+			ret = -EIO;
+			break;
+		}
+
 		/* Skip the block if it is bad */
 		if (mtd_is_aligned_with_block_size(mtd, off) &&
-		    mtd_block_isbad(mtd, off)) {
+		    mtd_block_isbad(mtd, off) > 0) {
 			off += mtd->erasesize;
 			continue;
 		}
diff --git a/env/Kconfig b/env/Kconfig
index 7abd82ab..ba45d194 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -652,7 +652,7 @@ config ENV_OFFSET_RELATIVE_END
 config ENV_OFFSET_REDUND
 	hex "Redundant environment offset"
 	depends on (ENV_IS_IN_EEPROM || ENV_IS_IN_MMC || ENV_IS_IN_NAND || \
-		    ENV_IS_IN_SPI_FLASH) && ENV_REDUNDANT
+		    ENV_IS_IN_SPI_FLASH || ENV_IS_IN_MTD) && ENV_REDUNDANT
 	default 0x10C0000 if MICROBLAZE
 	default 0x0
 	help
diff --git a/env/mtd.c b/env/mtd.c
index b26ee809..bf9fa516 100644
--- a/env/mtd.c
+++ b/env/mtd.c
@@ -2,6 +2,7 @@
 /*
  *  Author: Christian Marangi <ansuelsmth@gmail.com>
  */
+#include <env.h>
 #include <env_internal.h>
 #include <errno.h>
 #include <malloc.h>
@@ -9,6 +10,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <linux/mtd/mtd.h>
+#include <memalign.h>
 #include <u-boot/crc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -30,6 +32,29 @@ static int setup_mtd_device(struct mtd_info **mtd_env)
 	return 0;
 }
 
+static int env_mtd_read_buf(struct mtd_info *mtd, u32 offset, void *buf, int len)
+{
+	u32 sect_size = mtd->erasesize;
+	size_t ret_len;
+	char *tmp = buf;
+	int remaining = len;
+	int ret;
+
+	while (remaining) {
+		if (!(offset % sect_size) && mtd_block_isbad(mtd, offset)) {
+			offset += sect_size;
+			continue;
+		}
+		ret = mtd_read(mtd, offset, mtd->writesize, &ret_len, tmp);
+		if (ret)
+			return ret;
+		tmp += ret_len;
+		offset += ret_len;
+		remaining -= ret_len;
+	}
+	return 0;
+}
+
 static int env_mtd_save(void)
 {
 	char *saved_buf = NULL, *write_buf, *tmp;
@@ -40,7 +65,7 @@ static int env_mtd_save(void)
 	u32 write_size;
 	env_t env_new;
 	int remaining;
-	u32 offset;
+	u32 offset, save_off;
 	int ret;
 
 	ret = setup_mtd_device(&mtd_env);
@@ -48,6 +73,12 @@ static int env_mtd_save(void)
 		return ret;
 
 	sect_size = mtd_env->erasesize;
+#ifdef CONFIG_ENV_OFFSET_REDUND
+	save_off = (gd->env_valid == ENV_VALID) ?
+		CONFIG_ENV_OFFSET_REDUND : CONFIG_ENV_OFFSET;
+#else
+	save_off = CONFIG_ENV_OFFSET;
+#endif
 
 	/* Is the sector larger than the env (i.e. embedded) */
 	if (sect_size > CONFIG_ENV_SIZE) {
@@ -57,7 +88,7 @@ static int env_mtd_save(void)
 			goto done;
 		}
 
-		offset = CONFIG_ENV_OFFSET;
+		offset = save_off;
 		remaining = sect_size;
 		tmp = saved_buf;
 
@@ -87,7 +118,7 @@ static int env_mtd_save(void)
 	sect_num = DIV_ROUND_UP(CONFIG_ENV_SIZE, sect_size);
 
 	ei.mtd = mtd_env;
-	ei.addr = CONFIG_ENV_OFFSET;
+	ei.addr = save_off;
 	ei.len = sect_num * sect_size;
 
 	puts("Erasing MTD...");
@@ -104,7 +135,7 @@ static int env_mtd_save(void)
 		write_buf = (char *)&env_new;
 	}
 
-	offset = CONFIG_ENV_OFFSET;
+	offset = save_off;
 	remaining = write_size;
 	tmp = write_buf;
 
@@ -129,6 +160,9 @@ static int env_mtd_save(void)
 
 	ret = 0;
 	puts("done\n");
+#ifdef CONFIG_ENV_OFFSET_REDUND
+	gd->env_valid = gd->env_valid == ENV_VALID ? ENV_REDUND : ENV_VALID;
+#endif
 
 done:
 	put_mtd_device(mtd_env);
@@ -142,12 +176,8 @@ done:
 static int env_mtd_load(void)
 {
 	struct mtd_info *mtd_env;
-	char *buf, *tmp;
-	size_t ret_len;
-	int remaining;
-	u32 sect_size;
-	u32 offset;
-	int ret;
+	char *buf, *buf2 = NULL;
+	int ret, read1_fail, read2_fail = 1;
 
 	buf = (char *)memalign(ARCH_DMA_MINALIGN, CONFIG_ENV_SIZE);
 	if (!buf) {
@@ -159,40 +189,34 @@ static int env_mtd_load(void)
 	if (ret)
 		goto out;
 
-	sect_size = mtd_env->erasesize;
-
-	offset = CONFIG_ENV_OFFSET;
-	remaining = CONFIG_ENV_SIZE;
-	tmp = buf;
-
-	while (remaining) {
-		/* Skip the block if it is bad */
-		if (!(offset % sect_size) &&
-		    mtd_block_isbad(mtd_env, offset)) {
-			offset += sect_size;
-			continue;
-		}
-
-		ret = mtd_read(mtd_env, offset, mtd_env->writesize,
-			       &ret_len, tmp);
-		if (ret) {
-			env_set_default("mtd_read() failed", 1);
-			goto out;
-		}
-
-		tmp += ret_len;
-		offset += ret_len;
-		remaining -= ret_len;
+	read1_fail = env_mtd_read_buf(mtd_env, CONFIG_ENV_OFFSET, buf,
+				      CONFIG_ENV_SIZE);
+#ifdef CONFIG_ENV_OFFSET_REDUND
+	buf2 = (char *)memalign(ARCH_DMA_MINALIGN, CONFIG_ENV_SIZE);
+	if (!buf2) {
+		env_set_default("memalign() failed", 0);
+		ret = -EIO;
+		goto out_dev;
+	}
+	read2_fail = env_mtd_read_buf(mtd_env, CONFIG_ENV_OFFSET_REDUND, buf2,
+				      CONFIG_ENV_SIZE);
+	ret = env_import_redund(buf, read1_fail, buf2, read2_fail, H_EXTERNAL);
+#else
+	if (read1_fail) {
+		env_set_default("mtd_read() failed", 1);
+		ret = read1_fail;
+		goto out_dev;
 	}
-
 	ret = env_import(buf, 1, H_EXTERNAL);
 	if (!ret)
 		gd->env_valid = ENV_VALID;
+#endif
 
-out:
+out_dev:
 	put_mtd_device(mtd_env);
-
+out:
 	free(buf);
+	free(buf2);
 
 	return ret;
 }
-- 
2.53.0

