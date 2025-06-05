Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8156C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 07:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E24FC8091A;
	Thu,  5 Jun 2025 09:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I79/A9SP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA9C8091A; Thu,  5 Jun 2025 09:46:32 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFBB80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 09:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 28E6DA502E2;
 Thu,  5 Jun 2025 07:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20B9C4CEE7;
 Thu,  5 Jun 2025 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749109588;
 bh=P2Ba8MGTqVsUmaZZe3e5Xw4kMTYcLoOUgkvm3A4dlyA=;
 h=From:To:Cc:Subject:Date:From;
 b=I79/A9SPaDvQ9jgoSu93nxdlsK9b7yex1F5UA0vtNKMzsj3KKdoWLm8INj71rKCEZ
 DW+Gv1PFqyd0DY8oFpL7uTpRIAXyzhonYMZqLz0t7TGObbwSAax42kEuP0DkpBYckx
 jxciuxbAtumrVtbnVlfatNTT3YYJMQbdnsmtokeD1Sq6rgVx8WMOEvUymzJMd5gV10
 ZmLH6Wa42coHhmzch1yYa78Qe1O0CixB6BvKbY3Yx/htFZiU6z0dVPKS3YNvCtZRi7
 xK0AZg0VRDiOFFaMbdVyMrjmvjG1wsocduBmcm8GkBQxDrNoLidEEybBQSADWI66cv
 L9RHRnqYj9mFg==
From: Michael Walle <mwalle@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2] env: mmc: fix offsets relative to the end of the partition
Date: Thu,  5 Jun 2025 09:46:10 +0200
Message-Id: <20250605074610.1424953-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
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

According to the help text, you can set negative offsets to indicated
that the offset is relative to the end of the parition. But kconfig
doesn't let you specify negative hex values. I think this fell through
the cracks when converting the symbol from a '#define' to a kconfig
option.

Introduce a new boolean kconfig option to switch on the "relative to the
end" behavior.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v2:
 - made the Kconfig help text clearer on MMC hardware partitions.
   I've used the term "MMC hardware partition" as it was already
   used in some help texts. Thanks Quentin.
 - fixed typo. Thanks Quentin.

 env/Kconfig | 42 +++++++++++++++++++++++++-----------------
 env/mmc.c   |  8 ++++++++
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index d7a7e81144b..58500becbb7 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -231,14 +231,6 @@ config ENV_IS_IN_MMC
 	  These two #defines specify the offset and size of the environment
 	  area within the specified MMC device.
 
-	  If offset is positive (the usual case), it is treated as relative to
-	  the start of the MMC partition. If offset is negative, it is treated
-	  as relative to the end of the MMC partition. This can be useful if
-	  your board may be fitted with different MMC devices, which have
-	  different sizes for the MMC partitions, and you always want the
-	  environment placed at the very end of the partition, to leave the
-	  maximum possible space before it, to store other data.
-
 	  These two values are in units of bytes, but must be aligned to an
 	  MMC sector boundary.
 
@@ -249,9 +241,6 @@ config ENV_IS_IN_MMC
 	  valid backup copy in case the other copy is corrupted, e.g. due
 	  to a power failure during a "saveenv" operation.
 
-	  This value may also be positive or negative; this is handled in the
-	  same way as CONFIG_ENV_OFFSET.
-
 	  In case CONFIG_SYS_MMC_ENV_PART is 1 (i.e. environment in eMMC boot
 	  partition) then setting CONFIG_ENV_OFFSET_REDUND to the same value
 	  as CONFIG_ENV_OFFSET makes use of the second eMMC boot partition for
@@ -611,9 +600,18 @@ config ENV_OFFSET
 	  Offset from the start of the device (or partition).
 
 	  This offset may be interpreted differently depending on the chosen
-	  ENV_IS_IN_* options. For example, for ENV_IS_IN_MMC=y, this offset may
-	  be negative to indicate an offset backwards from the end of the
-	  partition. See the relevant help messages for more details.
+	  ENV_IS_IN_* options. See the relevant help messages for more details.
+
+config ENV_OFFSET_RELATIVE_END
+	bool "Offset is relative to the end of the partition"
+	depends on ENV_IS_IN_MMC
+	help
+	  Treat the environment offset as relative to the end of the MMC
+	  hardware partition. This can be useful if your board may be fitted
+	  with different MMC devices, which have different sizes for the MMC
+	  hardware partitions, and you always want the environment placed at the
+	  very end of the partition, to leave the maximum possible space before
+	  it, to store other data.
 
 config ENV_OFFSET_REDUND
 	hex "Redundant environment offset"
@@ -626,9 +624,19 @@ config ENV_OFFSET_REDUND
 	  environment location.
 
 	  This offset may be interpreted differently depending on the chosen
-	  ENV_IS_IN_* options. For example, for ENV_IS_IN_MMC=y, this offset may
-	  be negative to indicate an offset backwards from the end of the
-	  partition. See the relevant help messages for more details.
+	  ENV_IS_IN_* options. See the relevant help messages for more details.
+
+config ENV_OFFSET_REDUND_RELATIVE_END
+	bool "Offset is relative to the end of the partition"
+	depends on SYS_REDUNDAND_ENVIRONMENT
+	depends on ENV_IS_IN_MMC
+	help
+	  Treat the redundant environment offset as relative to the end of the
+	  MMC hardware partition. This can be useful if your board may be
+	  fitted with different MMC devices, which have different sizes for the
+	  MMC hardware partitions, and you always want the environment placed at
+	  the very end of the partition, to leave the maximum possible space
+	  before it, to store other data.
 
 config ENV_SIZE
 	hex "Environment Size"
diff --git a/env/mmc.c b/env/mmc.c
index 8848371eb4f..8211470a08f 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -29,11 +29,19 @@
 
 #else
 /* Default ENV offset when not defined in Device Tree */
+#if !defined(CONFIG_ENV_OFFSET_RELATIVE_END)
 #define ENV_MMC_OFFSET		CONFIG_ENV_OFFSET
+#else
+#define ENV_MMC_OFFSET		(-(CONFIG_ENV_OFFSET))
+#endif
 
 #if defined(CONFIG_ENV_OFFSET_REDUND)
+#if !defined(CONFIG_ENV_OFFSET_REDUND_RELATIVE_END)
 #define ENV_MMC_OFFSET_REDUND	CONFIG_ENV_OFFSET_REDUND
 #else
+#define ENV_MMC_OFFSET_REDUND	(-(CONFIG_ENV_OFFSET_REDUND))
+#endif
+#else
 #define ENV_MMC_OFFSET_REDUND	ENV_MMC_INVALID_OFFSET
 #endif
 #endif
-- 
2.39.5

