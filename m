Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D461DCD98CC
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 04:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2328056B;
	Fri, 12 Jun 2026 06:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ENHFI/Pg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A7183FF5; Fri, 12 Jun 2026 06:31:09 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34EEE8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 06:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyy08ZcX8c2xrokXdPtQjtkBdtcUqrwUPAIVPdCeuUFa9c+ZbtiT0nnHTgasU181IMPWPZDQm8BetRWn9LFW2U8nxadKDSqltPL467iIdN6LM3+GLq8LsEiXxuMfH3sP6HCu9a25Vs8wKtVnFmDlPhwsU2TvNVChdnN1chcI0X7dOcybeoBIbIfAWqQeGi7DARvaL3dWjM5O2CAQETkXmcH/7AMq2PRVqARumL16+096zFUD2jZUhffoWDsLzZw1rAFoA7V33QR4PJ7jKZjULU7Op7gLLCSUVVt3WL7qwiL3WwIxRU8XGSHCEf9/Z/1aOzCs5YX5PjdXUwahtu+bHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVAfr3XYMl++1DplzyH+Nf8aE48+oBfiUqG6ziV07K8=;
 b=Yo0zUli6PB5mbd973nhc/8w5/pr01qp0nKKmNhgJ4Ab1KC3HwpYk9DwSZb8SvUw2R3GwHTaFELSJXb44WR31MfhgY+KbWP2h/U5AwQOJmWGQg5AKM0kNijvjFrSwl+RC/2R0/HnoQsWYWEnNy5ir5mcFTWJbcYjDAO/nVH38L2RrTaqzHYgMR5U/a6Eo+LZnttHs4MSFD9noXvL4amI0YfMj2NwpWBRPHqtfBC9A8tZ7oVtDLa//wgVd/E+J+um9McJoMViXFxbMURzzxNsRbeZBXSREwe8KWsUiCBZm5Xs1grPw/9ajqqh/oZtkjxcFl4G0lD6gDaVoebMLihxc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVAfr3XYMl++1DplzyH+Nf8aE48+oBfiUqG6ziV07K8=;
 b=ENHFI/PgniW1rBqYLHkBrm+4CiIKcNpdbJyW8w9Gwn9vWc2nqB8zSlQd3SmMkndK2OhIVc5QPd1ruw2ffTW/SDnRG3rIdD2Ako7nBGst9k9HKcksZXMqUtFdr3xyCmFIZo6+ufaBSrCP37NYz/LQ7eAB64x6wOU5K45UHgJDF8w=
Received: from CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::9)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 04:31:02 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::2f) by CH5P220CA0015.outlook.office365.com
 (2603:10b6:610:1ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 04:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 04:31:01 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 23:31:01 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 23:31:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 23:31:01 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65C4UwGj2726598;
 Thu, 11 Jun 2026 23:30:58 -0500
Message-ID: <18490eb5-3ab5-4e78-a723-553983c9ed17@ti.com>
Date: Fri, 12 Jun 2026 10:03:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <andrew.goodbody@linaro.org>, <c-vankar@ti.com>,
 <jerome.forissier@arm.com>, <matthias.schiffer@ew.tq-group.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <nm@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config() for
 speed
To: Jai Luthra <jai.luthra@ideasonboard.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
 <178118305958.1799417.3241467311184856154@freya>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <178118305958.1799417.3241467311184856154@freya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|BLAPR10MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a94c272-598a-4d78-420a-08dec83b68d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|6133799003|3023799007|18002099003|22082099003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: ww2T1p5E1vg2c7/I+kF22R0jOKC00ZvBTAHcHxpeySJXdcy4AepTacBvXuS5Xn5JPlgbvFLpTlBkRJzgZ/NthfqiNeVTAOdtAwEWFsno1EJrkLng+PiVmzwvS3oVoDV4O690yohKuZZb2rf20VLC37vMfgCDKzNN9SBmk3eDlAHF1wTgWTPVvy9ZX/c4+oYorbBUEb5mmaAgSacf8VfPwIZOwbZ3dicoKsW0PU8pSii5zU/smIjFYDfAK1twT/VEGSTSB3n62j5fjqspwijo+dPSUI1lYtqxpoVUtbKPYI2R6k1rtaOXFkUigM+9yPP48HTLjqe7IbuKt3EfWa6hVdaPj2cBL9kqI4ZXi4VrKrHvNCk0j8RCBbmhbfaAGvFp34vzifdQ0QcuyjdJ8YgsAid92nZM1hgwha8fIEa5PuPtVFefEDgPhZTFV0kP8yOLPYJrzEcpSiMPuJ/lbmYVOBxOC+uASTesZ9NfZSKjyujFssXmGnNBo1+gXKAyyLSl921LTXhe/+G1YXxYEP4195bhMC7OI7kDQHeLGWdFbdsADhFfrqafi+zxHFe0dm5dzTb+HeexhXSlCFoS0aRrcJE0jxIDw53z4WccvAEOmcQFIHhONH9Vhb+jrkZF5q6vVTBXz4gK+0qNTEAyTqT5NCdbsBk+5B7ALPNitz/rY/Gx1+gM/Bfa1bx+LR9czYUZ
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HQnzn09+/+g2ftRcnYwOdnq078q3u3hLhRS1f0FWu/aqrLZ0xYMbxvyxWfrdIrSrbiBdAn2dVpgQK6VzWoV0HbPaQ4YFsAXSl2r0AYoVKta2lMEZDE3nBX9Mr08C3MdtyG/sFRLCZsRs6I5YlUf8bLoTSAFC1bEGPD8XIezYjkigWPyfu1djnoODbirjVclQxb0CWaBJbYIU6dcoFz6ucnc7J17WQujTVzV3IYsxNJO1NKNRRkbblPrvXPCTaIXGklDEO2ep7Uf/Sod3NkXmdNBD0VnT2I6y7di3Oe9Uccy4FLbDHWyWbQ96708lKWL1BmO6rDuNhbD/d6WZVfxrsDvaKG7lo9zV732+MReYOrGbgY5rWWEOawcqtlEHydiWm4EEYLfEs3slSlMA2JP9UbvUKNuO8l5573i1NhFwVHuK3KKyKORArTD/6r16E3Iq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 04:31:01.9318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a94c272-598a-4d78-420a-08dec83b68d0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
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

On 11/06/26 18:34, Jai Luthra wrote:

Hello Jai,

> Hi Siddharth,
> 
> Thank you for the patch.
> 
> Quoting Siddharth Vadapalli (2026-06-11 17:36:50)
>> Currently, phy_config() is invoked every time during am65_cpsw_start()
>> which guarantees robustness and also allows recovering from link
>> failures by resetting the Ethernet PHY. While this is beneficial for
>> system stability, for use-cases where speed is prioritized over
>> robustness, the existing implementation is insufficient.
>>
>> To support use-cases prioritizing speed while continuing to retain the
>> existing behavior for robustness, sample the environment variable named
>> "am65_cpsw_phy_config_once" to determine whether phy_config() should
>> continue to be invoked once per invocation of am65_cpsw_start(), OR, it
>> should only be invoked across invocations. Since the environment variable
>> is not set by default, robustness is prioritized over speed. Use-cases
>> which require speed can set "am65_cpsw_phy_config_once" to any of:
>> '1', 'y', 'Y', 't' and 'T'
>> based on the implementation of the env_get_yesno() helper function.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> Hello,
>>
>> This patch is based on commit
>> 3cdce049f90 erge tag 'u-boot-rockchip-20260610' of https://source.denx.de/u-boot/custodians/u-boot-rockchip
>> of the master branch of U-Boot.
>>
>> Patch has been tested on J784S4 EVM which uses MCU CPSW2G for Ethernet
>> functionality. The following test logs demonstrate the default behavior
>> being retained in the absence of 'am65_cpsw_phy_config_once' environment
>> variable being set to a logical true, followed by setting the environment
>> variable to a logical true ('y') and observing the PHY Autonegotiation
>> process being skipped, followed by setting the environment variable to a
>> logical false ('n' but could be anything that isn't logically true based
>> on the env_get_yesno() helper function) and verifying that we go back to
>> the default behavior of performing PHY Autonegotiation again:
>> https://gist.github.com/Siddharth-Vadapalli-at-TI/6229b5a3b7d80cd0c2037a6364406bbe
>>
>> Regards,
>> Siddharth.
>>
>>   drivers/net/ti/am65-cpsw-nuss.c | 32 +++++++++++++++++++++++++++-----
>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
>> index 84a3e44ecbc..a5cca52f674 100644
>> --- a/drivers/net/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ti/am65-cpsw-nuss.c
>> @@ -18,6 +18,7 @@
>>   #include <dm/pinctrl.h>
>>   #include <dma-uclass.h>
>>   #include <dm/of_access.h>
>> +#include <env.h>
>>   #include <miiphy.h>
>>   #include <net.h>
>>   #include <phy.h>
>> @@ -104,6 +105,7 @@ struct am65_cpsw_port {
>>          fdt_addr_t      macsl_base;
>>          bool            disabled;
>>          u32             mac_control;
>> +       bool            phy_configured;
>>   };
>>   
>>   struct am65_cpsw_common {
>> @@ -313,7 +315,7 @@ static int am65_cpsw_start(struct udevice *dev)
>>          struct am65_cpsw_port *port = &common->ports[priv->port_id];
>>          struct am65_cpsw_port *port0 = &common->ports[0];
>>          struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
>> -       int ret, i;
>> +       int ret, i, skip_phy_config_env;
>>   
>>          if (common->started)
>>                  return 0;
>> @@ -426,10 +428,30 @@ static int am65_cpsw_start(struct udevice *dev)
>>                         port->port_sgmii_base + AM65_CPSW_SGMII_CONTROL_REG);
>>          }
>>   
>> -       ret = phy_config(priv->phydev);
>> -       if (ret < 0) {
>> -               dev_err(dev, "phy_config failed: %d", ret);
>> -               goto err_dis_rx;
>> +       /*
>> +        * Invoking phy_config() every time that am65_cpsw_start() is executed will
>> +        * make the link robust. However, it delays every networking command such as
>> +        * 'dhcp' and 'tftp'. For use-cases that prioritize speed over robustness,
>> +        * phy_config() should be invoked only once. To support both use-cases,
>> +        * sample the environment variable 'am65_cpsw_phy_config_once' to switch
>> +        * between:
>> +        * a) Invoke phy_config() every time - Default behavior for robustness
>> +        * b) Invoke phy_config() once per driver probe - User configurable behavior
>> +        *    for speed.
>> +        */
>> +       skip_phy_config_env = env_get_yesno("am65_cpsw_phy_config_once");
>> +
>> +       /* If environment variable is not defined, assume it to be false. */
>> +       if (skip_phy_config_env == -1)
>> +               skip_phy_config_env = 0;
>> +
>> +       if (!port->phy_configured || !skip_phy_config_env) {
>> +               ret = phy_config(priv->phydev);
>> +               if (ret < 0) {
>> +                       dev_err(dev, "phy_config failed: %d", ret);
>> +                       goto err_dis_rx;
>> +               }
>> +               port->phy_configured = true;
>>          }
> 
> Tested-by: Jai Luthra <jai.luthra@ideasonboard.com> [on BeagleY-AI]

Thank you for testing the patch.

> 
> Although I was surprised there's no way to check the status of the phy link
> through some controller bit that can maybe mark phy as unconfigured on next
> attempt? Apologies if that's stupid, I don't understand networking =)
You do ask a good question. Maybe I should have clarified that in response 
to Nora's question.

The issue discovered during automation is that the PHY reports the Link 
being UP, but doesn't send any packets out. Based on the statistics in the 
MAC (Network Controller / CPSW), the packets are being sent from the MAC to 
the PHY, but the PHY isn't transmitting them on the Wire. At this stage, 
simply resetting the Ethernet PHY by writing to its registers using the mii 
command fixes the issue. Therefore, it seems to be a rare situation wherein 
the PHY ends up in a bad state and the Link Status alone isn't sufficient 
to figure out whether the PHY is working. Hence, resetting the PHY on every 
networking command and starting from scratch not only reduces the 
occurrences of the issue, but also helps us recover from the issue by 
rerunning the networking commands.

Since certain users may prefer speed over stability, or alternatively, 
since users may prefer speed by default with the option to recover on the 
same boot in case they end up in such a situation, using an environment 
variable seemed to be the most flexible approach (build-time configs will 
only provide speed or stability but won't allow the user to switch between 
them at runtime).

I hope this clarifies your question. Let me know otherwise.

Regards,
Siddharth.
