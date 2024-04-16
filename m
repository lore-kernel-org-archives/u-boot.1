Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B13C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBC58842C;
	Tue, 16 Apr 2024 14:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gqua/YdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E36788300; Tue, 16 Apr 2024 09:53:18 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9AAB881CE
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c70964374bso1114867b6e.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713253994; x=1713858794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HFM3id9jsN+n7e1uUOAIVx+J1XRQ0TPRsTOnndXon8=;
 b=gqua/YdUOS22b4/DpIDWM/pIv75wEPjgChyFvKopaZfGs+2nDX7bUL7Q7eql4mNlvR
 QlUpXzkYSK0FeEBi5C0N5xi2jLcTt61cYL0c7dDGKWLxfzTy/eDieJ6942NrV5wu45HC
 Ymqlx2XberZY/zevM23Icbvixl5AabBIH7fBr5j+zowuhHpaXVQm0VPX3wh9ZH5a8pdo
 rdR3ndd7AeuyLSRJiGkXSUzTuyztETIIJMczrkag+A5MJvVQ9Ei44MUmqsS+wx83qsGH
 EUN99ePaTvCC2Q/n/G8KCIiHi1oh6KC8VPnn0ETZswAJh9jHGnwxLJhRWjrrBBEV1pU8
 YumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713253994; x=1713858794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HFM3id9jsN+n7e1uUOAIVx+J1XRQ0TPRsTOnndXon8=;
 b=NXZ6GgInWTrJR2ghmSOaJcx/sPvikntSCtYwRC0ZasA5cJwb97/R/szuB2qKdeKGnU
 4lG9N2BFxRS5mRfLtDFDGsqSxS1oHd59KenQZWaFJDJsaoDZVJT9dOAGysTPg00JDukX
 knxBe7JfxU/QYWYH+/68Nxavs+g8lzOcRf2v1HG2l9dTU1VqzIHZrMOvRYjxogjZ193G
 jVx5dlA5ms9UZ/gb5TOli9MD9OObjXzJUjFQkmsvvh4+7PrsVcUtQQPWsmdQwhFHi5Vb
 fYQHrWTfNd9F8eDmb+SzNV9r7R4ZzbDC6eiylUnmedHk/S2H39OTjapgOJD5eVvCsc1g
 /Wig==
X-Gm-Message-State: AOJu0YzxSK5zdl3ULQnRx7kkI8DzGAc3tU+3zcfHQqDjQHmqRRTTWwxb
 QCXnVoAXhiDvux7SPapC8yszdkoND4itJY1lGQKHCvp4P7joPfzADAceCYMUUVGzjQ==
X-Google-Smtp-Source: AGHT+IEKd45W1xLVHaheGBaZXIxGf6kg/TZpliTpA0/LaJM17ZONtxTSDY3XGJ4rnxkt+VVvG/6xdQ==
X-Received: by 2002:a54:4891:0:b0:3c6:f4d0:3329 with SMTP id
 r17-20020a544891000000b003c6f4d03329mr12051553oic.13.1713253993893; 
 Tue, 16 Apr 2024 00:53:13 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a056a0000cc00b006ed2709ada6sm8391681pfj.65.2024.04.16.00.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 00:53:13 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] sysreset: cv1800b: Add sysreset driver for cv1800b SoC
Date: Tue, 16 Apr 2024 15:52:38 +0800
Message-ID: <20240416075254.13729-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416075254.13729-1-seashell11234455@gmail.com>
References: <20240416075254.13729-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Apr 2024 14:51:12 +0200
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

Add sysreset driver for cv1800b SoC

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

 drivers/sysreset/Kconfig            |  5 +++
 drivers/sysreset/Makefile           |  1 +
 drivers/sysreset/sysreset_cv1800b.c | 64 +++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_cv1800b.c

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 49c0787b26..b64bfadb20 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -59,6 +59,11 @@ config SYSRESET_CMD_POWEROFF
 
 endif
 
+config SYSRESET_CV1800B
+	bool "Enable support for Sophgo cv1800b System Reset"
+	help
+	  Enable system reset support for Sophgo cv1800b SoC.
+
 config POWEROFF_GPIO
 	bool "Enable support for GPIO poweroff driver"
 	depends on DM_GPIO
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index e0e732205d..d59299aa31 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_ASPEED) += sysreset_ast.o
 obj-$(CONFIG_ARCH_ROCKCHIP) += sysreset_rockchip.o
 obj-$(CONFIG_ARCH_STI) += sysreset_sti.o
 obj-$(CONFIG_SANDBOX) += sysreset_sandbox.o
+obj-$(CONFIG_SYSRESET_CV1800B) += sysreset_cv1800b.o
 obj-$(CONFIG_POWEROFF_GPIO) += poweroff_gpio.o
 obj-$(CONFIG_SYSRESET_GPIO) += sysreset_gpio.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_MAX77663) += sysreset_max77663.o
diff --git a/drivers/sysreset/sysreset_cv1800b.c b/drivers/sysreset/sysreset_cv1800b.c
new file mode 100644
index 0000000000..9cd62772ef
--- /dev/null
+++ b/drivers/sysreset/sysreset_cv1800b.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <dm.h>
+#include <stdbool.h>
+#include <sysreset.h>
+#include <wait_bit.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+
+#define REG_RTC_BASE             (void *)0x05026000
+#define REG_RTC_CTRL_BASE        (void *)0x05025000
+#define REG_RTC_EN_SHDN_REQ      (REG_RTC_BASE + 0xc0)
+#define REG_RTC_EN_PWR_CYC_REQ   (REG_RTC_BASE + 0xc8)
+#define REG_RTC_EN_WARM_RST_REQ  (REG_RTC_BASE + 0xcc)
+#define REG_RTC_CTRL_UNLOCKKEY   (REG_RTC_CTRL_BASE + 0x4)
+#define REG_RTC_CTRL             (REG_RTC_CTRL_BASE + 0x8)
+
+#define CTRL_UNLOCKKEY_MAGIC     0xAB18
+
+/* REG_RTC_CTRL */
+#define BIT_REQ_SHDN       BIT(0)
+#define BIT_REQ_PWR_CYC    BIT(3)
+#define BIT_REQ_WARM_RST   BIT(4)
+
+static struct {
+	void *pre_req_reg;
+	u32 req_bit;
+} reset_info[SYSRESET_COUNT] = {
+	[SYSRESET_WARM]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
+	[SYSRESET_COLD]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
+	[SYSRESET_POWER]     = { REG_RTC_EN_PWR_CYC_REQ, BIT_REQ_PWR_CYC },
+	[SYSRESET_POWER_OFF] = { REG_RTC_EN_SHDN_REQ, BIT_REQ_SHDN },
+};
+
+static int cv1800b_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	u32 reg;
+
+	writel(1, reset_info[type].pre_req_reg);
+	writel(CTRL_UNLOCKKEY_MAGIC, REG_RTC_CTRL_UNLOCKKEY);
+	reg = readl(REG_RTC_CTRL);
+	writel(0xFFFF0800 | reset_info[type].req_bit, REG_RTC_CTRL);
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops cv1800b_sysreset = {
+	.request = cv1800b_sysreset_request,
+};
+
+static const struct udevice_id cv1800b_sysreset_ids[] = {
+	{ .compatible = "sophgo,cv1800b-sysreset", },
+	{},
+};
+
+U_BOOT_DRIVER(sysreset_cv1800b) = {
+	.name = "cv1800b_sysreset",
+	.id	  = UCLASS_SYSRESET,
+	.ops  = &cv1800b_sysreset,
+	.of_match = cv1800b_sysreset_ids
+};
-- 
2.41.0

