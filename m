Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D6CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B44087701;
	Wed,  1 Nov 2023 12:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qeAfwNom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C0487703; Wed,  1 Nov 2023 12:59:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFD787700
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698839984; x=1699444784; i=xypron.glpk@gmx.de;
 bh=QkSl/3qETEbBm0Huu+v5wIN6HqrEifNVU8oRaNLqVOg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=qeAfwNomKkNyvoRHjIu7eaMVzCeK4Nfk9SIFvHH+afpNgWIowgifYXOc7vdXGG6r
 /d9qgWexgE9voYby9YTZI6VHQxQ0wyoNdTUMyvQLkPwhP6/O35mCVVUKIbOEXW9Sf
 rVuQeIafsd3F7N4FZK+sZFJAb3ULMrMhd8MOiNTh02+/vSyf27wt8662x7/aFLWhb
 NJ2+yWnNQaqNV2OkaqlqelobxeGRl48UpRz7TzhxikrPzX/BuYLyHboqzPpklCGGa
 h3ZP1UQ08eLuXagu4ezxWtGPdavx/zNhYOlfQrfnMNUPqRs+vA3jikm6sJtaVrBAN
 iD/4PYfDIYzIA8Vcgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.29.1] ([159.148.28.2]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1qkjlT0F0N-00MuOE; Wed, 01
 Nov 2023 12:59:44 +0100
Message-ID: <e3df899c-0510-4dc1-8868-0c5a41732350@gmx.de>
Date: Wed, 1 Nov 2023 13:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] rng: Add StarFive JH7110 RNG driver
To: Chanho Park <chanho61.park@samsung.com>
References: <20231101114017.1845960-1-chanho61.park@samsung.com>
 <CGME20231101114040epcas2p3658fcb45be38f9928884983b7441c5ef@epcas2p3.samsung.com>
 <20231101114017.1845960-4-chanho61.park@samsung.com>
Content-Language: en-US, de-DE
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231101114017.1845960-4-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AbarLVJpelH0iu2weKViZ446/W22Iobf85CF1k/54vqbmqtRfva
 woU4kwIOy4Hj3ybPN/aDuEzzwIORp3P7TI+uHjwpYA1GzsVjVGqyUALswXpCHbmJw3hxShd
 hsYllUYHNUZsR60vrrwUC1mG/Mx+UTG5W7VHkF730XvWGdBy7Oja+9FBrg136SjjxdLUieM
 t9VsOh0RJUtE/ewid5GGg==
UI-OutboundReport: notjunk:1;M01:P0:RWIZWkoYgd0=;MhGPylJOKiZMiUW4m/CzLYGaux5
 ITQ2QVS7JqTb9UzUQ2Sps4YpV1HRlU5vT6iAbyUm8HU3i7vwBEm2c77Pad6kM9jbATMNMHnOE
 dHQo6AB1MHn+4lrR//aqBG908EGbMjTNVn1gQvk1cVPVDt4hT6ozL/63IS8yacT3RCx4y2OA7
 LI/oJXCIIqCjggXhEKm1zf9JGNfCEpn3gH2X3Tj0FHYRjCVf83G7JxBnbZpcxc1eXqo2Iy+Q3
 5EemlQBTrNfjTiy0KV3dtUH9YjHcTv4Kx++Cnow7u/5512bkBCO7t1Djkbxg3ATdKYPd9Gq0z
 agVjTQ7C3D+yL6Hcf+s+KsCQIBfTspNGu/AariWCZp4W0a35AdwfK3awB9moFipZUaNBk8k9V
 seNW0kq7SHmWOi+QOVDidva75fCodalt1zvCN4tTE/4r2VDj+l1cp7NvWeF+jiUfV5Ua2GGvb
 BecCxUMWf0kJ/KqD8EuGgKw85P8PoAHL7k5lP/HQdhiVFa+Xhkw40OJG7t9zIHEvckhQkr7sT
 jei6EljjZYKETWEYSqcWdP+cV/U2/Z6aphFyJDsSEFyHdtIoz5yA4MzwibZZcZb3+JvZi+16i
 1g/zk6b6BOMXoD1VgTjaSuHsk+2ACl5cVutiAsrd8097/xMtL1f9PzJ/bpmEjtNi4xXBPMGQr
 fHOfSBtWgeFGyC1mUL0trbQ6CckWpvhJ9PrxKQLte72L1H8gceGPy4V/sY1keDjgy0Knnbdf9
 v+HfQUJNePml2A2WesNG3lE4SVvwfLZVCdEKVj3rhGpkH2thY3UWbr8vw/bAWoKSIllG34RRI
 gXXhlnqLCp4RxD6ulCRk+jy7zAxdOZ4rOxQAd2rEY+rFZNWUad4xp9jeRNtAvjfK1OZxqM/fV
 XTsijiQcEbVbxaJMVRPbL7t4a2hp8khdW5aRDzYCraDOhW3YW9c9MoH+Mnzd85jpVf5auL7ql
 vchy1M1HFOI0bq3MwMVI8/0Ix/o=
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

On 11/1/23 13:40, Chanho Park wrote:
> Adds to support JH7110 TRNG driver which is based on linux kernel's
> jh7110-trng.c. This can support to generate 256-bit random numbers and
> 128-bit but this makes 256-bit default for convenience.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>   drivers/rng/Kconfig      |   6 +
>   drivers/rng/Makefile     |   1 +
>   drivers/rng/jh7110_rng.c | 271 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 278 insertions(+)
>   create mode 100644 drivers/rng/jh7110_rng.c
>
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index 994cc35b2744..0dba1e06b429 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -91,4 +91,10 @@ config TPM_RNG
>   	  functionality. Enable random number generator on TPM
>   	  devices.
>
> +config RNG_JH7110
> +	bool "StarFive JH7110 Random Number Generator support"
> +	depends on DM_RNG && STARFIVE_JH7110
> +	help
> +	  Enable True Random Number Generator in StarFive JH7110 SoCs.
> +
>   endif
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 47b323e61ee3..9de762c8a1c3 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_RNG_IPROC200) +=3D iproc_rng200.o
>   obj-$(CONFIG_RNG_SMCCC_TRNG) +=3D smccc_trng.o
>   obj-$(CONFIG_RNG_ARM_RNDR) +=3D arm_rndr.o
>   obj-$(CONFIG_TPM_RNG) +=3D tpm_rng.o
> +obj-$(CONFIG_RNG_JH7110) +=3D jh7110_rng.o
> diff --git a/drivers/rng/jh7110_rng.c b/drivers/rng/jh7110_rng.c
> new file mode 100644
> index 000000000000..075a2d78eb2c
> --- /dev/null
> +++ b/drivers/rng/jh7110_rng.c
> @@ -0,0 +1,271 @@
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
> +static inline int starfive_trng_wait_idle(struct starfive_trng_plat *tr=
ng)
> +{
> +	u32 stat;
> +
> +	return readl_relaxed_poll_timeout(trng->base + STARFIVE_STAT, stat,
> +					  !(stat & STARFIVE_STAT_RUNNING),
> +					  100000);
> +}
> +
> +static inline void starfive_trng_irq_mask_clear(struct starfive_trng_pl=
at *trng)
> +{
> +	/* clear register: ISTAT */
> +	u32 data =3D readl(trng->base + STARFIVE_ISTAT);
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
> +		flg =3D STARFIVE_ISTAT_RAND_RDY;
> +		break;
> +	case STARFIVE_CTRL_EXEC_RANDRESEED:
> +		writel(cmd, trng->base + STARFIVE_CTRL);
> +		flg =3D STARFIVE_ISTAT_SEED_DONE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret =3D readl_relaxed_poll_timeout(trng->base + STARFIVE_ISTAT, stat,
> +					 (stat & flg), 1000);
> +	writel(flg, trng->base + STARFIVE_ISTAT);
> +
> +	return ret;
> +}
> +
> +static int starfive_trng_read(struct udevice *dev, void *data, size_t l=
en)
> +{
> +	struct starfive_trng_plat *trng =3D dev_get_plat(dev);
> +	u8 *buffer =3D data;
> +	int iter_mask;
> +
> +	if (trng->mode =3D=3D PRNG_256BIT)
> +		iter_mask =3D 7;
> +	else
> +		iter_mask =3D 3;
> +
> +	for (int i =3D 0; len; ++i, i &=3D iter_mask) {
> +		u32 val;
> +		size_t step;
> +		int ret;
> +

I think you are missing

    if (!i) {

here as one call to starfive_trng_cmd is giving you 128 or 256 bits of
entropy.

> +		ret =3D starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM);

}

Best regards

Heinrich

> +		if (ret)
> +			return ret;
> +
> +		val =3D readl(trng->base + STARFIVE_RAND0 +
> +			    (i * STARFIVE_RAND_LEN));
> +		step =3D min_t(size_t, len, STARFIVE_RAND_LEN);
> +		memcpy(buffer, &val, step);
> +		buffer +=3D step;
> +		len -=3D step;
> +	}
> +
> +	return 0;
> +}
> +
> +static int starfive_trng_init(struct starfive_trng_plat *trng)
> +{
> +	u32 mode, intr =3D 0;
> +
> +	/* setup Auto Request/Age register */
> +	writel(0, trng->base + STARFIVE_AUTO_AGE);
> +	writel(0, trng->base + STARFIVE_AUTO_RQSTS);
> +
> +	/* clear register: ISTAT */
> +	starfive_trng_irq_mask_clear(trng);
> +
> +	intr |=3D STARFIVE_IE_ALL;
> +	writel(intr, trng->base + STARFIVE_IE);
> +
> +	mode =3D readl(trng->base + STARFIVE_MODE);
> +
> +	switch (trng->mode) {
> +	case PRNG_128BIT:
> +		mode &=3D ~STARFIVE_MODE_R256;
> +		break;
> +	case PRNG_256BIT:
> +		mode |=3D STARFIVE_MODE_R256;
> +		break;
> +	default:
> +		mode |=3D STARFIVE_MODE_R256;
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
> +	struct starfive_trng_plat *pdata =3D dev_get_plat(dev);
> +	int err;
> +
> +	err =3D clk_enable(pdata->hclk);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_enable(pdata->ahb);
> +	if (err)
> +		goto err_ahb;
> +
> +	err =3D reset_deassert(pdata->rst);
> +	if (err)
> +		goto err_reset;
> +
> +	pdata->mode =3D PRNG_256BIT;
> +
> +	err =3D starfive_trng_init(pdata);
> +	if (err)
> +		goto err_trng_init;
> +
> +	return 0;
> +
> +err_trng_init:
> +	reset_assert(pdata->rst);
> +err_reset:
> +	clk_disable(pdata->ahb);
> +err_ahb:
> +	clk_disable(pdata->hclk);
> +
> +	return err;
> +}
> +
> +static int starfive_trng_of_to_plat(struct udevice *dev)
> +{
> +	struct starfive_trng_plat *pdata =3D dev_get_plat(dev);
> +
> +	pdata->base =3D (void *)dev_read_addr(dev);
> +	if (!pdata->base)
> +		return -ENODEV;
> +
> +	pdata->hclk =3D devm_clk_get(dev, "hclk");
> +	if (IS_ERR(pdata->hclk))
> +		return -ENODEV;
> +
> +	pdata->ahb =3D devm_clk_get(dev, "ahb");
> +	if (IS_ERR(pdata->ahb))
> +		return -ENODEV;
> +
> +	pdata->rst =3D devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(pdata->rst))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct dm_rng_ops starfive_trng_ops =3D {
> +	.read =3D starfive_trng_read,
> +};
> +
> +static const struct udevice_id starfive_trng_match[] =3D {
> +	{
> +		.compatible =3D "starfive,jh7110-trng",
> +	},
> +	{},
> +};
> +
> +U_BOOT_DRIVER(starfive_trng) =3D {
> +	.name =3D "jh7110-trng",
> +	.id =3D UCLASS_RNG,
> +	.of_match =3D starfive_trng_match,
> +	.probe =3D starfive_trng_probe,
> +	.ops =3D &starfive_trng_ops,
> +	.plat_auto =3D sizeof(struct starfive_trng_plat),
> +	.of_to_plat =3D starfive_trng_of_to_plat,
> +};

