Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84818FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C1C8486B;
	Tue,  5 May 2026 09:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="UkEjE0hH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD56A847C5; Tue,  5 May 2026 09:50:10 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E64846A1
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3650a4eb605so2156754a91.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967407; x=1778572207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixCZofU/gbuKsyrNQ+/+c8WsBYe4OwMx23um7cc+u44=;
 b=UkEjE0hHp56EnBemU970vEAMbBCb+EJTDBRN38e6tiFYZt6JswxEidkC0mh02EQRBC
 H2Az+pWkYReKbSvBnbvwGrnkwlKdaNa1LhZguKXXna8YSR8f5fhMi0/uOOFa+gfuxV5J
 jbhJSwUlDDSs9pTPrP2v+3b+ToUKQnt0OeJU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967407; x=1778572207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ixCZofU/gbuKsyrNQ+/+c8WsBYe4OwMx23um7cc+u44=;
 b=ee7k7ZymN/lO+Pl9PzpHlcPUyVbsxIm9x8BBemT0UX5hxwwncGyaLLsrY8vUqd5Syf
 YfMryKdBB1EEzDIeC2jeD7io8sOI7HLnGac+4ZlGPEuykS6/bHkgQ5NY7vW/sSZW2+Ah
 LHMD0RQka6aCafMVAnXcbrktyKLtW5L70obne38ruYUaVyNuDL0z/jcREPldovkltiiy
 JZN/F1/2Xc23PZbunFZfruLYqcf/XnRDAxHWbAnCc5N2eulNfBUMrZzgRERPE6+ChGyN
 RgcrHXs7AIXw+EtsDPlusLqYLzm01Cv7SrnmrykURMjWXYMFfVFQt51yQSBaQH7PAH69
 kNWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AoBweKfk6mT/OFGCM0sAMHD8r7YKWWGaO2MRl3XPpmQ7IHUjee5Ri8ELBOgGEPPfeSDqL+lE=@lists.denx.de
X-Gm-Message-State: AOJu0YzjftiKXXyoTQNyTt/Obyq9ZztkUxa9pK5h+w/V/ID/BxuVJPRW
 dz8vsTi0VoMuB6thRGKzkxWsBCEkvatm1KRl/pO1j7EvsspuW0V32HvO4hSR0tjLrkt61jn8SSX
 p6dR56BM=
X-Gm-Gg: AeBDieuuJN2w7Dp9GZ1/ogcIbjyuFqzPXB21UreoSZFvv+aF855HS18bI4yzJqEhFF5
 O+o7ZgF3Cs2yfdP9gbVVbL4lNZ4wsiQnDOcQp+R7yn7+vByKxrLv02BJxfLOffUhfQY750Unff8
 Qec1BuQW5XsjEptS6x1OXL2rfH/EMc1kBNod794e3B5IAmphmIyo2aSFbE3mMxcWyayqdl74EcC
 3CWmj7OW8yXoS3WvI49FGJRA4enerON0bO4BQ/n1R5c2ZFZDS9fdRgH7ukP3503rVHBfokSo6J2
 lcZbZkTGjbLbR2N82uXSVojQJWWIXvAAS1Pl4xjDmaBA8kXF0Ml7UbxIjTtf2MQf/8MyqMKm1mo
 XvV/zXr/6pGUCeOMmc4UQK5HIb2kbbuiiVUoJ8JJ8gwrU/4Rw+E2WNkDm+Vaj15vhdF9G6EnYKW
 9RwvqoICV6mNkkBo1ZEH+yM+KF+7U+rdZxouGkkeZ6tstmubA3eDs2EpuxT8FxUmlMS1bGINRzv
 LQ2b1IjgY+s23kHL7k1w/jrFGk=
X-Received: by 2002:a17:903:1b46:b0:2ba:919:bbf3 with SMTP id
 d9443c01a7336-2ba0919be66mr97630325ad.14.1777967406779; 
 Tue, 05 May 2026 00:50:06 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:50:06 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 7/8] virtio: blk: Fix converting the vendor id to a string
Date: Tue,  5 May 2026 16:49:40 +0900
Message-ID: <20260505074948.2603870-8-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505074948.2603870-1-daniel@thingy.jp>
References: <20260505074948.2603870-1-daniel@thingy.jp>
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
index 45fb596a3308..94968ef1c759 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -231,14 +231,11 @@ static int virtio_blk_bind(struct udevice *dev)
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

