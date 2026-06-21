Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A879CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF6E84901;
	Sun, 21 Jun 2026 10:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XVNjpmGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA40849EA; Sun, 21 Jun 2026 10:19:25 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E045E849AE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4E37342083; 
 Sun, 21 Jun 2026 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029961;
 bh=k8p1A89nJKPvmLAikJ8h+a/GIDc2sGoQkyMwEqIeThM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=XVNjpmGqq8+pWU6LIJ2jf7MQbmzoNtb/uP+1rMg8njP752CmboPWH06bXeoLepvSP
 FcHvVCEylUVn01G5RbnSbU66E+Ox7CXwQwx/SnL4P7tFWqP1SA+H9cL0sAfK6+ZAzq
 nTrNAa4K4l/UEnprSu/Ck5fYYCbfH2wq7Kj1+t4LcSKp9PFis9O/r341ne7T9c5B1j
 foHdcIbFi9TkuB62yw+sv3Cf9x0tJrsPj2tRJWOKVbMVuu1JmjDyia/mhgSSlHOZKA
 L48P0ONubrz9AyU2P8mAfli/B+8oRQMW2hIcAhzVciheK+l182su1XWhgpdu9Xg5l/
 GA80XBT7Wl9Jfi2R3x0jrepvjHex483ckqjnJQDGnuKTqaIPo0W35O9Dpwh51mjYdp
 o4rw3IQ/fv8+t31yctFrDmkfBaxT9wxzASikXqLd/8GOdlyOF27KAjzagn2jIlZLc+
 9bnIoC+tZQzUj8NzJl7EXSNwWylaLXAA1OVkloHcdW8fGGpWWoMSMBEccLq0qbW8vX
 Zrk9s8AiWs13d8n8duK7M7bxpGvT2c7iYPu9Trfrwu59okX5C1RNk9tht11tRp7OTG
 13pX8cIxZDF8C43jiBYkzvW2PzRSUbXEZYFSHWYSTqGcLEW1CpNQk261XU76O3lbpm
 GdeBKzOKYcDLK+F02MQpFIjQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 03/11] efi_loader: smbiosdump: fix starts_with() returning
 NULL
Date: Sun, 21 Jun 2026 10:19:07 +0200
Message-ID: <20260621081915.19154-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
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

starts_with() is declared as returning bool, but the null-argument
guard returned NULL (a pointer cast to bool) instead of false.
While harmless on most platforms where NULL and false both have
value zero, it is technically incorrect.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/efi_loader/smbiosdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index d7f2ba30a95..974728a43af 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -199,7 +199,7 @@ static u16 *skip_whitespace(u16 *pos)
 static bool starts_with(u16 *string, u16 *keyword)
 {
 	if (!string || !keyword)
-		return NULL;
+		return false;
 
 	for (; *keyword; ++string, ++keyword) {
 		if (*string != *keyword)
-- 
2.53.0

