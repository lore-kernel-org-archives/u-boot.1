Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0847C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 01:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C077487CC1;
	Wed,  1 Nov 2023 02:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XdZ/Oqvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2010187CCB; Wed,  1 Nov 2023 02:18:22 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E22F87CC1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 02:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101011813epoutp04cda6402c6d340f302550e87e731acd8d~TWvUcFAoz2919129191epoutp04N
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 01:18:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101011813epoutp04cda6402c6d340f302550e87e731acd8d~TWvUcFAoz2919129191epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698801493;
 bh=P11juMM0E7Q9KBY/HqBeDlilcaIxnimsliFOfG9BRPA=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=XdZ/OqvwxNCHcvTbTq/wb8q1S72axH+MjzL/vh4GoaUaUNgDY6+xZvzgdw7RevRRW
 eDenKAq/Q+jRKKH7XOTHLT+uOreBx0SJ0+7+2E8sYMthfy/2oRFE7NF3mVxjpELrXW
 tJIxZem0IUEaZ0qSxD2HivU0tFNVPhVYbv3ahS9c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231101011812epcas2p27973daaa2733be58ff29032b3274a4d6~TWvUJghp23031830318epcas2p2h;
 Wed,  1 Nov 2023 01:18:12 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKpzS2yVdz4x9QH; Wed,  1 Nov
 2023 01:18:12 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 0E.14.10022.457A1456; Wed,  1 Nov 2023 10:18:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231101011812epcas2p1226d853e7d2b7026aa90e9db3f298bcb~TWvTSsEbp2758027580epcas2p1k;
 Wed,  1 Nov 2023 01:18:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101011811epsmtrp1f5f52fa31e2ed7b11bffff1435b84f1f~TWvTR62cK3198931989epsmtrp1O;
 Wed,  1 Nov 2023 01:18:11 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-a9-6541a7548e28
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 C9.1A.18939.357A1456; Wed,  1 Nov 2023 10:18:11 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101011811epsmtip116042d2e404be5820d011ab79e113f14~TWvTGf6xU2207022070epsmtip1Z;
 Wed,  1 Nov 2023 01:18:11 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Jaehoon Chung'" <jh80.chung@samsung.com>, "'Sughosh Ganu'"
 <sughosh.ganu@linaro.org>, "'Heinrich Schuchardt'" <xypron.glpk@gmx.de>,
 "'Rick Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <016c01da0c5d$b0449f30$10cddd90$@samsung.com>
Subject: RE: [PATCH v2 3/5] rng: Add StarFive JH7110 RNG driver
Date: Wed, 1 Nov 2023 10:18:11 +0900
Message-ID: <013c01da0c61$47e741f0$d7b5c5d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKT+xXLwr3a99t9wWLY9o27f2hMVAJJLqHvAhBbHJ0BifolVq7Br9eg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTXDdkuWOqQeszIYsbv9pYLd6+OMto
 ce+anMXbvZ3sFoenfmC0eHzoNZMDm8ee07OYPT58jPO4c20Pm8fZOzsYPfq2rGIMYI3KtslI
 TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
 FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ1x48w3
 toKHgRUbz3azNTB+se9i5OCQEDCROD63oIuRi0NIYAejxPmJ/xm7GDmBnE+MEi++FcHZ69+w
 gtgg9XevbmeEaNjJKNG79yI7RNELRokJX11BbDYBfYmXHdtYQYpEBF4zSkw8f5cFJMEpYCVx
 /PpDsEnCAvYSu3Z9ZwaxWQRUJHZ9fwFWwytgKXGj/SsbhC0ocXLmE7A4s4C8xPa3c5ghrlCQ
 +Pl0GdgcEQE3ibcf77FB1IhLvDx6hB1ksYTARA6J84c2M0K86SLx+X48RK+wxKvjW9ghbCmJ
 l/1t7BAl5RI7liVBtLYwSjS37YHaZS/x4+YUVpAaZgFNifW79CHKlSWO3IK6jE+i4/BfqCm8
 Eh1tQhCN6hIHtk9ngbBlJbrnfIYGoYfE8o0/WCYwKs5C8uMsJD/OQvLLLIS9CxhZVjGKpRYU
 56anFhsVGMMjOjk/dxMjOF1que9gnPH2g94hRiYOxkOMEhzMSiK8h00dUoV4UxIrq1KL8uOL
 SnNSiw8xmgJDfSKzlGhyPjBh55XEG5pYGpiYmRmaG5kamCuJ895rnZsiJJCeWJKanZpakFoE
 08fEwSnVwKTMpHvlOvvJa2/Mnj9MMZj16ad/1YzAy1dyTR22XjnweF1Cl+Ht+T0rnzFueyA4
 Yf+arTKahzQ7hXnO7OZYnnb2GbeSme60jfbex9ljFxyYdVKU8d2hrTHnXXJ3cb3l9Hd+zN91
 tCU9/Xr5Ro68LZHJHwK2em6X7Pth+meuCO+Fqhen3kY8OKfGckrNzMHmsIr608QSGbY4vtvy
 Xvuk3jqZ1dZXp63VFLsmfTDkSczJo+uXXF9kvvjUFrbTZ/6n3q85aSEhzX5W5xKLz4u+FSu8
 ORdGinryzauRfy1asUHyApuCv97tjk/O2e2fys+0VxoIMv39n6rcK/Um0zmqYVvmI0fHed89
 Pb/OrxGZ1avEUpyRaKjFXFScCAC6vI0qIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTjd4uWOqQctTc4sbv9pYLd6+OMto
 ce+anMXbvZ3sFoenfmC0eHzoNZMDm8ee07OYPT58jPO4c20Pm8fZOzsYPfq2rGIMYI3isklJ
 zcksSy3St0vgyrhx5htbwcPAio1nu9kaGL/YdzFyckgImEjcvbqdsYuRi0NIYDujxPtNlxgh
 ErISz97tYIewhSXutxxhhSh6xiix6NJhNpAEm4C+xMuObWAJEYH3jBIPb3SDdQgJfGWUWP0t
 A8TmFLCSOH79ISuILSxgL7Fr13dmEJtFQEVi1/cXLCA2r4ClxI32r2wQtqDEyZlPwOLMAtoS
 T28+hbLlJba/ncMMcZGCxM+ny1hhLv1zdC4bzKWvjm8Bu0FEwE3i7cd7bBC94hIvjx5hn8Ao
 MgvJillIVsxCsmIWkpYFjCyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYKjSitoB+Oy9X/1
 DjEycTAeYpTgYFYS4T1s6pAqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1
 ILUIJsvEwSnVwJQfKNa18ojwBAPd3Q+CNt5anraoyez4VKNPBxaUhFV8W+Q4//WWgH2C1xl2
 nRS80PVHZUMJT3jdS5WZxvU2hn7JS11zV3nddGteZJn3qt77nNX0xiuGm4p9WF7uud+4cVFX
 MX/1uW+PH6cqMBu+Pjm/Pu733/MneCUW340LnddVv+eN89vvplX5uw2FWFQ6ejZsTn8qES2U
 MtEw4MqNNR9rrfQsXr2UMPD2dwyut2eY+TWR8TMn02V/P7U7a9oakvU6Alczs846EbA690KI
 TsKGS1f9b1+7/ZFtdu/r5S/dJOx3SU79WezOULHxp2B4UXXI2keTHj5Q+Goe8tF1+wGRh3rJ
 8tVc+8IL38/avEOJpTgj0VCLuag4EQBNmX07GQMAAA==
X-CMS-MailID: 20231101011812epcas2p1226d853e7d2b7026aa90e9db3f298bcb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031235553epcas2p1e580a6b433c6e848368162a6b52e479d
References: <20231031235530.1500393-1-chanho61.park@samsung.com>
 <CGME20231031235553epcas2p1e580a6b433c6e848368162a6b52e479d@epcas2p1.samsung.com>
 <20231031235530.1500393-4-chanho61.park@samsung.com>
 <016c01da0c5d$b0449f30$10cddd90$@samsung.com>
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
> From: Jaehoon Chung <jh80.chung@samsung.com>
> Sent: Wednesday, November 1, 2023 9:52 AM
> To: 'Chanho Park' <chanho61.park@samsung.com>; 'Sughosh Ganu'
> <sughosh.ganu@linaro.org>; 'Heinrich Schuchardt' <xypron.glpk@gmx.de>;
> 'Rick Chen' <rick@andestech.com>; 'Leo' <ycliang@andestech.com>; u-
> boot@lists.denx.de
> Subject: RE: [PATCH v2 3/5] rng: Add StarFive JH7110 RNG driver
> 
> 
> 
> > -----Original Message-----
> > From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Chanho Park
> > Sent: Wednesday, November 1, 2023 8:55 AM
> > To: Sughosh Ganu <sughosh.ganu@linaro.org>; Heinrich Schuchardt
> <xypron.glpk@gmx.de>; Rick Chen
> > <rick@andestech.com>; Leo <ycliang@andestech.com>; u-boot@lists.denx.de
> > Cc: Chanho Park <chanho61.park@samsung.com>
> > Subject: [PATCH v2 3/5] rng: Add StarFive JH7110 RNG driver
> >
> > Adds to support JH7110 TRNG driver which is based on linux kernel's
> > jh7110-trng.c. This can support to generate 256-bit random numbers and
> > 128-bit but this makes 256-bit default for convenience.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > ---
> >  drivers/rng/Kconfig      |   6 +
> >  drivers/rng/Makefile     |   1 +
> >  drivers/rng/jh7110_rng.c | 258 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 265 insertions(+)
> >  create mode 100644 drivers/rng/jh7110_rng.c
> >
> > diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> > index 994cc35b2744..0dba1e06b429 100644
> > --- a/drivers/rng/Kconfig
> > +++ b/drivers/rng/Kconfig
> > @@ -91,4 +91,10 @@ config TPM_RNG
> >  	  functionality. Enable random number generator on TPM
> >  	  devices.
> >
> > +config RNG_JH7110
> > +	bool "StarFive JH7110 Random Number Generator support"
> > +	depends on DM_RNG && STARFIVE_JH7110
> > +	help
> > +	  Enable True Random Number Generator in StarFive JH7110 SoCs.
> > +
> >  endif
> > diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> > index 47b323e61ee3..9de762c8a1c3 100644
> > --- a/drivers/rng/Makefile
> > +++ b/drivers/rng/Makefile
> > @@ -15,3 +15,4 @@ obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
> >  obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
> >  obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
> >  obj-$(CONFIG_TPM_RNG) += tpm_rng.o
> > +obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
> > diff --git a/drivers/rng/jh7110_rng.c b/drivers/rng/jh7110_rng.c
> > new file mode 100644
> > index 000000000000..37ea8cc39945
> > --- /dev/null
> > +++ b/drivers/rng/jh7110_rng.c
> > @@ -0,0 +1,258 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * TRNG driver for the StarFive JH7110 SoC
> > + *
> > + */
> > +
> > +#include <clk.h>
> > +#include <dm.h>
> > +#include <reset.h>
> > +#include <rng.h>
> > +#include <asm/io.h>
> > +#include <linux/iopoll.h>
> > +
> > +/* trng register offset */
> > +#define STARFIVE_CTRL			0x00
> > +#define STARFIVE_STAT			0x04
> > +#define STARFIVE_MODE			0x08
> > +#define STARFIVE_SMODE			0x0C
> > +#define STARFIVE_IE			0x10
> > +#define STARFIVE_ISTAT			0x14
> > +#define STARFIVE_RAND0			0x20
> > +#define STARFIVE_RAND1			0x24
> > +#define STARFIVE_RAND2			0x28
> > +#define STARFIVE_RAND3			0x2C
> > +#define STARFIVE_RAND4			0x30
> > +#define STARFIVE_RAND5			0x34
> > +#define STARFIVE_RAND6			0x38
> > +#define STARFIVE_RAND7			0x3C
> > +#define STARFIVE_AUTO_RQSTS		0x60
> > +#define STARFIVE_AUTO_AGE		0x64
> > +
> > +/* CTRL CMD */
> > +#define STARFIVE_CTRL_EXEC_NOP		0x0
> > +#define STARFIVE_CTRL_GENE_RANDNUM	0x1
> > +#define STARFIVE_CTRL_EXEC_RANDRESEED	0x2
> > +
> > +/* STAT */
> > +#define STARFIVE_STAT_NONCE_MODE	BIT(2)
> > +#define STARFIVE_STAT_R256		BIT(3)
> > +#define STARFIVE_STAT_MISSION_MODE	BIT(8)
> > +#define STARFIVE_STAT_SEEDED		BIT(9)
> > +#define STARFIVE_STAT_LAST_RESEED(x)	((x) << 16)
> > +#define STARFIVE_STAT_SRVC_RQST		BIT(27)
> > +#define STARFIVE_STAT_RAND_GENERATING	BIT(30)
> > +#define STARFIVE_STAT_RAND_SEEDING	BIT(31)
> > +#define STARFIVE_STAT_RUNNING		(STARFIVE_STAT_RAND_GENERATING | \
> > +					 STARFIVE_STAT_RAND_SEEDING)
> > +
> > +/* MODE */
> > +#define STARFIVE_MODE_R256		BIT(3)
> > +
> > +/* SMODE */
> > +#define STARFIVE_SMODE_NONCE_MODE	BIT(2)
> > +#define STARFIVE_SMODE_MISSION_MODE	BIT(8)
> > +#define STARFIVE_SMODE_MAX_REJECTS(x)	((x) << 16)
> > +
> > +/* IE */
> > +#define STARFIVE_IE_RAND_RDY_EN		BIT(0)
> > +#define STARFIVE_IE_SEED_DONE_EN	BIT(1)
> > +#define STARFIVE_IE_LFSR_LOCKUP_EN	BIT(4)
> > +#define STARFIVE_IE_GLBL_EN		BIT(31)
> > +
> > +#define STARFIVE_IE_ALL			(STARFIVE_IE_GLBL_EN | \
> > +					 STARFIVE_IE_RAND_RDY_EN | \
> > +					 STARFIVE_IE_SEED_DONE_EN | \
> > +					 STARFIVE_IE_LFSR_LOCKUP_EN)
> > +
> > +/* ISTAT */
> > +#define STARFIVE_ISTAT_RAND_RDY		BIT(0)
> > +#define STARFIVE_ISTAT_SEED_DONE	BIT(1)
> > +#define STARFIVE_ISTAT_LFSR_LOCKUP	BIT(4)
> > +
> > +#define STARFIVE_RAND_LEN		sizeof(u32)
> > +
> > +enum mode {
> > +	PRNG_128BIT,
> > +	PRNG_256BIT,
> > +};
> > +
> > +struct starfive_trng_plat {
> > +	void *base;
> > +	struct clk *hclk;
> > +	struct clk *ahb;
> > +	struct reset_ctl *rst;
> > +	u32 mode;
> > +};
> > +
> > +static inline int starfive_trng_wait_idle(struct starfive_trng_plat
> *trng)
> > +{
> > +	u32 stat;
> > +
> > +	return readl_relaxed_poll_timeout(trng->base + STARFIVE_STAT, stat,
> > +					  !(stat & STARFIVE_STAT_RUNNING),
> > +					  100000);
> > +}
> > +
> > +static inline void starfive_trng_irq_mask_clear(struct
> starfive_trng_plat *trng)
> > +{
> > +	/* clear register: ISTAT */
> > +	u32 data = readl(trng->base + STARFIVE_ISTAT);
> > +
> > +	writel(data, trng->base + STARFIVE_ISTAT);
> > +}
> > +
> > +static int starfive_trng_cmd(struct starfive_trng_plat *trng, u32 cmd)
> > +{
> > +	u32 stat, flg;
> > +	int ret;
> > +
> > +	switch (cmd) {
> > +	case STARFIVE_CTRL_GENE_RANDNUM:
> > +		writel(cmd, trng->base + STARFIVE_CTRL);
> > +		flg = STARFIVE_ISTAT_RAND_RDY;
> > +		break;
> > +	case STARFIVE_CTRL_EXEC_RANDRESEED:
> > +		writel(cmd, trng->base + STARFIVE_CTRL);
> > +		flg = STARFIVE_ISTAT_SEED_DONE;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = readl_relaxed_poll_timeout(trng->base + STARFIVE_ISTAT, stat,
> > +					 (stat & flg), 1000);
> > +	writel(flg, trng->base + STARFIVE_ISTAT);
> > +
> > +	return ret;
> > +}
> > +
> > +static int starfive_trng_read(struct udevice *dev, void *data, size_t
> len)
> > +{
> > +	struct starfive_trng_plat *trng = dev_get_plat(dev);
> > +	u8 *buffer = data;
> > +	int iter_mask;
> > +
> > +	if (trng->mode == PRNG_256BIT)
> > +		iter_mask = 7;
> > +	else
> > +		iter_mask = 3;
> > +
> > +	for (int i = 0; len; ++i, i &= iter_mask) {
> > +		u32 val;
> > +		size_t step;
> > +		int ret;
> > +
> > +		ret = starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM);
> > +		if (ret)
> > +			return ret;
> > +
> > +		val = readl(trng->base + STARFIVE_RAND0 +
> > +			    (i * STARFIVE_RAND_LEN));
> > +		step = min_t(size_t, len, STARFIVE_RAND_LEN);
> > +		memcpy(buffer, &val, step);
> > +		buffer += step;
> > +		len -= step;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int starfive_trng_init(struct starfive_trng_plat *trng)
> > +{
> > +	u32 mode, intr = 0;
> > +
> > +	/* setup Auto Request/Age register */
> > +	writel(0, trng->base + STARFIVE_AUTO_AGE);
> > +	writel(0, trng->base + STARFIVE_AUTO_RQSTS);
> > +
> > +	/* clear register: ISTAT */
> > +	starfive_trng_irq_mask_clear(trng);
> > +
> > +	intr |= STARFIVE_IE_ALL;
> > +	writel(intr, trng->base + STARFIVE_IE);
> > +
> > +	mode = readl(trng->base + STARFIVE_MODE);
> > +
> > +	switch (trng->mode) {
> > +	case PRNG_128BIT:
> > +		mode &= ~STARFIVE_MODE_R256;
> > +		break;
> > +	case PRNG_256BIT:
> > +		mode |= STARFIVE_MODE_R256;
> > +		break;
> > +	default:
> > +		mode |= STARFIVE_MODE_R256;
> > +		break;
> > +	}
> > +
> > +	writel(mode, trng->base + STARFIVE_MODE);
> > +
> > +	return starfive_trng_cmd(trng, STARFIVE_CTRL_EXEC_RANDRESEED);
> > +}
> > +
> > +static int starfive_trng_probe(struct udevice *dev)
> > +{
> > +	struct starfive_trng_plat *pdata = dev_get_plat(dev);
> > +	int err;
> > +
> > +	err = clk_enable(pdata->hclk);
> > +	if (err)
> > +		return err;
> > +
> > +	err = clk_enable(pdata->ahb);
> > +	if (err)
> 
> Doesn't need to disable the previous clk about pdata->hclk?
> 
> 
> > +		return err;
> > +
> > +	err = reset_deassert(pdata->rst);
> > +	if (err)
> 
> Ditto about clocks of hclk and ahb?
> 
> How about handle error?
> 
> err = clk_enable(pdata->hclk);
> if (err)
> 	...
> 
> err = clk_enable(pdata->ahb);
> if (err)
> 	goto err_ahb;
> 
> ...
> 
> Return starfive_tring_init(pdata);
> 
> goto_err_reset:
> 	clk_disable(pdata->ahb);
> goto err_ahb:
> 	clk_disable(pdata->hclk);
> 
> return err;

Thank you for your suggestion.
I'll update the codes in the next patchset.

Best Regards,
Chanho Park

> 
> > +		return err;
> > +
> > +	pdata->mode = PRNG_256BIT;
> > +
> > +	return starfive_trng_init(pdata);
> > +}
> > +
> > +static int starfive_trng_of_to_plat(struct udevice *dev)
> > +{
> > +	struct starfive_trng_plat *pdata = dev_get_plat(dev);
> > +
> > +	pdata->base = (void *)dev_read_addr(dev);
> > +	if (!pdata->base)
> > +		return -ENODEV;
> > +
> > +	pdata->hclk = devm_clk_get(dev, "hclk");
> > +	if (IS_ERR(pdata->hclk))
> > +		return -ENODEV;
> > +
> > +	pdata->ahb = devm_clk_get(dev, "ahb");
> > +	if (IS_ERR(pdata->ahb))
> > +		return -ENODEV;
> > +
> > +	pdata->rst = devm_reset_control_get(dev, NULL);
> > +	if (IS_ERR(pdata->rst))
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dm_rng_ops starfive_trng_ops = {
> > +	.read = starfive_trng_read,
> > +};
> > +
> > +static const struct udevice_id starfive_trng_match[] = {
> > +	{
> > +		.compatible = "starfive,jh7110-trng",
> > +	},
> > +	{},
> > +};
> > +
> > +U_BOOT_DRIVER(starfive_trng) = {
> > +	.name = "jh7110-trng",
> > +	.id = UCLASS_RNG,
> > +	.of_match = starfive_trng_match,
> > +	.probe = starfive_trng_probe,
> > +	.ops = &starfive_trng_ops,
> > +	.plat_auto = sizeof(struct starfive_trng_plat),
> > +	.of_to_plat = starfive_trng_of_to_plat,
> > +};
> > --
> > 2.39.2
> 


