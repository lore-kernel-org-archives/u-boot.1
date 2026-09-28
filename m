Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AC2CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1059606EA;
	Mon, 28 Sep 2026 22:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gmd8HBWnwOw4; Mon, 28 Sep 2026 22:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0A07560614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635438;
	b=LcjFvr4gcK9YpokfnEZ+crwMncjZP6F3Ayg0hhPQb8X3UJMfsETl59FLMUX7V3XbWexi
	 F57RCmxBsh0oq/G2cH/O5I1ABjD/Q83JxIxd5wl5mwaCgDIF8R9UHcciWdWqsueubHcaC
	 vD+mO1J+/zFAWPfHJYxv3VU9KpLZf/aFlztkLe4+sevMbauYLoWMBI2zp+5CniRowFTH5
	 P2Vp1uibEjsa6gF07wz4K8LJbjViIBRCq3nbECIHPbwfDrIddQWPfq79ThtfwUHO4Jz+E
	 hSh7BXsjVxhRAYW+YyB+tdzveRiODfvLvqsKVpcrlAdujJAxrGOiU7IT3d0rX1P1zjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C3fGUrmRFc3WGNWjxmDjd6tiiA++H249S8w+k/evXdM=;
	b=tBYCvUByxyyUhTBm2AxhxXFnZMuhwu1iuAak4oXpASmR6O2Qp2vBgq4JCkDsIbeysgeO
	 3N4UpakQiyL9GpUtv624zIhw9gBzfar+Bk6uFxuF1ukXzmosHlWtTK5usBfk58wV5zUN/
	 pf2rMC+VRybFhhuEn5LWqncIWAfNzLb/QiCSYEGNJ1bxBKTbAXzwi3L2ctqPSRDc3dbWV
	 4ocsGwgrixqHJKzszleV8Fif1AMn8DDo/tMpDCKfz7kJ6Sak9uJuXlbSJs5vOE4RrABAq
	 PzZKFXz0HRVk4Ifbjgk3UFaOWfMOWXBssPr/TmTF5wOYsno9RfrmTl+ZtYORYnSlcZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635438;
	bh=C3fGUrmRFc3WGNWjxmDjd6tiiA++H249S8w+k/evXdM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nwzcp4O3JxVBq6HwEq1G9QLCLLsiNceB6a3hSa27JxfG0f8HUzp5sYeACFkfaXHJO
	 9VKuJU8xBVl+FG134CVlzSkh2/5prk0byETFMS7ZqPnyVfU1PF1uiQPs0qXkVwu+RO
	 3zSV6FBw8Q7DBTqhoch6AJ4J4YRbTqc1hV5KiYOukFPfxnAZ/uvp5pSF2NUJ3Er8U/
	 PotbLYKqKbZVSgpi5PND+BYxo5+1sRa04ME0bsqVsIG9w19ZfH/EQU9Bp+58wrJSvz
	 +Ih/A/EPeEIH2HpjkIMFHSxv/HLTo6OqVpoLNMWaKsSZtcAfsDPYuKrqZK9lODdKo5
	 kkEkUppOI/03w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A07560614;
	Mon, 28 Sep 2026 22:43:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E2F7561
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D41D0403C5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ant1ps-pF_5 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:43:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 66FEE403B4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:38::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790635435;
 b=KnTZ9gnjMkAS87nkSEQSxbXkhS0+cuthx9b6SMxBQbIR7L75yIPvJTcAh1fD7XJmy4a6
 khwvVL+HPor6BCctmJScEFVvfSRHmK1V1K14uk+3WEsNG0LWP9LmkYDDznAangIkrlDR9
 N/oMaBst1wJ11cgiDWBqi0F69BGt5wnaDw3uoKFibS6Y7kd0PPb5JZnt7FxguqUgMeVbI
 g1kXRkZ5cc93rxgnFLszEov278s1OUmH6gtjJWYHs217W+Sx3ev4iFc+BMoPq0YdqLstF
 MSTmtM7mcK8+M8mkO+TREJaEOKI8VG+K3kNeWLNXaJl2kGN+73La5XRwCZ/9yJf55YA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635435;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=C3fGUrmRFc3WGNWjxmDjd6tiiA++H249S8w+k/evXdM=;
 b=LrHwwyJAwteNx+FVZ1qK+X8XFyqNp+Ql6n1z2p4/0NTkVgei/6rPtJ9CAs6HrO6Zl9vE
 UdMqp6zKrXRl0IkX3JXsH1xvyb9B49e81DFvzKeFzOj/VDl1RLPW1EsoVllR3ESjEWb1s
 A2xD9WeIJhHu4XE5JxHV8mEIKHR208NAJQASr7i6GywUm9vuEhZyXvNuLK/Vk1r7dI7Hv
 /svl0g7aJX2S/CYNS5fCIKoSkgIxEGZO860rSSGKwBNVLQaY3AEPzh+j9n3ezhVRgl8i8
 AAzqjNLGi8aNbg3fmMoCNbnt5Jg2BPyZ6vof5iYCwQC7x4yzpEHizquvSzBEKWd4jrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VutOkI44; 
 arc=none smtp.remote-ip="2a00:1450:4864:38::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::f;
 helo=mail-lr2-x0f.google.com; envelope-from=sochnev.v.74@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VutOkI44
Received: from mail-lr2-x0f.google.com (mail-lr2-x0f.google.com
 [IPv6:2a00:1450:4864:38::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66FEE403B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:54 +0000 (UTC)
Received: by mail-lr2-x0f.google.com with SMTP id
 38308e7fff4ca-3a60e33d456so27235251fa.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790635432; x=1791240232;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C3fGUrmRFc3WGNWjxmDjd6tiiA++H249S8w+k/evXdM=;
 b=VutOkI44dUKBxw9XnoQmKTseGH2XPaizRKWyf6Y4Rg5+mRLM0DtAV0O1r8A0RRYIEN
 cBdCjL/rLYhK//gL94J7x0CKCEFytGV8/szIG/1wGrXgSIbk3O3jURySZNYKlj0qSnCT
 RV8d3m6pva8GyhitlUbqXvbDivQdmi9yMMCFXwIAW9wvdHBAF+W1LBJ48Ob5VE/owFQL
 d5z9liRMLj1AZs2ottW4DSUsH3NKdhYHJyFsZirXZVGSu3Z+RfhlaCIoiIm+zvKvWDYz
 +OLjTgjulyE+0WnYuFNoAEFApSF0mCHDQbhPH6Uq30fvJddmT1ZJe7AAhkqVE5tVsnhn
 oZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635432; x=1791240232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C3fGUrmRFc3WGNWjxmDjd6tiiA++H249S8w+k/evXdM=;
 b=p6qY2DRhrl04mqGLjg112XH8gNZUIfgKrcIsNNAZ1SOBNZryIAoCmzRrvhcM3fvMJb
 zMnlc50Y+cVyndC6cY+7P9tS+g0x6AOB/ff6P/4up2anhZ4FIW813aQnIISMAacKYKWs
 9B9jZQa+Omrh3LNaOnIyxCFjYgbAaMwDMNaadDcGyOaAtut/AyVDYx3OaIP0Luqz224E
 Qe/Jv3YZxTSFKE/XiOt1KFfujUsNAPA32twpQUWqjjaZ8wYwQjNDJ+LNfEo+eUTNLncF
 IE53iBX7t9QUt2x7Ge5lk1Q8rIfCtZyUY0CvxtrpD5VZDqiBrX4YLT3YjKyWPUnOFMQ7
 d3ag==
X-Gm-Message-State: AFq9FYIhnzYfGV3CRF+JhsWncCaehUeLnyVSiRtPxggsM7HrmXBb9ynQ
 KvvdsuENxEmVC9KDzj9HAJZ1JLNQrXB1BtoQTXPI9TVgBeNtDlgNB+q1AHZSsZI=
X-Gm-Gg: AYBFou1U/KyJAQC/joZi2vBau9VICsA+9qz46ye217zgpUn6Qh5V7ciShSq4YocC0ej
 9Y8sH394jZ4395rMxoF4AeWoKNiybTgjsCKPem1We444yzXNEcpuM7TuqvQkWkEDQpulKaPCeYM
 /jVtPc4XdZMQixh3HtKDHXBcgU7naMbt9EK+tnKOCFITRQC5MZLXIXJVgdfIDGlJeFg0rTA3my+
 NhHn/OHwy96hocmVABbFYKphRxpqI+fvNtnrLF5C0QX5C+DlpwJgYwpcoOZmmX8ib0ORkDx13bW
 /xv3BZG0hGoLGlqEz7OzmvKFwjVayVH8Odjumkhz/lWNHTPw1qjI1+5/arzSFYnMIECmOVDFXTB
 EqFrI3CPBmkZUy00iCArZ1RlAZe4kikX8egZmWszz7i8C9DoX+WdUJYTuu/5BbAML/W0AHGs8xq
 M4E3dt9jsH4Pr08JUoCBuzeYKVCg/vprrhIbc19PdR/ADDJVU/LdudmzsRUb6t
X-Received: by 2002:a05:6512:404c:b0:5b8:f9b0:5796 with SMTP id
 2adb3069b0e04-5ba2b2ae28bmr1028929e87.12.1790635432402; 
 Mon, 28 Sep 2026 15:43:52 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9debb0eccsm902212e87.43.2026.09.28.15.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:43:52 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Cc: ansuelsmth@gmail.com, mikhail.kshevetskiy@iopsys.eu, sughosh.ganu@arm.com,
 xypron.glpk@gmx.de, Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH RESEND 1/2] rng: airoha: add support for the Airoha TRNG
Date: Tue, 29 Sep 2026 01:43:37 +0300
Message-ID: <20260928224338.505923-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
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
    The first posting on 2026-09-20 was held by list moderation (non-member
    post) and never reached the list. Resent to the current list address.

 drivers/rng/Kconfig      |   7 ++
 drivers/rng/Makefile     |   1 +
 drivers/rng/airoha-rng.c | 136 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/rng/airoha-rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index bacb02630..3f829fccf 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -140,4 +140,11 @@ config RNG_EXYNOS
 	  case the LDFW (Loadable Firmware) has to be loaded first, as it
 	  actually implements TRNG SMC calls.
 
+config RNG_AIROHA
+	bool "Airoha True Random Number Generator support"
+	depends on DM_RNG && ARCH_AIROHA
+	help
+	  Enable support for the True Random Number Generator (TRNG) found
+	  on Airoha EN7581/AN7581 SoCs.
+
 endif
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 50622d470..c005231b6 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_TPM_RNG) += tpm_rng.o
 obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
 obj-$(CONFIG_RNG_TURRIS_RWTM) += turris_rwtm_rng.o
 obj-$(CONFIG_RNG_EXYNOS) += exynos-trng.o
+obj-$(CONFIG_RNG_AIROHA) += airoha-rng.o
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

