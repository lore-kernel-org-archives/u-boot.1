Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D85C38147
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 08:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C79E87BB9;
	Sat, 16 Dec 2023 09:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PN0fnqbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C9187B45; Sat, 16 Dec 2023 09:12:14 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11EAB87620
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9DAA23F6B8; 
 Sat, 16 Dec 2023 08:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702714331;
 bh=jxuEG0n9G5ifs2JGpRXf8I5fpZiGy1R3rgUkV+AJsMU=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=PN0fnqbWiazBwjLIb2/jVsjPsqRJPtxaHdJcf5Ylkl8PPcEQ79QOz6UXXg3Iy1UK9
 PPXGoz7VfnFB2yQsWfakW4uOSKsBZkqSla4TkYzt4iQtIV28AppJjQHa2XZKWUIC9X
 4/fD7nI1Q0GJg0GivAD7j7CBMcRLaxkut/2r7evdfA9guHKE3nsQsgl2qMJZ9LUP7C
 jACcLXWgurJUkd3wo7IQ/T2EGpuQJj3K4Jlq5W1FyEfkXY7N3YVpwFVgR8Z38OyLEG
 FJYeWVBDZO5Ohlw1fOCwweaWGt68cgRQUkdval+SJh26j8V4YAig3XeBI41QTs/BSV
 tCIJGcsConnKQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/4] acpi: support 64bit in acpi_find_table for DSDT and
 FACS
Date: Sat, 16 Dec 2023 09:12:00 +0100
Message-Id: <20231216081200.7677-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
References: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
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

Use X_DSDT and X_FIRMWARE_CTRL if available.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/acpi/acpi.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
index f21e509461..f80b2176e1 100644
--- a/lib/acpi/acpi.c
+++ b/lib/acpi/acpi.c
@@ -45,11 +45,30 @@ struct acpi_table_header *acpi_find_table(const char *sig)
 		if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN)) {
 			struct acpi_fadt *fadt = (struct acpi_fadt *)hdr;
 
-			if (!memcmp(sig, "DSDT", ACPI_NAME_LEN) && fadt->dsdt)
-				return map_sysmem(fadt->dsdt, 0);
-			if (!memcmp(sig, "FACS", ACPI_NAME_LEN) &&
-			    fadt->firmware_ctrl)
-				return map_sysmem(fadt->firmware_ctrl, 0);
+			if (!memcmp(sig, "DSDT", ACPI_NAME_LEN)) {
+				void *dsdt;
+
+				if (fadt->header.revision >= 3 && fadt->x_dsdt)
+					dsdt = map_sysmem(fadt->x_dsdt, 0);
+				else if (fadt->dsdt)
+					dsdt = map_sysmem(fadt->dsdt, 0);
+				else
+					dsdt = NULL;
+				return dsdt;
+			}
+
+			if (!memcmp(sig, "FACS", ACPI_NAME_LEN)) {
+				void *facs;
+
+				if (fadt->header.revision >= 3 &&
+				    fadt->x_firmware_ctrl)
+					facs = map_sysmem(fadt->x_firmware_ctrl, 0);
+				else if (fadt->firmware_ctrl)
+					facs = map_sysmem(fadt->firmware_ctrl, 0);
+				else
+					facs = NULL;
+				return facs;
+			}
 		}
 	}
 
-- 
2.40.1

