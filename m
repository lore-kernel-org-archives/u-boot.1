Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88707C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DDA687C5B;
	Mon, 29 Jan 2024 22:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IQtesnh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D359987CD5; Mon, 29 Jan 2024 22:05:05 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7B7187B1D
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4963A3F8C7; 
 Mon, 29 Jan 2024 21:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706562296;
 bh=yBbwlXR4BpJo9oZ+PSNE7hH1YwEwAwGZv3lpPIOxJ50=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IQtesnh/uTzGOqp9jiHqQDy1q793xgAJfwY9kAXRaQHqocIdDHr5qmgbuOJJzKUI6
 aAMmNg+bCkTeI0mS5xH46wtxckp6cAeGjGxOaLkQCNlwpglrIWQmW71uARI9oWIi4/
 a5DsXccOWBSYlBB8Yn4vPqES2vUWrrPnHlyafvFNA+fPrImWVATkKcxpPjjMhUfyqN
 4p8RBYnEhMLnys/3yxE1VntYyF6y29YtaU32Zz6SlOFoyfmjyVbl8+0L+6Y4jGDhlH
 oapUX5IqwtAYoj+gPnIe/wtxtLF4ldpXQrvvgCSYUMnl/I/j70mD+pV4kR1j9xwA3I
 CqIE0dJLlL8QQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/7] cmd: smbios: always use '0x%04x' for printing handles
Date: Mon, 29 Jan 2024 22:04:47 +0100
Message-ID: <20240129210453.31070-2-heinrich.schuchardt@canonical.com>
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

Handles are u16 numbers. Consistently use '0x%04x' to print them.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/smbios.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index feebf930b79..67f3a9f5f19 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -95,9 +95,9 @@ static void smbios_print_type2(struct smbios_type2 *table)
 	smbios_print_str("Version", table, table->version);
 	smbios_print_str("Serial Number", table, table->serial_number);
 	smbios_print_str("Asset Tag", table, table->asset_tag_number);
-	printf("\tFeature Flags: 0x%2x\n", table->feature_flags);
+	printf("\tFeature Flags: 0x%04x\n", table->feature_flags);
 	smbios_print_str("Chassis Location", table, table->chassis_location);
-	printf("\tChassis Handle: 0x%2x\n", table->chassis_handle);
+	printf("\tChassis Handle: 0x%04x\n", table->chassis_handle);
 	smbios_print_str("Board Type", table, table->board_type);
 	printf("\tContained Object Handles: ");
 	handle = (void *)table->eos;
-- 
2.43.0

