Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183E5C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA2A87CA0;
	Wed,  1 Nov 2023 12:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="dLSWMeHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0404687705; Wed,  1 Nov 2023 12:40:56 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38AD2876CA
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101114041epoutp04ebfadffd888e269e901e25f68b0b1766~TfOzfXUpB0885608856epoutp04F
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101114041epoutp04ebfadffd888e269e901e25f68b0b1766~TfOzfXUpB0885608856epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698838841;
 bh=Xn5g2zFEHpSc/MdkM1C6H7sy7H64wlAabLgSRwETdKM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dLSWMeHr6u1lMQ1KaYo82+JjAPsgHFz1HShdd6W4q00I6pvcZhRl9ZoCHt6vYDVZU
 s68vEk56ZP0zrklN+rrsMix7zn+NnZ4LizKk6aTBIGyV3oQh0ZaZg2KEQTewnXhkjW
 HfCZG+Mw0uSZnftwKFYmvS+HS/hq1+HyY5aNTX68=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231101114040epcas2p2e9dfbb72ccbc293a783fc98f9b144029~TfOzDmqhR1820618206epcas2p2r;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SL4nh3FZVz4x9Pv; Wed,  1 Nov
 2023 11:40:40 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 05.5D.10022.83932456; Wed,  1 Nov 2023 20:40:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231101114040epcas2p3658fcb45be38f9928884983b7441c5ef~TfOyaOBkx2061720617epcas2p3_;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101114040epsmtrp1c54e8a0facefd5cce54f2cc87423ad18~TfOyWuqDE2761227612epsmtrp10;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-12-65423938b241
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 52.E4.08817.73932456; Wed,  1 Nov 2023 20:40:39 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101114039epsmtip15949f5b12aef51b4d8ba6a7552553da1~TfOyLY4MQ1681316813epsmtip1S;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 3/5] rng: Add StarFive JH7110 RNG driver
Date: Wed,  1 Nov 2023 20:40:15 +0900
Message-Id: <20231101114017.1845960-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101114017.1845960-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTVNfC0inVoHW3iMXl/doWN361sVq8
 fXGW0eLeNTmLt3s72S0OT/3AaPH40GsmB3aPPadnMXt8+BjncefaHjaPs3d2MHr0bVnFGMAa
 lW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SEkkJZ
 Yk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7
 Y/Hp88wFR+0qrn5Tb2BcadzFyMkhIWAice3/PpYuRi4OIYEdjBILW58zgSSEBD4xSrRMTYZI
 fGOUeLr7OzNMR++eb+wQRXsZJSafdIcomsYksWj/PDaQBJuArsSW568YQRIiAlcZJd7PegPW
 zSygLdH5eQpQNweHsIC1xI9dtiBhFgFViR/zjzOC2LwCDhLd93YxgZRICMhLLH4gARLmFHCU
 WNn2hw2iRFDi5MwnLBAT5SWat85mBlklIfCSXeLSxAuMEIe6SJz9OZEVwhaWeHV8CzuELSXx
 sr+NHWJ+ucSOZUkQvS2MEs1te6CetJf4cXMKK0gNs4CmxPpd+hDlyhJHbkGt5ZPoOPwXagqv
 REebEESjusSB7dNZIGxZie45n6EO8JD4NW8xGySkpjBK7H4yh2kCo8IsJN/MQvLNLITFCxiZ
 VzGKpRYU56anFhsVGMNjNzk/dxMjOEFque9gnPH2g94hRiYOxkOMEhzMSiK8h00dUoV4UxIr
 q1KL8uOLSnNSiw8xmgKDeiKzlGhyPjBF55XEG5pYGpiYmRmaG5kamCuJ895rnZsiJJCeWJKa
 nZpakFoE08fEwSnVwGR+ofhgXNsJIw8eicerUvykfqWGH5B47PdO1dX3snpk5f5JHHWfXgi1
 qe3qDVe6c/Qqx6Oyj9vm+75mv81TIjjtlOd50cQOuUmOGZekxQweySRavcjKdZcPub7s4b+s
 Jr4vbFfvMTGIRrx7K7G98mE/+8JVj84eiHflapkRvfXouudcO5umzi+fXHJgS4rC+3/M2yTW
 /lVZP2W9ssPFL329dQte7C1zf2mdrKmo3jw3IrQqI3bts90fGeXT2YM0SsoLP9vpJH33DDrP
 2e5jNsVgm+/1kNayTNmSCfzuW8955qouipz6b/39RT+/uxfvnePC9+Zxd1hKg1vgSq/1836K
 W/faJx09PO3QGsYJU5RYijMSDbWYi4oTAeLOwi8ZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnK65pVOqwc/11haX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 FJdNSmpOZllqkb5dAlfG4tPnmQuO2lVc/abewLjSuIuRk0NCwESid8839i5GLg4hgd2MEh3t
 DWwQCVmJZ+92sEPYwhL3W46wgthCApOYJO5NdwWx2QR0JbY8f8UI0iwicJNRYuGcrywgCWYB
 bYnOz1OAmjk4hAWsJX7ssgUJswioSvyYf5wRxOYVcJDovreLCaREQkBeYvEDCZAwp4CjxMq2
 P2wQqxwk5t5eyQpRLihxcuYTqOnyEs1bZzNPYBSYhSQ1C0lqASPTKkbJ1ILi3PTcYsMCo7zU
 cr3ixNzi0rx0veT83E2M4GDW0trBuGfVB71DjEwcjIcYJTiYlUR4D5s6pArxpiRWVqUW5ccX
 leakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXANP9o2t1HjHmiXWsnqt/Xmrjx
 ek28uVFv86I4rofnO5MvqNic4Zt+REzNQ1ng3V+zlmkXliyYO/Vp2Vbfg8XHJ51J1bJydHTL
 cXBTcTovu0be5kREAOcFz10HJ9wwqFu7TKB4VkyL4cNvuZteZuetK5cK3fxLZ43EETOXAwos
 aRMKvdQ3T/CaGPrDTibtqrpI0qHvpb+emnGcsA3NVHvP/PKhQcvlpSuu71WsKXz0/kOf74xn
 77SV5e81dC3waD2nfzalfrFOvtEnmRss8SZp8oaCbk3Tskr28QV6HDvsd+Mx9xuHQPtW9u9e
 Zq2TdqttaPp39pP94rPNJ/7EZFjfYdy7t9SyKCbStLTx7jdeJZbijERDLeai4kQAiElx59UC
 AAA=
X-CMS-MailID: 20231101114040epcas2p3658fcb45be38f9928884983b7441c5ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101114040epcas2p3658fcb45be38f9928884983b7441c5ef
References: <20231101114017.1845960-1-chanho61.park@samsung.com>
 <CGME20231101114040epcas2p3658fcb45be38f9928884983b7441c5ef@epcas2p3.samsung.com>
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
 drivers/rng/jh7110_rng.c | 271 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
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
index 000000000000..075a2d78eb2c
--- /dev/null
+++ b/drivers/rng/jh7110_rng.c
@@ -0,0 +1,271 @@
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
+		goto err_ahb;
+
+	err = reset_deassert(pdata->rst);
+	if (err)
+		goto err_reset;
+
+	pdata->mode = PRNG_256BIT;
+
+	err = starfive_trng_init(pdata);
+	if (err)
+		goto err_trng_init;
+
+	return 0;
+
+err_trng_init:
+	reset_assert(pdata->rst);
+err_reset:
+	clk_disable(pdata->ahb);
+err_ahb:
+	clk_disable(pdata->hclk);
+
+	return err;
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

