Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DF5C9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E96580847;
	Tue, 29 Sep 2026 15:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 690eCc0PRKIt; Tue, 29 Sep 2026 15:52:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2F083807F9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790697145;
	b=g22uPLHQqgFeQ+neaqrZSWWtP55lBhVMs0IFsypG4jaDcwgeuOXFIG1eUDdKNzUZBONO
	 zea9dpDbcvJNvXNdftf7f3ULH/Z95W5R3oUmOueYyP1U6EnSgaGs52Q0IpzI9OvMbvulc
	 jVXHnI5OiVUgIPvos8b8keqUBF6b94XqGriKwLfMpRYiVz38qOczZ4d1QsjEY97b3jZZD
	 GyTNbLpgfMsYO606BgR1TKIPFMjI1TMvx71fJAKtY9BLFRdYgf3qr/Jbi1665F6PQksZt
	 UZxG9HsUeRrN+1vv+AY3ZcfCU7X64dzzpkqonunDXcJ6kW5A3MlFUJCY9YCiPDbUWaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790697145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TU9fsSimN+Oj7sUwPmlFsF8nX89xX2CgzZ5Mh22HhH0=;
	b=Wqi8E73N+KV6R0owolU0Gr/JqIKMI3f1Aggmr+oX5GItYiULoYhDIFEK3bDyiCncnNfL
	 w9ILVJKCmE1XrqAq+LAqJ00zQPZGCkzCXF2dKWDDrYKHALn1QlaluWrWNpJ7EAIQiAkGr
	 bvI4qX0hTgreWlMZWovRV8Z4cjPQL9Sc1cwYTW5u+jBDxTJ/I9103ZgKelMWl3igI26vg
	 uehVQX2Y2EGo48X2ZIUj7KZkHG2zvavecoZty4gcFejBX0DyHth4CKQYgNPqA6rluC6Ck
	 kyUtlxdkslHw+37xrafAdap9zyEKhhH6DhGL/TB1Xc2ChZOgaK1lAaNRPRQBWMX5p4A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790697145;
	bh=TU9fsSimN+Oj7sUwPmlFsF8nX89xX2CgzZ5Mh22HhH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jng5ELLgU8o1bzCYMlDvgr415Lh432MgqA7fybG0TMtpqGyriA6+3RtcEQ/nkXPds
	 jXqVicoMa8V/miBHoLjAN+feSZSAsmdVWHI9zlofiAoMpydzo9+0Nx7rI3VHSzkXIa
	 +oIOpOkRyenVNqDiGf1kXuPy50nNqXsCVq97zJouSWqtaSJ/nICiC69UZbFFiCMxwb
	 oHnM77Sj0CfKpVpYyBvlbCTuQVdcT4uy8Kz96ROPSTIf/FhCDXSxaXCmzZ+7vV6/ix
	 yoNnYD37DI4NAv+gvGcq2+33OcG9Os2H2V+bMHMwIbFSJ3dYEt2Nbgmg4o4wI7x1sw
	 y5ui8TuIoOJLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F083807F9;
	Tue, 29 Sep 2026 15:52:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B0F032A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C76440333
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nA-LpVPZ7vcW for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 53BC64032C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790697143;
 b=PA3bjwBce+KTXl01o56tVTSrBGqJKBDRJkTAvIeHrgNV4ugZUhUVn/C9xsTn3tzRjL4R
 e7e7S9HEHgC+qGJYxozRTo48Od2InizBRr6kvxkh6gwjUjfaND+uAyfPNM+ibwhun3kL1
 MEM056onQV+2CyzaD8f/lwo2N9vxhJu15UNs3/PaNiv3bLwa0qKDeeC7Cq+aYu6++TrM2
 1fWDPmE2LIpyEucS0ay5Yekx1dlGQwRQhlRvdn5xP0IzCDnc4MgjkxQ9mQzcDZh3FDyu3
 joXC49EtFSRVsXYVwsg4YX0nUMC4efOt+z8V1H1kO1htvHAywRqJGeZY5kY3z7riiIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790697143;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=TU9fsSimN+Oj7sUwPmlFsF8nX89xX2CgzZ5Mh22HhH0=;
 b=iJXxvNce7gENWFQ3L1o6ghhIr94cJRy+zFoGXjvRjOWCxqbYzsQO87A5B0xgcWDGLqab
 XY+U8rVkM9o9O0mWtD8daufXXQZn/YA/k86ULZ0MK4nXWbY6ONThliYhf3S8OF5lc1V5+
 g4XHlwZCwh1DexHL+E1iPbKVqXCiopjS+2cpNVVR3kD12EuSdF6xiLCPEY3Ax+FNLD3Bb
 ehmg7cPBev7zLpJupBfuIaqPrfgszhiiFM+uziHTZFzwKIw6Kk27DWVhWHD+GcSp/CP6f
 LGPKrb2amch6n2A4LMLQnGPMBZvLC4Q8qFPvBaaMZsCFEQvL7vI7waKC8bcJS5Fp70Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YapCRhLv; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YapCRhLv
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53BC64032C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:52:22 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48434392b02so3770047f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790697141; x=1791301941;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TU9fsSimN+Oj7sUwPmlFsF8nX89xX2CgzZ5Mh22HhH0=;
 b=YapCRhLvZ1+tiL0BLv9N98JKbu5T095KRuocEX3QuL1VV3qyS130+TM25XCeS1GIfy
 El9iXq9WLAWn7fkISHQXsN3/bnnBRhVhH8aMwzdllErzE+abtFoTg3umce/NxNfgq5Av
 L2eVX+2gfOcGvlhqR/kvCA9XWYb9eGlYKNq3kHdryIhEZQhwer9/4L3+y5We8kj5vnf4
 oKzbIFXlEDuS5q4jtPR3asQ8NKvHcqE0x9bzYIMidwHNgrXYU9UVhTHbUIUX75/85wOO
 5qgSprivY/5pX1qMwHpK9hySXND1qZC9xNuANl/wx6YlP218O9FTmcGJxju3yHrF8XUQ
 wSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697141; x=1791301941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TU9fsSimN+Oj7sUwPmlFsF8nX89xX2CgzZ5Mh22HhH0=;
 b=BwyFOGT6MkN6kltBgQEJBUV/brFGlER3s+tfXI2OMTC2y4NQbcl5eCJM81dO1Gb1QV
 2+WoUK15sZBjPMyieZmBrwUKlnseLnDpRFXXjZxVvbxDvl0dOPud4xg03Xdn7s4lkhAT
 VSfwMtQnuXD8J6OjqBQyXdIZ71psQj5HzSnmTgZJVDxopXrlpm8JRndnxcHnrer0KKeR
 RANxnDipyjuq+3K9ioNb7w7wIkaQ1lm6QfWTY7phQwbrGgm5aoOeNg8ivy5wiCx3DPzV
 yNEOy5r1Sv3bXBQoCFt/z2QLcyyd+nLQX/TGEYBF0iWYnV/AYzvNtcCmgSPVPYFDOiE/
 EL2Q==
X-Gm-Message-State: AFq9FYJfewRiDGqG0n4SgPaihbckdkgpoW/ioO4ELVP29dOmgwRzpl1P
 QL3ARg/kQbuVMzm/AwScB9K+pR2zdG25eroBgv1IWhLiwWBPDqYmID4kPJAR2aE=
X-Gm-Gg: AYBFou39Jmhu3BahwC9Y/fr0cCFcMqJ+6rtmO2jautJBaDP5v37vOjDKaqbqKbkrej/
 BY9PrED2GLy3uoxJCb2LHtYtQuTZVYNwyUEVGJG2OUcPqMuRu1LXIHRnSAZchZDW+weNkL8HZOp
 g9hB3gN8qQ099hEUSyS1vq3nHxqYNyor2sOoFDDT4o4b6/4kK/+k0dyhSRdzMql/IlfL5rZXgad
 u5wZCYCWf3jIJSlTUL1xJ5WdyPDogt68inHNY4vBF7xZW/gi0lWsDeUY2XitK3TGjIIbDkoXg3b
 4VrQNgUeraIDnlMo8+pFKf02nAgMqE/nqgvPdsULg1CbI5XXX6ptlqpPONnLqLEi0JYr2hBc/bT
 SqjJBzht0mAEINF6aYdng4agmy+u2l3ZBWLa/ORcK5eVCcJLNddPKvTf1ynd5e8QmXLX5KsE9Ng
 MDkrN8Xtc+L5l3tXlcosM412S/4bsLLsceTfTwFRmY/sRlwWLqTsLxzHrOzD8c
X-Received: by 2002:a05:6000:420a:b0:48a:f486:2f4b with SMTP id
 ffacd0b85a97d-48af4863380mr4454778f8f.19.1790697140284; 
 Tue, 29 Sep 2026 08:52:20 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af507611csm4716395f8f.22.2026.09.29.08.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:52:19 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Cc: ansuelsmth@gmail.com, mikhail.kshevetskiy@iopsys.eu, sughosh.ganu@arm.com,
 xypron.glpk@gmx.de, Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH v2 1/2] rng: airoha: add support for the Airoha TRNG
Date: Tue, 29 Sep 2026 18:52:14 +0300
Message-ID: <20260929155215.35169-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928224338.505923-1-sochnev.v.74@gmail.com>
References: <20260928224338.505923-1-sochnev.v.74@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Port the Linux driver for the True Random Number Generator found on
Airoha EN7581/AN7581 SoCs to the U-Boot driver model.

The Linux driver waits for an interrupt to learn that the startup
health test finished. U-Boot has no interrupts, so the TRNG interrupt
is kept masked and RST_STARTUP_TEST_DONE is polled instead.

U-Boot can then provide /chosen/kaslr-seed, which KASLR requires.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---

Notes:
    Changes in v2:
    - Drop redundant DM_RNG dependency
    - Sort Kconfig and Makefile entries alphabetically

 drivers/rng/Kconfig      |   7 ++
 drivers/rng/Makefile     |   1 +
 drivers/rng/airoha-rng.c | 136 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/rng/airoha-rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index bacb02630..feca11fc7 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -15,6 +15,13 @@ config SPL_DM_RNG
 
 if DM_RNG
 
+config RNG_AIROHA
+	bool "Airoha True Random Number Generator support"
+	depends on ARCH_AIROHA
+	help
+	  Enable support for the True Random Number Generator (TRNG) found
+	  on Airoha EN7581/AN7581 SoCs.
+
 config RNG_MESON
 	bool "Amlogic Meson Random Number Generator support"
 	depends on ARCH_MESON
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 50622d470..b0650151d 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_$(PHASE_)DM_RNG) += rng-uclass.o
+obj-$(CONFIG_RNG_AIROHA) += airoha-rng.o
 obj-$(CONFIG_RNG_MESON) += meson-rng.o
 obj-$(CONFIG_RNG_MPFS) += mpfs_rng.o
 obj-$(CONFIG_RNG_SANDBOX) += sandbox_rng.o
diff --git a/drivers/rng/airoha-rng.c b/drivers/rng/airoha-rng.c
new file mode 100644
index 000000000..a94161ad2
--- /dev/null
+++ b/drivers/rng/airoha-rng.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Airoha True Random Number Generator driver
+ *
+ * Ported from the Linux driver drivers/char/hw_random/airoha-trng.c
+ *
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <dm.h>
+#include <rng.h>
+#include <dm/device_compat.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <linux/string.h>
+
+#define TRNG_IP_RDY			0x800
+#define   CNT_TRANS			GENMASK(15, 8)
+#define   SAMPLE_RDY			BIT(0)
+#define TRNG_NS_SEK_AND_DAT_EN		0x804
+#define   RNG_EN			BIT(31)
+#define   RAW_DATA_EN			BIT(16)
+#define TRNG_HEALTH_TEST_SW_RST		0x808
+#define   SW_RST			BIT(0) /* Active High */
+#define TRNG_INTR_EN			0x818
+#define   INTR_MASK			BIT(16)
+#define   RST_STARTUP_INITR_EN		BIT(0)
+#define TRNG_HEALTH_TEST_STATUS		0x824
+#define   RST_STARTUP_TEST_DONE		BIT(18)
+#define   RST_STARTUP_AP_TEST_FAIL	BIT(17)
+#define   RST_STARTUP_RC_TEST_FAIL	BIT(16)
+#define   RAW_DATA_VALID		BIT(7)
+#define TRNG_RAW_DATA_OUT		0x828
+
+#define TRNG_CNT_TRANS_VALID		0x80
+#define TRNG_TIMEOUT_US			100000
+
+struct airoha_trng {
+	void __iomem *base;
+};
+
+static int airoha_trng_read(struct udevice *dev, void *data, size_t len)
+{
+	struct airoha_trng *trng = dev_get_priv(dev);
+	u8 *buf = data;
+
+	while (len) {
+		size_t step = min(len, sizeof(u32));
+		u32 status, val;
+		int ret;
+
+		ret = readl_poll_timeout(trng->base + TRNG_HEALTH_TEST_STATUS,
+					 status, status & RAW_DATA_VALID,
+					 TRNG_TIMEOUT_US);
+		if (ret) {
+			dev_err(dev, "Timeout waiting for TRNG RAW Data valid\n");
+			return ret;
+		}
+
+		val = readl(trng->base + TRNG_RAW_DATA_OUT);
+		memcpy(buf, &val, step);
+
+		buf += step;
+		len -= step;
+	}
+
+	return 0;
+}
+
+static int airoha_trng_probe(struct udevice *dev)
+{
+	struct airoha_trng *trng = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	trng->base = dev_read_addr_ptr(dev);
+	if (!trng->base)
+		return -EINVAL;
+
+	/* No interrupts in U-Boot: keep the TRNG one masked and poll instead */
+	val = readl(trng->base + TRNG_INTR_EN);
+	val |= INTR_MASK | RST_STARTUP_INITR_EN;
+	writel(val, trng->base + TRNG_INTR_EN);
+
+	val = readl(trng->base + TRNG_NS_SEK_AND_DAT_EN);
+	val |= RAW_DATA_EN | RNG_EN;
+	writel(val, trng->base + TRNG_NS_SEK_AND_DAT_EN);
+
+	/* Health Test runs only on the transition out of SW Reset */
+	writel(SW_RST, trng->base + TRNG_HEALTH_TEST_SW_RST);
+	writel(0, trng->base + TRNG_HEALTH_TEST_SW_RST);
+
+	ret = readl_poll_timeout(trng->base + TRNG_HEALTH_TEST_STATUS, val,
+				 val & RST_STARTUP_TEST_DONE, TRNG_TIMEOUT_US);
+	if (ret) {
+		dev_err(dev, "Timeout waiting for Health Check\n");
+		return ret;
+	}
+
+	if (val & (RST_STARTUP_AP_TEST_FAIL | RST_STARTUP_RC_TEST_FAIL)) {
+		dev_err(dev, "Health Check fail: %s test fail\n",
+			val & RST_STARTUP_AP_TEST_FAIL ? "AP" : "RC");
+		return -EIO;
+	}
+
+	ret = readl_poll_timeout(trng->base + TRNG_IP_RDY, val,
+				 val & SAMPLE_RDY &&
+				 FIELD_GET(CNT_TRANS, val) == TRNG_CNT_TRANS_VALID,
+				 TRNG_TIMEOUT_US);
+	if (ret) {
+		dev_err(dev, "Timeout waiting for IP ready\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dm_rng_ops airoha_trng_ops = {
+	.read = airoha_trng_read,
+};
+
+static const struct udevice_id airoha_trng_match[] = {
+	{ .compatible = "airoha,en7581-trng" },
+	{ }
+};
+
+U_BOOT_DRIVER(airoha_trng) = {
+	.name = "airoha-trng",
+	.id = UCLASS_RNG,
+	.of_match = airoha_trng_match,
+	.ops = &airoha_trng_ops,
+	.probe = airoha_trng_probe,
+	.priv_auto = sizeof(struct airoha_trng),
+};

base-commit: f61f50a79dab97c8a4109ee9c15b90bf6157d4e8
-- 
2.55.0

