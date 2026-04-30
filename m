Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E3BFF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FAE7803C6;
	Fri,  1 May 2026 00:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="gY7WlJsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4EA80F0E; Thu, 30 Apr 2026 22:16:05 +0200 (CEST)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD1F803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 22:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.stelmach@samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260430201557euoutp0116d276aec7bdb479eef87bad047106d1~rO7wcaL861021310213euoutp01J
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 20:15:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260430201557euoutp0116d276aec7bdb479eef87bad047106d1~rO7wcaL861021310213euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1777580157;
 bh=0TiLTJl5VB7HDVP70zHSlpGOs61To0k0dW2SJ50GU30=;
 h=From:To:Cc:Subject:Date:References:From;
 b=gY7WlJsj+BHzcR26ZakF8diD+vZRcfo1ICW+TDV/taweWVFgFMl+zGkMPWvD0a69W
 dpVJB7WFVGgKC9NGJj/2AS5RSKtWy0i+vpDEgqhYHqRggrxbNsKNALxRNDQAEfdSSf
 7Xx8G5opiC0lPXu1+vqs2cNVVz1BcGbCqhl9qnBE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260430201556eucas1p21ad12913ce5c83e8bf5cef3c4f50d81b~rO7wCOCV71435814358eucas1p2e;
 Thu, 30 Apr 2026 20:15:56 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20260430201556eusmtip1f8f39edb0d6794800177afe0ddd2a51c~rO7v_yfv31351913519eusmtip1E;
 Thu, 30 Apr 2026 20:15:56 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: u-boot@lists.denx.de
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] fastboot: read fastboot buffer address from fastboot_addr_r
Date: Thu, 30 Apr 2026 22:14:52 +0200
Message-ID: <20260430201503.320359-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260430201556eucas1p21ad12913ce5c83e8bf5cef3c4f50d81b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260430201556eucas1p21ad12913ce5c83e8bf5cef3c4f50d81b
X-EPHeader: CA
X-CMS-RootMailID: 20260430201556eucas1p21ad12913ce5c83e8bf5cef3c4f50d81b
References: <CGME20260430201556eucas1p21ad12913ce5c83e8bf5cef3c4f50d81b@eucas1p2.samsung.com>
X-Mailman-Approved-At: Fri, 01 May 2026 00:55:30 +0200
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

Following the previous advice (link below) check fastbooot_addr_r
environment variable for fastboot buffer address.

Link: https://lore.kernel.org/u-boot/aWiWFrdwvy7-IK63@sumit-xelite/
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/fastboot/fb_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 68f92c4b887..4579f30b52e 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -226,7 +226,9 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg))
  */
 void fastboot_init(void *buf_addr, u32 buf_size)
 {
-	fastboot_buf_addr = buf_addr ? buf_addr :
+	void *_buf_addr = (void *)env_get_hex("fastboot_addr_r", 0);
+
+	fastboot_buf_addr = buf_addr ? buf_addr : _buf_addr ? _buf_addr :
 				       (void *)CONFIG_FASTBOOT_BUF_ADDR;
 	fastboot_buf_size = buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
 	fastboot_set_progress_callback(NULL);
-- 
2.47.3

