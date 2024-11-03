Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9A1D11194
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70DD88F12;
	Sun,  3 Nov 2024 23:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tnc3KtNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8184788F3C; Sun,  3 Nov 2024 23:45:11 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0C7688EE1
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-238.46.114.pool.telefonica.de
 [46.114.105.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C9251408DD; 
 Sun,  3 Nov 2024 22:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730673909;
 bh=x8RtmXF7o3PkzGrYjGU/jIMgwtHwePXzuVi3Ule6ksk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=tnc3KtNrHVouHZc5TgF2T8dq7f9Qnl8jOLx0hPGrjOrEM5TnVNyUyuuEpc/LGpZss
 ZDsY8TRJqQBr3PNT/gXINNGb8/mkByAjCJ17A2etGuTsHm/I4r45zaaLSzIu6SaVQg
 M+Ofdq6hjq59tY1PCB7m5uIdis9+nmIvUdoa6ezIlYJ6qx31aP7CN++qYkftie/gjR
 A2USM9GzIQ28oXZBxburrYSUZa9G7a8Nj/q/2G0Mg2g6rFqnvFgZcdbIAOiOwVHxCR
 oZLh8VRVFuBlvXW6WFNwE79qaP7fQVzlwFAgZbbT4qrMSroNA5SdnR+9fvauk/jRTy
 fGiFnoWoJ4Stg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: mkeficapsule: use %zd to print ssize_t.
Date: Sun,  3 Nov 2024 23:45:05 +0100
Message-ID: <20241103224505.195451-1-heinrich.schuchardt@canonical.com>
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

For printing a ssize_t variable we must use %zd and not %ld to avoid
a -Wformat error on 32-bit systems.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/mkeficapsule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 49f5b7849e4..fb6c57f77c1 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -866,12 +866,12 @@ static struct fdt_header *load_dtb(const char *path)
 
 	dtb = malloc(dtb_size);
 	if (!dtb) {
-		fprintf(stderr, "Can't allocated %ld\n", dtb_size);
+		fprintf(stderr, "Can't allocated %zd\n", dtb_size);
 		return NULL;
 	}
 
 	if (fread(dtb, dtb_size, 1, f) != 1) {
-		fprintf(stderr, "Can't read %ld bytes from %s\n",
+		fprintf(stderr, "Can't read %zd bytes from %s\n",
 			dtb_size, path);
 		free(dtb);
 		return NULL;
-- 
2.45.2

