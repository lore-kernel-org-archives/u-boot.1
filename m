Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EF4C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 10:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A4F288820;
	Wed,  3 Jul 2024 12:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="lTXp5b7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA34B8880F; Wed,  3 Jul 2024 12:13:11 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54BB888813
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 12:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D185A148A8F8; Wed,  3 Jul 2024 12:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1720001585; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=mLaLMBKU2BFDoYaDOFJjhasXvHMsSqofwnfyvcYHzHk=;
 b=lTXp5b7AdQcUKw2xyyhUxGFHhdfoOg2UrmRlx0uDh26VwXXAXTfDh3PQIs8yjI5FJqNg/Q
 4X17DPcK1PnwxcfKprfU/hbbkZUghDLmWSd+2tMS4hC53QLxK17nqROfUEirje1Dg+bOqG
 6QIEQyS2pEk2JNaGfRW0k9m05D448wJCNu42U5b+c8YNTuMA0MXsKjNeQTxGrXVuO6HNub
 EI+b2TEmawuy4xf8Qev07ozIHDAE8qrFzV5pN7l+RVh3dqfT5YPaTgNRXa066DsYn23SjZ
 7FzCyMB0Dr3JnO97fSBQj7UzKLVukgjFaajNXKWU9TlaD/l+DNdrd95CT2oUjw==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Heiko Schocher <hs@denx.de>,
 Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] fs: ubifs: Make k(z)alloc/kfree symmetric
Date: Wed,  3 Jul 2024 12:12:57 +0200
Message-Id: <20240703101258.1670825-4-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703101258.1670825-1-ada@thorsis.com>
References: <20240703101258.1670825-1-ada@thorsis.com>
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

Although kfree() is in fact only a slim wrapper to free() in U-Boot, use
kfree() here, because those structs where allocated with kalloc() or
kzalloc().

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 fs/ubifs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 321c9b9351e..e2d988790a3 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1762,8 +1762,8 @@ void ubifs_umount(struct ubifs_info *c)
 	mutex_unlock(&c->umount_mutex);
 	/* Finally free U-Boot's global copy of superblock */
 	if (ubifs_sb != NULL) {
-		free(ubifs_sb->s_fs_info);
-		free(ubifs_sb);
+		kfree(ubifs_sb->s_fs_info);
+		kfree(ubifs_sb);
 		ubifs_sb = NULL;
 	}
 #endif
-- 
2.39.2

