Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818F5C369CF
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 11:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1919C82075;
	Sun, 20 Apr 2025 13:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="gcEVTVWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F2082076; Sun, 20 Apr 2025 13:58:21 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D6B820E2
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 13:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: d0d8a6b8-1dde-11f0-a9b6-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d0d8a6b8-1dde-11f0-a9b6-00505699b430;
 Sun, 20 Apr 2025 13:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=VlxtYeiZs4Y+CgUzXFtyzQHGIgMSSDTwCaSZhahfufg=;
 b=gcEVTVWb/vhYxQly/DlHrpribLhUtgRlfhnnx8QVfuC7ZUXMjBjxODTFUtRRa27uhAV8a9hDkE0kJ
 /HjWQRw7J91WMwCdr+TT2GNFUd6CkBMwwNFHaTjVeTdjbLvoz0dCNe8Kmqf9WUA6D0fM0M8rcciLIB
 goc9GaFBvCQyD+J0=
X-KPN-MID: 33|luDIc/ohpJt46EoKtdlxuA6RefOD8v3cnYQxTBAux4D5uZ//n4/t+lugwqODglF
 o6tOGilhvlLKjYr8EmamE2A==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|GI5dz7nlXEH8kfF1hQl5om8AKD6jHQd9QirBWOxp/3VArdcUG0d80LCKXMQmmvJ
 +SK/yvdQOiTN2YfoF/onMhw==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id c021082f-1dde-11f0-97e2-00505699d6e5;
 Sun, 20 Apr 2025 13:58:19 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: kettenis@openbsd.org,
	trini@konsulko.com,
	marcan@marcan.st
Subject: [PATCH 2/6] arm: apple: rtkit: Add default buffer handlers
Date: Sun, 20 Apr 2025 13:58:04 +0200
Message-ID: <20250420115808.94272-3-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250420115808.94272-1-kettenis@openbsd.org>
References: <20250420115808.94272-1-kettenis@openbsd.org>
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

From: Hector Martin <marcan@marcan.st>

For devices without specific buffer methods, just assume we can give
them raw memory pointers when they request a buffer.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/mach-apple/rtkit.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/rtkit.c
index 433ffb259ee..5e8e282ec0e 100644
--- a/arch/arm/mach-apple/rtkit.c
+++ b/arch/arm/mach-apple/rtkit.c
@@ -11,6 +11,7 @@
 #include <linux/apple-mailbox.h>
 #include <linux/bitfield.h>
 #include <linux/errno.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 
 #define APPLE_RTKIT_EP_MGMT 0
@@ -97,6 +98,13 @@ void apple_rtkit_free(struct apple_rtkit *rtk)
 			rtk->shmem_destroy(rtk->cookie, &rtk->crashlog_buffer);
 		if (rtk->ioreport_buffer.buffer)
 			rtk->shmem_destroy(rtk->cookie, &rtk->ioreport_buffer);
+	} else {
+		if (rtk->syslog_buffer.buffer)
+			free(rtk->syslog_buffer.buffer);
+		if (rtk->crashlog_buffer.buffer)
+			free(rtk->crashlog_buffer.buffer);
+		if (rtk->ioreport_buffer.buffer)
+			free(rtk->ioreport_buffer.buffer);
 	}
 	free(rtk);
 }
@@ -131,7 +139,7 @@ static int rtkit_handle_buf_req(struct apple_rtkit *rtk, int endpoint, struct ap
 
 	buf->dva = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg->msg0);
 	buf->size = num_4kpages << 12;
-	buf->is_mapped = false;
+	buf->is_mapped = !!buf->dva;
 
 	if (rtk->shmem_setup) {
 		ret = rtk->shmem_setup(rtk->cookie, buf);
@@ -140,6 +148,12 @@ static int rtkit_handle_buf_req(struct apple_rtkit *rtk, int endpoint, struct ap
 			       endpoint);
 			return ret;
 		}
+	} else if (!buf->is_mapped){
+		buf->buffer = memalign(SZ_16K, ALIGN(buf->size, SZ_16K));
+		if (!buf->buffer)
+			return -ENOMEM;
+
+		buf->dva = (u64)buf->buffer;
 	}
 
 	if (!buf->is_mapped) {
-- 
2.49.0

