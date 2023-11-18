Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892A7C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3F886FE4;
	Sat, 18 Nov 2023 22:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bZmZwy5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B64DE8700D; Sat, 18 Nov 2023 22:52:48 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B813B86F40
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A6B8D413CE; 
 Sat, 18 Nov 2023 21:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700344365;
 bh=wJag742UB9ym2k9xxNQ+7QI0R7BmDPg9nXB41wevxVs=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=bZmZwy5kLTE1sOzr8aXJgPxnaho4mSZMUPxedDxVI3UvvCQcSO2zLunJZcsgrfcFn
 uwy7+oQ5KTnQxs6osc28AAP8ajd/QAl+iAbZza0ERN0DJT4rfS4JiaHMBDqmc05i81
 Sc60IO0OKlm948pmGq18qOtQ0FGujzMMzmIajlCqanlk6nEzCaO7Q95o0sfO5lmfDY
 dAsClXb6YM+UPk+TmRS/AqyDdor4iKqkRRqoXl52N8ra1ZUQhosI2op8mCm+V2BT4g
 axN7Dp0dSpuKrXr94BDSwoP/1eGrPcxz/FJZXxWh0YKe0khbcwg2fNPR3Niv93nd3U
 Bp7MwvqhEW7EA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: simplify acpi_write_ssdt()
Date: Sat, 18 Nov 2023 22:52:37 +0100
Message-Id: <20231118215237.94875-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

* Converting to void * is superfluous when calling memset().
* acpi_fill_header() already fills oem_table_id.

Fixes: d953137526cc ("x86: Move SSDT table to a writer function")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/acpi/ssdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/acpi/ssdt.c b/lib/acpi/ssdt.c
index 659c1aad40..b140b4b2ff 100644
--- a/lib/acpi/ssdt.c
+++ b/lib/acpi/ssdt.c
@@ -18,10 +18,9 @@ int acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	int ret;
 
 	ssdt = ctx->current;
-	memset((void *)ssdt, '\0', sizeof(struct acpi_table_header));
+	memset(ssdt, '\0', sizeof(struct acpi_table_header));
 
 	acpi_fill_header(ssdt, "SSDT");
-	memcpy(ssdt->oem_table_id, OEM_TABLE_ID, sizeof(ssdt->oem_table_id));
 	ssdt->revision = acpi_get_table_revision(ACPITAB_SSDT);
 	ssdt->aslc_revision = 1;
 	ssdt->length = sizeof(struct acpi_table_header);
-- 
2.40.1

