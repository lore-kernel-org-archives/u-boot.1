Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1BBC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C027A87C56;
	Fri, 15 Dec 2023 19:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T0qiVx8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37B187BD5; Fri, 15 Dec 2023 19:27:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB6D87C28
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 38803420EA; 
 Fri, 15 Dec 2023 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702664829;
 bh=6NXcajfgh0nE+SkxjeZ28aIQ2bXzGt/6XyoC6f0NBnA=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=T0qiVx8abhkMIVKACKOJWcrK25BjkvvxBpW+VOCFxZakgUm2v4lyvn2wuoPSigaPM
 LeKAO9cYB4rUQHUSoLoivcAKo9HdgyQCGZKEyLxPyjkDtQ5tOb6kLZm0Ms63w+Uw+h
 nHDeQV/UZix6L0gC/vn7/nlTPV1JnKQv3BzSVHREQ2USbWEPgYzcvyxqZK2iQsg8Ai
 MN4VnhTRhX4QtT9UJwDl01bScX11wov6oV+3zj6ztA7mCWKVu1fDeivsudlsZnFrk4
 XLlao0xg+Wq7NlxYlUbT3c6bT5/7/u6Snb2s9vvtHmvi8rvHPlQXX09qtnraCIRrgB
 0TTom1MOEIUUg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/4] cmd: acpi: check HW reduced flag in acpi list
Date: Fri, 15 Dec 2023 19:26:57 +0100
Message-Id: <20231215182658.187516-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215182658.187516-1-heinrich.schuchardt@canonical.com>
References: <20231215182658.187516-1-heinrich.schuchardt@canonical.com>
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

On non x86 platforms the hardware reduce flag must be set in the FADT
table. Write an error message if the flag is missing.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 cmd/acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 8d9eaf36c9..f6e02ea7a5 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <command.h>
 #include <display_options.h>
+#include <log.h>
 #include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/acpi_table.h>
@@ -57,6 +58,9 @@ static void list_fadt(struct acpi_fadt *fadt)
 		dump_hdr(map_sysmem(fadt->x_dsdt, 0));
 	else if (fadt->dsdt)
 		dump_hdr(map_sysmem(fadt->dsdt, 0));
+	if (!IS_ENABLED(CONFIG_X86) &&
+	    !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
+		log_err("FADT not ACPI hardware reduced compliant\n");
 	if (fadt->header.revision >= 3 && fadt->x_firmware_ctrl)
 		dump_hdr(map_sysmem(fadt->x_firmware_ctrl, 0));
 	else if (fadt->firmware_ctrl)
-- 
2.40.1

