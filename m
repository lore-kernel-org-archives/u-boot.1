Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBBFC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 00:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F370875F5;
	Wed,  1 Nov 2023 01:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="AnTXE6aQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F43875F6; Wed,  1 Nov 2023 01:52:39 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F018875EC
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 01:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101005231epoutp043f5615f991a43df91a35bb729b01c460~TWY4N__Vv0089600896epoutp04U
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:52:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101005231epoutp043f5615f991a43df91a35bb729b01c460~TWY4N__Vv0089600896epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698799951;
 bh=iLtytW+sy+CBTlra/2gePJp+Ukdw4jU4yg3yxzOxZxk=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=AnTXE6aQIj+HSEpKQanQecNYkUqhqDi2r7r3VkvT+49MIJIVDxAw7+g05LGpUs9rs
 oqslnJtcobvyma+X8zQ4rx1ZvT4ltlAn7aW0AzdPGVubMp8ZTtGEtzV2KW3wJ4bKGa
 Z9cqf+aUQtweSpzn1mk4jqp4Id42ZAR8cgJY8VSg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20231101005230epcas1p3a4ea933924e7d91ee1191f42edad1c03~TWY3-AwUN1754117541epcas1p3U;
 Wed,  1 Nov 2023 00:52:30 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.145]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKpPn4rf8z4x9Q2; Wed,  1 Nov
 2023 00:52:29 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 B6.F7.09739.D41A1456; Wed,  1 Nov 2023 09:52:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231101005229epcas1p1592bb6b973098bfee4c2fecbfc0cbd80~TWY2gQkmr0339303393epcas1p1o;
 Wed,  1 Nov 2023 00:52:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101005229epsmtrp2cca2c7d6b88f336ad6750664ebfec75b~TWY2fjgYf0686506865epsmtrp2J;
 Wed,  1 Nov 2023 00:52:29 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-4b-6541a14d9fcf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 49.FA.08817.D41A1456; Wed,  1 Nov 2023 09:52:29 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101005228epsmtip26824f978f8e54089f4ad06ca95df67c1~TWY2Pj9eR0849808498epsmtip2T;
 Wed,  1 Nov 2023 00:52:28 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Chanho Park'" <chanho61.park@samsung.com>, "'Sughosh Ganu'"
 <sughosh.ganu@linaro.org>, "'Heinrich Schuchardt'" <xypron.glpk@gmx.de>,
 "'Rick Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <20231031235530.1500393-4-chanho61.park@samsung.com>
Subject: RE: [PATCH v2 3/5] rng: Add StarFive JH7110 RNG driver
Date: Wed, 1 Nov 2023 09:52:28 +0900
Message-ID: <016c01da0c5d$b0449f30$10cddd90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKT+xXLwr3a99t9wWLY9o27f2hMVAJJLqHvAhBbHJ2uzfceoA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmga7vQsdUg31NChaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGpVtk5Ga
 mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
 kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFqgV5yYW1yal66Xl1piZWhgYGQKVJiQnXHjgkDB
 BI+KOw29TA2MNy27GDk5JARMJBYvambvYuTiEBLYwSjRd3wtK4TziVHi9sYfjBDON0aJLfce
 ssC0fFj1iAkisZdR4tHuh8wQzktGiR89OxlBqtgE9CT+L1oIlhAReMMo8fXUXrYuRg4OTgFH
 iWlbS0FqhAXsJXbt+s4MYrMIqEj8OfCZHcTmFbCUuPasiwnCFpQ4OfMJ2GZmAXmJ7W/nMENc
 oSDx8+kyVhBbRMBJYtbCt0wQNSISszvbwPZKCDRySKxZMo0dosFFYs7GL4wQtrDEq+NboOJS
 Ep/fgdwG0tDMKLF0yUFWCKeHUeJfw3U2iCpjif1LJzOBfMAsoCmxfpc+RFhRYufvuYwQm/kk
 3n3tYQUpkRDglehoE4IoUZG49PolE8yuu0/+s0LYHhLLN/5gmcCoOAvJn7OQ/DkLyT+zEBYv
 YGRZxSiWWlCcm55abFhgDI/u5PzcTYzgxKllvoNx2tsPeocYmTgYDzFKcDArifAeNnVIFeJN
 SaysSi3Kjy8qzUktPsRoCgz5icxSosn5wNSdVxJvaGJpYGJmZGxiYWhmqCTOe+tZb4qQQHpi
 SWp2ampBahFMHxMHp1QD01Relw9X7zzVu+TUZfWnY6VMZPTkxhflvVKT1NrDi3fd+vzA6bZV
 7M67p9JX3326l2GKOu/nhrQPDiX33NZZlJxqaVpZPu+8WiJn0tGNKhe/sq650PfrzjOF0OZ1
 Vnsj1rauPb9ZW37vsqJnITplJ28edzl8wPPfod4r+/iV50Z9Nb4hExy4w/ChCNvNHsdnrirf
 GGVz+KZGX3k4j6OGWV50eeqrglW2rJUS6e9SC3dw6EqEHRQs6dySX1O0bm3Q162bH8YIij0M
 kI399pc31iZiB/9GPmZVx5qbAiv85v//UdBQvEV4X1bf//P3F6oyZIcszS8s2GSfWPj/dSKr
 UdDJ2Nif+63jlDYWG7DcV2Ipzkg01GIuKk4EAKhZ5/0lBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK7vQsdUg6d72Cwu79e2ePviLKPF
 vWtyFm/3drJbHJ76gdHi8aHXTA5sHntOz2L2+PAxzuPOtT1sHmfv7GD06NuyijGANYrLJiU1
 J7MstUjfLoEr48YFgYIJHhV3GnqZGhhvWnYxcnJICJhIfFj1iKmLkYtDSGA3o8Sk/Q/YIBJS
 Ep+fTgWyOYBsYYnDh4shap4zSnS0fAGrYRPQk/i/aCEzSEJE4AOjROPKU4wQVccZJTa2tIB1
 cwo4SkzbWgrSICxgL7Fr13dmEJtFQEXiz4HP7CA2r4ClxLVnXUwQtqDEyZlPWEBsZgFtiac3
 n0LZ8hLb385hhjhOQeLn02WsILaIgJPErIVvmSBqRCRmd7YxT2AUmoVk1Cwko2YhGTULScsC
 RpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBcaKltYNxz6oPeocYmTgYDzFKcDAr
 ifAeNnVIFeJNSaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoFJ
 7syWHyuXlrVy1qvE9t0OO8I1Of7mXnbWHdq7Z/u9kpi1O//1ZM1121qeKVy7fMBy0yKr3jj3
 +Ld/T886eOTO0xvSbz7oH+Hlb4tft/P9RaG2d9q3Ju7rYtWe6KZlL6iV8exh09ZJk+/+3xlu
 lPFqsnn1gYfsNvvduoT9cqPfzvtto9dqql4d92ad78zutX173CzWGyxZdVrz2dPSkM6Ojuvh
 Zi/vfn2jvcZ478Ho7rXNyWdUnslF+6oxXjJe9enKlNcCM51MCn23cjrW3vxfExV5VCt6jk5d
 k7ekz3zdItVQq0OT2cP1RfZpfHOcJ7o0SPd/qDmfTdTjw+0HxHSWGZYrrPMRmXY0fAa38MdH
 SizFGYmGWsxFxYkAbjzw6AIDAAA=
X-CMS-MailID: 20231101005229epcas1p1592bb6b973098bfee4c2fecbfc0cbd80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031235553epcas2p1e580a6b433c6e848368162a6b52e479d
References: <20231031235530.1500393-1-chanho61.park@samsung.com>
 <CGME20231031235553epcas2p1e580a6b433c6e848368162a6b52e479d@epcas2p1.samsung.com>
 <20231031235530.1500393-4-chanho61.park@samsung.com>
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



> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Chanho Park
> Sent: Wednesday, November 1, 2023 8:55 AM
> To: Sughosh Ganu <sughosh.ganu@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>; Rick Chen
> <rick@andestech.com>; Leo <ycliang@andestech.com>; u-boot@lists.denx.de
> Cc: Chanho Park <chanho61.park@samsung.com>
> Subject: [PATCH v2 3/5] rng: Add StarFive JH7110 RNG driver
> 
> Adds to support JH7110 TRNG driver which is based on linux kernel's
> jh7110-trng.c. This can support to generate 256-bit random numbers and
> 128-bit but this makes 256-bit default for convenience.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/rng/Kconfig      |   6 +
>  drivers/rng/Makefile     |   1 +
>  drivers/rng/jh7110_rng.c | 258 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/rng/jh7110_rng.c
> 
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index 994cc35b2744..0dba1e06b429 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -91,4 +91,10 @@ config TPM_RNG
>  	  functionality. Enable random number generator on TPM
>  	  devices.
> 
> +config RNG_JH7110
> +	bool "StarFive JH7110 Random Number Generator support"
> +	depends on DM_RNG && STARFIVE_JH7110
> +	help
> +	  Enable True Random Number Generator in StarFive JH7110 SoCs.
> +
>  endif
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 47b323e61ee3..9de762c8a1c3 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
>  obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
>  obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
>  obj-$(CONFIG_TPM_RNG) += tpm_rng.o
> +obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
> diff --git a/drivers/rng/jh7110_rng.c b/drivers/rng/jh7110_rng.c
> new file mode 100644
> index 000000000000..37ea8cc39945
> --- /dev/null
> +++ b/drivers/rng/jh7110_rng.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * TRNG driver for the StarFive JH7110 SoC
> + *
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <reset.h>
> +#include <rng.h>
> +#include <asm/io.h>
> +#include <linux/iopoll.h>
> +
> +/* trng register offset */
> +#define STARFIVE_CTRL			0x00
> +#define STARFIVE_STAT			0x04
> +#define STARFIVE_MODE			0x08
> +#define STARFIVE_SMODE			0x0C
> +#define STARFIVE_IE			0x10
> +#define STARFIVE_ISTAT			0x14
> +#define STARFIVE_RAND0			0x20
> +#define STARFIVE_RAND1			0x24
> +#define STARFIVE_RAND2			0x28
> +#define STARFIVE_RAND3			0x2C
> +#define STARFIVE_RAND4			0x30
> +#define STARFIVE_RAND5			0x34
> +#define STARFIVE_RAND6			0x38
> +#define STARFIVE_RAND7			0x3C
> +#define STARFIVE_AUTO_RQSTS		0x60
> +#define STARFIVE_AUTO_AGE		0x64
> +
> +/* CTRL CMD */
> +#define STARFIVE_CTRL_EXEC_NOP		0x0
> +#define STARFIVE_CTRL_GENE_RANDNUM	0x1
> +#define STARFIVE_CTRL_EXEC_RANDRESEED	0x2
> +
> +/* STAT */
> +#define STARFIVE_STAT_NONCE_MODE	BIT(2)
> +#define STARFIVE_STAT_R256		BIT(3)
> +#define STARFIVE_STAT_MISSION_MODE	BIT(8)
> +#define STARFIVE_STAT_SEEDED		BIT(9)
> +#define STARFIVE_STAT_LAST_RESEED(x)	((x) << 16)
> +#define STARFIVE_STAT_SRVC_RQST		BIT(27)
> +#define STARFIVE_STAT_RAND_GENERATING	BIT(30)
> +#define STARFIVE_STAT_RAND_SEEDING	BIT(31)
> +#define STARFIVE_STAT_RUNNING		(STARFIVE_STAT_RAND_GENERATING | \
> +					 STARFIVE_STAT_RAND_SEEDING)
> +
> +/* MODE */
> +#define STARFIVE_MODE_R256		BIT(3)
> +
> +/* SMODE */
> +#define STARFIVE_SMODE_NONCE_MODE	BIT(2)
> +#define STARFIVE_SMODE_MISSION_MODE	BIT(8)
> +#define STARFIVE_SMODE_MAX_REJECTS(x)	((x) << 16)
> +
> +/* IE */
> +#define STARFIVE_IE_RAND_RDY_EN		BIT(0)
> +#define STARFIVE_IE_SEED_DONE_EN	BIT(1)
> +#define STARFIVE_IE_LFSR_LOCKUP_EN	BIT(4)
> +#define STARFIVE_IE_GLBL_EN		BIT(31)
> +
> +#define STARFIVE_IE_ALL			(STARFIVE_IE_GLBL_EN | \
> +					 STARFIVE_IE_RAND_RDY_EN | \
> +					 STARFIVE_IE_SEED_DONE_EN | \
> +					 STARFIVE_IE_LFSR_LOCKUP_EN)
> +
> +/* ISTAT */
> +#define STARFIVE_ISTAT_RAND_RDY		BIT(0)
> +#define STARFIVE_ISTAT_SEED_DONE	BIT(1)
> +#define STARFIVE_ISTAT_LFSR_LOCKUP	BIT(4)
> +
> +#define STARFIVE_RAND_LEN		sizeof(u32)
> +
> +enum mode {
> +	PRNG_128BIT,
> +	PRNG_256BIT,
> +};
> +
> +struct starfive_trng_plat {
> +	void *base;
> +	struct clk *hclk;
> +	struct clk *ahb;
> +	struct reset_ctl *rst;
> +	u32 mode;
> +};
> +
> +static inline int starfive_trng_wait_idle(struct starfive_trng_plat *trng)
> +{
> +	u32 stat;
> +
> +	return readl_relaxed_poll_timeout(trng->base + STARFIVE_STAT, stat,
> +					  !(stat & STARFIVE_STAT_RUNNING),
> +					  100000);
> +}
> +
> +static inline void starfive_trng_irq_mask_clear(struct starfive_trng_plat *trng)
> +{
> +	/* clear register: ISTAT */
> +	u32 data = readl(trng->base + STARFIVE_ISTAT);
> +
> +	writel(data, trng->base + STARFIVE_ISTAT);
> +}
> +
> +static int starfive_trng_cmd(struct starfive_trng_plat *trng, u32 cmd)
> +{
> +	u32 stat, flg;
> +	int ret;
> +
> +	switch (cmd) {
> +	case STARFIVE_CTRL_GENE_RANDNUM:
> +		writel(cmd, trng->base + STARFIVE_CTRL);
> +		flg = STARFIVE_ISTAT_RAND_RDY;
> +		break;
> +	case STARFIVE_CTRL_EXEC_RANDRESEED:
> +		writel(cmd, trng->base + STARFIVE_CTRL);
> +		flg = STARFIVE_ISTAT_SEED_DONE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = readl_relaxed_poll_timeout(trng->base + STARFIVE_ISTAT, stat,
> +					 (stat & flg), 1000);
> +	writel(flg, trng->base + STARFIVE_ISTAT);
> +
> +	return ret;
> +}
> +
> +static int starfive_trng_read(struct udevice *dev, void *data, size_t len)
> +{
> +	struct starfive_trng_plat *trng = dev_get_plat(dev);
> +	u8 *buffer = data;
> +	int iter_mask;
> +
> +	if (trng->mode == PRNG_256BIT)
> +		iter_mask = 7;
> +	else
> +		iter_mask = 3;
> +
> +	for (int i = 0; len; ++i, i &= iter_mask) {
> +		u32 val;
> +		size_t step;
> +		int ret;
> +
> +		ret = starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM);
> +		if (ret)
> +			return ret;
> +
> +		val = readl(trng->base + STARFIVE_RAND0 +
> +			    (i * STARFIVE_RAND_LEN));
> +		step = min_t(size_t, len, STARFIVE_RAND_LEN);
> +		memcpy(buffer, &val, step);
> +		buffer += step;
> +		len -= step;
> +	}
> +
> +	return 0;
> +}
> +
> +static int starfive_trng_init(struct starfive_trng_plat *trng)
> +{
> +	u32 mode, intr = 0;
> +
> +	/* setup Auto Request/Age register */
> +	writel(0, trng->base + STARFIVE_AUTO_AGE);
> +	writel(0, trng->base + STARFIVE_AUTO_RQSTS);
> +
> +	/* clear register: ISTAT */
> +	starfive_trng_irq_mask_clear(trng);
> +
> +	intr |= STARFIVE_IE_ALL;
> +	writel(intr, trng->base + STARFIVE_IE);
> +
> +	mode = readl(trng->base + STARFIVE_MODE);
> +
> +	switch (trng->mode) {
> +	case PRNG_128BIT:
> +		mode &= ~STARFIVE_MODE_R256;
> +		break;
> +	case PRNG_256BIT:
> +		mode |= STARFIVE_MODE_R256;
> +		break;
> +	default:
> +		mode |= STARFIVE_MODE_R256;
> +		break;
> +	}
> +
> +	writel(mode, trng->base + STARFIVE_MODE);
> +
> +	return starfive_trng_cmd(trng, STARFIVE_CTRL_EXEC_RANDRESEED);
> +}
> +
> +static int starfive_trng_probe(struct udevice *dev)
> +{
> +	struct starfive_trng_plat *pdata = dev_get_plat(dev);
> +	int err;
> +
> +	err = clk_enable(pdata->hclk);
> +	if (err)
> +		return err;
> +
> +	err = clk_enable(pdata->ahb);
> +	if (err)

Doesn't need to disable the previous clk about pdata->hclk?


> +		return err;
> +
> +	err = reset_deassert(pdata->rst);
> +	if (err)

Ditto about clocks of hclk and ahb?

How about handle error?

err = clk_enable(pdata->hclk);
if (err)
	...

err = clk_enable(pdata->ahb);
if (err)
	goto err_ahb;

...

Return starfive_tring_init(pdata);

goto_err_reset:
	clk_disable(pdata->ahb);
goto err_ahb:
	clk_disable(pdata->hclk);

return err;

> +		return err;
> +
> +	pdata->mode = PRNG_256BIT;
> +
> +	return starfive_trng_init(pdata);
> +}
> +
> +static int starfive_trng_of_to_plat(struct udevice *dev)
> +{
> +	struct starfive_trng_plat *pdata = dev_get_plat(dev);
> +
> +	pdata->base = (void *)dev_read_addr(dev);
> +	if (!pdata->base)
> +		return -ENODEV;
> +
> +	pdata->hclk = devm_clk_get(dev, "hclk");
> +	if (IS_ERR(pdata->hclk))
> +		return -ENODEV;
> +
> +	pdata->ahb = devm_clk_get(dev, "ahb");
> +	if (IS_ERR(pdata->ahb))
> +		return -ENODEV;
> +
> +	pdata->rst = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(pdata->rst))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct dm_rng_ops starfive_trng_ops = {
> +	.read = starfive_trng_read,
> +};
> +
> +static const struct udevice_id starfive_trng_match[] = {
> +	{
> +		.compatible = "starfive,jh7110-trng",
> +	},
> +	{},
> +};
> +
> +U_BOOT_DRIVER(starfive_trng) = {
> +	.name = "jh7110-trng",
> +	.id = UCLASS_RNG,
> +	.of_match = starfive_trng_match,
> +	.probe = starfive_trng_probe,
> +	.ops = &starfive_trng_ops,
> +	.plat_auto = sizeof(struct starfive_trng_plat),
> +	.of_to_plat = starfive_trng_of_to_plat,
> +};
> --
> 2.39.2


