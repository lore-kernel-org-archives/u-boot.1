Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96440C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 16:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8B787C19;
	Fri, 15 Dec 2023 17:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I+7SBsqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66DB87C2A; Fri, 15 Dec 2023 17:40:27 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970A087C13
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 17:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DAAB7401C3; 
 Fri, 15 Dec 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702658424;
 bh=ZoOOkKHAOHkUMrUnxM2YjUVpfxTdEWT3nbAiRUNR/5Y=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=I+7SBsqPbZqhHt8DY1GxRVImITX00XvvzQV3hqyuzxk3H0rbo67xeFPIrbfbhSIeL
 llD7UXSs11QJT3QkNvB0h3I+4k6SvYLd/LLcZuANT4Xse+mpYQIdO1N2Xxtlrifz22
 ZfSIDIV4JeObG/zC615uwkj/L8RMeGTVJ7ucxb34yIPeJfMw9vdJu1iYRmGAEFURwl
 OK3TjE7eeCAfd9jwrLSbm2wuA0iDVhDlq/n9rFrr8cb2vgDbOPdVZyCFjjNH7UW6La
 29yF3sP0+K4tS+DGqR0BHHD72w1BSIubz/GRfAR1p2CsWYuN2uT/KvFNdjyn7nfUqg
 1H3bBEzMBZnyw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] cmd: acpi: fix listing DSDT and FACS
Date: Fri, 15 Dec 2023 17:40:15 +0100
Message-Id: <20231215164016.137794-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
References: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
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

If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
field X_DSDT is filled, field DSDT must be ignored.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 0c14409242..24910c150b 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -53,9 +53,13 @@ static int dump_table_name(const char *sig)
 
 static void list_fadt(struct acpi_fadt *fadt)
 {
-	if (fadt->dsdt)
+	if (fadt->x_dsdt)
+		dump_hdr(map_sysmem(fadt->x_dsdt, 0));
+	else if (fadt->dsdt)
 		dump_hdr(map_sysmem(fadt->dsdt, 0));
-	if (fadt->firmware_ctrl)
+	if (fadt->x_firmware_ctrl)
+		dump_hdr(map_sysmem(fadt->x_firmware_ctrl, 0));
+	else if (fadt->firmware_ctrl)
 		dump_hdr(map_sysmem(fadt->firmware_ctrl, 0));
 }
 
-- 
2.40.1

