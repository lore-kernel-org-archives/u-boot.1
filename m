Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23684CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 23:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8FC83957;
	Wed,  5 Nov 2025 00:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jdbHldA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271CD839A5; Wed,  5 Nov 2025 00:39:20 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3221083942
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 00:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8477E4042E; 
 Tue,  4 Nov 2025 23:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762299557;
 bh=lt2Y0a7/VmR2qC83zIXQxQt6kVQGY0KYGtj+/K0Zqdw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jdbHldA7EjauKss8Z5K3lhIluuC+uTkkFGliaZIjjg/5dBgmQnsF/inUqJQ7UjPMA
 WcykEuPfmxkF+3s9ztVNMRKOKk8kI4MXyp6tTh3meAfbOYDibvA8aB7mTuSphGv7S6
 qA2uHY0gLHighhE98g+a2Dk0wl4wyGzXAL7SEBbZlcaw0GFI+UJJSnkyduGVvoVWyv
 NRRBtkIrgao0lmNSoGCg0g4ezjXvsErH3gTqGu5s1rOIhO6Mlm8+VKh1qDOUMGmJQZ
 c3UAud6uVhPyEr5slFPLAsLntz3EB5e7G7ItrCMyJ/jDTYl6Bas6VQT1u+hc/HUGjm
 3naD6/oyRPU16RyqRP5MolIsC9TOE8I2yGZ8znYfT4ikH6slglc7Aokov2adWDOr/N
 etga9j23aRoXR8gDRTidrEnR2+UI1TI24spNIjYHP2czgYus3ppTscZ1tLT4wW3AqN
 d4vayljChpjLquPmJ5VHWOdUG7d67AJysTDkO4hpSzbcNMBBGIRKTMF6APObLho/cf
 KIkRyZKB/C5rPO+hAGlONY9uOL27ighz6691RAnca/v1wL6wYT2q42ByM6DrifjbKA
 CdCpdiBoxgjEvH5pHSG1faiSxVpyh/QbJ5wsMktcJbsOdjS/qidU1nWgrNNM3mQVuB
 hgJOc21DG4gUmIPCJ4WEuo/I=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] virtio: typo complaint
Date: Wed,  5 Nov 2025 00:39:15 +0100
Message-ID: <20251104233915.89413-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

%s/v1.0 complaint/v1.0 compliant/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/virtio/virtio-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index 1dbc1a56aa2..ac563991b90 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -328,7 +328,7 @@ static int virtio_uclass_child_pre_probe(struct udevice *vdev)
 		debug("(%s): legacy virtio device\n", vdev->name);
 		uc_priv->features = driver_features_legacy & device_features;
 	} else {
-		debug("(%s): v1.0 complaint virtio device\n", vdev->name);
+		debug("(%s): v1.0 compliant virtio device\n", vdev->name);
 		uc_priv->features = driver_features & device_features;
 	}
 
-- 
2.51.0

