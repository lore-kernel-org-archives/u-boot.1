Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28FCC4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 23:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 093278652B;
	Wed,  1 Nov 2023 00:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="HNyGDx8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5EE8652B; Wed,  1 Nov 2023 00:12:55 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF60586487
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031231241epoutp0236bca471235b1c2bb04964a89b771c43~TVBuKnDqi2096520965epoutp026
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 23:12:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031231241epoutp0236bca471235b1c2bb04964a89b771c43~TVBuKnDqi2096520965epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698793961;
 bh=iqauAZOOQhLeAGB4Uj23RHh3VczQGCjeNmZl4g4jCXY=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=HNyGDx8fO1ErVYimlqCFSXjqmUI4NieehlO/Id1TCooAZO6oX5qB5Tk2sGq0OKNNp
 1KKGxBMyV06zlD2Fckgt0BPFQol/MGgH14r9DaeThoQgJf6MqbPcih8XwyG9Bd0pZ2
 ouCgEB+zpL3D6/lPVZi2lSz4AIhfoJmqb4n76ux8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231031231241epcas2p404997bc73fef85ade050633b1434d654~TVBt6aUni0827008270epcas2p43;
 Tue, 31 Oct 2023 23:12:41 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKmBd0mt6z4x9Pt; Tue, 31 Oct
 2023 23:12:41 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 D4.83.10022.8E981456; Wed,  1 Nov 2023 08:12:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231031231240epcas2p13311e601e52dc605113a6b15f485b12f~TVBtRhELS3208832088epcas2p1U;
 Tue, 31 Oct 2023 23:12:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031231240epsmtrp176ab3aad25f520a6f07afc9cdb87e051~TVBtQ6FTz2514225142epsmtrp1s;
 Tue, 31 Oct 2023 23:12:40 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-74-654189e844c1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 43.29.08755.8E981456; Wed,  1 Nov 2023 08:12:40 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031231240epsmtip1a2830494d72497c44764fb3f42f27780~TVBtAocyX1274512745epsmtip1X;
 Tue, 31 Oct 2023 23:12:40 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Heinrich Schuchardt'" <xypron.glpk@gmx.de>
Cc: "'Sughosh Ganu'" <sughosh.ganu@linaro.org>, "'Rick Chen'"
 <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <ff82b420-6226-436f-9f95-01411eaa8289@gmx.de>
Subject: RE: [PATCH 3/5] rng: Add StarFive JH7110 RNG driver
Date: Wed, 1 Nov 2023 08:12:40 +0900
Message-ID: <010601da0c4f$bee10aa0$3ca31fe0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIxN1qPwsf+qgiFZA69rww+o6NUzAIKbSreAWDPPZoDRztsf6+Am/wA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTQvdlp2OqQYeoxdsXZxkt7l2Ts3i7
 t5Pd4vDUD4wWjw+9ZnJg9dhzehazx4ePcR53ru1h8zh7ZwdjAEtUtk1GamJKapFCal5yfkpm
 XrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0FYlhbLEnFKgUEBicbGSvp1NUX5p
 SapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG9+rfbAXdURXv3mxjbmD8
 7NLFyMkhIWAisWbTIRYQW0hgB6PE800lXYxcQPYnRolzVz4wQzjfGCU+PJrLBtPxe9JjdojE
 XkaJTfeusEG0v2CUuHarGsRmE9CXeNmxjRXEFhEwkLg4ZxlYA7NAP6PEodnv2EESnAJWEpO2
 LwbbLSxgI/F9cSdYnEVAReLA1WdgQ3kFLCUmX+tjhrAFJU7OfAJWzywgL7H97RxmiIsUJH4+
 XQa1zE3ixNeHzBA14hIvjx4BWywhMJFD4vfsF1ANLhLL5yyBekdY4tXxLewQtpTEy/42IJsD
 yC6X2LEsCaK3hVGiuW0PVK+9xI+bU1hBapgFNCXW79KHKFeWOHIL6jQ+iY7Df6Gm8Ep0tAlB
 NKpLHNg+nQXClpXonvOZdQKj0iwkj81C8tgsJA/MQti1gJFlFaNYakFxbnpqsVGBMTyuk/Nz
 NzGC06OW+w7GGW8/6B1iZOJgPMQowcGsJMJ72NQhVYg3JbGyKrUoP76oNCe1+BCjKTCoJzJL
 iSbnAxN0Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTGvKDFq5
 HA+0zHR8mH9U++py9ZdGkqJ6PzIe/PugbqaaeuLper5uQ2HlgwxHAk1MNHRzw2YF9nQFPKuz
 ZzbnsJPPcdhdOD/y8L3f/57mL117+yln8Hd127Dtnhzfevhk1/UFnUpZtHWhpdbDvfzXDKbk
 /HDoO/JM4rjC8938rdM9Q2WbuaV+BZrsbVhvlD17xqV09zNFAaFZDXrejZ83VWW2u+7vPRIU
 MPfPRYf78iyRebK/Jzvr6kQv1+FYMe1Mx6y9UnvrpOevVzh8a++znd9Wfvu503v78o2Jd74w
 VRRXzVJ9Yti6+W8BW9FbvytbXy08OvkS+8voV6/4lEz7kzN3mU07+j9YYL7WQ43Ke0osxRmJ
 hlrMRcWJAPFd9CQYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTvdFp2Oqwco2FYu3L84yWty7Jmfx
 dm8nu8XhqR8YLR4fes3kwOqx5/QsZo8PH+M87lzbw+Zx9s4OxgCWKC6blNSczLLUIn27BK6M
 7tW/2Qq6oyrevdnG3MD42aWLkZNDQsBE4vekx+wgtpDAbkaJR/NEIeKyEs/e7WCHsIUl7rcc
 Ye1i5AKqecYosXfBbGaQBJuAvsTLjm2sILaIgIHExTnL2EGKmAUmMkqcfHmMHaLjM6PExj+9
 LCBVnAJWEpO2LwazhQVsJL4v7gRbwSKgInHg6jM2EJtXwFJi8rU+ZghbUOLkzCdg9cwC2hJP
 bz6FsuUltr+dwwxxnoLEz6fLWGHO/nN0LhvM2a+Ob2GHuM5N4sTXh8wQveISL48eYZ/AKDoL
 yYpZSFbMQrJiFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNMS3MH4/ZV
 H/QOMTJxMB5ilOBgVhLhPWzqkCrEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2
 ampBahFMlomDU6qBSSUvUifrLH9bfDNP9JXX/S4BHHW1m5ssNt74MzfU8Vn4p6MhJeHvTh04
 K/r6SlbDt9Nz57+OWf7CRdStRilEsJs5MONzWGTKsaD1Abcl43o8fwif8hUs318a6hfrV9yS
 +Fs1I/zqxhuCk9Zlp57WW7lylyLPEde+VksvX9XuLIfluwTl7BMzYt6bZ89e6jrht2XgEbuy
 TxrNH79t0S79XuOYw5G8vP1Pd/BLuZi1UjPmadyNDOBrnj1pR4xVzgo7mWiBVw6bki+VBzgq
 1j5asvK5+tpegW/TTsrYzm8us6lTrmjPrQtSzT5+UN38we4nyucWxM9X1z//W/NVb3v0jFNz
 i/+fWbvY5lnZt0wlluKMREMt5qLiRADbxxzFHwMAAA==
X-CMS-MailID: 20231031231240epcas2p13311e601e52dc605113a6b15f485b12f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231030073229epcas2p19e6145de5e8b740125bbc523fbcc4f66
References: <20231030073204.150030-1-chanho61.park@samsung.com>
 <CGME20231030073229epcas2p19e6145de5e8b740125bbc523fbcc4f66@epcas2p1.samsung.com>
 <20231030073204.150030-4-chanho61.park@samsung.com>
 <ff82b420-6226-436f-9f95-01411eaa8289@gmx.de>
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
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Sent: Wednesday, November 1, 2023 6:18 AM
> To: Chanho Park <chanho61.park@samsung.com>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>; Rick Chen <rick@andestech.com>;
> Leo <ycliang@andestech.com>; u-boot@lists.denx.de
> Subject: Re: [PATCH 3/5] rng: Add StarFive JH7110 RNG driver
> 
> On 10/30/23 09:32, Chanho Park wrote:
> > Adds to support JH7110 TRNG driver which is based on linux kernel's
> > jh7110-trng.c. This can support to generate 256-bit random numbers and
> > 128-bit but this makes 256-bit default for convenience.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > ---
> >   drivers/rng/Kconfig      |   6 +
> >   drivers/rng/Makefile     |   1 +
> >   drivers/rng/jh7110_rng.c | 272 +++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 279 insertions(+)
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
> > index 000000000000..e71bf188f017
> > --- /dev/null
> > +++ b/drivers/rng/jh7110_rng.c
> > @@ -0,0 +1,272 @@
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
> > +	char *buffer = (char *)data;
> 
> Great to see a RNG driver for this SoC.
> 
> The conversion is not needed in C and should be removed.

Thank you for your kind review.
I'll remove it in the next patch.

> 
> > +	int ret;
> > +	size_t max;
> > +
> > +	if (trng->mode == PRNG_256BIT)
> > +		max = min_t(size_t, max, (STARFIVE_RAND_LEN * 8));
> > +	else
> > +		max = min_t(size_t, max, (STARFIVE_RAND_LEN * 4));
> > +
> > +	ret = starfive_trng_wait_idle(trng);
> > +	if (ret)
> > +		return -ETIMEDOUT;
> > +
> > +	while (len) {
> > +		size_t max;
> > +		u32 val, step;
> 
> Variables should be defined in the loop where they are used.
> Use size_t for step as this is what memcpy() needs as argument.
> 
> > +
> > +		if (trng->mode == PRNG_256BIT)
> 
> The arguments of this if-statement are not changed in the loop. We don't
> really need the variable max. The number of iterations would be enough:
> 
>      if (trng->mode == PRNG_256BIT)
>          rounds = 8;
>      else
>          rounds = 4;
>      while(len) {
> 
> > +			max = min_t(size_t, len, (STARFIVE_RAND_LEN * 8));
> > +		else
> > +			max = min_t(size_t, len, (STARFIVE_RAND_LEN * 4));
> > +
> > +		ret = starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM);
> > +		if (ret)
> > +			return ret;
> > +
> > +		for (int i = 0; i < DIV_ROUND_UP(max, STARFIVE_RAND_LEN);
> i++) {
> 
> You are decrementing max in the loop. So on every iteration
> DIV_ROUND_UP(max, STARFIVE_RAND_LEN) will result in different result. I
> don't believe this is intended.
> 
> > +			val = readl(trng->base + STARFIVE_RAND0 +
> > +				    (i * STARFIVE_RAND_LEN));
> > +			step = (max >= STARFIVE_RAND_LEN) ?
> > +				STARFIVE_RAND_LEN : max;
> 
> Please, stay consistent in your style and use min_t().
> 
> > +			memcpy(buffer, &val, step);
> > +
> > +			max -= step;
> > +			buffer += step;
> > +			len -= step;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> The following code looks a bit easier to read:
> 
> u8 *buffer = data;
> int iter_mask;
> 
> if (trng->mode == PRNG_256BIT)
>      iter_mask = 7;
> else
>      iter_mask = 3;
> 
> for (int i = 0; len; ++i, i &= iter_mask)
>      u32 val;
>      size_t step;
> 
>      if (!i) {
>           int ret;
> 
>           ret = starfive_trng_wait_idle(trng);
>           if (ret)
>                return -ETIMEDOUT;
>       }
>       val = read_l(trng->base + STARFIVE_RAND0 +
>             (i * STARFIVE_RAND_LEN));
>       step = min_t(size_t, len, STARFIVE_RAND_LEN);
>       memcpy (buffer, &val, step);
>       len -= step;
> }

That's a good suggestion, so let's apply the code.

Best Regards,
Chanho Park

> 
> Best regards
> 
> Heinrich
> 
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
> > +		return err;
> > +
> > +	err = reset_deassert(pdata->rst);
> > +	if (err)
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


