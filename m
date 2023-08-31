Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D19C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 06:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B9798652C;
	Thu, 31 Aug 2023 08:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mloYcA7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F5338655C; Thu, 31 Aug 2023 08:33:52 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2FB8651C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 08:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxJU1rRfGGNmvSpe2WQGLq17uKLvMzaTobHfF61DhzBCiky54zA2DbugxyfYGco4qcoHRNBFp/kDmjcW37DdN7TdXgzojVhOcuADTJ/kU35Y21SAllvxLUC1Tn6NPhJBt9PWku+Sv/AQGOSU1QymEbS3q9DYnujY/VSebceiPjOW9haFU5FnLnZsM5lZGjOJOaClljVaGJK4fAgHmj2IUCQRmF0QyCSw2bCs/HHvGYWNA+UxHRpab0Yu6/b7+MPgh0nYPnevs1ANx0ZplCE0HhBPwfv23P1ZobsXlO7HOe8c9DSA5ZqQapPl2cRUyNVN4ZNUABTKWzxBh2U+S/X+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hulQDAKHfWVIeQgGwcBRo86wR4e1OWV+OUJFax0EHE=;
 b=PmsvkwNqA5OXx2a+9+o/JQJ9a90coF5zPMub7oO1jKsCWqmh/jDv6gdaebPU93iMGMkH9SABaBtmLY9R0znOkiEVIhrAYTQFne6YkgFx/PBO4Nrq27eA65A3p6C6S9F37xECGb+lmHdrHDaeGgCtDiWDZO8wJ7IT5xkbl9rSjtWWWRr7JOn5sspp78+5/2G9OC6YwBiHrLAbdMdjKa7HExlhbRvcKUN9+F3dtzOKz5JssXdA5uxchQmPDiqPxbKEuwq0Rxg0O+jZHzzb/eHGmIwugbfe6hwg0CXPhqJtckOVvsHui8Dfvn9grDgNE+OdRCQQW9w6m9igk/iETIU2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=samsung.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hulQDAKHfWVIeQgGwcBRo86wR4e1OWV+OUJFax0EHE=;
 b=mloYcA7/cXT8RjqcNJ2+wLxHQnr4fhKaK4+47QKORumCAUzDLrdPodk6/HHSPV8mGyPnwyiZj6jvLFEos4CJdZa62OvqvvWZ1hGIEp7vtFq/+x7Q30RToXcRkaLVtNT6ZCzQ8CDNd22f4viKVi3HEqf4Og0DVB60TqMHfBHCayU=
Received: from PA7P264CA0126.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::12)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 06:33:46 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10a6:102:36e:cafe::a2) by PA7P264CA0126.outlook.office365.com
 (2603:10a6:102:36e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Thu, 31 Aug 2023 06:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 06:33:44 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 01:33:42 -0500
Message-ID: <c9f882e3-9674-72bf-b449-c89b972acfd4@amd.com>
Date: Thu, 31 Aug 2023 08:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug build
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>, <u-boot@lists.denx.de>
References: <CGME20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec@epcas2p3.samsung.com>
 <20230816065437.836392-1-chanho61.park@samsung.com>
 <84b747fb-f026-be06-aa0f-c3bab07c3ac4@amd.com>
 <000001d9dbb1$cd79b4a0$686d1de0$@samsung.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <000001d9dbb1$cd79b4a0$686d1de0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b2e4c9-5dd4-48bb-e646-08dba9ec39ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nM/k3Tz59RhESYwO7preWKrlMRaNNyTcOPwvJrGe2Byvx+eLigWJBItO3G2usdsrrO1T6UlYz2JKwpdnDAC4pGzNO0LtoQ6KNrzSxeLtS5ljgbOLdTr9HgADFfawTwVhnQShQrlvNTbpDnZ/UtzpBF4feJ3fbCATtLYZOemfZGwjwOPNtpUhSEQqjx8Au1m9kTMFibi4x9HMCvuIbrBh7871au85Dn4nWV3cJbRyd1fxgwcgCVy0tRra47Wmzgl7l8B3M4ad705efaDoil0UgzzKdBbaJ09LgbA+ima3L+1ksHOMBtkvaDQNj4xrcrzqjNqGM+tNnaPLw2/s0AeVmDHWPk37A/omaoak9xfOk/xOo0f0cGvDosOXMjk92vnTi6U+6RZ2yJz6zoz2m7nvU5qQk/9h3vGCjExkCl2KRNRWG5sXXDsSJayMl6CFL/nFNiQyehKCygDJlNDNzNS49hCZzRze5O2+Wn51AmNOpUD4PQZOWsd0nBsNahWV5D/cN0aNldRtBFTj4P9rvGSdOQ/YFs/vXe2eA0x5TYNdYUq2a8BibltuQyggrUf4eV8/qO05nKGKNdQL5PU5cFIYAEp+AU5YE+zh3DbuGD2Wync4oGLvp0KGwXuW68XM4Q9ABJX67wCGUgl80L6YABuiOnb4TTDI8jijA08LJDjaXHVYCwe5gOFdK7p50d3QREag12MwjVG45lY2d63sTE4rovDbQdZPcUR7/1nsn2u3bZ9zKKeLrliMCEK36NJ61rEiSWHR7EZi4hrARmoeKVo3ob3IURq7MTT7oGSJrtLHFWrLg9hxcsbT//tAdO6qrM2U
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(426003)(40460700003)(316002)(16576012)(41300700001)(5660300002)(336012)(47076005)(2616005)(16526019)(4744005)(44832011)(8676002)(86362001)(31696002)(26005)(36756003)(36860700001)(2906002)(40480700001)(8936002)(82740400003)(356005)(81166007)(70206006)(70586007)(478600001)(53546011)(110136005)(31686004)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:33:44.7571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b2e4c9-5dd4-48bb-e646-08dba9ec39ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343
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



On 8/31/23 04:21, Chanho Park wrote:
>> On 8/16/23 08:54, Chanho Park wrote:
>>> This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled and
>>> CONFIG_SPL_FPGA is not enabled.
>>
>> I would rewrite this because the connection to SPL_FPGA is just one part
>> of it.
>> It is also taken when CONFIG_FPGA is not enabled.
> 
> Sure. Will you rewrite while you pick this patch in your tree or do you want me to post v2 patch?

Please send v2.

Thanks,
Michal

