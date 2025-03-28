Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565B7C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC8881E47;
	Fri, 28 Mar 2025 15:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EC43oT5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCEBA81E06; Fri, 28 Mar 2025 15:53:25 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07A281DB4
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1CW4YfLp9Zbr386V9Csnuz5/hl1zyq3jlPO7MGdDXRa0jiDLVGbhMXCTSJUCP4p6sFPOF5upZl8VgPp7aIMkIoEcj+474NKiNf5aF/EFtM0Dffm+toyxEKlxgski5EO2wUkU+DeeFWcCtbwLOG5Lpy5IUHFb6nBpjopy8V3K16KRwGH4kVp1Oa6cdtg6w8qYrwU1pKCw+JnQmnuXjNFaS5o3+WFtPrypak35H1Z15HPidXavDb0LfDVlZLCvXM27CzmTPd+uJlARVmelTagxgg2Et4B2Q7R0NiGNGIFG9qJS67b3iY5OGt+QoAm+4AQMEeQJgBQrFWvEhW6lMbrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyL8YUmMcDhGFAta0GGx1Xk1GcUar4LH4ZqS20LpaOM=;
 b=bM2zAfRFYdQWxcGt0i+ZJFLH2iWimJIQkF1progGFRDeykMWf5WuoHwZhLrk5XQqNo0gLdgUNw3ZaoRpFrmEYPdgR2/e2L423AsREVBdf8O4wL0nJM/7Yp/EBCdTscnaxjBAAzyVcuKg9iLanu7gEw/aw2b2zYKfv1b90MFLeFsFzD2eZqNKLPWD1Aq5jZ1zj0B8DaL0CPdoX1UTYCCdZbAmGHB7K0y1qq9Fxdo4l/IrH2GPYOrd9UT7OPjtTX6RSz+pd1pIxGWCpbPoZAeOL926oMCGeR7CrJSxiExPsqfRhb0N8jdO6+UoGJvGp6L8jA5Swt39U1VN2pC/aoF94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyL8YUmMcDhGFAta0GGx1Xk1GcUar4LH4ZqS20LpaOM=;
 b=EC43oT5MTMAGcX3jrz3f1IzfvlQ+Npensijx90tW7LB2yW9IXPHGK7Mu8TWVfxvtupEmFKV6nQt+fyYkotEirnl8szaXnbMqgqXHabdsicPJ4XGSE494k8GiTITgfXAGsers+6UR5B7+xdWM7ahpSJr9dn/U1O+2W9EoXzRIwxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 28 Mar
 2025 14:53:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:53:20 +0000
Message-ID: <beb3cc8c-bcbd-491e-b35d-f546acf57e2e@amd.com>
Date: Fri, 28 Mar 2025 15:53:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Update the text base and dtb address
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <3ffb6f1f7ff418f01ccc2eccf8a834441f9f0b74.1742461498.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3ffb6f1f7ff418f01ccc2eccf8a834441f9f0b74.1742461498.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 354ef074-a2f4-44bd-de5d-08dd6e0847d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkNMU1cveE5IcFdyL2JjcXBwSU9ZMFhMbWIxZkVxOU1wT2lEem4vYnFEaFZV?=
 =?utf-8?B?Vk83YUVNdmhZbzNCUEgrT0RUanNmdHNUVWs3eXVkYVhBTjJHNjlMc0pZdWk0?=
 =?utf-8?B?aG9xbU9rVjBwNktJZys5bVpIU1ZsdmRUZzRpZEphMTFIVXpQVjZWMUIzVjhr?=
 =?utf-8?B?aTlZd01OT2VORzZNc01TMFJnVGhPQlVDdUxjQkROV2J4bDNJK2RkZ1VERFYx?=
 =?utf-8?B?ZzA3VGVsOTdHQzFFZFRrSDZWSWRMMmt0TW1EMFQzWktFWWlnM3RQNWVzdWsz?=
 =?utf-8?B?Yjc0MS84QktYa2tWNkFhZWJOZHduUkd4ckhwZzRGLzU0NFhnWFN4L3lQOWx4?=
 =?utf-8?B?ajJUOW1JK1VBNUNadjg2bmtzakU0NFJtUWVkTXBncDBVTGVWejBTdkkxY2JH?=
 =?utf-8?B?dVdoTDNEektqZml2LzR4UTZYZ3ZVLzRzR1dXY1VnaXQ1OFdZQU41NDlNblRU?=
 =?utf-8?B?VjZyUEJQMDBLZ3hTbFErT3V0SlpXWUFObUs4SDg4cFNGOHVzR0RBb09PVDZ6?=
 =?utf-8?B?ZVhzZzVid3ZBeG9vcit0VXE3QmgzUEFBYkNWcldzVlB2dUVWMDZNaXJadUpO?=
 =?utf-8?B?T2QzMTE2WW15ZkRJSUdOOW5zbnJTQUwyMWt5TW16MDZZV3BQVWRBZFdXVi9E?=
 =?utf-8?B?NGxFRFVYbThRbmFNOFFqLzlQSSs4ZVNCc2dSaWhFN0ZjanN6Q3RDeXpCM09E?=
 =?utf-8?B?UWR1OVlnd0FPRG9lSThsczM1bU0zeDI3ckZNYUpmbUhNN2lWNlFRNGMxZG5B?=
 =?utf-8?B?a3AxNHIrSnhIeHFNK29VWXN5WVJsUlJBOVAyeXIxUkFrdGNOTTdFWjQ2STlI?=
 =?utf-8?B?LzdYR3NtRE5vZzJIbVMxbjFsVlFNSnFLL3NqbHhoc0gwY2E4VmFacEhkZThI?=
 =?utf-8?B?UU5NYW51cFVncmJTODJqYkhzdWp1RUowSnNaaG9uUS8wSVgzdCtrY1dPZU5l?=
 =?utf-8?B?dDBubnJlak9NUjR6b3hZelBndHJjbThkWmtiN0M5RjVyc1NuSVNKN2N3ZDdZ?=
 =?utf-8?B?ZXlDZE9iMFYwRldrU1lRU3ROSXRSUHZ2eWUyTkl1WCtFL1FnUnNhdWprazhJ?=
 =?utf-8?B?UmtJNFd0dUViNWxUdCtqQ1RWS0ZlMExXMDB1V1NwQ28vMm5sMEY1T3FOWVI0?=
 =?utf-8?B?TElZRG8wZU50WjEyQjJ1NzFEZGkwdGJSaVl6elhtQjdTMXVIQkdKbDNJdmJy?=
 =?utf-8?B?dUIyVFdHVnZGL3VuQWM3SkZ5aFBVOTJCYVBvNFdvZXVXU3hYTGhCaHIyM2xv?=
 =?utf-8?B?UHJwbkpXeTVtVlpBWE40QUxSS2VJcFpEQ05IUTlBR2pUN1U2Vkp5UGpFSHRT?=
 =?utf-8?B?T29VdW0zU1Q0YllTSHBWKzhud21yWW94NHVyWEdxNDBuYnpYSmxhT3REYmhB?=
 =?utf-8?B?enVYemtJdTF4dTdsWTd4MUVIZWdsZGo5QTRxaEFsK3I3TTFtZEduNWZlUHFJ?=
 =?utf-8?B?eUpjQUE4cEt5ZEk5QzdxQjRJTlI3eTZhUnlCZkVkZ0xsQjJzMlZCWXN5ZDFs?=
 =?utf-8?B?eEZsUmQ1ckNnek5oMDNUTDdtMnhlamlteDB2N2kwK3VoSTgxcUZnMXU1cDlG?=
 =?utf-8?B?Y2FDSG5tMXhlNzFYdXh2VVFKaE1yU1Rqb2hRRTZlTktOdUZHV214SGFzeEdN?=
 =?utf-8?B?MEppWUM5SXRHbjljWnM1NERhRzR3azZZUjVjT1V0RXdzUTVDQ0ZlTXQrNHJH?=
 =?utf-8?B?UWdSYXk4MjRldE1tbXBHcG85QkZZUXVRSFdlNGdOSHFoWVJub0M5dzVtR2oy?=
 =?utf-8?B?aWllK1FVcVJlelEyM1ltc1VoZXNlK0ZKWU1ybWs3c2RWbFNCWVdyTFVIcTJZ?=
 =?utf-8?B?MlF4QllUTTRQZWZKWFJkTzYzNzJqNm1tNS8yNTNGcC9TVVg5eFZMbUE0ZHpL?=
 =?utf-8?Q?9GoldauHKvJT/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BUWDFubU5ROEY0dXAxRS9LTGxraDBJYTA1b0loM1pkd0xXL1djT2c0blAy?=
 =?utf-8?B?YTJFRGFXWnllOGJUcXc0OXFMRHg5OHZidE0weXNiUGF2UDFya082RjlOTWlN?=
 =?utf-8?B?MnVNQXJmUHh5Lzg2VkNZQll2R24wZnZUenBBRGpzMUZtRUhUbXVZQncxc2Vi?=
 =?utf-8?B?YnAwbjVscHlNZWdjejJnSERBZU1nR0lTTkl0SkF4ajFTM2ZQSmFnWXdJdElR?=
 =?utf-8?B?RkZVQjA0eWtNcVdDQ3RlKzVtcWVmREtLd3lXTTF6Znd6bVcwdmM4MEg5aUEy?=
 =?utf-8?B?VjJVN1RMT2RwNGluaW51QXFzMUlCRzcyWUNSUUFjbHFIdi9yanZMcnRnTnBo?=
 =?utf-8?B?cE9hbHNEOEk2aWRpVHhtOEhtRU1kRER2QWtJdFYrdFUrbGpSUUUyVG15eUh2?=
 =?utf-8?B?ZnRrSmY4VmpCR2V4eURSekxicy9qbW1VMkJxU0tyTmp3MWtUbkRrWlk4ZFpG?=
 =?utf-8?B?MnhGeVR4NjE4T3pIeml4bVRRdzF0SUdYalhCWmJLT0xmdGhJb202MXlJOW5L?=
 =?utf-8?B?NzBvb0JNS3M5ZEJOMmdRaURmRnNiaStwTUJPbE1LSHVVS05XYlljTk13NzVO?=
 =?utf-8?B?dFV2ZEdEaFNydGhidTRKYVpIQ3VhK0U0c3NkcWpqWGMrNTRtMnNSMWpmM3BO?=
 =?utf-8?B?dDM1UUFvTnJETEpobUozTCt5STZoMUtjOXd2SFJ1ZjdVU1VTL1p4dnU4bEdk?=
 =?utf-8?B?QWx4MVlveTBuWFhHajNIOHp4M29rL0NXRVkzQis2aGxWMVNobytqaDZaSVB3?=
 =?utf-8?B?amw0ZXhQeVV2bURSMkxqOXRVNXliZEhlM2lZRStpSEp0Z292SEtIVmZCRi9C?=
 =?utf-8?B?MjdpV1A2c2pkaFZOMFdsbVdXbXJ1cG1BdDhnT1BZVWpiY0NhZ0RmbEVPUzdE?=
 =?utf-8?B?NkptaHFUTkMzVmN5L1VXMk83NTBKRSttQzNMTk5wdFp0RHdaM2lNZ3laMjlZ?=
 =?utf-8?B?dE9pcW1vUzZnZzloa2R3S3NyTUdvYncwVU94NnlMYTJPQjdrd0hmVkdmcWVE?=
 =?utf-8?B?STlzTGUwMUJMVzBTOTNNOWhNS0ZxYUtsaTdlWDM4cERaZ0FLTDJpczhubmVQ?=
 =?utf-8?B?blA4USt3ODZFVWx3Q2IwOGo4QmdHdEQ0ZHBJTUlQKzFYWmNNcFlKV2dVc2Zm?=
 =?utf-8?B?UDJFNm4wRG4rTFlGallnVi9GTmtDMlFGVHF1c3B6ZnVQU0lGQ0dvVzlMaVFB?=
 =?utf-8?B?dkgxeGZHT3U1T0dHbEs0QzhtaEZkc2Q0eGNPbXhEcEFUdWROdVNwQkpsNmdk?=
 =?utf-8?B?eVU0TzBDbThMZWN0Z2VxMHBTL3dMZ2djc0dVcFo2K0swWkU2WXBKKzFyNTBt?=
 =?utf-8?B?SUxVZ2N2VUE3T2VFS0x2ZVBCVVBZQ21DTkJCTDV2dWw4R0w5cXlKNTFuRWNG?=
 =?utf-8?B?dHRZSWgxVCt2WndSWE5ZNUU5am1KRVI3Y3FCN29scmd4alY4MGZkTktlTHdq?=
 =?utf-8?B?UjJoQi9VYVNJMmh0MnNPVldPNWhjSDkvMGdQMStPV1dCQndEdFlFd0FVc2k2?=
 =?utf-8?B?UjZSWE90VjMxcTl1NS8vc0c0WkxRTE9QcjRmR0tLVk9yZEdwSEZBYWdsRTNR?=
 =?utf-8?B?K0g0UDlWbFlidEQveUo4SERwTExFZ01LTkdVcnNPOENVTm4rT0NlZy9ycnhs?=
 =?utf-8?B?VXc4dVV1dU9vV3dWNWtpRWVIbHVtaW9LZHA5U29HZkpQWStjRFkrNEs0MXYx?=
 =?utf-8?B?TlU2RkUyZHczY3U4cVRUR21Kd1Q1TUUyMEIwU0l4NVd4VG9Jc2ZSbmNuZHVx?=
 =?utf-8?B?ei85eWppNjlFMFR0ZXhaSHZPbUJtSEw1UEFhNHR2am1UdUJQOVFCek5NaEpq?=
 =?utf-8?B?bEtWZlhFZ0tmZnBhTG45Vy9yRjl5RzJ6OFVnNnBOYkRPaS9uUmJaTHJaUHc2?=
 =?utf-8?B?Z2N6VVdvN1JxcHZvMng3aERWT3NaTGdUc01lMTdKZmpRSzRzYnFkRUdPL2E2?=
 =?utf-8?B?VGtKc1dIeERlWlVHREg5QVN6ajlXVEZLOWNIeENTQXVSRHpzdXZrQzRwaHZU?=
 =?utf-8?B?dmt6SE5vdVVyQ2tVeVNiNzZKSG16Z0VsVTFXWXdtQXFoWVFzSmNHM09aYklS?=
 =?utf-8?B?TUgyT0JYYmlJaVRxdVhBSU5YdmpPNzYxQVdwYnlpVUxmNkdmSCtYYXAyWTVq?=
 =?utf-8?Q?LXMY0Uz9W8xDt5kfsnk/pDb/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ef074-a2f4-44bd-de5d-08dd6e0847d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:53:20.3008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic678JXsZye2pf5zROzBsMDIdHuB5YLm9WvKSNi3/sVSAkz6yiZv84It4wRaOjrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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



On 3/20/25 10:05, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> Update the TEXT_BASE and DTB address as per the new memory map.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 59bda4c71fb0..087c7f047335 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -3,7 +3,7 @@ CONFIG_COUNTER_FREQUENCY=375000
>   CONFIG_POSITION_INDEPENDENT=y
>   CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>   CONFIG_ARCH_VERSAL2=y
> -CONFIG_TEXT_BASE=0x8000000
> +CONFIG_TEXT_BASE=0x40000000
>   CONFIG_SYS_MALLOC_F_LEN=0x100000
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-virt"
>   CONFIG_OF_LIBFDT_OVERLAY=y

Applied.
M
