Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF476C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 01:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D6A86AFE;
	Sat, 26 Aug 2023 03:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BCoSvQps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84ED9869CA; Sat, 26 Aug 2023 03:53:01 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1530F86A77
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 03:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 853CB3F6CC; 
 Sat, 26 Aug 2023 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693014778;
 bh=3A+aGkG7tMCb2LIqvPaJh4p+b3OKL3nVvK2UKvCJ0ik=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=BCoSvQps58GUocQLxFP1SnsrbO8stmg6knAAFJHfDOByiov9jzLR0cG1lvidRU+SN
 SgoiM5hC55XnINvj6srysnj5XJhSqWy0hJk6CnIPD6OU1XtBUHF+/oFfLbXaSG/D1p
 joGljCVnL7pBpYHGZTJ6hTOpPVdCFttdDpq2jmAd9dp2w34fi32gsWaRfqtH9nvSOO
 Od6MsziRnPDwsG2ladPh7DiMTe8mR2jgJJ3S7ODzPq5R11dysrpsEkgl3sAcL5hLYE
 ufLhCMO72wIfQGDclEfKO7m8hM3klhU4ig5A0YpdNUtFkI8wRUl9YqRGU3DggmsGTs
 hPk/mVeXGN+fw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Joshua Watt <jpewhacker@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] cmd: fix gpt setenv
Date: Sat, 26 Aug 2023 03:53:41 +0200
Message-Id: <20230826015343.167612-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
References: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
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

Do not assume that partitions are continuously numbered starting at 1.

Having a partition table with a single partition 63 is valid.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/gpt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 007a68eaa7..d0e165d539 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -786,10 +786,8 @@ static int gpt_setenv(struct blk_desc *desc, const char *name)
 
 		for (i = 1; i < part_drv->max_entries; i++) {
 			ret = part_drv->get_info(desc, i, &pinfo);
-			if (ret) {
-				/* no more entries in table */
-				break;
-			}
+			if (ret)
+				continue;
 
 			if (!strcmp(name, (const char *)pinfo.name)) {
 				/* match found, setup environment variables */
-- 
2.40.1

