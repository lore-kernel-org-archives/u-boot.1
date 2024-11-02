Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C2EE677F8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 10:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A4188FC4;
	Sat,  2 Nov 2024 11:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="H1nQseJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9014B88FD6; Sat,  2 Nov 2024 11:27:41 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B05A4889D2
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 11:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 300FE3FDAB; 
 Sat,  2 Nov 2024 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730543259;
 bh=Kt6FB8pHBieAcQuw1xJWnwDwi3klQSlPG2WZSXC2TWI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=H1nQseJKDmtQHNK6V3kDpyVnT88dsD58xmEr0K1CCkTmuvpmiH8N8sOe4g3YqYID2
 +cUD3WFGPXq2E2UsyLqJYB4+99RkP33Yv/PKp73Mcz8wFgYaHZEWpx3LziVoynVlN1
 AjgUgSyTeq7GSp7OIUUGz3RNdBsNEdSrdnLpjeVTlTiXkQUbZHGOz+OvhzyuLVl36d
 N/4tPAKzsgpbaBxEcF4oz9rygeZEuBZq3TCBfJpbLqg77hwdH60OY+LQHLecqdGlOK
 gxGc9A+BpHNTPWC6XZ8IjZdeC/0R2rjXXqhiSMHnrX6uoyav4V0Yd0188Zn7pp43sB
 8fkYRs7bxPOnA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tpm: use memmove() for overlapping buffers
Date: Sat,  2 Nov 2024 11:27:37 +0100
Message-ID: <20241102102737.107531-1-heinrich.schuchardt@canonical.com>
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

The behavior of memcpy() for overlapping buffers is undefined.

Fixes: 4c57ec76b725 ("tpm: Implement state command for Cr50")
Addresses-Coverity-ID: 356664 Overlapping buffer in memory copy
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/tpm-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 59e6cbafafa..ad2b5ab0c32 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -821,7 +821,7 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
 	if (*recv_size < 12)
 		return -ENODATA;
 	*recv_size -= 12;
-	memcpy(recvbuf, recvbuf + 12, *recv_size);
+	memmove(recvbuf, recvbuf + 12, *recv_size);
 
 	return 0;
 }
-- 
2.45.2

