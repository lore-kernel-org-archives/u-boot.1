Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E708CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 21:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B96B881B0;
	Wed, 10 Apr 2024 23:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JrIuN1Az";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08F3881C2; Wed, 10 Apr 2024 23:50:57 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E7287861
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 23:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3DC783FE50; 
 Wed, 10 Apr 2024 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712785855;
 bh=ocjr1OMRtHrBdpTYIsbtncfTCeJ5MzSn63gmj1dDybo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JrIuN1AzfRMRhoaiPs/NYPsNnKKdzgoKhj0ejbWXCCINK8nptQBr/2TEMUiF3BTSC
 qQo3R4Ef7gy/QUxFyjLhIa14DzNUF/ps4b9sbBRPb99GIZ5N4JqVF7g6MX4jp6DyPC
 ZY1xEYn5VQO7sYRejrr8enpAmZ287Rh5FPZASmShC5EjOOLPBNiXCMPhi9LdQZQlMu
 JfHYDkglNwLUzoTU+wajrc+VmD3DZr73VLabAj2Z7t9UaWSsuzHQRxVdaxWCzmdy62
 VGh2+mO/E7iY60B9qYFFUQoNQy+qfPSA4dd4BNvNEEZeYMoU8KdZdrnzLPmEnhh+9Q
 uvinFlLFCJ8tg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: don't call os_close with invalid file descriptor
Date: Wed, 10 Apr 2024 23:50:34 +0200
Message-ID: <20240410215034.18806-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

If open() fails it returns -1. Calling close() with this value
makes no sense. Return -EIO instead.

Addresses-Coverity-ID: 185828 Improper use of negative value
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/cpu/os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index cbae5109e85..154a5d77490 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -188,7 +188,7 @@ int os_read_file(const char *fname, void **bufp, int *sizep)
 	fd = os_open(fname, OS_O_RDONLY);
 	if (fd < 0) {
 		printf("Cannot open file '%s'\n", fname);
-		goto err;
+		return -EIO;
 	}
 	size = os_filesize(fd);
 	if (size < 0) {
-- 
2.43.0

