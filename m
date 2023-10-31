Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8D4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 21:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66A087635;
	Tue, 31 Oct 2023 22:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j6vVjhCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3C587B63; Tue, 31 Oct 2023 22:18:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A1E87633
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 22:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698787088; x=1699391888; i=xypron.glpk@gmx.de;
 bh=VFG3jiE2mzDKy2VllPxzP6LTsXSGBp6Gnhs/iKeCbLk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:
 In-Reply-To;
 b=j6vVjhCb/0xigXeIjAmXXEXuU0ZPFzzhV2y7uuiMiNrvvzjeGwguFNswoVD7Eq30
 p5MGNNZNGRYOlaqOSUnkPP9GSzGAKS75Qsc//UEkUr3wWw6B/hg9zrRC1klHfOchL
 lEiPOQbNMJlkDcm/QjA/Xi+kHcq+KejC38N9n7tQ3k1J5BhsoklnfIro9EfPtXLaz
 erWcEPyFVBirvgww/Gg5NVYTFhtySycOeex4OrOw+7SxbtUKJAAh0DgPRrUMeavX8
 NsrMfW8zXoC0MVj56evuvNX/nHkzPiYR3LM4N8aBBqtzKc8SZXl0tUMWBV7PkMw9N
 43SiIok2dDyV0IZt8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.29.1] ([159.148.28.2]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1rAqIL0xLl-00DayL; Tue, 31
 Oct 2023 22:18:08 +0100
Message-ID: <ff82b420-6226-436f-9f95-01411eaa8289@gmx.de>
Date: Tue, 31 Oct 2023 23:17:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] rng: Add StarFive JH7110 RNG driver
Content-Language: en-US, de-DE
To: Chanho Park <chanho61.park@samsung.com>
References: <20231030073204.150030-1-chanho61.park@samsung.com>
 <CGME20231030073229epcas2p19e6145de5e8b740125bbc523fbcc4f66@epcas2p1.samsung.com>
 <20231030073204.150030-4-chanho61.park@samsung.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, u-boot@lists.denx.de
In-Reply-To: <20231030073204.150030-4-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lJFKvWo7kIImMeBcjsMhVzcHdH7nJjb6dZR9VW3evzFXkG+WaNj
 8BjkPkQ29cnc1HSjn5TcbrtZuMUBeEJst4Ke7z8rMfILZLtURo1sgIJW97WSohudoQcE6Aa
 dCVo+VRF6ddDScKzoLmAWV4DgjPPId1MjnjLeyZ43xh1UnEBcflu/HAXYdQFD/dTpz/6u5t
 aHirlWn6OGLMFUQJNettg==
UI-OutboundReport: notjunk:1;M01:P0:QHKLj/FljfE=;cDuPfsJGq9mwBc1VuMAl9aih9v9
 YFO86zbyvOHO5XseqH7ikrGv+lOPbgMmQtLzmOZfGQICXkRtrh+XQAgs0aMZ+2jn5JqVZuaEg
 Os3J3l0n1n1Fn2GntzFtIp7J8sjanF14ww+TqetR+5enRqUVNQYZtJhKLFbQA5+VMC6127D31
 hp5QZN+WEmEhfFLGQnrChITypxSgss6Wt96FGyMBdIy1XqkAvXa6HdkwIaX6uoKnx7pMKVNeP
 1cGp8oHdUtstvjpfq28W8oNZ1eoGH59OTR5EfiTTqoMoD9f66z+dnhb50iAVSwep0EkbB9ArM
 S25PN9Kb7QGidwR1lqfycSiDoW18Cn4VXSWIrhHRW1VB7EzX0BbDyxOOWZzinMfxIFErFDGew
 EcbFWyUe18wut6HQfPZM5bIvQ8qOmKF79grpqaiwYoosaX4eGHGidGOeKmZV1mKQgax37wuyD
 lCU/TuyHFlQRAEUyCldFWGkRfnltihwbUf6ypTNHcagfjDZjSAz7jyld9xNCKk3Ao6zTIsvc+
 DsuOWbkZJ0Hx/NKXaPr7aPM3+tINP+Nb0DjDayXthUaZNG1GAj8FkBr5ZuE4TnMZQfO2M90BF
 7p+mS2LT2odyyKSzLP0TEYqZO6jvIlmZ1rmQ2gqMvsjqTR9wX3sECFbVGQm1hOFlS/hYOFrNs
 62Zdm9428D6ozb6gIFbg+LFu4F/2vzq3T9IslKrwfflxmF2AYAyNsONIHOineUgoXlxTsMWGw
 Aff9prb2OaOeeDbv+GFm6FUbR2j2DH0E47AYMdKoyLnLABpj3PIhbJn9XPgt+3Hn+u3qS26kM
 M1NRK7s++PhcrM08fds5S9mYyZA98f8wcYjcGm3F3vIvBJau3QrI6ZwyGSVNEFo6mhGaZde+r
 KRGrwM6WefiFiWWJnB8RPgO7PWglse+y1Oqq1jouMpzEr/qgpzLoXGiDdr88lxtFuJ5MHIIsg
 gdnUvP6QVkfTp5EbQtlYsZ2Hi8g=
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

On 10/30/23 09:32, Chanho Park wrote:
> Adds to support JH7110 TRNG driver which is based on linux kernel's
> jh7110-trng.c. This can support to generate 256-bit random numbers and
> 128-bit but this makes 256-bit default for convenience.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>   drivers/rng/Kconfig      |   6 +
>   drivers/rng/Makefile     |   1 +
>   drivers/rng/jh7110_rng.c | 272 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 279 insertions(+)
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
> index 000000000000..e71bf188f017
> --- /dev/null
> +++ b/drivers/rng/jh7110_rng.c
> @@ -0,0 +1,272 @@
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
> +	char *buffer =3D (char *)data;

Great to see a RNG driver for this SoC.

The conversion is not needed in C and should be removed.

> +	int ret;
> +	size_t max;
> +
> +	if (trng->mode =3D=3D PRNG_256BIT)
> +		max =3D min_t(size_t, max, (STARFIVE_RAND_LEN * 8));
> +	else
> +		max =3D min_t(size_t, max, (STARFIVE_RAND_LEN * 4));
> +
> +	ret =3D starfive_trng_wait_idle(trng);
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	while (len) {
> +		size_t max;
> +		u32 val, step;

Variables should be defined in the loop where they are used.
Use size_t for step as this is what memcpy() needs as argument.

> +
> +		if (trng->mode =3D=3D PRNG_256BIT)

The arguments of this if-statement are not changed in the loop. We don't
really need the variable max. The number of iterations would be enough:

     if (trng->mode =3D=3D PRNG_256BIT)
         rounds =3D 8;
     else
         rounds =3D 4;
     while(len) {

> +			max =3D min_t(size_t, len, (STARFIVE_RAND_LEN * 8));
> +		else
> +			max =3D min_t(size_t, len, (STARFIVE_RAND_LEN * 4));
> +
> +		ret =3D starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM);
> +		if (ret)
> +			return ret;
> +
> +		for (int i =3D 0; i < DIV_ROUND_UP(max, STARFIVE_RAND_LEN); i++) {

You are decrementing max in the loop. So on every iteration
DIV_ROUND_UP(max, STARFIVE_RAND_LEN) will result in different result. I
don't believe this is intended.

> +			val =3D readl(trng->base + STARFIVE_RAND0 +
> +				    (i * STARFIVE_RAND_LEN));
> +			step =3D (max >=3D STARFIVE_RAND_LEN) ?
> +				STARFIVE_RAND_LEN : max;

Please, stay consistent in your style and use min_t().

> +			memcpy(buffer, &val, step);
> +
> +			max -=3D step;
> +			buffer +=3D step;
> +			len -=3D step;
> +		}
> +	}
> +
> +	return 0;
> +}

The following code looks a bit easier to read:

u8 *buffer =3D data;
int iter_mask;

if (trng->mode =3D=3D PRNG_256BIT)
     iter_mask =3D 7;
else
     iter_mask =3D 3;

for (int i =3D 0; len; ++i, i &=3D iter_mask)
     u32 val;
     size_t step;

     if (!i) {
          int ret;

          ret =3D starfive_trng_wait_idle(trng);
          if (ret)
               return -ETIMEDOUT;
      }
      val =3D read_l(trng->base + STARFIVE_RAND0 +
            (i * STARFIVE_RAND_LEN));
      step =3D min_t(size_t, len, STARFIVE_RAND_LEN);
      memcpy (buffer, &val, step);
      len -=3D step;
}

Best regards

Heinrich

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
> +		return err;
> +
> +	err =3D reset_deassert(pdata->rst);
> +	if (err)
> +		return err;
> +
> +	pdata->mode =3D PRNG_256BIT;
> +
> +	return starfive_trng_init(pdata);
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

