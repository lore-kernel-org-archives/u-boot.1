Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2CAC47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D981E87D0A;
	Mon, 29 Jan 2024 22:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VwwuvgpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06D587C87; Mon, 29 Jan 2024 22:05:07 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E7187C87
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CBCB43F8C8; 
 Mon, 29 Jan 2024 21:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706562297;
 bh=askMd1anmPP0ZMuUS3ptXHRsLE1ZLHmO95kw94ESEKQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=VwwuvgpKdZWun+mf8enhq1RNHv3YUoOFh3BYFz8ZgGSNxzuCiVfyi/NqtqFJqFel5
 0WFocz3n9fmLyTO/KgJT7aqAHySBTECf0OgvE9c3yZJ8tZR5k6p5Ung6JQF1msri77
 EoP6x/1/yO5DH/4tXS8LwhkMTa2BYxbYeLTpEmxQet1FUqf9gowBFeclEIyaJUs05P
 r6WdZBYcD27sGFScyFsvrZw7GbNgc54HtjzHiWRzWAvWt+N+uBcGOm/WKJOJBaAMG7
 z76YDhTh7KoVPjKyrb7B69WTWIXvDCdaDPYIAVCINhOcs54Gn9jzHKX4UYH3GELlvX
 hhNUMuklaVGlA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/7] cmd: smbios: add missing colon after UUID
Date: Mon, 29 Jan 2024 22:04:48 +0100
Message-ID: <20240129210453.31070-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
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

For consistent formatting add a colon ':' after the UUID label.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 67f3a9f5f19..62935ecd1a2 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -76,7 +76,7 @@ static void smbios_print_type1(struct smbios_type1 *table)
 	smbios_print_str("Version", table, table->version);
 	smbios_print_str("Serial Number", table, table->serial_number);
 	if (table->length >= 0x19) {
-		printf("\tUUID %pUl\n", table->uuid);
+		printf("\tUUID: %pUl\n", table->uuid);
 		smbios_print_str("Wake Up Type", table, table->serial_number);
 	}
 	if (table->length >= 0x1b) {
-- 
2.43.0

