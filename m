Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C987CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87822846AD;
	Sat, 16 May 2026 09:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="QVHIOCrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 339CE846A4; Sat, 16 May 2026 09:40:56 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE13B8407D
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so328534a91.1
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917252; x=1779522052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uquJrn5pH93fzWzf/wlhYOVqhvgiAfdSsnIF6mixuUs=;
 b=QVHIOCrmKAhmJ2ZyE1RggVlBkvi1+chuVzv+B/QPtovUcFmQUqEF2t2bT1un5xZqlz
 T/XbKnhmoIJEv/9iojNSMxjn2zpC8K0+COdQe8RqkRL0Ub/w05fW+qAJYgXZvbxeI9el
 4/y6j840Rr/leVb2gdfei7sTx5I11rY5UNV6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917252; x=1779522052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uquJrn5pH93fzWzf/wlhYOVqhvgiAfdSsnIF6mixuUs=;
 b=hYtCfCg5k21f79IpXHn+9OURvh3hgNTOeeMYgnf+IVQj0nNCW3p7lMtPSMZOCipjRv
 KUa1hbHdBvek8dMwe1/HC6qGDYDZYPdbzxhXhOf7isyEg6to34Ru3qvk1L6eGknLMmYJ
 PK+tIFSvcGwxfuh7uTCzLv3Lgq1BNBy4QWhlnfoOoi+5bqaRINzPiVCMqvz5MzeZOLHt
 s+DKWLWTejyaZPOT91r18q9ASLWWAFxiEdgb9ksxHXt/j5U6TocMpoTgqe2XZoPu9vIR
 KG59z3WROU6VIVMGd3Tn/hSgqKHvINra5/wk9AtL6C0Lqx4jT9B/uUGf4gmeDQmW/i4D
 bvrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+9o+jwj3dmjPHOTnq3JqIMqyb1nO5SltYPXistSPjxBNMNKNbgaSfqD/L96m2KK2gTgK9jh8=@lists.denx.de
X-Gm-Message-State: AOJu0YxYC9C1ctf7gUVYmyO7QYRPmlU19lHcaFEcMAaU/RlAWt+v+44r
 cSHrwN3NJqogyVMpU1lraSVGwRdZ2PCWz85kRz5gVZtBaMKYv+BAVvRFoQuHu4U4mpg=
X-Gm-Gg: Acq92OGrGRX9y/2VQTQBTREZpzc5kBLxsUSmAWE39f2VdSQbVh9g629yRPCfZ+aktzO
 dQ6kElSh2tinm/nB2M/B3RtvVeVHkZxuhDKb0AtTzgSycra3MwEsYaN69SeqZd8b+Im4UbZCYo5
 cSNCGD84drZuDH7/RvEaoIkmuJcdR1jJmVt3DlVXuxKIPgrrkMBQ+s85see6/2yrIBP8uogSATW
 y1PPaxAjwsw6x9u3LiRtRxYrGoVoJ1WMhDBE+2kAAhd3TYt8q+CXANdp2EdaLUrf7ak4x8ZvobZ
 ojTaH2e9r2NGzpiqBeve2RvvzrCD09Vdl6z7ZM5RSsQhmLv9eMKNka278u+S/0UJQakQyEK5vyn
 ekPiskeD0gKo6BADS6NuGVk3ZMRW+k2GqnKPA+TF9y78Q/EnyzvaCAcxKyglshAXSNOoEZl0HYk
 qnusyhU32hVrEMeWmeWCDCHzFsqvUi5LZjk1WzGFQ9frsPO6u+cdBEX+/sXlaN5LyHm0FQD5+MP
 bK+tsJ+dyJ8Xg==
X-Received: by 2002:a17:90b:33cd:b0:368:7536:b5b7 with SMTP id
 98e67ed59e1d1-36951b71e46mr7284931a91.16.1778917252297; 
 Sat, 16 May 2026 00:40:52 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:51 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 8/9] virtio: blk: Fix converting the vendor id to a string
Date: Sat, 16 May 2026 16:40:00 +0900
Message-ID: <20260516074016.885146-9-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516074016.885146-1-daniel@thingy.jp>
References: <20260516074016.885146-1-daniel@thingy.jp>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/virtio/virtio_blk.c | 11 ++++-------
 include/virtio.h            |  3 +++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 7b1d891cdcbb..404d9140cb2b 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -232,14 +232,11 @@ static int virtio_blk_bind(struct udevice *dev)
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
2.53.0

