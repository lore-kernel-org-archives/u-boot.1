Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B025DC369AE
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 08:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEDF829E7;
	Sun, 13 Apr 2025 10:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744534699;
	bh=rWYCR6BLVNc1Gi8KgH7A6jqDAhtNPMECDEG38KPBEKQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HsFAceraS/cN8CxLtT9VnK3gjeAFpPojEeS9yG4wrIUrySs5/dINBAihEXIh9ns89
	 PEF7cbfWCYNekKtIXUW9ZMkvce2jP7MIbUaJnnzdaeFMeVw5K23Y3+orXNr+ZRUlBl
	 QRlbg7ugZk5l9h37LAvIEyJOyn1VwrwwT6MCisH1kO0+ePur4FCQmpBqBHLFE8PXBZ
	 yVU/qmGZoXpQ/6OY3/frSYP3Id36HMiBOGstXjkzKvcS4uz0QNuWBfvEQ/oA7EYtOI
	 0h1cpyBwSwxpRgKO7C+R1Kvsc7yoFcLI+49WjgNY0+nQ5O74VQtpCT5vBbvI/KugVk
	 sQU6c/NHfp8pg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 546BF829A1; Sun, 13 Apr 2025 10:58:18 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4717082917
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 10:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="INrhgbII"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 512A110271405; 
 Sun, 13 Apr 2025 10:58:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744534694; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=rWYCR6BLVNc1Gi8KgH7A6jqDAhtNPMECDEG38KPBEKQ=;
 b=INrhgbIIRJM9uf0yFSre4nb1mYmyXgxY9lVrFmOcP9Hdhto7PHiBJZkLL6Th8dyUqSdBEp
 lqGOOgneMryweSlRSWkfNue7kSWHTrtEgLJDt0dEgdiRP8qQL7vGJaDL632uDpKtwC6PDF
 rDV9UNu3OI9cMRBH+Ntr8yG740XCkZvsONUcS1KJJVpHVdyg6F5MaE4urd4dFCI6eI7SsD
 35BdAU0nrn6vZGOwnWMIAhqA05FdiZvc0JlgdN+jnpSv+9Mtd6ayPaPkjA1iIYtHr7tUOC
 Co76AsyAnHY5wmDfjKVtJO2hmP2Md8cZJhm+yBUa6TGjldl9wf52Nzf/3jzsgg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/7] fs: exfat: Flush node before put in read() callback
Date: Sun, 13 Apr 2025 10:54:59 +0200
Message-ID: <20250413085740.5953-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Make sure the node is never dirty before being released, flush
the node first using exfat_flush_node() and only then release
the node using exfat_put_node(). This now matches the behavior
of exfat_fs_write() too.

Fixes: b86a651b646c ("fs: exfat: Add U-Boot porting layer")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/exfat/io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/exfat/io.c b/fs/exfat/io.c
index 81e82829c72..12498a4a6ec 100644
--- a/fs/exfat/io.c
+++ b/fs/exfat/io.c
@@ -898,9 +898,7 @@ int exfat_fs_read(const char *filename, void *buf, loff_t offset, loff_t len,
 
 	*actread = sz;
 
-	exfat_put_node(&ctxt.ef, node);
-
-	return exfat_flush_node(&ctxt.ef, node);
+	err = exfat_flush_node(&ctxt.ef, node);
 exit:
 	exfat_put_node(&ctxt.ef, node);
 	return err;
-- 
2.47.2

