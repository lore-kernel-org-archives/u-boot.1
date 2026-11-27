Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2087B606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uVwpey4C;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DFlU9uXP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD7EA60615;
	Fri, 27 Nov 2026 19:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xdn3h4JZ4UtD; Fri, 27 Nov 2026 19:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8196460698
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795808917;
	b=Fe/7G+wJYANmSOc8j/F9blsXUyKIK0aR2vAMyRBvzES3qwYFRwU+pIHftSCXO2XXgqVH
	 RwOALBOxxBLiKrjq5d6hcZXIE8TorHgSc6iy/yAB10Vw/gjhuOm0yFnzzkiHfwev8wzCF
	 7JBMQsIuN+uKTQT2nSFyMBe7sW0cERu6wiNhwxUW2YPRF8DKnWRnBKG5sWDZbkC8rQGHk
	 rwLzWqI5AWBTYvr0O7OlbjZsZjuee2bWEcWpblxjJL8XVwA9u1i+EO5Rxkke6zX2RNvA1
	 BHbWZwwMtKnpFCgaNkVR0Uw0sdkbM3d7H872OoultzchDCgjd0BOyBR3ii9frarUIxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795808917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dStE44iOFMhnH2bGEMeSX0SyvLldD9Bwz9mT4sezcYc=;
	b=TgNdJfqgxzrEB+8MgRkLhiE9B/2HSV/vH4Sy0B19bkkGHToltZfHvy+9/6H4hQdCHZzo
	 XyD1cREtY7A7eNmdgvM/m+oBycS9c4RM2y0sd1uFRJF7K7g/qORTPoWURwOkKDQA5LP4W
	 iDIKVOvu5H4oN8scP3Xo+J1brCn6fYy3zB40jYYrxrIFnZzZYRWNY+flbt3PAWWJC3H3a
	 Wh56MZR75DIRhFx6icoQ+Zj9EHQOci5w+2yp+jjR4F0YMK0fJuijvtP7j89k6Xcmh8Qzu
	 o07ESpKsfJRBB+848TulMl0E6N8Bd46norM7ZlUAB5SSYH0/7hWuR7NvT/owCostOIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795808917;
	bh=dStE44iOFMhnH2bGEMeSX0SyvLldD9Bwz9mT4sezcYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uVwpey4CuXoKtz8uf0hNwji/yiDC/6vDJ+8S0vU5A2UVq6lcsOkm3WjEoReVQa5or
	 pV/wWGDDq6kgCiC9vYlER7VwyfKFC85Ci+FvcYyDIX6ivvYgVdid14dTfZGO9FygOI
	 lZcuqdnTaz0Mvhosrb1fJgaoidVGHmK8nJ/EmGhRuAIK5yeMT7e+RfYwYvv5zv61PZ
	 4C1YDkVKcr+VacqOK4YOqMCSwcoKcFTf5Xf6hCl5TZ8baVQALjshnu23HwCObnKLea
	 2w1wjS2gBCtpLZLl9PAWqHpUzeWzZHXa54Ijcbv4atNX/DQE5KHMNWuKrlXoTxZ355
	 IBmwkJCr2gRcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8196460698;
	Fri, 27 Nov 2026 19:48:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0D5B49D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE63040D35
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PkRvHmnO20G1 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:48:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B5B240D09
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=nathbappai@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=DFlU9uXP
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B5B240D09
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:48:35 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-3282db206d3so6324421eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795808914; x=1796413714;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dStE44iOFMhnH2bGEMeSX0SyvLldD9Bwz9mT4sezcYc=;
 b=DFlU9uXPdBkE9VEVaG3ESizS3eda03JIEAaZxH1hId/ZRGbzrZ6yvDumgdNKLn3WzJ
 jjHw4vOMGo9tUNNUjjAz9lN9RfVsoVgmFfMSsbQgOo7fj4rZx7ady5v/zP/JvXk2Po8K
 pVBu1vpB0QcqC4fVGja4fa4L5DzOBw48dwwPttK2MVHrkI5B+Wcn0h7cpb9mRy6XgE6Y
 IMmJRgzWGUTiKwPSWQAQ0iyAx2GrEr7WPe0Fh59X8Ht9kagZ15yrh3P2pkP8M6VyL12V
 7c+KFJCRSm7SQhP6iv2aGjakQN8OeZm1gvFOcPzkYIQ1L+FuFPS+9tC3EOh/2E1QM8wB
 DMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808914; x=1796413714;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dStE44iOFMhnH2bGEMeSX0SyvLldD9Bwz9mT4sezcYc=;
 b=DMTP8K1Tm1gGgfkol5uA0h+cZ+q+IUrxbgS1t1NS2lGMvABavTx13sdocudLfO6CVg
 atns0u8OW6Kd1pCjkbXqyEM3NDT2+WkSfZSoN/7fDChvLWiURr2yzM22nfpPvL+18360
 UN1VYQhTkcJE24hGStOu1cRbyTANUFOJ6jaoF8uahptQMM0+Sh8ME7Qm8zQ2q1szwjAv
 u9iGwhb22aitgvTfykUdDo520ZP6qroUn1y2ZAlUD2DohFdPjtJXoDc4sLQNwXl+awXy
 TL4kr4Au9jeAYgiHQC8QNSvvxCRKPWYlRu/vHYrAqAWZAp4uAj6NUlVSm2ubESwzbdKt
 eYSA==
X-Forwarded-Encrypted: i=1;
 AL+hErEkasmxbCacGTHN3VHs1CT5040txrx4/F64nrGpvLZ0SAaXIbpJXYtNcLHN7T7u5RqbbAhqp7o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z++N7HbNb2UtyXtp2AToTMv8ViQXFsGt/rl6AgRXf8CA2w7KWcE
 gxvbPUd6Acnx7T1dLfa9GGkODkk2wo2lZbucM1WxGtAaM29bpNV89Laj
X-Gm-Gg: AZFdTZe17LANOVrV0nGnWsQayDeuqrpmwiChqTt2b+6j2DypqGAiZAf2B6CoWhZjB1a
 Ig+NN1J/mMxmhH0YSWwYCK3LSA3g/0+hba+W9DMrWdz6iFEpovhLjbyYnhgv1vw2tfJHFv6HLOn
 nYGwYXs4Y/6xX4QWANuWff2aOPSZFHAynQr6Y2vlJ4QsKxfwVqDuRwJ/+Fu6ybctnXWmZJP7FfD
 XoUWmyu65GD4gxYYty/3+E9sma1ptyv7j6UgzpiGTtTD2RZY9JDGrpKUy8XUJlzhAO75pnFyU9K
 ddIOSVpzODfxUXBc6gAyDDgLZspbzR9J0+Fc8so1r/a7wC3VjiArY9eUhPIHCj6XCNIEKQqdoUu
 KiLTTd06H+7Z/XwwQjjsWPAf39aLwdoWx6Tx+4Tmi4DfPIdYwWSAI2X1ub6cfcL1Xh7oQRID3Fp
 JAojB1U9MafT2ZJGF4AwCCTt+n5IIrycVocWmD+SjPcElJlQnlcYtResY29wzXFqOk6NIXegj7c
 Hn8kF7mq3fMcWIBHRqtn4FoGwzjSKUNsJwwwU20smzv2+S8JULJeEqxCVTpQfiVeW5J3lOxyB07
 mevLwzapY2i4r765+LGn4/o9Qgs0nvm8WOI=
X-Received: by 2002:a05:7300:7f21:b0:386:9a67:3be with SMTP id
 5a478bee46e88-3869a670d85mr22415602eec.23.1795808913888; 
 Fri, 27 Nov 2026 11:48:33 -0800 (PST)
Received: from [192.168.0.102] ([103.94.107.232])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm84893422eec.26.2026.11.27.11.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:48:33 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Fri, 27 Nov 2026 19:48:14 +0000
Subject: [PATCH 1/2] power: regulator: add Qualcomm RPM regulator driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-qcom-rpm-regulator-v1-1-c150ea719275@gmail.com>
References: <20261127-qcom-rpm-regulator-v1-0-c150ea719275@gmail.com>
In-Reply-To: <20261127-qcom-rpm-regulator-v1-0-c150ea719275@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Johan Jonker <jbx6244@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795808901; l=18966;
 i=nathbappai@gmail.com; s=20260718; h=from:subject:message-id;
 bh=givnYkHOi7tUBcclYMBhPIp/+1IIb4EcECi3rRhNH/Y=;
 b=VXkNXRwAi2nsMfThj1m7SrWxESTOa3rqEliyBhRMFz384bahk32+Fi1MFStrYrtly6ft/ftGH
 shdcZVCiX9WAzPsQbp8BEKh8IO15swXXDfO2GecqgKnUZaoDHVKVy6E
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=ATtK28d7wNTkFPtwgWLEaJ1T7ikcnGabljPw7CKsQ0Q=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a regulator driver for Qualcomm SoCs using GLINK RPM transport.
This helps to enable regulators which are disabled from reboot.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 drivers/power/regulator/Kconfig              |   9 +
 drivers/power/regulator/Makefile             |   1 +
 drivers/power/regulator/qcom_smd-regulator.c | 439 +++++++++++++++++++++++++++
 include/soc/qcom/smd-rpm.h                   |  45 +++
 4 files changed, 494 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index dbd24415cb5a..79c4653da9bf 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -274,6 +274,15 @@ config DM_REGULATOR_QCOM_RPMH
 	  implements get/set api for a limited set of regulators used
 	  by u-boot.
 
+config DM_REGULATOR_QCOM_SMD_RPM
+	bool "Enable driver model for Qualcomm SMD based RPM regulator"
+	depends on DM_REGULATOR && QCOM_SMD_RPM
+	help
+	  Enable support for the regulators exposed by the Resource Power
+	  Manager found in Qualcomm 8974 based devices. The driver
+	  implements get/set api for a limited set of regulators used
+	  by u-boot.
+
 config DM_REGULATOR_QCOM_USB_VBUS
 	bool "Enable driver model for Qualcomm USB vbus regulator"
 	depends on DM_REGULATOR && DM_PMIC
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index bfe3349e3e5d..e8709f23fc10 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_$(PHASE_)DM_REGULATOR_COMMON) += regulator_common.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_FIXED) += fixed.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
+obj-$(CONFIG_DM_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
 obj-$(CONFIG_DM_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus_regulator.o
 obj-$(CONFIG_$(PHASE_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
diff --git a/drivers/power/regulator/qcom_smd-regulator.c b/drivers/power/regulator/qcom_smd-regulator.c
new file mode 100644
index 000000000000..8047b9b3dd0e
--- /dev/null
+++ b/drivers/power/regulator/qcom_smd-regulator.c
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015, Sony Mobile Communications AB.
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <power/regulator.h>
+#include <soc/qcom/smd-rpm.h>
+
+/**
+ * struct linear_range - table of selector - value pairs
+ *
+ * Define a lookup-table for range of values. Intended to help when looking
+ * for a register value matching certaing physical measure (like voltage).
+ * Usable when increment of one in register always results a constant increment
+ * of the physical measure (like voltage).
+ *
+ * @min:  Lowest value in range
+ * @min_sel: Lowest selector for range
+ * @max_sel: Highest selector for range
+ * @step: Value step size
+ */
+struct linear_range {
+	unsigned int min;
+	unsigned int min_sel;
+	unsigned int max_sel;
+	unsigned int step;
+};
+
+#define LINEAR_RANGE(_min, _min_sel, _max_sel, _step)		\
+	{							\
+		.min = _min,					\
+		.min_sel = _min_sel,				\
+		.max_sel = _max_sel,				\
+		.step = _step,					\
+	}
+
+/* Initialize struct linear_range for regulators */
+#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
+	LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)
+
+struct rpm_regulator_desc {
+	const struct linear_range linear_ranges;
+	int n_linear_ranges;
+	unsigned int n_voltages;
+	const struct dm_regulator_ops *ops;
+};
+
+struct qcom_rpm_reg {
+	struct udevice *dev;
+	u32 type;
+	u32 id;
+
+	const struct rpm_regulator_desc *desc;
+
+	int is_enabled;
+	int uV;
+	u32 load;
+
+	unsigned int enabled_updated:1;
+	unsigned int uv_updated:1;
+	unsigned int load_updated:1;
+};
+
+struct rpm_regulator_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+#define RPM_KEY_SWEN	0x6e657773 /* "swen" */
+#define RPM_KEY_UV	0x00007675 /* "uv" */
+#define RPM_KEY_MA	0x0000616d /* "ma" */
+
+static struct udevice *rpm_smd_dev;
+
+static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
+{
+	struct rpm_regulator_req req[3];
+	int reqlen = 0;
+	int ret;
+
+	if (vreg->enabled_updated) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_SWEN);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->is_enabled);
+		reqlen++;
+	}
+
+	if (vreg->uv_updated && vreg->is_enabled > 0) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_UV);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->uV);
+		reqlen++;
+	}
+
+	if (vreg->load_updated && vreg->is_enabled > 0) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_MA);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->load / 1000);
+		reqlen++;
+	}
+
+	if (!reqlen)
+		return 0;
+
+	ret = qcom_rpm_smd_write(rpm_smd_dev, QCOM_SMD_RPM_ACTIVE_STATE,
+				 vreg->type, vreg->id,
+				 req, sizeof(req[0]) * reqlen);
+	if (!ret) {
+		vreg->enabled_updated = 0;
+		vreg->uv_updated = 0;
+		vreg->load_updated = 0;
+	}
+
+	return ret;
+}
+
+static int rpm_reg_get_voltage(struct udevice *rdev)
+{
+	struct qcom_rpm_reg *vreg = dev_get_priv(rdev);
+
+	return vreg->uV;
+}
+
+static int rpm_reg_set_voltage(struct udevice *rdev, int uV)
+{
+	struct qcom_rpm_reg *vreg = dev_get_priv(rdev);
+	const struct linear_range *uv_range;
+	int ret;
+	int old_uV = vreg->uV;
+
+	dev_dbg(vreg->dev, "%s: set_value %d (before %d)\n", rdev->name, uV, old_uV);
+
+	uv_range = &vreg->desc->linear_ranges;
+	int min_uV = uv_range->min;
+	int max_uV = uv_range->min + uv_range->max_sel * uv_range->step;
+
+	if (uV < min_uV || uV > max_uV) {
+		dev_err(vreg->dev, "voltage %d is out-of-range [%d:%d]\n", uV, min_uV, max_uV);
+		return -EINVAL;
+	}
+
+	vreg->uV = uV;
+	vreg->uv_updated = 1;
+
+	if (vreg->is_enabled == -EINVAL) {
+		/*
+		 * Cache the voltage and send it later when the regulator is
+		 * enabled or disabled.
+		 */
+		return 0;
+	}
+
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->uV = old_uV;
+
+	return ret;
+}
+
+static int rpm_reg_is_enabled(struct udevice *rdev)
+{
+	struct qcom_rpm_reg *vreg = dev_get_priv(rdev);
+
+	return vreg->is_enabled;
+}
+
+static int rpm_reg_enable(struct udevice *rdev, bool enable)
+{
+	struct qcom_rpm_reg *vreg = dev_get_priv(rdev);
+	int ret;
+
+	dev_dbg(vreg->dev, "%s: set_enable %d (before %d)\n", rdev->name, enable, vreg->is_enabled);
+
+	if (vreg->is_enabled <= 0 && !enable)
+		return 0;
+	if (vreg->is_enabled > 0 && enable)
+		return 0;
+
+	if (vreg->is_enabled < 0) {
+		ret = rpm_reg_set_voltage(rdev, vreg->uV);
+		if (ret < 0)
+			return ret;
+	}
+
+	vreg->is_enabled = enable;
+	vreg->enabled_updated = 1;
+
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->is_enabled = !enable;
+
+	return ret;
+}
+
+static const struct dm_regulator_ops rpm_smps_ldo_ops = {
+	.get_value = rpm_reg_get_voltage,
+	.set_value = rpm_reg_set_voltage,
+	.get_enable = rpm_reg_is_enabled,
+	.set_enable = rpm_reg_enable,
+};
+
+static const struct rpm_regulator_desc pm8998_hfsmps = {
+	.linear_ranges = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.n_linear_ranges = 1,
+	.n_voltages = 216,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct rpm_regulator_desc pm660_ht_lvpldo = {
+	.linear_ranges = REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
+	.n_linear_ranges = 1,
+	.n_voltages = 63,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct rpm_regulator_desc pm660_nldo660 = {
+	.linear_ranges = REGULATOR_LINEAR_RANGE(320000, 0, 123, 8000),
+	.n_linear_ranges = 1,
+	.n_voltages = 124,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct rpm_regulator_desc pm660_pldo660 = {
+	.linear_ranges = REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
+	.n_linear_ranges = 1,
+	.n_voltages = 256,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct rpm_regulator_desc pm6125_ftsmps = {
+	.linear_ranges = REGULATOR_LINEAR_RANGE(300000, 0, 268, 4000),
+	.n_linear_ranges = 1,
+	.n_voltages = 269,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct rpm_regulator_desc pm2250_lvftsmps = {
+	.linear_ranges = REGULATOR_LINEAR_RANGE(320000, 0, 269, 4000),
+	.n_linear_ranges = 1,
+	.n_voltages = 270,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct rpm_regulator_desc pm2250_ftsmps = {
+	.linear_ranges = REGULATOR_LINEAR_RANGE(640000, 0, 269, 8000),
+	.n_linear_ranges = 1,
+	.n_voltages = 270,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+struct rpm_regulator_data {
+	const char *name;
+	u32 type;
+	u32 id;
+	const struct rpm_regulator_desc *desc;
+	const char *supply;
+};
+
+static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm2250_lvftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm2250_lvftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm2250_lvftsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm2250_ftsmps, "vdd_s4" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm660_nldo660, "vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm660_ht_lvpldo, "vdd_l13_l14_l15_l16" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm660_pldo660, "vdd_l4_l17_l18_l19_l20_l21_l22" },
+	{}
+};
+
+static const struct rpm_regulator_data rpm_pm6125_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm6125_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm6125_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm6125_ftsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm6125_ftsmps, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm8998_hfsmps, "vdd_s5" },
+	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pm8998_hfsmps, "vdd_s6" },
+	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pm8998_hfsmps, "vdd_s7" },
+	{ "s8", QCOM_SMD_RPM_SMPA, 8, &pm6125_ftsmps, "vdd_s8" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm660_nldo660, "vdd_l1_l7_l17_l18" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm660_nldo660, "vdd_l2_l3_l4" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm660_nldo660, "vdd_l2_l3_l4" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm660_nldo660, "vdd_l2_l3_l4" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm660_nldo660, "vdd_l6_l8" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm660_nldo660, "vdd_l1_l7_l17_l18" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm660_nldo660, "vdd_l6_l8" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm660_ht_lvpldo, "vdd_l9_l11" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm660_ht_lvpldo, "vdd_l10_l13_l14" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm660_ht_lvpldo, "vdd_l9_l11" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm660_ht_lvpldo, "vdd_l12_l16" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm660_ht_lvpldo, "vdd_l10_l13_l14" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm660_ht_lvpldo, "vdd_l10_l13_l14" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm660_ht_lvpldo, "vdd_l12_l16" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm660_nldo660, "vdd_l1_l7_l17_l18" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm660_nldo660, "vdd_l1_l7_l17_l18" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm660_pldo660, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pm660_pldo660, "vdd_l23_l24" },
+	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pm660_pldo660, "vdd_l23_l24" },
+	{ }
+};
+
+static const struct udevice_id rpm_regulator_ids[] = {
+	{ .compatible = "qcom,rpm-pm2250-regulators", .data = (ulong)rpm_pm2250_regulators },
+	{ .compatible = "qcom,rpm-pm6125-regulators", .data = (ulong)rpm_pm6125_regulators },
+	{}
+};
+
+/* probe an individual regulator */
+static int rpm_regulator_probe(struct udevice *dev)
+{
+	const struct rpm_regulator_data *init_data;
+	struct qcom_rpm_reg *priv;
+	const struct linear_range *uv_range;
+
+	/*
+	 * Without a link to the RPM report "no driver", so that consumers
+	 * carry on with the votes the boot firmware left.
+	 */
+	if (qcom_rpm_smd_ready(rpm_smd_dev))
+		return -ENODEV;
+
+	init_data = (const struct rpm_regulator_data *)dev_get_driver_data(dev);
+	priv = dev_get_priv(dev);
+
+	priv->dev = dev;
+	priv->type = init_data->type;
+	priv->id = init_data->id;
+	priv->desc = init_data->desc;
+	priv->is_enabled = -EINVAL;
+
+	/* Highest supported voltage inside the range */
+	uv_range = &priv->desc->linear_ranges;
+	priv->uV = uv_range->min + uv_range->max_sel * uv_range->step;
+
+	return 0;
+}
+
+/* for non-smps_ldo regulators add additional driver definitions */
+U_BOOT_DRIVER(rpm_regulator_smps_ldo) = {
+	.name = "rpm_regulator_smps_ldo",
+	.id = UCLASS_REGULATOR,
+	.probe = rpm_regulator_probe,
+	.priv_auto = sizeof(struct qcom_rpm_reg),
+	.ops = &rpm_smps_ldo_ops,
+};
+
+/* This driver intentionally only supports a subset of the available regulators.
+ * This function checks to see if a given regulator node in DT matches a regulator
+ * defined in the driver.
+ */
+static const struct rpm_regulator_data *
+vreg_get_init_data(const struct rpm_regulator_data *init_data, ofnode node)
+{
+	const struct rpm_regulator_data *data;
+
+	for (data = init_data; data->name; data++) {
+		if (!strcmp(data->name, ofnode_get_name(node)))
+			return data;
+	}
+
+	return NULL;
+}
+
+static int rpm_regulators_bind(struct udevice *dev)
+{
+	const struct rpm_regulator_data *init_data, *data;
+	struct driver *drv;
+	ofnode node;
+	int ret;
+
+	rpm_smd_dev = dev_get_parent(dev);
+	if (!rpm_smd_dev) {
+		dev_err(dev, "Unable to retrieve handle to rpm\n");
+		return -ENODEV;
+	}
+
+	init_data = (const struct rpm_regulator_data *)dev_get_driver_data(dev);
+	if (!init_data) {
+		dev_err(dev, "No RPM regulator init data\n");
+		return -ENODEV;
+	}
+
+	drv = lists_driver_lookup_name("rpm_regulator_smps_ldo");
+
+	dev_for_each_subnode(node, dev) {
+		data = vreg_get_init_data(init_data, node);
+		if (!data)
+			continue;
+
+		ret = device_bind_with_driver_data(dev, drv, data->name, (ulong)data,
+						   node, NULL);
+		if (ret < 0) {
+			dev_err(dev, "Failed to bind RPM regulator %s: %d\n", data->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* Driver for a 'bank' of regulators. This creates devices for each
+ * individual regulator
+ */
+U_BOOT_DRIVER(rpm_regulators) = {
+	.name = "rpm_regulators",
+	.id = UCLASS_MISC,
+	.bind = rpm_regulators_bind,
+	.of_match = rpm_regulator_ids,
+	.ops = &rpm_smps_ldo_ops,
+};
diff --git a/include/soc/qcom/smd-rpm.h b/include/soc/qcom/smd-rpm.h
index 10d2f188b612..ed2c75560fee 100644
--- a/include/soc/qcom/smd-rpm.h
+++ b/include/soc/qcom/smd-rpm.h
@@ -11,6 +11,51 @@ struct udevice;
 
 #define QCOM_SMD_RPM_ACTIVE_STATE	0
 #define QCOM_SMD_RPM_SLEEP_STATE	1
+#define QCOM_SMD_RPM_STATE_NUM		2
+
+/*
+ * Constants used for addressing resources in the RPM.
+ */
+#define QCOM_SMD_RPM_BBYB	0x62796262
+#define QCOM_SMD_RPM_BOBB	0x62626f62
+#define QCOM_SMD_RPM_BOOST	0x61747362
+#define QCOM_SMD_RPM_BUS_CLK	0x316b6c63
+#define QCOM_SMD_RPM_BUS_MASTER	0x73616d62
+#define QCOM_SMD_RPM_BUS_SLAVE	0x766c7362
+#define QCOM_SMD_RPM_CLK_BUF_A	0x616B6C63
+#define QCOM_SMD_RPM_LDOA	0x616f646c
+#define QCOM_SMD_RPM_LDOB	0x626F646C
+#define QCOM_SMD_RPM_LDOE	0x656f646c
+#define QCOM_SMD_RPM_RWCX	0x78637772
+#define QCOM_SMD_RPM_RWMX	0x786d7772
+#define QCOM_SMD_RPM_RWLC	0x636c7772
+#define QCOM_SMD_RPM_RWLM	0x6d6c7772
+#define QCOM_SMD_RPM_MEM_CLK	0x326b6c63
+#define QCOM_SMD_RPM_MISC_CLK	0x306b6c63
+#define QCOM_SMD_RPM_NCPA	0x6170636E
+#define QCOM_SMD_RPM_NCPB	0x6270636E
+#define QCOM_SMD_RPM_OCMEM_PWR	0x706d636f
+#define QCOM_SMD_RPM_QPIC_CLK	0x63697071
+#define QCOM_SMD_RPM_QUP_CLK	0x707571
+#define QCOM_SMD_RPM_SMPA	0x61706d73
+#define QCOM_SMD_RPM_SMPB	0x62706d73
+#define QCOM_SMD_RPM_SMPE	0x65706d73
+#define QCOM_SMD_RPM_SPDM	0x63707362
+#define QCOM_SMD_RPM_VSA	0x00617376
+#define QCOM_SMD_RPM_MMAXI_CLK	0x69786d6d
+#define QCOM_SMD_RPM_IPA_CLK	0x617069
+#define QCOM_SMD_RPM_CE_CLK	0x6563
+#define QCOM_SMD_RPM_AGGR_CLK	0x72676761
+#define QCOM_SMD_RPM_HWKM_CLK	0x6d6b7768
+#define QCOM_SMD_RPM_PKA_CLK	0x616b70
+#define QCOM_SMD_RPM_MCFG_CLK	0x6766636d
+
+#define QCOM_RPM_KEY_SOFTWARE_ENABLE			0x6e657773
+#define QCOM_RPM_KEY_PIN_CTRL_CLK_BUFFER_ENABLE_KEY	0x62636370
+#define QCOM_RPM_SMD_KEY_RATE				0x007a484b
+#define QCOM_RPM_SMD_KEY_ENABLE				0x62616e45
+#define QCOM_RPM_SMD_KEY_STATE				0x54415453
+#define QCOM_RPM_SCALING_ENABLE_ID			0x2
 
 /**
  * qcom_rpm_smd_write() - send a resource request to the RPM and wait for

-- 
2.56.1

