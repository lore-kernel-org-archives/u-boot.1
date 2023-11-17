Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B391BC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 02:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C79874E9;
	Fri, 17 Nov 2023 03:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OUUzeIQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA891874D6; Fri, 17 Nov 2023 03:02:19 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 699A5874AB
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 03:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2F6C820B74C5;
 Thu, 16 Nov 2023 18:02:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F6C820B74C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700186529;
 bh=ILwPB//605toebwnRlQsm68vMWfjdeW42A5045RcDsg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OUUzeIQpQwePG9vqfRu1E2oVrgJglFEEufzUZ1taXweCw/1OhNslcQu1SvPnUSoQa
 WGfdF7txY2a1h3kGA1Zef24cv/9Xd3682MaTVwItfGpMIFFZgiSk+uhrT1AT/F0v1W
 6+EDGfJAtoJMAE9hv80jfTap67J30ynnoa7t1oQc=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com, sjg@chromium.org
Subject: [PATCH v5 5/5] fdt: Fix compile error for !OFNODE_MULTI_TREE
Date: Thu, 16 Nov 2023 18:02:06 -0800
Message-ID: <20231117020207.948636-6-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
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
index 6ce468d9cac..ec25466a5e7 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -135,12 +135,6 @@ int oftree_new(oftree *treep)
 	return 0;
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
@@ -243,6 +237,12 @@ int oftree_new(oftree *treep)
 
 #endif /* OFNODE_MULTI_TREE */
 
+void oftree_dispose(oftree tree)
+{
+	if (of_live_active())
+		of_live_free(tree.np);
+}
+
 int oftree_to_fdt(oftree tree, struct abuf *buf)
 {
 	int ret;
-- 
2.42.0

