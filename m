Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B1EE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6DA80619;
	Tue, 14 Jan 2025 08:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xYGdLzbz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB90680691; Tue, 14 Jan 2025 08:32:55 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897AF80285
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNNW2Swl4aVhwWqhHii4opogxPB41RO5+aSN3td4Ms1+PWgpZXtzEtzbxgMJJNGFNEdlHDTaw0gOZenEiV9kZEG4G1i+lJNab8YrBIXVSbEMMqAfyQD+khSCRvlqZwD1camSbztn0nznOJzQRrXA/NRs6eRAHKRTxL2cMRadyIvWCvlLcTLMMK8AN1mawuTU5IMvwpYCx0Ptjj0kfwAAIEkFt8X36ZYF+iMBOObhK+o2VjHyHOcZqTcuzOygpZsH2YRBpQU/7KkBI5/65RvkZfigYwEfvEMYpqH6Z9NBuR/ehxeFMcnEsgLMk8Y5rqkD4zCpFcatk+u42rQsHm2uLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rWV6BMEoGTLS0V9j6pMl4pLNIBT+HPOnsXfGd/CEtM=;
 b=bSqYEldabZa5Lc3XEi+4nOvkUg5O7FA2oLE6e3ikxr8WEicnqSPSuiZlJ7sx7GRmlnzejyV9MELzYKrLXy5jCaxWf6VwEdkPKlIKy7Gs2pJ3FVMwHpuHcMf2OrUPojphwXAfBRRnC8odb1bjNZyeelGshTWBKffu5yp1S3lgzAzim3h8O6LJ082iejP2bV3wAzw2ETDpADN/LOP2Sgpc/MibKKUNxBlmEca/I6yHiPPcS2n7XSfxJNP/6TvAhhZcwuG+kOSvG3G0LoHtLBoJq7KEssH95vjmAujHfOyuNuFop8TdeeSUN1VSI/ya0Stc6eLJyjbARB2Z3pgDZnJz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rWV6BMEoGTLS0V9j6pMl4pLNIBT+HPOnsXfGd/CEtM=;
 b=xYGdLzbz2O9XFmwU4aa/wE/phFERWZqvDKnKbrJcTEUaRls+tN6paxjAJey7aiP2lbPkpUCvkopQ+2Bx/ZOMg5IQli4urqt0mXFryJ4tir1tnl8n1Oh0AtG3LjIhIT+Q7U5sAMqFWG7qhtQp/CkDGc6p2qrGthsE0n5my0sXAn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 07:32:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:32:49 +0000
Message-ID: <addefbd6-3ae2-4a7b-a103-55d241a36ca7@amd.com>
Date: Tue, 14 Jan 2025 08:32:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: zynqmp: Add usb_pgood_delay for SOM boards
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
References: <20250107122915.1378284-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250107122915.1378284-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0150.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: d86fcc89-a590-45a6-9681-08dd346da5aa
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWJNZmNYS3FaUlVJMGlYR2lYelc5NlQ3N1dLc00ySG00U3ptY2tTd2dSSkJo?=
 =?utf-8?B?TTV1dzVaTTdEZHlPNmJWRFVDZDhrT3BGNG1jWXVqZ2VPWCtDdzExZUFSS3hD?=
 =?utf-8?B?bTh3Rlp3QUxuK0htR0xNc0s5blVJbkp3aEo5aHh2VVF3Y21oRDliQVcrN0dI?=
 =?utf-8?B?U3YxWDJQbWlSYWZockRIbHhZeHNpdjJ3NUI5eWtQMzFwd2c4alpjWjRSQkpH?=
 =?utf-8?B?T04ydFk4eE5MVFJITERQNEpURk9rNnQzaU5VTExkNW1CWXVkY3pQYmV4QmVX?=
 =?utf-8?B?OXU1S2F6N3ZFQzBTcDM2WkRrcVpBMXVsRG43aEtLSDlnTHUrcU9reHF1Q29O?=
 =?utf-8?B?SUFvdmdHMlk1b2xBcThQNzZON3BwV2tPeENzTSt5TC9aNS9CZkNLbzBSdmhi?=
 =?utf-8?B?Q200RUlXVkZmZ1lnbzg1RWRINDd4bTZjYit3dDZKTHlybjMvQjFVSXFmSmo4?=
 =?utf-8?B?V2g0VzU5Rlkyb2I0aE9DU2x5cjBFQ21pUEJtRFZkeDdZZjZzc3hyTTIvNFZx?=
 =?utf-8?B?UkFrN2s2eTUyNjgvL2daUGQwVzJweFJOVHlhRm1YZHdOeCtGSEc1dDhnREJ5?=
 =?utf-8?B?VHN1SXptWGVjaFg1VmtqN2JWTW53K3ZadnhqemhiRFJmaUFmQ29XYTczT2Nr?=
 =?utf-8?B?VjVjRmlXNG5yenhXRzJ1QmxkVFcwQXlhclBZRHZGVnpVUCt1N2hhUEVLRjdt?=
 =?utf-8?B?VnI2Nlh3YXh6RXpKdWowVW5qRFJvcGtnNlU0SERLTDJOc3JJa1dGaGRyRzcw?=
 =?utf-8?B?U1FuOE5qSlNsb0VvNWkxcUZkdGl3WnFQQ1JOMVhpQnI1QjAxd09aTmR2Z1Zt?=
 =?utf-8?B?bGFlanRmRlVJdkpxbkFwTE9vZy9JUnZaSXl6NTZqQ3BMc044cXE2b1R5MjhT?=
 =?utf-8?B?cXdBZU5ucHA0dTlnWUIrSGJWSHNzVWFJSWVBZnVHTHN3MkFqQWlGVldwcmE0?=
 =?utf-8?B?N2pXb0F1b21jVFQwb1VsWFNvNy8wL1BUTmI2dGxEb1J2cEl1Yk1qRlNhT2dt?=
 =?utf-8?B?aEVlRmFNNUZJVnh6akdpdlNBVHRheWpyUVFqTzhQc2tFNC8vNlBsNnJXYkpo?=
 =?utf-8?B?UU9qQ0pYVStkcTNHRy9LaUVwcUEyWG1LSktWVE15eXRFcXNzeDlkMUhHRExk?=
 =?utf-8?B?TmpmSHR3bEM3blJ0ejN4UU5xZWZ2SXJrMjdmTG9RcFVSQ2ErcitGM0hQZDQ5?=
 =?utf-8?B?TFcyRnlDNW5GTy9UYWV4U2hTQ3VEcEdPUEpsNEg4WXo3QXM1VnQycnRFSE5C?=
 =?utf-8?B?eHcwWHBFQUdZNUo1N2MvNGk0V1lVVTExT1E3ZUR3eHIvbmh5V1JIQ1I1eFpO?=
 =?utf-8?B?UWM3ZnlxSzNIN0N5QjlOU2hEaWp2SUdTOE9xT1VqbVMrQVBwbzQ3Z2ltWXFU?=
 =?utf-8?B?eXVBY09PTXY3Y3dOYXdsMkFTN2dQajhmeWc2QzlmNXFwME1jSERETytMZzF1?=
 =?utf-8?B?VlVIbW92cjUvZlZKWDVvVmUveE5VSlF2S04yeDZHRkpUdlNCQkJrNlZZNHdk?=
 =?utf-8?B?a0Y5dHhWbUVBNEhkYnl0QjE4WS9TSzlLMXNPeVZGdUhzOERQWmVCWmROOExH?=
 =?utf-8?B?SFZ3bFVJTHZTMHdMYm5LcVc5WHdNYm1OY0NYSVNpdnpveUxQRkN5bkhYbHV4?=
 =?utf-8?B?RzJmTEd3bEFpSVVoTU5wd3V1aHlTK0szbnBmYTh1SWlSWVo5djVDZXp4NVpP?=
 =?utf-8?B?MkVrRHAwYk1JSExwbmV4RitydXIxbko3bUFJejJzeHQva1BIYlJYeVFWNzIx?=
 =?utf-8?B?MVJ3ZEh3OTdDaWw4UlZlVDMyN1BmNWl5QytwUk9xZFM0Q2NLUEJQV3pwM3ZE?=
 =?utf-8?B?TmZXKzVrUWI3SUV0Tm0xaXJTNHhCTCtvLzcyRytWNzJ6bzZnSWFsMUg3QzlK?=
 =?utf-8?Q?SxxUP7bO8HnaN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZNdXZ4azdSNGk2N1lST1JLWHFJRWNlSHczYlFFOTVQZ1JjS2dWM0NkbFpS?=
 =?utf-8?B?QVI2OTNVSitiUFY4MVdNc05jcGN3dVVTYVdMbkRCYTdHOGVrNG5za2VZN0Fx?=
 =?utf-8?B?cllaSHc1K0IzUUlJL0pId1grV0Z5ZFlJV2JVR0RrUk9vRmtzMDYzd21mOVJw?=
 =?utf-8?B?Ym03ZXJ3M3RYTHJGYk56N0cyY3lldlNESkZyeG0yYmVYM3RzdGVWajl0Y29K?=
 =?utf-8?B?UkxXNWsyM3U0TnpYcmVZc1M2cFRuZnJDRUdpL3VDdU1PZmVtQ0Q4TFZuRGlz?=
 =?utf-8?B?aWc1UVRJdnJFWjVtekhVN0x0alYvM1pNTnBvdTZDNGVZbXRtSXZxU3hnODhR?=
 =?utf-8?B?SzgxaXdQcm5BM0xnQXZoK3dMbjR0amoxUzg1VUJ0RlZQU21MandUL2ozRUEz?=
 =?utf-8?B?ZkdsZVBENEp6VEVzUC9EZFJEeE1neDI3d2RzNWFmbERZbzhtQytlbEszTnpG?=
 =?utf-8?B?WVhzUHVVYW9CcVMxTG1SWkRHLzF3bkxiYW1uajZ1VjlERjVXcGtlUnlQVytr?=
 =?utf-8?B?d3J3UHVaaEs5Z3FqNUJ4QnA2b051ZzdsU2Fva2t4L29kdU1rdUNEK2dORldq?=
 =?utf-8?B?R1JRR1FwYkt1dUszckppZWFxd2VWT3hhM1dHSVpNZXo2MldDUGcvOVdHa3Js?=
 =?utf-8?B?VStiOU56OWx6WENPc1U2MHk2REJienA0RWFjVm9vcEszS05Xc1BXeitRTmdV?=
 =?utf-8?B?dzZMT2dnVjAvMFBTeHdjVkRvZHA1TGExRThQWmFyTGZvQUtDWGh4QU9GQVhJ?=
 =?utf-8?B?V1VCZ2FTV3JGSExLM1ZEU3BDNkNvNXJ0QjU0UXRzT1JNMXJ6aUw1T2lIcXBY?=
 =?utf-8?B?Z01wYVJDdzlabzZuZU1sTW9EMk0yaXBZTVZGSmgzbXZnSERTYkt5QVJvWFNo?=
 =?utf-8?B?T3N2Y2pxS2U5UHFkV2JpOGpZWHFiN2hjYVFQM2xjZ3BZNFFZU0srb2VHb1pa?=
 =?utf-8?B?RUFGQ0lMeHNURzU1TFU0ZjIvT1pHS2ZFSm1GWjVnNmhvZFVMazhaMXhvcXM5?=
 =?utf-8?B?cHppeVArdzRDb1RCN1Y4dlM4SXo0N2JBSHp1THVIUWlSeGFOaWJRNnd0LzNm?=
 =?utf-8?B?WUkweUpYV2tGeElxdkpjNG10NGZVYk51ZS9jT1ZtZ0doMlgzWXkyTHNEWHNL?=
 =?utf-8?B?TmJBOFlKWTU3NEpPVUhORkk3ZTFtVTRoRmhtSnZNSGtCNFJ6aCtBMnl6ZW5v?=
 =?utf-8?B?K3kvczhNUzcrKzVla0hiSi94aHlTbXVKSDFTM0o0QXhsanN2TGNrRGRqa3Fk?=
 =?utf-8?B?cWtYRGJIT1B4bDRwd0lIQWpPMW5rMGFOSjFOL2FyU1pIM2lhQjJNWmk5QlBH?=
 =?utf-8?B?VVcxRGJzeC8vZTBqOEdIRXRad21oTVBvUW43akdEa3BXZUMyWWM1clBQVmdH?=
 =?utf-8?B?SDAvTEw3OFA1SHlETGllUzVlWEVGcWRqZzAxckNJdXlTckxWbnJvU3I4UlZa?=
 =?utf-8?B?YkErOVk0cS9DMW9TcmZxYXRMZUw3YkdoS01VVzlERTBMNm1Hckt1cXBvREpC?=
 =?utf-8?B?Z0I3eFNZS3VveFVYSENkT3VhMDlac29JZXJZdjJmVTVzQ2U4MW1EcTI5OVFE?=
 =?utf-8?B?RUpOYWQrLzRlZ1hIL2JnTXpuem5aOUcxMEZBSWVtcGRvam5zdDJodnc4VmZC?=
 =?utf-8?B?U0RHTG5aZ3RwbjBMcHd4eFJWRjIrZm5sNk11N3F6cE1CaTdwZzlTUFF0V0cy?=
 =?utf-8?B?OFZqWlJ1K2QvNFpEc1FnVjVnZi9mbzhVOVBETW1USDBHaEo2NWpGZlRzWGoz?=
 =?utf-8?B?Qjl5RzdWQlNLMGdBSlRQaWFLZGh0TmxMV1JiUkQ1V3ZKdFNleTdUSEZsTXdy?=
 =?utf-8?B?RjFmZ2tZUUR2OHgycmlISjU4a2twRys0d0RvZURGS01FY1gxRitRcXhQOTlS?=
 =?utf-8?B?VlNtTm1SbzZtajNrNmp6aHlnVTJiMXJycEc1dFlhM0tUc1Q2OVpYSVhGM1ly?=
 =?utf-8?B?WXJiTWlabjl2eDJNcUhXZ08wbEZHNzI3cTIzd1gyc3Z3anN2N3FQU21nV2lE?=
 =?utf-8?B?QnRpMUUxSVg4VTFENHgzYUpKbnZOOVFDUXVMSDByUFJ6UmdlTHZMR0xSbFFi?=
 =?utf-8?B?c0d2MzlpbDR2YitBbmowcGV3OTh3V1hOZlpmdjdIYnAySjYzc29VQjNEVXlX?=
 =?utf-8?Q?1o8ZScS15l0JszWLDDHBIfxH2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86fcc89-a590-45a6-9681-08dd346da5aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:32:49.4342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ks82yUIqYZEVmdKoH5uMsyLBv7IskvwUbLiRMKuL4lDwAaVFFMB3xRqe9MqkLQ6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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



On 1/7/25 13:29, Prasad Kummari wrote:
> Add usb_pgood_delay to ensure proper detection of USB devices.
> Increase the USB power good delay on the SOM boards, as this
> is required for certain USB sticks otherwise, they may not
> be detected.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>   board/xilinx/zynqmp/zynqmp_kria.env | 1 +
>   include/configs/xilinx_zynqmp.h     | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index ff3a0924de..c0a22fbf67 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -43,6 +43,7 @@ script_size_f=0x80000
>   scriptaddr=0x20000000
>   usb_boot=usb start; if usb dev ${devnum}; then devtype=usb; run scan_dev_for_boot_part; fi
>   preboot=setenv boot_targets; setenv modeboot; run board_setup
> +usb_pgood_delay=1000
>   
>   # SOM specific boot methods
>   usb_boot_devices='usb0 usb1 usb2 usb3 usb4'
> diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
> index bb0db7c5ca..13941ba358 100644
> --- a/include/configs/xilinx_zynqmp.h
> +++ b/include/configs/xilinx_zynqmp.h
> @@ -179,6 +179,7 @@
>   #ifndef CFG_EXTRA_ENV_SETTINGS
>   #define CFG_EXTRA_ENV_SETTINGS \
>   	ENV_MEM_LAYOUT_SETTINGS \
> +	"usb_pgood_delay=1000\0" \
>   	BOOTENV
>   #endif
>   

The patch looks good but it didn't land in u-boot mailing list and lore.
Can you please send it again?

Thanks,
Michal
