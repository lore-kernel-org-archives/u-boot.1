Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602FAE9B24B
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 10:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA5283D8A;
	Tue, 24 Feb 2026 11:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bwSO1GS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8AFE83DAE; Tue, 24 Feb 2026 11:06:28 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EAED82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf9l6Gd7j7YqsALVYqu1N2yta6nlc+ag+y7upXv7ryMbLrZO/T+9Fg56tEhL8AM4eeiLsbIoB2r4QrVCv3qMwhlMeyc0UKCr32YQS8H3ADXbfIN21FgH+2YjuSxUep07RDwdjLsfmlxRzpT82WGTyJZ8fEzPohXX4mesZKJ6E2Mg8ef2y1TK3ZdIHD5OFx1SfssNZsg9rnYdE1f6D718lfEwp3iCdeCRa11rHDjl5sqc4y5MIGX72vkZljtJMZceWoJhtJfDjw/wMSE0J+1cSIA4eXkqJb1OtRC+JqobZRu8ZN9J21RRF15ZSbbTj8xT/rOsH2Xz6BRtNUhjIrJZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPBcLcIEwhX1CC6MQjGrqrZfI+Jfe5oiKXE5KhpkQLk=;
 b=S1KMFHMQrNK7NRRy/lqR4WjmLBmCK8xSQqjw7fchORVa6Sltddup1H7te9zLq7LKrEYL13Oe5zpJD5yo7vFjAk7bt7O/4VtAl9qqslbVFAMFVgPBiu/lCZnhOFnoYS3dopjfrZ2P/Ic3kkIip/wa2YbsEYJSnUMWoRPFtZNqLufcaMQSTf7JcBhhpNZWTVrc4awofgHIZq9e1K43fIhzc/T06PqornlW/WEkMiY+yfrfAF3VRXzRx94JS552y7qRyXhG6euhYJbxgHpRpAmBmk3zF6AVAbQU8d/7EmG4HrrF4dPig1c0BSIWxg3en81BOPDGsFx/SGESl6HM1elWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPBcLcIEwhX1CC6MQjGrqrZfI+Jfe5oiKXE5KhpkQLk=;
 b=bwSO1GS3URmzQl3oX88ncEBLLriRcsbZtTFPR+TOTyKWBdrwM8F7u6JrQj8nRLbuVKST1GYSN2GX/wb51r+WtIVJEC7lxZi6lpBBPmTLA4xXNejSoTVgIQ88iHi3RzdDABHFxxhpMm7f6TSJkAtQCJDu8o1Wcta/756oVCUjEIg=
Received: from BL1PR13CA0414.namprd13.prod.outlook.com (2603:10b6:208:2c2::29)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 10:06:23 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ae) by BL1PR13CA0414.outlook.office365.com
 (2603:10b6:208:2c2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 10:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 10:06:22 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 04:06:21 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 04:06:21 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 04:06:21 -0600
Received: from [10.24.50.71]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OA6IAC2050166;
 Tue, 24 Feb 2026 04:06:19 -0600
Message-ID: <28901d6f-837b-421e-aa9c-01f47ae6446b@ti.com>
Date: Tue, 24 Feb 2026 15:36:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: k3_*: Add config fragments for inline ECC and
 BIST
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>,
 <gehariprasath@ti.com>, <s-k6@ti.com>
References: <20260220091532.3584771-1-n-francis@ti.com>
 <1c38a0d3-8c40-4ba8-8038-df1d1bf1c85e@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <1c38a0d3-8c40-4ba8-8038-df1d1bf1c85e@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SJ0PR10MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d8de3c-853c-4b08-c6f0-08de738c5cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ui9TaDRYTlZkOWIyQmtaL2ZQamM2NWRaVVJ5Mm1ld2dRc096cktwUC8yUm0v?=
 =?utf-8?B?Tk1rRUhTNDVHZ0MybEtFUitLckQwcmlRemtBZEplMHpUQW1qc1VCT3pHTS84?=
 =?utf-8?B?TW9icTZZdCs2a0Z0akpLc29KOEdlUENpaWhIT2Z5REp6TGUvUjlaMTNMUVNG?=
 =?utf-8?B?T2tNc0dqbmxBYmtSQWR4MDdLZjdhVVpUbFJCNWU3SzBiQmxhM3g4VUt0aEhX?=
 =?utf-8?B?NWE5S1E1aUcxV0NMMS9Ea2NEUTgrZEh6U0pmdk1mYS9tVXdTSGcyQk5UbWVj?=
 =?utf-8?B?N1F6M0ppajBvUmRLTHBMUERTVldrcmd0Y3JSMWtLYkU3UjQ5aG5XZjlTcklH?=
 =?utf-8?B?V044WC90YmUrSEpzZWxseW1Md2pGUWNjb0JzRVBhc3R4SlQ0QTFMUzU3bW4v?=
 =?utf-8?B?elJ2L0ZJdUdlRDgyNFVTejE1VWhZK0o3NEF2WXg3M2U2QXJ4MnEzanpoRzNE?=
 =?utf-8?B?NmxEOS9vdit3TVdrODhhNXhweUJnQnkvMzExL1dXdVBXN3NCQnpYYWZ4N0ZX?=
 =?utf-8?B?L0NBZy9Td1pIT1VFM0dvdGRUaXRwaDZZOVJUancwaEJreHJnOSt6TzhEZDM2?=
 =?utf-8?B?dkRaREVBZ2ZhaG53TDFZRUVnUjY1dnlKQ20wZk01VkVuOFlvSCtSVVZlbVA5?=
 =?utf-8?B?NVRYZHQvNlJxbHRSSHZORmw2OTFPMDV6V2REUk1JRFBYdytMbTFNR3RGY0Vt?=
 =?utf-8?B?eC8rNGRqYkt6ay9LQklZLzhSQ1N1Nm55K21oN0ZFQ2F0aW5JSmluMlE2azBW?=
 =?utf-8?B?RUFkeDFEQjdJK1RMd1FCSy9JQXVweDdPZlB5MWJIMHRHVnBtdGVQYVdtazVS?=
 =?utf-8?B?cGRBdFdpeGdHUk5PTjVnS2M3S2g3VDFXNGRTcExUOWFWcGUwVE16V0VqUWZM?=
 =?utf-8?B?MmpPYXNpbytxaU5JRnhRQmZTcGNLMVE4Rm5BRWFVOGE4QXFsdUJwOFVsK0JY?=
 =?utf-8?B?VTcrY0M4b1VuK29tUHBCTWdGR0x5ZFMyYUc1d2srY2t3NWtveDVIcnE4Y0M4?=
 =?utf-8?B?L3pOVFJmZW0welRxTGdmanhlVlhrVTJMNUQwSDhmc29TNGxRM1JuQTA3UVFq?=
 =?utf-8?B?YkFzaXZKeCtaT2wrL1o5OWNtTjBoWUc0YkxLSGZMOTB0cGR6M0o2V0RtS1Iz?=
 =?utf-8?B?aS9lSVkvMkYreXZRQ1grdEZTcnpQenllc3VwK1FBZi9LdzZWUTQzV09RTHB3?=
 =?utf-8?B?ai8xUmVSQTZVVWRmd3RkWDNVd1pTRk5hajB5di85OG9MWGVtRDFqWStsMW1o?=
 =?utf-8?B?MEFOQXUyTmV5ek56NVNuRkFrTndvdE1WcVcxZVhReE5qVVdaRHBCVFJYcFlX?=
 =?utf-8?B?NWhqcnVnSkpFVkJGNFlra29QeDNmbHJxUi9KRHNZWElIVjZjcWx0NU1OT2NI?=
 =?utf-8?B?VWw2d0dVUnFLajdkREVKcHY1TGIwZHR6NCszRkRLSzl0amdhTTBUcWZsS0k2?=
 =?utf-8?B?dkdzTWtBc3k2ODY5SGRUZ1FvOHVlblZMRU0xRFBBazlWeVVHLzBLK2Q1dHVN?=
 =?utf-8?B?WmhxSERjRk9HMnRhcS9JNCtKZUNWOEZIVjNZQ2dFcUphamVlbHo1bldEWmZy?=
 =?utf-8?B?dDFJbjEzSFNwbFc2TksrbWYyWFo0V0VFclZIZGlGTW9ZVmRBbHBCWjBHWDMv?=
 =?utf-8?B?UnB1KzJRYmtWcHNUNlhqaTJReTVjd3NmL1F6OExyb1VBSWo2c3hqZ2s1bVBu?=
 =?utf-8?B?bTNaZTRIQ05JMGZob2UvckQ0Z3A5M1huRitZYStCd3l1TnZ2MFBZMFFYUGtn?=
 =?utf-8?B?Q2VRODdJZDNjU3FNS1FTb0J2LzNEVG5LWHM4U0luRitYbkFWR1lOZFBQd2pM?=
 =?utf-8?B?bXFKRnZTSEdXTXRDc1VJQ2grZmZ5ZmpLbGR4cjcrWUUxZ2NqcEZRRU1PVTZi?=
 =?utf-8?B?U0Q4Y1NBQlhBZHovcFlqajBvVGpCZmZ6NVlFZE0wZks5V2IzVGd4ZDBQN0Na?=
 =?utf-8?B?OHhOUzN2c3N5WE5jZUdpcDBOaG5pMmhibnN6djZJVE1WM1ZBT0cvTDhpR3Ey?=
 =?utf-8?B?UWVqa083S1NubHhMd2ppSkhpYTQvK0ZwMkpYUVh6ZU05SGgyZEpKekZUbWEw?=
 =?utf-8?B?YkRoNStCa3M0T3l3djBxWnRnaU54SXpORlhjWmcxTTVpV01vcWRiZnliZE11?=
 =?utf-8?B?QVZLL1BCdk5QeEh1cytNSGo5L1YveVk4dGlxQlpmMDB0bXY3SmxRaldRNDRv?=
 =?utf-8?B?aHhzaUJ5a05BNjRBTzgyODI3eGI5V2FGVVZkaktYUzE2aGxLRTMwQ3N6SmpC?=
 =?utf-8?B?U3RmU3hlWktmTEp6VnI4V1VrQTJ3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /iJpQKAzThnydGjIzjn+ii1+ejAKV+GgJgOk3bJOdaFnWjnOmbxFvm3qxc+TVJBMXmEu+SCd25CXNbqCT01qi8EVIOwYtTz68Xmm9j53l9mZJknlUCfJ+ek10c1MsAjt+O4F4a+dxepYeI6P5qkSCpxk1D/ctkAUrgODCMXGDsyJQCWmczLiPZ28JGklqEkkxok7vdOTFjwNicqhJ/tWKTPx/mMyoOEUXoVcyB3Ur2g/MzJ0ErCsA7IlNCJ0lgzDq10CwDzgRSFjfLJLhpEW0JXlO98F8H+eEluQ7liud+AaJ5+EMsJWAdNGFu2+AtVxX0mQli+q5aWKjcu+EDcaeFV6xt9DsGj/U5yIrVHaZTcxoJLIB+/zhWKf5fGjmupUzk6f5IgTv2fnd2GOijUfyRD/XNrKRFFAZhc8xKUQYx9NR4vtPW4qMorvFuao8zIl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 10:06:22.1928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d8de3c-853c-4b08-c6f0-08de738c5cd3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
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

Hi Udit,

On 22/02/26 07:24, Kumar, Udit wrote:
> 
> On 2/20/2026 2:45 PM, Neha Malcom Francis wrote:
>> Add config fragment support for enabling inline ECC and/or BIST on TI K3
>> supported platforms.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Typically we do not enable these configs by default but would still
>> like to have
>> the option to start building them in our default build flow for
>> testing. Also
>> there is the added advantage of users being able to see what is needed
>> in case
>> they choose to enable these features.
> 
> Can these fragments exits together ? , if yes then one config fragment
> should be ok

No since INLINE_ECC is applicable only to R5 builds while BIST is
applicable for only A72.
> 
> 
>>
>>   configs/k3_bist.config       | 1 +
>>   configs/k3_inline_ecc.config | 1 +
>>   2 files changed, 2 insertions(+)
>>   create mode 100644 configs/k3_bist.config
>>   create mode 100644 configs/k3_inline_ecc.config
>>
>> diff --git a/configs/k3_bist.config b/configs/k3_bist.config
>> new file mode 100644
>> index 00000000000..671dda1a9dc
>> --- /dev/null
>> +++ b/configs/k3_bist.config
>> @@ -0,0 +1 @@
>> +CONFIG_K3_BIST=y
>> diff --git a/configs/k3_inline_ecc.config b/configs/k3_inline_ecc.config
>> new file mode 100644
>> index 00000000000..143c814b41c
>> --- /dev/null
>> +++ b/configs/k3_inline_ecc.config
>> @@ -0,0 +1 @@
>> +CONFIG_K3_INLINE_ECC=y

-- 
Thanking You
Neha Malcom Francis

