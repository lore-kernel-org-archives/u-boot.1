Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27470C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 00:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C4687758;
	Fri,  1 Dec 2023 01:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130B887758; Fri,  1 Dec 2023 01:55:28 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 1D35C87719
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 01:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 44E4D20B74C1;
 Thu, 30 Nov 2023 16:55:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44E4D20B74C1
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: Sean Edmond <seanedmond@microsoft.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 5/5] fdt: Fix compile error for !OFNODE_MULTI_TREE
Date: Thu, 30 Nov 2023 16:54:44 -0800
Message-ID: <20231201005507.2080396-6-seanedmond@microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201005507.2080396-1-seanedmond@microsoft.com>
References: <20231201005507.2080396-1-seanedmond@microsoft.com>
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

Required to fix the following compile error when building sandbox:
/tmp/cci9ibby.ltrans21.ltrans.o: In function `do_cedit_load':
<artificial>:(.text+0x601d): undefined reference to `oftree_dispose'

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v3)

Changes in v3:
- fix compile error for sandbox for !OFNODE_MULTI_TREE

 drivers/core/ofnode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 557a4a1b969..f4af184a476 100644
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

