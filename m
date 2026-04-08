Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337EE10FC454
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 22:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E3284142;
	Thu,  9 Apr 2026 00:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="bPT5S2RN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532578418A; Thu,  9 Apr 2026 00:10:07 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F8538407E
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 00:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82cf976ecacso127903b3a.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775686201; x=1776291001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOt9OULTo/ICGagTQwu1OC0Y28jrkWz9xsNj87DXqXk=;
 b=bPT5S2RNQAnme6CVixo7rkW7L382kOca0npo0NPOolTOBZnNOuz3mqDv+q66c/ArHE
 fTAGi+aZGZIdRvQbrHsJoObuS2WjWbMiJ8yovSzYpGkhOfcmmwmRmMb/Ardx2dyXlQK5
 E9w5ROC3R18r+TybKHPKijaxgRXGtA4pEylIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775686201; x=1776291001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QOt9OULTo/ICGagTQwu1OC0Y28jrkWz9xsNj87DXqXk=;
 b=MQb4ukLFkZKIRgoHijx4q/fRKMTpjcM/rMu2vpAYUOh6HcpMmcCqOrPassXCNraQTP
 SbkuDnjCxon0dw+m9JsfGwKPGPjIU5PgbqhGuA9NASbyP83vNJv6shfLR8jjSRm5nbO7
 B16byDViWbAmJAFV8gH9roxwmjX5HMXfPTWfO4T1Kkrn/n2pey6P4YHQS7e3psR9sWLg
 M3LvVZD+7W3nwIAHrw2DcejLmxNxLLemU4WnDgeEZJVIAcZ2AC9AWH5BuKx2bm/WSUdz
 DRlz1PNPtu1CS1erHweGJeUxnK4B8EYQL1GyYGFsn8LN3vpo1/XX4q+VAqaXBNqIn13J
 WNlg==
X-Gm-Message-State: AOJu0Yy9YPozkq/6PwuFVJrjiPOLGOUo9IrhGH16BZNqr3fgcMOTF0M/
 sk+yqHL9FJScuRrLKk4xiBF7jSJcd7e6Y4EP9+spTyxBE4ivkV9o3DhOewPtQDmxC0A=
X-Gm-Gg: AeBDiesY3UGPQ36QrcchWC3zVg/eHs+DDiUaom4+16ZuIpmv9GNWsVrrvkJXPpFHhqJ
 EaoMHhWen9RdQM1FkEBFr97J1B01MgSyjY2GM5IowIRS9lfwKn2dlfXImgh9ELd9TrmP7fn19jg
 h8AYEMtByVFoC/6w63GUBYGokI5slkeur5BhgeVdCXFHOG5yXMlPBgMVRK3QptxIEGJnJgjPriD
 Cp+5dRDDlxfY4sDA0xV1BiWZ2NLjuwbDKIX3Qxw5G2/QNSu2r9BweloKE7sFffZGCeDzOU/sBRb
 0tc//Jq0c8mTHCsEjj81uxVLjUzJyuGGIuUFDyKsxm1wndxPJlbGGSU4yeYGfqqWROkEaddMHfP
 MB44gHxr2YdOfqSOADVgVK0skTwDwqn9a+A0z4YZ4J3nHudU+m2MUkq5+QCtjTPxtn6g/HRj4B7
 9gOB/9uy3as/twdaCTf6tYh8M=
X-Received: by 2002:a05:6a00:1785:b0:82a:79d7:cf6 with SMTP id
 d2e1a72fcca58-82dd8944863mr1060689b3a.2.1775686200991; 
 Wed, 08 Apr 2026 15:10:00 -0700 (PDT)
Received: from kinako ([2400:2200:7f0:5ee8:dac6:2cde:760c:93f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b60199sm19877723b3a.25.2026.04.08.15.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 15:10:00 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v3 4/5] virtio: blk: Fix converting the vendor id to a string
Date: Thu,  9 Apr 2026 07:09:27 +0900
Message-ID: <20260408220928.3328551-5-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408220928.3328551-1-daniel@thingy.jp>
References: <20260408220928.3328551-1-daniel@thingy.jp>
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

Currently we are trying to work out if the vendor id is from
a virtio-mmio device and then casting a u32 to a char* and using
it as a C-string. By chance there is usually a zero after the u32
and it works.

Since the vendor id we are trying to convert to a string is QEMU's
just define a value for the QEMU vendor id, check if the vendor
id matches and then use a predefined string for "QEMU".

I don't think we should have been assumming all virtio-mmio vendor
ids are printable ASCII chars in the first place so do this special
casing just for QEMU. If the vendor id isn't QEMU print the hex
value of it.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/virtio/virtio_blk.c | 12 +++++-------
 include/virtio_mmio.h       |  2 ++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 3dd0cf36268b..d876c40deb05 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -11,6 +11,7 @@
 #include <part.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <virtio_mmio.h>
 #include <virtio_ring.h>
 #include <linux/log2.h>
 #include "virtio_blk.h"
@@ -164,14 +165,11 @@ static int virtio_blk_bind(struct udevice *dev)
 		return devnum;
 	desc->devnum = devnum;
 	desc->part_type = PART_TYPE_UNKNOWN;
-	/*
-	 * virtio mmio transport supplies string identification for us,
-	 * while pci trnasport uses a 2-byte subvendor value.
-	 */
-	if (uc_priv->vendor >> 16)
-		sprintf(desc->vendor, "%s", (char *)&uc_priv->vendor);
+
+	if (uc_priv->vendor == VIRTIO_MMIO_VENDOR_QEMU)
+		strcpy(desc->vendor, "QEMU");
 	else
-		sprintf(desc->vendor, "%04x", uc_priv->vendor);
+		sprintf(desc->vendor, "%08x", uc_priv->vendor);
 	desc->bdev = dev;
 
 	/* Indicate what driver features we support */
diff --git a/include/virtio_mmio.h b/include/virtio_mmio.h
index 8c072826db55..cc59bc516c2c 100644
--- a/include/virtio_mmio.h
+++ b/include/virtio_mmio.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+#define VIRTIO_MMIO_VENDOR_QEMU	0x554d4551
+
 struct virtio_mmio_plat {
 	phys_addr_t base;
 };
-- 
2.51.0

