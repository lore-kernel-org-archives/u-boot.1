Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A0CCD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9413988064;
	Tue, 26 Mar 2024 23:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CzMn4rEZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="x2ZAjrXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD82388058; Tue, 26 Mar 2024 23:15:04 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE2780EED
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V43yG4xGvz9sbv;
 Tue, 26 Mar 2024 23:15:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFjjiadGAQ1/tgcSkMkCFfMJY33Q5XrOhVgxgGoGmZI=;
 b=CzMn4rEZQzvQQYAx8M7RDpu22yxD5J7VEws+RQCjlTmir2ee/etq1w5H/JttEdzanlFdyx
 A04Y0+/Rs5Ftzr1dc/gx20QF4OLiiqdNIrDRnuwaQsQMaatpQBmy/+Jq6gq0dbE5Iucgek
 KWxC/PQANdh12aF3Yqy2v+ZVe2ClRL5PdvamfbNXR2ovWNVkKer+Xt83407tdy/SQABs+n
 v0bPc72ZgUDEuoQsNgT/jZR/xToedjdGzpMaVLye2CZoaxtqLaxcXxQdyE0b+rpUlaAMYx
 h1sY7jSicqt6zHjzoQCMDJUv+P43SbIrUguvXg/UQrDcLrU4aGty/P7rDY4Xzw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFjjiadGAQ1/tgcSkMkCFfMJY33Q5XrOhVgxgGoGmZI=;
 b=x2ZAjrXG2itA6+brbgfE8Tx+72PnyHDv7eyGlnkuPZQJDolKSURFUNFcJMbNf1NODIinVk
 7Qd7Ke0SOljlrndfoFGjkCGMx9UaDQiXPaA3HyI1jPMSUW1mXSbkJ5WVg+k96iie0ntGxt
 yATRnCuZryAD11vNpce2rGj8V4GQocsg2wZSjKf6Exxn4CDCM/W+6fGKen3ODknVVrvNEv
 ZhhEMTOFUPneUtHbsGtKgLxl5PqSyp+7LKHrQfEyysvTSNk02nZgEU2/um+t/ayItIIxjS
 0SMutMMWu6QcAcAdRe7PUC9RY7plWsK/xSd/Cbm+JlKUc0fbUcRJyHgiZENf7Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 3/6] boot: fdt: Fix tmp type in env_get_bootm_size() and
 rename to low
Date: Tue, 26 Mar 2024 23:13:13 +0100
Message-ID: <20240326221431.55346-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
References: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e19c20a98beb1cc8b1a
X-MBO-RS-META: nztmeah5pkd559xhoszkt7ku6e9kte4f
X-Rspamd-Queue-Id: 4V43yG4xGvz9sbv
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

Change type of 'tmp' variable from phys_size_t to phys_addr_t and
rename it to 'low' to better describe what the variable represents,
which is either the bootm_low address from environment or start of
DRAM address.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V4: New patch
---
 boot/image-board.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index e3d63745299..13876b79026 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -125,8 +125,8 @@ phys_addr_t env_get_bootm_low(void)
 
 phys_size_t env_get_bootm_size(void)
 {
-	phys_size_t tmp, size;
-	phys_addr_t start;
+	phys_addr_t start, low;
+	phys_size_t size;
 	char *s = env_get("bootm_size");
 
 	if (s)
@@ -140,11 +140,11 @@ phys_size_t env_get_bootm_size(void)
 
 	s = env_get("bootm_low");
 	if (s)
-		tmp = simple_strtoull(s, NULL, 16);
+		low = simple_strtoull(s, NULL, 16);
 	else
-		tmp = start;
+		low = start;
 
-	return size - (tmp - start);
+	return size - (low - start);
 }
 
 phys_size_t env_get_bootm_mapsize(void)
-- 
2.43.0

