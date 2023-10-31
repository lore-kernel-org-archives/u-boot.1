Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5F4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 23:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE8987B49;
	Wed,  1 Nov 2023 00:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="TgfLz2OO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF48787B5F; Wed,  1 Nov 2023 00:56:11 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C06A87B49
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epoutp03ed9a7d070f251563fa83132987dc55bb~TVnc2EOOq2685926859epoutp03W
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031235554epoutp03ed9a7d070f251563fa83132987dc55bb~TVnc2EOOq2685926859epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698796554;
 bh=5wMrPFA0LRTm4dLrhJQGXuckGWenCMUW1cCRaE1nPDo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TgfLz2OOyF7EkbxZMD6mMrxVzBQqqxlIfHM0Y00IRriV0UVmeebqOtrPWzMSTXOQy
 OmgMsUoCglm/e4q4yoLwFkcfbSla0mqZ0QDBAlKk+g+evM2pkemVDRGTlqvckIQGE8
 MYZCttO6bsGp49ZRg0yc0NQDXuFUeekICklBtfXY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epcas2p4bd9123dfc95f3821a3f8bc17ab035f68~TVnciuU3b0928309283epcas2p43;
 Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKn8T5Zlpz4x9Pv; Tue, 31 Oct
 2023 23:55:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 BB.0F.10006.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epcas2p1e580a6b433c6e848368162a6b52e479d~TVnb7HVcY1708117081epcas2p1y;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031235553epsmtrp11df7a1481695fff0adc81d2bdd9572de~TVnb6gMD21700217002epsmtrp1W;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-7f-654194099077
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 41.BA.08755.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epsmtip18537d81a934e69bf48c5b0be10bb276d~TVnbpduzo0166001660epsmtip1_;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 3/5] rng: Add StarFive JH7110 RNG driver
Date: Wed,  1 Nov 2023 08:55:28 +0900
Message-Id: <20231031235530.1500393-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031235530.1500393-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQpdzimOqwfxObYvL+7Ut3r44y2hx
 75qcxdu9newWh6d+YLR4fOg1kwObx57Ts5g9PnyM87hzbQ+bx9k7Oxg9+rasYgxgjcq2yUhN
 TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
 SCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIztjXf5+x
 4IdNxdYlog2MzUZdjJwcEgImEvMb1zN1MXJxCAnsYJT4d3I5I4TziVFi1rIbjCBVQgLfGCW2
 X7OF6Tgy6REzRNFeRom1z65COdOYJPpPTmQBqWIT0JXY8vwV2CgRgdWMEtv2N7ODJJgFtCU6
 P08Bs4UFrCUm37sEZrMIqEocen6MDcTmFXCQ2LvzJ2sXIwfQOnmJxQ8kQMKcAo4Sp86+gyoR
 lDg58wkLxEh5ieats8GOkBC4xy6x8PZeRohTXSROnj3JBmELS7w6voUdwpaSeNnfxg4xv1xi
 x7IkiN4WRonmtj3MEDX2Ej9uTgG7gVlAU2L9Ln2IcmWJI7eg1vJJdBz+CzWFV6KjTQiiUV3i
 wPbpLBC2rET3nM+sELaHxPKNP1gg4TmFUaJrs+MERoVZSJ6ZheSZWQh7FzAyr2IUSy0ozk1P
 LTYqMIRHb3J+7iZGcGLUct3BOPntB71DjEwcjIcYJTiYlUR4D5s6pArxpiRWVqUW5ccXleak
 Fh9iNAWG9ERmKdHkfGBqziuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+J
 g1OqgSlfaYLoi+ivrbIKvJGfFl6flDlr7xnjg3f/V9u2W889n/zw8wIphUUZHWLqBt1MN4+/
 djopt0Tr/7mz/rUCx+VXOdaH9kb4etzNDw494rQ/6PL+X/XyxU9bOEw+vjpzx7X31Z2bx4Xr
 PXZ3L9rlss3dwrL/UOpjqReXS060T7Ax2nYp2ul/wYcZjj2SlyyN95xedXVeSdSL4/s3veS1
 UA+qO9FqHhkrsF3h5Qu5icHdP9buDyid9JPLqXxv1J3NAuqX8t90fju6X6hNOOeCsUo5S6bY
 z7kPl2Y8qd03dXvdYeVJyzZ8t12+L85nekGyrNSn84tmNoZee6rxYlvfe5nEJ9VbgBk0iyf+
 +NFX5yOUWIozEg21mIuKEwHOlmnOFQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnC7nFMdUg4Z9IhaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGsVlk5Ka
 k1mWWqRvl8CVsa//PmPBD5uKrUtEGxibjboYOTkkBEwkjkx6xNzFyMUhJLCbUeLkstdMEAlZ
 iWfvdrBD2MIS91uOsILYQgKTmCSm/YkGsdkEdCW2PH/FCNIsIrCeUeLH8vdgRcwC2hKdn6eA
 NQsLWEtMvncJzGYRUJU49PwYG4jNK+AgsXfnT6B6DqAF8hKLH0iAhDkFHCVOnX3HBrHLQeLD
 xEnsEOWCEidnPmGBGC8v0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0u
 zUvXS87P3cQIDmItzR2M21d90DvEyMTBeIhRgoNZSYT3sKlDqhBvSmJlVWpRfnxRaU5q8SFG
 aQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQYmuaL+rYrb2TOvTbW62SCd9k3y8r5Fhqbv
 Q5RmZZ9LO5O5+M/Fo3NlysVkuJbFTp/9/E+fXbrs3BmF1gqJz9T74pv5QkP3LDXepfv9RJ+E
 IG9JftH0R4sj7mysXnypKJc3xa//TkfcqQqJZy/v5MT6uTQo9fy66p/BuZ7j3EcZm81SHNJm
 zgvYjf/qzH942tI85PB9hbCqgKSGf6GPNq0WvzDBfaLxBJU59fmsKvcE3k5+rKo+feaHzSce
 6Nf381oGnD9WcGruw8L9z6/5fquc5pA6zZHp386WyMTTSrPKV9qfzclS/vE7P1iissNhzqdc
 lYa0un6OzJI1/KdneNZl673ylLlWcXGPkd3K7O1KLMUZiYZazEXFiQBnuXRY0QIAAA==
X-CMS-MailID: 20231031235553epcas2p1e580a6b433c6e848368162a6b52e479d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031235553epcas2p1e580a6b433c6e848368162a6b52e479d
References: <20231031235530.1500393-1-chanho61.park@samsung.com>
 <CGME20231031235553epcas2p1e580a6b433c6e848368162a6b52e479d@epcas2p1.samsung.com>
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
 drivers/rng/jh7110_rng.c | 258 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
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
index 000000000000..37ea8cc39945
--- /dev/null
+++ b/drivers/rng/jh7110_rng.c
@@ -0,0 +1,258 @@
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
+	u8 *buffer = data;
+	int iter_mask;
+
+	if (trng->mode == PRNG_256BIT)
+		iter_mask = 7;
+	else
+		iter_mask = 3;
+
+	for (int i = 0; len; ++i, i &= iter_mask) {
+		u32 val;
+		size_t step;
+		int ret;
+
+		ret = starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM);
+		if (ret)
+			return ret;
+
+		val = readl(trng->base + STARFIVE_RAND0 +
+			    (i * STARFIVE_RAND_LEN));
+		step = min_t(size_t, len, STARFIVE_RAND_LEN);
+		memcpy(buffer, &val, step);
+		buffer += step;
+		len -= step;
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

