Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21935CEB2EB
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 04:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8363588F4B;
	Tue,  1 Oct 2024 06:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727756635;
	bh=z8mep/uNsKdEjoDuIzaPtnW2aiIOzdhgi1GBaB0SfGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=HLKv9oWES6jUKJrvqSk5QgbVNZrWvOh4WmdRhzyMT+Uoy7NL3yZPJJhPPa1sK1Nvr
	 hvbRwqGysmVr2bp6G7R0bQ3nQn1DWgw3m2l2crOLoKihLfmDGL0kfSKeRxmZCJMePJ
	 yfjjVaZ/tc+0t+mqGvNIdKEZ3XSWXJ61woGhfnUln9PJyyXojJP0mv9slTSKl0ln6r
	 MndQlt2Idy088+cNNQmW1mQkmUXlnFlczYQrnBlK1Pjl45jpHh3nd8yhmaCBAhiiei
	 sSkR/0Xwk3tfMzx1l0EvcoDAW6+J8q753m0jFvoQMPB+9nI65nzEx8V+c3xsg5b+mL
	 oVXVoGvXp5aWw==
Received: from [192.168.1.107] (82-131-158-173.pool.digikabel.hu
 [82.131.158.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 970B188B8F;
 Tue,  1 Oct 2024 06:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727756634;
 bh=z8mep/uNsKdEjoDuIzaPtnW2aiIOzdhgi1GBaB0SfGo=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=vyDaSs8h2agAnH5wpVF/nVeFDMGp038N3z+F8OHGbVubCjzGX27yS0eOoVKGR7vzM
 YBiHPFoh1WvxkTwpriWlnlQ1F0jCQu/JgUxDS/Ku345gGWYrLC1GceS+ZbT2QbT34e
 jyodRFxk2qkJIAAPYbp9jXVVMt4qqPMrlxkCVrib2YfKxuD6tI+aZYkCmTFz+jkz95
 AelQO+/HtZkAPJbIC6xVMlLNflgYWzqRi+C+VVk7Va0ojKmcAHjdTQ+3M7iE+ZvFNu
 2OpYDlLoGouuk6o9UfVcUZ/G2/PbxZjIXZsHsGQZaAL2bpkw9F0YsXJJ015wKc8yUZ
 OhRu6GXbXmANg==
Message-ID: <ebb734bd-bdf7-ffd2-d676-7eb6011466a3@denx.de>
Date: Tue, 1 Oct 2024 06:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Miquel Raynal <miquel.raynal@bootlin.com>, Ye Li <ye.li@nxp.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
 <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
 <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Dario,

On 30.09.24 15:20, Dario Binacchi wrote:
> Hello Heiko,
> 
> On Tue, Sep 24, 2024 at 11:07 AM Heiko Schocher <hs@denx.de> wrote:
>>
>> Hello Dario,
>>
>> On 13.09.24 11:55, Dario Binacchi wrote:
>>> From: Michael Trimarchi <michael@amarulasolutions.com>
>>>
>>> Add iMX8 block ctrl driver for displaymix on iMX8MM/iMX8MN and
>>> mediamix on iMX8MP.
>>>
>>> To support blk ctrl driver, the power domain driver on iMX8M needs
>>> update to add relevant PGC domains
>>>
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>> ---
>>>
>>>    drivers/power/domain/Kconfig              |   6 +
>>>    drivers/power/domain/Makefile             |   1 +
>>>    drivers/power/domain/imx8m-blk-ctrl.c     | 438 ++++++++++++++++++++++
>>>    drivers/power/domain/imx8m-power-domain.c | 213 ++++++++++-
>>>    4 files changed, 656 insertions(+), 2 deletions(-)
>>>    create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c
>>>
>>> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
>>> index bd82d2f7044b..fb006b6e8e28 100644
>>> --- a/drivers/power/domain/Kconfig
>>> +++ b/drivers/power/domain/Kconfig
>>> @@ -40,6 +40,12 @@ config IMX8M_POWER_DOMAIN
>>>          Enable support for manipulating NXP i.MX8M on-SoC power domains via
>>>          requests to the ATF.
>>>
>>> +config IMX8M_BLK_CTRL
>>> +     bool "Enable i.MX8M block control driver"
>>> +     depends on POWER_DOMAIN && ARCH_IMX8M
>>> +     help
>>> +       Enable support for manipulating NXP i.MX8M on-SoC block control driver
>>> +
>>>    config IMX8MP_HSIOMIX_BLKCTRL
>>>        bool "Enable i.MX8MP HSIOMIX domain driver"
>>>        depends on POWER_DOMAIN && IMX8MP
>>> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
>>> index 2daab73eb758..46849fd2a4db 100644
>>> --- a/drivers/power/domain/Makefile
>>> +++ b/drivers/power/domain/Makefile
>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
>>>    obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
>>>    obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
>>>    obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
>>> +obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
>>>    obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
>>>    obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
>>>    obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
>>> diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/domain/imx8m-blk-ctrl.c
>>> new file mode 100644
>>> index 000000000000..4c89078b991b
>>> --- /dev/null
>>> +++ b/drivers/power/domain/imx8m-blk-ctrl.c
>>> @@ -0,0 +1,438 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2023 NXP
>>> + */
>>> +
>>> +#include <dm.h>
>>> +#include <malloc.h>
>>> +#include <power-domain-uclass.h>
>>> +#include <asm/io.h>
>>> +#include <dm/device-internal.h>
>>> +#include <dm/device.h>
>>> +#include <dt-bindings/power/imx8mm-power.h>
>>> +#include <dt-bindings/power/imx8mn-power.h>
>>> +#include <dt-bindings/power/imx8mp-power.h>
>>> +#include <clk.h>
>>> +#include <linux/delay.h>
>>> +
>>> +#define BLK_SFT_RSTN 0x0
>>> +#define BLK_CLK_EN   0x4
>>> +#define BLK_MIPI_RESET_DIV   0x8 /* Mini/Nano/Plus DISPLAY_BLK_CTRL only */
>>> +
>>> +#define DOMAIN_MAX_CLKS 4
>>> +
>>> +struct imx8m_blk_ctrl_domain {
>>> +     struct clk clks[DOMAIN_MAX_CLKS];
>>> +     struct power_domain power_dev;
>>> +};
>>> +
>>> +struct imx8m_blk_ctrl {
>>> +     void __iomem *base;
>>> +     struct power_domain bus_power_dev;
>>> +     struct imx8m_blk_ctrl_domain *domains;
>>> +};
>>> +
>>> +struct imx8m_blk_ctrl_domain_data {
>>> +     const char *name;
>>> +     const char * const *clk_names;
>>> +     const char *gpc_name;
>>> +     int num_clks;
>>> +     u32 rst_mask;
>>> +     u32 clk_mask;
>>> +     u32 mipi_phy_rst_mask;
>>> +};
>>> +
>>> +struct imx8m_blk_ctrl_data {
>>> +     int max_reg;
>>> +     const struct imx8m_blk_ctrl_domain_data *domains;
>>> +     int num_domains;
>>> +     u32 bus_rst_mask;
>>> +     u32 bus_clk_mask;
>>> +};
>>> +
>>> +static int imx8m_blk_ctrl_request(struct power_domain *power_domain)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>> +static int imx8m_blk_ctrl_free(struct power_domain *power_domain)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>> +static int imx8m_blk_ctrl_enable_domain_clk(struct udevice *dev, ulong domain_id, bool enable)
>>> +{
>>> +     int ret, i;
>>> +     struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
>>> +     struct imx8m_blk_ctrl_data *drv_data =
>>> +             (struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
>>> +
>>> +     debug("%s num_clk %u\n", __func__, drv_data->domains[domain_id].num_clks);
>>> +
>>> +     for (i = 0; i < drv_data->domains[domain_id].num_clks; i++) {
>>> +             debug("%s clk %s\n", __func__, drv_data->domains[domain_id].clk_names[i]);
>>> +             if (enable)
>>> +                     ret = clk_enable(&priv->domains[domain_id].clks[i]);
>>> +             else
>>> +                     ret = clk_disable(&priv->domains[domain_id].clks[i]);
>>> +             if (ret && ret != -ENOENT) {
>>> +                     printf("Failed to %s domain clk %s\n", enable ? "enable" : "disable",
>>> +                            drv_data->domains[domain_id].clk_names[i]);
>>> +                     return ret;
>>> +             }
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int imx8m_blk_ctrl_power_on(struct power_domain *power_domain)
>>> +{
>>> +     struct udevice *dev = power_domain->dev;
>>> +     struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
>>> +     struct imx8m_blk_ctrl_data *drv_data =
>>> +             (struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
>>> +     int ret;
>>> +
>>> +     debug("%s, id %lu\n", __func__, power_domain->id);
>>> +
>>> +     if (!priv->domains[power_domain->id].power_dev.dev)
>>> +             return -ENODEV;
>>> +
>>> +     ret = power_domain_on(&priv->bus_power_dev);
>>> +     if (ret < 0) {
>>> +             printf("Failed to power up bus domain %d\n", ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     /* Enable bus clock and deassert bus reset */
>>> +     setbits_le32(priv->base + BLK_CLK_EN, drv_data->bus_clk_mask);
>>> +     setbits_le32(priv->base + BLK_SFT_RSTN, drv_data->bus_rst_mask);
>>> +
>>> +     /* wait for reset to propagate */
>>> +     udelay(5);
>>> +
>>> +     /* put devices into reset */
>>> +     clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
>>> +     if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
>>> +             clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
>>> +                          rv_data->domains[power_domain->id].mipi_phy_rst_mask);
>>
>> Does this build for you?
>>
>> I needed the following fix:
>>
>> diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/domain/imx8m-blk-ctrl.c
>> index 4c89078b99..b772d50480 100644
>> --- a/drivers/power/domain/imx8m-blk-ctrl.c
>> +++ b/drivers/power/domain/imx8m-blk-ctrl.c
>> @@ -114,8 +114,8 @@ static int imx8m_blk_ctrl_power_on(struct power_domain *power_domain)
>>           /* put devices into reset */
>>           clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
>>           if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
>> -               clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
>> -                            rv_data->domains[power_domain->id].mipi_phy_rst_mask);
>> +               clrbits_le32(priv->base + BLK_MIPI_RESET_DIV,
>> +                            drv_data->domains[power_domain->id].mipi_phy_rst_mask);
>>
>>           /* enable upstream and blk-ctrl clocks to allow reset to propagate */
>>           ret = imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, true);
>>
>> to get it building.
> 
> Yes, you're right. I made some changes suggested by patman, and before
> applying the
>   patch, I didn't recompile, so I didn't notice.
> 
>>
>> BTW: Just also working on bootlogo support for an imx8mp based board!
>>
>> I now applied your patches:
>>
>> clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE present for gate and mux
>> clk: clk-uclass: Implement CLK_OPS_PARENT_ENABLE
>>
>> And added in my adapted /drivers/clk/imx/clk-imx8mp.c (imported from linux)
>>
>> clk_dm(IMX8MP_CLK_MEDIA_AXI, imx8m_clk_composite_flags("media_axi", imx8mp_media_axi_sels,
>> ARRAY_SIZE(imx8mp_media_axi_sels), base + 0x8a00, CLK_IS_CRITICAL));
>>
>> instead of using imx8m_clk_composite, and dropped my approach to
>> get clocks up and working.
>>
>> Also dropped my similiar approach for mediablock and used your
>>
>> power: Add iMX8M block ctrl driver for dispmix
>>
>> And with this 3 patches, bootlogo works also/still fine for me!
>>
>> I did not applied/need your patches:
>>
>> clk: imx8mn: Prevent clock critical path from disabling during reparent and set_rate
>> clk: imx8mm: Prevent clock critical path from disabling during reparent and set_rate
>> clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as enabled
>> clk: imx8mn: Mark IMX8MN_SYS_PLL2 and IMX8MN_SYS_PLL3 as enabled
>>
>> Of course, they are for imx8mm, but I mean I do not need similiar patches
>> for imx8mp!
>>
>> Also not applied (as for imx8mm)
>> clk: imx8mn: add video clocks support
>>
>> but as said, have similiar patch for clk-imx8mp.c
>>
>> May you check if using imx8m_clk_composite_flags() is working for you?
> 
> I will do it
> 
>>
>> I did not applied your patches 09/26 and the following patches from
>> your series, as I made a video bridge driver based on
>>
>> linux driver drivers/gpu/drm/bridge/fsl-ldb.c
>>
>> and a lcdif driver based on linux:/drivers/gpu/drm/mxsfb/lcdif_drv.c
>>
> 
> Thank you for you feedback Heiko

You are welcome!

Hmm.. unfortunately ... I had applied your 2 clock patches, which
fixed a problem with enabling parent clocks ... but they broke booting
on a carrier which has fec ethernet! After "Net: " output the board hang...

I reverted your 2 clock patches and it bootet again ... so there is
a problem ... try to get some more time to look into...

Do you have fec ethernet on your board?

Thanks!

bye,
Heiko
> 
> Regards,
> Dario
> 
>> bye,
>> Heiko
>> --
>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
> 
> 
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
