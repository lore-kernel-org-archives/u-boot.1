Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78000C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 16:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC6F8838CE;
	Thu, 24 Jul 2025 18:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=novatechautomation.com header.i=@novatechautomation.com header.b="cho824JE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F50838D4; Thu, 24 Jul 2025 18:32:21 +0200 (CEST)
Received: from gw2.cammew.com (gw2.cammew.com [64.182.209.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A39838C7
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 18:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
Received: from eric-Desktop.novatech-llc.local (unknown [38.62.160.128])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gw2.cammew.com (Postfix) with ESMTPSA id 224B5EDCCD;
 Thu, 24 Jul 2025 12:32:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 gw2.cammew.com 224B5EDCCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=novatechautomation.com; s=relay; t=1753374734;
 bh=FBRCO3EiFbYdc8kk4ILJXi42b72wAttaiRw37xpozQ4=;
 h=From:To:Cc:Subject:Date:From;
 b=cho824JEVEDuBnhN4/3Nnxut8iyFOuYEHZJ6eFpjPY4O/WvTlQ01hGf99TpxZpWRz
 yquBso1Zz3+yzrKTwH1k4kOIsGHBHfkaXHG2FCIqWAHBaFbYuwHyOxGYjldLz6moU3
 Dv541f84/xsrfQ8PD+I7JYFBuw7qwdM7pA3/4fig=
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: u-boot@lists.denx.de
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Subject: [PATCH] x86: Fix TCPA bloblist size
Date: Thu, 24 Jul 2025 11:31:56 -0500
Message-ID: <20250724163156.1372667-1-eric.schikschneit@novatechautomation.com>
X-Mailer: git-send-email 2.43.0
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

Excessive default value causes crash on hardware: x86 baytrail E3845

It is unclear where the data is being populated being 'BLOBLISTT_TCPA_LOG'
is not found elsewhere in the u-boot tree. This leads to confusion about
how much space for TPM log is actually needed.

This was tested on hardware using TPMv1.

Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
---
 arch/x86/lib/acpi_table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index 5ecd3d4b651..ea7825b61ff 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -173,7 +173,7 @@ int acpi_write_tcpa(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	struct acpi_table_header *header;
 	struct acpi_tcpa *tcpa;
 	u32 current;
-	int size = 0x10000;	/* Use this as the default size */
+	int size = 1500;	/* Use this as the default size */
 	void *log;
 	int ret;
 
@@ -194,7 +194,6 @@ int acpi_write_tcpa(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	ret = bloblist_ensure_size_ret(BLOBLISTT_TCPA_LOG, &size, &log);
 	if (ret)
 		return log_msg_ret("blob", ret);
-
 	tcpa->platform_class = 0;
 	tcpa->laml = size;
 	tcpa->lasa = nomap_to_sysmem(log);
-- 
2.43.0

