Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACA606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t+2PCoCP;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=JkzMpzey
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BB9F409C1;
	Sat,  7 Nov 2026 05:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pbrhtuunkpIQ; Sat,  7 Nov 2026 05:48:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4783140910
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794030499;
	b=OCcAsIY47pg8EtZhouY/hGa/MBJZW00js4Y/kBSjjNKdY6wJAO0bUgPvs7qMu+uYvq7X
	 YpSlaIsFVkTk/Xfw13cNT7aMWlUK5kGe7fFfOj6vsUi5XX4NhQEO4CQ5he1XY/ttTAbA7
	 T+2GXqRINgRkXcM+7v/k3YT036QxmQ+X4puUEtzKwnzvAapw/OI5lyBF77fgvZFOAJ/vT
	 G8gHZ3qNp8mlrPjECKRVtY1Y4mqjXF9SKL55eaGpe0AuVoD1BZ3lTNPE+mmqUlXasfOmr
	 GglhGl1r+fpaOSuyO1/afUM3GufuY76RuA5o8kXunXrWBxPO/r/uoGT26eSQdxDbp3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794030499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z9jZVUx/SDpCcd9fVMOXtTwUEQpRP82MKtrFUxP9038=;
	b=PQU2C/Dh0q0rnyNuDWRvpVt3+LHeRfDaU1ZSl9YJvZhkf5NgNuHdvTmVy2FsOLWkULRB
	 6imKRGNi+geO642RPvBn/OGg4xBAzQ46HrvSjQcQjM6n6hDSl4JmR8if3+xl3APj1pOL3
	 YYsc0S78CIofuwXtgt37beMotSwaQasEI/pNm3H+20d/aDeRcUefDDfZM6EEYz4MLbCyx
	 0fL66ZnpG81SIv8h4eVzVrMKvWMEMN893J7Um38BRUji500gEY39xXGE6fPX6G96h84/7
	 +2km6zYC0GCmDPa1nRLKpArPWKy63F7Eup9ImPdM7K+BAJXArg15GATXxXM6uxxYexg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=email.cz;
	dkim=pass header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=JkzMpzey;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794030499;
	bh=z9jZVUx/SDpCcd9fVMOXtTwUEQpRP82MKtrFUxP9038=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t+2PCoCP9EF+GqB92EO77VSsJcrC/Z0GrMFajz2zQgmSlPT/J6+jkIZZVF9Q+Jqyl
	 XteOZo2NaVNCPmUvhA+6uedW7vK2iC5ZUEBvUs0/iVLs08yXw3erCOM2ag7ilMLhsO
	 RE/190bdKE4Xo7hxNQ2qyBbA7E3cokjhLgIra/nV2W896mza1miCEjTC9nx84WbCqZ
	 nIGQdPqzaqJHyX81WRKng8+9CGsnRhARzmL6CyU7t1BfiyVbNaAPiQkMyWOGd+rQ5P
	 ZkEHskn7hy//2bbwKmu7co8vuKium9rTbjxD2195e76P4tqkWHPzU54k6IiKNniS58
	 Y9VvoGPUPkJAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4783140910;
	Sat,  7 Nov 2026 05:48:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A4891C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BB3040910
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdOwOflnt5sm for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 05:48:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FF9440870
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=77.75.76.34
X-Greylist: delayed 60655 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 07 Nov 2026 05:48:15 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=JkzMpzey
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.75.76.34;
 helo=mxe.seznam.cz; envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.76.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FF9440870
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:48:13 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxe-54d86748f-8hdxd
 (smtpc-mxe-54d86748f-8hdxd [2a02:598:128:8a00::1000:aaf])
 id 68406a7796b4d8dd68cee46f; Sat, 07 Nov 2026 06:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1794030473; bh=z9jZVUx/SDpCcd9fVMOXtTwUEQpRP82MKtrFUxP9038=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=JkzMpzeyFsfjcGyYeuN7Y1FTG1puZ/f34E9KrHYsE+EPnljddNGmwSU5HGv5/8umN
 Yh5L2/SywauRTfX+hy2L1FFvOKIpJSUMY+caaGO7HMvDQdpamgE+VjZ4wCbCYxOW1l
 kQaA5R9OUadbiA7WsOg5mszSyyJA2KE26EmTsbfxBRpL/1702Jmq1ZWHcS9Ri9Mc+Z
 qkQpoR0OsFY01Ecs/2rPC/i6yoKp6U5J48MnSJFTV6/XXeROioHrUdz0j73Ve8Ju6o
 dvJgQJj170BFN4HF31wYVFD2Sqg+/r9PlLY271+52yz/4Nri434eYvZISJyZF8paQL
 aWt0pA4P5Etlw==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Sat, 07 Nov 2026 06:47:44 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.u-boot-project.org>
Cc: "Stefan Bosch" <stefan_b@posteo.net>, "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Michal Simek" <michal.simek@amd.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Subject: [PATCH] Kconfig: Imply MD5 and SHA1 instead of selecting them  
Date: Sat, 07 Nov 2026 06:47:44 +0100 (CET)
Message-Id: <x6.ZqL8.6lacd1LQ7Dn.1gxhk0@seznam.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MD5 and SHA1 are no longer considered secure, but they cannot be
disabled on boards using FIT, image signature helpers or UUIDs,
because FIT, IMAGE_SIGN_INFO, SPL_IMAGE_SIGN_INFO, VPL_IMAGE_SIGN_INFO
and LIB_UUID select them. The code behind these options does not
require them, as the supported algorithms are looked up at runtime
and unsupported ones are rejected.

Imply MD5 and SHA1 instead, so they stay enabled by default but can
be disabled by the user. This does not change the resulting
configuration of any defconfig.

Select MD5 or SHA1 explicitly only for the code which calls them
directly and relied on the options above until now:
- bubt on Armada 3700 (sha1_*() for the TIM image header)
- zynq rsa command (md5_wd() for the boot image partitions)
- NanoPi2 board (md5_wd() for the MAC address generation)
- EFI capsule firmware (gen_v5_guid() for the dynamic image GUIDs)

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 arch/arm/mach-nexell/Kconfig | 1 +
 board/xilinx/zynq/Kconfig    | 1 +
 boot/Kconfig                 | 4 ++--
 cmd/mvebu/Kconfig            | 1 +
 common/Kconfig               | 6 +++---
 lib/Kconfig                  | 2 +-
 lib/efi_loader/Kconfig       | 1 +
 7 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-nexell/Kconfig b/arch/arm/mach-nexell/Kconfig=

index b43dd5a5c25..67f7f10362d 100644
--- a/arch/arm/mach-nexell/Kconfig
+++ b/arch/arm/mach-nexell/Kconfig
@@ -27,6 +27,7 @@ choice
 config TARGET_NANOPI2
 	bool "FriendlyARM NanoPi2 / NanoPC-T2 Board"
 	select ARCH_S5P4418
+	select MD5
 	help
 	  Enable support for FriendlyARM NanoPi2 and NanoPC-T2 Boards.
 
diff --git a/board/xilinx/zynq/Kconfig b/board/xilinx/zynq/Kconfig
index d6f40631cca..1a2411f50bc 100644
--- a/board/xilinx/zynq/Kconfig
+++ b/board/xilinx/zynq/Kconfig
@@ -23,6 +23,7 @@ config CMD_ZYNQ_RSA
 	default y
 	depends on CMD_ZYNQ
 	depends on CMD_ZYNQ_AES
+	select MD5
 	help
 	  Enabling this will support zynq secure image verification.
 	  The secure image is a xilinx specific BOOT.BIN with
diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..59dac3cdea4 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -69,8 +69,8 @@ config BUTTON_CMD
 menuconfig FIT
 	bool "Flattened Image Tree (FIT)"
 	select HASH
-	select MD5
-	select SHA1
+	imply MD5
+	imply SHA1
 	imply SHA256
 	help
 	  This option allows you to boot the new uImage structure,
diff --git a/cmd/mvebu/Kconfig b/cmd/mvebu/Kconfig
index e83a9829491..8381a374d6d 100644
--- a/cmd/mvebu/Kconfig
+++ b/cmd/mvebu/Kconfig
@@ -4,6 +4,7 @@ depends on ARCH_MVEBU
 config CMD_MVEBU_BUBT
 	bool "bubt"
 	default y
+	select SHA1 if ARMADA_3700
 	select SHA256 if ARMADA_3700
 	select SHA512 if ARMADA_3700
 	select DOS_PARTITION if ARMADA_3700
diff --git a/common/Kconfig b/common/Kconfig
index 92bf31f038b..ae0b699a906 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1300,7 +1300,7 @@ source "common/spl/Kconfig"
 
 config IMAGE_SIGN_INFO
 	bool
-	select SHA1
+	imply SHA1
 	select SHA256
 	help
 	  Enable image_sign_info helper functions.
@@ -1309,14 +1309,14 @@ if IMAGE_SIGN_INFO
 
 config SPL_IMAGE_SIGN_INFO
 	bool
-	select SHA1
+	imply SHA1
 	select SHA256
 	help
 	  Enable image_sign_info helper functions in SPL.
 
 config VPL_IMAGE_SIGN_INFO
 	bool
-	select SHA1
+	imply SHA1
 	select SHA256
 	help
 	  Enable image_sign_info helper functions in SPL.
diff --git a/lib/Kconfig b/lib/Kconfig
index 38e37bdc56a..45b8e1fd54e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -94,7 +94,7 @@ config HAVE_PRIVATE_LIBGCC
 
 config LIB_UUID
 	bool
-	select SHA1
+	imply SHA1
 
 config RANDOM_UUID
 	bool "GPT Random UUID generation"
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c4b0c2137b8..d9667fbd724 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -336,6 +336,7 @@ config EFI_CAPSULE_NAMESPACE_GUID
 
 config EFI_CAPSULE_FIRMWARE
 	bool
+	select SHA1
 
 config EFI_CAPSULE_FIRMWARE_MANAGEMENT
 	bool "Capsule: Firmware Management Protocol"
-- 
2.43.0
