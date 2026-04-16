Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ABFF8A14D
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8FD84285;
	Thu, 16 Apr 2026 11:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="GkSgMdhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92DE98407E; Thu, 16 Apr 2026 11:40:16 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA71084277
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso3537248a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332412; x=1776937212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nvel3xKllIvYyfxsg1GFyovNvU44g56KlYEeybkcgXQ=;
 b=GkSgMdhN8sob0nuWo0J1g5PQLJ/Wwy4axlVLbfrhwlj38Es0tD5LdH5VD1TSFlNH8q
 VBNSB8CgDnLs4KuLVneKeSLv2JObjtKc3iPoXgs215dXV60BCSroQDXXl5Y1aTbF0Z9x
 Sd2bw9ba9DHEbzec2Vb8XxOUiRfXJeQlC61wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332412; x=1776937212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nvel3xKllIvYyfxsg1GFyovNvU44g56KlYEeybkcgXQ=;
 b=MMM3auj9hF8JP4hoT1aVZD3M1Y98wz+1asPkwkf08wTILK3jGA5W8nXN39zGl/KaTj
 wSIh/ZsCL0n89kx+39x8MQSYeSRevX1ui5jqjmh1P0ogWHVy25xx7IKdGC8f/y/X36WS
 G36Lg+9Ecj5wjLx2swGjJbP1JYi73wuLtREa6jjYuQK0FijX89yBKKe+n8cB3EYQjIUk
 AUGYzOrL0FtdxK2x+5Qd6Qiysok72HPvabe3JLRqridUXks/HQXOclazrViQSLcMSV+I
 8FYvXZ5sYhMQs0dvzdrjyMjs87XxnDSAxntNX9CmBDOEMlM7FpdEFMHBB07/znFR2vdA
 SrCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9a2IFjHdFljhq6dDPwe60fpPTpWeGyjExsYxmiEXNjN/bHV4dQ1boPan+iUBWB/LUREr2gN/c=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy/8oGDXm5E0u1xabIWxX9JX0s30fW4WqAP2LXx6MHKFrubwp3
 2pAOgkggo1VPtOfr52QFqiX3DBqRKSMnPdL1/0hJ2ImsONrVSm9X/8OfSqivQa519lo=
X-Gm-Gg: AeBDiete4zpUA7qHWbok9W5kg2nN2jkMW5d1fgjsqQ+clqchMumQL45aoL7mMXGl5Wj
 AKKkFnWgUfOk5/dck9weLBSVUxwaUN+utEeBwSzTo5qbZrkS+/g5fZtqLcq8yqlMoPvmP2Ptsnp
 3SfkEt2B8mTuQ3O2I+ZdCwxo+Yz9OmCoOFAXYVYF08N8G0HpsZDLrJ4YDsovNVZ55daOVBTzIzv
 OeV+jo06m25kwd9s6Yj5tgvEhQBUp7pQXLEkWmfxknY8rZLg52AnS0EmxX8g2hcHqgwO6z5BCcK
 jKI66Nts0JGc7B9ElNekohr4+wJg03mZ6hoEpAOWx+ksNJAmMBWhiT8nN4DQ+9Ggf2ZSkxsMg2s
 NBDu6KJ1SbwFu2rT1xOk5AwDd26km9xk/yXa1K8p5aEPqhnKcTp9NPiWdjQn9mnEB/G9EZp+P0F
 QHYVjVSsmv2Vzjni9X851k95rQ/xP2VBwNYaeAjGb1LPGk9Quq4EOQy0J/DB4ogiYhAwvTJigY3
 C70iQ/SvNbW+90Rl6g9I+FQ
X-Received: by 2002:a05:6a20:7f9e:b0:39f:2ad9:e547 with SMTP id
 adf61e73a8af0-39fe376980cmr26471418637.0.1776332412149; 
 Thu, 16 Apr 2026 02:40:12 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:40:11 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v5 7/8] virtio: blk: Fix converting the vendor id to a string
Date: Thu, 16 Apr 2026 18:39:26 +0900
Message-ID: <20260416093927.602613-8-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
References: <20260416093927.602613-1-daniel@thingy.jp>
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

