Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC88CC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5363A87D6B;
	Mon, 29 Jan 2024 22:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZH99Xxoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59FA87CD9; Mon, 29 Jan 2024 22:05:08 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15CBA87B1D
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8798A3F8C9; 
 Mon, 29 Jan 2024 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706562298;
 bh=gy7hFfR+dfMBZASJQgajacoIDAlD0l+nF3GkVkOnv2A=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZH99Xxoil6+Xmt/W3GkPsuV0JfXwAGdDTlsGCx7tA6IOuW+zCJjuuNsOLT6dQ/ZQU
 DRrSVpJneb6JUH2PfEzfpIJqeGuTdNQUEvKkPQyTIlGgFmBB4Dgy5bU2OoXbYUetnG
 APrybTVUXpLcKmHF3arlkOSKQSNeFPQgZV5YQcC77mPUHgXAuqS0Hcl9lfadOrD+6h
 WjJW+nK89YPYpZNLaKfKpA7KLcm72P73WwiXDkLHzS1orkdgX6yh1M9KwhUe4IltS0
 QM/TyYXpfkosFuPEZddxtJe9MSMrYaxbffh9t/9IgboA+oDRBbxoabRbGxy3CoTsZ1
 fXmpefLPB+i6g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/7] cmd: smbios: replace missing string by 'Not Specified'
Date: Mon, 29 Jan 2024 22:04:49 +0100
Message-ID: <20240129210453.31070-4-heinrich.schuchardt@canonical.com>
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

A missing string value is indicated by a string index of 0. In this case
print 'Not Specified' like the Linux dmidecode command does.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/smbios.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 62935ecd1a2..95bdff60268 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -25,6 +25,10 @@ static const char *smbios_get_string(void *table, int index)
 {
 	const char *str = (char *)table +
 			  ((struct smbios_header *)table)->length;
+	static const char fallback[] = "Not Specified";
+
+	if (!index)
+		return fallback;
 
 	if (!*str)
 		++str;
@@ -41,7 +45,7 @@ static struct smbios_header *next_table(struct smbios_header *table)
 	if (table->type == SMBIOS_END_OF_TABLE)
 		return NULL;
 
-	str = smbios_get_string(table, 0);
+	str = smbios_get_string(table, -1);
 	return (struct smbios_header *)(++str);
 }
 
-- 
2.43.0

