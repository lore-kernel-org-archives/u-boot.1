Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7D0D6CFBA
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 03:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4053D8397D;
	Fri, 23 Jan 2026 04:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fcba9uP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67DF5838FA; Fri, 23 Jan 2026 04:32:57 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61B5839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 04:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSVf03kOfehiNLFjnc7DUmAH42wi/wO2v8IzCrnPDGk10xYpERlNJm4iUus2zcR6oLuwy9hVh7TheZNhEYsQx8vs5uXhSc7DyJnfdEq9Vmh5p+JyFJE4C2HouBIihqWwwGFtMx8OHqWwAXvFGGIhlLUd6aKgs8jwiLgO2X6J6nctPSHcj1o+tS+rBjhFH389ZuVmA5pVKtVUE4HkB63Z44aCZkVjhM2j+VfuHNhTwXv10go2QU6Ix3P1GV8RVJ0iQ/0MsibzZRcZhpJqeU8q0kI73iGj2BW5piyzNk9E/l2FqC0bKGTP0lW2wbDuU4cMyBTDPUilnBNm8vSZ9dJ0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxFzjpngioF3kofCAxG3vCg9+iz15c4i/0fAtEinCIQ=;
 b=rhx6XEsatIQak21owwFGzCbt6q92aErUurwjWta/RsdYm9NT9r+G1PI86FMuM5lsi8wpiqquj39Cr3tp3Qd8RIQB7BOJfGxbQYeEbNjKNmjwMcJl0DPC203zyNFXsqHsNuJ9ZkO6+uEc3qjOpfGJI3jC7cpmlYxi7NxOlniFo9674QsJpHqNBPGuQDe7JMqZcChfwredk5Cnyn7zRKMCziKan5IvVjjnBIvknkhPTuQMeVu1Ms65zC0wWYiuSvcg0li/Am2OCcFGsuDiF4iHZhJCR49c3KDUGNNJpblU0py5Je6TROG0Tw4JiRfSL7M4XsFDxwp/NWrPxHrc82roPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxFzjpngioF3kofCAxG3vCg9+iz15c4i/0fAtEinCIQ=;
 b=Fcba9uP+772UfKDul3Fa08UkkQnEZETPSesrYdC7TQyMMbFu2E95aUTW3OXtKfi1WbK2jl5aCzuhkNsB5Wp64RaHpXI8fZZaU8rIQ7T1GJVwAEyXt2SyXroU3uezKZU6ePK+6WyistaGvtWKBItTErUNaja3rwOApkANbEpBipg=
Received: from SJ0PR13CA0222.namprd13.prod.outlook.com (2603:10b6:a03:2c1::17)
 by DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 03:32:51 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::8a) by SJ0PR13CA0222.outlook.office365.com
 (2603:10b6:a03:2c1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Fri,
 23 Jan 2026 03:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 03:32:49 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 21:32:41 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 21:32:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 21:32:41 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60N3WaNG1513757;
 Thu, 22 Jan 2026 21:32:36 -0600
Message-ID: <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
Date: Fri, 23 Jan 2026 09:02:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DS0PR10MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a229bf6-a839-4e46-ba69-08de5a301587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW5SbHRjOEpvaGN1TnUxb2VRd3JhS2pWcjFQK3FMTEdCbGpCOVA0VGNjTEtC?=
 =?utf-8?B?d21GQ1NYNFlDcFQzaHF0ajRNRDNrdGNxNm1YWjdrRzAwNmVwZG9GdGRNbmll?=
 =?utf-8?B?UUJudTNtdzljTlJZd2dyQjVJdnhXSUFaNUZQVTl6UGNJRlBycnBxQ3l4M3dR?=
 =?utf-8?B?VnBvUHptQ09NemZ6Ty9pZVh0RnE4dktLUnE0TDMrYlVVOGVXR05vdEJmYjY4?=
 =?utf-8?B?WmNzWWdETzhRZGRVem1qU1hIMUV2RkVCcmtRY0FuSlVJU3h4a29jZGNweWpS?=
 =?utf-8?B?Ry81ZW0xRDhUcjJwak1PYXFoQkh0ajd6ZGJWRlpsV2toKzUrVjFtaURmYnJN?=
 =?utf-8?B?dFdmWW1sV21PaDdrLzlyOUtMODBoaUNsMWFHV1NtekxPN0k3MDZDZmwzUGhP?=
 =?utf-8?B?Y0ZEV2dUQXVtY3pycWREdUcwTU5Nd1lmSGpSUmtOSmxQY1FwZFArSGJmMkFG?=
 =?utf-8?B?YmoyRHdEUnF0bE5JZzgxY0l5dS9HZHpDNHJobmQzMkxWSGVZMmRXZTRpSEhk?=
 =?utf-8?B?SUpkYW00YzV4ZkNaOFVMVjdkMlZ2SEM5Q2xlT3RweW94ajdWYTltdnJ6WEov?=
 =?utf-8?B?TFFrSi9DekFFUDVUZHNyaUJXWFhmNW5STFZ4UDgvcXlpTElET2hDMW5BUkp2?=
 =?utf-8?B?TERLeFhnR25yVUxLZ2ltS2xlU0VXK09jMkx4WlduUkRNaE1XM1RxbGl1ank2?=
 =?utf-8?B?djFlNGZ1bTNHVWc3bjd0MlRzZ1FBcVJPLzhUelNGc1p3NENnb3M2RGw5dzZ2?=
 =?utf-8?B?NjIvZXZpZTF5VmlGc2hQS205dWF6KzZJMGR0dUw2UzMrTkxrWElkR0tUVE1S?=
 =?utf-8?B?TENTNkU1S1NsZExEbm12eFZEVFFMaDhIU3NZSGxpcEdqTU1QQnBCek50Zk9E?=
 =?utf-8?B?aCt4Rk5oRFYrbTlIaCsxWXNQYzdpOWVRQXNIZXZoZ1hWSlVESFdaTk9FbWxr?=
 =?utf-8?B?eDczb2RsZ0xrSVByVURTY3F2c0g0SjJuOHVUdjNZYTRObEZ5S3B2YnRuaGF6?=
 =?utf-8?B?bHZXOHZPZlRlQTd3djZrb0tsMDVvK3hIUC9uczU1aVdWZTdaOWtnTmQzSGFS?=
 =?utf-8?B?SUhwNjhnWjVkR1pERnhDZUI3MWpqWE8wUG5uU2lUN1FNcDJPZEZhSE9qTVYv?=
 =?utf-8?B?a0pndEdZOEI4cU41aktwVDJ3dzBWQ0xnZUtUUW4rUXlVYUlpQlkrcDVVMXdo?=
 =?utf-8?B?VS8zd1Z6aXVBOWUwWTJLRENvbXJKeTFQUDVXZEg5dTJVL0R3MlRxRUFqaFp2?=
 =?utf-8?B?K0VCdDhITmdaZ2w3VzBBejJVRktTdVdZanU3Z3ZvQmN2eFhEeFgyYXdsYU14?=
 =?utf-8?B?V1JjOUhKWGhGMzFUeU9sZFM5VCt5ZVVENzUyMFVRMGR1MlduVDNRSVRQREFJ?=
 =?utf-8?B?ellNMlhDUk9GbnJJcUtpeE1sSmpEM3Y3L2dyRmhleTMzZm5peGY5ZlVwWHdm?=
 =?utf-8?B?TEplL0ZJN0xZSWNUYjlhNUh1aVZEZXhUT3VKQVVNUW9xbzQ5TU1HT3NWamJ4?=
 =?utf-8?B?VFRoZXhBZXVYVHJnQ1pqQ2lXWXY2VUkvdmpuV2tUUzNqUTd2MWNranFzYUNE?=
 =?utf-8?B?V2NvcVFXSXE5c1dpaGlra0kzeHVQMStLTnh5Tk8rVFlkY1dCalZndVVGS2Rm?=
 =?utf-8?B?ektkUnNWUzQ4WGhxTUFhNytGUytvMnZ3RlBOWHdiTWsxajk5RjJtK2dTcDd1?=
 =?utf-8?B?SFFuYndnSWE2ZzhJNE9JNjFKSkdnd2dsNTdNSm53bkVYUVU2bXlydGwxaVlS?=
 =?utf-8?B?UHZlekd0bWl2b3hvbHcydlNPTXFFRkhXWWc0L1NKaGhWbjBTTkFQOEF2dGdn?=
 =?utf-8?B?c2NPR094M1Yya0o1Q3hwVVRuVjcxVkFLRXBvRVkvZTI3YWsvbzZnZDdqQkl6?=
 =?utf-8?B?T0J3eTZOaTFxeHR4U3dBSTdvR1pYZzNHMGtGSm5aWDNSbGdIcngyQUtwak5M?=
 =?utf-8?B?OFZpWFlWUkt1eFVoc01NVmIzVmVoL3dFaU1hTlVFaUxmTWdWNlNLVXpyMjcy?=
 =?utf-8?B?SEVuT1BUKzlwUUhMbVk3ZXpKUjJqT0UwRDIxZTZzZmJvTC9xbVJHWUdYb0RB?=
 =?utf-8?B?TGIrNG0rNUxZWUVGWW5nQ3RCeXVjVHdnT09TRFNzYllIaXoxb21xbjE0L0Fi?=
 =?utf-8?B?UnlENGlaOElwM3Ryc0srcmNVd3V0ZXNMZWhMS242ZndVa3FCZFJaaHpYZFZ5?=
 =?utf-8?B?VmVuUGJ1T0VNd01MVG0rVEgxcWE5Q3pqdkpOb0RoWlpGV3htSC9JMWx3SGJw?=
 =?utf-8?B?TlVRVHJXazFycHJMb3BUY2t5YXNRPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 03:32:49.8088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a229bf6-a839-4e46-ba69-08de5a301587
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6847
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


On 23/01/26 00:33, Marek Vasut wrote:
> On 1/22/26 6:45 PM, Tom Rini wrote:
>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
>>
>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>>
>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>> setup_multi_dtb_fit() when locating the next available DTB within the
>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>>> version v1.7.2-35-g52f07dcca47c")
>>>
>>> The mkimage tool already supports enforcing this alignment via the -B
>>> option, but users would have to specify it explicitly. This change
>>> makes 8-byte alignment the default when using -b.
>>>
>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>
>> Tested-by: Tom Rini <trini@konsulko.com>
> Doesn't this enable 8-byte alignment for everything in case a DT is specified on mkimage command line ? That doesn't seem right ?
>
> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to be 8-byte aligned, all the other blobs can be 4 byte aligned just fine .


All the mkimage flags are parsed at once and populated in the params
data structure in one shot in the code. There is no separation of code
specifically for generating a FIT for a DTB vs for anything else. We
would get the same result when using mkimage -f auto -b ...dtb... -B 0x8
I think we should be fine with this limitation for the usecases when
generating fitImage with mixed images. Unless you have some idea?

Thanks,
Beleswar

