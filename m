Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74201C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 14:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85476811B2;
	Mon,  3 Mar 2025 15:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nvbdGoiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15450811B3; Mon,  3 Mar 2025 15:03:00 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FDF380C93
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 15:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axmYfuWj828r+Hj+oypRmZ4CZbNOlRYQn3oPUJEVM1EPWJopc5jI9j3Eo0pICUopn3c1899TSVsjBrWdiGp3CeU7V6rAC3tYoqao+fQQqp+J5bR7tkgX8APe+Dxwyo77q9TFjQLz0V0sTsI1DreEBU7mmULoUV94hpxUU63UZioWLYCKex7yHSWusJEa9W/kCmt8f2lDpYF35JCQU27Yu7rTI1z7LQcRps6255+OSom9ton46/PqR1JYR96yOp3XL9p2d4LusQqxtwPQDhBCS2yS4QImYXq/Jr87z+KSQh0MJOldrixQp7JWx2nfNXDd0cNWSg51qBLNPQqS9mlstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymk3Tj5f0glAwxDHgYkqyIVBhWsqRX8U4LRnwoQQU3w=;
 b=ZPiki1AZvfDIsyePM/VX0N36qWwHeHx8fuEWVQ4g+241uh154NSFnk/Eu3aNLrlakIXMCE1YZDQetndGGwp34RF9I6ClMOR4OgFhEeWNlMpVEat/RK/J4eFJrpuFeQyuWVmPzYu9xzoK9iRTnFMHFS5Z7GsQnq0GXBGXXduRWtzpbCfIWb8KthOUrDhQkyPtBXPugVDci1BLJEujxEIIVoXRRMtXDRuW5HoTp1gy12ir3af1ZCDUp25cPc3wlO1zBrqTpnIJw9fFKAvabeOcgdQ0WDzOAr1mkeHRw7A2LaTMas/vn1QL7pvAUAQX1iROiE4RS5wzEZwjOjeWqiAjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymk3Tj5f0glAwxDHgYkqyIVBhWsqRX8U4LRnwoQQU3w=;
 b=nvbdGoiw/EqNCg0LW1AldGjKcpaQi/kiabnOtVvDhR/tKuWvhE4HDlcAPnkAodqTpjST5vC+/YivhRKR7rdD5cHViTGIplVoiOmUWBbJ98onZfeaZJOX2DvoTAZqHG9XCb04Ff4c9Xu8ID2+xZmBtgO+kAjRoaxCNK6MK9hQttU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Mon, 3 Mar
 2025 14:02:53 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 14:02:53 +0000
Message-ID: <5a80a075-453f-4497-9643-21682c9c553a@amd.com>
Date: Mon, 3 Mar 2025 15:02:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] xilinx: dfu: Fill directly update_info.dfu_string
To: Jon Humphreys <j-humphreys@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai
 <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
References: <20250226223547.393611-1-j-humphreys@ti.com>
 <20250226223547.393611-2-j-humphreys@ti.com>
 <26b269b3-9df5-4ae4-876d-ab41aec6baa4@gmx.de>
 <1a85dacb-9e84-43f3-a223-5a5aa7e68179@amd.com>
 <84a24111-d03b-447a-b451-e95fe3e7736e@gmx.de>
 <86frjyndg3.fsf@udb0321960.dhcp.ti.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <86frjyndg3.fsf@udb0321960.dhcp.ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0029.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::18) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 293bcc00-3280-4523-a3c1-08dd5a5c170d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFNZcGdXcUU1K21PUFNhOW9PSk43N29tZkhvaDl4cTlWZTNXdFA5YWZqTTI1?=
 =?utf-8?B?Q3JuZ1h6OHVwRHFhUUFFczhoYXp4R29VY0lxZGVVZC9jZWVjaXhJRW1qQW54?=
 =?utf-8?B?VzcwSHFUZEk4Z1ZzYzg1Z1FUUlhRSWkxQWIrY0xpOWJSYUJFUFRBS2VZdHg3?=
 =?utf-8?B?cXdaUWo1SWh3ZVl5Z0hoUU1FVERWTDZubk42RW04QS9JQVBLM3ZZaVZZUmFF?=
 =?utf-8?B?NDIyQzVBaldUTFBjMjhXdTlIMEdqS1dPNTZXazdQMlFnS08zUEhiSGNXZlE4?=
 =?utf-8?B?Q2JEVTRNVUxuMXg1MEx3T1FlNjBpeFVtSjRFcHYxR2RBNmRjZVNPNVAvLzE2?=
 =?utf-8?B?WnIwZTlPckdEN3c1bklrdTUzRFRUcUQxNERNSFU0Y3d1ZzF3RHNCenlMaE40?=
 =?utf-8?B?S0FzQWZjSUVEMy80MXpWaGtpOEtVV2RMRUxHMzVTemVEelZJelNXN3U5a0hz?=
 =?utf-8?B?TFhpWGVBbUN5N2tzSjJycklXSTBoQjBaVEpHeG5Cd05hdnV3ZVNoY3ZhcUY2?=
 =?utf-8?B?dXdNQ2JOQ0tzNmdhckZ6UWVPaS9jWFNnNHNHTFVUSlZsaWhsYWxzZFN5L0pp?=
 =?utf-8?B?MTdqaGpxUTZRaUVEMzZOUzJURHYva0ttZ05mcnU2RUhmWUxVdnlMdGVKK2pa?=
 =?utf-8?B?NURwY0hlZXpnd3pnVERGNWY5dWtuVlQ4R1FCcUdvcEZHcHorZkNFQUM4WTFH?=
 =?utf-8?B?aElQY2luSy82MGduYmllbEo3TXVGdDNRS1RFQlRKUTEzTFZNN0xKTWdNcnla?=
 =?utf-8?B?TDhtd3JqZjJQUjVZWElxRWR3SlYxc0NjbmpxZ0FYWlVlOTJPUDZjR0l0OTZZ?=
 =?utf-8?B?MEs0aFd0eHZVMEtFYmZiZjN3NmhiT2N2eE9ic0tWbnl1aFg3OTI5VlRpendm?=
 =?utf-8?B?b2xqRi9tMWlRczdHVGs3a2NMYVdFMEhKZTBXVkhBdDVpMEVXVHE1Qy9RakVh?=
 =?utf-8?B?MEU4ckFvK1FWNEJZT1hISFN0VmZPUUdPZUZ2ckRTK0o2anUwUllEQ3Q3WFpp?=
 =?utf-8?B?V1BvU3cvMHFOUElmMjdZa2VMSVgvcmZGYVhBdktCVDA5dDlzMHIyenNTQThi?=
 =?utf-8?B?b3llY1ZSRU5Rdm5WbUhqRFdTZVNpT3hUc0VCN3owbklMaFR6R0FHU00rRDQ1?=
 =?utf-8?B?WnlsdWkwdmt5WmF4WW5YUlR4c3E3YzJVWmx3TTNuTUY4VGorU214OVhCZ3Fr?=
 =?utf-8?B?bDVVNGNSUVBWcjNvaXVxaWFmT0ZrWHVhSzM2dEovU0tJR2RVdjd2OXNUYjgx?=
 =?utf-8?B?d1czYTBSRld0SFBOa3JJOE9IdE9RR0tUbUN4bG9IdXdudjJDOUc5eDBnY3dQ?=
 =?utf-8?B?NE00eTFyKzhpWlptSlBNT3BMUW0ydkVLYUVIQ2RKcTlkdU5ZcUlPRTVncy9N?=
 =?utf-8?B?bnZwUHJjMTdOMVphS2hrSGovRHArRVIrTThpRXU1UXgyVjJvelBycW1FekZF?=
 =?utf-8?B?MWwvMGJtNGY5U0YxbFF3RkV4TFlXWWZPZlNCM3pXUGtqS0FTYUd0N3BLRko2?=
 =?utf-8?B?NWk4cDhNaGdlSTh5M0JwTlEyS0pUNDJoQVFKVjkyS0dxVXR5MldlUlZTRGZl?=
 =?utf-8?B?eXpxNStiSGY5UkZGOVI2aGxWTHpvb0p1b3I5c2kxd1Q4OWNJNEUyR1pkZnFR?=
 =?utf-8?B?M1VNWlRrVHZBdHo4T1dScGlRbFM2WHoyZFk1alkwMzg1bXIyM1o4bDl2aDJv?=
 =?utf-8?B?ZnQwRk5FUnZjWm1FTmp0MVExb0h5QzdLSHVRazBYUE9qSnRrZHFoVFNBT1dG?=
 =?utf-8?B?SkhZcFM5emZ4OS8wYnRXUzhmTkd5U3V2YWhWWWxXRTVPYnk2QjZibHZzZnQv?=
 =?utf-8?B?blBuUkxOVnh3TTBxU3A0NFc3L3RQenRKNTJtQWkwMmM4cVAxc2lXcUlHaUd5?=
 =?utf-8?Q?VHabYlyBJ+bJf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRoMkdoVm12ZlltVW93THRqeGU3dmRiQko0K3QvcjVlQlQvbUVnRUtkY3pY?=
 =?utf-8?B?cjFFa0E5S1VrSllVKzdpY0thbytqYzBtQmRpQmNuNDFHQUdpMUl2azhFc1Jk?=
 =?utf-8?B?NFBwblA5dlYydEdYa09yeHhUWU5oTE9vcWpNcng2MEI1N1Fqd1J1UnJXclpH?=
 =?utf-8?B?SU9TeGY1R3JlMy94NFlmUmVIRzMrZG43ZVZxRE9PSVUyZUdOclBmQnJyMmZv?=
 =?utf-8?B?R0l3V2dwa0QybzJhdGdFaWxtRGpCUGg4WUNrQUQwdUtNd3ZwUTk5M2RaaTZj?=
 =?utf-8?B?SXlNcnc2T2tvZEpHU2lXSGhsZ1FiV0E2VGt2SVJkR2I2c0ViR2xqM0ErY1Zr?=
 =?utf-8?B?S3ZLNUMzSk1idEFucE8xOTFKaGNMajUvMUdRaC9oZS9UK0piNythK0tlT0FR?=
 =?utf-8?B?NU1zY2Y0RXA1eWQ2eS9mZzdRVmxMcFo1amdNaC85WjUzQVg3QmxXNXk1MGdD?=
 =?utf-8?B?ZGp4WTY0WVovS2F3QWdtWkNDdzZGalF1bUxQWUVwYnZqYlRQWHBIUXVhNTlL?=
 =?utf-8?B?WTF5cVpPUzhsZ3g1YVV0REVZV3lJUVg5c1dldUtCclY0Zm94WWljNXQ2a0Vq?=
 =?utf-8?B?RTZhbXpscFN0ZWVzZ1IySk9maHQycDJCUmRQek5MY0hMeUI5Q29IdjFteWc1?=
 =?utf-8?B?b016UU42Q3poKzdNeGhmYkhmRDN4ZGo5M2dCem9TVU9MbmVFMnJUUmF1bWhr?=
 =?utf-8?B?ZVpUL0lCV09uK0xsRzlVTlJzVEJxclNhbklNT2Z4aW9KWjVSUHJvUXhlQ0ZI?=
 =?utf-8?B?R2x2SHdmdFFZVnZSWGVQRFVQY2ttT0hhNXdEenIwNTQyVVJRNi9GQTBSYWlJ?=
 =?utf-8?B?VW14TlpvZXdzNUY4R3FnN29BRGNPUXRqRjJNWG9qUDVtdFlZMVU3WXl4SWc3?=
 =?utf-8?B?dmJmMzIwc1UxV2ZoRlFmWC9RcFF4RkF6RWVXTW1EN21qUmxqd3lFVXg1S0Rs?=
 =?utf-8?B?Z0krNGFjNGNVYWsza25yeG1iOE5SZldrcGJud0FYNkNqZ1h3WDdudlpYWWti?=
 =?utf-8?B?Zi9FSnhvRkVJTEh2ZElxdlV4YkFlbitoY25jemcrdEtPSjc0QWNJMXI2WVZ4?=
 =?utf-8?B?V3ZBWmdmRGFUSW9udTJHUDhCelIyT0MwcHl6citNOEJ6QzZEdldmSWtlcG5E?=
 =?utf-8?B?Y0xVZlRTcUx5YnpsZGkvQmsvbnYzZm1ZUjNhY040SzhDcEoreW1SU09CUHFB?=
 =?utf-8?B?R0lFWEEwYmVyRGNqbFkvZldYVmFKc0tqdTlrc3puWlowQTU0dU10eCt5ZVVY?=
 =?utf-8?B?WHNFWEh1cTIvVjlUdUwzcmRnUXRSZmRhR3pZeTZlNzNuQUV0T1R3QzB4Um0w?=
 =?utf-8?B?eXZFcC9LZlRmYUQ4MEZKbElOTkRuK0FGcTRVaU9aZGpaUkw2Y2s2Wkl4dXRz?=
 =?utf-8?B?TzNoR3dPZ1NHSzFUNG4rL2V3ejJ6aHYyK1ZYTXo1YUNMRWxmMDNQUjlMYWE5?=
 =?utf-8?B?Wm5xSUREcEJDVmduQi9jYUVmMFNvT2Jka1VVWTRRNHB0YVBLTHR6Q1htQUkx?=
 =?utf-8?B?UTIvSC9abVQ2WkE5bFBXL0ZGUk50RHU5clNPRFBtSGVxWk94aGpzTGlMMFQ1?=
 =?utf-8?B?eHg5cTJQSzJtYmVnbEFxZlF4Q2xBY2prakt5VndXR0o0UVc2aFR4MnFDODhZ?=
 =?utf-8?B?N0Zic0YzUUUvVHJYYUNiOXpyL2NWUGVEcnZVWmxLckdpUUpjQnBtdlJDLzlo?=
 =?utf-8?B?d0t1N2M5K2QrWkswdCs0Zlk1OVFzTlF1allxeTRZRUlaNkJLaXhJSnBnMUtM?=
 =?utf-8?B?M0tuTWtqaDBWNXNwWjNJN0MxL2ZEbkZ2ZEp5OGhaL0lrQU1wOWVablQ0YUVz?=
 =?utf-8?B?YkJKWCtzR0pPdFBHS0VDLzFWZzVuMk5ZdUhYcUZ1U3pPeHZxWVhSdGo3azR4?=
 =?utf-8?B?YkFYM2o4TGMyUkFxUE16MUdjRmNQNEFnVU0xMUVhNExrU3FHb2VTTERyVVZm?=
 =?utf-8?B?RGExSmdHbkdITTdxNEhVOFdlMGZ1UU1WL0NFb1dWVlpuM0hJblJCMXZYaFlJ?=
 =?utf-8?B?U05mbWxpK3oyckdCamUxbUVFYlNPZVcvbE9tUmZQRk1FZkFDR1dvMW9VeERy?=
 =?utf-8?B?dUdjNExtZkR3ZVVlZzh0NzByYTV1a08rRWdDWGlUQWhiRUI1WGNRb05OSVI0?=
 =?utf-8?Q?qzUgTcfWdvTm7ldD1grDWgg6g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293bcc00-3280-4523-a3c1-08dd5a5c170d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 14:02:52.9791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLvUZ+fa81lVNRIgunywqfc4EXdYZqxoHYUHSMvymSgdQGAQboyW5wUfbbHcHFN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
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



On 2/28/25 19:15, Jon Humphreys wrote:
> Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
> 
>> On 28.02.25 16:41, Michal Simek wrote:
>>>
>>>
>>> On 2/28/25 15:33, Heinrich Schuchardt wrote:
>>>> On 26.02.25 23:35, Jonathan Humphreys wrote:
>>>>> From: Michal Simek <michal.simek@amd.com>
>>>>>
>>>>> Directly fill update_info.dfu_string to prepare platforms to switch
>>>>> from using dfu_alt_info variable to dfu_string which contains
>>>>> description
>>>>> for capsule update when switch is done.
>>>>
>>>> Other platforms only set the environment variable.
>>>
>>> Not really.
>>>
>>> git grep \.dfu_string board/
>>>
>>> beagle, imx, rpi, ti and others are also doing it.
>>
>> But why do we have platforms that don't?
>>
> 
> I'm not aware of the history of the Xilinx platforms and why they didn't,
> but Michal has fixed this.  I'm not aware of any other platforms not
> setting .dfu_string.

It has never been wired like this from the beginning.
In April 2022 the patch
741ef867288b ("capsule: board: Add information needed for capsule updates")
added description for capsules without defining dfu_string because dfu_alt_info 
has been properly generated.

M

