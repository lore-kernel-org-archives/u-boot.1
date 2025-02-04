Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2704AC02197
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 16:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519CD800B3;
	Tue,  4 Feb 2025 17:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exOCapan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0533801BE; Tue,  4 Feb 2025 17:24:36 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6261C80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 17:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHf9h8lan86HISwZEmsSx9F8uoLxcYp87uYRPkY73EZfdaiE/GOFe+D9sIRrGd5r7KWTrxnaglw44OPzzLLAxYC9oNyqRBYmW1wSvnl9P3uwljy61OIMvdzT8FXk1naCsUYymvvDsA0q+o6SY6mqxP8f4or+P24ThxET+rT/BQRiQfmq60cSpehqrCp5OQ4xgMJXuFxVo21P2XwLLJ89xUI/itnUFWfSdNRjmp9d/ImBwNnVPax6reiNZFKJA+EQNOD01yLxetPv8ohXZDE+kDZO3pAe3u8dg9MR3JQrPMEYBWSm6AY4zwZ6dZASE1dEkwdfI2+sbUqQgNPSRyFvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRJ3/C6kK9k2GN1V6d8YNYJptbJJlUlpOm88RNT87+U=;
 b=naR/22Cwip7b74fAs7SZZ51VvCt4rXlusYv2lxYmkzEH8jQnir7wQ7P/LeIBmlkUVPZy/Nkj7Ybtk3uGJe6385kabcybrKVlsWKldQBTtpReUe2co6RzrIgIyyvr3vkyyVxdAGdrR6X0acdv9zmF0V7kBFlli/sRAneKYJF58XaxnDbvgRMeV2+aoNqDJ8DGDfSErKeZYrxMQSyx7wDZHIP7usjSnkGjOE+IqEl9ZEf8+W4eb8d908RC/DGkHzZZ3EnXJyqto7fPH2g9LUFFS7WWWBbbKIq/FCHyXL5Bp0Yzze9NVlYU2uymJB9PGO0jiBGJyQ7JbkP6owVv6GQFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRJ3/C6kK9k2GN1V6d8YNYJptbJJlUlpOm88RNT87+U=;
 b=exOCapanMQtbD3IAJFs4pbY+hhHWiqP+BQIbcWCwCjHRJ3K4k8JhoMrAtuDe5Tf0F6moOUGtkR+XjhpY8FjchMSWQCY1P4i+sPEzhkK9p0CApvR3/fmSxA8a2KGi2A+xYsUdPRRaQT/K4WxxVyohFbt3enqemBM4U7nbOhRf3x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 16:24:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 16:24:31 +0000
Message-ID: <881e4dbb-a80a-4ce4-a944-5461b72083d4@amd.com>
Date: Tue, 4 Feb 2025 17:24:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: Kconfig: depend on DM_RNG for WGET_HTTPS
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Adriano Cordova <adrianox@gmail.com>
References: <20250204160051.3055038-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250204160051.3055038-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0151.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f240905-c07c-4110-e6b7-08dd4538674d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFNBbDhQYStpMDJzVm9nTmVqWHBQem52clZGQVZteG13ZVFCeDJxQnFNYjdv?=
 =?utf-8?B?eHVOS1BNNjYzajFidFU2Wnd6L1puUUROS1hkOTU5ei9HVVNQL1BjTUxhSnNU?=
 =?utf-8?B?TnhQT3d1SEtLOTZBaVgrLzJWKzhBSmZMSElETWZpZWNkbHhhRUVES1Ezb0o1?=
 =?utf-8?B?ZFhsdjJ1WUVRdzZUV1JNTllCcnVtb2JrN205cUY2N1pMU2NQRUVVdjVWYitq?=
 =?utf-8?B?dTd4VnJRSWMzU215Mzd6cVpPU1IyaHpYRHdoU3NjYlMwMzhCZ3hQeTl3cDB6?=
 =?utf-8?B?SVhmS0VTUnhMT1JpR1gvOFVaYmpNMlhUM1dIb3Z6TUxYM2pDazFnb3JIMU4x?=
 =?utf-8?B?b2xGZVFkWWZ5Q2J6RjhsaHRaWFNiYlIvRVU3emRPUkpHUzlTWnhQNFBCcms3?=
 =?utf-8?B?ZDF3N1RrdHRrWlAvWElRWnBDUVJEQzlDNXRML2ppTEVHZkRHYVZqWE9Bb2Nq?=
 =?utf-8?B?UWw3d2lsOHBWZExENmIzUFFYZGFLcXRkME5KRUtJeS9vdjRnQzFGaS9FVzhX?=
 =?utf-8?B?L3NodS9McTNLOGl4T3NucXdmdERUNmVoSGlnQUJJdll2OG5pNnpQNlAvT1FQ?=
 =?utf-8?B?M1M5Z1cwWHRLUVF2bmpUTzZQdS9hL25wRVBnREp0NUVFSDAyVVE2QzlkNFN1?=
 =?utf-8?B?MW8veTc3NkswK2s2bUgvL3ZsRE5qSURWMHl4Nm9tTm5KSFpUWG1GTzJrOVV2?=
 =?utf-8?B?NWZxMjMrUC84T1F3ZktibVdwM1A4NUM4YnFoMi9xK2dXQ1o1OFVkMkU5bnJo?=
 =?utf-8?B?cGNtdkJ6S0F5NlBHZ3lUckF3R0ZRMHhuL0ZCRGYxS28yK2p1WldMRWlKTDFY?=
 =?utf-8?B?YVJCZkJCTHREYnJDRFlZcU52OUNGUEpIUDIrNFFuNlh5SUNHM3drR0RmREs4?=
 =?utf-8?B?T1NXa0dvV2NvVDRwS21uRzVZRW9mZEpEQm1mSDdLNU5CTkl2ZnVDYXN3UStp?=
 =?utf-8?B?UUpMeTdJQlZQbWZoWEZIRi96bE5pa1R2MDVOdHBxWnROaGwxT0RCK2FKRjlu?=
 =?utf-8?B?OVJxYkxNNWY4RkdtWmZ1VFFnRW5MRXgzV2Y3NzNEVU1zalpxUElid3VjQ2wr?=
 =?utf-8?B?ZkRHQ2ZsVU1PSzc1Q0tvcVNoZUVBUDRDSUF6bEtMd0VqZDd2MXZDTkNvcmFQ?=
 =?utf-8?B?NG05NmY4eUJ6VGJUSzNXR2llZ0RHOTlSdG9IcTRXZ3hEMkV3aG0wdVdCUlQv?=
 =?utf-8?B?MWo2ZU8rNDBYT2lvbU9xQ2RVaFNTd3RHbXpSREp2ZWVyeWJ6UjJTOUpZcU5G?=
 =?utf-8?B?NTRETytKU29UVjVVak92Qm5RdXRoQ2RRa2dxZWNXeVpzWkVMR3NzMlVIRUpP?=
 =?utf-8?B?dU9oNnB6ZDhuWFY3S1ZEL0JnWllqWDg5Z3V0UVVMYm9LeDZJNXlTOVlqRjND?=
 =?utf-8?B?OHpkbUZZRzd0ckRleVpINWlYSjFsTmdnM1dnWDhENDljZXJ2TXNxYU9Tanlq?=
 =?utf-8?B?NlVFS290LzdlNWozczFheEJyYTZrNmowMFUxR1hzamg5OHlCVG1mMUdPVHlv?=
 =?utf-8?B?cHFsWEtGdTJMcU5lTGtiU0R2SFF5eng5WVNHSDRSV2JVSlluWnFsNHlwUStP?=
 =?utf-8?B?dW1NcWhnLzY1NHM4ZFBPRWRFdVJRNjI0eUN3NktpSk1mQjdvV1JUTEdlMDNP?=
 =?utf-8?B?akdiU2hxZGpJdUtMb0xaTVA4R1Vrd3dwZjNJZUYwcWJ3YWh1RnA5cFYwdkxk?=
 =?utf-8?B?NXd4S2FJbGkvYVFhNTZhUWZhZ2pzVytMNkViN2xjcmQ1a0htWG5CZnZ0cGF0?=
 =?utf-8?B?WDAzNFpXR1FNb01iNVVVQjBYaFU2eHIwMXBPaWVTRURzTlF1OGFKM0wvZGRy?=
 =?utf-8?B?aWxVejQzVk5GeElocG1kR3JNaktqYjhLOXJ1ZkFSQ3VxdW9PYU42SHI5MSt5?=
 =?utf-8?Q?L4tpNY/xPqNmo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NOVFVkQXBndXV2Rkx6cVNNakYwSXlyZjVzQ1VaS1Y0S0pyYSs4TE4xbWRj?=
 =?utf-8?B?OFY0ZDViTGVIOWRncnpHazV2ckJpbW9vNWhkK0FJQkFQUTBzeTBSRzA1eUFk?=
 =?utf-8?B?T29UZ0huenBGOVpFZGNYaGJFVytjamVLK0ZxYXByY0JKMVJCb20yOWxDTnpJ?=
 =?utf-8?B?ZFFkeHpsN0hocUxvOGl0dVFsM0F0Nk5hd1hjQkJHRnZrM1RqQlkvbVZ2Rmpu?=
 =?utf-8?B?anpGVE9uOW9keDgwdlV0TnhNa2RmOFlTczdveTJORkJDNitSUjFmb3o3VE9P?=
 =?utf-8?B?ejJqYzMvYjNIWCt6ZkVFZkhMT1hSYmpmY1ROK2xvWXJGRVF5eTBuS2FBclIz?=
 =?utf-8?B?cGFzN1FqeS9FcENDSldJV3ZTVXJSVlpWN1BqUUpXc2FmdFVtODF2R3F5WFNx?=
 =?utf-8?B?ckpwVG1xZlFDYnMzdExvek04amFzVDhMeTV4RWsxa3IzQlFIdUZIVUp2YWJ2?=
 =?utf-8?B?Z1lYTzZ4a2I3aVlyc1dWU3MzcjZCV2tRNS9BV3psbVZremZYVGFFaTI1ZGdR?=
 =?utf-8?B?RVlXdzg2eUtVR1Q2TUoycmFVYWxQT0s0YVZ4a20vSE1wRDhyOFkxdjJ3VmZG?=
 =?utf-8?B?QS9rVUJJcTVPazl1a2puM2tnaXJ6N0t0U3E2cG15eExMR3VrYWZtTzRYY2po?=
 =?utf-8?B?Z0FoZkhSclBrY1Q5bUptVTFlL3ZRd1F4YksrVkpsMEYyWWZHeElsRERhajFK?=
 =?utf-8?B?SUlLaEx0T2lEaEQ1dW5zdzNyaVRjVmNKc2dmUmZaK0ZlZUlROFdTVGlxc1dy?=
 =?utf-8?B?VXBhdFRkRE5KYmpsV3A2Zjh1TVVFTzBDRHF4dVlpTlJoV1QyUGRoRUM5Y214?=
 =?utf-8?B?cTl2aFVPQmVUclA4U09reVlzdXl1U2F6T25RTmpsS2FIR3ZmZ3Z6Y3lOeElv?=
 =?utf-8?B?My9kemJYM0dFNldaYmttZHlCRFoxZUNCcEd3ZmhQOTBwRWVwKzQrN091ajM5?=
 =?utf-8?B?TjlXWEVZK2FXenJHbHJ4TDNRd3p2RHlFYk5oYUYrMHhSdzdVUFROV0NKYXVO?=
 =?utf-8?B?dnh3OHNEd09ibllyOWwzQnpBaXhVV05vaExWU3FrTVVvc2U5Uzkyc0ozeXM5?=
 =?utf-8?B?VVJobXRNWFdFZ2Y1WDVUeUZiRDdZa3c3V1NVYnJBUnFETnBwTUVWV0RCaEVj?=
 =?utf-8?B?Qnl5ejRWaFJrcDhQeVo0emxuKzBDR1FFVnlrZ3hnM1RKWWU4d1FhTm1JN0Z1?=
 =?utf-8?B?N01jdDlUbDdWQVY0ak4rZEZUOGZOc2xOREFIU3BIS28wTytkdGRLOHBkbVpo?=
 =?utf-8?B?aUVSTFFwMkNTbDhxZUpjOGdmMG9OMkwxcEpiK3NsTTJmUVM4OEVNbUtyUEZk?=
 =?utf-8?B?V2h2V3RQWGtpUzViSHpzd1k3cE1SRko5VzN2ajBiV3oyUEJNL2p4cjBpOExN?=
 =?utf-8?B?U1U3L2lPK0JaWjU2T0ttaWw3OVMrclNKMlpQYlo2QkxCL1hnQnNBaCt4OGs2?=
 =?utf-8?B?ZVdhV0diYVZtbmFEdTc5NkdxT0hrdmZJbTU3S3pzS1duMExyaC8vNlJaVlNo?=
 =?utf-8?B?S1RRQUphY3VlYTM5dGFkK3liVXJsTzVGK1lwR2FLSTkzOXV2YkExc1pFMW4z?=
 =?utf-8?B?UDVpSTBZeEJwb01lMTB2b0pjTjgvUFpFMitDeTc0enlXcXFBVWNzRnZxYVND?=
 =?utf-8?B?UWgrTENYM1RaUjZ0TTRqMzFZeitOUmdoKzA5SW0rNlBaSVg0N0ZIelJFaVRB?=
 =?utf-8?B?Ym9RVEl5bU4zckllL0hLQlBrTkFPMmd5dURiVnEzS0I4N0kyVUpMVFpPV2pV?=
 =?utf-8?B?S3lhUWdORUlaOVlvRUNBaHJaQmZVbjV3M1k2WXRXUkxvNmp2SlQrZWpPYmNu?=
 =?utf-8?B?LzJaNjlueXJGK2JPdVZDUUZuRkdPREVPUnJaRUFwK3RjT05sU1JrdG82RTFB?=
 =?utf-8?B?M3pDeWFnVlNpdFdlYkwzNS9jMTkwSVBpYkhHSHNvZjI0NCtNVVEzMnZ2WUJQ?=
 =?utf-8?B?RFp1R2JnaVNwb3RlY0k0dWY3OHF1NkphdWhKRWFRTkxOYXVSNmN6V1Q1ZE9I?=
 =?utf-8?B?b2tMZW1XT0t0TmdMQU5tL3lhczc0dFV1SlZjcFhUUHdhUEJFdFZOVjUwOGNz?=
 =?utf-8?B?UnM1dCt5azBCUHJWVm5uTForWnNWekFqRDhIdjZuU3NqKzQ4Rk95QUtpaDV6?=
 =?utf-8?Q?kqhs2hDtuDxGM+09ooBgRgYbt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f240905-c07c-4110-e6b7-08dd4538674d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:24:31.2532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbUJuyzIibJ9d+rSkbpD7uHnyaCXsGYTrlWzZworkn9lnVsI/iGm9i8zKfUYtQWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
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



On 2/4/25 17:00, Jerome Forissier wrote:
> net/lwip/wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but
> dependency is not recorded anywhere that's why depend on DM_RNG
> when WGET_HTTPS is used.
> 
> Suggested-by: Michal Simek <michal.simek@amd.com>
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   cmd/Kconfig     |  1 +
>   net/lwip/wget.c | 11 ++++++++---
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index e62817bd977..e3fbb7538ee 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2154,6 +2154,7 @@ config WGET_HTTPS
>   	depends on CMD_WGET
>   	depends on PROT_TCP_LWIP
>   	depends on MBEDTLS_LIB
> +	depends on DM_RNG
>   	select SHA256
>   	select RSA
>   	select ASYMMETRIC_KEY_TYPE
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b76f6c0f1d9..de688641dd7 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -433,10 +433,15 @@ bool wget_validate_uri(char *uri)
>   
>   	if (!strncmp(uri, "http://", strlen("http://"))) {
>   		prefix_len = strlen("http://");
> -	} else if (!strncmp(uri, "https://", strlen("https://"))) {
> -		prefix_len = strlen("https://");
> +	} else if (CONFIG_IS_ENABLED(WGET_HTTPS)) {
> +		if (!strncmp(uri, "https://", strlen("https://"))) {
> +			prefix_len = strlen("https://");
> +		} else {
> +			log_err("only http(s):// is supported\n");
> +			return false;
> +		}
>   	} else {
> -		log_err("only http(s):// is supported\n");
> +		log_err("only http:// is supported\n");
>   		return false;
>   	}
>   

Works for me.
Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
