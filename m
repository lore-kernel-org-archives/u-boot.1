Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B7EC47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 07:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD24C87BAD;
	Fri, 26 Jan 2024 08:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="viPpxKrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED3187BD1; Fri, 26 Jan 2024 08:54:42 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29F887BA1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 08:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 359213F2F1; 
 Fri, 26 Jan 2024 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706255678;
 bh=S7R73aHGc5UlXnJpubxtpfZGYvH3zbO5nTirLktApLs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=viPpxKrnHi0H8VhMHQZeb0dc/R7ls2ye27b1VKpia7UCvckOg9Si5ituklDil7X6A
 uOQ4yDplffKP1WRu1xcp/JtAUY5s+MYLZUHqII+JVN1rrgs3RpQyoJSUu60Fvxoiux
 K2KwdUYEvm2xy0pPpQAmKrw8V54MGTR+b7TL9c3QLouF7pI2rQSMWH3Y/BU0nrGql/
 rHLVMnC37wzxJ/1UF9c285pgytWMhcxL2ZPdtnwusTv0cdnH4YHeBynJqyN5IuVmZj
 hBkn7iMkCqw3TV3IfugsnUxdHGeZ201fyD6ZGs9txDneTGodlm1cM5cvIq3R8E8Jft
 Fvm3pt7LrAeIg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] cmd: in do_efi_capsule_esrt use
 efi_get_configuration_table
Date: Fri, 26 Jan 2024 08:54:31 +0100
Message-ID: <20240126075431.22876-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126075431.22876-1-heinrich.schuchardt@canonical.com>
References: <20240126075431.22876-1-heinrich.schuchardt@canonical.com>
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

Use library function efi_get_configuration_table() to find the ESRT.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/efidebug.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index a3a7556ea4a..a587860e2a5 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -173,15 +173,12 @@ EFI_ESRT_UPDATE_STATUS_NUM  > (idx) ? efi_update_status_str[(idx)] : "error"\
 static int do_efi_capsule_esrt(struct cmd_tbl *cmdtp, int flag,
 			       int argc, char * const argv[])
 {
-	struct efi_system_resource_table *esrt = NULL;
+	struct efi_system_resource_table *esrt;
 
 	if (argc != 1)
 		return CMD_RET_USAGE;
 
-	for (int idx = 0; idx < systab.nr_tables; idx++)
-		if (!guidcmp(&efi_esrt_guid, &systab.tables[idx].guid))
-			esrt = (struct efi_system_resource_table *)systab.tables[idx].table;
-
+	esrt = efi_get_configuration_table(&efi_esrt_guid);
 	if (!esrt) {
 		log_info("ESRT: table not present\n");
 		return CMD_RET_SUCCESS;
-- 
2.43.0

