Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B849CC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0482486EF6;
	Sat, 11 Nov 2023 14:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KwFYUxoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A409D870E1; Sat, 11 Nov 2023 14:42:40 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38E486F1C
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 45901416D4; 
 Sat, 11 Nov 2023 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699710158;
 bh=k+NWhEY4vaWdJW4zOhHfpE1CpSeebdS1WIiJl5P+zOM=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=KwFYUxoZLUbkCVlFi9uzyGfc7T4qQl8RE1OSNYRBQxM2cuvQi4z3gmNiTl/UPx2nC
 hU4u58EldcW/mPASas9LV+M5lMSlkCkBMMVNB686fWqvkxcZ8OmO98TXHmvdO0HAeM
 Pg0k1H82zdmHDR2Ux4aWHAuDapt+yud3scW6JX62Wka8MEZMLKV/OiA+npbWtg+Ubx
 yyxTffbLtRPOs8Ui0qacmuZqUm4lbRx5qlz2nx2f8NdDLUXo/65T9B6L2XN8hCXZyb
 6gUKE/v+z8W1uNj2EhlyZWGWNicSiVt1D2bFf7UNLFFEYpfGAtkvc4fKk7NFuKAbj6
 xf57YdlauMeEg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] acpi: fix struct acpi_xsdt
Date: Sat, 11 Nov 2023 14:41:10 +0100
Message-Id: <20231111134112.165377-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
References: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
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

The size of the ACPI table header is not a multiple of 8. We have to mark
struct acpi_xsdt as packed to correctly read the entries.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/acpi/acpi_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index a3b67259e6..20ac3b51ba 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -80,7 +80,7 @@ struct acpi_rsdt {
 };
 
 /* XSDT (Extended System Description Table) */
-struct acpi_xsdt {
+struct __packed acpi_xsdt {
 	struct acpi_table_header header;
 	u64 entry[MAX_ACPI_TABLES];
 };
-- 
2.40.1

