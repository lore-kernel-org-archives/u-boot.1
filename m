Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B75C52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 07:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8282F889A3;
	Thu,  8 Aug 2024 09:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V07/wpSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BACF8895B; Thu,  8 Aug 2024 09:08:31 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFCAA889D5
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 09:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0B0763FD45
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 07:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723100897;
 bh=fbxf8K6CCYnuHawmEpkIa9lZWqi9hvzFHTcZBxr6JrE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=V07/wpSGEQmbB+XX2uHqI3rsFYJUfCj6oqROTqMDAHBZ5M2mcaOO1GCBuipsYQ+fc
 5Rp/iPcn3YDKQimGUgiFkxyyMv1bqLACHJ6nHG/+B3UDJAtOq+xEYgxdf2WoMVinfG
 k18gSlT4yPVBFyPRnoLSQ+zZdnm6JBSf+/3GIUHcNnx2pHwotGe2SZUBL9FfiGHdLi
 PPgB7z2uoRjvipovPYyH7nRNi9AWcE8Ly/1lrq3UaViiFNWp3MH46ZqblqRoqPKwwp
 8o/89lC/BN6JxL+kBopV7YAGmN0PWu9+EgKvFXOhg7Yqxdt7LmCwb8qcmF34gCu6dj
 uZKt6k8s/lLyg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-428e48612acso8478475e9.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 00:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723100896; x=1723705696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fbxf8K6CCYnuHawmEpkIa9lZWqi9hvzFHTcZBxr6JrE=;
 b=vdHw6BsqMJYWat9/fnUiE1iGqG7d72ns9Cws4yxjarX3MpVIT07oJvY/BOrz/gVx9T
 VWvR9Qf1P1rBY67VLSWLU7jndTakot6muYwBL51nfHlMyxO0NkR9KtxmOgEcsf0i8j1H
 +3p0YM0MOEFhiA2VqwiB4a8/YMMqOL0VDgp9BYDwXhkO17zEzaKOrbzzRX/G2VX8yibw
 0np8UdwQU5i5a3LLhLd/2rLROfXRO8C2+WUFJXZMwrcfcgkpq9xrAT8mPhgb2p6QuuhB
 vE3ImK/YAmX7KYL6czyoBY/Ln7WpwPq+JFVfPLYLIm4+1KjijRmNMTNWqXnStHJQ0G7y
 Y38w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeG9F1dHRJ09LAmBv0l/5goVWBJcZ9TKRQEDc7a1U+eUqXu5omRKnTlkjsqR9cvDkKW5aqNhESIGL02PiR0DyuL5oDgQ==
X-Gm-Message-State: AOJu0YxB9HE9FU1Ip8GhOa5+DlnhX045XKDHQGGfLmZspTx6O7XweSrk
 64f+bF7RLVi5ydcup38vslh04lnlXyOs90gMSFJTf7dB2mfQ30gfGOdyX4q8Mp6vlXh6KlnG7w/
 zS6Ue2KoKpZRqHIvEiA3P2IzVK/FpZ8AcpkZPKZrB6XpUWaP7+QwqrjFOKs40XrjdV90=
X-Received: by 2002:a05:600c:4f95:b0:428:29e:8c42 with SMTP id
 5b1f17b1804b1-4290aeee05bmr11594435e9.9.1723100896620; 
 Thu, 08 Aug 2024 00:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE50qtUODrEGTngH4F6b1h7IlOqhJZErAl+1g+98xQ3BCN3UGO/E+WOsPFOcFhUDB5QekidHA==
X-Received: by 2002:a05:600c:4f95:b0:428:29e:8c42 with SMTP id
 5b1f17b1804b1-4290aeee05bmr11594085e9.9.1723100896068; 
 Thu, 08 Aug 2024 00:08:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3037:2e0:4fb6:2b17:1f93:a543:a0b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c739083sm7157515e9.18.2024.08.08.00.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 00:08:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Tony Dinh <mibodhi@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] ata: dwc_ahsata: create boot device
Date: Thu,  8 Aug 2024 09:08:03 +0200
Message-ID: <20240808070803.57438-1-heinrich.schuchardt@canonical.com>
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

For each block device we must create a sibling boot device.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/ata/dwc_ahsata.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/dwc_ahsata.c b/drivers/ata/dwc_ahsata.c
index a29d641343e..203f98edffc 100644
--- a/drivers/ata/dwc_ahsata.c
+++ b/drivers/ata/dwc_ahsata.c
@@ -6,6 +6,7 @@
 
 #include <ahci.h>
 #include <blk.h>
+#include <bootdev.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dwc_ahsata.h>
@@ -897,7 +898,11 @@ int dwc_ahsata_scan(struct udevice *dev)
 	ret = blk_probe_or_unbind(dev);
 	if (ret < 0)
 		/* TODO: undo create */
-		return ret;
+		return log_msg_ret("pro", ret);
+
+	ret = bootdev_setup_for_sibling_blk(blk, "sata_bootdev");
+	if (ret)
+		return log_msg_ret("bd", ret);
 
 	return 0;
 }
-- 
2.45.2

