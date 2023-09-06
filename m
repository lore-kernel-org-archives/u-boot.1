Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565BDEE14A3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 14:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AFB86907;
	Wed,  6 Sep 2023 16:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="olxlf1UK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD1386963; Wed,  6 Sep 2023 16:57:05 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24251865A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 16:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9MULMpC+spBdP4Icfed0qGysqODBquFJ6Y6XuMLIkQx3+CVva10fZqoBnBalhg79MfeFFhM5I/G+v330ncbO6fvWksfp6OK1+xt7i6Zns/RSSos9deGzkmZQMssuG3NR9ahlz+yzObvcm/Qd4OkE2w6185q2fb0VV2SCaVPnzYDMqLxeSeu4XwwGwdQ2wdWQYzVZ6MgRKNmaB6HKm9hdvHeprFGsI/g8DPvYOi1h0WqcAZXBwpcwf0hEMUaWe1kmLkGFpR3WHLoo8GSmUJJPTLTw9a/5e2Ej4vVV3PDqYgcQc2xQXmEOOGSZ5fFDNdVug3OelARmhJFpsKterghPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtnjznhiywSrKrT6cA7KMkZu6ZWoDX9V/qLXtiQSReM=;
 b=OI9a6PSCp0W8jDoUA2FVd95G0AWA9u4CcVazKnmdvHR07qMlhV7RI/BgjkKPNDEB9u+3dRCT6w7GWYvkloKy7aNp2UEjbk4AqWw+3K+whwZbOw5wuvdjhd+YNa69m47F+3pMRDOrVlfB8ldkSL6W9Ik+4ytuDCbCvIIeKUCL+6R2TaUeJuL7yKeY2AFlnuvqWsUspQ3i47jNJQeeAMBdCc+NebQLxrmBUpHr2drCB7uuMizKXOwdH5zXH16zUqFdZBaqsyL1SVLRNRF2obbfkMr03cJxwNGSu32TySG62dQMSrSs3+Mx9DxlR91vx08ipOvvquihB7n8ByBh7xF3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtnjznhiywSrKrT6cA7KMkZu6ZWoDX9V/qLXtiQSReM=;
 b=olxlf1UKgGMJEeovioH93AdOzTYd97sSOOKRqmzqc5OCFtH2HsjyF3Xn5GQjqFiTKtRwIPBicnVgAgTvCLEsTEy1xNB/8VMJWdPmbFBxSHbFNtFWbYTwNvped3ygCooEq/wHkreQ3ELl6nw38WVa8iz6vVczqHluQcHxBo0/T6w=
Received: from DM6PR04CA0023.namprd04.prod.outlook.com (2603:10b6:5:334::28)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:56:59 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::88) by DM6PR04CA0023.outlook.office365.com
 (2603:10b6:5:334::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 14:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 14:56:59 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 09:56:58 -0500
Message-ID: <523ca6eb-3737-d090-8006-f127eda2330b@amd.com>
Date: Wed, 6 Sep 2023 16:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC 4/6] gpio: add scmi driver based on pinctrl
Content-Language: en-US
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, <u-boot@lists.denx.de>
CC: <etienne.carriere@st.com>, <sjg@chromium.org>, <linus.walleij@linaro.org>, 
 <Oleksii_Moisieiev@epam.com>
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-5-takahiro.akashi@linaro.org>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230906024011.17488-5-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 197ce816-8536-4f84-5658-08dbaee985b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gHV88P//f6DzOyeWxLpuE0Tip8NKbwwerSQ2WhTK4pWsVez7I3/RgwMSzXTLZMPTpEsWyC+GpSemGgRQoS6dFLP5bnTabravX1nblBceA/4Qn4NWOX14lGnO9megTHJJYiLxcS5YcV+xdy6gjAQODCbda3iyBPNEdOP08MG6/Ct6l6f8fNU6OMDEtZ+eufZ0lRGgTJObPen5J2BNVCpTFkwbRA55kFhlSivJbEFJ2jMxqHYSe20o9dc1b5OfgmCwko3HB4cIa0U8bDiJHjJGKIDnJpCvAfRLrCmLIRHp4+Oe9Chnr7K2tV8NbFyUI5k7TbWFnZZxfAaxCJHTyZRLqy7rLivlQYy/1DTnwreL4G6TiwoFiDTbtj58o+vZMoirn/cn6vYBfaplkzWOy43Ac1ZZpTlzkHJp/pnuo9i6hc3/z86TGojWpdqpmB6z/jfOqLpGHhCTsMItDqLqH0YYUqjjHoJns/mYbsmS38/gdJs72Vmhm9oVYLjn4cYnCJkcwVGhPsfjCxUbVblqjxOko8IlowL6hOL1dY0eRQiJ9y8ZI1bAj9S9jzWByETzceut0HvceTp6JDbAEJBdc1anQWmxOKOQcX1hzyYw4lQVOO7hGuDe2CceI9251NO/mJtdekfGPU6wTM8oFDkkkT7AmDPnUWIy4WI13BcQsjrcqipkWPvB+wOtLD7k50kXRqgkVf4RWWvcJ8sOMO7aEgttzXB3ld/nEcBNq2Pcdsqpn0Lgu2vqn0P4S/w04BWaRAglUs3KUVEGghGlL7q9++6H0grNn0j93KQzBXwvE6+/MU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(53546011)(478600001)(83380400001)(2616005)(426003)(336012)(16526019)(2906002)(26005)(316002)(16576012)(44832011)(54906003)(70206006)(70586007)(41300700001)(110136005)(5660300002)(4326008)(8936002)(8676002)(40460700003)(82740400003)(40480700001)(47076005)(36860700001)(31696002)(36756003)(86362001)(356005)(81166007)(31686004)(66899024)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:56:59.6339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197ce816-8536-4f84-5658-08dbaee985b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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



On 9/6/23 04:40, AKASHI Takahiro wrote:
> This DM-compliant driver deals with SCMI pinctrl protocol and presents
> gpio devices exposed by SCMI firmware (server).
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   drivers/pinctrl/pinctrl-scmi.c | 544 ++++++++++++++++++++++++++++++++-
>   1 file changed, 539 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> index 3ebdad57b86c..73d385bdbfcc 100644
> --- a/drivers/pinctrl/pinctrl-scmi.c
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -11,21 +11,20 @@
>   #include <malloc.h>
>   #include <scmi_agent.h>
>   #include <scmi_protocols.h>
> +#include <asm-generic/gpio.h>
>   #include <dm/device_compat.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
>   #include <dm/pinctrl.h>
>   
>   /**
>    * struct scmi_pin - attributes for a pin
>    * @name:	Name of pin
> - * @value:	Value of pin
> - * @flags:	A set of flags
>    * @function:	Function selected
>    * @status:	An array of status of configuration types
>    */
>   struct scmi_pin {
>   	char		*name;
> -	u32		value;
> -	u32		flags;


You have added this in 3/6 then there is no reason to remove it in this version.

M
