Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8266ACCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 084C983852;
	Fri, 17 Oct 2025 17:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="jEYWvUig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818AB83826; Fri, 17 Oct 2025 17:26:46 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CBF83852
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KroKciRqy/5W4QPPTbxzSHT/vPSPHbfn8MBcsTo97d2xGUzoBIk+Q3P/Lm5+EK5hgrjGcTUjsK07hYhrWpW9gRG1OopnYhOXZ+ULj0jVjYP/REV+qZK08fjckyU0jB5dfMFFubY2/BCSeaFtkQyJ2J1K9lbvef2XJIdKPVK46UjHRhcuUVD+ou/aK956uUZ4/788nPSDk5hf/yenfM0RbxGBmXDqSSMr2IV7Y/ZUGzssM3JjUyMw1dRwMU+Ecp/DCDF84GbyfRft4CaH6QzZEKWZ7MbfKUT+6uXDk1f3zwJt9ZZ3YkC3L7DpiFzG73T2ZlvEpba9wyOf5Ddi36ERSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOs98k3BHeu1SI0ERzqVqKdzCjlvufFIsMXFZv3btYo=;
 b=yMgPsRRw+E5YQMYinDNPy6uaSluyg7z+UsnpYlWq5zCpHIg1UEli2XlN8Nk43zYD6msb2/RuMU3zQh9O3OA5yehO3GiTwLyCZoROqxpGnU0tikogOuqJpBkLZ/5pKA/1GGxgP2238wOhj5JTdQpRcRLrf9ZTr13Jy/To6SGzn8gq6BxAxnJBhBegcIm/VWU5oHO/D1vs7jNynwB3UAYqJiSpCOlZ527fVCBUe0fwFPFLrAXiKQbjUHTCwWih1OOc6Id/UYWH99QBIZleLLRiv27/7nYar9FRkeTftENRxKCrL8lnWIyeNFD/8yL3W8OKNeMsM/evMmCxxBWU7Iw0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOs98k3BHeu1SI0ERzqVqKdzCjlvufFIsMXFZv3btYo=;
 b=jEYWvUigr1b41CA7P3sKaA2cpjoDeuqgFMP10qXsTMlErqXLJiR5P5POwmnIrxGzU0EZJwyi/wz8y7NAoba0OuTIrQ6mh9NUAkp2xLZFPKxLMCxjs3OQ0SjVVdRCtwyhg1GC9AEI0x5WGTOVo9W/K3/j8Y294aFX4zkWgtp1eZqD/1rfLqKXYiTnZvJZAkeg8GqcRipvt6ND+qycnhXLbFAyUDBHpJGmBO0qg2RTqnZw2196vV0x+SLYwEwhMK1QjJzXZk4C14W4UzyI1t9hRierg4PL5cEu9uLNY9dejLlQH1lNhJFCUh7ml2B3SG+50XW7tsPQWbyGCdWevpJHYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MRZP264MB2085.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 15:26:40 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 15:26:40 +0000
Message-ID: <41d219e7-9bdc-4888-a4cd-582ceb35dc3e@softathome.com>
Date: Fri, 17 Oct 2025 17:25:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFH] Future direction of the U-Boot project
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250602222738.GC100073@bill-the-cat>
 <705b32df-451f-4be9-aa09-4bcdc0cb3855@linaro.org>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <705b32df-451f-4be9-aa09-4bcdc0cb3855@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0169.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::13) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MRZP264MB2085:EE_
X-MS-Office365-Filtering-Correlation-Id: 92868dfd-33c2-472b-147b-08de0d919186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K05mRmxpNXNIMFBHUUk3c1dMRGdlZDAwNEh0UGFzdGxsT1NSMmlyVUEwcDVj?=
 =?utf-8?B?WER2Y1NkbWRJZ2dDOEZRdUVsVHBLMlM5aElSc0x5Y3NIWlRwa2dzeEUyeWds?=
 =?utf-8?B?SVFDbFlpYXVQRHVmc3hnQmdvY29ET1RBVUtMalBEZkFyejJHVlZCMEYwZG1n?=
 =?utf-8?B?OTgya3FpRmhib2t1YWtOTmlIcHhSWXV2VXRlM2E4MkM2MGhMQnNMVTI4a0FD?=
 =?utf-8?B?eGM4L0N4TEVqZmtNSzNuSWNMZ3Bkd1NvQUVVcXFMSGQ2WkI0WkM4WEc5MW5I?=
 =?utf-8?B?ak5jRWVZT3JYdHFKOXFIUnlVWUdLZjJvWmZXVzVnSHZROTRNQlBPWXdONzVp?=
 =?utf-8?B?MFNEcHhoZmltMDRtdnRQMEloQkVzbXUxbHdXenFrNFlldDNuZVhUdHJKOFVD?=
 =?utf-8?B?VkQ0MDRUdzhDOWNFZUc2UjJ6ZHBmUmxXV0ZFdUkyaEwrMGJ3cWhWaDBGZFVp?=
 =?utf-8?B?b2dIbkhDWmhHTEZuSHIvVEJJK0p3cnRCRzUrK1lDUkNFSWNKdG5iYWlYa0E4?=
 =?utf-8?B?NjV4QisxZlltZVBTd2RlMnlOZ0tEdXZFMUxKRzdkSG5NSmhldGR2MlNNL3RC?=
 =?utf-8?B?L01DVFFDTWE0dkZKRkMzUWJKSGQwL3ZPQ2RuYjJGQSttNm5pRDdQTGRSVWpl?=
 =?utf-8?B?RjlYYXRMVk5JQVFaeHB2UDR3VEZjbks4dkFESThyZ1lRUURIVXBFV2piU00r?=
 =?utf-8?B?VnZGZ1NFK0VFNjRXdTFtdE4zZTlsNzZJamRMYThlK3p1bXhoVjdreTBPL2dY?=
 =?utf-8?B?Yi93c2c4RkJCeDNUUDNpcGR0ek16S2Vydk5sMWVUekdZWEZBQS9WblJoSzZ0?=
 =?utf-8?B?bzZyUUJaelNvelE0L3FNVXU0N3dxOFh1b3A0SENBTnlwVEZxUmxpbGRyM0Zy?=
 =?utf-8?B?ckxZVy9xT3R3TXNHZEx1aEFQUFJlaXhwM1pMV09EM2t2QVBQK05oQVMyVXZ0?=
 =?utf-8?B?cmJPUm1KaTNyTHlrdkxrSmEyMmVBNmZIaVZBL0ZrYlAvTXFmZ2VoN2RZRURX?=
 =?utf-8?B?QmxNR1RTcExvalpBNXJRUFdOSE55M2V6WSt6Y1ZzcnNxbWVPWDdVaVRNbFlk?=
 =?utf-8?B?cko2aC9pMzJyRVhHR1djMzNUREEzK3lXY24zLy9sWDJiQmgwN2UraVo3Tndt?=
 =?utf-8?B?SXhmL0Y1UVZzMWZVTGQvUUM4TVpUTlhiMERWajUrQUZOL05SOHcwTHJXVzls?=
 =?utf-8?B?elRFM0VzOFVSWVI1RkJUZ0Zzc1hhZlQ2amNkVEc0OUJTeFlUeVZlRUpKUnky?=
 =?utf-8?B?UUNhMUVkZ1p4bXRTK1dtOTlzT2lnSTgwZkd3cFBkSFRMb3lSWUtCdFdHSk81?=
 =?utf-8?B?aDUyOUxENXl0SDMwSEF5UVhXejBnSmpWTE5tdGJZNE40MUlRWlhWYThhd3RZ?=
 =?utf-8?B?b1dTcExXMkJHeElhNkQyelNWTW5YRWFTa2NUTDN2eExKcVpjYlpUMmZ2bWhU?=
 =?utf-8?B?SWt5ZTZOVVlGd1pRVVQyT1M4eFZiQlJORTY3Y1FnZWRqYWhCRCtWRTgrV09z?=
 =?utf-8?B?c085ZE5tVDl1djJ6U2VSRzZRUkpiQlIvMHExTWtIUGVGWERHcEUrZEpscDVx?=
 =?utf-8?B?WHI5MHpucWZVeWtLcm1TV0FzcDZRUFQ5VGRMVUg5eU9ZOENJODI5UzRhelJt?=
 =?utf-8?B?V0hrWnA1Z2RsYVo0MHVqYmdWOGVBSHZ3amw0Wkx3cDhCMVRSYkY2QUFBYTBR?=
 =?utf-8?B?VS9iOEEwb2Z3a1Nzd1lQRkdmK3BUV2UwSEVOaHg4TnZRTkF1YmVqSTlnRlNy?=
 =?utf-8?B?RFFnNXBvRUlTalpFV21UbUFBQnY2UURUTGFhOG5hMlVzWWtWWG15OUhZb29n?=
 =?utf-8?B?OVhkK3piNWwvNzVvMnh4YnBUNmwvM1M3TW5NWlJXOVZrLzROVzRSN25WSmJm?=
 =?utf-8?B?VVhMSWtWQVlDWGhiRlA3SURlNWRRUnNqemFDcTNMTEVjS3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldCMEtMd2NGZk1XS2xHTk5OTDhJWWhFaDRRUEV3cEZJUTcreEtjNHRiaVVv?=
 =?utf-8?B?OXl2QnozbVBqODAxdHpsaldIWmNIUFovZWdDQmdqaDRzUFlkZHRzMVFUaDgw?=
 =?utf-8?B?UHM5VUhEc051VjgyYXlEcDF6dXB2Z2ZrWHlHbllSTHlQVEFLMDhpMWNCcEc2?=
 =?utf-8?B?dWo5U0kxVC9vcmZVKzIrLzVZN0FHdnh0RGhBOTd5SWczZGhKWTBuVDV1RFU5?=
 =?utf-8?B?UThCYjcwSjIxQi9tblh1MGpYMisxMVRUVnVpOFNsNUxadlJvam9tdE9ldmt0?=
 =?utf-8?B?ZC9ab1RXbUdqK1F1RTVFTmZ4M1QrTmJESW5VcktyNkN1R2w1RWs0RUM3YkM2?=
 =?utf-8?B?SjdqMmd3ZnFMb2gvc0sxSDltbDNYMUZ6VEVSUnZDZ3R3ei9Wa09nK2VkdzFP?=
 =?utf-8?B?T2p1SllZQ2NSWE10UkFSYldMcjNRUThOUk9aZmhNenJvdkVzMDltV0E4NEov?=
 =?utf-8?B?Y1BsTXFPMm0yd0dyczY0TUYzcWV5VVpUM3BmWUdibEpHRmVja3RNVW9mSTJ1?=
 =?utf-8?B?Sm9wYjJ5b3NRS0Z0VHRnWHNYMlkraVZlUVAvSkRFc1pVdDlNRU1Gd2lmMEhP?=
 =?utf-8?B?dnFyMGJnbXpVVXpJVkZHaFR2R29GdmZURjVDRDlVdCtrVllDVGxKUVIzbmdV?=
 =?utf-8?B?aUZ1Y00rbm1sWk9vc0RNSW5JV2xVU2dCWDFFaXNRc3k3bmEwVVBXdTByeFRn?=
 =?utf-8?B?clpQQ2h4MVZIckVBYkd2MlhyR25QYnBEcUpzWjU0SUVuTWpnVjZUaVZ4U0VZ?=
 =?utf-8?B?cEV2clNLNGFmdGxIRzR3OTYvVGg1WlRvVmx2MFVTMGdvdFpFN01DaEJYYTI2?=
 =?utf-8?B?aGpjL084bldzVVJLVldzdStnUVd5MDNDN05Wc2Q5TERWdDhZVjVlRDlCb0R1?=
 =?utf-8?B?K2JxV01kODFzbFNUOVR5cUpYK082cDdMbVFlRFFLc0xxaGcvSDlVSzZPN2xY?=
 =?utf-8?B?YldmU3Fibm82NjdoRU5ZMnYyMU9JNE0rYjg0bjRGM01Idm5UUGdVNHdhVDhV?=
 =?utf-8?B?b0d0V1Y0eVRUcWlrV2s4M3RDc0pISkNlaS9KcDB6K1JFUjlwa3UxbU5za1M5?=
 =?utf-8?B?bDhldXZaLy82WndOYWJ5eHIzMU03KzllK1pqM282SmFCc3ZOeStrUHNta2Fy?=
 =?utf-8?B?M3ZEdE5lTlNhWkVTOUJsRkZFaitwd0UrQmMwUlZoUmVHWHFwZFlTZXNtYW5H?=
 =?utf-8?B?VmdqNE8weHc1V211WmVPVVdyaWlHVVlxbmJkOW5HMlNiRFhjbkJyQ0VVbWd2?=
 =?utf-8?B?a285MHdKc1NLQ2VlUldCRHdPNjRuTnN4aDZLbHY0VXo0MUQwWlhYbzlmYm1D?=
 =?utf-8?B?OXUreFBLY1duV0lHblJTRW9HZlJOcHBKcmhQeHBodDR5UWVPVHBaam85YVhk?=
 =?utf-8?B?ZXA4NkhwVS96eGtHVUo5dkw2b0xxR1NLRVQxeGp4QzZHQkhLcC93M0plUDRG?=
 =?utf-8?B?LzZlT2JqdVcwUjR0K0E1VURyMUI2Um5mcUFoVnk4eHFWczJ0bnE2bDF2N3Fy?=
 =?utf-8?B?Q003ZFd2ZVIyTWNlWk5VYUdISzJmeW51bXJ3L2xPT1VScmpoSFJKRHQ3THpo?=
 =?utf-8?B?dlkzRTJ4Qld0MGZ4ZWZWZmhHWFMzSEc2NzcyNDQ3YStjZ2ZIUTZlWkQwaTdo?=
 =?utf-8?B?dG5tYzBqbk15ZC9FdVR2eURhVzVHZkpmUGJnVW1wS0ROZW90RUJvRnM5OVFR?=
 =?utf-8?B?cXJBYThMbWJGc1hhT3lhWnQzVWVLVVEwRllaYkxyUlN6Um5UYW1DSVQwYUZn?=
 =?utf-8?B?RE9TWUpheklwcnUxTEdjSVVMdmJWcHl4VDg1Z0pINVpJWmtveU9XZDlITlUv?=
 =?utf-8?B?ZStML01EMFFKNXVHbnlaY3JPNUFlQk03ckNSWUpWSFUvV2Q5bWYvbFo2UURM?=
 =?utf-8?B?ZitxeExGU1BvMjNKYXpBWWRiOHdTUElXR0xIRkk5WFlZcGtKMk1rVThNQSts?=
 =?utf-8?B?TUZxcHhiZ3dtQ21MV3VtT3JscmRvYUJFYUhWYTZXOFVPSlBUUHJmMlhkME41?=
 =?utf-8?B?TVBHL2NLcjh2VWpPcVNDZXlraThMM3B1Z3ZtOHpSRlNHK216SWNlYjNHMVdi?=
 =?utf-8?B?blFQbUw0UExtZFIvM3JzeC9pMVdnTVJLMFBxTlBzUUZjYkNxMzZQUEFlWkhV?=
 =?utf-8?B?cENIZlN5d2lXa1FNRXRUYnVWK1ZnZ3RMTXJrMzNUSERvb242V05jMFJaaDY2?=
 =?utf-8?B?SmdGQ3VoRU9BMDZ1emRrc0N3RXEwZmo5eVYrSlFMUElCZjB4ZjNPU1FpSkht?=
 =?utf-8?Q?Xj912n5AA8eBRjIfSeGXZGvOV5mPgB3pZ/l1TUOK3c=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92868dfd-33c2-472b-147b-08de0d919186
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:26:40.0970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR+YE8n2ByMApQnrjXKsuiBzphCK4TSyfiinPO+/9ye2ddKge+FyCdOCl0TeNRjd5Qej/2SJTVNpD73YEH0l8x5RP8K8mWh8aOXZma/MRiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2085
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

Hi Tom,

Le 22/07/2025 à 16:01, Casey Connolly a écrit :
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> On 03/06/2025 00:27, Tom Rini wrote:
>> Hey all,
>>
>> Something I've talked about in release emails earlier this year, and
>> promised a follow-up on but hadn't gotten to yet, was how to manage the
>> project moving forward. The email I made last week about Simon also I
>> believe highlighted some of the problems that we as a project and
>> community face.
>>
>> As a starting point, I want to thank all of the people (and companies)
>> that have been working on the project and doing the less visible but
>> important and expensive things that need doing. DENX has been running
>> much of the project infrastructure since inception. Currently, all of
>> the fast AMD64 build machines are from Simon. Linaro has been providing
>> two of the 3 fast ARM64 build machines (the other is from Simon). Our
>> patchwork project is on OzLabs group. A number of years ago, Simon
>> picked up the u-boot.org domain. There's likely other things I'm
>> unintentionally forgetting here.
>>
>> So, what are the problems I see and would like to get some help and
>> guidance in working on resolving? Well, in a lot of ways it all stems
>> from one root cause. The project was founded on the "BDFL" model,
>> which was quite common at the time, and a relatively reasonable option
>> too.
>>
>> But now? It makes getting resources harder. There are a number of people
>> working in the background now trying to get things donated to the
>> project (thank you, again) but I also know historically it's been a
>> challenge not having some distinct entity for U-Boot. Individual
>> contributions are best done as "I have a server" or similar. Conferences
>> are a strictly individual thing.
>>
>> Then there's the day to day parts of the project. I feel like I
>> shouldn't complain about taking vacations where I just handle pull
>> requests and not patchwork stuff too, or only doing a few things on the
>> weekend. But it also means there's no real way to handle contentious
>> issues other than what I say goes. Which isn't ideal.
>>
>> What to do about it? Well, I've talked with the Software Freedom
>> Conservancy (https://sfconservancy.org/) (SFC) earlier in the year (and
>> before that, years ago at conferences). There are number of open source
>> and community focused projects that they provide a legal entity for and
>> help with administrative things. I've personally been a fan of what they
>> do, and donated yearly for a long time. I think they would be a good fit
>> for the project because they do this kind of work for a number of other
>> big and important and community centric projects. I would encourage
>> anyone interested to look at their website and look around.
>>
>> But that is something like step two or step three. The first step is
>> that I'm hoping some members of the community would like to formalize
>> helping with the project. SFC can help us with creating some
>> organizational structure for the project itself, but we need a few
>> people to do it. And before we even get that far, help with the mailing
>> list moderation queue and triaging patchwork assignments would be great.
> Hi Tom,
>
> I'd be interested in helping out too!


I know  that I wake up very very late, but if you still need some help, 
I am interested in helping too.


>
> Kind regards,
>
>> Thanks for reading this, I look forward to finding a sustainable path
>> forward for the project and the community at large.
>>
> --
> // Casey (she/her)
>
Regards,

Philippe


