Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6D1C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C602C87D9E;
	Mon, 29 Jan 2024 22:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AWfjCmKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A149287D0A; Mon, 29 Jan 2024 22:05:10 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C2B87C68
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7A26D3F8CB; 
 Mon, 29 Jan 2024 21:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706562299;
 bh=t4+wAoQYzsOmo2LIvZgqxfV6IDdfOkiaKarm31XFeho=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=AWfjCmKL8P+vPD2YbGG1pavDcaLl9fYHLgCewEc6huFZ4a0dlVZclzDPrfurECIuK
 X+5U+r2CNzTSzlR3M0udloA+Wl9/1xUDT1Wt08uRVPgfr+UOa4ZKZQlZBGjK5cVQCR
 ah0QJmrsVX8kzEgO84tUk6Ika3wUPymX4sMdOs3oLXJ3QekyS5GFBSs6uEpk8UWCci
 m16G8jqZ/iV9FrTwGwaYuDaNCAZcCykS8UvcjEqWe8/1RzCs1yBcebNjZPNY7PKRXu
 EgK2SCKkw3VP8BrnjaO7njeltmLC+FwLhSv/bBf6O+QNtRlkk6EskyTRCsm3hWD72F
 z41apZuV9O94w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/7] smbios: string table always needs two terminating NUL
 bytes
Date: Mon, 29 Jan 2024 22:04:50 +0100
Message-ID: <20240129210453.31070-5-heinrich.schuchardt@canonical.com>
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

The string section of the different SMBIOS structures is always terminated
by two NUL bytes even if there is no string at all. This is described in
section 6.1.3 "Text string" of the SMBIOS 3.7.0 specification.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/smbios.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/smbios.c b/lib/smbios.c
index 7bd9805fec0..81908e89610 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -311,6 +311,9 @@ int smbios_update_version(const char *version)
  */
 static int smbios_string_table_len(const struct smbios_ctx *ctx)
 {
+	/* If the structure contains no string it is followed by to NUL bytes */
+	if (ctx->next_ptr == ctx->eos)
+		return 2;
 	/* Allow for the final \0 after all strings */
 	return (ctx->next_ptr + 1) - ctx->eos;
 }
-- 
2.43.0

