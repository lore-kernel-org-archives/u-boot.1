Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAF606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SHRM2Fcn;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=JLcpQusd;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=NnGNvS4o
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B754381102;
	Fri, 30 Oct 2026 02:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2JWCDOKRBot; Fri, 30 Oct 2026 02:08:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 26E4081105
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793326127;
	b=tReD/+0r69mV8tZg0NCGzJnJWwzYrLpFMMfZ2+1ghxbp/1YfcPKMTxw+d8JG5xJQ603s
	 dOl5CU4gJQgPbayAuAynHgIjD9UZIiy0SRj6E5IoP5e9eWSpTJKrvLDgOnjDq49b0xggT
	 8vlufWTRS5TMQVv0QtflEHxsON8toF6pVm+FyE0KaX6Yd6wGM0eujes1L4C3QL+kSHwF/
	 FsyDl4mH16IA/lEIzcvES8jhBzVBS2hHJp5/AOA8RMMGR5l4urs/J+iwiW7S2E3LTUqGn
	 uSCuHjnjj1Tnlljte/Plyxl3MLXLfkl5VouWRKI0c48VGJ/eZwfvKHH9HSpRO4hdccg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793326127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p0eubNr9S5JU9/3C0FAWY7zLYSYP0uXndnnFsDRLdFg=;
	b=m+VRm5zE99gK233oB6lifI/fDkXqLf/mrfEEgTTPu5b4IZRKZaJ7TCiz19tVEn89HAfZ
	 fpJWS3HrYWm9dZ6ZWGzFQwn8gI/lP7qx2+SIdV0hik1/FD76veajVcw97ip+UcJaeGRIZ
	 LcGp4ZEpE+A6t7RGpm+J59zt1H8cSayMJOPyto4llC7wLy+HUYvd3U0OuK4s38GpwqSZ2
	 ca1/EM/kOFjAWO19oikWvm2HvhvqDzNM/Ca4w5qAtmKGWg3CerVx18/ByZaTBHS9la3ev
	 ymjkqCy2ir/cJYhIW+AyPpzjIXjujreoPJX3or4BcGZYsWaaUUuVqVL8RizPC0KF6SQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=JLcpQusd;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=NnGNvS4o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793326127;
	bh=p0eubNr9S5JU9/3C0FAWY7zLYSYP0uXndnnFsDRLdFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SHRM2FcnAUirqW04seo6AwnX8REh73ohw5pngi0zFxvngTuGLtlHQKyVckyEZbgPq
	 pM6ZTYRWQs/8w4m5R99CSHYbvsswrCWLE36ZtukWMIpRAdcfja+n3BQ9D/mA9MyyuV
	 uc//WMEdK0cVbBFSCjfmOF7EvwuVVaQPd3G9EcMlefXxa9I9GBvo9EnaTRP+DeV3LF
	 CTGwqC7xEHwAZPvPdDTDylRksQiTyutHOjBKY3Xnlw6FCxz9/aMcVoZz1uhXUrWIWu
	 s4hvwJ51OmftSegz62vYG0Z69vgB7jmosXl+t6FKTVN5tYokm6RIJmWRFZ8DcTJbvF
	 Hcltj2MFTEXzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26E4081105;
	Fri, 30 Oct 2026 02:08:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id C20621DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id A2D8380A89
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id iUwvePELG_DR for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 02:08:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 343ED80BB8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793326116;
 b=EKlQR41dPZRDTiiCjmwjDoLpiCS2pt1hGC7Pgru12dbImTyeid37jLkMUUaHbnKG4nlK
 nqC/65en6bH4vTQnnRVaU9SQ/qnzjFE+uk8+4yEmZd10dBaZEwzoKDdppJpRx0THq6dSL
 7HydWOA2M1skoo8LArs1sbBOsmq7bX8c1LG1m0KnZvU4EYSx7/A6LCtdEzuzdKMUXbFLl
 m9d/DGL195y+rK24V+1MRXV7ycoJ55ATbkZFCPR2yjf5YhUJXURiOaCkmeZl6ZZeqQCUk
 NvIV58QuGKIC6c7HhD7UYhbb4W6IvedoLxU4pCqi+lV7fTrVm8tcUaftzgcKF2HaNJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793326116;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=p0eubNr9S5JU9/3C0FAWY7zLYSYP0uXndnnFsDRLdFg=;
 b=UmgXlxz46iKm4kSN5eIS8XfkSDuPzRxSCxj4xbk77gkcsaPW+h+Q+DyAmyaZxkHmx5YF
 +00Hz8RoRDiAPDJpJfB5mGq9W5X0D3rCzyZCSP5+5VfXHIsQTcR0YZZS+nQXdHNfJZOGV
 eTYdup6FTDsv21iUmKfeGY0L7LfFZATLYGVM78h6bkuHlSlz0O7Z5x+HuTkbsI8zOExhw
 G1R3tbmbudyPhuBfh2tCdltXjY5pwkufrnl6Tw01PbXy9qAPIqMOOvrytqIKrO68hdLsI
 9J2NvXntbSKr7o1k6pPBR4Fsa5xQnqkLm7M2R9+IsG926TtEgOA0Az6WhKR0vMkTSew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=JLcpQusd; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=NnGNvS4o; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=JLcpQusd; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=NnGNvS4o
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 343ED80BB8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326111; bh=p0eubNr9S5JU9/3C0FAWY7z
 LYSYP0uXndnnFsDRLdFg=; b=JLcpQusdGKaynMEZu1Q079JRf7rXdimdHPqFrAt3AIyZ/Gz53J
 vU6mwThLy6VlyuW1xXmcug9Mav8qdvQh4xweeVq0cDSLwlhVTFPlQUpFQPBJqV9x4iVZdOwvb2i
 DAiX6IdUg4HccgGetRjPYyrbhebYMOWQFGkqBsZv2Q7XLUCS0QnT7PQMbYxqr/4Vk7/zdd3m/mz
 /AZlGifazV+fKvupX9goD9urPnbEYlSNcAHjC/mCgmOYCtVc6PgSxDoOcYWXhIbylh8oOVnyh1O
 WbjgkdkrtJFw+lc0jVWMXjbE4C2ZiEjnWaBeXEeeYaYMj304o9J4SFjrsZnX6dccElA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326111; bh=p0eubNr9S5JU9/3C0FAWY7z
 LYSYP0uXndnnFsDRLdFg=; b=NnGNvS4o6tZU1yBSeB4v08ay76Aw37PSx8lK6wMinIxObX+Gev
 cq2/cVmqqxMhZk6pgpk0LyP3VV8Ft3Ex7RAA==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	brads@mainlining.org
Subject: [PATCH v2 2/4] doc: arch/powerpc: document the mpc85xx boot images
Date: Fri, 30 Oct 2026 02:08:29 +0000
Message-ID: <20261030020832.26572-3-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030020832.26572-1-brads@mainlining.org>
References: <20261030020832.26572-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Boards boot from NOR, through a PBL image the BootROM runs, or with a
TPL and SPL pair out of NAND, and the image layout changes with each.
Write the layouts and the config options that control them down so
nobody has to figure it out from the linker scripts again.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 doc/arch/powerpc/boot.rst    | 59 ++++++++++++++++++++++++++++++++++++
 doc/arch/powerpc/index.rst   |  1 +
 doc/arch/powerpc/powerpc.rst |  4 ++-
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 doc/arch/powerpc/boot.rst

diff --git a/doc/arch/powerpc/boot.rst b/doc/arch/powerpc/boot.rst
new file mode 100644
index 00000000000..f72ed8d8304
--- /dev/null
+++ b/doc/arch/powerpc/boot.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026, Bradley Morgan <brads@mainlining.org>
+
+Boot images on MPC85xx
+======================
+
+There are two boot models and the image layout tells you which one you
+are dealing with.
+
+NOR flash
+---------
+
+U-Boot is linked for CONFIG_TEXT_BASE and u-boot.bin goes straight to
+flash. If the SoC has a boot page (CONFIG_MPC85XX_HAVE_RESET_VECTOR),
+the reset vector sits in the top 4K boot page at CFG_RESET_VECTOR_ADDRESS.
+That one is board specific, 0xeffffffc for P2041RDB NOR and 0xfffffffc
+for its PBL images.
+
+With CONFIG_OF_SEPARATE, binman glues u-boot-dtb.bin together using
+arch/powerpc/dts/u-boot.dtsi. For a RAM image without a reset vector,
+CONFIG_SYS_MPC85XX_NO_RESETVEC throws .resetvec away and moves .bootpg
+up.
+
+RAMBOOT
+-------
+
+RAMBOOT means the BootROM loads the image for you. Depending on the
+board that is SD, SPI or NAND, and the defconfig name says which:
+
+* P2041RDB_SDCARD_defconfig, P2041RDB_SPIFLASH_defconfig
+* T1024RDB_SDCARD_defconfig, T1024RDB_SPIFLASH_defconfig,
+  T1024RDB_NAND_defconfig
+* T2080RDB_SDCARD_defconfig, T2080RDB_SPIFLASH_defconfig,
+  T2080RDB_NAND_defconfig
+
+These select CONFIG_RAMBOOT_PBL and add a PBL wrapper around u-boot.bin
+to the build:
+
+* u-boot.pbl, when U-Boot proper is the only stage
+* u-boot-with-spl-pbl.bin, when CONFIG_SPL_FSL_PBL is set and an SPL runs
+  first
+
+NAND
+----
+
+Some P1010 and P1020 boards boot from NAND with a TPL in L2 SRAM that
+sets up DDR, then an SPL that loads U-Boot proper. That is the
+CONFIG_TPL and CONFIG_SPL_INIT_MINIMAL setup in the _NAND defconfigs.
+
+SPL builds in general also produce u-boot-with-spl.bin, which is SPL
+plus U-Boot proper padded to CONFIG_SPL_PAD_TO.
+
+SD and SPI, the other way
+-------------------------
+
+The BootROM also handles raw SD and SPI images that carry their own boot
+sector. Either let CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR prepend one for
+eSDHC, or use the external boot_format tool. See
+doc/README.mpc85xx-sd-spi-boot and doc/README.ramboot-ppc85xx.
diff --git a/doc/arch/powerpc/index.rst b/doc/arch/powerpc/index.rst
index bf0c46b9408..bfeeb1ed2bb 100644
--- a/doc/arch/powerpc/index.rst
+++ b/doc/arch/powerpc/index.rst
@@ -8,3 +8,4 @@ PowerPC
    :maxdepth: 2
 
    powerpc
+   boot
diff --git a/doc/arch/powerpc/powerpc.rst b/doc/arch/powerpc/powerpc.rst
index 78a386f5431..0f1f0148252 100644
--- a/doc/arch/powerpc/powerpc.rst
+++ b/doc/arch/powerpc/powerpc.rst
@@ -130,7 +130,8 @@ MPC85xx:
   See doc/README.mpc85xx-spin-table.
 
 * CONFIG_MPC85XX_HAVE_RESET_VECTOR, CONFIG_SYS_MPC85XX_NO_RESETVEC and
-  CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR are the image layout knobs.
+  CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR are the image layout knobs, they
+  are explained in :doc:`/arch/powerpc/boot`.
 
 Device trees
 ------------
@@ -157,6 +158,7 @@ No magic here, other architectures do the same.
 More reading
 ------------
 
+* :doc:`/arch/powerpc/boot`
 * doc/README.pblimage
 * doc/README.ramboot-ppc85xx
 * doc/README.mpc85xx-sd-spi-boot
-- 
2.47.3

