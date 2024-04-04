Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE5DCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D9BF88441;
	Thu,  4 Apr 2024 13:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Rt+OeyhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D1B88447; Thu,  4 Apr 2024 13:49:17 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADAA88408
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B3AE424B5
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712231315;
 bh=3nBZVv03WTyeQ4Fd5e0Yn8JXJ75KJB3GamdqMVq+sDs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Rt+OeyhFAw1Q2bf9Ppmr+Io+QCJOqw17Y8ArqwfnS9mO0vv2tgs87u3SOnkvY74mo
 HSvdbIkGXG242tmK8FROj9ZHrCM7Xnx+XjlRiVyeZn0HB+sp9MIAmp8TjHyzw307Mg
 wE0YwKu1VcU9KrjOssgOQXtYE1wuiZO+4BgnGhbg4mjEB1MMFkf7pMEKeFN0257yhN
 CnkKY++kqpPtKmChRs8mpmjHAC2agtt76ZRQk0yM6YTf/yFlisnUBJAn3ycmX4LqDY
 J0iCIwm9/dfaEmKD/lu/WkzfEXwJL1KWu9IeDYhesGWygS7Fnj3cMurgeuJRzNbcls
 inCqagZLlB9ww==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-416259a5fe5so4445065e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712231277; x=1712836077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3nBZVv03WTyeQ4Fd5e0Yn8JXJ75KJB3GamdqMVq+sDs=;
 b=L98hgagTxFOBqfR9iz/9zBRDnrkmjEJPKcWljnpNkSZvSveknxAIbBLAy8W1B9sayc
 BLvOGRiLZ4IJWlXDwtOekSqYB9Qk4HSbwdw0kDIvPIK0nTR3Il8CYAjaR4owHCk0b+ia
 FNeR0NAv38Fq57eDyXztpJynqr7msIV767ZsyNTl3tAMDfq+3eDKopxt+mR1DfJsp8WC
 vCv0B9WeFQxIj+wRALR2Pf8Uo6a49IoY9gaDqG6Z+DrBssI/8Dl59Fd4fRaPCzZOOj2e
 PqOE/QAf0uAGXk4G/dpEVm4w1xU3MKz7dFGZFGylNCJ7V8aDiSfPz7kFS1Am2/qFqt/I
 rCOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv/gemlKWT4GxjdR9dUTSD8i3iD2qx4aLvWzjymQVF1tzSmZDABl2IlMkKIioM6F33HQytWu1gTG843VrlFuEmZtMlYQ==
X-Gm-Message-State: AOJu0YzmQ2XGHThONryn9G1SNI3Ea5OdFs8CRRn7ue5Sv8Qf71BaJW/M
 DGBl8+kE3GAsyb+ESL6dSpezxtpRJqDrdNs7wXHG94mgeVClgQXETP5+bslPG/kwkvf9W03Tx1m
 Hxf+EABiZnuvPfKbegNkO41BuUANh52njRIvDGN2F+9PsjibxdyYof71aMaIWyaEoibU=
X-Received: by 2002:a05:600c:20e:b0:413:f3f0:c591 with SMTP id
 14-20020a05600c020e00b00413f3f0c591mr2159697wmi.41.1712231277380; 
 Thu, 04 Apr 2024 04:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFah1cphi853x9b0fIPlqlBSabTD+n9t+g+oXWNbVHuET9FltoNgSg54k46lXGjfaSNf+jo3w==
X-Received: by 2002:a05:600c:20e:b0:413:f3f0:c591 with SMTP id
 14-20020a05600c020e00b00413f3f0c591mr2159678wmi.41.1712231277096; 
 Thu, 04 Apr 2024 04:47:57 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a05600c350200b00414906f1ea1sm2422134wmq.17.2024.04.04.04.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 04:47:56 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>,
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] boot: correct finding the default EFI binary
Date: Thu,  4 Apr 2024 13:47:42 +0200
Message-ID: <20240404114742.81187-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
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

* The sandbox must not use an arbitrary file name bootsbox.efi but the
  file name matching the host architecture to properly boot the respective
  file. We already have an include which provides a macro with the name of
  the EFI binary. Use it.

* The path to the EFI binary should be absolute.

* The path and the file name must be capitalized to conform to the UEFI
  specification. This is important when reading from case sensitive
  file systems.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 boot/bootmeth_efi.c  | 44 +++-----------------------------------------
 test/boot/bootflow.c |  4 +++-
 2 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index a46b6c9c805..aebc5207fc0 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -14,6 +14,7 @@
 #include <bootmeth.h>
 #include <command.h>
 #include <dm.h>
+#include <efi_default_filename.h>
 #include <efi_loader.h>
 #include <fs.h>
 #include <malloc.h>
@@ -23,43 +24,7 @@
 #include <pxe_utils.h>
 #include <linux/sizes.h>
 
-#define EFI_DIRNAME	"efi/boot/"
-
-/**
- * get_efi_leafname() - Get the leaf name for the EFI file we expect
- *
- * @str: Place to put leaf name for this architecture, e.g. "bootaa64.efi".
- *	Must have at least 16 bytes of space
- * @max_len: Length of @str, must be >=16
- */
-static int get_efi_leafname(char *str, int max_len)
-{
-	const char *base;
-
-	if (max_len < 16)
-		return log_msg_ret("spc", -ENOSPC);
-	if (IS_ENABLED(CONFIG_ARM64))
-		base = "bootaa64";
-	else if (IS_ENABLED(CONFIG_ARM))
-		base = "bootarm";
-	else if (IS_ENABLED(CONFIG_X86_RUN_32BIT))
-		base = "bootia32";
-	else if (IS_ENABLED(CONFIG_X86_RUN_64BIT))
-		base = "bootx64";
-	else if (IS_ENABLED(CONFIG_ARCH_RV32I))
-		base = "bootriscv32";
-	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
-		base = "bootriscv64";
-	else if (IS_ENABLED(CONFIG_SANDBOX))
-		base = "bootsbox";
-	else
-		return -EINVAL;
-
-	strcpy(str, base);
-	strcat(str, ".efi");
-
-	return 0;
-}
+#define EFI_DIRNAME	"/EFI/BOOT/"
 
 static int get_efi_pxe_arch(void)
 {
@@ -259,10 +224,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 		return -ENOENT;
 
 	strcpy(fname, EFI_DIRNAME);
-	ret = get_efi_leafname(fname + strlen(fname),
-			       sizeof(fname) - strlen(fname));
-	if (ret)
-		return log_msg_ret("leaf", ret);
+	strcat(fname, BOOTEFI_NAME);
 
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index e60e9309fa9..674d4c05f83 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -13,6 +13,7 @@
 #include <bootstd.h>
 #include <cli.h>
 #include <dm.h>
+#include <efi_default_filename.h>
 #include <expo.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
@@ -179,7 +180,8 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
 	ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
-	ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       efi/boot/bootsbox.efi");
+	ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/"
+			   BOOTEFI_NAME);
 
 	ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
 	ut_assert_skip_to_line(
-- 
2.43.0

