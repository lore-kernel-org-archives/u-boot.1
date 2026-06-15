Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1C3CD98D6
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 07:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C2A846A4;
	Mon, 15 Jun 2026 09:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s/tusK7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8E784704; Mon, 15 Jun 2026 09:48:54 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E71E83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyWHrfItuPu4ARiZlZDfaIqd7BS3C80P9l1FE4LYIkvSXXcvW8nt3figqB94gxUCtEO72gRfwSc854r1OcdVCppwppovknHBzxIYaGtzu8vhDcUuG3ZTpHx3ENGASiAAShVZlV4iscjo0jXmMbD3J0/GRM0Ye91MKbBpg8sKwjJxGMU+7t8Prc4PDJ3FcsO+5YIVhPXTMZ9kpQmboCvYz5qb4LGB5/2RM5+YRQSwdTLhK8tFvCsFsX7bB2J1CzCHZirCnv+eqE5OpypElKJEylkZhmSoX9tFtjhgHk5kHnL5DFIU775xtfbbyANvywjwVCz6yxHQRFk/aFlnq35FDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BsZwE3Cjtz8ITJR1jmoIfu0bkwPtyiCtTSsooxOtmo=;
 b=XKZYNVKEhZyAP1YBnxxRH5gyMV8PVOcSfbFe80z7iffb3epPKyrnY2HVREpsXxe8rGdFRi4LOQpqSwZwiBbgWtupwUKASqJZTPEQCclvjRVOEt/BamFwwm/QA3wmhHVe8qAUhfOZ8lQSfkoajkx2uVcEsbrrZEWu7qhlurmK3PttiJHzG5ZoMD5hhGI2YfzUjk8YwFQp55pS3EmIfOxinsQaVuiRyffDPdcj6Z8fOexrnukfXdvV9SDGS8m5yGwX5dh4UdfNvlUb4H/q+gfd3ACpQA74rFcBmsQRpQ9WRksDGcWJ2AiaWiWcqtJBYCFBSG1JX4Mr3iFcSmh5feVf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BsZwE3Cjtz8ITJR1jmoIfu0bkwPtyiCtTSsooxOtmo=;
 b=s/tusK7VyDQnHv51SBxMxk4iQMnA0b8pAnEV2QtOZi1m4ec2VBBQXBjK/gI89R+7cMLBfWJEWnQlhDgG1eXnoeLNtVV+sZ4rY4TFfEfC0y5AtEnEc4TKXAaTky2s1+YUWNbksI0SCvnrcUVcVSwZ3lqkYgyYPukARnLiYIp9J5Y=
Received: from BN9P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::29)
 by PH8PR10MB6647.namprd10.prod.outlook.com (2603:10b6:510:221::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:48:48 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::36) by BN9P220CA0024.outlook.office365.com
 (2603:10b6:408:13e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 07:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 07:48:47 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 15 Jun
 2026 02:48:46 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 15 Jun
 2026 02:48:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 15 Jun 2026 02:48:45 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65F7mgXu826502;
 Mon, 15 Jun 2026 02:48:43 -0500
Message-ID: <0d62b807-4205-4b65-bed7-d8686b5386cd@ti.com>
Date: Mon, 15 Jun 2026 13:21:41 +0530
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
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <10236b090b3e6c1ca978c4d71a9d4b15abf3e1b3.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|PH8PR10MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: c5256f8c-b061-4342-22b4-08decab28885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|56012099006|3023799007|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DRLEKaJYwpJvZtjLpMqAAQeA9UQecm0EL7VrvsnA1f5YlOpVK/tz1EgPPWbZR6yZnIcn/g8sfuugTitK3sZ9bDqiOkvvCc7GY0z/wxCCNXf3FYXwzgty9eDaYMKpSF91M3ZCFmC7sOSMUWQYw/VysRJ5iBGwf+P7vdwq+Qsb1Pb0AtXdJG8O5XyRddorBynifDdPAav4KUNrBsJb3MCRTFeS729HU85XD2Yg4STvjNGCTBoSq3AfAwK7U+QAKVatxhtzH4J6vv7EPaN8JdgqBCp5XjZQ3tVu9Fg2IJ0TsRccqFACxuOENfFFTZarT1aTWKf9PY71WrRTN+jBn8Whq3U74xp6GR8ZrLa4evHgJetVvxv17VpUEemRKGWikV6pyG1cOh1pLTTXdrUivvpWc+JWDEZgRD8LPfcFmS4H3Vh9u39sQKn4L9VIJ+1XXlL5OjjN8bnMWG6q/uQIPSuFKNYwafpRCEY6W24sOyhnSmpZ9+txdWlYen7bykCIClz/I2BNXWmjVQIsOgukfvYbM7PNAV1dD+T332nO40G9DGiVanDFCTFYYMyqmHzVI1oAe5TVl5d7/uyaoscRRfm5N8cqGWppPK7kFQ9kRyrBYuew3pvZZiFXm56UQFmAUiqSh+20DOt6qoND1UNrA3K8oqb/BZfscu5yZMPDt+NfiQ9/09OITfbtoVCvEuVY9pv6
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(56012099006)(3023799007)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8UpcM+eSOzFsp4LQDKRL3S+nKObb4UQehSXmWKx1ErNh3AyV5hh/TC1kEvQWgWM+6HxI45B19cv0esDcmoNWxVuyjC9zauHfDv359fqVl6J7tofzRCsyqQXzpTBrsEgPAeUyQ7U4XbL8f69YWA1Xn8qRgqMpGpPDfkv2WuUaGPZHsVP+p4HHP9ST7yJw+HrXjU6RItKWHvnsIWvUnRJd78vhJDWS8wEjQs5uEzYN9slErWEhHBJDlkeYOu5K0w7jjUXe/kmHRqTni4YN3e1JvrTAd6qrfRAuoyKfSH+u8rZ2yPHnOUUuZuAzI5cMBpw6WKR6ebbG8txx+pZ+EWQ4+dmWt+Eay7CQhL5EXdnn1hraZooPiWMPThBIWqtC6V4KoDOl8l3smN5khf/UvswwR7dP6oSA2pR3Tl/Vh61tnv1UutzBAYQAZ5ftOENgsUn2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:48:47.5391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5256f8c-b061-4342-22b4-08decab28885
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6647
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

On 15/06/26 12:59, Nora Schiffer wrote:
> On Fri, 2026-06-12 at 10:03 +0530, Siddharth Vadapalli wrote:
>> On 11/06/26 18:34, Jai Luthra wrote:
>>
>> Hello Jai,
>>
>>> Hi Siddharth,
>>>
>>> Thank you for the patch.
>>>
>>> Quoting Siddharth Vadapalli (2026-06-11 17:36:50)
>>>> Currently, phy_config() is invoked every time during am65_cpsw_start()
>>>> which guarantees robustness and also allows recovering from link
>>>> failures by resetting the Ethernet PHY. While this is beneficial for
>>>> system stability, for use-cases where speed is prioritized over
>>>> robustness, the existing implementation is insufficient.
>>>>
>>>> To support use-cases prioritizing speed while continuing to retain the
>>>> existing behavior for robustness, sample the environment variable named
>>>> "am65_cpsw_phy_config_once" to determine whether phy_config() should
>>>> continue to be invoked once per invocation of am65_cpsw_start(), OR, it
>>>> should only be invoked across invocations. Since the environment variable
>>>> is not set by default, robustness is prioritized over speed. Use-cases
>>>> which require speed can set "am65_cpsw_phy_config_once" to any of:
>>>> '1', 'y', 'Y', 't' and 'T'
>>>> based on the implementation of the env_get_yesno() helper function.
>>>>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
>>>>
>>>> Hello,
>>>>
>>>> This patch is based on commit
>>>> 3cdce049f90 erge tag 'u-boot-rockchip-20260610' of https://source.denx.de/u-boot/custodians/u-boot-rockchip
>>>> of the master branch of U-Boot.
>>>>
>>>> Patch has been tested on J784S4 EVM which uses MCU CPSW2G for Ethernet
>>>> functionality. The following test logs demonstrate the default behavior
>>>> being retained in the absence of 'am65_cpsw_phy_config_once' environment
>>>> variable being set to a logical true, followed by setting the environment
>>>> variable to a logical true ('y') and observing the PHY Autonegotiation
>>>> process being skipped, followed by setting the environment variable to a
>>>> logical false ('n' but could be anything that isn't logically true based
>>>> on the env_get_yesno() helper function) and verifying that we go back to
>>>> the default behavior of performing PHY Autonegotiation again:
>>>> https://gist.github.com/Siddharth-Vadapalli-at-TI/6229b5a3b7d80cd0c2037a6364406bbe
>>>>
>>>> Regards,
>>>> Siddharth.
>>>>
>>>>    drivers/net/ti/am65-cpsw-nuss.c | 32 +++++++++++++++++++++++++++-----
>>>>    1 file changed, 27 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
>>>> index 84a3e44ecbc..a5cca52f674 100644
>>>> --- a/drivers/net/ti/am65-cpsw-nuss.c
>>>> +++ b/drivers/net/ti/am65-cpsw-nuss.c
>>>> @@ -18,6 +18,7 @@
>>>>    #include <dm/pinctrl.h>
>>>>    #include <dma-uclass.h>
>>>>    #include <dm/of_access.h>
>>>> +#include <env.h>
>>>>    #include <miiphy.h>
>>>>    #include <net.h>
>>>>    #include <phy.h>
>>>> @@ -104,6 +105,7 @@ struct am65_cpsw_port {
>>>>           fdt_addr_t      macsl_base;
>>>>           bool            disabled;
>>>>           u32             mac_control;
>>>> +       bool            phy_configured;
>>>>    };
>>>>    
>>>>    struct am65_cpsw_common {
>>>> @@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *dev)
>>>>           struct am65_cpsw_port *port = &common->ports[priv->port_id];
>>>>           struct am65_cpsw_port *port0 = &common->ports[0];
>>>>           struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
>>>> -       int ret, i;
>>>> +       int ret, i, skip_phy_config_env;
>>>>    
>>>>           if (common->started)
>>>>                   return 0;
>>>> @@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *dev)
>>>>                          port->port_sgmii_base + AM65_CPSW_SGMII_CONTROL_REG);
>>>>           }
>>>>    
>>>> -       ret = phy_config(priv->phydev);
>>>> -       if (ret < 0) {
>>>> -               dev_err(dev, "phy_config failed: %d", ret);
>>>> -               goto err_dis_rx;
>>>> +       /*
>>>> +        * Invoking phy_config() every time that am65_cpsw_start() is executed will
>>>> +        * make the link robust. However, it delays every networking command such as
>>>> +        * 'dhcp' and 'tftp'. For use-cases that prioritize speed over robustness,
>>>> +        * phy_config() should be invoked only once. To support both use-cases,
>>>> +        * sample the environment variable 'am65_cpsw_phy_config_once' to switch
>>>> +        * between:
>>>> +        * a) Invoke phy_config() every time - Default behavior for robustness
>>>> +        * b) Invoke phy_config() once per driver probe - User configurable behavior
>>>> +        *    for speed.
>>>> +        */
>>>> +       skip_phy_config_env = env_get_yesno("am65_cpsw_phy_config_once");
>>>> +
>>>> +       /* If environment variable is not defined, assume it to be false. */
>>>> +       if (skip_phy_config_env == -1)
>>>> +               skip_phy_config_env = 0;
>>>> +
>>>> +       if (!port->phy_configured || !skip_phy_config_env) {
>>>> +               ret = phy_config(priv->phydev);
>>>> +               if (ret < 0) {
>>>> +                       dev_err(dev, "phy_config failed: %d", ret);
>>>> +                       goto err_dis_rx;
>>>> +               }
>>>> +               port->phy_configured = true;
>>>>           }
>>>
>>> Tested-by: Jai Luthra <jai.luthra@ideasonboard.com> [on BeagleY-AI]
>>
>> Thank you for testing the patch.
>>
>>>
>>> Although I was surprised there's no way to check the status of the phy link
>>> through some controller bit that can maybe mark phy as unconfigured on next
>>> attempt? Apologies if that's stupid, I don't understand networking =)
>> You do ask a good question. Maybe I should have clarified that in response
>> to Nora's question.
>>
>> The issue discovered during automation is that the PHY reports the Link
>> being UP, but doesn't send any packets out. Based on the statistics in the
>> MAC (Network Controller / CPSW), the packets are being sent from the MAC to
>> the PHY, but the PHY isn't transmitting them on the Wire. At this stage,
>> simply resetting the Ethernet PHY by writing to its registers using the mii
>> command fixes the issue. Therefore, it seems to be a rare situation wherein
>> the PHY ends up in a bad state and the Link Status alone isn't sufficient
>> to figure out whether the PHY is working. Hence, resetting the PHY on every
>> networking command and starting from scratch not only reduces the
>> occurrences of the issue, but also helps us recover from the issue by
>> rerunning the networking commands.
> 
> It would be really good to figure out what is going on here. If the PHY can get
> into a state where it incorrectly reports a link, shouldn't the OS be affected
> as well and not just U-Boot? We don't randomly reset the PHY under Linux either
> after all.

While that's true, users do have an option to restart the Auto-Negotiation 
process via 'ethtool' command in Linux, and its equivalent isn't possible 
without invoking a 'phy_config' in am65_cpsw_start in U-Boot. I did try 
figuring out what might be going wrong with the PHY but wasn't able to 
root-cause it. I don't know the internals of the PHY so I cannot comment on 
it. In my experimentation, resetting the Ethernet PHY fixed the issue and I 
chose to allow users to do the same so that they don't have to reset the 
SoC for Ethernet Functionality at U-Boot in case it fails.

> 
> I accept that this option may be a valid stopgap measure lacking a proper
> solution, but it does seem to me like it allows you to choose between
> "unreliable" and "unusable" for some applications like the mentioned PXE boot,
> and neither sounds desirable...

The terms "unreliable" and "unusable" don't seem right to me for the PXE 
boot issue that you are referring to.

Invoking "phy_config" on every invocation of "am65_cpsw_start" seems to 
cause PXE boot to fail and to address this you can set 
"am65_cpsw_phy_config_once" to true. Eventually, if network functionality 
fails, you only need to set "am65_cpsw_phy_config_once" to false, rerun the 
networking command once, and set "am65_cpsw_phy_config_once" to true again, 
thereby recovering from the issue.

It will help if you clarify why providing the above option to users is a 
bad idea. I am not forcing users to choose either of them at build time.

The alternative you are proposing seems to be that of reverting an earlier 
commit (as you have done in your vendor tree), but that causes stability 
issues. Therefore, to address your use-case, instead of reverting the 
commit, you can still set "am65_cpsw_phy_config_once" to true to get the 
exact same behavior as reverting an earlier commit. Hence, I am failing to 
understand your concern with the flexibility offered by this patch.

Kindly let me know.

Regards,
Siddharth.
