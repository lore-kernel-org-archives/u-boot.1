Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29903C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 917B086961;
	Fri, 25 Aug 2023 09:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJVmDusO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAE1852DB; Fri, 25 Aug 2023 09:15:25 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 178BE869E1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJzqLFbksvr6tsKCwH/s0T03TNeMwWS5uuUitzGtF5HBfnArtZdwxbruDVBIiqD0bsjUwo21bEjSFCb9xX9v7expOXz7Mmi2/zlfe1jC+I0ACmWBtEXXqOGHrYkEK7rQqaElkbvRWbBMIifrBic1iLTyiIeZY+K8rYLLkLfkSLIZh+ZfAqBLxmmyqG3mIvqjO3UN51SBAp7MX6WNDOXezg/IByYbE0UT6fALEiwIr2d457BYR+6/Cj5F8VTosb0VgGEcDeTqjgHxGqaDTwAzrkQvKUanOhXBCgN6zV9Fxq0CRWgxYmSC2PxALHgRl9BqO8iz+PZXfgky8KzW2yGiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gj5LvUXR6Nu8Xex+FcrtHFg20g927Mvgk93Wk1XpD8A=;
 b=HUOOZ/+uk+nSd2XShgwqnZhvgQ7fEGRQtTVz3weO39lwMsIqyTCQoXLxfxW2pNlKumbwa3H/oRwfBmIV2lr09Jg7HG1UXWHMqoo/5Tqp20uG6JurfdR2oU8sC3eEilo+Z2HOSkXTD+nS/4+f2LTr/tAbOZyce/TNVQpLF644V45vkvRlAozKAx/rC0zSyUPWtLnb6XZGdgQU8WNtKn65bA1a/od7t1EBORoHNI122VRra7gEpVl57mWxeYsagbfDTv2Ok+yGtMsBc0vVlybuxg2eI5WRSY8ijR8M2fa2xs8NnScetzZQykYuu3g6GkOabIG0xEemYWW4Dr3iAlNcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gj5LvUXR6Nu8Xex+FcrtHFg20g927Mvgk93Wk1XpD8A=;
 b=NJVmDusOflTY7WQEVlx2vS6EM1yAU3GRibYiKQ/yeu1yaUf9a46r4NQGYKI/kCrJuir+7I1LPGVrVc9xZQuIcoIPLCwwarO56dbtmozhqkBsmIz+LpbIlWM5xBytJQg+WDPRyHnqwDg61U3jYI+zgjnTpbOLd1rcqTypxagMZf0=
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:15:19 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::b4) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Fri, 25 Aug 2023 07:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 07:15:18 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:15:10 -0500
Message-ID: <32e261a0-f4eb-04f4-f31a-33414a292146@amd.com>
Date: Fri, 25 Aug 2023 09:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] clk: Dont return error when assigned-clocks is empty or
 missing
Content-Language: en-US
To: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, <u-boot@lists.denx.de>, "Tom
 Rini" <trini@konsulko.com>
CC: <lukma@denx.de>, <seanga2@gmail.com>, <git@amd.com>
References: <20230711095128.19086-1-ashok.reddy.soma@amd.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230711095128.19086-1-ashok.reddy.soma@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd297d6-a6af-41c1-4006-08dba53b0963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riuUWBjLoYbElEptfH35zBAdyE4P0lbdd+GucchQbSkQhEtxv+Uy0glraWBtvDK45smdPrUt6Be9ShtCWEv2UOue5hMNFHjXA9dRFhlRv0rpXgLca2Vq1Pda6TBlKlfwd5BKy0sBZgfoz3nNJFQKWtSFN3m8glaluZDSNv2v76k4+XaGnxnh16zpyP1omjQFlQBU8FFCPj1IpQRpKZ/72Gfj0MIRCbvZeRky+5H6xSx8WR+kTOX1PB7Pc3mih/eAEE7DVZLQo9/zGGwiLRQU5Ex2c6VKXRuXJR/ooVWyyTE8s0LFDL/4Sw44Oi8y8b9n0Kn2a1ncWfqAw+oBmxoOlgAuFQhhVLwlZm/DbZL9YcrbkUbuvxutKhFlLc5TMTwbgyZ46LRlPYRjkk1HQR43WRaB0NlR/02df+t5+G5jad8UAuwqIpVSXwiBdYLkYFOPZ7431DLPdmoyAQobETCFiAYlUmZJlj7Djd4wvMq0XkTetTpE4SG0WKy0T1Je4MTGyR3vHR7LoxfSO6fhf8rCMKJUmmrC7MOTaf2z987WrR6SdigyOdSYCS5JsawHmTaCb5YKWUg5AxLjlb6KY/lc2cL6EDJD7oGPIzkwXBR/fxZAeh2BrCTvFdSn0mF0PjFTAICi5iPxoVh7p1VFZ2qwkIciAjStmorO3ws6VK9av5RZpJKWID4Nz1jJlPT48Yu+ocDP+JqMZbz3LvqH5U8tZZTz1kRzpPYOGGYgLo1w2n6PefXtmavGqgj8T+psA4rym0VjKRe3FKJGKBhsOBelskB0q/NZor4t9HAEyNGPfAe6Hqexb2tXlXtMncj9qaz6Sa2SQPpiW3jPHhOIPEvXKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(2616005)(36860700001)(336012)(426003)(83380400001)(26005)(53546011)(47076005)(41300700001)(16526019)(2906002)(316002)(70586007)(54906003)(16576012)(5660300002)(44832011)(4326008)(70206006)(8936002)(110136005)(8676002)(478600001)(40480700001)(81166007)(31696002)(86362001)(356005)(82740400003)(36756003)(31686004)(192303002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:15:18.1116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd297d6-a6af-41c1-4006-08dba53b0963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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

Hi Tom,

On 7/11/23 11:51, Ashok Reddy Soma wrote:
> There is a chance that assigned-clock-rates is given and assigned-clocks
> could be empty. Dont return error in that case, because the probe of the
> corresponding driver will not be called at all if this fails.
> Better to continue to look for it and return 0.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> ---
> 
>   drivers/clk/clk-uclass.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index dc3e9d6a26..f186fcbcdb 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -329,7 +329,13 @@ static int clk_set_default_rates(struct udevice *dev,
>   			dev_dbg(dev,
>   				"could not get assigned clock %d (err = %d)\n",
>   				index, ret);
> -			continue;
> +			/* Skip if it is empty */
> +			if (ret == -ENOENT) {
> +				ret = 0;
> +				continue;
> +			}
> +
> +			return ret;
>   		}
>   
>   		/* This is clk provider device trying to program itself

What's your take on this one?  I didn't get reply from Sean.

Thanks,
Michal
