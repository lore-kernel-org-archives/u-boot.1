Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79D8C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 00:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B9087BCB;
	Thu,  1 Feb 2024 01:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gh/GMlA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B43A0878C9; Thu,  1 Feb 2024 01:20:41 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B68487B2A
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 01:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 11F62419B0; 
 Thu,  1 Feb 2024 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706746833;
 bh=C0/3rvl/73Rs0Icaag/mYcs2x5ymAKiG9JfSKTpCuIQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gh/GMlA6DeVIoUX1JbB4PcnEkjuKMmG6kZT1NWYgKKIFEHaoyVySRXsK4OiSyERUy
 oKjO/tBz1A/lBN5hFpDE9z8K/UJ4TE2c1ntcPww65n5bXUTawE+mU4W4khGTqaMUQg
 mK40xT16GH+Zw7psyzZoJKwOwZUNn5aCYDHB7DIGF5sn2bJV7OdcOlki3hE6ZDbV7g
 oAuUxBfngp7g0YYve9X6s5Dl9B3bHkT2LewQimClsfWYIkudgBKVEgzMiIyYXIEwM+
 BJbrnkbRCicqFNs2MWBTRAbGPq7Yz0uMHJW08CxcfvP2DiA5g7ue3Ek13jGhoHgjFw
 09tBsZ8kBaKsg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] cmd: smbios: show correct table size for SMBIOS2.1 entry
 point
Date: Thu,  1 Feb 2024 01:20:20 +0100
Message-ID: <20240201002022.11258-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201002022.11258-1-heinrich.schuchardt@canonical.com>
References: <20240201002022.11258-1-heinrich.schuchardt@canonical.com>
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

The SMBIOS table size for SMBIOS2.1 entry points is in field 'Structure
Table Length' (offset 0x16) and not in field 'Maximum Structure Size'
(offset 0x08).

Rename the receiving variable max_struct_size to table_maximum_size
to avoid future confusion.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/smbios.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 95bdff6026..e2d82be163 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -126,7 +126,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 	static const char smbios_sig[] = "_SM_";
 	static const char smbios3_sig[] = "_SM3_";
 	size_t count = 0;
-	u32 max_struct_size;
+	u32 table_maximum_size;
 
 	addr = gd_smbios_start();
 	if (!addr) {
@@ -142,7 +142,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 			 entry3->major_ver, entry3->minor_ver, entry3->doc_rev);
 		table = (void *)(uintptr_t)entry3->struct_table_address;
 		size = entry3->length;
-		max_struct_size = entry3->max_struct_size;
+		table_maximum_size = entry3->max_struct_size;
 	} else if (!memcmp(entry, smbios_sig, sizeof(smbios_sig) - 1)) {
 		struct smbios_entry *entry2 = entry;
 
@@ -150,7 +150,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 			 entry2->major_ver, entry2->minor_ver);
 		table = (void *)(uintptr_t)entry2->struct_table_address;
 		size = entry2->length;
-		max_struct_size = entry2->max_struct_size;
+		table_maximum_size = entry2->struct_table_length;
 	} else {
 		log_err("Unknown SMBIOS anchor format\n");
 		return CMD_RET_FAILURE;
@@ -163,7 +163,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	for (struct smbios_header *pos = table; pos; pos = next_table(pos))
 		++count;
-	printf("%zd structures occupying %d bytes\n", count, max_struct_size);
+	printf("%zd structures occupying %d bytes\n", count, table_maximum_size);
 	printf("Table at 0x%llx\n", (unsigned long long)map_to_sysmem(table));
 
 	for (struct smbios_header *pos = table; pos; pos = next_table(pos)) {
-- 
2.43.0

