Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8F8CD8CA2
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 15:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7DA86BF2;
	Tue, 10 Oct 2023 17:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="thmQGx8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CDFF86B1D; Tue, 10 Oct 2023 17:07:29 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA30A86BF2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 17:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCQmIlPOJVlphhWCOlkoJkl47rg1e+9qkTYmvU732NVLwp9a2Ls0VGZRf/mi0l8r7o6IEey2foMNWnHA775d60ULwtRxNUb1HAjnyU/T1Aqyk6U/l8gENeTrP/B732K30TQdQlOGEuuDywcb0N33tOxeYk7VUCmLtfay756q9cHFq/XskSuQpbVa8I9K/xBRSPa3Uw97jxPy1Xm2C6WFGi+5faCYH/+rfj0kg+PZTKwvJIAxJy0DVgxTTIh6RHzs0lwixfDxZfxqRQML0ij4iNwQ1tVsz/0gEvvMwmEmaybn4MhdzUbuFdK9JImLNYE2Dbtmh5V+IJofTSwY0d4nfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5oDxOJ/Owk1nrpwMTYG7o5ByGwdowacaSQoALzn9PA=;
 b=EQ8EriJptIaAtWGaZAPClGLKLXDc9h4VfmIrl++wyZck22ubVVdqYEa1adw5kBjkcTw9fr8JEHczwReEGvC77ReoxKZGnHiMEYITa/4hK1VOw6/m1OrMcogl0fe2gR2mDlR/puwF20/hMO7Roi82xWWIGylDlBMgdihw2CRPVtwfr+KQD3jKbXT3M1rEOy4UclDqzSZuENryhN2V4OAVwAyDFgO7HeGPmd3fCZBInJ0vA0N1I6QZJ7EZ2l/QeGkVgbKj1np2TSJ9resDUaQtUmorL87tYXMOn9KpVAlqHhmpbOw7Qy1EmvzHUIZMCEjs2NIFE6pED6cSpJulmWs8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5oDxOJ/Owk1nrpwMTYG7o5ByGwdowacaSQoALzn9PA=;
 b=thmQGx8k0G5dAiP/aKmqF5l1FLtW13sPpqVvjizndF0e5U1rGmX6hmh2AbOW98pYnSip7H1JuIB3RGupubCRw7+ksCmaKzHiKnrnkE3K5QqIsQbKb79oSuQQGU4HCX522zdnEmjZ74T1tZCP/Zwze3GF3GC5LEVBH/6jVz1znYA=
Received: from CH2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:20::26)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 15:07:18 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::25) by CH2PR07CA0013.outlook.office365.com
 (2603:10b6:610:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 15:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 15:07:07 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 10:07:05 -0500
Message-ID: <058ce49e-1693-4429-8659-3576d367c036@amd.com>
Date: Tue, 10 Oct 2023 17:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] clk: scmi: Provide channel information to every clock
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <vincent.guittot@linaro.org>,
 <takahiro.akashi@linaro.org>, <etienne.carriere@foss.st.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
References: <e36c4715ec6f8d3b0819acc4b8ea837accfceba6.1696506554.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e36c4715ec6f8d3b0819acc4b8ea837accfceba6.1696506554.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 070d1faa-f245-494a-e6e9-08dbc9a29246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqJQBIX1dGX/WgJurec9Vc7QzXy8imzvk908/Q8jV+hUflHbSJjsmILfWNMnbfrD48i/oKdhWirbtA93i65JiakyRbSqqXZbA5S60MNLa4g0zX4z0LmjQIyHOBnJ1XYKPWd61qJ8aadYZ+bexer4+VS9iUCj5rdYyqj30Q4Dai1BwxRj0Q9sjfsvzOldH3gnNMFggeupYBHeEyZF6lFYlGuMEq6EqIgju18+KCILnWVSO4StT9XYnDG7MbZPWV2AwlKxcJxJD0KxKRF1AfPJxCEFJm/t9AuW6u5hKBRievygbNMgk0sITcXTgdUCkH1wQqjO45ggy4B+LGHANwrOcESg+ZsxSK5paHuxJXgw/DTxur0YeJLUdC+y5AtinCIXjKWCvqleL/4ntM9WCuHfoHEmCfkL+yD7Fv7fTBS1OAfcRTlq5HdMOYHIhnHf5QfiDla+MBR6w4NX6PTTERrzLZE+g2zBqeKagxLSdrkPdFCca1PxGlHw76ekipcU64yNazz2uPeWRdwA7Zwnr0mZmorny2yGpbX7cjl8ezJ9MFjlOOM7JqcYE3Wey1Sdnc9kI3tcyLv5NC77ueesSHiVk8oSn94QXWFwK1AklhJ7V9eFnwSCKd50U3kHsDxiu02l/S68WKXLo9s8GUlzAODHrOcchAGwU8c5aQ68YUS6PX7J59F5+0HAXVmOhEDazhM3Vz0jJk9VvdbkAju3eqSuvktk/O5jrAX3vjKHl44uQpylBfPMTY6zfckAPlzZopcSAt0EJZJP7yUbpgiOwosOE8DstQ8ZLpsz4FJ1DmIYfd8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(8936002)(47076005)(2906002)(53546011)(41300700001)(5660300002)(54906003)(2616005)(70586007)(44832011)(110136005)(70206006)(16576012)(4326008)(8676002)(478600001)(36756003)(966005)(82740400003)(86362001)(31686004)(31696002)(26005)(426003)(16526019)(336012)(356005)(40460700003)(83380400001)(81166007)(316002)(40480700001)(36860700001)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:07:07.8280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070d1faa-f245-494a-e6e9-08dbc9a29246
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187
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



On 10/5/23 13:49, Michal Simek wrote:
> When assigned-clocks/assigned-clock-rates is defined U-Boot DM core finds
> out leaf which is registered via clk_register().
> But new clock doesn't have information about channel which is stored in
> private data. That's why copy parents private data (channel only now) to
> all childs.
> It will fix the issue when there is reference to clk child and operations
> with it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> I am not really sure that this is the right way how to solve this problem.
> I had another patch which is pretty much written in a way if current device
> doesn't have private data it looks at parents private data.
> Anyway I am sending it as RFC to start to have discussion about it.
> ---
>   drivers/clk/clk_scmi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index d172fed24c9d..98a779fdc81b 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -12,6 +12,7 @@
>   #include <scmi_protocols.h>
>   #include <asm/types.h>
>   #include <linux/clk-provider.h>
> +#include <dm/device-internal.h>
>   
>   /**
>    * struct scmi_clk_priv - Private data for SCMI clocks
> @@ -186,6 +187,7 @@ static int scmi_clk_probe(struct udevice *dev)
>   				return ret;
>   			}
>   
> +			dev_set_priv(clk->dev, dev_get_priv(dev));
>   			clk_dm(i, clk);
>   		}
>   	}

Please ignore this patch.
Takahiro's series is fixing this problem
https://lore.kernel.org/all/20230926065750.734440-1-takahiro.akashi@linaro.org/

Thanks,
Michal
