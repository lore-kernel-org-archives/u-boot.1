Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4358C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 07:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E75A87A16;
	Mon, 30 Oct 2023 08:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="VMXNXdB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B6D870BB; Mon, 30 Oct 2023 08:32:38 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E418D879DA
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231030073230epoutp045f43b2d1bad57511e7a16492cc247350~S0ji-AWEX0560005600epoutp04R
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 07:32:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231030073230epoutp045f43b2d1bad57511e7a16492cc247350~S0ji-AWEX0560005600epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698651150;
 bh=NwWCoVqExrvoNdd3dK6h8ux1AKAMaLb9jFGmALIfPGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VMXNXdB0MQaekKJiE3qiHdeM4T+QKb3cTL5tZYLP2LeslrOblG3rDBnUdjTrT35BQ
 1HfSXcM/BS38TqNXh6SfaRqcePkTRABBuUM0hHSU71J6PeiO97h+82LHbDSNcoBW+l
 jtyXtLhg6zBU5nb6YHX8/kEqyX1PmB5MICNfLpZI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231030073230epcas2p4358919427d39782fcf79409d5bf4c80b~S0jivxtka2578825788epcas2p4v;
 Mon, 30 Oct 2023 07:32:30 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SJlNG09HMz4x9QM; Mon, 30 Oct
 2023 07:32:30 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 B8.11.09607.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epcas2p19e6145de5e8b740125bbc523fbcc4f66~S0jh4Iynl1598115981epcas2p1v;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231030073229epsmtrp185ab0bb1879b3a0842d910ae4e762b22~S0jh3jmgm0605406054epsmtrp1U;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-8b-653f5c0d227e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C1.04.07368.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epsmtip1d389c90c84921c074f6acafd880358f9~S0jhpF3dx0477404774epsmtip1J;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 3/5] rng: Add StarFive JH7110 RNG driver
Date: Mon, 30 Oct 2023 16:32:02 +0900
Message-Id: <20231030073204.150030-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030073204.150030-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTXJc3xj7V4HyXtsXl/doWb1+cZbS4
 d03O4u3eTnaLw1M/MFo8PvSayYHNY8/pWcweHz7Gedy5tofN4+ydHYwefVtWMQawRmXbZKQm
 pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDtV1IoS8wpBQoF
 JBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ9xbtYSp
 YKpDxdNVG9gaGA+ZdDFycEgImEhc/cnbxcjFISSwg1FiZd93RgjnE6PE4+dbmCGcb4wSF5c9
 Yuli5ATr2LrtECtEYi+jxMbvJ6FapjFJvHl7jQmkik1AV2LL81dgCRGB1YwS2/Y3s4MkmAW0
 JTo/TwGzhQUsJNobJ4HZLAKqEhdXrgCzeQXsJTatPc0IcaC8xOIHEiBhTgEHiSVT/jNBlAhK
 nJz5hAVipLxE89bZYKdKCNxjl5jZsZ0J4lQXiY3XzkCdLSzx6vgWdghbSuJlfxs7xPxyiR3L
 kiB6Wxglmtv2MEPU2Ev8uDmFFaSGWUBTYv0ufYhyZYkjt6DW8kl0HP4LNYVXoqNNCKJRXeLA
 9ulQS2Uluud8ZoWwPSRary5mggTVZEaJmftvMk1gVJiF5JtZSL6ZhbB4ASPzKkax1ILi3PTU
 YqMCE3gEJ+fnbmIEJ0ctjx2Ms99+0DvEyMTBeIhRgoNZSYSX2dEmVYg3JbGyKrUoP76oNCe1
 +BCjKTCoJzJLiSbnA9NzXkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwc
 nFINTL5Js95EvHJ1kZw0t6X8yd3ezn9eRmvf3QtZsqXl2z/ZRZ9ETdaFpi0uPf3d6MfpRAu3
 LVOZbUTrl3+/+Fg9a5Gd0clpdfHfDnXtKL1670LQ9EsXXvnbfPe4uHOvU9fFu1PkGWTqsz8a
 h5Yyi140dTy5cOrjvsK3BteeXVi67NVC74exXOev/lu5QnXtRIEvk7pWad8898LSeEbB7pcz
 n7Iv4CtXe/F9v+G0K1NPzHed7bD8xI5ZaWfMD33hFNQNYznW9fbyxrV7VauWzM83WdMmschb
 Y6rMpq0SF2b3ht7jEV2tvuT2mU1T5ApjdnfIT1um4zLX7OGZ8uDtz45UC0cEJ7l3m6s0Kvl3
 uL+yMIxgUWIpzkg01GIuKk4EAKIdH7EXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnC5vjH2qwaXVwhaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGsVlk5Ka
 k1mWWqRvl8CVcW/VEqaCqQ4VT1dtYGtgPGTSxcjJISFgIrF12yHWLkYuDiGB3YwSSzr2MUEk
 ZCWevdvBDmELS9xvOQJVNIlJYsH2sywgCTYBXYktz18xgiREBNYzSvxY/p4VJMEsoC3R+XkK
 WLewgIVEe+MkMJtFQFXi4soVYDavgL3EprWngZo5gDbISyx+IAES5hRwkFgy5T/YEUJAJY/f
 fGKFKBeUODnzCQvEeHmJ5q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6yYYFhXmq5XnFibnFp
 Xrpecn7uJkZwIGtp7GC8N/+f3iFGJg7GQ4wSHMxKIrzMjjapQrwpiZVVqUX58UWlOanFhxil
 OViUxHkNZ8xOERJITyxJzU5NLUgtgskycXBKNTCddd9bdsjsQ4P5qg3NPY0CG+6d2m30Y9qO
 Ss9HK7pEJVMjOXk4zL+XalSZTMz68UfwSXfWRstDb8V73kiWq3N11t3pCPpiOSXk9rMihyb5
 J6GLjF+wHtGQqWr2aVFVfd37mmPxvYV11w/fX6fQov/O/tXk51PCvn5lnZq7TODnKYvjT9bt
 n277ht/tbaplXLDQWWb388L/kz53iAh8FA8JjK9dNFtnie9VHsszv8Kz425//Kx5VCb50uUF
 O5oqSh5xteqscNv9mLkvyWuFpuqW9yzX21dOTXy2SfLHfO11yo3M3FwMU15Jvnj8ue2Ai82a
 8Ns/Eni6pt0rW8B4zMHGtFX1Td22jwfZXfTlfx1VYinOSDTUYi4qTgQAZYkxPNMCAAA=
X-CMS-MailID: 20231030073229epcas2p19e6145de5e8b740125bbc523fbcc4f66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231030073229epcas2p19e6145de5e8b740125bbc523fbcc4f66
References: <20231030073204.150030-1-chanho61.park@samsung.com>
 <CGME20231030073229epcas2p19e6145de5e8b740125bbc523fbcc4f66@epcas2p1.samsung.com>
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

Adds to support JH7110 TRNG driver which is based on linux kernel's
jh7110-trng.c. This can support to generate 256-bit random numbers and
128-bit but this makes 256-bit default for convenience.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/rng/Kconfig      |   6 +
 drivers/rng/Makefile     |   1 +
 drivers/rng/jh7110_rng.c | 272 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 drivers/rng/jh7110_rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index 994cc35b2744..0dba1e06b429 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -91,4 +91,10 @@ config TPM_RNG
 	  functionality. Enable random number generator on TPM
 	  devices.
 
+config RNG_JH7110
+	bool "StarFive JH7110 Random Number Generator support"
+	depends on DM_RNG && STARFIVE_JH7110
+	help
+	  Enable True Random Number Generator in StarFive JH7110 SoCs.
+
 endif
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 47b323e61ee3..9de762c8a1c3 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
 obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
 obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
 obj-$(CONFIG_TPM_RNG) += tpm_rng.o
+obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
diff --git a/drivers/rng/jh7110_rng.c b/drivers/rng/jh7110_rng.c
new file mode 100644
index 000000000000..e71bf188f017
--- /dev/null
+++ b/drivers/rng/jh7110_rng.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * TRNG driver for the StarFive JH7110 SoC
+ *
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <reset.h>
+#include <rng.h>
+#include <asm/io.h>
+#include <linux/iopoll.h>
+
+/* trng register offset */
+#define STARFIVE_CTRL			0x00
+#define STARFIVE_STAT			0x04
+#define STARFIVE_MODE			0x08
+#define STARFIVE_SMODE			0x0C
+#define STARFIVE_IE			0x10
+#define STARFIVE_ISTAT			0x14
+#define STARFIVE_RAND0			0x20
+#define STARFIVE_RAND1			0x24
+#define STARFIVE_RAND2			0x28
+#define STARFIVE_RAND3			0x2C
+#define STARFIVE_RAND4			0x30
+#define STARFIVE_RAND5			0x34
+#define STARFIVE_RAND6			0x38
+#define STARFIVE_RAND7			0x3C
+#define STARFIVE_AUTO_RQSTS		0x60
+#define STARFIVE_AUTO_AGE		0x64
+
+/* CTRL CMD */
+#define STARFIVE_CTRL_EXEC_NOP		0x0
+#define STARFIVE_CTRL_GENE_RANDNUM	0x1
+#define STARFIVE_CTRL_EXEC_RANDRESEED	0x2
+
+/* STAT */
+#define STARFIVE_STAT_NONCE_MODE	BIT(2)
+#define STARFIVE_STAT_R256		BIT(3)
+#define STARFIVE_STAT_MISSION_MODE	BIT(8)
+#define STARFIVE_STAT_SEEDED		BIT(9)
+#define STARFIVE_STAT_LAST_RESEED(x)	((x) << 16)
+#define STARFIVE_STAT_SRVC_RQST		BIT(27)
+#define STARFIVE_STAT_RAND_GENERATING	BIT(30)
+#define STARFIVE_STAT_RAND_SEEDING	BIT(31)
+#define STARFIVE_STAT_RUNNING		(STARFIVE_STAT_RAND_GENERATING | \
+					 STARFIVE_STAT_RAND_SEEDING)
+
+/* MODE */
+#define STARFIVE_MODE_R256		BIT(3)
+
+/* SMODE */
+#define STARFIVE_SMODE_NONCE_MODE	BIT(2)
+#define STARFIVE_SMODE_MISSION_MODE	BIT(8)
+#define STARFIVE_SMODE_MAX_REJECTS(x)	((x) << 16)
+
+/* IE */
+#define STARFIVE_IE_RAND_RDY_EN		BIT(0)
+#define STARFIVE_IE_SEED_DONE_EN	BIT(1)
+#define STARFIVE_IE_LFSR_LOCKUP_EN	BIT(4)
+#define STARFIVE_IE_GLBL_EN		BIT(31)
+
+#define STARFIVE_IE_ALL			(STARFIVE_IE_GLBL_EN | \
+					 STARFIVE_IE_RAND_RDY_EN | \
+					 STARFIVE_IE_SEED_DONE_EN | \
+					 STARFIVE_IE_LFSR_LOCKUP_EN)
+
+/* ISTAT */
+#define STARFIVE_ISTAT_RAND_RDY		BIT(0)
+#define STARFIVE_ISTAT_SEED_DONE	BIT(1)
+#define STARFIVE_ISTAT_LFSR_LOCKUP	BIT(4)
+
+#define STARFIVE_RAND_LEN		sizeof(u32)
+
+enum mode {
+	PRNG_128BIT,
+	PRNG_256BIT,
+};
+
+struct starfive_trng_plat {
+	void *base;
+	struct clk *hclk;
+	struct clk *ahb;
+	struct reset_ctl *rst;
+	u32 mode;
+};
+
+static inline int starfive_trng_wait_idle(struct starfive_trng_plat *trng)
+{
+	u32 stat;
+
+	return readl_relaxed_poll_timeout(trng->base + STARFIVE_STAT, stat,
+					  !(stat & STARFIVE_STAT_RUNNING),
+					  100000);
+}
+
+static inline void starfive_trng_irq_mask_clear(struct starfive_trng_plat *trng)
+{
+	/* clear register: ISTAT */
+	u32 data = readl(trng->base + STARFIVE_ISTAT);
+
+	writel(data, trng->base + STARFIVE_ISTAT);
+}
+
+static int starfive_trng_cmd(struct starfive_trng_plat *trng, u32 cmd)
+{
+	u32 stat, flg;
+	int ret;
+
+	switch (cmd) {
+	case STARFIVE_CTRL_GENE_RANDNUM:
+		writel(cmd, trng->base + STARFIVE_CTRL);
+		flg = STARFIVE_ISTAT_RAND_RDY;
+		break;
+	case STARFIVE_CTRL_EXEC_RANDRESEED:
+		writel(cmd, trng->base + STARFIVE_CTRL);
+		flg = STARFIVE_ISTAT_SEED_DONE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = readl_relaxed_poll_timeout(trng->base + STARFIVE_ISTAT, stat,
+					 (stat & flg), 1000);
+	writel(flg, trng->base + STARFIVE_ISTAT);
+
+	return ret;
+}
+
+static int starfive_trng_read(struct udevice *dev, void *data, size_t len)
+{
+	struct starfive_trng_plat *trng = dev_get_plat(dev);
+	char *buffer = (char *)data;
+	int ret;
+	size_t max;
+
+	if (trng->mode == PRNG_256BIT)
+		max = min_t(size_t, max, (STARFIVE_RAND_LEN * 8));
+	else
+		max = min_t(size_t, max, (STARFIVE_RAND_LEN * 4));
+
+	ret = starfive_trng_wait_idle(trng);
+	if (ret)
+		return -ETIMEDOUT;
+
+	while (len) {
+		size_t max;
+		u32 val, step;
+
+		if (trng->mode == PRNG_256BIT)
+			max = min_t(size_t, len, (STARFIVE_RAND_LEN * 8));
+		else
+			max = min_t(size_t, len, (STARFIVE_RAND_LEN * 4));
+
+		ret = starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM);
+		if (ret)
+			return ret;
+
+		for (int i = 0; i < DIV_ROUND_UP(max, STARFIVE_RAND_LEN); i++) {
+			val = readl(trng->base + STARFIVE_RAND0 +
+				    (i * STARFIVE_RAND_LEN));
+			step = (max >= STARFIVE_RAND_LEN) ?
+				STARFIVE_RAND_LEN : max;
+			memcpy(buffer, &val, step);
+
+			max -= step;
+			buffer += step;
+			len -= step;
+		}
+	}
+
+	return 0;
+}
+
+static int starfive_trng_init(struct starfive_trng_plat *trng)
+{
+	u32 mode, intr = 0;
+
+	/* setup Auto Request/Age register */
+	writel(0, trng->base + STARFIVE_AUTO_AGE);
+	writel(0, trng->base + STARFIVE_AUTO_RQSTS);
+
+	/* clear register: ISTAT */
+	starfive_trng_irq_mask_clear(trng);
+
+	intr |= STARFIVE_IE_ALL;
+	writel(intr, trng->base + STARFIVE_IE);
+
+	mode = readl(trng->base + STARFIVE_MODE);
+
+	switch (trng->mode) {
+	case PRNG_128BIT:
+		mode &= ~STARFIVE_MODE_R256;
+		break;
+	case PRNG_256BIT:
+		mode |= STARFIVE_MODE_R256;
+		break;
+	default:
+		mode |= STARFIVE_MODE_R256;
+		break;
+	}
+
+	writel(mode, trng->base + STARFIVE_MODE);
+
+	return starfive_trng_cmd(trng, STARFIVE_CTRL_EXEC_RANDRESEED);
+}
+
+static int starfive_trng_probe(struct udevice *dev)
+{
+	struct starfive_trng_plat *pdata = dev_get_plat(dev);
+	int err;
+
+	err = clk_enable(pdata->hclk);
+	if (err)
+		return err;
+
+	err = clk_enable(pdata->ahb);
+	if (err)
+		return err;
+
+	err = reset_deassert(pdata->rst);
+	if (err)
+		return err;
+
+	pdata->mode = PRNG_256BIT;
+
+	return starfive_trng_init(pdata);
+}
+
+static int starfive_trng_of_to_plat(struct udevice *dev)
+{
+	struct starfive_trng_plat *pdata = dev_get_plat(dev);
+
+	pdata->base = (void *)dev_read_addr(dev);
+	if (!pdata->base)
+		return -ENODEV;
+
+	pdata->hclk = devm_clk_get(dev, "hclk");
+	if (IS_ERR(pdata->hclk))
+		return -ENODEV;
+
+	pdata->ahb = devm_clk_get(dev, "ahb");
+	if (IS_ERR(pdata->ahb))
+		return -ENODEV;
+
+	pdata->rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(pdata->rst))
+		return -ENODEV;
+
+	return 0;
+}
+
+static const struct dm_rng_ops starfive_trng_ops = {
+	.read = starfive_trng_read,
+};
+
+static const struct udevice_id starfive_trng_match[] = {
+	{
+		.compatible = "starfive,jh7110-trng",
+	},
+	{},
+};
+
+U_BOOT_DRIVER(starfive_trng) = {
+	.name = "jh7110-trng",
+	.id = UCLASS_RNG,
+	.of_match = starfive_trng_match,
+	.probe = starfive_trng_probe,
+	.ops = &starfive_trng_ops,
+	.plat_auto = sizeof(struct starfive_trng_plat),
+	.of_to_plat = starfive_trng_of_to_plat,
+};
-- 
2.39.2

