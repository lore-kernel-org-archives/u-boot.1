Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5796C61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCE6980CDC;
	Tue, 25 Aug 2026 16:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWz_YndCM3u8; Tue, 25 Aug 2026 16:43:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676193;
	bh=4Hsmhn5v/OAYGs58trbWezHVKOFmficfh/+7c3IF7NA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WfhArKlCvPrUEiiGBWVFdrUkvXevjvXayxTHHu+S23mQJwo/Z85hpOooEEQrW2LBH
	 M6sYLJzv4+uDYG5QTwMED5NufseDCIWev+li07mTXz7uKmja/wdJYoNB3W9RyD2vGJ
	 6RnVcYA67Ebo2zA/5+oNOyUw8XayuI05kJkmxr7j7ZTTfZAbvz2mSpUxSkuVa5moZ9
	 TOakXKn7vaA8Qrs8nhgG0C9ues+HQ8sZXyHb/TSNTRP8NP0FhFT3sIkf9YVZdaaRZl
	 WLakPfNR6qT5m4rZsVTIfbpXRkXAcU04wp6m+MHtvaMW33GPypviZi8nYEB4ZgMfvE
	 TXyNzVIZbJSlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C132780C67;
	Tue, 25 Aug 2026 16:43:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3834C3DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F26460703
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UmHXBnGaP8xq for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:43:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=NY9udD8l
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCE68606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:43:09 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-80bb41f7f3cso46610697b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787676188; x=1788280988;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4Hsmhn5v/OAYGs58trbWezHVKOFmficfh/+7c3IF7NA=;
 b=NY9udD8lhbYDdeN4GkOZSJtj4SNF5x1NkCIvyEtjxiw8EFzgmfTYjTghpo955SndDE
 W7pR6JcBegRJTCzXcxMF9Ko5c1JO0hcjfyXDT4qPT3MWlrnpKXqU2BADhKwWoP08hHF7
 KWgoROR2vXnAMfqVbEgHvM8BUQ2rsyZznw5R9q6/0VYXPFREHG927Pfx6p6Y8lfARzfJ
 DTnlk13EShs/1HfEEP9m+N7TApQXHAy+Gfs72x1sbcKNH2rcXXrngoAaMNOpajE24GAv
 aqoZqnQzey6Mnjksjl1Mrk+/Ge6NxCnpC1MEcEH0qS792wZvjv92ud+b1eeHOFl0jfpY
 2cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787676188; x=1788280988;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4Hsmhn5v/OAYGs58trbWezHVKOFmficfh/+7c3IF7NA=;
 b=ZR1CTbK87pR+q7iAL7fKcYOUY8lbsZ8qN0ZrkHNBNm8j+kPJpq1XqYT7ghNG2fadu2
 fZbskOawcTraFsrpO3Y5XrcakAmTz8qRrg/WYdAP9829W9WFYg+1Qtl8c++STgp0/Erb
 TxUQ9uk5t3E0wfJx+1/xmqOhSMguLp8Lqdpw4yQ565flUq+sCSSbcCK+lxRfnuMuWAaP
 5v/wlJHSjnQnSA88F8nAa7BXspjx8tM5oSpmstKZt0QqFKXnSL+Fv/JP3MquUXNMp4on
 ehflw5pDMiX9xSAMBU2CbHK2puF9zEtmhnaUyvTALDcRYdV3kGcGr51Uv4vlrpEmf5+v
 c0sQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqVnkys+EMp56UvLZJ+2EkUfFcYmgasYGzmRSgg3rkw9JNVa0sc2f0aJ5fGygd2iU+NYcosyA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++licjJlpBlucGyj0A1KNmAZjQZ/vdRbevr9aPT/5FXBR7aIs4Md
 3H+DaISRBGCCPBZ/c2g0JZzvGUHhGWFSGu5rbLSKedUbfrJGrFcAmr6pkD3LEqV1L9c=
X-Gm-Gg: AR+sD136DfInT2lUzv4O5YHl6w6TzsoJOMxLRb/JrsCEmGESxEpPd3EWKViCY79pBSw
 h4w0RFUZjvKQSWftfDE4bl8MB+T8iV0c1oGX6/kdtI0AYaEgA/+Q7aZBBbXbkX3jEYIcOpVL4lf
 WTARh9KSfv8t2zj8WKKG643u6p3hAAbpgSt+qCxs6OVNnnVjzK83uVpwtuTYS5hT3sV1q5sEiuW
 G/uIH96i+2oBfvvIjXU/OJDOiae/0lwEq1NcvgZ5UQh0KdT+ya0XPy7tB6585pJoT2Qv0HoEj9D
 Kk5eX3frH+cTdenZelpqlfQytxDd0ZsWlMB8FOg+PRTitNPGtnVyC8Rvl738SzYZR29bSLDjhMi
 +ueyisIyHJJPtKAMFg1kpQwqDO3ScXqJl/fOYTY2+VofV303I1fz776jzzFW4q/A9fgc8Z66IYw
 9i56Ar6nWMr/IFlpjvpAoAWM2ijuy2fkcbG1sK7ilLDNrtZVgGA7f8xLZo+WXBmhmUSYGeSkpP7
 nmEWgb8i9o5Ye9PUvPJQOL/olBQfdMEYdA4Wtc=
X-Received: by 2002:a05:690c:e142:10b0:81f:b410:b214 with SMTP id
 00721157ae682-85740e6b0c5mr430887b3.27.1787676183299; 
 Tue, 25 Aug 2026 09:43:03 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85705f3549csm2756377b3.13.2026.08.25.09.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 09:43:02 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 25 Aug 2026 11:42:46 -0500
Subject: [PATCH v2] iommu: Add RISC-V IOMMU driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
X-B4-Tracking: v=1; b=H4sIAAXGjWoC/22NQQ6CMBBFr0JmbQktBMSV9zDEQJnKmNCaTmk0h
 LtLcevyJe+/vwKjJ2S4ZCt4jMTk7A7qlIGeevtAQePOoApVF+eiFJ5Yxzu5eV5E3TY4VgbNWEr
 YFy+Pht5H7db9mJfhiTqkRDIm4uD857iLMnn/y1EKKZq21KavlOwHdXXMeUCb5h5tyLWbodu27
 QszAXGywgAAAA==
X-Change-ID: 20260803-riscv_iommu-697ed4fefd31
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
specification. This driver sets up the IOMMU in bare mode so that
peripherals requiring DMA in U-Boot can function.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Changes in v2:
- Changed DDTP read timeout to 3s from 10s
- Link to v1: https://patch.msgid.link/20260803-riscv_iommu-v1-1-793cfa421ab2@oss.tenstorrent.com
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
index 00000000000..ad5ee7c5088
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
+#define RISCV_IOMMU_DDTP_TIMEOUT          30000000
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

