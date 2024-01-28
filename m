Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63235C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 10:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4180C88179;
	Sun, 28 Jan 2024 11:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Asp1Ln6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC5488179; Sun, 28 Jan 2024 11:24:29 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D336187729
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 11:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 99BB43FFCB; 
 Sun, 28 Jan 2024 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706437465;
 bh=hDhOwthjedxxfEPuyTQwZQrScOtpo8W815eW4xUJjaE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Asp1Ln6uXplGarnoii9c3LLoOB8GISaFHPCySN4GV2bhZBX7K30vVDJ7k4l+SwNpR
 dhBHrpDFhl3m8RxxTNfVeeOMSLv34LROOHpH+Tlxjn8A1mZubrrLvwBBqKJ36sIohl
 +EnpSOAMh/eYabM4Pe/U8hKhFFo/QzzX/4lBCWsNedyWbD3EChTIkwKWILUTBw/qO/
 fY5JmeaVwpna7XWRZSlhY/V4KdgcoCMN9Prnw9xYpH8Pmxsn4eKdDP6b3yUgUZEuqQ
 uHS7FhDbAVYPgg+/XkpmzFQWguI4FVTuMPEBig4wRqVkUrt9fddsj3g7XrAHX9pNz1
 bJrp2usmmCTDQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: smbios_entr() use logical or for booleans
Date: Sun, 28 Jan 2024 11:24:21 +0100
Message-ID: <20240128102421.19726-1-heinrich.schuchardt@canonical.com>
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

As a matter of programming style use logical or to combine two boolean
results.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/smbios-parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index f48d7436570..0d1ac781b38 100644
--- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -15,7 +15,7 @@ const struct smbios_entry *smbios_entry(u64 address, u32 size)
 {
 	const struct smbios_entry *entry = (struct smbios_entry *)(uintptr_t)address;
 
-	if (!address | !size)
+	if (!address || !size)
 		return NULL;
 
 	if (memcmp(entry->anchor, "_SM_", 4))
-- 
2.43.0

