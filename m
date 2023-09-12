Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE5BEE3F37
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 21:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1983886F5C;
	Tue, 12 Sep 2023 23:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o2qLSiD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA56D86E13; Tue, 12 Sep 2023 23:35:11 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 03EE386E54
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 23:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 32EA0212BE40;
 Tue, 12 Sep 2023 14:35:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32EA0212BE40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694554506;
 bh=aSRcXQdFgktaZB1W8CvTY0rsgPdCmEEgDAks3SHoxcg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o2qLSiD2eVWS7nO7Cv+A1oZUbdjIUywIiNKZyTmFQpWA/qFcVoj/7eI1/3D2zToru
 hrDbXrjYOEJJVE+aBXS4Fbs5NMLutfGR+z2/ux1FUydoKoHPVFTqopyjNtxDA1ik9v
 njuim7jKgJQHBKfcuSG/nnYlYnBXosoui0K7DyU4=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH v3 5/5] fdt: Fix compile error for !OFNODE_MULTI_TREE
Date: Tue, 12 Sep 2023 14:35:04 -0700
Message-Id: <20230912213504.65513-6-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
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

From: Sean Edmond <seanedmond@microsoft.com>

Required to fix the following compile error when building sandbox:
/tmp/cci9ibby.ltrans21.ltrans.o: In function `do_cedit_load':
<artificial>:(.text+0x601d): undefined reference to `oftree_dispose'

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 drivers/core/ofnode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 4be21133b8..f7b3f41077 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -92,12 +92,6 @@ static oftree oftree_ensure(void *fdt)
 	return tree;
 }
 
-void oftree_dispose(oftree tree)
-{
-	if (of_live_active())
-		of_live_free(tree.np);
-}
-
 void *ofnode_lookup_fdt(ofnode node)
 {
 	if (gd->flags & GD_FLG_RELOC) {
@@ -195,6 +189,12 @@ static inline int oftree_find(const void *fdt)
 
 #endif /* OFNODE_MULTI_TREE */
 
+void oftree_dispose(oftree tree)
+{
+	if (of_live_active())
+		of_live_free(tree.np);
+}
+
 /**
  * ofnode_from_tree_offset() - get an ofnode from a tree offset (flat tree)
  *
-- 
2.40.0

