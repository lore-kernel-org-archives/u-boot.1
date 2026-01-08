Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2517CD1488B
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1E18416C;
	Thu,  8 Jan 2026 15:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="uryrE72T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D9884175; Thu,  8 Jan 2026 15:29:35 +0100 (CET)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [91.218.175.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9ADB8412C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
Message-ID: <dce30059-f738-4cab-ae88-195b5f0887fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767882571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPJ5JGNFdDAwZrxbn+7qFg10bQlNUeuAf6lBZKDwVVw=;
 b=uryrE72TYYgDuasxgwIEGPGiHADmwA+zheTkh8bR2gegw2IkEqDGEK+EXCGw0xz36B5BGZ
 xmg1+u79KVYLO8XmVdm4kZjzN65WdPixr81F8nLNiejoTJj32YORt1r9roslfTDe25RzY7
 ouVsazV3DeTVKr/dZEEkDlxaNk1t1+A=
Date: Thu, 8 Jan 2026 09:29:28 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: Add power sequencing driver for PCI slots
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260106223409.748335-1-sean.anderson@linux.dev>
 <CALeDE9NR8TZw1Vpgn4c0if2z1geXhB1dU_VLi8dOckiZDZZNoA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CALeDE9NR8TZw1Vpgn4c0if2z1geXhB1dU_VLi8dOckiZDZZNoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 1/7/26 23:07, Peter Robinson wrote:
> Hi Sean,
> 
>> Extend the PCI bridge driver to enable resources associated with PCI
>> slots like clocks, power rails, and resets. This is modeled off of the
>> PCI power control subsystem in Linux. The traditional compatible for PCI
>> slots in U-Boot is pci-bridge, but Linux uses the more-systematic
>> pciclass,0604 so add that as an option.
> 
> Not sure if you're aware but upstream is doing a big rework of the
> pwctrl stuff[1], I'm not sure if this would need to be adjusted to
> take any of those changes into account but might be worth considering
> reviewing the issues being addressed by that rework too.

Yes, I saw that (and commented on v2 [1]). But the devicetree stuff is
the same, and we can use a much simpler model in U-Boot because device
probing is synchronous. That series is also not merged yet.

--Sean

[1] https://lore.kernel.org/linux-pci/39e025bd-50f4-407d-8fd4-e254dbed46b2@linux.dev/

> 
> [1] https://lore.kernel.org/linux-pci/20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com/T/#t
> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>  drivers/pci/Kconfig      |  8 ++++++
>>  drivers/pci/pci-uclass.c | 55 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 63 insertions(+)
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index ea9868425d0..efac18b33f6 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -100,6 +100,14 @@ config PCI_ENHANCED_ALLOCATION
>>           Enable support for Enhanced Allocation which can be used by supported
>>           devices in place of traditional BARS for allocation of resources.
>>
>> +config PCI_PWRCTRL_SLOT
>> +       bool "PCI slot power control"
>> +       help
>> +         This is a generic driver that controls the power state of different
>> +         PCI slots. The clocks and resets for the PCI slots are expected to be
>> +         defined in the devicetree node of the PCI bridge. Say N if your PCI
>> +         busses don't have software-controlled clocks or power rails.
>> +
>>  config PCI_ARID
>>          bool "Enable Alternate Routing-ID support for PCI"
>>          help
>> diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
>> index c370f8c6400..c5b1ddec45a 100644
>> --- a/drivers/pci/pci-uclass.c
>> +++ b/drivers/pci/pci-uclass.c
>> @@ -6,6 +6,7 @@
>>
>>  #define LOG_CATEGORY UCLASS_PCI
>>
>> +#include <clk.h>
>>  #include <dm.h>
>>  #include <errno.h>
>>  #include <init.h>
>> @@ -14,6 +15,7 @@
>>  #include <pci.h>
>>  #include <spl.h>
>>  #include <asm/global_data.h>
>> +#include <asm/gpio.h>
>>  #include <asm/io.h>
>>  #include <dm/device-internal.h>
>>  #include <dm/lists.h>
>> @@ -1893,13 +1895,66 @@ static const struct dm_pci_ops pci_bridge_ops = {
>>
>>  static const struct udevice_id pci_bridge_ids[] = {
>>         { .compatible = "pci-bridge" },
>> +       { .compatible = "pciclass,0604" },
>>         { }
>>  };
>>
>> +static int __maybe_unused pci_bridge_probe(struct udevice *dev)
>> +{
>> +       struct clk clk;
>> +       struct gpio_desc perst;
>> +
>> +       if (!clk_get_by_index(dev, 0, &clk)) {
>> +               int ret = clk_enable(&clk);
>> +
>> +               if (ret)
>> +                       return log_msg_ret("clk", ret);
>> +
>> +               /* Delay for T_PERST-CLK (100 us for all slot types) */
>> +               udelay(100);
>> +       }
>> +
>> +       if (!gpio_request_by_name(dev, "reset-gpios", 0, &perst, 0)) {
>> +               unsigned long delay = 0;
>> +               int ret;
>> +
>> +               /*
>> +                * If PERST is inactive, the following call to dm_gpio_clrset_flags
>> +                * will be the first time we assert it and we will need to
>> +                * delay for T_PERST.
>> +                */
>> +               if (dm_gpio_get_value(&perst) != 1)
>> +                       delay = 100;
>> +
>> +               ret = dm_gpio_clrset_flags(&perst, GPIOD_MASK_DIR,
>> +                                          GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>> +               if (ret)
>> +                       return log_msg_ret("set", ret);
>> +               mdelay(delay);
>> +
>> +               ret = dm_gpio_set_value(&perst, 0);
>> +               if (ret)
>> +                       return log_msg_ret("clr", ret);
>> +
>> +               /*
>> +                * PCIe section 6.6.1:
>> +                * > ... software must wait a minimum of 100 ms before sending a
>> +                * > Configuration Request to the device immediately below that
>> +                * > Port.
>> +                */
>> +               mdelay(100);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  U_BOOT_DRIVER(pci_bridge_drv) = {
>>         .name           = "pci_bridge_drv",
>>         .id             = UCLASS_PCI,
>>         .of_match       = pci_bridge_ids,
>> +#if CONFIG_IS_ENABLED(PCI_PWRCTRL_SLOT)
>> +       .probe          = pci_bridge_probe,
>> +#endif
>>         .ops            = &pci_bridge_ops,
>>  };
>>
>> --
>> 2.35.1.1320.gc452695387.dirty
>>
>> base-commit: 38ace442b630c5ddf049af83e8db229c012ed355
>> branch: pci_pwrseq
