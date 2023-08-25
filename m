Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D5EC71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 09:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3E4864BC;
	Fri, 25 Aug 2023 11:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="00UZSF5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E2986532; Fri, 25 Aug 2023 11:39:23 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9BB86481
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACHsyALNV6n3wsYPUit3RkRCb2i8XjHdkBkWQ+WpF4W1lbBB4Qj197tfA+Qp5iCUnzWbFxjXFYP1Z55L+Deu7vJvR5bi4hXf/hvnb6zdaYjJIhIeByyMmokZD8IiTnbmcBJiFE0MANANvag8hZRl/G2OW+AiTBL/9zB4l3IXG7WlWbJtTr1gTE0hKSATXSlgoWK+Wi0Prkfar8CN7rqVrldLaEwERtj53OyM5bJ6F7qSHOtdDRoefs3f5aQzwDVabP+m+yJldPztJr5+HW/zCU1G44a0tX3qGndFykk/WhCOU6m+aOWTYaTvV1GDLFyaApVUtJPm6DjRXkF5zL3gFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUdXOGbHJ7CH29VWhKWWqnNhkhO/8qw1peGEJQNkVOA=;
 b=SCzV33Fv9wHgCnAy1M1v/c2Utk/7zeAouajIuvdJbookO8q/Z8/u4ZBlLSmUdFIAlbNbcRHtdSvamF4EFL7RPp/f58rdEcdqpvdcF4V6f9gpWGZsHu7PgWDqH8de2Clop+0ZC5MlUufTmE0wiUcBhHs4bEI3q4lKciBh6tK8Knmnh2TP8LAqRt0BkqCYn2YUU4hrJsuz3H4tC9pihnLmZDcf4YCGiQaNB4dzs1gsJdKBFmyQIitPa1ETaoG5k7KXZJlW9+jX8GT+4XyQ2Pq1uT1QEJE7+IuHmkDIassEZdzqLggeFm+z/5RuShLpJ0/tzLAlmqKi4Fcj+FR9GN/sKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUdXOGbHJ7CH29VWhKWWqnNhkhO/8qw1peGEJQNkVOA=;
 b=00UZSF5RKl0DFtJ8mFOQaxW1CorkAX6n7eZkPio/U0yRo4AA2EqdYWQT/rL3TTK5ZKYkmQucKZ+runKcE/4xdvggTr6RApvpF7HAgbhoVc9e1ctfpLG8dDRp+9PKN17DvOVxaDSpg6ZYfsVMw+PZkpn9iVq6GRrY8K27smfKAGA=
Received: from PH8PR07CA0040.namprd07.prod.outlook.com (2603:10b6:510:2cf::26)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 09:39:17 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::37) by PH8PR07CA0040.outlook.office365.com
 (2603:10b6:510:2cf::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 09:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 09:39:17 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 04:39:11 -0500
Message-ID: <a4b8db1e-c788-63f2-52eb-f854ce1dc7b4@amd.com>
Date: Fri, 25 Aug 2023 11:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dm: core: support reading a single indexed u64 value
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
CC: <u-boot@lists.denx.de>, <git@amd.com>
References: <20230811061121.23964-1-ashok.reddy.soma@amd.com>
 <CAPnjgZ3Bfynuv2tCgsuGgnvWmWc=yxHc1-HVpDESV-eSm+D4nA@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <CAPnjgZ3Bfynuv2tCgsuGgnvWmWc=yxHc1-HVpDESV-eSm+D4nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0ea646-4d10-4aab-91ff-08dba54f269d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUfoC8+GK2B7OJ3MmkgDqfMAeTMsz92Ld4iQVwornt1SEIpeD7Tdp6m53+kJ6byvYREcOzFU+6hRGGq2HePCU7L3dZT25WCkCs3695ttxzUYunYO8fBapyAv/MSZzf0Y4DxmWRBK7NEcEyxwX/X7Y8rJvo7UFjAmnjtml2vfk9dU9fsIH0ZwgHsNbDYSuGTkUBVRJM/r5hRhyLTnhBYmtYm9/Ax6XNHt7KRGxI0fLkM3JAeor3rQhYFelR7D4twdEz8W/LmfZDa5WkH25AGNAwCpyIetbw0ne3tkfXlxh6Se9HD2Rf5bJ7vWcbyMZyhfOYxEOPvVgsOdZ6aTfpD1TDt+CDWAn3DcZNWWdZYSo47q9H3TQDvsM0c0L6t1+K1st+sHRbiIXjfld/S0eKPeQgWaoFHr8lB9jDbHlOf6opzblDYJQvzWdKbn0g+E08NOi2fmNrswBvQdZkgQH+aYc/sIsRx7uq1TnsvkSjludaJv8t20aDh13u2bz8RDsM5x6CKvfj3Qq5HAObeh8OS+Yi5/8kXdQmmnKJgGkwdyQooFUgkkAiHNNmAoIEVL60bBn0SWaWOJW9W9NCMgZJkfpfspohxS7R0rjZx/xlTq81t7e+bJL0BuFbQEgqeCL55a5nHruAN+j0taJcrk9prnEMR9v3HNsTWJAGF28sz06jkwqSJL/DSGwQIInfwY7wQcfkD5jlHUuTLCsswPsKd1eX0SIuA2nMLFPTgueSOK4/t7BClHKdFDy21VAlKbhCNdCc07KiIa9QsR5Q7Tv8KRpIA+RdzIL+pA7OpxuzbZ/Uu2n6kCHfn6tjyo97BN0q3V
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(336012)(36860700001)(44832011)(83380400001)(26005)(16526019)(478600001)(47076005)(40480700001)(2616005)(5660300002)(426003)(31686004)(4744005)(2906002)(8936002)(4326008)(8676002)(356005)(82740400003)(81166007)(40460700003)(6636002)(110136005)(70206006)(70586007)(86362001)(16576012)(41300700001)(31696002)(54906003)(53546011)(36756003)(6666004)(316002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:39:17.1292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0ea646-4d10-4aab-91ff-08dba54f269d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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



On 8/11/23 15:36, Simon Glass wrote:
> Hi Ashok,
> 
> On Fri, 11 Aug 2023 at 00:11, Ashok Reddy Soma <ashok.reddy.soma@amd.com> wrote:
>>
>> Add helper function to allow reading a single indexed u64 value from a
>> device-tree property containing multiple u64 values, that is an array of
>> u64's.
>>
>> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>> ---
>>
>>   drivers/core/of_access.c | 22 ++++++++++++++++++++++
>>   drivers/core/ofnode.c    | 30 ++++++++++++++++++++++++++++++
>>   include/dm/of_access.h   | 19 +++++++++++++++++++
>>   include/dm/ofnode.h      | 12 ++++++++++++
>>   4 files changed, 83 insertions(+)
> 
> Please can you add a test in test/dm/ofnode.c ?

Ashok left AMD that's why I am sending v2 with some other related changes and 
also with adding test you requested.

Thanks,
Michal
