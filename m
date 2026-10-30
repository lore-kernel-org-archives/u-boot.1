Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A4606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AMdIzmGs;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=qLFPZwUi;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=jbEb/6gi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FA5780F51;
	Fri, 30 Oct 2026 01:49:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lvnBugY8xfT4; Fri, 30 Oct 2026 01:49:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C55F5810C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793324974;
	b=DZNMVEti+8/JsfkbPNZrLm5YyR+xbIRzMQy+i9IJBvbM/5FrYct/HoE8jYy6xGshb7Gz
	 ZHqoP7THk6pWLK2EGa7H/q5Ej4bB4LJmj+X4O5kRjCad6X4miY1H1Ut0eroYenbhzU5QC
	 S0ey476w/nqaDZ8I3P0t5B64FUUwt2s9ks6fUEbsTAvuZ61k+Gp+p7P0yZEY08umGmug0
	 pk43sb1jEZ9GHJzZ9AEjHQum4Sqr+8x7FLJ58WMU0OZl1AHPcehVVSN2QWWhTzM351wXh
	 ybEuJ+mxSgcmelL8Deq2GY6n6wf3Fiyh0x2xWwu4poKxJZ7EpEeohjAiANcBFM5CoRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793324974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PDFHKyubS0i+1JBa/3ASvBtbVqkak3OLRYLOP72VDVQ=;
	b=pqLrs0UHVvIJeIFNkI5MaIlqNXVK20KlTw0Yym9nrn1NX1mb5zGlykqhJI7SsLyFOGJ9
	 rmx5cBX4jaYIG8/HoLKzBdHEK+H0qZbBSfZpRpCDp4VF9QfTgac4+0uHwt/VuwQucb6+h
	 8/mzVA615nloGE7bqRJtQJovx6REyG08JRZR2kdSzVZpPx+vNqAw9gsgGnA7ta3VR1bDb
	 BLylgP1zVVv6cOKO+VMzkMVVjYLmmU+JA8vqgff2AOYZZlez8nfkYoRlyweFWHLdbEgKo
	 tJ/c2bm5sijnL7wgUMihdOwGQoqN48qu17aUbziGnIziqB+u3XBAFuLCWdwePEOdtcA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793324973;
	bh=PDFHKyubS0i+1JBa/3ASvBtbVqkak3OLRYLOP72VDVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMdIzmGsrEd2s6tILABnSnpab8cFWWK7rSm9uy/S2g17rATAbbYertRv5WXZgcqpp
	 1B/wkI3HszZf0xH7HcHUXHUnB0e5Th5LiLPtdD8peQjesYHJU4gnBPanU8Z2g+ioSU
	 hTAmHx5KAMOatqNZBpBL87U4746re21KL50M2KKnzzXtPd7JfOCTvLwshCMp5JVE0R
	 hqi1L05Safm2Ga8dWvHfs3q3jzZ/JhE72EwvVlFc0z6T7Te3pfDMFnDhAQiz5TCV5T
	 sR+T3ja7NxJjuSDz+QaB+pGof9dmhKRlHPGEIREo8iFG4e2lsx0MOkkH+VWGz11yTG
	 v7fYk1AD4z/zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C55F5810C5;
	Fri, 30 Oct 2026 01:49:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 850991DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 6AF6D40521
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id QHFSMqoRaKcQ for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 01:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 317B14051A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793324968;
 b=UvDYazQh1ZHLVU9OYUUdCO7XUoTqJNK4i2stZUar3l21UDu1bthPmuZmQdc4tEbmrIUW
 F2zVy08vWPf1hqxOxBJovxvhvRlEuiq8CwZZCrZg3W1vK7KMvM3HQ3FPYRA5octjV1eQ5
 p9tviwVnGZirpSGjkgqw5neIH2UB0QJe4x9E78+dVYRf4o/WBTgtPdGPgsjigCq7D352Z
 eWYgzxhwpXlSbVE6RarXpWOKAnK3MyrFZFAnoppH05JjnVCLNJlQ5c4SfZH8O0PXxuhp1
 pb2peKO6AkWhZqwmUWRGtnBTcrBbnlIoYRzWVCSRqUFVCNxKb40FijQpUfg4y6ViYGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793324968;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=PDFHKyubS0i+1JBa/3ASvBtbVqkak3OLRYLOP72VDVQ=;
 b=oO/vP71V8W8z4ezIRCjvF7y18UiRbFSoDsteMsY5Z9YzYt6eUaF0NrjqGW+Ock6362X4
 MuZDsXRFa2yRsaLxJ8Jzl4GZS49lSsI6JeSUd1F5rD2WETSumyIgtTnWFL/5VxMJpUawT
 RTWhIRZHwspzIEZf8pzvF6kIGW5hWOFrMW6CalFAG0N3V9oR4LIHbKRWTHG9hXEOEfODt
 YIM+KtFYoR5fxHfZslzeNPyeow9pjZhAiG84PFHJ/ED+qeoP5xpu+eIVk0n3gJOZAtKjI
 VfJOgp7kIgB3x3DwvmBvL4qeXkXYlSZWRRjXbNonTofhOoXW9zWjhNHFgybUVdhaZsg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=qLFPZwUi; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b="jbEb/6gi"; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=qLFPZwUi; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=jbEb/6gi
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 317B14051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793324964; bh=PDFHKyubS0i+1JBa/3ASvBt
 bVqkak3OLRYLOP72VDVQ=; b=qLFPZwUi+VcgKuCaLhJAwUJUjLqx2KTOxTio9teeVGnoyzKpk9
 zprw5xML5NhzzV02okTaDdz+NMDsobQwnj8Jx3ToUigQE9Y+WcYxqE1A8eT8u+bEOTCjrAbCleL
 CpjH5hE3NWDPDZ+IrVnprVInNypD2OquhrwyybuG0JYYqm7BayFIrl0oGQyx1yN+oRKkmF9itP6
 cy8kIM/1uQdLn4x2eozciWDAu3QiWtARiFlafvuNZR6m/t9Fr5TIWh6a0apcoTAPe9lXQPYtDuZ
 BvbjA+YBf9mUP9P1LONeyhgsGaipV9OwCZFEMpwbeCmytyaAAEPnDMQtiMnnX6cUs8w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793324964; bh=PDFHKyubS0i+1JBa/3ASvBt
 bVqkak3OLRYLOP72VDVQ=; b=jbEb/6giak9bcZ+JcXECVI3UkAMt+2LBL4pC2uBUDt0XNn5y0I
 lu1tIGxnUmVXwliRwRR9FxRFgQx5wkzHj6BA==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	brads@mainlining.org
Subject: [PATCH 2/3] doc: arch/powerpc: document the mpc85xx boot images
Date: Fri, 30 Oct 2026 01:49:24 +0000
Message-ID: <20261030014925.32610-3-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030014925.32610-1-brads@mainlining.org>
References: <20261030014925.32610-1-brads@mainlining.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boards boot from NOR, through a PBL image the BootROM runs, or with a
TPL and SPL pair out of NAND, and the image layout changes with each.
Write the layouts and the config options that control them down so
nobody has to figure it out from the linker scripts again.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 doc/arch/powerpc/boot.rst    | 57 ++++++++++++++++++++++++++++++++++++
 doc/arch/powerpc/index.rst   |  1 +
 doc/arch/powerpc/powerpc.rst |  4 ++-
 3 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 doc/arch/powerpc/boot.rst

diff --git a/doc/arch/powerpc/boot.rst b/doc/arch/powerpc/boot.rst
new file mode 100644
index 00000000000..dd01588db18
--- /dev/null
+++ b/doc/arch/powerpc/boot.rst
@@ -0,0 +1,57 @@
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
+the reset vector sits at the top of the 4K page, 0xfffffffc.
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
+These select CONFIG_RAMBOOT_PBL and build a PBL image instead of a plain
+u-boot.bin:
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
index 102943383de..1bc5f629ce3 100644
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

