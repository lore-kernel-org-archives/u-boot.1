Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237A2EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 05:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8917285DFA;
	Wed,  6 Sep 2023 07:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gouc0XYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F5F8660B; Wed,  6 Sep 2023 07:23:05 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD7CF805C2
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 07:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d776e1f181bso2789027276.3
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 22:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693977781; x=1694582581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kwxPj+SWKDQIlkIYQLNZfwDWSc9ZgqOsSNFK82bNkaw=;
 b=Gouc0XYlsGEc/wrdiNzu69CN96xMBA/76y4I3M2ZIjqcruDloQYj4l5ojqAgvDU1Nz
 8svWLQxAQKr/XSSmOijtnM4IFAvATJ6JL3KNeUd2o2yibyVioh1jnFOEPejFpYEthjaC
 n+GHkWgg0gM13aNIs45EZ7oL00LMYHGoBhJbQreaf4rybozq48YtK174oahVv+1YX8df
 dH5ASjY3UcQElPx8xEtEUqG+Iylglzg99SZ9LvyTEIZ7EogN2K8tUqZ11GekWODCam69
 7Eal5Kuk/KX0cxW3CMuDwd6deG3WOPYdLL0NBprhMbik8IFbg8m2ZGqce+QmGeYrU3Qt
 c/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693977781; x=1694582581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kwxPj+SWKDQIlkIYQLNZfwDWSc9ZgqOsSNFK82bNkaw=;
 b=FjqT0//u1CjafvAb44boccwv8cTLE46kd1YDu6uaIhAPiQHBl7Mla3ePnvTs+d8Na5
 dMNAABBD6V1pd8S3J0qqigb3os6ut7yxG01Ueib2WRNnpGzhhao9YoF6SRVpblZm/PKx
 xt2b3tzdWcwpd8Mmtu4Eya+5gEz6BGjwrNO8QGpMJh3dV9Ho1xghFl9xmZuEke+JyslK
 ejZt/evRvFp83CEI+S+urX0YnwchrdOSzwXz2tHH8k1fBM/1Cz0iDON/2fSsgdDMSm9i
 ht1vnT5HuwsiCsQhV6bsqfCUo8PkzAzzfFD0FAH9C/NJ/s+dLrHhwFDoTCYczCzvlsCX
 5OqQ==
X-Gm-Message-State: AOJu0Yx5SrJ+/gpH2NVrHiIqj7jEWw1JhZjDuL551ziGooP9fajcQ0L+
 ueTbFxvmNVXJf/S5fxUWGJE=
X-Google-Smtp-Source: AGHT+IHSaIKdfxxYMOXbMzW8NEALgtUnI2dmF4XkSMElx/Kg1RNeWbLKHNCuj7Nb7MuYtBJufYg9jw==
X-Received: by 2002:a25:3a87:0:b0:d44:af:3cce with SMTP id
 h129-20020a253a87000000b00d4400af3ccemr5281739yba.27.1693977781457; 
 Tue, 05 Sep 2023 22:23:01 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 l131-20020a252589000000b00d749bc5b169sm3163298ybl.43.2023.09.05.22.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 22:23:01 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: mvebu: sata_mv: Add bootstd hook to enable sata_bootdev
Date: Tue,  5 Sep 2023 22:22:41 -0700
Message-Id: <20230906052242.21568-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Add hook in sata_mv probe to enable bootstd bootdev.

Note: bootdev_setup_for_sibling_blk() invocation is a noop if bootsd is
not enabled for ahci sata yet.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 drivers/ata/sata_mv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 18c7a66db1..55a5365b5a 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -34,6 +34,7 @@
 #include <common.h>
 #include <ahci.h>
 #include <blk.h>
+#include <bootdev.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
@@ -1104,6 +1105,12 @@ static int sata_mv_probe(struct udevice *dev)
 			/* TODO: undo create */
 			continue;
 
+		ret = bootdev_setup_for_sibling_blk(blk, "sata_bootdev");
+		if (ret) {
+			printf("%s: Failed to create bootdev\n", __func__);
+			continue;
+		}
+
 		/* If we got here, the current SATA port was probed
 		 * successfully, so set the probe status to successful.
 		 */
@@ -1116,7 +1123,6 @@ static int sata_mv_probe(struct udevice *dev)
 static int sata_mv_scan(struct udevice *dev)
 {
 	/* Nothing to do here */
-
 	return 0;
 }
 
-- 
2.39.2

