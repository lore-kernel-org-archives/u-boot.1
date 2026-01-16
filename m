Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB7C982D1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 16:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B65F8389A;
	Fri, 16 Jan 2026 17:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="no5f5nGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C37B83015; Fri, 16 Jan 2026 17:11:05 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4F1833C6
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 17:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dt4b90tfbz9t18;
 Fri, 16 Jan 2026 17:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768579861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRj1QUXQooSRFvHdY3L51JoMbG3Hfrs0cwlqHUoINcI=;
 b=no5f5nGr5BN7aey5JIQN9gn/1LERpQiLNCoQdXfLX6/GvQCR5gfwRbN9yO6dbk9MmlEKYA
 6UkB8taIcnYNYSPNzuyd+oRi9qhbDkOA6Ufjb2Lx+/3WGwrvDInH3/wTmE0iUZX/qHxILE
 aa7QzbItptoMnSZBP/z6M/dUAO3Q0yk7+QZ586+i7lTIIsJWv+cdN2V4HeFKd0R9M0xaum
 zv57JYnUY5ztQcDtjKZ0x/U9vhfjDBUiYpIJ5WaxR+ZmW4ZMyGdFbakF5OhyKZOYYBJu3j
 oGYY4jVRe2pefqgRq2VkSx2bMJZYLr+oejqm116SsZw7SM0aOLCQG2ieeCeb9Q==
Message-ID: <8dad4173-4b2b-4ba7-8e73-838182570bc1@mailbox.org>
Date: Fri, 16 Jan 2026 15:07:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: Initialize Xilinx glue registers
To: Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260106221728.738219-1-sean.anderson@linux.dev>
 <8265ad50-83d1-40fa-943d-b6e64d9b7812@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8265ad50-83d1-40fa-943d-b6e64d9b7812@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eje7f8t3ij4w7owoon3krxhokaxzzaot
X-MBO-RS-ID: 8d15efe0799416f2c3e
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

On 1/16/26 9:19 AM, Michal Simek wrote:
> 
> 
> On 1/6/26 23:17, Sean Anderson wrote:
>> These registers may have been initialized by SPL/FSBL, but program them
>> in case they have not. If they are left at their default values, the
>> controller will never exit reset.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>
>> ---
>>
>>   drivers/usb/dwc3/dwc3-generic.c | 32 ++++++++++++++++++++++++++------
>>   drivers/usb/dwc3/dwc3-generic.h |  2 ++
>>   2 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3- 
>> generic.c
>> index c09014aec60..ce896db9532 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -501,6 +501,27 @@ struct dwc3_glue_ops rk_ops = {
>>       .glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
>>   };
>> +void dwc3_xlnx_glue_configure(struct udevice *dev, int index,
>> +                  enum usb_dr_mode mode)
>> +{
>> +/* USB glue registers */
>> +#define USB3_FPD_PIPE_CLK    0x7c
>> +#define USB3_FPD_POWER_PRSNT    0x80
>> +    struct dwc3_glue_data *glue = dev_get_plat(dev);
>> +    void *base = map_physmem(glue->regs, 0x10000, MAP_NOCACHE);
>> +
>> +    if (generic_phy_valid(&glue->phy)) {
>> +        writel(0, base + USB3_FPD_PIPE_CLK);
>> +        writel(1, base + USB3_FPD_POWER_PRSNT);
>> +    } else {
>> +        writel(1, base + USB3_FPD_PIPE_CLK);
>> +    }
>> +}
>> +
>> +struct dwc3_glue_ops xlnx_ops = {
>> +    .glue_configure = dwc3_xlnx_glue_configure,
>> +};
>> +
>>   static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>>   {
>>       const char *name = ofnode_get_name(node);
>> @@ -621,11 +642,10 @@ int dwc3_glue_probe(struct udevice *dev)
>>       struct udevice *child = NULL;
>>       int index = 0;
>>       int ret;
>> -    struct phy phy;
>> -    ret = generic_phy_get_by_name(dev, "usb3-phy", &phy);
>> +    ret = generic_phy_get_by_name(dev, "usb3-phy", &glue->phy);
>>       if (!ret) {
>> -        ret = generic_phy_init(&phy);
>> +        ret = generic_phy_init(&glue->phy);
>>           if (ret)
>>               return ret;
>>       } else if (ret != -ENOENT && ret != -ENODATA) {
>> @@ -643,8 +663,8 @@ int dwc3_glue_probe(struct udevice *dev)
>>       if (ret)
>>           return ret;
>> -    if (generic_phy_valid(&phy)) {
>> -        ret = generic_phy_power_on(&phy);
>> +    if (generic_phy_valid(&glue->phy)) {
>> +        ret = generic_phy_power_on(&glue->phy);
>>           if (ret)
>>               return ret;
>>       }
>> @@ -690,7 +710,7 @@ int dwc3_glue_remove(struct udevice *dev)
>>   }
>>   static const struct udevice_id dwc3_glue_ids[] = {
>> -    { .compatible = "xlnx,zynqmp-dwc3" },
>> +    { .compatible = "xlnx,zynqmp-dwc3", .data = (ulong)&xlnx_ops },
>>       { .compatible = "xlnx,versal-dwc3" },
>>       { .compatible = "ti,keystone-dwc3"},
>>       { .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
>> diff --git a/drivers/usb/dwc3/dwc3-generic.h b/drivers/usb/dwc3/dwc3- 
>> generic.h
>> index 40902c8923f..13f6391cae8 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.h
>> +++ b/drivers/usb/dwc3/dwc3-generic.h
>> @@ -10,12 +10,14 @@
>>   #define __DRIVERS_USB_DWC3_GENERIC_H
>>   #include <clk.h>
>> +#include <generic-phy.h>
>>   #include <reset.h>
>>   #include <dwc3-uboot.h>
>>   struct dwc3_glue_data {
>>       struct clk_bulk        clks;
>>       struct reset_ctl_bulk    resets;
>> +    struct phy phy;
>>       fdt_addr_t regs;
>>       fdt_size_t size;
>>   };
> 
> I will let Marek to handle this. From my perspective we should take 
> Jerome's patchset to update usb stack and then add this on the top.
Since this fixes a real bug and is isolated to xilinx platform, it would 
be good if xilinx at least provided feedback on this patch.

+CC Ilias
