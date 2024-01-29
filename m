Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231D4C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C59C87D8D;
	Mon, 29 Jan 2024 22:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jeoOCMI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1CBE87D99; Mon, 29 Jan 2024 22:05:15 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5682387CCE
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3CBFA3F8CE; 
 Mon, 29 Jan 2024 21:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706562301;
 bh=Kr93haWwzqtB2hUT0qJzBgRIDLQMwrXQDqnnfp/aMfM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=jeoOCMI13Mv34YnmAB5ATwj36wFrnMOKlKlMlRk8uMASmaGGF+6UvR5H/eACzA6X5
 HDVc0+j3Um3Us498Q4tbugGOTgfeKYPz2Ldh9UujGGSuBn8pfnxX9fTLenpH/Fz+b4
 2pViGdVUYniahOEa9FnfMzJ7M/Q3fuwh1bLneFdBTFwok8BFYCtxSeTqYh4F1Q3tNJ
 AUkttE7CjeCIqDRwAtH/+ddBSt76M/dBTKIT+NIOD69WxFI+UDFE8s8RX5CFI+IU9r
 aMIDCijq39J0LfrFfG+tUMGBOrPxpHIMqQdIAAppuGF3Q9BiUghx3kj6qprTCmR7Jw
 2FV8d/TlB+STQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/7] smbios: provide type 4 RISC-V SMBIOS Processor ID
Date: Mon, 29 Jan 2024 22:04:52 +0100
Message-ID: <20240129210453.31070-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
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

For RISC-V CPUs the SMBIOS Processor ID field contains
the Machine Vendor ID from CSR mvendorid.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/cpu/riscv_cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpu/riscv_cpu.c b/drivers/cpu/riscv_cpu.c
index 034b9b49c05..f3e10daf7ec 100644
--- a/drivers/cpu/riscv_cpu.c
+++ b/drivers/cpu/riscv_cpu.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <asm/sbi.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <linux/bitops.h>
@@ -95,13 +96,24 @@ static int riscv_cpu_bind(struct udevice *dev)
 	struct cpu_plat *plat = dev_get_parent_plat(dev);
 	struct driver *drv;
 	int ret;
+	long mvendorid;
 
 	/* save the hart id */
 	plat->cpu_id = dev_read_addr(dev);
+	/* provide data for SMBIOS */
 	if (IS_ENABLED(CONFIG_64BIT))
 		plat->family = 0x201;
 	else
 		plat->family = 0x200;
+	if (CONFIG_IS_ENABLED(RISCV_SMODE)) {
+		/*
+		 * For RISC-V CPUs the SMBIOS Processor ID field contains
+		 * the Machine Vendor ID from CSR mvendorid.
+		 */
+		ret = sbi_get_mvendorid(&mvendorid);
+		if (!ret)
+			plat->id[0] = mvendorid;
+	}
 	/* first examine the property in current cpu node */
 	ret = dev_read_u32(dev, "timebase-frequency", &plat->timebase_freq);
 	/* if not found, then look at the parent /cpus node */
-- 
2.43.0

