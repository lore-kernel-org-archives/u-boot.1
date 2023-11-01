Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36427C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F7F87AEF;
	Wed,  1 Nov 2023 13:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="TflYsrGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E726F87CF1; Wed,  1 Nov 2023 13:17:33 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB67D868D1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231101121717epoutp035c8f1f5f5bcac4be8e4e3d535a4981b9~TfuxTvOpz1978319783epoutp03X
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231101121717epoutp035c8f1f5f5bcac4be8e4e3d535a4981b9~TfuxTvOpz1978319783epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698841037;
 bh=xRR2WePrr/8nUJfYEJSuuTIE9pyCexiQcAtXkXTPYv4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TflYsrGbEbWoVy0ADnEiKWFCbb30cqDfoa3ajed3JpwwvYCR6XCKgEOK8lLxgMEtg
 uLgeEX7meEKCkFbu/tTTz6ZRScUm5EVAK4ikoFFK9yu8jdGDTZG0G7ESLIW4mzKt2x
 kcuG7gE09UQm424jddSTWqShN/6/ggG+AVkmgTO8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231101121717epcas2p3af6b18f4a0907828a98f04350b37bd57~TfuwyxlNm2435424354epcas2p3Z;
 Wed,  1 Nov 2023 12:17:17 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SL5bx08rzz4x9Q0; Wed,  1 Nov
 2023 12:17:17 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7F.F8.18994.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231101121716epcas2p2ca68a2ab3ecd448d80ad0c129d2053d7~TfuvxZWPg0689906899epcas2p29;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101121716epsmtrp1e64e6b1a532ffac29afad365bfc62518~Tfuvt5Z880181001810epsmtrp16;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-12-654241cccff9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 34.C5.08817.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101121716epsmtip1b42f72bcd23180ef80b36a30f837d9b7~TfuviTPM10809708097epsmtip1I;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v4 3/5] rng: Add StarFive JH7110 RNG driver
Date: Wed,  1 Nov 2023 21:16:50 +0900
Message-Id: <20231101121652.1865516-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101121652.1865516-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdljTVPeMo1OqwZGVFhaX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
 iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTs
 jGv3b7AVPLGruDz1GnsD4xbjLkZODgkBE4n2g/1sXYxcHEICexglHh26wQLhfGKUeH95IRNI
 lZDAN0aJnV0+MB1rP2+H6tjLKHFt4V92iKJpTBL9G8xBbDYBXYktz18xghSJCFwFmjTrDTNI
 gllAW6Lz8xSwBmEBa4lT22axgtgsAqoS2748AIvzCjhIzHjWDlTPAbRNXmLxAwmQMKeAo8TV
 5vXMECWCEidnPmGBGCkv0bx1NjPILgmBl+wSnXu2MkNc6iJx9e9cdghbWOLV8S1QtpTEy/42
 doj55RI7liVB9LYwSjS37YHqtZf4cXMKK0gNs4CmxPpd+hDlyhJHbkGt5ZPoOPwXagqvREeb
 EESjusSB7dNZIGxZie45n1khbA+J7fO+M0OCbQqjRPeRd0wTGBVmIflmFpJvZiEsXsDIvIpR
 KrWgODc9NdmowFA3L7UcHsfJ+bmbGMHJUst3B+Pr9X/1DjEycTAeYpTgYFYS4T1s6pAqxJuS
 WFmVWpQfX1Sak1p8iNEUGNwTmaVEk/OB6TqvJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS
 1OzU1ILUIpg+Jg5OqQYmkxOvFfsuLHu2LYvHal/vXAfXQ/Ki/e5sykVlMReuXjvu1zG75uHv
 Ct9V35ZYt++RNZth/aI6NExs+r9DR7/ELymwlE3x97918THb3d8nha2EM19bPp/54kjctrPr
 jvuFL2mZe+mY8mmOwPOnkiQ11JUc7r/gN01cuD7SWGI975+Ex5+tbY+7rDj6JTHvyDubfxzq
 aw/UTX93N+WA6OHtnBkP5l9O9OtyrJmpse2qgoC87OruPwdiOtMOC5R/5vPpWb506zbzTVo8
 px4KLVsZ73+E26B5R9H1BMvvsrbr1N08G47+e1Fy1Cbj6r8Xx7LDdTK3TXlsyNDhznlZ7Rt3
 m3WqTELpzVP5ASJnr3NoKbEUZyQaajEXFScCALhwUsMfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO4ZR6dUg0X3OS0u79e2uPGrjdXi
 7YuzjBb3rslZvN3byW5xeOoHRovHh14zObB77Dk9i9njw8c4jzvX9rB5nL2zg9Gjb8sqxgDW
 KC6blNSczLLUIn27BK6Ma/dvsBU8sau4PPUaewPjFuMuRk4OCQETibWft7N1MXJxCAnsZpTY
 uXM9E0RCVuLZux3sELawxP2WI6wQRZOYJF7Pm84KkmAT0JXY8vwVI0hCROAmo8TCOV9ZQBLM
 AtoSnZ+ngHULC1hLnNo2C6yBRUBVYtuXB2BxXgEHiRnP2pm7GDmANshLLH4gARLmFHCUuNq8
 nhnEFgIqebfkPRtEuaDEyZlPoMbLSzRvnc08gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LjPJS
 y/WKE3OLS/PS9ZLzczcxgkNaS2sH455VH/QOMTJxMB5ilOBgVhLhPWzqkCrEm5JYWZValB9f
 VJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QDk20Yz8+j/Y8nq6/7zbNOwDRK
 VXDDqs8Cp2vLM3L+R/FrWbzurfhuznJ50ZHJpipP5U14j1VFbBHb09962bDC+2v9TW2ZeD7d
 n3pWSiuTmAPkj/5naa0XfpX4WeDFlveh/+9y/QtZlTHhU4LtfInCW4YmVuueXWLO3bI8cfG8
 axdezs/tvfOJ5f96xqe9aVUPH0/OevvdeO/V3bIq20v/xJj8ilQ461QZe+CHld/yqev69Jaa
 pQUErVJaH+t2wtXHYzez6KE2LUbeR2/sN1YUPQ5N+piTmH+98GR8/Nswxq0sS+69Eo3J8RRN
 f7tzHsOiQ/m/gh8fZ/bZzsnbJhn7+v755mk7v25pM7zxVDVMSImlOCPRUIu5qDgRAJ1fzXnY
 AgAA
X-CMS-MailID: 20231101121716epcas2p2ca68a2ab3ecd448d80ad0c129d2053d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101121716epcas2p2ca68a2ab3ecd448d80ad0c129d2053d7
References: <20231101121652.1865516-1-chanho61.park@samsung.com>
 <CGME20231101121716epcas2p2ca68a2ab3ecd448d80ad0c129d2053d7@epcas2p2.samsung.com>
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
 drivers/rng/jh7110_rng.c | 274 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)
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
index 000000000000..eb21afe4e7cb
--- /dev/null
+++ b/drivers/rng/jh7110_rng.c
@@ -0,0 +1,274 @@
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
+		if (!i) {
+			ret = starfive_trng_cmd(trng,
+						STARFIVE_CTRL_GENE_RANDNUM);
+			if (ret)
+				return ret;
+		}
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

