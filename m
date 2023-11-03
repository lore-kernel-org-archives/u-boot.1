Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C8DC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 18:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B003B87454;
	Fri,  3 Nov 2023 19:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PFJTi+lK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD888704B; Fri,  3 Nov 2023 19:38:57 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 4B885871E7
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 19:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id AA78320B74C5;
 Fri,  3 Nov 2023 11:38:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA78320B74C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1699036730;
 bh=SjgJcO0mR7ha6c8yz86PMwI278GqEvzR5Lxcb8svxIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PFJTi+lK9tBOZY+7Va4c6sQ+XO/U3+x9JNLhvChKZOM0XbT7eHjkflUgMoGV1DQdo
 8VaNcpSSgZBOiVHMXJh0f0Yz6MK4Vy/l5ORiKmyr1ViWmdCTLVxavCF3YjxLEeHnsq
 8vWmpwz/c3n/9kL7BpEG9MqFKI23KqTGiDQaCuCg=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com
Subject: [PATCH v4 5/5] fdt: Fix compile error for !OFNODE_MULTI_TREE
Date: Fri,  3 Nov 2023 11:38:44 -0700
Message-ID: <20231103183844.2308934-6-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
References: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
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
index 55291f0202b..c3d326831fc 100644
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

