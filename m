Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7300C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 14:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD3E877B1;
	Sun, 21 Jan 2024 15:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="keSsDI0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C5C8780A; Sun, 21 Jan 2024 15:05:07 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFF28775F
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 15:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 664263F722; 
 Sun, 21 Jan 2024 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705845904;
 bh=mz4673nq7wk66FiVMt59yJch2BNuEmHfw/O0U65pRpM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=keSsDI0kfUTEw0fmu0b8m2tqAj7afT+BEpCFWbmlwa/It4AcNjeX5knp7v3JHTti0
 t93NgHBydptHQugmA124m0kDo8W1MnZnkV1jHdmvUwK3o1q4AyDgOzhXU7VyUKReFj
 0dzSROBDTo5x98AcBRN1cbnY6TPG1c8p1Colp5Fj78YUacaH9dwXM8laofA0vR9zMH
 8qji93WFdwLFGVijska8NQn6v1sonGe2drSx5VIIngCsl6y7Fk0IHavkp955PnmGfB
 xB8Iad4JDlkBSTb9ofl2UGXbjbxouHF9kx6XfMmEkHCtIoeZNGi6HjsfdUhqSCE6FX
 Q70Qd3pXT5zgg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: remove duplicate declaration of acpi_fill_header()
Date: Sun, 21 Jan 2024 15:05:00 +0100
Message-ID: <20240121140500.176028-1-heinrich.schuchardt@canonical.com>
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

acpi_fill_header() is declared twice in include/acpi/acpi_table.h

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/acpi/acpi_table.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index e67562ef654..2e22ce92996 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -828,16 +828,6 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
 		      struct acpi_gen_regaddr *address, uint32_t address_size,
 		      const char *device_path);
 
-/**
- * acpi_fill_header() - Set up a new table header
- *
- * This sets all fields except length, revision, checksum and aslc_revision
- *
- * @header: ACPI header to update
- * @signature: Table signature to use (4 characters)
- */
-void acpi_fill_header(struct acpi_table_header *header, char *signature);
-
 /**
  * acpi_align() - Align the ACPI output pointer to a 16-byte boundary
  *
-- 
2.43.0

