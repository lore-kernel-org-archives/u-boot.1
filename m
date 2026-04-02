Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4113BD3940D
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 11:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7558383D8A;
	Thu,  2 Apr 2026 13:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EmX9afHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7D184011; Thu,  2 Apr 2026 13:01:18 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A5BC80212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 13:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZHSrIySrCsRkkD/CQ1qe+g+bjqUevcXWHOnajKA8bObRTkllY7720q5igIyc5xgRB+d01/TlpUAiZSHnesEqvuqwCUKgy6bBnHFfS6ehx+yo/pcET/UdtgXTMSEYlU4Q21WPRoxPSCcMvX4eINE6MHL/ZlfOYZPUpIa7E1YdFo5JknLiIlYErFgdfuNWjas1MkaU7dIuVG1VFyGsFGSzucdbqgscUgRHXeWH+irZptVho15HhiXAczP4qDjxSS6x3+/viyOFtW2nX8SE47H2r+FdV3T+j5NrHfFiiknlOKpWeWSWsFY2YDFTFSgM4lvpl+OJ91xax5ZrDR5X6tJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGkHVqFo7uSgfP2ZZpeORGE2jj01t3I6Vqq1W58pNBc=;
 b=nVJwG8KM8NDMHjjFBf6Y8A+GNzCsQIGJEqAyR+5eDCXnFWKFFjlsXp5DBdU5ZBjUWMm/ptsVG9bXk0viTqJOlc8iKcmU9HVpEdeBRp3ZRbDdGAbjF8W/SExWMFK6X8sYnUqfh1CEnO76M5WigqraRbF3VKK9WR8Ugh1Mpf8iLcYWpLJJKPHJFp8K8CO5VPRhZU3W7nJgF6oHi7tQPzynhg9Y4Dhl/ZrwQf/ytmC3pdDgTHwvZg5Ty2faV3sEeEY75dTNrThl3bkStPIx3rgZDfnZv4nHqi+Ok0mi27inGLDsONewXib36Ikn8HIsj+RCFGX8Y83H1q8+ugYVxdgkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGkHVqFo7uSgfP2ZZpeORGE2jj01t3I6Vqq1W58pNBc=;
 b=EmX9afHu7dCnY3UWZ7EcEn+wKoAEqyZeLYyIvCp0FBBafGxIr0JuuUEoiRhDcTIWkr7hvSGoJz7mYcyzdyO48fFd8M0zdWen4SGXmXEO1zDRfYUeP7BQXZ5WmICnIS+gGRKKpDPkUopZHuwBl+i4cI76GCFe6XemDV6+d5XKWgU=
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 11:01:12 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::cd) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Thu,
 2 Apr 2026 11:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:01:11 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 06:01:10 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 06:01:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 06:01:10 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632B16OP1880981;
 Thu, 2 Apr 2026 06:01:07 -0500
Message-ID: <0c4f352c-7de8-46ad-8e4d-60fa187d6160@ti.com>
Date: Thu, 2 Apr 2026 16:33:12 +0530
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
 <4ec0cbe4-2184-4e0b-95d1-621f4665d680@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <4ec0cbe4-2184-4e0b-95d1-621f4665d680@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 5726a61b-708c-4e35-4aa2-08de90a726ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rsEFRPp1MiPng/S6wu5TgI6YvJHI95oRwKpp3fH5DIYvENGuGiT6HoCfraXamtwjGTZEm6vV0/iolA4sLF33KRBdUGxYGCBjUZxAqWhpVf1fZX4A89hs3MMWUy+SbhBUZrc9p9/XzDTlvYPkEiXcz2spD7buuTs5QpwKaO2np9asmzMSqBLEKYOflHLx7gAn7sAWC3vlwyR3bkH4jhxdUl32MVP5OFShcqktASsLRdepS7IrLjcPScUb9CZxe64cAH3LWnR/1ahF3oBzS9hNFRtmaXCQrBC+dSs7ZY2fgBg9mNOm5Zs9Z/chLQN9L+tc0JIgeCTPv3Y/pKZNUWDa95fV3FO5Fn2ugo4M/1QyOwVr3lUiid1Z+xfRn/JbZ7f6FxhuwXHG7oshkAh8X5EpPWdCkRDXJROUfQyGILimVLQiAr+8JJoGhk/6nDop9Fqy+nYdFQ2zj0PaI1aV89ZdmCgetjev4MISZVjps2ELpHow746j4YXwgj+uj0gpwBSTwebG5h/a/FpaGOf3errBxYSWvm6W5oUJj/MNCsJYxU+ZQRtpGPwmRK/ohdDnagpbrigb+BTNTvSOF3+H7hOdk+ueI0VFENfNNxCFyEwMv0rcXCRoPLjEp1qzlTg9wklj9TZH02bxEHnNj0LP3H92yQfhGJXww46VVTna3Ei+7y4uiDQKhIQG1yC+nDtQ+VKeYUtaEoiEi0avNDgW5tAJamQDayj88fXc2Osku3IRIoY=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6O5Hhm7DSHBNUu5Vn32on9XWix7/DsnA7kTQYAbhpkwLa51CiG0HaRiykhzQLYoQCpb3T/68R1BMtonL9IoIsondvFfesDB3NJthbjw8DGVNytskS7r69snScHmfgJLSxVBpxQ9p8bedpKXC2oHmExG22blB51RX258mo+h0qo2zbPzvetc16fA3OpG9WJ+mOwM7CyZsCzhKzlpgNTBHjGM+Pft051ffHsh1S09x/4OCGGxaJac8kvp1+5ED14zE+44XQTck6qZVLEWrcZmU6b0g5wphghJMT2eijslWAO+KhRl0PkJJdmcieJ9FoqPlWV3q/1pScIgIb1hC2Hc1v2FNitPF85K/NrkI2Wm3fB5jbyZJz3tXHoP+Mh9/jXLn9B9FRGfc4TOdXMFzL+XUIhZWZuDvWXov1HHU+UiR2Dlok0r92qnic3lh+hoW+oax
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:01:11.9027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5726a61b-708c-4e35-4aa2-08de90a726ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
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

Hello Marek,

On 13/03/26 09:29, Siddharth Vadapalli wrote:
> On 12/03/26 20:31, Marek Vasut wrote:
>> On 3/12/26 2:50 PM, Tom Rini wrote:
>>> On Thu, Mar 12, 2026 at 07:02:47PM +0530, Prasanth Babu Mantena wrote:
>>>
>>>> While USB DFU boot works with this patch, but the non USB boot modes like
>>>> SD Boot and flash boot fails for J784S4 EVM device.
>>>>
>>>> So, Reverting this patch.
>>>>
>>>> This reverts commit bfb530e06ca6c19f66c079601e568c761a001993.
>>>>
>>>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>>>> ---
>>>>   drivers/usb/cdns3/core.c | 53 ----------------------------------------
>>>>   drivers/usb/cdns3/drd.c  | 11 ---------
>>>>   2 files changed, 64 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>> index 10bc4cabed4..4434dc15bec 100644
>>>> --- a/drivers/usb/cdns3/core.c
>>>> +++ b/drivers/usb/cdns3/core.c
>>>> @@ -392,52 +392,6 @@ static const struct udevice_id cdns3_ids[] = {
>>>>       { },
>>>>   };
>>>> -/*
>>>> - * The VBUS Valid Bit in the OTG Status register can be used to determine
>>>> - * the role. When VBUS Valid is set, it indicates that a USB Host is 
>>>> supplying
>>>> - * power, so the Controller should assume the PERIPHERAL role. If it 
>>>> isn't set,
>>>> - * it indicates the absence of a USB Host, so the Controller should 
>>>> assume the
>>>> - * HOST role. If the OTG Status register is inaccessible, return an 
>>>> error.
>>>> - */
>>>> -static int cdns3_get_otg_mode(struct udevice *parent, enum usb_dr_mode 
>>>> *mode)
>>>> -{
>>>> -    /* Create a temporary child device for using 
>>>> devfdt_remap_addr_name() */
>>>> -    struct udevice child = {
>>>> -        .parent = parent,
>>>> -    };
>>>> -    struct cdns3 cdns, *cdnsp;
>>>> -    void __iomem *otg_regs;
>>>> -
>>>> -    dev_set_ofnode(&child, ofnode_first_subnode(dev_ofnode(parent)));
>>>> -    otg_regs = devfdt_remap_addr_name(&child, "otg");
>>>> -    if (!otg_regs) {
>>>> -        dev_err(parent, "failed to get otg registers for child node\n");
>>>> -        return -ENXIO;
>>>> -    }
>>>> -
>>>> -    /*
>>>> -     * As mentioned in drivers/usb/cdns3/drd.c, there are two versions
>>>> -     * of the Controller. The following logic detects the version of the
>>>> -     * Controller and interprets the register layout accordingly.
>>>> -     */
>>>> -    cdnsp = &cdns;
>>>> -    cdnsp->otg_v0_regs = otg_regs;
>>>> -    if (!readl(&cdnsp->otg_v0_regs->cmd)) {
>>>> -        cdnsp->otg_regs = otg_regs;
>>>> -    } else {
>>>> -        cdnsp->otg_v1_regs = otg_regs;
>>>> -        cdnsp->otg_regs = (void *)&cdnsp->otg_v1_regs->cmd;
>>>> -    }
>>>> -
>>>> -    /* Use VBUS Valid to determine role */
>>>> -    if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID)
>>>> -        *mode = USB_DR_MODE_PERIPHERAL;
>>>> -    else
>>>> -        *mode = USB_DR_MODE_HOST;
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>>   int cdns3_bind(struct udevice *parent)
>>>>   {
>>>>       enum usb_dr_mode dr_mode;
>>>> @@ -459,13 +413,6 @@ int cdns3_bind(struct udevice *parent)
>>>>       if (dr_mode == USB_DR_MODE_UNKNOWN)
>>>>           dr_mode = usb_get_dr_mode(dev_ofnode(parent));
>>>> -    /* Use VBUS Valid to determine role */
>>>> -    if (dr_mode == USB_DR_MODE_OTG) {
>>>> -        ret = cdns3_get_otg_mode(parent, &dr_mode);
>>>> -        if (ret < 0)
>>>> -            return ret;
>>>> -    }
>>>> -
>>>>       switch (dr_mode) {
>>>>   #if defined(CONFIG_SPL_USB_HOST) || \
>>>>       (!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
>>>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>>>> index 0ca40a5cc8d..cbb13342343 100644
>>>> --- a/drivers/usb/cdns3/drd.c
>>>> +++ b/drivers/usb/cdns3/drd.c
>>>> @@ -301,17 +301,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
>>>>           cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>>>>       }
>>>> -    /*
>>>> -     * In the absence of STRAP configuration, use VBUS Valid to
>>>> -     * determine the appropriate role to be assigned to dr_mode.
>>>> -     */
>>>> -    if (cdns->dr_mode == USB_DR_MODE_OTG) {
>>>> -        if (cdns3_get_vbus(cdns))
>>>> -            cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>>>> -        else
>>>> -            cdns->dr_mode = USB_DR_MODE_HOST;
>>>> -    }
>>>> -
>>>>       state = readl(&cdns->otg_regs->sts);
>>>>       if (OTGSTS_OTG_NRDY(state) != 0) {
>>>>           dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
>>>
>>> Adding in the USB custodian as this revert is intended for master and
>>> v2026.04 I assume as the commit being reverted is also in master.
>>> Thanks.
>> This may be related to
>>
>> [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and probe 
>> parent
>>
>> ?
>>
>> Can you coordinate with Siddharth Vadapalli ?
> Please refer to my response at:
> https://lore.kernel.org/r/17a341aa-4711-4389-8ea1-a8169616baeb@ti.com/
> on the patch quoted above
> ([PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and probe 
> parent)
> 
> A common .probe as a stub will not work and probing the parent in 
> cdns3_bind() doesn't seem to be acceptable. So reverting the commit appears 
> to be the only option at the moment to fix non-USB Boot Modes.
Please note that this revert patch is required to fix non-USB Boot Mode. If 
you have a suggestion for an alternative, please let me know.

Regards,
Siddharth.
