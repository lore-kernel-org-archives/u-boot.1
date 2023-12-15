Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2164C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540CC87C30;
	Fri, 15 Dec 2023 19:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XoZh1S0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9AA987C4C; Fri, 15 Dec 2023 19:27:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8473687BD5
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
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BBF66413E3; 
 Fri, 15 Dec 2023 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702664828;
 bh=f3EP1ahUVaLC7xXYaqfuYXoaHI2O4igxkqkwtXYTLV0=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=XoZh1S0sFk9Y5VY864Vk8YMdfOOR4fWMsA0yWE2OlqbxBZ88XB96If4350I+CcH/m
 rCRSIEZxN2JwlULNsgLNh5C5KrYsozxzCRhEAloKV4k4GwoGj/3C7nXy8zuVc/4pHV
 iRJmxbVjdlFc7fCRz3YqpPg/Qdro6w/Shb9sxQ89FYHnmd9gCy1IHs90djtNNQ+TBg
 PnA+dX6uTuXW/5+yYqSZCepUY/V3j16tVg/OOWprPWFNFwKXpz61qZhV4aGvKk/zjI
 3WvDhRjUGhyL0Gy8HF2Zzt4Bg3/O5I5k6gtWU+k417uizHOuk52Xmi73gqfSAlyggP
 8gF58/6F+t0ZA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/4] cmd: acpi: fix listing DSDT and FACS
Date: Fri, 15 Dec 2023 19:26:56 +0100
Message-Id: <20231215182658.187516-3-heinrich.schuchardt@canonical.com>
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

If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
field X_DSDT is filled, field DSDT must be ignored.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	check FADT table revision
---
 cmd/acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 0c14409242..8d9eaf36c9 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -53,9 +53,13 @@ static int dump_table_name(const char *sig)
 
 static void list_fadt(struct acpi_fadt *fadt)
 {
-	if (fadt->dsdt)
+	if (fadt->header.revision >= 3 && fadt->x_dsdt)
+		dump_hdr(map_sysmem(fadt->x_dsdt, 0));
+	else if (fadt->dsdt)
 		dump_hdr(map_sysmem(fadt->dsdt, 0));
-	if (fadt->firmware_ctrl)
+	if (fadt->header.revision >= 3 && fadt->x_firmware_ctrl)
+		dump_hdr(map_sysmem(fadt->x_firmware_ctrl, 0));
+	else if (fadt->firmware_ctrl)
 		dump_hdr(map_sysmem(fadt->firmware_ctrl, 0));
 }
 
-- 
2.40.1

