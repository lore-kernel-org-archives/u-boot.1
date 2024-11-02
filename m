Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABB2E677EE
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 06:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F08988EC6;
	Sat,  2 Nov 2024 07:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pQeQRBi2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8418F88F50; Sat,  2 Nov 2024 07:41:32 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC0E88A4C
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 07:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D076A3F18F; 
 Sat,  2 Nov 2024 06:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730529690;
 bh=BOyWjVTadbx/Y/xk1hontvCIQhtP7Pbb72KScbmSkW0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=pQeQRBi2MVDShSIckoc0map+Io6RqLY67E7weZDrNuWVslQZmdfVyIpAYvIcRGO5Y
 ILzf5tDql/e9MgX/l+lPCsnWJ+XcUNP/MD1TrhTmlPj/eTCUkRjgNu7M2FyNNIDVl8
 bJFmXDTV25cHrTS65fPa4vvcsAvnh0TXNvyfeb6u37UnNZHjByKEfC0IJUSQc6wIjM
 HUa3QQNQ+1pWD5RtFGflAu7htEzg5Vz1S2ROuuxm6+04dZYZpjWN7zOnzM48d9CJbz
 jUpT8Gvzgqn9DOpebj0oo8q0eEXWrEOa88IiCJtbBlUr1xHmWhV0oOzPFi630Gz/xN
 2KK4PDL0QVQyQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lmb.c: add missing comma in lmb_dump_region()
Date: Sat,  2 Nov 2024 07:41:27 +0100
Message-ID: <20241102064127.41571-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

In the message string " %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: "
a comma is missing before flags.

To avoid increasing the code size replace '0x%' by '%#'.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/lmb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 00c8888936a..95adf2e93a4 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -97,7 +97,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 	enum lmb_flags flags;
 	int i;
 
-	printf(" %s.count = 0x%x\n", name, lmb_rgn_lst->count);
+	printf(" %s.count = %#x\n", name, lmb_rgn_lst->count);
 
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		base = rgn[i].base;
@@ -105,7 +105,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 		end = base + size - 1;
 		flags = rgn[i].flags;
 
-		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
+		printf(" %s[%d]\t[%#llx-%#llx], %#08llx bytes, flags: ",
 		       name, i, base, end, size);
 		lmb_print_region_flags(flags);
 	}
-- 
2.45.2

