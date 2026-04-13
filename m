Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270B6EBFD21
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF9D8421D;
	Mon, 13 Apr 2026 11:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="FrFYGzVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F8584206; Mon, 13 Apr 2026 11:23:20 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE82841CD
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so2374530a91.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776072195; x=1776676995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoQ9KYdHgbeszQ2mA+HsiY3ZfxQ2lklXF+rc2EuvS6g=;
 b=FrFYGzVEzH0kMCcpfSu0H2J0+0oMFaJahW6BNAeDfKw3Rkh4c21yctlvQp81DhNbg7
 FtyXBP1F1Qtuo/6GsrT/CVCSJM24pvG4NyQQibEYOlg9xkIhdwUXsqqtVIS5zAYurJv1
 yO1DW1cfcQDb7Bb5zrtRM2Vs1p5C4XIJJ9JZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072195; x=1776676995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xoQ9KYdHgbeszQ2mA+HsiY3ZfxQ2lklXF+rc2EuvS6g=;
 b=lax5IhkYuTchFaFFcpnlMojFg3vrflHS45s9hok69cMidgy7ZNC9Q+jMCskzVc9GTj
 O/xkUwseEC8OM3SMKIJV2ziu/p3OVVkDOYiLbDjvV8WbhHeaTjFOaCLXnWKVcgz8Es5T
 RONHyYEOzzplp6U8jgcbB4TZTO97x3J9IDiwTA/2vAwYNUVCJdjI2H6uLSNntYaU+tzK
 af1qau2nUTWhNU9Swgo/DbeYDUnAmsXo7NnyjlDzVrj4Tk01Kqcs6h25DV5UYfkSdKmb
 5GwNK3XxmmaF2Dt15dwRzJaBD+19nbUHyQtZqwfLBSiuIluQAbepW7aiv5NWw0xGlDsS
 jYGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9f6XRTnx1fvilqWHUniPiXMxBI73LdLhReTVb31KgPuihV2WPJOtyrwNkbZ6eiYzdGM0OFBSE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0NnFicjFSUOleRreSIvQj7ytAi13orwWjDJH5Co1I4NTs+ymk
 wRiGvYffUOVpPrh5sh9wrCxy6BKzpm2LjpnZIsOjYRhCji2F+ERSGZ2wHNGSE8wLKpM=
X-Gm-Gg: AeBDietPuzTn0+oT6jkZx3e4tQQL0JhmGJgoy12hp0IjgOVdr2YgdjO+0/5LErpm4qY
 PSPb77wpVX4g3n6DdRxjCuX/OOTQ5fFKu5HRuuvZV4vTfY/P/a1yuNh4AKrZ1eI4DhxItqNHgUz
 ITSAcQ7G5LQ9LI9mcwhakit54hHviKc7Kcq6v7pp1N+dNyuqJwbKOYSsjiWl5W0CXurrIX9mqRR
 ZJWfAEPUlfuJVK1X6qx10POjYgY7wlfZ2Shvqqs3BICZbpDrL90dmUVlmJcgWt59fmC7zj4U6wC
 WBAyIfbyfXYm5hWXIPGjLdBKXJTG5wTufN3mz5UD9cibMNNlXGBZ/hRtydDsAsNFPK8m3Ow/fOf
 zR6bfyBoZvGbsEEkIag67fauQ0UIcyn/Y3yArFW84/augLe5AMPkYspeTLgHHteDGIwbHj4Vpy5
 pwGq7FQcgEf8UKXfap14trzshU
X-Received: by 2002:a17:90b:3d4f:b0:35d:a5cb:95c1 with SMTP id
 98e67ed59e1d1-35e42837793mr13224471a91.23.1776072195420; 
 Mon, 13 Apr 2026 02:23:15 -0700 (PDT)
Received: from kinako ([2400:2200:776:9b18:a191:7a74:9fd8:591b])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fb617725esm1055930a91.1.2026.04.13.02.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:23:15 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v4 5/6] virtio: blk: Fix converting the vendor id to a string
Date: Mon, 13 Apr 2026 18:22:39 +0900
Message-ID: <20260413092240.3719260-6-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413092240.3719260-1-daniel@thingy.jp>
References: <20260413092240.3719260-1-daniel@thingy.jp>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/virtio/virtio_blk.c | 11 ++++-------
 include/virtio.h            |  3 +++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 3dd0cf36268b..e70cf6a776b2 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -164,14 +164,11 @@ static int virtio_blk_bind(struct udevice *dev)
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
+	if (uc_priv->vendor == VIRTIO_VENDOR_QEMU)
+		strcpy(desc->vendor, "QEMU");
 	else
-		sprintf(desc->vendor, "%04x", uc_priv->vendor);
+		sprintf(desc->vendor, "%08x", uc_priv->vendor);
 	desc->bdev = dev;
 
 	/* Indicate what driver features we support */
diff --git a/include/virtio.h b/include/virtio.h
index 17f894a79e31..3edf023463d7 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -25,6 +25,9 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/typecheck.h>
+
+#define VIRTIO_VENDOR_QEMU	0x554d4551
+
 #define VIRTIO_ID_NET		1 /* virtio net */
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
-- 
2.51.0

