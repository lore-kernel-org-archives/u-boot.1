Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6C4C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 03:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66AE387D10;
	Sat, 22 Jun 2024 05:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="icUsqKcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753ED87FC2; Sat, 22 Jun 2024 05:49:38 +0200 (CEST)
Received: from mail-m25467.xmail.ntesmail.com (mail-m25467.xmail.ntesmail.com
 [103.129.254.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0B387C2D
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 05:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=icUsqKclDPbQ7QhpMXLY3At1zGWSBr6FqgkJcna2evVmJ8raajtFFe5kHA5NKaXNp4trycSAgy33JHBIWbIfP99ia0cwY1j+430nZz58bmh+Ki1sv6M7QpOlGgF8L0Rmk8/hEt0xXI6pmYgsUWcTUmgxTd8DVoaM2/lzpTI5RV8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=dyLqdgk+7Hf1dNU7x5V98ZUPfHyEe7e9ykiZFXb1Ivk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 950709003A2;
 Sat, 22 Jun 2024 11:49:17 +0800 (CST)
Message-ID: <7fa48725-c965-4a41-bab1-74e987569855@rock-chips.com>
Date: Sat, 22 Jun 2024 11:49:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/18] rockchip: Avoid #ifdefs in RK3399 SPL
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-17-sjg@chromium.org>
 <3dbe42b8-7f9d-4b67-b903-692860518461@kwiboo.se>
 <CAFLszTgF9cBnQkLQX24yd-Z3KKoujkiwbBBP2c26vyOBbOaLtQ@mail.gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CAFLszTgF9cBnQkLQX24yd-Z3KKoujkiwbBBP2c26vyOBbOaLtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgaTFZITh5IQ0tLGh9JThpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 NVSktLVUpCS0tZBg++
X-HM-Tid: 0a903e100e5103a9kunm950709003a2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6ESo5PTNOHThOPxAiSCgP
 TD9PFBdVSlVKTEpCS0lDSk5DTktNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSk5INwY+
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

Hi Simon,

On 2024/6/21 22:57, Simon Glass wrote:
> Hi Jonas,
>
> On Fri, 21 Jun 2024 at 00:45, Jonas Karlman <jonas@kwiboo.se> wrote:
>> Hi Simon,
>>
>> On 2024-06-21 01:06, Simon Glass wrote:
>>> The code here is confusing due to large blocks which are #ifdefed out.
>>> Add a function phase_sdram_init() which returns whether SDRAM init
>>> should happen in the current phase, using that as needed to control the
>>> code flow.
>>>
>>> This increases code size by about 500 bytes in SPL when the cache is on,
>>> since it must call the rather large rockchip_sdram_size() function.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changes in v3:
>>> - Split out the refactoring into a separate patch
>>> - Drop the non-dcache optimisation, since the cache should normally be on
>>>
>>>   drivers/ram/rockchip/sdram_rk3399.c | 47 ++++++++++++++++-------------
>>>   1 file changed, 26 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
>>> index 3c4e20f4e80..2f37dd712e7 100644
>>> --- a/drivers/ram/rockchip/sdram_rk3399.c
>>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
>>> @@ -13,6 +13,7 @@
>>>   #include <log.h>
>>>   #include <ram.h>
>>>   #include <regmap.h>
>>> +#include <spl.h>
>>>   #include <syscon.h>
>>>   #include <asm/arch-rockchip/clock.h>
>>>   #include <asm/arch-rockchip/cru.h>
>>> @@ -63,8 +64,6 @@ struct chan_info {
>>>   };
>>>
>>>   struct dram_info {
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>>        u32 pwrup_srefresh_exit[2];
>>>        struct chan_info chan[2];
>>>        struct clk ddr_clk;
>>> @@ -75,7 +74,6 @@ struct dram_info {
>>>        struct rk3399_pmusgrf_regs *pmusgrf;
>>>        struct rk3399_ddr_cic_regs *cic;
>>>        const struct sdram_rk3399_ops *ops;
>>> -#endif
>>>        struct ram_info info;
>>>        struct rk3399_pmugrf_regs *pmugrf;
>>>   };
>>> @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
>>>                                        struct rk3399_sdram_params *params);
>>>   };
>>>
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>> -
>>>   struct rockchip_dmc_plat {
>>>   #if CONFIG_IS_ENABLED(OF_PLATDATA)
>>>        struct dtd_rockchip_rk3399_dmc dtplat;
>>> @@ -191,6 +186,17 @@ struct io_setting {
>>>        },
>>>   };
>>>
>>> +/**
>>> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
>>> + *
>>> + * Returns: true to do SDRAM init in this phase, false to not
>>> + */
>>> +static bool phase_sdram_init(void)
>>> +{
>>> +     return spl_phase() == PHASE_TPL ||
>>> +         (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
>>> +}
>>> +
>>>   static struct io_setting *
>>>   lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
>>>   {
>>> @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
>>>        struct rockchip_dmc_plat *plat = dev_get_plat(dev);
>>>        int ret;
>>>
>>> -     if (!CONFIG_IS_ENABLED(OF_REAL))
>>> +     if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
>>>                return 0;
>>>
>>>        ret = dev_read_u32_array(dev, "rockchip,sdram-params",
>>> @@ -3138,22 +3144,24 @@ static int rk3399_dmc_init(struct udevice *dev)
>>>
>>>        return 0;
>>>   }
>>> -#endif
>>>
>>>   static int rk3399_dmc_probe(struct udevice *dev)
>>>   {
>>>        struct dram_info *priv = dev_get_priv(dev);
>>>
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>> -     if (rk3399_dmc_init(dev))
>>> -             return 0;
>>> -#endif
>>> -     priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>>> -     debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
>>> -     priv->info.base = CFG_SYS_SDRAM_BASE;
>>> -     priv->info.size =
>>> -             rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
>>> +     if (phase_sdram_init()) {
>>> +             if (rk3399_dmc_init(dev))
>>> +                     return 0;
>>> +     } else {
>>> +             priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>>> +             debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
>>> +     }
>>> +
>>> +     if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
>> This check should be dropped, this driver intent is to initialize dram
>> in first phase (normally TPL), and report the size to any other phase.
> This whole patch can be dropped :-) Here I am just trying to avoid
> code-size growth when the cache is off. But yes, it is not needed.
>
>> The main need for phase_sdram_init() and disable of DCACHE can probably
>> be avoided if bob/kevin can move to use separate TPL and SPL instead of
>> doing both dram init and everything else in SPL.
>>
>> My best guess is that enabling of caches in SPL cause issue for bob and
>> kevin because they only use SPL not TPL+SPL like (if I am not mistaken)
>> all other Rockchip arm64 targets.
>>
>> Using SPL-only was not something I tested when caches was enabled in SPL.
>>
>> Maybe bob/kevin can be changed to also use TPL+SPL similar to all other
>> RK3399 boards?
>>
>> How U-Boot works on these chromebooks is still a mystery to me.
>>
>> When coreboot is involved it would only load U-Boot proper and SPL or
>> TPL+SPL would never be involved at all?
>>
>> If I understand correctly SPL is only involved for bare metal boot, if
>> this is the case then using TPL + back-to-brom to load SPL should
>> probably work fine?, and would align all RK3399 boards to work in a
>> similar way and reduce the need for special care/handling in the code.
> These boards were the first rk3399 support we had in mainline, I
> believe. Everything else came later but conversions were not done for
> these existing boards.
>
> I actually intensely dislike the back-to-brom stuff. If the ROM had an
> actual API (mmc_read(), etc.) then that would be fine. But just
> jumping back makes it hard to control what is going on.
The logic of BootRom is very simple and very clear:
- Read image from boot medium and check the availability(format of 
rockchip IDB,
     which is packed by the mkimage rksd/rkspi);
- Load TPL/dram init blob to the internal SRAM(size limit by the sram), 
and jump to the entry;
- Back to bootRom with '0' return means the dram init success, bootRom 
will get next image for dram;
- Read SPL image from boot medium to DDR start address(no size limit), 
and jump to the ddr entry;
- The signature verify will be done for all the firmware load by bootRom 
if the secure boot feature is enabled;
This model works for all Rockchip SoCs, although some SoCs have very 
limit SRAM size(only available
for DRAM init) and some other SoCs like rk3399 have bigger SRAM size.

Thanks,
- Kever
> It is interesting to hear that SPL-only is causing a problem. Do you
> have any inkling of what that might be? I could take a look at
> converting the boards to use TPL, but it does seem a bit sideways to
> the issue here. Is the bootrom doing some magic, perhaps? Is there
> decent documentation for the boot ROM these days?
>
> Regards,
> Simon
