Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72157C71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0E98689A;
	Sun,  3 Sep 2023 22:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="R03TtX+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E548186420; Sun,  3 Sep 2023 22:40:09 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD8C868D3
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 027a1d3f-4a9a-11ee-a2b6-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 027a1d3f-4a9a-11ee-a2b6-005056992ed3;
 Sun, 03 Sep 2023 22:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=7sflJ0cuVAsXw8dSuZas7oReAawKzrD9Rfei0OsDo1U=;
 b=R03TtX+4QAduAN76/OoSl+jHKICFdaiZFIIVt3PJF9BU+DsUqXHjl1Zcz7defmLn5e523fygyPTI0
 az9PfraPZkrxtVYPjYGl7we+/N51QGDqrnpPMW0Za9M/lO9RHWnSvP4XwaJ3q1B6t9LlqAGj8IfCdh
 kj95nyqm5kTUIE7g=
X-KPN-MID: 33|vLOqrTKZGgF/wSf69ftLSdu2RV57gw/Ac39jxiLmEgelAEWhcKjkC7qRnZHdDGd
 +CBBmgTjaO46sMDkSIdekHj0912YYw0A9FNWdZUeDa/o=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|I3ScgXRYXe8bk87U9ZzH0GjKiorIhuqoVXzodwE0S/VcsKlf0Zv05UNm0gmQ8oB
 WnV5ll7x/SFKR8Qdl2i2yzw==
X-Originating-IP: 80.61.163.207
Received: from copland.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 10aded98-4a9a-11ee-875e-00505699d6e5;
 Sun, 03 Sep 2023 22:40:06 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, sjg@chromium.org, Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2] bootstd: Make efi_mgr bootmeth work for non-sandbox setups
Date: Sun,  3 Sep 2023 22:40:00 +0200
Message-ID: <20230903204000.96999-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.42.0
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

Enable the bootflow based on this bootmeth if the BootOrder EFI
variable is set.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---

ChangeLog:

v2: - Initialize EFI subsystem to populate EFI variables


 boot/bootmeth_efi_mgr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index e9d973429f..e6c42d41fb 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -14,6 +14,8 @@
 #include <bootmeth.h>
 #include <command.h>
 #include <dm.h>
+#include <efi_loader.h>
+#include <efi_variable.h>
 
 /**
  * struct efi_mgr_priv - private info for the efi-mgr driver
@@ -46,13 +48,26 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
 static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	struct efi_mgr_priv *priv = dev_get_priv(dev);
+	efi_status_t ret;
+	efi_uintn_t size;
+	u16 *bootorder;
 
 	if (priv->fake_dev) {
 		bflow->state = BOOTFLOWST_READY;
 		return 0;
 	}
 
-	/* To be implemented */
+	ret = efi_init_obj_list();
+	if (ret)
+		return log_msg_ret("init", ret);
+
+	/* Enable this method if the "BootOrder" UEFI exists. */
+	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
+				&size);
+	if (bootorder) {
+		bflow->state = BOOTFLOWST_READY;
+		return 0;
+	}
 
 	return -EINVAL;
 }
-- 
2.42.0

