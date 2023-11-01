Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C28C4167B
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BFFD8770E;
	Wed,  1 Nov 2023 13:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="NRb9zwgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA2F87710; Wed,  1 Nov 2023 13:10:27 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D276287702
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231101121019epoutp01c2e9e58b2432ad7bdf90156b5aadfdb8~Tforh1H9Y1239412394epoutp01N
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:10:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231101121019epoutp01c2e9e58b2432ad7bdf90156b5aadfdb8~Tforh1H9Y1239412394epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698840619;
 bh=Fk2jbHnaVJEb091Mgz3tm4RxvqwTB0uJTyUft96jQ6E=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=NRb9zwgqH/6/PATQjXRMRbHoAF4eryYXbyGw1Y2RWq2QyQ89AzXKa6yw7ZKbEBUD3
 HESfLU2J8tYLplJjVU9G2QZZAlxvsVYN++m9SEsQVvYnAi+qIAmqK3ZxCEyO6LZ1O8
 YGTan2eHF8vVc0v2bVecV0eDtu87RbHBeMujtmQI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231101121018epcas2p168060df23372db5a282c96230f7b2a24~TforA6ppi0531205312epcas2p1T;
 Wed,  1 Nov 2023 12:10:18 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SL5Rt3bfRz4x9Pt; Wed,  1 Nov
 2023 12:10:18 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 D7.02.09607.A2042456; Wed,  1 Nov 2023 21:10:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231101121018epcas2p2bc3c00b78b4f7048ea876691b9054724~TfoqU9tVe1183111831epcas2p2f;
 Wed,  1 Nov 2023 12:10:18 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101121018epsmtrp124d5d6c08d327354e8b0b8500f11dc02~TfoqUWvr23072630726epsmtrp11;
 Wed,  1 Nov 2023 12:10:18 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-bd-6542402a34df
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 74.E2.18939.92042456; Wed,  1 Nov 2023 21:10:17 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101121017epsmtip26b918681d4c5aef3bb2c78a7963aa892~TfoqHPI8k0204102041epsmtip2S;
 Wed,  1 Nov 2023 12:10:17 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Heinrich Schuchardt'" <xypron.glpk@gmx.de>
Cc: "'Sughosh Ganu'" <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>,
 "'Rick Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>,
 "'Jaehoon Chung'" <jh80.chung@samsung.com>
In-Reply-To: <e3df899c-0510-4dc1-8868-0c5a41732350@gmx.de>
Subject: RE: [PATCH v3 3/5] rng: Add StarFive JH7110 RNG driver
Date: Wed, 1 Nov 2023 21:10:17 +0900
Message-ID: <01c701da0cbc$60e227f0$22a677d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJPEwdrzRv1A9DpY22BSMay/vjCawI90PYIARQgf8sCg3uM7K9MpsQA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmma6Wg1OqweEDUhY3frWxWrx9cZbR
 4t41OYu3ezvZLQ5P/cBo8fjQayYHNo89p2cxe3z4GOdx59oeNo+zd3YwevRtWcUYwBqVbZOR
 mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
 KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITujZ/El
 loIrphXXZ19nbGCco9XFyMEhIWAiMfefQRcjF4eQwA5Gidl7NjNDOJ8YJXb/nMYK53ybsoax
 i5ETrGPa4cVMEImdjBLLZr5ig3BeMEo87ZnNAlLFJqAv8bJjGyuILSJgIHFxzjJ2kCJmgd2M
 Eud/zQMr4hSwkuhYdBtsrLCAvUTLlc1gcRYBFYn/t/rYQGxeAUuJtXe3skDYghInZz4Bs5kF
 5CW2v53DDHGSgsTPp8uglrlJfF4+kRGiRlzi5dEjYIslBGZySLTcOAv1g4tE18XNbBC2sMSr
 41vYIWwpiZf9beyQkCmX2LEsCaK3hVGiuW0P1DJ7iR83p7CC1DALaEqs36UPUa4sceQW1Gl8
 Eh2H/0JN4ZXoaBOCaFSXOLB9OguELSvRPecz6wRGpVlIHpuF5LFZSB6YhbBrASPLKkax1ILi
 3PTUYqMCE3hkJ+fnbmIEp00tjx2Ms99+0DvEyMTBeIhRgoNZSYT3sKlDqhBvSmJlVWpRfnxR
 aU5q8SFGU2BQT2SWEk3OBybuvJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg
 +pg4OKUamPrMfU78NXZNOP1HPdo0s5XrwtOT+zbuDmbsSkkR7fB4sPPo8YRbDWUxp8RYzfgX
 T9DomRTMfGLt9oZ7NfVzloXNt72hOufdhKv7trCfMvKafnrSyUozR8HCiXyylvlLnhY0flnh
 ZLlVIiDWXOguly5nHcNMab0Tu+/aJS4/9M3rTtO+gCunes4//H6qtXQ5w927Layv3x7WrO+7
 +7p6x6+jl9znXBX2+nfouzlb54b+w2f2b3+guS3JuT3XyGb/3gqeJ8kHvp89r1BR9/ruB9Gl
 EhtK/RqENRbHb765P9JoPe8s9bad0/07t91Yf8Pm75uTlV3C8sfVTuxv4SwS2bSy6PLLA2bq
 N6OYXmr/kVZUYinOSDTUYi4qTgQA8bDc4iQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvK6Wg1OqwQ1uixu/2lgt3r44y2hx
 75qcxdu9newWh6d+YLR4fOg1kwObx57Ts5g9PnyM87hzbQ+bx9k7Oxg9+rasYgxgjeKySUnN
 ySxLLdK3S+DK6Fl8iaXgimnF9dnXGRsY52h1MXJySAiYSEw7vJgJxBYS2M4osXSvEURcVuLZ
 ux3sELawxP2WI6xdjFxANc8YJZ78us8KkmAT0Jd42bENzBYRMJC4OGcZO0gRs8B+Ronu06/Z
 ITq+MkrcftrPDFLFKWAl0bHoNiOILSxgL9FyZTMLiM0ioCLx/1YfG4jNK2ApsfbuVhYIW1Di
 5MwnYDazgLbE05tPoWx5ie1v5zBDnKcg8fPpMlaYs/8cncsGc/ar41vYIa5zk/i8fCIjRK+4
 xMujR9gnMIrOQrJiFpIVs5CsmIWkZQEjyypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4FjT
 CtrBuGz9X71DjEwcjIcYJTiYlUR4D5s6pArxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBES
 SE8sSc1OTS1ILYLJMnFwSjUwJWTP/rxptlqpXOqTZZ+vmx1We51srP+ntfDLSskUQ1ZLVU3F
 Ut4Jq0W5Y9WN52ZtdHD6br5HvNwpvUpVq+N5YZPA5yaTwzM9f0Wym2xs7rvxotH1fITHVZbp
 V2smTdi2d62C2KTIB3ND+040RT0ufaVwe8fjS++n/dkw+fvKRWvfhj7lP23MrM42a9rjyHmX
 jP45Tzt68KTJYrMlF0vubpfKOTa5ojiyJdHNRPLatABBner1OZk2HfoXL7K/d1hV+T2q/cmJ
 m+3egp4zOV7wL19jpXt6ViAT4/+r/JPN6lSfbrmR/Pmet+FlAXHujh/fDr1y7JyR2c718nn1
 tRzjRsHWXpnYgw3/f5Xum7R4jhJLcUaioRZzUXEiAKX8FtwkAwAA
X-CMS-MailID: 20231101121018epcas2p2bc3c00b78b4f7048ea876691b9054724
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101114040epcas2p3658fcb45be38f9928884983b7441c5ef
References: <20231101114017.1845960-1-chanho61.park@samsung.com>
 <CGME20231101114040epcas2p3658fcb45be38f9928884983b7441c5ef@epcas2p3.samsung.com>
 <20231101114017.1845960-4-chanho61.park@samsung.com>
 <e3df899c-0510-4dc1-8868-0c5a41732350@gmx.de>
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

Hi,

> -----Original Message-----
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Sent: Wednesday, November 1, 2023 9:00 PM
> To: Chanho Park <chanho61.park@samsung.com>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>; u-boot@lists.denx.de; Rick
> Chen <rick@andestech.com>; Leo <ycliang@andestech.com>; Jaehoon Chung
> <jh80.chung@samsung.com>
> Subject: Re: [PATCH v3 3/5] rng: Add StarFive JH7110 RNG driver
> 
> On 11/1/23 13:40, Chanho Park wrote:
> > Adds to support JH7110 TRNG driver which is based on linux kernel's
> > jh7110-trng.c. This can support to generate 256-bit random numbers and
> > 128-bit but this makes 256-bit default for convenience.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > ---
> >   drivers/rng/Kconfig      |   6 +
> >   drivers/rng/Makefile     |   1 +
> >   drivers/rng/jh7110_rng.c | 271 +++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 278 insertions(+)
> >   create mode 100644 drivers/rng/jh7110_rng.c
> >
> > diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> > index 994cc35b2744..0dba1e06b429 100644
> > --- a/drivers/rng/Kconfig
> > +++ b/drivers/rng/Kconfig
> > @@ -91,4 +91,10 @@ config TPM_RNG
> >   	  functionality. Enable random number generator on TPM
> >   	  devices.
> >
> > +config RNG_JH7110
> > +	bool "StarFive JH7110 Random Number Generator support"
> > +	depends on DM_RNG && STARFIVE_JH7110
> > +	help
> > +	  Enable True Random Number Generator in StarFive JH7110 SoCs.
> > +
> >   endif
> > diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> > index 47b323e61ee3..9de762c8a1c3 100644
> > --- a/drivers/rng/Makefile
> > +++ b/drivers/rng/Makefile
> > @@ -15,3 +15,4 @@ obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
> >   obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
> >   obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
> >   obj-$(CONFIG_TPM_RNG) += tpm_rng.o
> > +obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
> > diff --git a/drivers/rng/jh7110_rng.c b/drivers/rng/jh7110_rng.c
> > new file mode 100644
> > index 000000000000..075a2d78eb2c
> > --- /dev/null
> > +++ b/drivers/rng/jh7110_rng.c
> > @@ -0,0 +1,271 @@
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
> 
> I think you are missing
> 
>     if (!i) {
> 
> here as one call to starfive_trng_cmd is giving you 128 or 256 bits of
> entropy.
> 
> > +		ret = starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM);
> 
> }

Oh. I missed this while I made the patches. Thanks for the heads up.
I'll quickly update it in the next patch.

Best Regards,
Chanho Park

