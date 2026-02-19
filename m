Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0835BE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6652983D77;
	Thu, 19 Feb 2026 14:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZohJTqrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292EA83AC5; Thu, 19 Feb 2026 07:11:59 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A638883936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 07:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtKbnQe0NRM39D3HOE4sXl6AM495XmTLTPN+l+CMSktw2jPGdyWVLkWkmAMmEElPftVwEK5v3OV1w1UAliQZzXVHAwkDRndnIZTQdatOtO6Qv82inXCuGwbS+IgOBHiEmECvJSd0jCyUBQSHS/abw0d2iJWBCGdJe2Vd2D5TsAE46NrNfOl9jILcB8dSIVFZnxHP4v9f6gMvD0EQnOGV+y0yqGkeNlW3rSYkyzNGLclmdzrU37osrzzamjqsmsBSfai0XNrk4m3J5JwqgAYHSm/KMlyoApb5yeRGDUjl9Z8+b2yL683YOXVziJ6WJtB2tCuUFZkSBD7kuGN6nL5ZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrYGw6T6qdtiMXzSOAPiQcLCiDc6UasorEWxBpYsGP8=;
 b=kiBp3LMWgYO83cOKLeM1UDYL04b9v3jQ8SIOiZbkMhukdG9VCJ6my89qgFtwgADK8qtMx90fTAk0NXA3R/tdTBuAnXvD9u8rdndEF47GxwYLqTTZybSrO9oSr8Bed5VOZT20f+ihkUaRn3Xz79wtpTpH0GhfEyx80ayIH7cNchBb2wQiNU0rBExBzNmBGeH12k46RlvegQlP2uTEwckPy3iR2TsXIEQdiZ6cp8I4tJfXr19wo3Pp/Z52VgqQDKXhHFtntMNBgO4gYYtAUY8xRePXvLY/MRxFH8yNhf1TsoepaO5SqLA/P+51sXTWDBGFdQS0SXvhJvuoMxc3/HAo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrYGw6T6qdtiMXzSOAPiQcLCiDc6UasorEWxBpYsGP8=;
 b=ZohJTqrZkIUp3WwPhG+o7YuoqgzsV5fcD9Om2CeFg9Jd3hzOXq8TXmHZwCmo21jfNzrzAxDZJR6xUAExIVoJu4wu5jxc+zQsBMX+oTjJI0M3TNn+917nhwJkjn5inI5hgGbq2fl7xFIfQBbn3RIEygGqBhoPeJT/mpLI0ahYBQo=
Received: from CH0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:610:b3::18)
 by DM6PR10MB4331.namprd10.prod.outlook.com (2603:10b6:5:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 06:11:51 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::f2) by CH0PR03CA0043.outlook.office365.com
 (2603:10b6:610:b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.14 via Frontend Transport; Thu,
 19 Feb 2026 06:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 06:11:50 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 00:11:50 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 00:11:50 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 00:11:50 -0600
Received: from [172.24.21.92] (lt5cd2489kgj.dhcp.ti.com [172.24.21.92])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61J6BjrY2107821;
 Thu, 19 Feb 2026 00:11:46 -0600
Message-ID: <a3cfa9bb-9953-459a-be0d-864f0a34591d@ti.com>
Date: Thu, 19 Feb 2026 11:41:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] docs: board: ti: j784s4_evm: Add PCIe boot
 documentation
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <c-vankar@ti.com>, <neil.armstrong@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <j-keerthy@ti.com>,
 <semen.protsenko@linaro.org>, <afd@ti.com>, <anshuld@ti.com>,
 <peng.fan@nxp.com>, <ahalaney@redhat.com>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260216102858.2745657-11-s-vadapalli@ti.com>
 <8f91ccb6-dccc-4f09-ab78-6e92d407f3d8@ti.com>
 <d6f733d4095a6d4619eb896d7e5ac00e55a56da8.camel@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <d6f733d4095a6d4619eb896d7e5ac00e55a56da8.camel@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DM6PR10MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: f999cf0b-2059-4cec-65e9-08de6f7dc59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnFld1cvdUtEbEJJR1pwaDRNS2gzR2FCUG9ybVhDOG9ITXp6ODdHK0NsZitU?=
 =?utf-8?B?enVMTXc0SUtOcFR2YndCakFrNkhIRkJlU21WZzlWc2hLTlNrUDhPRTB5MWtS?=
 =?utf-8?B?ZG41b2pBaVFsRW9hOUx6STdYOU9wQ3Z6SUZqL2h0MldHUUZ4SDR4RFE5cDFK?=
 =?utf-8?B?NHk3Uy9nNjJDYU1ZcHY1TlB0QXVpV0FYUHV0RjRNVUg4M2dscExVamFJdm40?=
 =?utf-8?B?SzdIK0pMTlNDcjhzNnRtbW8ya1ZuNHRvMkdMd3RqQWlYVjZ4VTREZ2FqRXNt?=
 =?utf-8?B?UjFlejQ2QVYwa2VjOFdpSW5PTHkvL0NTTXVrZHVwREJGdC9xOXBrUGNmK2VD?=
 =?utf-8?B?SVE3RjYyT3VybnZuUkF5MGR2SnZGbVltTWdUN0JXM1BqTnpuS3dsN09Dc21C?=
 =?utf-8?B?Mzh4S242N1J6dlE3eTdrcU8rTHFPYVZ0alFCZTEzVzMwcXZkT2FDaU1xSGsx?=
 =?utf-8?B?Yzg0anNXQkRwY2FaQ1EwUGJMZVl2NGVIQ0ZzcGdubXNqby9DeC9VdmRDcGdK?=
 =?utf-8?B?ZjFsTFZVK3R6UkdVNEg4QW82NkE2aUNNNW9hMmpTU0ZFQnFWOTZlQUo0VG1n?=
 =?utf-8?B?bmE3MnpaV3BJYUJWR2ROVjQ4L1gxb0xPR2VBaTNRMG5VME1kRkszaVkyL0k4?=
 =?utf-8?B?SSs4K2F3N1BFTjArTGhwV0pUOTN3cnQ4SWd4MitjQ2M3eTRPM3BqYUdtSzY0?=
 =?utf-8?B?elBER2svdVdUTjdCZDlranpCOUlvejdLN1VZNVEyVm9HQm1YbUVHdVJyMWlx?=
 =?utf-8?B?YzlNWFlsMFhUNkZwMCtJY0ZzT2NtRzluTnp3UkFRR2VPSTZsbE1JM2RRUVJt?=
 =?utf-8?B?M3VoWmV0K0pjL1haaENpODRaV0YzZTFpblByc0U5NkUxVWNyN3p6RDhTdDdr?=
 =?utf-8?B?ZnlVVjZBM2o5a0V1SlhyeHk1bGdxU3QxKzhoNDB4SWM3bE5FeStkRlpwM0dL?=
 =?utf-8?B?NTBXNzM5VHp1MTN1N1ZwNlMvU1JDUVI4ZEttOFFVVU0xNGNRdUE2TXlsbExY?=
 =?utf-8?B?K0g5bHFHTmNJc2lOQXVqajYrWTRFcDNqS3pFQnN3YlFrcFlITjNRdEJUN0Zr?=
 =?utf-8?B?V2IrcVJUbGNLcURkVDdRNWNGTEVwNFpjVnI1c3c0UGFJT3lHaERCVVBvcjlp?=
 =?utf-8?B?VU9pT3FDa29HUk96Nk1KSWJqalNTRmJNTDdYZzNtT3FtazRkeloySXRKb0Yv?=
 =?utf-8?B?bk9tUXBINWgzODR1VTVuNGh4TGRwWnoxMHZtLzgzUFpzU2hBb29kMVNnYnFT?=
 =?utf-8?B?TkNuM0xSUnlOY1BxdDNlTkJ6NGl5OXk2TW15Uy9FVkl1c3grWStnSWd0dVlF?=
 =?utf-8?B?am9Rd1E4OWh5cjU2REtqZFRnM2RBZzk4WGtKRDlvUmd6b2pvRDlXdXU4Ny9j?=
 =?utf-8?B?bHFhT0JjWkZPdXVNbHA0dERzZFZqQWYzb1JrMmpVTGNuWkllVlo3NFpia0hj?=
 =?utf-8?B?Z3RxNlhqbmRBSEJtdERiOG5rTkQ2cGdSRE5OVUJhcTJQWEtCMDJxZlF6bVg3?=
 =?utf-8?B?aE5FMXNUNEt5SUhLem8wNk5LakVVTnpJa0ZtVWVTcVRNcHVabHM0bFpMdXVP?=
 =?utf-8?B?Q0taeU5wTWVaR3llV3N2WU15N096b2QzNElWMm5Zb1FZOHYrazVJL3drbHpP?=
 =?utf-8?B?RHp4NzcrdEwxdFFHR3FNVk94bzNyT2VpY0tGdzNqZGIrRXd1MnRSdGRtRGZJ?=
 =?utf-8?B?ZFk4VDRoQmNERG1zZVIzWCtOYXFOWGtuZitJQStmS2l4T0YraFNJYXlER2s4?=
 =?utf-8?B?Y29wQW9DMXpaaFJUTDhGRHJBN3RZVE85NU1Dc2Q0RDhPY2RJVFRZOTlSVGdz?=
 =?utf-8?B?TURrWmdjMXZVOWVXc0FYMEVGLzhLdWNKZjNBOUM5SkRraEpKMnR6MDJMclBi?=
 =?utf-8?B?MkQ1NnFFa3lsUjRVNmRIMnNyd09kd01uSU9haEFwZDYyRU5SNlBoT0d6bW9z?=
 =?utf-8?B?bGhnQlZzRVlrQXl2Sy9NYTZGS2M1NDFIYjVmYXcrS2VmU2wwRzZOeTRaS0tE?=
 =?utf-8?B?TVJjb00wdEF5OHZCM2VWMHZoOEJQOFMyck5EQnE4TmUrbnhpVU1paURhVTZo?=
 =?utf-8?B?YzBwd1JjYnFQRW81LzQ2T1hYOXQzN2lLeFU4cTdKcXVsM2pUWW9YNnB4cHBq?=
 =?utf-8?B?SFl5eG9IeXR1aW5BbFF4THlEbmdDa0FDRmptcU9oZ3NxL0Z1N0FzY2xhNUZQ?=
 =?utf-8?B?Zml2dmZ0RjlYSDJ3dVcrQWNtUVVGa2VubjJzRlQ5eGlUUHpCN2JOc1VMcngy?=
 =?utf-8?Q?s3JA/B846m7SS+T2n12eQAHOqTRhDO9ABWcIa0iqb8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MCZLojQtKCk2YTi1+KJK6zDWZpj4mcqFp7AzuTAkEWOaZQH0dkrfRzThOPJEy8cEUpevGPj0/bhIowW7RFdN9XT9qBChJbYNBxDKINZTbYSQH7XyCdsXoPU4pddcmU1rbfzePgb/a/fY8Avkga15gdFA54lg6MKrORNUCdTYGVqNh9zb52J2PPXgqOJgoKdbXKuGtVunc+WE2lVQKCfnW28mzWZ5w5s8m2jXrwD5LI7Rwt3McZhgXnGw3LYeAZbHQEJu41QQAzCR5uUTlE6aaqt+k5GzixH7znsPkgr7bisY3/o/ps/+2f1h79tYUfcsqq87AOf+JHLBfsGuE6tLmA3vHhod+RZMKeQbuMNCcGk8P7rawHRizJ8lfX5c4SevWhLnihFouLS8PVz/TElGmiZXAu21NJj7G47LlWS64e0Tzf1z9mztdt4CGdAUD6tz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 06:11:50.9113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f999cf0b-2059-4cec-65e9-08de6f7dc59b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4331
X-Mailman-Approved-At: Thu, 19 Feb 2026 14:37:09 +0100
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


On 2/19/2026 10:24 AM, Siddharth Vadapalli wrote:
> On Wed, 2026-02-18 at 18:57 +0530, Kumar, Udit wrote:
>> On 2/16/2026 3:58 PM, Siddharth Vadapalli wrote:
>>> From: Hrushikesh Salunke <h-salunke@ti.com>
>>>
>>> Add PCIe boot documentation for J784S4-EVM including boot mode switch
>>> settings, hardware setup requirements, endpoint configuration details
>>> and step-by-step boot procedure.
>>>
>>> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
>>> [s-vadapalli@ti.com: simplified and documented the pcie_boot_util program]
>>> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>    doc/board/ti/j784s4_evm.rst | 305 ++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 305 insertions(+)
>>>
>>> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
>>> index d858dc7cdbb..fb767bedbf6 100644
>>> --- a/doc/board/ti/j784s4_evm.rst
>>> +++ b/doc/board/ti/j784s4_evm.rst
>>> @@ -299,6 +299,10 @@ http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
>>>         - 00000000
>>>         - 01110000
>>>    
>>> +   * - PCIe
>>> +     - 10001000
>>> +     - 01010000
>>> +
>>>    For SW7 and SW11, the switch state in the "ON" position = 1.
>>>    
>>>    Boot Mode Pins for AM69-SK
>>> @@ -330,6 +334,307 @@ section.
>>>    
>>>    For SW2, the switch state in the "ON" position = 1.
>>>    
>>> [..]
>>> +
>>> +PCIe Boot Procedure
>>> +^^^^^^^^^^^^^^^^^^^
>>> +
>> overall series looks ok.
>>
>> One suggestion, if you can move generic document into some common file
>> and include here.
>>
>> then you may not need to update repeat text for each platform.
> Thank you for the suggestion. I will do so in a future patch independent of
> this series.

Thanks Siddharth,

For now

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> Regards,
> Siddharth.
