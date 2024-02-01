Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23B3C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 00:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E33879A2;
	Thu,  1 Feb 2024 01:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y5PNlaoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76FA87B84; Thu,  1 Feb 2024 01:20:41 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA3387B5F
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 01:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6CAAC419B1; 
 Thu,  1 Feb 2024 00:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706746836;
 bh=b7UzdLIqDaaVYpSy8Oc3iaCXijiUt95AvIYa2G2xzdc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Y5PNlaoP0Amri2jl6o9en69I4n1qtqnyt6D2BUDEUqoYyhMtTwKyrTuVrxTBxRn3z
 HSG09jFztq4cZ+fT4nqBQVuainITxcGHmY70J/qtucBMSVk6moV5PXippFxmUhrJrA
 Opj2HMEJmiSvuEPcjbvB1CSCLqk601PjyY/Z4MrQ+LcL7091L0ROl5Smt9aboFP0o9
 6+ZIbP/J/F/ZkAOv/R36XQ3u2QbQ7BJxBTALc26ldAUqBY/zLQAuZez34zSuiNgoeC
 aU+72vCtLjP8DjsKACO4xdNu6yuq/bz38dWKHTeqFKwkYLQVYABOQFdS6jRfOrKHlI
 AORc972MwwVTg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] smbios: do not determine maximum structure size
Date: Thu,  1 Feb 2024 01:20:21 +0100
Message-ID: <20240201002022.11258-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201002022.11258-1-heinrich.schuchardt@canonical.com>
References: <20240201002022.11258-1-heinrich.schuchardt@canonical.com>
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

Only the SMBIOS 2.1 entry point has a field for the maximum structure size.
As we have switched to an SMBIOS 3 entry point remove the superfluous
calculation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/smbios.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index cd750cc218..327f78c8b0 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -566,7 +566,6 @@ ulong write_smbios_table(ulong addr)
 	struct smbios_ctx ctx;
 	ulong tables;
 	int len = 0;
-	int max_struct_size = 0;
 	int handle = 0;
 	int i;
 
@@ -588,7 +587,6 @@ ulong write_smbios_table(ulong addr)
 	/* populate minimum required tables */
 	for (i = 0; i < ARRAY_SIZE(smbios_write_funcs); i++) {
 		const struct smbios_write_method *method;
-		int tmp;
 
 		method = &smbios_write_funcs[i];
 		ctx.subnode_name = NULL;
@@ -598,10 +596,7 @@ ulong write_smbios_table(ulong addr)
 				ctx.node = ofnode_find_subnode(parent_node,
 							       method->subnode_name);
 		}
-		tmp = method->write((ulong *)&addr, handle++, &ctx);
-
-		max_struct_size = max(max_struct_size, tmp);
-		len += tmp;
+		len += method->write((ulong *)&addr, handle++, &ctx);
 	}
 
 	/*
-- 
2.43.0

