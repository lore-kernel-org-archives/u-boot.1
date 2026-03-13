Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2659F106FD72
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 03:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F3284166;
	Fri, 13 Mar 2026 04:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SOCFbJwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C48A84167; Fri, 13 Mar 2026 04:58:15 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD49984068
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 04:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTumFsEfZ8GsGO7ZMAhvGMbnF2VVu8iwNVTvG7N1DEvH+i+x1iQNqOi0/TEiONV4vZye5wuiCXq8wvHFJay+gXbU5R0Pw6GAR0JRyvmudWBYIfavd+Lov3/tAwmkHHvnqcTjkEC4Vkp1YkHYyrnZ7bsoViG/QJBwaZXa6pW38FHiSC2Xqr5irbSsPsYHW4remtwiUWGdhRVQzx0fD/je0WWqMjwxxH2jLlA0lkTx/oHVeeW13xkyi2SOLVD+ZTzPPJLz+6CmRYatYsw/AtFblMN4uY98XBapxHtqweOtAni9y3p8zmob/QZ0QL54dr+hsSFTDvfOJUU15v1FDHquDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqzKj3LBHHGW/u1iEFj5eTM4tA29TAqIEfqAJmZ//1M=;
 b=g0TJC/bGurOKKCLxBDuvrPhijnjYKFzV/ZeWx8CxiO0azR+X/3mpdGfzu2MLJUibpIY7rQT9+sdkNxuEuUxp4Szvmoj3xJQ/Yk2tvIlq33h/G3/evt08W4pBKgJMal93OQYPsyHzeaoIJGuzCjlR1GWaeMUMvtlLd+662j/nxyo8fkc1c8gYtixnvKyeeFQCs4h5AOpFuAtovAWe4dmvvVLK9jOrN6qAr9uM3wjrIUhR/BthE/h1y83QMYQZKlpNahjtB3nEO03VtGivqiOVudKn244HL/NTTQdF1YPZ9OvRD8lm6j1v/g2RBLzLQrhzn15zN2Kqt9QO37JjDDussg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqzKj3LBHHGW/u1iEFj5eTM4tA29TAqIEfqAJmZ//1M=;
 b=SOCFbJwtypnB8KETJAHXsvG4Qdwrzo4iFb/QJ1EcBAJ5oSvSo6STvM95cWk9zplXX95EJXGG/jwEfeR3eVGcY/9WeG4AL3m/cQF8eGEYVxcbO2B116c8XSe8D4NNMdYsQWDFyKGztOQYCjjZ9psodJMrImMo3HPLKpXH+/KouqY=
Received: from MN0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:52c::14)
 by DS7PR10MB5038.namprd10.prod.outlook.com (2603:10b6:5:38c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 03:58:10 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::5c) by MN0PR05CA0023.outlook.office365.com
 (2603:10b6:208:52c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 03:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 03:58:08 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 22:58:05 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 22:58:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 22:58:05 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62D3w2YZ4043627;
 Thu, 12 Mar 2026 22:58:03 -0500
Message-ID: <4ec0cbe4-2184-4e0b-95d1-621f4665d680@ti.com>
Date: Fri, 13 Mar 2026 09:29:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Tom Rini <trini@konsulko.com>, Prasanth Babu Mantena <p-mantena@ti.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] Revert "usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG"
To: Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut
 <marek.vasut+usb@mailbox.org>
References: <20260312133247.2192335-1-p-mantena@ti.com>
 <20260312135019.GA502704@bill-the-cat>
 <c57a8801-8282-4df3-a813-3ba7948cc054@mailbox.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <c57a8801-8282-4df3-a813-3ba7948cc054@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS7PR10MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: a800fe24-eddc-41e5-d49d-08de80b4bd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /SInEhv/7HiJ3qtHhAZ341/moOvhpHlLenwE9+cowHY+mI6JYyt/VmB7Kav2X5XFrt8TmREI4GkMyGQiMog5gAqpYGstz00VDQ7RiiKJ6Q0jLnXri67sX7TY8mn1he9AE2FxPz7JmXaB1Wrj7X9a8xlG5lWH0o35CDi44gLZHe3uE8RWCEPwqliWgs5dPtPXovPwqUFAaBoPgR3J1mrd8P14nzRF2OVf0Bz87n+myxJjqU2pKFGbmZ18tp5T6aOykOJzdMNQtyJCW5uJIuiU6v8M8bJfibLyISOFtEKur+EaqW90H0lTnbBM66lnZCWBOHI3K89kJ3uC5uiyoG3plA/2QkAkG5ywPEASDIBJjqKTwQrZTLGlT2KXp/qoM/O2/9KFK6q+dZMey0Acj59YLEZ0O7B8q9x+h0Zy2kouqRBwboBFJFSbXGIjraJ0Gi3Abza+6Sh9lsvfm02Sabb2KY2rdXrLCiYIvCRbP/pw8+SXu8K6myGANWOaGgnvUws0sg2pPIDxw8wjD7BVKSzq1GNWeRHJNCPCvNl/7UwRLvtE70AyeTxTRN5jKdUYp4m8MdQaOk7+Vx7ZY/Hf7Apo2CZV5WbW3hdsTTeBMesZwsujgQJIovknlS+Cu9OIKrEOEIJle3+eyd02AksjIx6OwPnf+tLzU15PFllmyrRcpXoiq/8z80z6PAqoN+TzTF0P6Wsgzahb/uFguQV7RsopGNHqhaDxcbH1rFSTQZIFrDABNXfKfzOp5GiLcUqjmxBX5pVBs0iGY+DVIqLOVDMKVQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eHq170YLMGSU481K+b6W/3iyKspZF3oqOEw+o2gQu6RVuGIeA2VuiM9nfrnpIz3crV6Ssz9Oqgq/btqG3SDlTwEEKAQG7uRygMU4yt+FsPy3KIp4SAgHZM6D9t2BRVyHFzsRjC/pkuCk5YijllBOvbNAc1ahn29YHeLGw8zlBPexP0sRZbpxiZJqvAN92ZdT48YbSTO72H58hdNB61yV+vFpmFnB6HXN6MRfzH8Qg8jk5WOax4jDzgSrm89md2jwPLmOv+rx2wb1gIQ6nc4UVJhmONkDl+SQaQXGrNk0scYT5fu3y61dQoc0xjntqlcIhteRrspco3h8JzIZtrVosXXuMm2UEXIJCXQzFjvvn2FTaqfYNe2dPs3L8wrQn/Z7Stat8bOXb0BTRc6GAzZObNDOTiciDvTVUmroUguJ5k9DlSInPFN6q+JIsjXt1kkw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 03:58:08.6732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a800fe24-eddc-41e5-d49d-08de80b4bd15
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5038
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

On 12/03/26 20:31, Marek Vasut wrote:
> On 3/12/26 2:50 PM, Tom Rini wrote:
>> On Thu, Mar 12, 2026 at 07:02:47PM +0530, Prasanth Babu Mantena wrote:
>>
>>> While USB DFU boot works with this patch, but the non USB boot modes like
>>> SD Boot and flash boot fails for J784S4 EVM device.
>>>
>>> So, Reverting this patch.
>>>
>>> This reverts commit bfb530e06ca6c19f66c079601e568c761a001993.
>>>
>>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>>> ---
>>>   drivers/usb/cdns3/core.c | 53 ----------------------------------------
>>>   drivers/usb/cdns3/drd.c  | 11 ---------
>>>   2 files changed, 64 deletions(-)
>>>
>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>> index 10bc4cabed4..4434dc15bec 100644
>>> --- a/drivers/usb/cdns3/core.c
>>> +++ b/drivers/usb/cdns3/core.c
>>> @@ -392,52 +392,6 @@ static const struct udevice_id cdns3_ids[] = {
>>>       { },
>>>   };
>>> -/*
>>> - * The VBUS Valid Bit in the OTG Status register can be used to determine
>>> - * the role. When VBUS Valid is set, it indicates that a USB Host is 
>>> supplying
>>> - * power, so the Controller should assume the PERIPHERAL role. If it 
>>> isn't set,
>>> - * it indicates the absence of a USB Host, so the Controller should 
>>> assume the
>>> - * HOST role. If the OTG Status register is inaccessible, return an error.
>>> - */
>>> -static int cdns3_get_otg_mode(struct udevice *parent, enum usb_dr_mode 
>>> *mode)
>>> -{
>>> -    /* Create a temporary child device for using 
>>> devfdt_remap_addr_name() */
>>> -    struct udevice child = {
>>> -        .parent = parent,
>>> -    };
>>> -    struct cdns3 cdns, *cdnsp;
>>> -    void __iomem *otg_regs;
>>> -
>>> -    dev_set_ofnode(&child, ofnode_first_subnode(dev_ofnode(parent)));
>>> -    otg_regs = devfdt_remap_addr_name(&child, "otg");
>>> -    if (!otg_regs) {
>>> -        dev_err(parent, "failed to get otg registers for child node\n");
>>> -        return -ENXIO;
>>> -    }
>>> -
>>> -    /*
>>> -     * As mentioned in drivers/usb/cdns3/drd.c, there are two versions
>>> -     * of the Controller. The following logic detects the version of the
>>> -     * Controller and interprets the register layout accordingly.
>>> -     */
>>> -    cdnsp = &cdns;
>>> -    cdnsp->otg_v0_regs = otg_regs;
>>> -    if (!readl(&cdnsp->otg_v0_regs->cmd)) {
>>> -        cdnsp->otg_regs = otg_regs;
>>> -    } else {
>>> -        cdnsp->otg_v1_regs = otg_regs;
>>> -        cdnsp->otg_regs = (void *)&cdnsp->otg_v1_regs->cmd;
>>> -    }
>>> -
>>> -    /* Use VBUS Valid to determine role */
>>> -    if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID)
>>> -        *mode = USB_DR_MODE_PERIPHERAL;
>>> -    else
>>> -        *mode = USB_DR_MODE_HOST;
>>> -
>>> -    return 0;
>>> -}
>>> -
>>>   int cdns3_bind(struct udevice *parent)
>>>   {
>>>       enum usb_dr_mode dr_mode;
>>> @@ -459,13 +413,6 @@ int cdns3_bind(struct udevice *parent)
>>>       if (dr_mode == USB_DR_MODE_UNKNOWN)
>>>           dr_mode = usb_get_dr_mode(dev_ofnode(parent));
>>> -    /* Use VBUS Valid to determine role */
>>> -    if (dr_mode == USB_DR_MODE_OTG) {
>>> -        ret = cdns3_get_otg_mode(parent, &dr_mode);
>>> -        if (ret < 0)
>>> -            return ret;
>>> -    }
>>> -
>>>       switch (dr_mode) {
>>>   #if defined(CONFIG_SPL_USB_HOST) || \
>>>       (!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
>>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>>> index 0ca40a5cc8d..cbb13342343 100644
>>> --- a/drivers/usb/cdns3/drd.c
>>> +++ b/drivers/usb/cdns3/drd.c
>>> @@ -301,17 +301,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
>>>           cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>>>       }
>>> -    /*
>>> -     * In the absence of STRAP configuration, use VBUS Valid to
>>> -     * determine the appropriate role to be assigned to dr_mode.
>>> -     */
>>> -    if (cdns->dr_mode == USB_DR_MODE_OTG) {
>>> -        if (cdns3_get_vbus(cdns))
>>> -            cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>>> -        else
>>> -            cdns->dr_mode = USB_DR_MODE_HOST;
>>> -    }
>>> -
>>>       state = readl(&cdns->otg_regs->sts);
>>>       if (OTGSTS_OTG_NRDY(state) != 0) {
>>>           dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
>>
>> Adding in the USB custodian as this revert is intended for master and
>> v2026.04 I assume as the commit being reverted is also in master.
>> Thanks.
> This may be related to
> 
> [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and probe parent
> 
> ?
> 
> Can you coordinate with Siddharth Vadapalli ?
Please refer to my response at:
https://lore.kernel.org/r/17a341aa-4711-4389-8ea1-a8169616baeb@ti.com/
on the patch quoted above
([PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and probe 
parent)

A common .probe as a stub will not work and probing the parent in 
cdns3_bind() doesn't seem to be acceptable. So reverting the commit appears 
to be the only option at the moment to fix non-USB Boot Modes.

Regards,
Siddharth.
