Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF43CD8CA8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 20:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA7783EEF;
	Sat, 13 Jun 2026 22:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJ0rimCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB9083FEC; Sat, 13 Jun 2026 22:42:01 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AD2801A9
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 22:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so14800375e9.2
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781383319; x=1781988119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=78uyxwwwalK+cSHSlERGyqxbWB+g6H4o0WHphSI8sdw=;
 b=AJ0rimCFndSuMRYsEc8LHLN7JFbp9CPfMnxY1NaGFOlpsMtGvfMCccIkFqq9EUvDf/
 u3pMgG+S73rQyqm9NwimHDsnCEomnhcklwS3gECA9HbdfL3MtFQULEQlviWoh4rHZVmg
 YjEPPKFvMsh9udx1bugFrfgHJMvVQngn6aDZMCKgYkgj/YgW6O2RGz4IOspA9eBQLe9o
 0in6k52XAkxe3OxRXa/ZHuOutBLi9PRDWRYxfiafdo5vGAYczjGpgT5TW6ZXDugst0ny
 8Rv2sUO9jo5lna7yMdKGSqx1cjn3FTekgtjx/l8heMajGZQScxhuJ7gROSsLUBiJZEot
 gqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781383319; x=1781988119;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78uyxwwwalK+cSHSlERGyqxbWB+g6H4o0WHphSI8sdw=;
 b=UnEQaw4WhBAbY3m8BXwCy4C7dGZqEkj2w+jj3kJWIJgMlRp2NK5hEtI69OW8+FrV2I
 dAVNUhx/MTuneqc7dmHQWxL2J+KIeYFbRAgdmtc08MMZ9vuZKEBmmkcYhbvXPbVNHnGS
 T3VDMShx0sTTPQe1VO15lD4kvKF3rvq3yPi8HFVIYgRItYraW7di2otfREzzMNtBxE/f
 +GEbhELuJxtVj7seMPb429/gVFUW1Z5rElS0CBr783h7mzuAp3Tj6jMieQzf23LiT0xJ
 YRp7LeAPRDg9b4fwA59tIKBy7ay4Oy8rThP/Y6GOGHgIwLteYnBhF/cFcYuirUQ/LE8P
 6uYw==
X-Gm-Message-State: AOJu0Yx7wpDMYtdkcR81ypayxeGkCrVvbIDkTLiKisjnaVWI+xs8G6+Y
 5+6yDXRU0a3E1VhnhQXiEx5j90E/xcbpY5+WCjU8Zlde9tWWlLPzAuEadae/p1x/U2o=
X-Gm-Gg: Acq92OH6j5+fsYpniv11SoHLaeuJhiskScLj/9GHCjMEGC+ALv0yCsQT/d4iEVxJY1N
 R60k9ZdqUU7BQqBMyJVeIF/BnmTwB/1Z3JIGCcFXys4zMShiSxTy7eTiUiPOfB+3VmHi97HrGBR
 HOlSosKUwwfRo2Ao60S4xf1CiREkKpve5D28KV6kWtbNipWPsJX6et4YmjdmlYU80ULiXCx/6lT
 T+YQ0prA+RTh0nzsH1x69xZ/m0ICjN2Nwxz0Qp/hGmEWlWUhm9J4e+KCMnLTxYznLSZsCy8Fhgh
 +6hH76QjfrQaLL7VhZNykqCu+Ahfvk6D5iuSRpPsjRoh7In0HsjOPgoPRiW4W1NI5mZ1HSeJyTY
 Gw0wpvYSCvGeLYWA+efmmsU0o6lzFeI6vzXRr+CRJC3ZCCVYnOTEk1UNI7TP3w86uCwFs7R/DfB
 e3SrLU3DEHy73dgeDu82HBPCj9Ovl/ZTmeTE0QYDV/J/507PCvV/pB
X-Received: by 2002:a05:600c:4745:b0:490:bd66:e523 with SMTP id
 5b1f17b1804b1-492200c04a9mr56090065e9.20.1781383318449; 
 Sat, 13 Jun 2026 13:41:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202edf89sm109078155e9.1.2026.06.13.13.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 13:41:57 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 =?UTF-8?q?Andr=C3=A9=20Przywara?= <andre.przywara@arm.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to Linux
Date: Sat, 13 Jun 2026 22:41:50 +0200
Message-ID: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Currently some ARM-based platforms reserve TF-A memory in their own ways:
- Mediatek gets BL31 region via SMC call in ft_system_setup()
- K3 uses CONFIG_K3_ATF_LOAD_ADDR, effectively in ft_system_setup()

And others like Allwinner simply forget to do it, which results in Linux
overwriting TF-A and crashing.

Unfortunately seems that the things are not much better on TF-A side and
there is no universal way to get the reserved memory region across
platforms. But there is at least a most common way in TF-A, namely
reserving  memory range in the FDT, in particular:
- Allwinner	("tf-a@40000000" node)
- ARM FPGA	("tf-a@80000000" node)
- Xilinx	("tf-a" node)

While this patch aims to improve the situation for Allwinner platforms,
it's deliberately adding more generic code to pave the potential way of
unification for other platforms.

Note that fdtdec_add_reserved_memory() has a check for an already existing
carveout with exactly matching boundaries and will not create a duplicate
even if the name doesn't match. It would not however detect an already
existing bigger carveout fully containing the one requested.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
The patch has been developed to faciliate Allwinner A133 SoC support, where
most of the work currently happens on TF-A [1] and Linux [2] sides, but
I wanted to send this patch upfront to get the first feedback and because
already supported H616 SoC would already benefit from the patch.

[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/49754
[2] https://lore.kernel.org/all/20260605070923.3045073-1-alexander.sverdlin@gmail.com/
[3] https://lore.kernel.org/all/b428d57ba5464f1226daf099877f4c25fa4fc191.camel@gmail.com/

 arch/arm/lib/bootm-fdt.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/lib/bootm-fdt.c b/arch/arm/lib/bootm-fdt.c
index 2671f9a0ebf..19d917943c1 100644
--- a/arch/arm/lib/bootm-fdt.c
+++ b/arch/arm/lib/bootm-fdt.c
@@ -14,7 +14,9 @@
  * Copyright (C) 2001  Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
  */
 
+#include <dm/ofnode.h>
 #include <fdt_support.h>
+#include <linux/ioport.h>
 #ifdef CONFIG_ARMV7_NONSEC
 #include <asm/armv7.h>
 #endif
@@ -24,6 +26,52 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static int tfa_copy_reserved_memory(void *new_blob)
+{
+#ifdef CONFIG_OF_CONTROL
+	ofnode node, subnode;
+
+	/*
+	 * TF-A for several platforms inserts its memory region as
+	 * reserved-memory node
+	 */
+	node = ofnode_path("/reserved-memory");
+	if (!ofnode_valid(node))
+		return 0;
+
+	ofnode_for_each_subnode(subnode, node) {
+		struct fdt_memory carveout;
+		struct resource res;
+		const char *name;
+		int ret;
+
+		name = ofnode_get_name(subnode);
+		if (!name)
+			return -FDT_ERR_BADSTRUCTURE;
+
+		/* only handle TF-A reservations */
+		if (strncmp(name, "tf-a", 4))
+			continue;
+
+		/* check if this subnode has a reg property */
+		ret = ofnode_read_resource(subnode, 0, &res);
+		if (ret)
+			continue;
+
+		carveout.start = res.start,
+		carveout.end = res.end,
+
+		ret = fdtdec_add_reserved_memory(new_blob, "tf-a", &carveout,
+						 NULL, 0, NULL,
+						 FDTDEC_RESERVED_MEMORY_NO_MAP);
+		if (ret < 0)
+			return ret;
+	}
+#endif
+
+	return 0;
+}
+
 #ifdef CONFIG_FMAN_ENET
 __weak int fdt_update_ethernet_dt(void *blob)
 {
@@ -56,6 +104,13 @@ int arch_fixup_fdt(void *blob)
 		return ret;
 #endif
 
+	ret = tfa_copy_reserved_memory(blob);
+	if (ret) {
+		printf("ERROR: transfer of TF-A nodes to new fdt failed: %s\n",
+		       fdt_strerror(ret));
+		return ret;
+	}
+
 #ifdef CONFIG_ARMV8_SPIN_TABLE
 	ret = spin_table_update_dt(blob);
 	if (ret)
-- 
2.54.0

