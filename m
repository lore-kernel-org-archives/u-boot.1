Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A05EEE6459
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A1E86590;
	Fri, 15 Sep 2023 13:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fESR7XAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6B1865AB; Fri, 15 Sep 2023 13:52:07 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E7EC86482
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 13:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2TSOw2HhkxcRR5vwaMzHRBBm8+6yogSoFReyUsg+wxG+/bwByLUBElZKGDCJL5YrJ7elUB2xP9pzY2kwDyEVYaR2k6ViyyQ4j2cIZDgOvwRxDK/l1COFu8prETDeSbB8kK8WM4CsGdkx+zdiNtvJ6Iixrx2BuSsDe4OOQmS/5+HjKwEAXU9gk+5R4zuZGoIdlzVygOBPvQgGqq2K5frcE20zATfE9XnOdk7svhsSxwsPmgS1mURrZnRsZQwZTZsH8npvNc3kEHvgdG07L9X6xP9qslTL2G3FfrHQmCL969yLFFhik2G2kkIlTUVcs0g/KnVhnsW1FnXtKrvbyIdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hXpCmiwmwM4OdWZuk12Lpii4jdoV2oMvmuAU7HUNZ4=;
 b=YceH/woU3cc3hWYNnXIZrTDDLUhdLejgOH10WDokTrScL35AuqjP9t3nItXEyVJQwv7EJe8uQb+bemK//qN/ZT3MlFAQA4bY5MuFdy7BO9mBL7LCHRb4TDReQOofCQXWemfinkTTl1BR0UvJrTRcUovNZ9LKMfM6PzqJ8jRU/oWMKoCmstNRzwVTVUGyR3DbJc6T4n6A/S+hpeauyRwjlso5TTxwxcgrfdBUyQJlPehDiJDHouLmB3TXyTJR1lOo8JME+YzFTSR1RnnDW14C6xhiyjsiMYfOXIW5GZxnUAED4KdzEKYMTdyRX2l6AJ/bvj9+ndmFXZkY/NEz1SfBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hXpCmiwmwM4OdWZuk12Lpii4jdoV2oMvmuAU7HUNZ4=;
 b=fESR7XAKlsWaMyarvcDMHDBT4hgVZEKKGT4deUAVku69MUb3/mTqvDcRos4kzyBmSZ/73KjSu7XPqo6SmA8nVvsgRDfKshtqvtDRP+RgzmPvBh2EyMAw1GF3oFY/OepaBZ99xY3I1XoMB3B4w8Asgs//WsNbq4UG8D49MhC4cSo=
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 11:52:02 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::a6) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 11:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 11:52:01 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 06:51:59 -0500
Message-ID: <74662763-65a4-4e64-bad2-0d5b3bd58229@amd.com>
Date: Fri, 15 Sep 2023 13:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: zynqmp: Display the tristate configuration for
 all pins
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <git@xilinx.com>
References: <20230914100620.26346-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230914100620.26346-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: f32a881d-b8d3-41a5-f812-08dbb5e22c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+2PlTpwLqxCr1e0zZEDKHUtQYq+7/dig7Kc2BxpBtqiqDSVUJoXfcfDR8YWZW0KJWlSqJ6lAK+V4EFYD3+jEEIvDqaAMqYWF1SGdRZcecu0wZDuqeZtTodWWYUqYeJHR+RtQKhCyyZuAk/ex0bFd3Vm8PFT8h4NZ8he4zQLdYxgShQjmzoU+uc7pPSap5rxEtS1fX0j6B6XgoEgTB6kPL/ohRVAFVUi/lvn4+Oie9Goz07nmRn6wnIhu1b19t+G16/3exJam3SLppuFSer8zhEQOfrcwFvJ6CWqBcUt8rxiFx4llNR3sfNq+Md7E3G3bh9+4YHXqUDnCUNHL6UzEk0fhCGYlznbLR3PW1A2VkCmmLhIb6YMGLfGQ9Qrm9KYyv4MxqPHwzjVRrznZgKJu3aBxLdSXpybXYGqzvuYpYkchjC8TqHzDe0Cas2msMLIQ2rqCrJa20Qh0yoxekRhHGy8JtA7Zg0oZLkIQf0taUhyM5KhHxPDDrD2QszU7FN6aGx5av/ropmHVzeuriLZAyyxrI66Z94bKrLWoJLxlJ3J4/pUDWPdLWEtoc3ROROJ/c5jRsakDXdpJGBh7qsgB/c71L5X7cdysykr7oaNqjDYYBAWgJ3oJtoWcABjjrMVXmcfauoblVP5ayMPv5OBsNjovYZWpRfDwfdI0p4a90BVb7ajQycivwUQP7FMYXK6S65iUSh6xvArZUanE54bxhppO28gvbVIFsuEyH0fpTrCHDV+Hhxo9s4W6jWykgNPf+VWydAr/l6pNQ3jvLs8A/t85J+lxGbUkOf1FXfO/vTDfDaltM+0b0eDRb6BDoce
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(2906002)(8676002)(53546011)(40480700001)(6666004)(31696002)(107886003)(16526019)(2616005)(26005)(40460700003)(86362001)(8936002)(16576012)(4326008)(44832011)(41300700001)(110136005)(316002)(356005)(70586007)(36756003)(81166007)(5660300002)(70206006)(82740400003)(478600001)(83380400001)(426003)(47076005)(36860700001)(31686004)(336012)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:52:01.5027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32a881d-b8d3-41a5-f812-08dbb5e22c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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



On 9/14/23 12:06, Venkatesh Yadav Abbarapu wrote:
> Read the tristate config for all the pins and display it.
> 
> ZynqMP> pinmux status MIO1
> MIO1: slew:fast	bias:enabled pull:up input:cmos	drive:12mA
>        volt:1.8	tri_state:enabled
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/pinctrl/pinctrl-zynqmp.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
> index 02626a7561..d98834b1aa 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -533,6 +533,8 @@ static int zynqmp_pinctrl_get_pin_muxing(struct udevice *dev,
>   				     &pinmux.drive_strength);
>   	zynqmp_pm_pinctrl_get_config(selector, PM_PINCTRL_CONFIG_VOLTAGE_STATUS,
>   				     &pinmux.volt_sts);
> +	zynqmp_pm_pinctrl_get_config(selector, PM_PINCTRL_CONFIG_TRI_STATE,
> +				     &pinmux.tri_state);
>   
>   	switch (pinmux.drive_strength) {
>   	case PM_PINCTRL_DRIVE_STRENGTH_2MA:
> @@ -553,13 +555,15 @@ static int zynqmp_pinctrl_get_pin_muxing(struct udevice *dev,
>   		return -EINVAL;
>   	}
>   
> -	snprintf(buf, size, "slew:%s\tbias:%s\tpull:%s\tinput:%s\tdrive:%dmA\tvolt:%s",
> +	snprintf(buf, size,
> +		 "slew:%s\tbias:%s\tpull:%s\tinput:%s\tdrive:%dmA\tvolt:%s\ttri_state:%s",
>   		 pinmux.slew ? "slow" : "fast",
>   		 pinmux.bias ? "enabled" : "disabled",
>   		 pinmux.pull_ctrl ? "up" : "down",
>   		 pinmux.input_type ? "schmitt" : "cmos",
>   		 pinmux.drive_strength,
> -		 pinmux.volt_sts ? "1.8" : "3.3");
> +		 pinmux.volt_sts ? "1.8" : "3.3",
> +		 pinmux.tri_state ? "enabled" : "disabled");
>   
>   	return 0;
>   }

When I run it on SOM I get some lines truncated.

MIO12     : slew:slow	bias:enabled	pull:up	input:cmos	drive:4mA	volt:1.8 
tri_state:disabled
MIO13     : slew:slow	bias:disabled	pull:up	input:cmos	drive:4mA	volt:1.8 
tri_state:disable
MIO14     : slew:slow	bias:disabled	pull:up	input:cmos	drive:4mA	volt:1.8 
tri_state:disable

it is because of buf limit is 80 chars (PINMUX_SIZE)

It means we have 2 options.
1. keep this patch as it is and send one more which extend PINMUX_SIZE limit
2. change enabled/disabled to something shorter

The longest line is
slew:show\tbias:disabled\tpull:down\tinput:schmitt\tdriver:12mA\tvolt:1.8\ttri_state:disabled\0
which is based on my calculation 88 chars.

It means if you want to increase that macro 90 chars should be enough.
Please let me know which way you want to go.

Thanks,
Michal

