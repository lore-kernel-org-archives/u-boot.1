Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E1BD2E9C3
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 09:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE11C89232;
	Mon, 11 Nov 2024 10:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AwhqHIN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A97891A4; Mon, 11 Nov 2024 10:16:28 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B44F3881E7
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 10:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 06E953FB6D; 
 Mon, 11 Nov 2024 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731316586;
 bh=ghKmOzZ2N4xzRdJWAg9nT8qJP6fso64Tw2r9glRwNGM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AwhqHIN7u3YX2/OkTIwL2iITpi8xgSe+C3k33DgcoC71lB/3DiCJZn9VxJOvbP7PP
 uCvS6ecCYGK0ZnggS+5YzB4jO5yj0io7H6RIFq7UtoVtmbg5gC2OrYvdxS8MxijkIt
 7Rb3+ioG2GWNhxwLZr7do7D+YaXgboWLbUQ3A1DLqXi7jEd7xm0WdlZSSU3ubelqX6
 5I8rdkNysvwlsbwXgK8zlaMUbkKnp/cOBGZCpuNy3n78LeCtlLcATmEr/SAOgt3F1U
 9Wnuf4cV/JOIJglsC6n6oYr31iMWoIrU8petohG6XmK8etopI6fB8OVEAoTFsCfKTF
 OUmGFa8Ee4zIg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: remove README.TPL
Date: Mon, 11 Nov 2024 10:16:21 +0100
Message-ID: <20241111091621.33005-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

doc/develop/spl.rst describes SPL, TPL, VPL.
Remove the outdated README.TPL document.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/README.TPL | 49 -------------------------------------------------
 1 file changed, 49 deletions(-)
 delete mode 100644 doc/README.TPL

diff --git a/doc/README.TPL b/doc/README.TPL
deleted file mode 100644
index 95b466e4af9..00000000000
--- a/doc/README.TPL
+++ /dev/null
@@ -1,49 +0,0 @@
-Generic TPL framework
-=====================
-
-Overview
---------
-
-TPL---Third Program Loader.
-
-Due to the SPL on some boards(powerpc mpc85xx) has a size limit and cannot
-be compatible with all the external device(e.g. DDR). So add a tertiary
-program loader (TPL) to enable a loader stub loaded by the code from the
-SPL. It loads the final uboot image into DDR, then jump to it to begin
-execution. Now, only the powerpc mpc85xx has this requirement and will
-implemente it.
-
-Keep consistent with SPL, with this framework almost all source files for a
-board can be reused. No code duplication or symlinking is necessary anymore.
-
-How it works
-------------
-
-There has been a directory $(srctree)/spl which contains only a Makefile. The
-Makefile is shared by SPL and TPL.
-
-The object files are built separately for SPL/TPL and placed in the
-directory spl/tpl. The final binaries which are generated are
-u-boot-{spl|tpl}, u-boot-{spl|tpl}.bin and u-boot-{spl|tpl}.map.
-
-During the TPL build a variable named CONFIG_TPL_BUILD is exported in the
-make environment and also appended to CPPFLAGS with -DCONFIG_TPL_BUILD.
-
-The SPL options are shared by SPL and TPL, the board config file should
-determine which SPL options to choose based on whether CONFIG_TPL_BUILD
-is set. Source files can be compiled for TPL with options chosen in the
-board config file.
-
-TPL use a small device tree (u-boot-tpl.dtb), containing only the nodes with
-the pre-relocation properties: 'bootph-all' and 'bootph-pre-sram'
-(see doc/develop/spl.rst for details).
-
-For example:
-
-spl/Makefile:
-LIBS-$(CONFIG_SPL_LIBCOMMON_SUPPORT) += common/libcommon.o
-
-CONFIG_SPL_LIBCOMMON_SUPPORT is defined in board config file:
-#ifdef CONFIG_TPL_BUILD
-#define CONFIG_SPL_LIBCOMMON_SUPPORT
-#endif
-- 
2.45.2

