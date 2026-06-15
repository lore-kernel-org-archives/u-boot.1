Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47D9CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B179846A4;
	Mon, 15 Jun 2026 14:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AZ0ti6Jm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D5EB84704; Mon, 15 Jun 2026 14:27:08 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20D683FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XngTZgnIaca5rUGyQPgoxRPmOIJjosQgCKC2GKhtNRMlOw7vfj9WFuoHIjzkzeyKz4EV5IjW1LqpKsF3WNbnAEn3/kQF0QUbOy+vfqBO+fovq4z32tjZrUDmtGwKHVo32qf2n1gxCOM/L0KgtUHSuxmzGPs5iCIG+2o50mLJAS6/628ecVm+Ry8oEQsCV8nbs1Kvs9OfB9uMWdCTKyzZft8NoTeK2wGW1TFKDkU9afGR/dWEwfcanua+pM93gyknQFT6QxYRiX4CATn6IdTZVRCtbuni7zBDPW3zmeIVq2YR9K9km8W7gi590b+LB8ifCh1O34x0uHC3/vLSoHdoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JowBzS50xey4t89qDKDOGJxkk5+l0Ow4XZGoc2SITQ=;
 b=RzQgSEm+EwGW8LCuzI4Q41ypBKTyYaHUBcR0zmigW7xNegfk8vXO0wJG/UGYvVwZv+yDHoLOW/yrlmXf9gbtvs/9hdp6Y4MXiZM9YMwg3wJDXBxIUeunkFCqEPJQhnkSHiPkozOy+2UaWdIXbG2Dt8xuzh84T49CYc7acEVGud2oi8em+eEeS81XXzYFvNtvdlgqqP0rvTogXGh39fQSqoaV+/CBspOO0BwA6veJZwzgSLENcUhPfuqBwpRXCWxJc8bE+/wEBRBwlH5gyE4zQQrsQzSTitsVrzEsKFwSdUR4rgNRLkQvmKjh/O2osPdB87rKVPrkXIskB3/fIV5rIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JowBzS50xey4t89qDKDOGJxkk5+l0Ow4XZGoc2SITQ=;
 b=AZ0ti6Jm6oeByatWHz+LFktR1TuqHwCcbTPbupphdXIBlfbS4wA4aZRrnhVBYiLZGC6hPfC0aXLKkpW/hltukIxB9vzoCA35jYcEu4bFiXY+MCda35CYwrNhhwZH9lECVOEdK1fPraBGTu7b+3IIZNYThr6uyWH+evTjo2ZIZnk=
Received: from CY8P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::7) by
 MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 12:27:00 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:930:46:cafe::20) by CY8P220CA0024.outlook.office365.com
 (2603:10b6:930:46::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 12:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 12:26:57 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 15 Jun
 2026 07:26:13 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 15 Jun
 2026 07:26:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 15 Jun 2026 07:26:12 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65FCQ9X01884507;
 Mon, 15 Jun 2026 07:26:10 -0500
Message-ID: <2b8587b9-619a-4497-b1b3-f390c90aa693@ti.com>
Date: Mon, 15 Jun 2026 17:59:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Jai Luthra <jai.luthra@ideasonboard.com>, <andrew.goodbody@linaro.org>,
 <c-vankar@ti.com>, <jerome.forissier@arm.com>,
 <matthias.schiffer@ew.tq-group.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <nm@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config() for
 speed
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
 <178118305958.1799417.3241467311184856154@freya>
 <18490eb5-3ab5-4e78-a723-553983c9ed17@ti.com>
 <10236b090b3e6c1ca978c4d71a9d4b15abf3e1b3.camel@ew.tq-group.com>
 <0d62b807-4205-4b65-bed7-d8686b5386cd@ti.com>
 <9d16a17d1e0cea6a129700248896e90c4d74729d.camel@ew.tq-group.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <9d16a17d1e0cea6a129700248896e90c4d74729d.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfdc004-01db-4f95-738f-08decad964b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|5023799004|4143699003|3023799007|18002099003|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: lhMNHRxDK1zOyV8sXNKgkFixnXFPru9ue0jYHApew9xBTakHp7GAEO2bb3tJoVS9kGu+EIB+gA8OIYtvmEqQMBiHQwjgF+cVlkUK8BDrs8D5eg8t0I6OvSq/WwhqL5BODqdmcQKY7K+gVoKB+YhaXm5JD5ctf0PBhP10Xjw9tGijFzjC3m0UvpPCwKbqunj9VWXFAZkWaNTBZAvpniZx3AqiWI/H/qZFoc0PdAkT6Lvoch5BvZ2NzZauXPeqVJelGQCSIqhREROmjmXELjh5L6v2+i4S2b2Eset66a0KVqrI7UNSo3ZuX4z8RZRlH6c7ztowqbbqOfnos+eAJuu3oF4sgt1xZaqaVVqN35WVOhzh2bKA+qEnY11clOnIkNRGtqIMsKD4zQyssKrbnNDtYM3fYjv7ZuCsKA7Kkj+AlWNz0aEu4ON+I8ScB0W9M01fJ6138/02K0+kuS/mxHeMhO40bYyL4k+KAlFModAgTqjm3VDE33LYcvlLu1xZzT5LsuS8pTcUE5SXbFfiBUt88PdCNbfs0d+e1+PUG9nqnM1xaoHgeKImd0cpKswCZrcx7s3XCXszhdaWSI4KdeDNEbK+xIH0Mfi2Sv31E+NOSx21M6h5NPFOdlr7F37meNIdbsT1Uf+xQvxPdfwZH9mkvnFQ+nUv26aPHeFnejWeBt8mK5OQaXn4eDTmcnPBR/ii
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(5023799004)(4143699003)(3023799007)(18002099003)(6133799003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: psDDPUN9PwrYYSNfFTdAoKxoEDkViEIBljnI2nsDr5vEk7c6Z1LovCRxYXMaQfpjgwSQqv4mCQNz/b23BLFzzIJDQEA+8VBp4T4ax26duz+mYPtinb/BGsx/QNANQNybZ0JwC+0H8n7+faFkyweA+M57Aa5YH0KA9YVTG8acFS2/u+29wBmCl4CDvF6LyqRV15ovUb4W6rTHhUOuzpDBIHa3oZ11Z+VfPEc8Eau/cZ0nFckM3Iv2xzwPP2pVaa53Je3omx9hU/OEHAriK6chj+Oaag6TGNfLA3wx+wvgIYK+fIymknKU7vmLy0r/sAME764Nw+p6P6ofU30ceYGnoVEgY47X7kN+vq4EUuNWBITI7gvoUOdH9O0CMe/veIrwMd9RvbU9QFrRKoTjUzXwnVdzskwiMFSXkk3BMiPPf0cYP7aRld6lhas4OLAShcgG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:26:57.8531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfdc004-01db-4f95-738f-08decad964b5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
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

On 15/06/26 16:46, Nora Schiffer wrote:
> On Mon, 2026-06-15 at 13:21 +0530, Siddharth Vadapalli wrote:
>> On 15/06/26 12:59, Nora Schiffer wrote:
>>> On Fri, 2026-06-12 at 10:03 +0530, Siddharth Vadapalli wrote:
>>>> On 11/06/26 18:34, Jai Luthra wrote:
>>>>
>>>> Hello Jai,
>>>>
>>>>> Hi Siddharth,
>>>>>
>>>>> Thank you for the patch.
>>>>>
>>>>> Quoting Siddharth Vadapalli (2026-06-11 17:36:50)
>>>>>> Currently, phy_config() is invoked every time during am65_cpsw_start()
>>>>>> which guarantees robustness and also allows recovering from link
>>>>>> failures by resetting the Ethernet PHY. While this is beneficial for
>>>>>> system stability, for use-cases where speed is prioritized over
>>>>>> robustness, the existing implementation is insufficient.
>>>>>>
>>>>>> To support use-cases prioritizing speed while continuing to retain the
>>>>>> existing behavior for robustness, sample the environment variable named
>>>>>> "am65_cpsw_phy_config_once" to determine whether phy_config() should
>>>>>> continue to be invoked once per invocation of am65_cpsw_start(), OR, it
>>>>>> should only be invoked across invocations. Since the environment variable
>>>>>> is not set by default, robustness is prioritized over speed. Use-cases
>>>>>> which require speed can set "am65_cpsw_phy_config_once" to any of:
>>>>>> '1', 'y', 'Y', 't' and 'T'
>>>>>> based on the implementation of the env_get_yesno() helper function.
>>>>>>
>>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>>> ---
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> This patch is based on commit
>>>>>> 3cdce049f90 erge tag 'u-boot-rockchip-20260610' of https://source.denx.de/u-boot/custodians/u-boot-rockchip
>>>>>> of the master branch of U-Boot.
>>>>>>
>>>>>> Patch has been tested on J784S4 EVM which uses MCU CPSW2G for Ethernet
>>>>>> functionality. The following test logs demonstrate the default behavior
>>>>>> being retained in the absence of 'am65_cpsw_phy_config_once' environment
>>>>>> variable being set to a logical true, followed by setting the environment
>>>>>> variable to a logical true ('y') and observing the PHY Autonegotiation
>>>>>> process being skipped, followed by setting the environment variable to a
>>>>>> logical false ('n' but could be anything that isn't logically true based
>>>>>> on the env_get_yesno() helper function) and verifying that we go back to
>>>>>> the default behavior of performing PHY Autonegotiation again:
>>>>>> https://gist.github.com/Siddharth-Vadapalli-at-TI/6229b5a3b7d80cd0c2037a6364406bbe
>>>>>>
>>>>>> Regards,
>>>>>> Siddharth.
>>>>>>
>>>>>>     drivers/net/ti/am65-cpsw-nuss.c | 32 +++++++++++++++++++++++++++-----
>>>>>>     1 file changed, 27 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
>>>>>> index 84a3e44ecbc..a5cca52f674 100644
>>>>>> --- a/drivers/net/ti/am65-cpsw-nuss.c
>>>>>> +++ b/drivers/net/ti/am65-cpsw-nuss.c
>>>>>> @@ -18,6 +18,7 @@
>>>>>>     #include <dm/pinctrl.h>
>>>>>>     #include <dma-uclass.h>
>>>>>>     #include <dm/of_access.h>
>>>>>> +#include <env.h>
>>>>>>     #include <miiphy.h>
>>>>>>     #include <net.h>
>>>>>>     #include <phy.h>
>>>>>> @@ -104,6 +105,7 @@ struct am65_cpsw_port {
>>>>>>            fdt_addr_t      macsl_base;
>>>>>>            bool            disabled;
>>>>>>            u32             mac_control;
>>>>>> +       bool            phy_configured;
>>>>>>     };
>>>>>>     
>>>>>>     struct am65_cpsw_common {
>>>>>> @@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *dev)
>>>>>>            struct am65_cpsw_port *port = &common->ports[priv->port_id];
>>>>>>            struct am65_cpsw_port *port0 = &common->ports[0];
>>>>>>            struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
>>>>>> -       int ret, i;
>>>>>> +       int ret, i, skip_phy_config_env;
>>>>>>     
>>>>>>            if (common->started)
>>>>>>                    return 0;
>>>>>> @@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *dev)
>>>>>>                           port->port_sgmii_base + AM65_CPSW_SGMII_CONTROL_REG);
>>>>>>            }
>>>>>>     
>>>>>> -       ret = phy_config(priv->phydev);
>>>>>> -       if (ret < 0) {
>>>>>> -               dev_err(dev, "phy_config failed: %d", ret);
>>>>>> -               goto err_dis_rx;
>>>>>> +       /*
>>>>>> +        * Invoking phy_config() every time that am65_cpsw_start() is executed will
>>>>>> +        * make the link robust. However, it delays every networking command such as
>>>>>> +        * 'dhcp' and 'tftp'. For use-cases that prioritize speed over robustness,
>>>>>> +        * phy_config() should be invoked only once. To support both use-cases,
>>>>>> +        * sample the environment variable 'am65_cpsw_phy_config_once' to switch
>>>>>> +        * between:
>>>>>> +        * a) Invoke phy_config() every time - Default behavior for robustness
>>>>>> +        * b) Invoke phy_config() once per driver probe - User configurable behavior
>>>>>> +        *    for speed.
>>>>>> +        */
>>>>>> +       skip_phy_config_env = env_get_yesno("am65_cpsw_phy_config_once");
>>>>>> +
>>>>>> +       /* If environment variable is not defined, assume it to be false. */
>>>>>> +       if (skip_phy_config_env == -1)
>>>>>> +               skip_phy_config_env = 0;
>>>>>> +
>>>>>> +       if (!port->phy_configured || !skip_phy_config_env) {
>>>>>> +               ret = phy_config(priv->phydev);
>>>>>> +               if (ret < 0) {
>>>>>> +                       dev_err(dev, "phy_config failed: %d", ret);
>>>>>> +                       goto err_dis_rx;
>>>>>> +               }
>>>>>> +               port->phy_configured = true;
>>>>>>            }
>>>>>
>>>>> Tested-by: Jai Luthra <jai.luthra@ideasonboard.com> [on BeagleY-AI]
>>>>
>>>> Thank you for testing the patch.
>>>>
>>>>>
>>>>> Although I was surprised there's no way to check the status of the phy link
>>>>> through some controller bit that can maybe mark phy as unconfigured on next
>>>>> attempt? Apologies if that's stupid, I don't understand networking =)
>>>> You do ask a good question. Maybe I should have clarified that in response
>>>> to Nora's question.
>>>>
>>>> The issue discovered during automation is that the PHY reports the Link
>>>> being UP, but doesn't send any packets out. Based on the statistics in the
>>>> MAC (Network Controller / CPSW), the packets are being sent from the MAC to
>>>> the PHY, but the PHY isn't transmitting them on the Wire. At this stage,
>>>> simply resetting the Ethernet PHY by writing to its registers using the mii
>>>> command fixes the issue. Therefore, it seems to be a rare situation wherein
>>>> the PHY ends up in a bad state and the Link Status alone isn't sufficient
>>>> to figure out whether the PHY is working. Hence, resetting the PHY on every
>>>> networking command and starting from scratch not only reduces the
>>>> occurrences of the issue, but also helps us recover from the issue by
>>>> rerunning the networking commands.
>>>
>>> It would be really good to figure out what is going on here. If the PHY can get
>>> into a state where it incorrectly reports a link, shouldn't the OS be affected
>>> as well and not just U-Boot? We don't randomly reset the PHY under Linux either
>>> after all.
>>
>> While that's true, users do have an option to restart the Auto-Negotiation
>> process via 'ethtool' command in Linux, and its equivalent isn't possible
>> without invoking a 'phy_config' in am65_cpsw_start in U-Boot. I did try
>> figuring out what might be going wrong with the PHY but wasn't able to
>> root-cause it. I don't know the internals of the PHY so I cannot comment on
>> it. In my experimentation, resetting the Ethernet PHY fixed the issue and I
>> chose to allow users to do the same so that they don't have to reset the
>> SoC for Ethernet Functionality at U-Boot in case it fails.
>>
>>>
>>> I accept that this option may be a valid stopgap measure lacking a proper
>>> solution, but it does seem to me like it allows you to choose between
>>> "unreliable" and "unusable" for some applications like the mentioned PXE boot,
>>> and neither sounds desirable...
>>
>> The terms "unreliable" and "unusable" don't seem right to me for the PXE
>> boot issue that you are referring to.
> 
> You are right, "unreliable" is not entirely accurate, at least not when the PXE
> boot is run right after a full board reset which should get the PHY into a
> working state.
> 
> I would argue that PXE boot taking up to a minute instead of a few seconds
> because it resets the PHY and reestablishes the link ~10 times could be called
> "unusable".
> 
>>
>> Invoking "phy_config" on every invocation of "am65_cpsw_start" seems to
>> cause PXE boot to fail and to address this you can set
>> "am65_cpsw_phy_config_once" to true. Eventually, if network functionality
>> fails, you only need to set "am65_cpsw_phy_config_once" to false, rerun the
>> networking command once, and set "am65_cpsw_phy_config_once" to true again,
>> thereby recovering from the issue.
>>
>> It will help if you clarify why providing the above option to users is a
>> bad idea. I am not forcing users to choose either of them at build time.
>>
>> The alternative you are proposing seems to be that of reverting an earlier
>> commit (as you have done in your vendor tree), but that causes stability
>> issues. Therefore, to address your use-case, instead of reverting the
>> commit, you can still set "am65_cpsw_phy_config_once" to true to get the
>> exact same behavior as reverting an earlier commit. Hence, I am failing to
>> understand your concern with the flexibility offered by this patch.
> 
> My main concern is that this is only a workaround, not a real solution - I'm
> neutral wrt whether this patch should be applied or not. If it is applied, we
> are likely going to set the variable in our default env in future TQ releases.

Applying this patch will allow maintaining status quo for use-cases 
depending on stable Ethernet in scenarios such as automated testing where a 
large frequency of tests are run on a daily basis. Additionally, applying 
this patch will also support use-cases concerned about speed (where 
repeated PHY negotiation shouldn't be performed).

Not having this patch seems to be a bad idea compared to having this patch 
and supporting both kinds of use-cases.

> 
> One question is why this variable and behavior should be specific to the am65
> Ethernet driver, when it looks like it is actually a PHY issue - and if it is
> made more generic, what the default behavior should be.

1. Issue is discovered on TI Boards using the DP83867 Ethernet PHY, with 
the SoC containing CPSW as the Ethernet Switch (MAC) and programmed by the 
am65-cpsw-nuss.c driver.
2. I agree that issue is because of the PHY and could potentially affect 
other boards as well with different PHYs. However, I don't have the data to 
back this claim and therefore I am implementing the fix in a limited manner 
based on what I have confirmed to be affected. If there are instances of 
similar failures on other boards with different PHYs as well, please let me 
know and I shall then identify a generic solution to address all affected 
boards.

Regards,
Siddharth.
