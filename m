Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2682EF46C45
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 14:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80BF83EC6;
	Mon,  6 Apr 2026 16:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="OIQvds9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E1908352B; Mon,  6 Apr 2026 16:24:37 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1991C8405F
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c76b0cda2aeso1512378a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775485473; x=1776090273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvY6rMqtz4X518COuQ10zUdJPlmfu0QsTYJzfAaMLOs=;
 b=OIQvds9b0AjKmDCsI6WOcCmhj0YIX/AaNjFNq332ynTFxDwtRt/EZHJRZi8sUXC/oN
 pH1sRN5qC4gTAsLyrmMNy+fUF1mmGaRy/7QOOKwC7MUNSlJX8eQ5Cl2wWCZCYpTY7/OT
 OgQkTiEgoh9tZY5f7+UIOBityQ4WYfBVyg3J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485473; x=1776090273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvY6rMqtz4X518COuQ10zUdJPlmfu0QsTYJzfAaMLOs=;
 b=VAilpQZLwE2H1FVCTjH4geu0v+YQgx5i+d+am9Zx6VtwWg8qBzdgr8XyFRujAhl8fO
 AEbL8zq1AFbOCJPJDv1bj/VUYbeoa9vSu8O9/Npjqyga5jvG3LAZI02qDpOugU0PZEZF
 wvvEK+nXlCHvCgASPw90bq0p9/PUMItVo+jZPNkq0F5V1OvU+jHlObzNH7sLGjcjWui0
 AcZ2JcF8v6y5D2ioZQdZLep75vTLvYTEGqGyrsDNHFZBE30q4veF3eRWE5/9oW23Hjdm
 M+O0jcAr/NFvdORQKAmZZ7gFMlnHb6HixDGRGao60mnSg1xIVxdFrgFXzCia/zmJzBAG
 QcIQ==
X-Gm-Message-State: AOJu0YwBDp5fH3kEcj1h7ds1CCCLercGcLH1gM/c3FjSNecYBDIeFH7m
 B3ZlA/NHXAGio5Wb+B0Q2p+1e9IXiN3RsafNvRBPfQpjnLlQTWeCnsKMIWqxRKZB4lY=
X-Gm-Gg: AeBDievygn9Ay8LaEb53+g4R8yd9rKhA6Z0fDSc3KNeyAB5ikvLcTgO0/P5a/RP/BXD
 /JB5QJ8TqGBl135gu36KtrDC5HvKNLGudZeJtML1LzLeZEM29fFCy9xW028gMqaI5Sdb2uPBSoa
 d/kpeyllFtgqiHG+QSzz/NwqmtISqJdQk/L7EYUcQb35fhLtkFMmet07UN1A6QWMJKf9f0+FTHl
 RlwZQ95hhjxOM/T09ryKPVUXAbSvpu3UNUAtCXMqwcZlyCurrF5ouHSc5uEiLmzeoi+pCaRzVQL
 wnplXVZuVQbBT3pmk59QmV/c/Z6LiTr7RpnBNzwqEgMb2tAKla0en8O7gLBCyYaxRe0HSeRLt2h
 mHKxKEOYDS3Ft7I/J7qCHIB50CvsBYoKGgzaa0pTU/XpKebpBfVw0ELfLxyIiOQGtYBSVcE73DZ
 W81bu0pvE7eHPkF9BX1G4IejXm4TkIa8SNKimv9L+lAdMroeA9yigCitF2H49o0Kzm5CJIt+lZa
 O5ptyyWA2A=
X-Received: by 2002:a17:902:f642:b0:2b2:49a7:a5c4 with SMTP id
 d9443c01a7336-2b2818b00ccmr116069805ad.27.1775485473573; 
 Mon, 06 Apr 2026 07:24:33 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1866070-ipxg00f01sizuokaden.shizuoka.ocn.ne.jp. [180.1.30.70])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156885295ad.29.2026.04.06.07.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:24:33 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v2 3/5] virtio: mmio: Keep vendor id little endian
Date: Mon,  6 Apr 2026 23:24:09 +0900
Message-ID: <20260406142411.2992618-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406142411.2992618-1-daniel@thingy.jp>
References: <20260406142411.2992618-1-daniel@thingy.jp>
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

The vendor id is used as a little endian value but it gets
swapped to the CPU endian in readl(). Swap it back to le
to avoid the below weird output from `virtio info`.

Device 0: UMEQ VirtIO Block Device
            Type: Hard Disk
            Capacity: 1.0 MB = 0.0 GB (2056 x 512)

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/virtio/virtio_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1cd737aca249..ddf873fa96fb 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -374,7 +374,7 @@ static int virtio_mmio_probe(struct udevice *udev)
 		 */
 		return 0;
 	}
-	uc_priv->vendor = readl(priv->base + VIRTIO_MMIO_VENDOR_ID);
+	uc_priv->vendor = cpu_to_le32(readl(priv->base + VIRTIO_MMIO_VENDOR_ID));
 
 	if (priv->version == 1)
 		writel(PAGE_SIZE, priv->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
-- 
2.51.0

