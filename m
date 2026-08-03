Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EFCC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA2DC405AA;
	Mon,  3 Aug 2026 20:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0aspfQzlPthE; Mon,  3 Aug 2026 20:06:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC4D340517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785787603;
	bh=lU8nt4RFl2Dpk64V4xLN5k1pL5y450SH1BKE9rbJwA0=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=CFtHUG5gMbBelosMMcA9DlNDuj8/41yRrYGA4W9UTx3B/0PXYVlZC2DzIb3C9c822
	 1Gz5JA02Fsq9eBiQoEe77RT7f9Wz10cKFELF3sGEOMbVRVB78/2r/LfdHfgXStvRe0
	 RvIeD8OK0kJz6982gjqWiCxtuy+SZJq82rHjfT3pMDDaFzSNT8ALG2mxTHG9vTNZGx
	 tELbExYmE2Lc3e5AhjGX3hCXP6ZeyCirhu9fqhSgDWQMI3BwLWnJdNZoo++xkp3224
	 nFJ45GYvRaNpqhU1YjGCzJYKB4FiBK2cQk+m/OclxtzVU1SIEl16apE+bgR+mqYoTY
	 C9a4BEOct7sSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC4D340517;
	Mon,  3 Aug 2026 20:06:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65B9E296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4768A40193
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KKmB_7SYZf5W for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:06:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 519434015C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 519434015C
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 519434015C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:06:40 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso2496833a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 13:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785787599; x=1786392399;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lU8nt4RFl2Dpk64V4xLN5k1pL5y450SH1BKE9rbJwA0=;
 b=OyV55z4zXIj9x1cJ8ygkz3ijE2lBTtQ6464phf1mh9FLRQmggw2TFX1icOj2x8kwo1
 K6YOFaUP9ZEniDR9jKuDH/pgvf6t5FWZbyUgBFtzynP9dw3YxZi+HXXKS7p1FAlDtoia
 e09zN0da4zt5B0gRm/csq/LbHGMVHh31jsAsU/M1fdAZqov54kWjYr6SL0/946ue6JQR
 xj6+gcsHOPril/S+cse+7WFUulbW0EjAC1bIq/eZ47ouw4KDvSi1ZEwcgFwjUPNZFepi
 liRejxWQyIWS8k925eDXwHr+faXLo2Th7lGGyHfAD0d3J0rQ2pyVHSGQng3w++7w5BIM
 SBVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJjHeKyOs/uDQ/hrYRIehIM6oCZ6HZehBZlngm+e0+OjpcHdxuiCmTZ5urXF6Pyl0W114Lt+0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyO0AiZlHK1WSf9Wop1R4EaDSTp5HByyEyMVdlb/ZGHHT1nv8qY
 ZWFpHhDxFIi/63y2XBIJqv/GRk0l0l3J9xZkOMr9vAZiSUJP09adTMyAiOGZ3NWc7t0=
X-Gm-Gg: AR+sD13PAY0gRK9oqkEh1j+7MuSv6+VoqWczmxYM2/YtzIJCLNs33GbUkeh7mbVOP3T
 hHYvqm/CXpJ1rzMDOllelEZI5pfrytisHlUj0LAJQSV458FMYFySJXt74MWq5BHtJglT4FClert
 1d4Rem8t/tPb1jLlyV1/tVg2XIdOx0kxnAl67drYvPXxj4v+9ndjxT6TPsX2n6tZmsbiZxYxS8q
 /ess9L15B8lyvJE3szxEGzWm4tdDHTb/YytqqcnGNq5hKuF6VV17dgU1/9FoqpAGizZQdQ7rnGm
 9mHFbYOnwv36BOf5NOd0Y+E2gUw7+ENGV84ee4LTivHVzpBKpcOm00y8u+oOO/BIO/Oowj8gc04
 KH1Ys5mpsEZDTx+Up3B60QIxYSx2TOOuTu2oBpRIELRWdC0O60mP26gSW91tuRe95gMx8MlM57d
 pULUJHWhboiEzaPLHmTxVTlcBtQzhqniOqXHFe7emjACgSo0IF+xabVLBqpd8kcYkVVtkoWVq8C
 xb3oKzIa/GDUNPXEnZOwBciRxn1m0TqZ9qG2Cw=
X-Received: by 2002:a05:6830:6515:b0:7e3:d199:3164 with SMTP id
 46e09a7af769-7f196d8254bmr20717477a34.11.1785787599069; 
 Mon, 03 Aug 2026 13:06:39 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18f07a55asm8302029a34.13.2026.08.03.13.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 13:06:38 -0700 (PDT)
Date: Mon, 03 Aug 2026 15:06:12 -0500
Subject: [PATCH] iommu: Add RISC-V IOMMU driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-riscv_iommu-v1-1-793cfa421ab2@oss.tenstorrent.com>
X-B4-Tracking: v=1; b=H4sIALP0cGoC/yXMSQqAMAxA0atI1hbqgNNVRETbVCM40GgRxLtbd
 fkW/1/AaAkZquACi46Y1sUjCgNQY7cMKEh7QyzjTBYyEZZYuZbWeT5EVuaoU4NGJxH4YrNo6Px
 udfObj35Ctb8LuO8HvGODGW8AAAA=
X-Change-ID: 20260803-riscv_iommu-697ed4fefd31
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1785787599; x=1786392399;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lU8nt4RFl2Dpk64V4xLN5k1pL5y450SH1BKE9rbJwA0=;
 b=g9RLB5zk312Q8hxDLcifdgytRfL0xQuCOhkTprxjeJUUy7IOE8myequ32aZhlOxh+x
 583/ljeaQoN4Ydd3u3Y/bqlvh5FYkumVlkxklutVsmjmBcmhPS84DReXf9UfgJXv+8Li
 HRZsZ7+1EsBcAAWjCaL0MYaNdotKbV4TWS+RFJXlhffHkwBHu2R2EpCSfHeRDem19tSi
 BHQHpFE4ilaKC7xhOwXjERkFosZMR4UNUlfrrxwsyADgBlOBbEdE3NZimCWQQFT7RtRl
 WXm0XW2xq4IwQg0FchZXZtLDgnpDtbjsrwVTSrErQ/NvVxkbFcHWQsnHL1X9Y8Elhjf2
 kIHQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=g9RLB5zk
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
From: Anirudh Srinivasan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
specification. This driver sets up the IOMMU in bare mode so that
peripherals requiring DMA in U-Boot can function.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Hi,

This is a pre-requisite for U-Boot on Tenstorrent Atlantis. On this
platform, the IOMMU comes up in Off mode at boot, so this is needed for
SD and NVME boot to work in U-Boot.
---
 MAINTAINERS                 |  1 +
 drivers/iommu/Kconfig       |  8 +++++
 drivers/iommu/Makefile      |  1 +
 drivers/iommu/riscv_iommu.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 289a45f47bb..a7b9e78cd79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1583,6 +1583,7 @@ F:	arch/riscv/
 F:	cmd/riscv/
 F:	doc/arch/riscv.rst
 F:	doc/usage/sbi.rst
+F:	drivers/iommu/riscv_iommu.c
 F:	drivers/sysreset/sysreset_sbi.c
 F:	drivers/timer/andes_plmt_timer.c
 F:	drivers/timer/riscv_aclint_timer.c
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 2ba6d9c1362..24cfd823c0a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -40,4 +40,12 @@ config QCOM_HYP_SMMU
 	  Say Y here to enable support for non-boot peripherals like USB by
 	  configuring identity mapped streams for them.
 
+config RISCV_IOMMU
+	bool "RISC-V IOMMU support"
+	depends on IOMMU && RISCV && 64BIT
+	help
+	  Enable support for the RISC-V IOMMU. This driver configures the IOMMU
+	  in Bare mode so that devices requiring DMA in U-Boot can work
+	  without additional configuration.
+
 endmenu
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 438cab8a7c4..caad566694a 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_IOMMU) += iommu-uclass.o
 obj-$(CONFIG_APPLE_DART) += apple_dart.o
 obj-$(CONFIG_SANDBOX) += sandbox_iommu.o
 obj-$(CONFIG_QCOM_HYP_SMMU) += qcom-hyp-smmu.o
+obj-$(CONFIG_RISCV_IOMMU) += riscv_iommu.o
diff --git a/drivers/iommu/riscv_iommu.c b/drivers/iommu/riscv_iommu.c
new file mode 100644
index 00000000000..9e41a397250
--- /dev/null
+++ b/drivers/iommu/riscv_iommu.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Tenstorrent
+ */
+
+#include <dm.h>
+#include <iommu.h>
+
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+
+#define RISCV_IOMMU_REG_DDTP              0x10
+#define RISCV_IOMMU_DDTP_BUSY             BIT_ULL(4)
+#define RISCV_IOMMU_DDTP_TIMEOUT          10000000
+#define RISCV_IOMMU_DDTP_IOMMU_MODE_MASK  GENMASK_ULL(3, 0)
+#define RISCV_IOMMU_DDTP_IOMMU_MODE_OFF   0
+#define RISCV_IOMMU_DDTP_IOMMU_MODE_BARE  1
+
+static int riscv_iommu_probe(struct udevice *dev)
+{
+	void *base;
+	int ret;
+	u64 val;
+
+	base = dev_read_addr_ptr(dev);
+	if (!base)
+		return -EINVAL;
+
+	/* Read DDTP and check if busy bit is cleared */
+	ret = readq_poll_timeout(base + RISCV_IOMMU_REG_DDTP, val,
+				 !(val & RISCV_IOMMU_DDTP_BUSY),
+				 RISCV_IOMMU_DDTP_TIMEOUT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Transitions to Bare mode from any mode other
+	 * than Off are undefined. Skip writing the register
+	 * when already in Bare mode.
+	 */
+	switch (val & RISCV_IOMMU_DDTP_IOMMU_MODE_MASK) {
+	case RISCV_IOMMU_DDTP_IOMMU_MODE_OFF:
+		break;
+	case RISCV_IOMMU_DDTP_IOMMU_MODE_BARE:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	/* Enable Bare Mode */
+	val &= ~RISCV_IOMMU_DDTP_IOMMU_MODE_MASK;
+	val |= RISCV_IOMMU_DDTP_IOMMU_MODE_BARE;
+	writeq(val, base + RISCV_IOMMU_REG_DDTP);
+
+	/* Read DDTP to check if write was accepted */
+	ret = readq_poll_timeout(base + RISCV_IOMMU_REG_DDTP, val,
+				 !(val & RISCV_IOMMU_DDTP_BUSY),
+				 RISCV_IOMMU_DDTP_TIMEOUT);
+	if (ret)
+		return ret;
+
+	/* Check if DDTP value is Bare */
+	if ((val & RISCV_IOMMU_DDTP_IOMMU_MODE_MASK) !=
+	    RISCV_IOMMU_DDTP_IOMMU_MODE_BARE)
+		return -EIO;
+
+	return 0;
+}
+
+static const struct udevice_id riscv_iommu_ids[] = {
+	{ .compatible = "riscv,iommu" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(riscv_iommu) = {
+	.name = "riscv_iommu",
+	.id = UCLASS_IOMMU,
+	.of_match = riscv_iommu_ids,
+	.probe = riscv_iommu_probe,
+	.flags	= DM_FLAG_VITAL,
+};

---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260803-riscv_iommu-697ed4fefd31

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

