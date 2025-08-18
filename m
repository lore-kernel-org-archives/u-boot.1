Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C5ECA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 07:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E9E82E67;
	Mon, 18 Aug 2025 09:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U2YMZkTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A04833D1; Mon, 18 Aug 2025 09:58:25 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA9E8004F
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 09:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D29JxOQCUwqycnvv3lahf2OuD227/JUNbM5EVwg0aicPg9L+ypDP5NJAWnKF4JrEnrr3qF+IY9LPoc05z2lojSpAhrq7XPeEzvcKHecFbLSJxySpLW+0ESY+gbR/bJ8xMVwb1H/Fl4ZEawNlk7oLTCvF+TMFW3udOHu+0veStIYdWE0d3hlHDFspCUaInHlEFeuAT8R6aXY4XvNxggipGWnM4BowvonVU37yS6MngTwoaW393B5kd6uexFxI2cB9BIt+KL6J2rh+QIk5RtLnO8bY24BKpv7TC+1TYbrEBC/p3byM5qWTcFiPZHOeOQCEa4wyBtT6j54Y1mNnaIrUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCUYYthxXue7xVC3F8iwOL1eVAIzjhTu/15mRCm5IwY=;
 b=esGp+gVf9PwgoQIylLSWhCPSwzeqk0bTmav7qFASfXx91kJr+PJCO6tQzgu//WKG4lFB8ujexy1C5232yXO2rb5tyHmhV4Ty4SLYLaaYXo3j66KFOaqc5/letIHdArXWx8JZiprgbcWxYWk1QMwTi0ITcgNbAiZkN061gAD+x98sBa2ok8H2/cMz13cf2W9hrfUSs/pbA2pRMNMOtql0VqtZzTrDD2430h3grfvyf+NwOpKjS0LoaHqqYyU0fqMjoxXKyxuFcPgKyVW2R6C07bVbocU+/IZ0Y6h8y6vSWJWdWFxtaU6D5K+ozgRhHndAVjDpALzm2tW0zwekKsl2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCUYYthxXue7xVC3F8iwOL1eVAIzjhTu/15mRCm5IwY=;
 b=U2YMZkTw1mbp6qkiS+Y3dD/xd/03gC3HAPFtBrSvDtD3S8S2njugpwp3/eUYi8TwMqDJxjkRP04rS1t/HuR8rZXYf4z6RXXtRvEIiFr3/R9AM9Mftm1USWIuUmMFa0GafS+om1KdtmkUHJyZKQ+rBkDV1SPJXj190zdy3Z2u9xU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Mon, 18 Aug
 2025 07:58:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 07:58:20 +0000
Message-ID: <a79a1ef8-b77a-496c-b780-ff6740c7e9b4@amd.com>
Date: Mon, 18 Aug 2025 09:58:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] soc: xilinx: zynqmp: Fix zu1cg device detection
To: boewingloh.linux@gmail.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Frank_B=C3=B6wingloh?= <f.boewingloh@beckhoff.com>
References: <20250808123134.636-1-f.boewingloh@beckhoff.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250808123134.636-1-f.boewingloh@beckhoff.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a7b93b-60ad-4923-a062-08ddde2cffc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk42UmtCYXhsdWpKazg2VW84NXRBSGtBaXV5eUxBV21iVEZKdU5hTDhMREE4?=
 =?utf-8?B?YmJ3dXpNdFpnZktETlhUMDU1STcreCtZL0tYS0dXcHM3RnBwemJuZGZGVVo3?=
 =?utf-8?B?M3FWTlJyenFQaWpEbExOZVoxSUxNN0lWeEg3TTk0Q1dMQ2ZaVXROaGl4ZHQ1?=
 =?utf-8?B?aGxUV2JTU0dIQ29rR0Fld3NEbFkyV2Q2R1VyWGNVeFlQYm5kdHRQWUgyaDNT?=
 =?utf-8?B?aDBrTUlFR2M3TG1TbllkYVk0Sll3em1xQmhCSDgxUlNrcmN3VGNRUDNhaFVM?=
 =?utf-8?B?bzh4THRPamlkL0xkdkwxbkxPMDRETzE0ejV6UkRwVGd6VGtoUVAxQWV6VHZp?=
 =?utf-8?B?UERLTktySDhOVXdsYmNHOUl6dUlHVHhrUngzTDJZUENMaER4R2lqYkhSL3d4?=
 =?utf-8?B?SHZzeVZLa0VDSkI0cDdXTC83NHVjaU9WS0w5T3AyUmpRcTczS3BQaTZYb2F1?=
 =?utf-8?B?V1dLYkRZNEtEWXU1emgyMDB0VUgwTmZYR1FZcjMyT1QxOVVSVXRMREFlV2V3?=
 =?utf-8?B?RHNzY2RZM214czJaTHVIeXFYbTdubElpNEVRRVJkSndReFJJbzRQdEpoM081?=
 =?utf-8?B?NWVyUFFLTlBBa3N4bit5alRXcitjZUd6dVpCdFdWa09OUUE2RnZ5NDlGQmQ0?=
 =?utf-8?B?VHd6ZnFCNW4vUVZYN1B2cTJjSG5tamxSWkFldlRtYS9kUnRvZnVxSDE2UXEy?=
 =?utf-8?B?R3pPQ01qY2RwTUdzNEhwTmZsNEJVYVpPNmhHZ2VsZ1c5U2UydXNnTE9jM2ha?=
 =?utf-8?B?bFJoUWtsZmYrUkY3ckVUclFzcGtZemZjdjBzdisvblkvYUN1aG0waFNLTHho?=
 =?utf-8?B?cklVL0NVYnc4STN2M2RtSk0yd09YOE13Zk1CekJHUlNSWURYVExHRVlBKzV4?=
 =?utf-8?B?UW1KbEZ5L0w2azkvZkZoNHFQb29MQ1I1TkZCVVFza0ErK2JHaXk2NEtUdVVn?=
 =?utf-8?B?ZFZhSldZNGdIckNVMTY3b01Hdm0vL1VKZEt3WXUxZWlVZWtUTE9pQklXMjkw?=
 =?utf-8?B?dmVJQmFBMlpRcUhMRkU5TWJZTmZFaW56b3gxV0VidU44V2VlVTIweDl1SGI0?=
 =?utf-8?B?UzNvV3pONlBxR1FycHJBWmxmR2FUcVBHelh3d3RwaXdDUGFBZVgvQjFjdnpE?=
 =?utf-8?B?WGovTXExa3RnNkVmOHFYNW4yZHJJR3I3ZGNWSHhXc2t3YlBxRTJhdU9mWVJR?=
 =?utf-8?B?WWhhYitYTHdyYlp2MmZJRVRGU2FPMDEwOTRHTWJkRWxlSkpxTEFScUliV1Nk?=
 =?utf-8?B?MTZJM1FpMHhFSGFwWFF3KzdYWmxuTFF5K2E4UnFrOTlra1B1c3hZb2V3RHM1?=
 =?utf-8?B?UnBZR2NpTFhlSkVnRm94YzZ1aHFuT0hCR1ZlYXBHNm5KM2tZbjZtYVpuWjU1?=
 =?utf-8?B?dktITzM4Ukg1bzVKaHNCbHgrTDVPNWhZTnRPQU95VDFkRWhXMXhhY1V0ZzN6?=
 =?utf-8?B?bE1hMlpQVDFSZTdTQitZRXVvaUhjZDEvUnE4ZXo5WkYweXEvQ1BYRTJlQ29F?=
 =?utf-8?B?Q2F2ZG1nWnZSTVFseE5qZ2txREx5RnIxVm0yd3U4bjEzOWwzVFF4ajU1SUpQ?=
 =?utf-8?B?c0FyWFFTWGFRS3gvRHYrdU1vSDBQdG53bG9TSUVRZmd4djN5WlZZMU9DbFpO?=
 =?utf-8?B?bmlYTFYrVndlZ1dZalF1NXYvV25OMUY0ZEpTcVRHd3hkUGo2Q2N5WFJ1SGt6?=
 =?utf-8?B?RlorejdUTmFyZXlHdU0yaklxdjdyckZHWElJSDRjOVNRUTBnUE1Rd0FhM3F4?=
 =?utf-8?B?Z0cxNzVSRmVsVWRtN05jbjRpbldFR1ZpWkpXMmdtc3Z2ZjVDVlFaK1hqejdK?=
 =?utf-8?B?dWNpek1ycXVhR0xqNGZya3BwdTJnd0V6LzNaQ09UdWp1UXNGVmFmMHNlZ3Y5?=
 =?utf-8?B?Y1hkN1ZHR3pxRnNUS0phT244b3VCUkFCUTR2eitNaEZ0UlUzSnpsZ3VmK01K?=
 =?utf-8?Q?XPUrKjaOIC4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REp1elRCbnBWTmFzVnppRVJCUTE1Sm4rUkIvRGZ2eTJkMFl1clRPVXR4U0g1?=
 =?utf-8?B?dkhkRWtxdEpVTmRWODJ1UndGdk9xN2l5Lys4T3ZmbVVBb28xUURBRDlhSTBn?=
 =?utf-8?B?WFFGZDEzaWs2bFM5d05LUmc0bGpHTGV1bmxFNVZ1ZE1jdlNBbFRYWnR3TCt2?=
 =?utf-8?B?TWtMd01takV3WVMxQ2RBMFlOUC8vOE5yQmlGTitwclhUcWlTNFJUS3hncU1K?=
 =?utf-8?B?eTdpaWlVQnZvZ1dpZStsR1orU2hoMWhnT2ZranQyTVVJQVdUZTdjdnRJZFZu?=
 =?utf-8?B?eEQ4NGhNbjRHa3dlMWdQZjl4cWtZZWtZcFVLUDRPOWthV3VwYTIvYXN6TWxk?=
 =?utf-8?B?TDZVbU1ZRCtSVUpDTk1ScHcydWVzWHo4VlhwSG51Rzl0Z0RyYmx1dVJINTVw?=
 =?utf-8?B?MHRGOTBGR082SFBKWXp1YUFIR3B2cW05dmR3UkRId09zTEdjZ3lkUlJ5T0VP?=
 =?utf-8?B?bVZLVWR6R2V0T01WS2JFUXh5ZnhQZ0hFUVVlZmU3MkhqNEI1bzRoRm9mRHpz?=
 =?utf-8?B?S1MvZ2c3MDFXdjh6SnpuM2Y3ckY1VjVSU1BPelFaK29FekRzNzFHWHFsZlN3?=
 =?utf-8?B?TVZEb2hlZUROQUZUMmR0NnBDalA1bVV1MUZaYmNVc3RoWnBxUW0vNWsyYnd4?=
 =?utf-8?B?MkFacWFweDZicXpOUTUzUXp5eHFhYXQvZC9QV1RNK2p2TUJCWURRV1BldVcy?=
 =?utf-8?B?VGhvb0xZZTRnMEZnVzZyYWtPTGVjdnEzOWFPR2s2S2R3clJqdHRvQXJFdnhw?=
 =?utf-8?B?S0wrZjlHMXU1a0cycHRxd2tjd3JuM25RTW9FQkZRSEgwRXBWQkhmeHZ0dCtS?=
 =?utf-8?B?cnMvUnFwTk1CZjNDY1p6WTNOOFExaEhsNXZyakRWdFlDU2RFbURJbmJJTUZy?=
 =?utf-8?B?OW54dEs5SFFGOUVXSXlDejdGTmdzNFRUWi9LaFBHSXIvUDh0RkZaT2FJUVd5?=
 =?utf-8?B?a0VYdVZ1N3FpcHJMRmlUdjFobms3WDZIOVZHM1k2UmFEdy9yZlZweDZBZTJu?=
 =?utf-8?B?UkNpTTZ2c2F1SUNDMzFOWlFZRDhVN0lkbGdPaGVYcS9rK1dzQjVWdzZGMUNN?=
 =?utf-8?B?dFVFcEZGaG8raUhCYitOc0w1VDZWU3lPb2pMMDZ4aVZCVS9vQ3pqeXZscVFO?=
 =?utf-8?B?a0Q0azBGWE9WT1JORFdjRFcyaWgwSnVTSy9KRmxaVWtic1VhdTN4d3c0QjA0?=
 =?utf-8?B?Nzltd0dIa09mQWVqYkRoeFFIc0RLUmdTeG5PUzJjMUcxazNMOEFQWklrZUYw?=
 =?utf-8?B?RmZoa0ZQTjdBV2tzS2t0MUZ3dkN4N3Y0ZEhqWjVoMmlxUEU2b0tvUUtTeUFa?=
 =?utf-8?B?dHB2Mkw0dnZXTFk4TVgrUFp6bWJOR2VzaWlKVFN4bTl0VnNOY1Z4djhSSkpD?=
 =?utf-8?B?SncxZVJTREhaNk9lV1BTMXNCczFtOFlLWGJRT25Fak5JVTF1bGl3ZUkxU3BE?=
 =?utf-8?B?Ukk3d3REQmVUTTNVMmJDS3Y2WTdZQXc2aHgxMHRGaGQ0dVUva3lNcC9YVTJZ?=
 =?utf-8?B?Szl0UVU0cGo4U2ozS25CWXhmK0RycWRwNWtDVmtTOGZjWWdyNUJtS2JpaXZK?=
 =?utf-8?B?TkRaYUl5ZWxPUDVoNExmQm9FbEVwU0IxbDVFRm8wb3VDZ0phcVpTUDBZL21Z?=
 =?utf-8?B?TVR0czZHSk02WFRBTEhHRm83Y214SkVsbDRyVUxjRnZlOXFOS0xoQ05YdUZH?=
 =?utf-8?B?SjkyYjdKWlk4eDluUG1aM1VNa2lsdTloUzRUaHpRdXRIUitNbEQzeUxSa0Zi?=
 =?utf-8?B?dWxjV3RBTGFPYjhHSWR1cVlxWVdYR1QzT3RMWlVDN0trczVwWTRBL2lLL2cv?=
 =?utf-8?B?d29OOGZSRGtnOTBicnAxUGU0U1FmbEc1S1pIYUxFMlV6VkZBYkYxZG5DdmxV?=
 =?utf-8?B?dC9PTXd0MkhvbEJaVHU2V0U5SXN3WU95ZUg5Q0NhNE5PUmlxSkhkTEplMEEz?=
 =?utf-8?B?dGViNlBvVUdmY0pIMERYL1cyTWxpUWh3YmttRmpvRnBTd3ltQkYyTVNjNlNS?=
 =?utf-8?B?ZzVOZ3E5MTZPUThhZFNOdGVWUjJRMllxYXNaNDNWajUxY1kyMndCa2dmT2Vp?=
 =?utf-8?B?MkszSU5TRVg4WXZKUnI0R3NQWjFEbUlWM0M0Q3daT1NMQkRWKzl5Z09tRVF1?=
 =?utf-8?Q?34WLpRLeuDLTr5KNBJCwJeaO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a7b93b-60ad-4923-a062-08ddde2cffc4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:58:20.8170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRlCuUrU0BMCOnAjPD+UxvD7hOx+vwcVcvdMAoBV0RDmgpjHPZFgewafafvcx0uM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725
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



On 8/8/25 14:31, boewingloh.linux@gmail.com wrote:
> From: Frank Böwingloh <f.boewingloh@beckhoff.com>
> 
> Currently u-boot displayed a zu1cg soc as "Chip:  zu1eg".
> A value of 0468_8093h in the IDCODE (CSU) Register defines a ZU1 soc
> not only for the EG family but also for the CG family as described
> in the Xilinx Zynq UltraScale+ UG1085 documentation in Table 1-2.
> 
> Signed-off-by: Frank Böwingloh <f.boewingloh@beckhoff.com>
> Cc:  Michal Simek <michal.simek@amd.com>
> ---
>   drivers/soc/soc_xilinx_zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
> index 0c45c781fef..4b69ff3de13 100644
> --- a/drivers/soc/soc_xilinx_zynqmp.c
> +++ b/drivers/soc/soc_xilinx_zynqmp.c
> @@ -63,7 +63,7 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   	{
>   		.id = 0x04688093,
>   		.device = 1,
> -		.variants = ZYNQMP_VARIANT_EG,
> +		.variants = ZYNQMP_VARIANT_EG | ZYNQMP_VARIANT_CG,
>   	},
>   	{
>   		.id = 0x04689093,

Applied.
M
