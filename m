Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6FFCEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330D88914F;
	Tue,  1 Oct 2024 07:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727762040;
	bh=UkrKOlE/yT4agd7NiN5Kqi14HhkO2WSQ13+5uurn40Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=oFGWCqK6Gxsvlbt9epZbjTWuBrFRXMWJ4GLNqL4xpHecITPsJY2cYSxHD1LoA6Xhj
	 pzpbnKbCFbmXQBsZ7UufbQz1B6YmWdn6Jg4RvtPhQlvNLUBWWI5a862u0gG7wrqgCO
	 CKr8d922uojjaCZlZGBx/WErIRU9RVCaJYmrXzLXApp4McLkm3JXWRTkTFLNi3mCED
	 X8xOm044RsxR5td8EFau+xNOdY5MubB1s6QPxbH6SN9ar6Lyj0N1ZAQ0x/wy8lxlJc
	 p7aoY/qnaTAZl3KNGMyjhhHn/2CCEkiEqNScNCX4VboGebh9UiUJYmQdj0K9U9pE+K
	 GARczxjiVb5HQ==
Received: from [192.168.1.107] (82-131-158-173.pool.digikabel.hu
 [82.131.158.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 830CB88C69;
 Tue,  1 Oct 2024 07:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727762038;
 bh=UkrKOlE/yT4agd7NiN5Kqi14HhkO2WSQ13+5uurn40Y=;
 h=Date:Subject:From:To:Cc:Reply-To:References:In-Reply-To:From;
 b=ZO8cW/lxKWAc/RSp1kpZgu3w+AldqcrWaknEAE6R0ZBHgBhUO+WrAuz3tWSdMuQc2
 WTPjAVHN/Tu7tYTtikIsXFmUONv/guWQCwx+n0wY3lDuby7IPu0fqN1SMTDiwrSF2h
 5NqDywtyGBUwE+JkE7gMDksr+zpXXCXJ0VUuieJsLmsA9yir8HKrQAPYbD1GBNqYJb
 gLxfKFCX/fH+7UK7kW6WAg/igTVaXdoCne8qzZJHNs57/eJpS1vrT48Swl1WK0G1Z5
 rDWtR9PUR0unfC3sLfJ/1fj/ql7QkRroW3Icbj9iQcvwf7TDhvMyhGPz3p0rrwlg/2
 uLK6G4O2y5PJg==
Message-ID: <9ce14505-6c37-f2e8-4b5d-44f1a55f0393@denx.de>
Date: Tue, 1 Oct 2024 07:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 08/26] power: Add iMX8M block ctrl driver for dispmix
Content-Language: en-US
From: Heiko Schocher <hs@denx.de>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 linux-amarula@amarulasolutions.com, Miquel Raynal
 <miquel.raynal@bootlin.com>, Ye Li <ye.li@nxp.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-9-dario.binacchi@amarulasolutions.com>
 <beecebba-79f5-e21d-3062-287c2dbb04e9@denx.de>
 <CABGWkvqOzc3cGM_aKVurv1XbAbeHXE77xwq_uAmSuZMgjCoevQ@mail.gmail.com>
 <ebb734bd-bdf7-ffd2-d676-7eb6011466a3@denx.de>
 <CAOf5uwm13jyOb0M9Xvx_bO1RpXhDcWqKBC-4fhZGo61Q5cjnjw@mail.gmail.com>
 <3cb57821-30f0-6aa0-2dec-313381b1350a@denx.de>
In-Reply-To: <3cb57821-30f0-6aa0-2dec-313381b1350a@denx.de>
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

Hello Michael,

On 01.10.24 07:14, Heiko Schocher wrote:
> Hi Micahel,
> 
> On 01.10.24 07:01, Michael Nazzareno Trimarchi wrote:
>> Hi Heko
>>
>> On Tue, Oct 1, 2024 at 6:23 AM Heiko Schocher <hs@denx.de> wrote:
>>>
>>> Hi Dario,
>>>
>>> On 30.09.24 15:20, Dario Binacchi wrote:
>>>> Hello Heiko,
>>>>
>>>> On Tue, Sep 24, 2024 at 11:07 AM Heiko Schocher <hs@denx.de> wrote:
>>>>>
>>>>> Hello Dario,
>>>>>
>>>>> On 13.09.24 11:55, Dario Binacchi wrote:
>>>>>> From: Michael Trimarchi <michael@amarulasolutions.com>
>>>>>>
>>>>>> Add iMX8 block ctrl driver for displaymix on iMX8MM/iMX8MN and
>>>>>> mediamix on iMX8MP.
>>>>>>
>>>>>> To support blk ctrl driver, the power domain driver on iMX8M needs
>>>>>> update to add relevant PGC domains
>>>>>>
>>>>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>>>>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>>>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>>>>> ---
>>>>>>
>>>>>>     drivers/power/domain/Kconfig              |   6 +
>>>>>>     drivers/power/domain/Makefile             |   1 +
>>>>>>     drivers/power/domain/imx8m-blk-ctrl.c     | 438 ++++++++++++++++++++++
>>>>>>     drivers/power/domain/imx8m-power-domain.c | 213 ++++++++++-
>>>>>>     4 files changed, 656 insertions(+), 2 deletions(-)
>>>>>>     create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c
>>>>>>
>>>>>> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
>>>>>> index bd82d2f7044b..fb006b6e8e28 100644
>>>>>> --- a/drivers/power/domain/Kconfig
>>>>>> +++ b/drivers/power/domain/Kconfig
>>>>>> @@ -40,6 +40,12 @@ config IMX8M_POWER_DOMAIN
>>>>>>           Enable support for manipulating NXP i.MX8M on-SoC power domains via
>>>>>>           requests to the ATF.
>>>>>>
>>>>>> +config IMX8M_BLK_CTRL
>>>>>> +     bool "Enable i.MX8M block control driver"
>>>>>> +     depends on POWER_DOMAIN && ARCH_IMX8M
>>>>>> +     help
>>>>>> +       Enable support for manipulating NXP i.MX8M on-SoC block control driver
>>>>>> +
>>>>>>     config IMX8MP_HSIOMIX_BLKCTRL
>>>>>>         bool "Enable i.MX8MP HSIOMIX domain driver"
>>>>>>         depends on POWER_DOMAIN && IMX8MP
>>>>>> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
>>>>>> index 2daab73eb758..46849fd2a4db 100644
>>>>>> --- a/drivers/power/domain/Makefile
>>>>>> +++ b/drivers/power/domain/Makefile
>>>>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
>>>>>>     obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
>>>>>>     obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
>>>>>>     obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
>>>>>> +obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
>>>>>>     obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
>>>>>>     obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
>>>>>>     obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
>>>>>> diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/domain/imx8m-blk-ctrl.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..4c89078b991b
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/power/domain/imx8m-blk-ctrl.c
>>>>>> @@ -0,0 +1,438 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * Copyright 2023 NXP
>>>>>> + */
>>>>>> +
>>>>>> +#include <dm.h>
>>>>>> +#include <malloc.h>
>>>>>> +#include <power-domain-uclass.h>
>>>>>> +#include <asm/io.h>
>>>>>> +#include <dm/device-internal.h>
>>>>>> +#include <dm/device.h>
>>>>>> +#include <dt-bindings/power/imx8mm-power.h>
>>>>>> +#include <dt-bindings/power/imx8mn-power.h>
>>>>>> +#include <dt-bindings/power/imx8mp-power.h>
>>>>>> +#include <clk.h>
>>>>>> +#include <linux/delay.h>
>>>>>> +
>>>>>> +#define BLK_SFT_RSTN 0x0
>>>>>> +#define BLK_CLK_EN   0x4
>>>>>> +#define BLK_MIPI_RESET_DIV   0x8 /* Mini/Nano/Plus DISPLAY_BLK_CTRL only */
>>>>>> +
>>>>>> +#define DOMAIN_MAX_CLKS 4
>>>>>> +
>>>>>> +struct imx8m_blk_ctrl_domain {
>>>>>> +     struct clk clks[DOMAIN_MAX_CLKS];
>>>>>> +     struct power_domain power_dev;
>>>>>> +};
>>>>>> +
>>>>>> +struct imx8m_blk_ctrl {
>>>>>> +     void __iomem *base;
>>>>>> +     struct power_domain bus_power_dev;
>>>>>> +     struct imx8m_blk_ctrl_domain *domains;
>>>>>> +};
>>>>>> +
>>>>>> +struct imx8m_blk_ctrl_domain_data {
>>>>>> +     const char *name;
>>>>>> +     const char * const *clk_names;
>>>>>> +     const char *gpc_name;
>>>>>> +     int num_clks;
>>>>>> +     u32 rst_mask;
>>>>>> +     u32 clk_mask;
>>>>>> +     u32 mipi_phy_rst_mask;
>>>>>> +};
>>>>>> +
>>>>>> +struct imx8m_blk_ctrl_data {
>>>>>> +     int max_reg;
>>>>>> +     const struct imx8m_blk_ctrl_domain_data *domains;
>>>>>> +     int num_domains;
>>>>>> +     u32 bus_rst_mask;
>>>>>> +     u32 bus_clk_mask;
>>>>>> +};
>>>>>> +
>>>>>> +static int imx8m_blk_ctrl_request(struct power_domain *power_domain)
>>>>>> +{
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int imx8m_blk_ctrl_free(struct power_domain *power_domain)
>>>>>> +{
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int imx8m_blk_ctrl_enable_domain_clk(struct udevice *dev, ulong domain_id, bool enable)
>>>>>> +{
>>>>>> +     int ret, i;
>>>>>> +     struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
>>>>>> +     struct imx8m_blk_ctrl_data *drv_data =
>>>>>> +             (struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
>>>>>> +
>>>>>> +     debug("%s num_clk %u\n", __func__, drv_data->domains[domain_id].num_clks);
>>>>>> +
>>>>>> +     for (i = 0; i < drv_data->domains[domain_id].num_clks; i++) {
>>>>>> +             debug("%s clk %s\n", __func__, drv_data->domains[domain_id].clk_names[i]);
>>>>>> +             if (enable)
>>>>>> +                     ret = clk_enable(&priv->domains[domain_id].clks[i]);
>>>>>> +             else
>>>>>> +                     ret = clk_disable(&priv->domains[domain_id].clks[i]);
>>>>>> +             if (ret && ret != -ENOENT) {
>>>>>> +                     printf("Failed to %s domain clk %s\n", enable ? "enable" : "disable",
>>>>>> +                            drv_data->domains[domain_id].clk_names[i]);
>>>>>> +                     return ret;
>>>>>> +             }
>>>>>> +     }
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int imx8m_blk_ctrl_power_on(struct power_domain *power_domain)
>>>>>> +{
>>>>>> +     struct udevice *dev = power_domain->dev;
>>>>>> +     struct imx8m_blk_ctrl *priv = (struct imx8m_blk_ctrl *)dev_get_priv(dev);
>>>>>> +     struct imx8m_blk_ctrl_data *drv_data =
>>>>>> +             (struct imx8m_blk_ctrl_data *)dev_get_driver_data(dev);
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     debug("%s, id %lu\n", __func__, power_domain->id);
>>>>>> +
>>>>>> +     if (!priv->domains[power_domain->id].power_dev.dev)
>>>>>> +             return -ENODEV;
>>>>>> +
>>>>>> +     ret = power_domain_on(&priv->bus_power_dev);
>>>>>> +     if (ret < 0) {
>>>>>> +             printf("Failed to power up bus domain %d\n", ret);
>>>>>> +             return ret;
>>>>>> +     }
>>>>>> +
>>>>>> +     /* Enable bus clock and deassert bus reset */
>>>>>> +     setbits_le32(priv->base + BLK_CLK_EN, drv_data->bus_clk_mask);
>>>>>> +     setbits_le32(priv->base + BLK_SFT_RSTN, drv_data->bus_rst_mask);
>>>>>> +
>>>>>> +     /* wait for reset to propagate */
>>>>>> +     udelay(5);
>>>>>> +
>>>>>> +     /* put devices into reset */
>>>>>> +     clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
>>>>>> +     if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
>>>>>> +             clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
>>>>>> +                          rv_data->domains[power_domain->id].mipi_phy_rst_mask);
>>>>>
>>>>> Does this build for you?
>>>>>
>>>>> I needed the following fix:
>>>>>
>>>>> diff --git a/drivers/power/domain/imx8m-blk-ctrl.c b/drivers/power/domain/imx8m-blk-ctrl.c
>>>>> index 4c89078b99..b772d50480 100644
>>>>> --- a/drivers/power/domain/imx8m-blk-ctrl.c
>>>>> +++ b/drivers/power/domain/imx8m-blk-ctrl.c
>>>>> @@ -114,8 +114,8 @@ static int imx8m_blk_ctrl_power_on(struct power_domain *power_domain)
>>>>>            /* put devices into reset */
>>>>>            clrbits_le32(priv->base + BLK_SFT_RSTN, drv_data->domains[power_domain->id].rst_mask);
>>>>>            if (drv_data->domains[power_domain->id].mipi_phy_rst_mask)
>>>>> -               clrbits_le32(priv->base + BLK_MIPI_RESET_DIV, d
>>>>> -                            rv_data->domains[power_domain->id].mipi_phy_rst_mask);
>>>>> +               clrbits_le32(priv->base + BLK_MIPI_RESET_DIV,
>>>>> +                            drv_data->domains[power_domain->id].mipi_phy_rst_mask);
>>>>>
>>>>>            /* enable upstream and blk-ctrl clocks to allow reset to propagate */
>>>>>            ret = imx8m_blk_ctrl_enable_domain_clk(dev, power_domain->id, true);
>>>>>
>>>>> to get it building.
>>>>
>>>> Yes, you're right. I made some changes suggested by patman, and before
>>>> applying the
>>>>    patch, I didn't recompile, so I didn't notice.
>>>>
>>>>>
>>>>> BTW: Just also working on bootlogo support for an imx8mp based board!
>>>>>
>>>>> I now applied your patches:
>>>>>
>>>>> clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE present for gate and mux
>>>>> clk: clk-uclass: Implement CLK_OPS_PARENT_ENABLE
>>>>>
>>>>> And added in my adapted /drivers/clk/imx/clk-imx8mp.c (imported from linux)
>>>>>
>>>>> clk_dm(IMX8MP_CLK_MEDIA_AXI, imx8m_clk_composite_flags("media_axi", imx8mp_media_axi_sels,
>>>>> ARRAY_SIZE(imx8mp_media_axi_sels), base + 0x8a00, CLK_IS_CRITICAL));
>>>>>
>>>>> instead of using imx8m_clk_composite, and dropped my approach to
>>>>> get clocks up and working.
>>>>>
>>>>> Also dropped my similiar approach for mediablock and used your
>>>>>
>>>>> power: Add iMX8M block ctrl driver for dispmix
>>>>>
>>>>> And with this 3 patches, bootlogo works also/still fine for me!
>>>>>
>>>>> I did not applied/need your patches:
>>>>>
>>>>> clk: imx8mn: Prevent clock critical path from disabling during reparent and set_rate
>>>>> clk: imx8mm: Prevent clock critical path from disabling during reparent and set_rate
>>>>> clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as enabled
>>>>> clk: imx8mn: Mark IMX8MN_SYS_PLL2 and IMX8MN_SYS_PLL3 as enabled
>>>>>
>>>>> Of course, they are for imx8mm, but I mean I do not need similiar patches
>>>>> for imx8mp!
>>>>>
>>>>> Also not applied (as for imx8mm)
>>>>> clk: imx8mn: add video clocks support
>>>>>
>>>>> but as said, have similiar patch for clk-imx8mp.c
>>>>>
>>>>> May you check if using imx8m_clk_composite_flags() is working for you?
>>>>
>>>> I will do it
>>>>
>>>>>
>>>>> I did not applied your patches 09/26 and the following patches from
>>>>> your series, as I made a video bridge driver based on
>>>>>
>>>>> linux driver drivers/gpu/drm/bridge/fsl-ldb.c
>>>>>
>>>>> and a lcdif driver based on linux:/drivers/gpu/drm/mxsfb/lcdif_drv.c
>>>>>
>>>>
>>>> Thank you for you feedback Heiko
>>>
>>> You are welcome!
>>>
>>> Hmm.. unfortunately ... I had applied your 2 clock patches, which
>>> fixed a problem with enabling parent clocks ... but they broke booting
>>> on a carrier which has fec ethernet! After "Net: " output the board hang...
>>>
>>> I reverted your 2 clock patches and it bootet again ... so there is
>>> a problem ... try to get some more time to look into...
>>>
>>
>> We have a fec, but we had I think two patches more on it. I forget to
>> answer Marek
>> about them because I don't have my board now and because he is
>> partially right (or maybe right).
>> Anyway when we boot we could have and we have clocks that are enabled
>> by bootrom or SPL that
>> we need to declare as enable like PLL2/PLL3 those clocks are parts or
>> could be part of reparent so,
>> you need to have a reference counter on them that allow to not disable
>> during the down chain disable
>> and up chain enable. I think that what happens to your ethernet it's
>> that you disable some clock that is
>> critical to the board to survive. I had a patch merged by Tom that
> 
> Yep, thats what I think too! If you access registers in a block for
> which the clock is not enabled ... it just hang...
> 
>> prints the clock name so if you enable
>> the debug of the clock you will find that your board stops working
>> during one of this reparinting.
> 
> I currently work on 2024.07... will rebase if 2024.10 is out...
> 
> Ah, you mean:
> 
> commit a70d991212c9684e09ed80ece69ce1ff7bfd9f08
> Author: Michael Trimarchi <michael@amarulasolutions.com>
> Date:   Tue Jul 9 08:28:13 2024 +0200
> 
>      clk: clk-uclass: Print clk name in clk_enable/clk_disable
> 
>      Print clk name in clk_enable and clk_disable. Make sense to know
>      what clock get disabled/enabled before a system crash or system
>      hang.
> 
>      Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> 
> I have the same change when I debug :-P
> 
> IIRC I did not see the clock names ... but I will recheck!

I see with your patch the clock names, so fine... and see [1]

Hmm... I am on imx8mp, and I think the changes the patchset do in

"clk: imx8mn: Prevent clock critical path from disabling during reparent and set_rate"

are in clk-imx8mp already ...

Ported the patch from patchset

"[PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as enabled"

to imx8mp [2] and fec ethernet works again for me on imx8mp!

Could you add this if you post a v2 ?

bye,
Heiko
[1]
│   │    <> Net:   clk_set_defaults(gpio@30230000)
│   │    <> clk_set_default_parents: could not read assigned-clock-parents for 00000000fee74d90 
name=gpio@30230000
│   │    <> clk_set_defaults(aristainetos3-fec-rgmii-grp)
│   │    <> clk_set_default_parents: could not read assigned-clock-parents for 00000000fee75780 
name=aristainetos3-fec-rgmii-grp
│   │    <> clk_set_defaults(ethernet@30be0000)
│   │    <> clk_get_by_indexed_prop(dev=00000000fee7ad20, index=0, clk=00000000fee5e3b8)
│   │    <> clk_of_xlate_default(clk=00000000fee5e3b8)
│   │    <> clk_request(dev=00000000fee77480, clk=00000000fee5e3b8)
│   │    <> clk_get_by_indexed_prop(dev=00000000fee7ad20, index=0, clk=00000000fee5e390)
│   │    <> clk_of_xlate_default(clk=00000000fee5e390)
│   │    <> clk_request(dev=00000000fee77480, clk=00000000fee5e390)
│   │    <> clk_set_parent(clk=00000000fee825c0, parent=00000000fee80680)
│   │    <> clk_get_parent(clk=00000000fee825c0)
│   │    <> clk_enable(clk=00000000fee743d0 name=clock-osc-24m)
│   │    <> clk_enable(clk=00000000fee80680 name=sys_pll1_266m)
│   │    <> clk_enable(clk=00000000fee7fb40 name=sys_pll1_out)
│   │    <> clk_disable(clk=00000000fee80680 name=sys_pll1_266m)
│   │    <> clk_disable(clk=00000000fee7fb40 name=sys_pll1_out)
│   │    <> clk_disable(clk=00000000fee743d0 name=clock-osc-24m)
│   │    <> clk_get_by_indexed_prop(dev=00000000fee7ad20, index=1, clk=00000000fee5e3b8)
│   │    <> clk_of_xlate_default(clk=00000000fee5e3b8)
│   │    <> clk_request(dev=00000000fee77480, clk=00000000fee5e3b8)
│   │    <> clk_get_by_indexed_prop(dev=00000000fee7ad20, index=1, clk=00000000fee5e390)
│   │    <> clk_of_xlate_default(clk=00000000fee5e390)
│   │    <> clk_request(dev=00000000fee77480, clk=00000000fee5e390)
│   │    <> clk_set_parent(clk=00000000fee85b80, parent=00000000fee80b80)
│   │    <> clk_get_parent(clk=00000000fee85b80)
│   │    <> clk_enable(clk=00000000fee743d0 name=clock-osc-24m)
│   │    <> clk_enable(clk=00000000fee80b80 name=sys_pll2_100m)
│   │    <> clk_enable(clk=00000000fee7fc80 name=sys_pll2_out)
│   │    <> clk_enable(clk=00000000fee7f480 name=sys_pll2_bypass)
│   │    <> clk_enable(clk=00000000fee7eb80 name=sys_pll2)
│   │    <> clk_enable(clk=00000000fee7e280 name=sys_pll2_ref_sel)
│   │    <> clk_enable(clk=00000000fee743d0 name=clock-osc-24m)
│   │    <> clk_disable(clk=00000000fee80b80 name=sys_pll2_100m)
│   │    <> clk_disable(clk=00000000fee7fc80 name=sys_pll2_out)
│   │    <> clk_disable(clk=00000000fee7f480 name=sys_pll2_bypass)
│   │    <> clk_disable(clk=00000000fee7eb80 name=sys_pll2)

[2]
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index d6865509cb..f6fa66094d 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -235,6 +235,7 @@ static const char * const imx8mp_clkout_sels[] = {"audio_pll1_out", "audio_pll2_
  static int imx8mp_clk_probe(struct udevice *dev)
  {
         struct clk osc_24m_clk, osc_32k_clk;
+       struct clk *clk;
         void __iomem *base;
         int ret;

@@ -303,6 +304,14 @@ static int imx8mp_clk_probe(struct udevice *dev)
                 return ret;
         clk_dm(IMX8MP_CLK_32K, dev_get_clk_ptr(osc_32k_clk.dev));

+       ret = clk_get_by_id(IMX8MP_SYS_PLL2, &clk);
+       if (!ret)
+               clk_enable(clk);
+
+       ret = clk_get_by_id(IMX8MP_SYS_PLL3, &clk);
+       if (!ret)
+               clk_enable(clk);
+
         base = dev_read_addr_ptr(dev);
         if (!base)
                 return -EINVAL;
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
