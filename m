Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFABCE95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 11:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 835258652F;
	Mon,  9 Oct 2023 13:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyMSks2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA8986AFA; Mon,  9 Oct 2023 13:03:26 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29AF864A0
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 13:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnSHI+FnTm6xmjDodWn23KIu9xIK8E/B+taRE+d/SQqjAJTF74hiq9gPcaej741WWHRK9sY6VZUuBxqmaG1GZGCCm972CxI+a3KTfzt+wfQEYinTe4QLKcTxsbZ99wcjoDAoNtGTB9o6NMVBvCPSE9Yi3WeaoEybLXeGjFwhz3WUvBWaGmEahJKrj1J4m+uA0xQxMtoDZFVqPdkRxiNGMENHzXK/mbrmtAaTfmZ79dUgUlEjK7qTgVPP3CZzWYC1nHxoemUVDRBUZKRIosyKMJxJzVt7MA5tUHjDS+l2C+8BCe5Vy+R5vtjWr9YrzsIQv55knIcW3Ldoxpj/g5bZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxdRi5tiy0wN2NLZDxKCKGVb1qBOLeOQAwRYk7Mh/g8=;
 b=GiGGl6sNWGsBohk5vB+XnGsRpwGqwQ/ZOYrtCBwmrOLs/K+IGs1ttjhHg2Xz0lI6NmxY6ASvqRgEbCEy0RpeF93Qa7iUcLTRJVXxEn4xDiJ3ZesbAoRFgkyAFxTG3EcW0uJq7GlTOqEUYrXwf6Wt1qJbnlpFVJZF5fJpLPE9EdJJAhtpwA75I+UXVHkhy+vf2e4WDDakO6VkSGrFMeIGe4n4lZumb9REubSDT3OGAzV0YdX/cRlDc5I+9xf+uLdIq+qPqE8Af/X/VtQi67xykLBGDDW0qof8SgBHf2ZJNchnsJa4aYu1eH5bwQDm8Xr5cbQFveL2DJmeiHr3/RZPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxdRi5tiy0wN2NLZDxKCKGVb1qBOLeOQAwRYk7Mh/g8=;
 b=zyMSks2t8SYa6aa6/UJY0W7hQ8NSnunYIGCnJKc6VbLsl52CPDfH+YmFR6rLEpjiPhPNJWSAc8c+NeK4w7wh7oQX+jvtQCmd05LyLGA+pclOjBIEmBxvGfccIj7MHOB43glTH9bO0Z2EVgcb3oOixC/qd5C0HsMyNY4FB2QB8Ns=
Received: from BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15) by
 PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.31; Mon, 9 Oct 2023 11:03:17 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::ce) by BYAPR01CA0002.outlook.office365.com
 (2603:10b6:a02:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 11:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 11:03:16 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 06:03:15 -0500
Message-ID: <ce462a4b-f7ae-437c-bcc5-42f8ff232fe8@amd.com>
Date: Mon, 9 Oct 2023 13:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: xilinx_phy: Get rid of using property
 xlnx,phy-type
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <git@xilinx.com>
References: <20231005030202.2764-1-venkatesh.abbarapu@amd.com>
 <97d46d27-691d-4af6-8414-41012e32d3f8@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <97d46d27-691d-4af6-8414-41012e32d3f8@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cf3d43-ab44-48b7-9c1d-08dbc8b75734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YGe1lKJhq4HmnVkL/8TyfhjbvUplsLgMKKseQvNV8KBwxduGeTtABql6MxG7jOcEoZNraykm27vM25FjtBMPlDmUminDSamUg9ezWpMX4bdmfz/R/wLj+4LPuhDMTI/qwykxvLHmnrA+21TPU+v3YD/DEAZAORgSkP+RM5qlgiuPJZBm1Zl9qxt9YMxqwbLvP97o6+l5R0oZi0fVKTWDpjGe6WtCBntTuUymUvIIRlWRXgfx96Lnq3pfphfQ6Rn1MEbEZpYWGpUzMKIJ06i3LP4wlLbC63bYAgM7UHW5t4RfChy6DLSlxs1AJu+23h9+iuKGxLTiCWFqNiJ/vSZ+yFCctyU3n42FvDsp3y6qzYyFDfrlo1sFnKz7u/QCkc4O8s71gvXOxPr6nIpydqccaGd2yXX8p2EmpwKV5Ldix0+2pm67KwbKXVvzDfI6ULkUewUvlwpLCQmoHQvVwyr/ORXhLMuIZdtm0tOQn3ToKwgCErVlL5XEfAo6X9DUaP2nWaT2Xcsmz8F0MZslkgcYxvFkRLfqddd1eKpbbGw7DHmdLYs9N0IXdD6hqAwcHBY33sR+e5u8dgu08t5lswl9fIFLgu6VCRlAURIZRk8qKqlyQ82O4KRBz3knoEvQfylSGFjjYfBPsXQrYDSAQHoolOStbkFma9LpCSX+FSJpT636Z5nUscf1y6lsWb39fA43bBsV5MYnlkMRaLIlUVvaBx05lXjawc3jQIKG/yFEW6Rq+tSaiNqcSATmzPInQXOQh8vPAFLF5jLi8Ib7ZtxmPcrAwuFYoyFT56o2jsyHgdRi7chE9gwmrkTyocBEhz5scErI/mHFPQZ/bHcjsaarA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(2616005)(83380400001)(40460700003)(31686004)(16526019)(40480700001)(53546011)(478600001)(336012)(426003)(31696002)(356005)(86362001)(81166007)(6666004)(107886003)(82740400003)(36860700001)(47076005)(8676002)(26005)(110136005)(36756003)(44832011)(2906002)(70586007)(316002)(8936002)(70206006)(5660300002)(16576012)(4326008)(41300700001)(54906003)(26583001)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:03:16.9130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf3d43-ab44-48b7-9c1d-08dbc8b75734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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



On 10/9/23 12:15, Michal Simek wrote:
> 
> 
> On 10/5/23 05:02, Venkatesh Yadav Abbarapu wrote:
>> As the xlnx,phy-type device tree property is deprecated and phy-mode
>> is being used, so removing the code references of xlnx,phy-type.
>>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>>   drivers/net/phy/xilinx_phy.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/net/phy/xilinx_phy.c b/drivers/net/phy/xilinx_phy.c
>> index 1df639d6f4..50f1611ad5 100644
>> --- a/drivers/net/phy/xilinx_phy.c
>> +++ b/drivers/net/phy/xilinx_phy.c
>> @@ -107,10 +107,6 @@ static int xilinxphy_of_init(struct phy_device *phydev)
>>       if (!ofnode_valid(node))
>>           return -EINVAL;
>> -    phytype = ofnode_read_u32_default(node, "xlnx,phy-type", -1);
>> -    if (phytype == XAE_PHY_TYPE_1000BASE_X)
>> -        phydev->flags |= XAE_PHY_TYPE_1000BASE_X;
>> -
>>       return 0;
>>   }
> 
> Applied.
> M

Actually no. I will remove this patch from my queue. You also need to remove 
phytype variable.
That's why please send v2 on this.

M
